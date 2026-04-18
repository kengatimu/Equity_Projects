import ExcelJS from 'exceljs'

// ── Column definitions ────────────────────────────────────────────────────────

const COLUMNS: {
  header: string
  key: string
  width: number
  required: boolean
  validation?: ExcelJS.DataValidation
  note?: string
}[] = [
  { header: 'Code',                key: 'code',               width: 22, required: true,
    validation: undefined,
    note: 'UPPERCASE_SNAKE — unique across the platform. e.g. FINACLE_CORE_KE' },
  { header: 'Name',                key: 'name',               width: 28, required: true,
    note: 'Full display name. e.g. Finacle Core Kenya' },
  { header: 'Tier',                key: 'tier',               width: 10, required: true,
    validation: { type: 'list', allowBlank: false, formulae: ['"T1,T2,T3"'],
      showErrorMessage: true, errorStyle: 'stop', errorTitle: 'Invalid Tier', error: 'Must be T1, T2, or T3.',
      showInputMessage: true, promptTitle: 'Tier', prompt: 'T1=Critical · T2=Important · T3=Standard' },
    note: 'T1=Critical · T2=Important · T3=Standard' },
  { header: 'Subsidiary',          key: 'subsidiary',         width: 13, required: true,
    validation: { type: 'list', allowBlank: false, formulae: ['"KE,UG,TZ,RW,DRC,SS,GROUP"'],
      showErrorMessage: true, errorStyle: 'stop', errorTitle: 'Invalid Subsidiary', error: 'Choose: KE, UG, TZ, RW, DRC, SS, GROUP',
      showInputMessage: true, promptTitle: 'Subsidiary', prompt: 'KE · UG · TZ · RW · DRC · SS · GROUP' },
    note: 'KE=Kenya · UG=Uganda · TZ=Tanzania · RW=Rwanda · DRC=Congo · SS=South Sudan · GROUP=Shared' },
  { header: 'Vendor',              key: 'vendor',             width: 18, required: false,
    note: 'Software vendor. Use "In-house" for internally built systems.' },
  { header: 'Description',         key: 'description',        width: 38, required: false,
    note: 'Brief description of what this application does.' },
  { header: 'Has DR',              key: 'hasDr',              width: 10, required: false,
    validation: { type: 'list', allowBlank: true, formulae: ['"Y,N"'],
      showErrorMessage: true, errorStyle: 'stop', errorTitle: 'Invalid', error: 'Enter Y or N.',
      showInputMessage: true, promptTitle: 'Has DR', prompt: 'Y = has DR procedure · N = none' },
    note: 'Y if documented DR failover procedure exists, N otherwise.' },
  { header: 'DR Capability',       key: 'drCapability',       width: 18, required: false,
    validation: { type: 'list', allowBlank: true,
      formulae: ['"FULL_FAILOVER,APP_ONLY,DB_ONLY,APP_REPOINT,PARTIAL,ACTIVE_ACTIVE,ROLLBACK_DRILL,COLD_STANDBY,TABLETOP,EXTENDED_OPS"'],
      showErrorMessage: true, errorStyle: 'stop', errorTitle: 'Invalid DR Capability', error: 'Must be one of the listed values.',
      showInputMessage: true, promptTitle: 'DR Capability', prompt: 'Select the DR failover type.' },
    note: 'FULL_FAILOVER · APP_ONLY · DB_ONLY · APP_REPOINT · PARTIAL · ACTIVE_ACTIVE · ROLLBACK_DRILL · COLD_STANDBY · TABLETOP · EXTENDED_OPS' },
  { header: 'DC Endpoint',         key: 'dcEndpoint',         width: 36, required: false,
    note: 'Primary DC-side URL. e.g. https://app.dc.equitybank.co.ke — For multiple URLs separate with a semicolon (;). Additional endpoints can be added from the application detail page after import.' },
  { header: 'DR Endpoint',         key: 'drEndpoint',         width: 36, required: false,
    note: 'Primary DR-site URL. Required when Has DR = Y. For multiple URLs separate with a semicolon (;). Additional endpoints can be added from the application detail page after import.' },
  { header: 'Business Owner Name', key: 'businessOwner',      width: 24, required: false,
    note: 'Full name of business owner accountable for DR sign-off.' },
  { header: 'Business Owner Email',key: 'businessOwnerEmail', width: 30, required: false,
    note: 'Work email of business owner. e.g. jane.doe@equitybank.co.ke' },
  { header: 'Tech Owner Name',     key: 'techOwnerName',      width: 24, required: false,
    note: 'Full name of technical owner responsible for the runbook.' },
  { header: 'Tech Owner Email',    key: 'techOwnerEmail',     width: 30, required: false,
    note: 'Work email of tech owner. Must match a registered platform user.' },
  { header: 'Customer Facing',     key: 'customerFacing',     width: 16, required: false,
    validation: { type: 'list', allowBlank: true, formulae: ['"Y,N"'],
      showErrorMessage: true, errorStyle: 'stop', errorTitle: 'Invalid', error: 'Enter Y or N.',
      showInputMessage: true, promptTitle: 'Customer Facing', prompt: 'Y = failure visible to Equity customers.' },
    note: 'Y if failure is directly visible to Equity Bank customers.' },
  { header: 'Notes',               key: 'notes',              width: 40, required: false,
    note: "Any additional context about this application's DR setup or constraints." },
]

// ── Palette ───────────────────────────────────────────────────────────────────

const C = {
  RED_DARK:   'FF7A1A1A',  // title bar
  RED_MID:    'FFC0392B',  // required section label + header
  GRAY_DARK:  'FF374151',  // optional section label
  GRAY_MID:   'FF6B7280',  // optional header cell
  HINT_BG:    'FF1F618D',  // hint row (medium navy)
  HINT_TEXT:  'FFFFFFFF',  // hint row text
  HINT_BDR:   'FF2E86C1',  // hint row border
  WHITE:      'FFFFFFFF',
  ROW_ALT:    'FFF8F9FA',  // subtle alternating row (all columns)
  BORDER:     'FFE5E7EB',  // data cell border (light)
  BORDER_MID: 'FFD1D5DB',  // divider
  DIVIDER:    'FFC0392B',  // required/optional column divider
}

const REQ_COUNT = COLUMNS.filter(c => c.required).length  // 4
const TOTAL     = COLUMNS.length                           // 16

// ─────────────────────────────────────────────────────────────────────────────

export async function generateApplicationTemplate(): Promise<void> {
  const wb = new ExcelJS.Workbook()
  wb.creator  = 'Equity Bank DR Platform'
  wb.created  = new Date()
  wb.modified = new Date()

  // ── Sheet 1: Applications ─────────────────────────────────────────────────

  const ws = wb.addWorksheet('Applications', {
    views: [{ state: 'frozen', ySplit: 4, xSplit: 0 }],  // freeze first 4 rows
    pageSetup: { orientation: 'landscape', fitToPage: true, fitToWidth: 1 },
    properties: { tabColor: { argb: C.RED_DARK } },
  })

  // Set column widths
  ws.columns = COLUMNS.map(col => ({ key: col.key, width: col.width }))

  // ── ROW 1: Title banner ───────────────────────────────────────────────────
  const titleRow = ws.getRow(1)
  titleRow.height = 28
  titleRow.getCell(1).value = '  EQUITY BANK DR PLATFORM  |  Application Import Template'
  titleRow.getCell(1).font  = { bold: true, size: 13, name: 'Calibri', color: { argb: C.WHITE } }
  titleRow.getCell(1).fill  = { type: 'pattern', pattern: 'solid', fgColor: { argb: C.RED_DARK } }
  titleRow.getCell(1).alignment = { vertical: 'middle', horizontal: 'left' }
  ws.mergeCells(1, 1, 1, TOTAL)
  for (let c = 2; c <= TOTAL; c++) {
    titleRow.getCell(c).fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: C.RED_DARK } }
  }

  // ── ROW 2: Section labels (REQUIRED / OPTIONAL) ───────────────────────────
  const sectionRow = ws.getRow(2)
  sectionRow.height = 18

  // Required section label
  sectionRow.getCell(1).value = `  ★ REQUIRED  (Columns A – ${colLetter(REQ_COUNT)})  — Rows missing these fields will be skipped`
  sectionRow.getCell(1).font  = { bold: true, size: 9, name: 'Calibri', color: { argb: C.WHITE } }
  sectionRow.getCell(1).fill  = { type: 'pattern', pattern: 'solid', fgColor: { argb: C.RED_DARK } }
  sectionRow.getCell(1).alignment = { vertical: 'middle', horizontal: 'left' }
  ws.mergeCells(2, 1, 2, REQ_COUNT)

  // Optional section label
  sectionRow.getCell(REQ_COUNT + 1).value = `  OPTIONAL  (Columns ${colLetter(REQ_COUNT + 1)} – ${colLetter(TOTAL)})`
  sectionRow.getCell(REQ_COUNT + 1).font  = { bold: true, size: 9, name: 'Calibri', color: { argb: C.WHITE } }
  sectionRow.getCell(REQ_COUNT + 1).fill  = { type: 'pattern', pattern: 'solid', fgColor: { argb: C.GRAY_DARK } }
  sectionRow.getCell(REQ_COUNT + 1).alignment = { vertical: 'middle', horizontal: 'left' }
  ws.mergeCells(2, REQ_COUNT + 1, 2, TOTAL)

  // ── ROW 3: Column headers ─────────────────────────────────────────────────
  const headerRow = ws.getRow(3)
  headerRow.height = 24

  COLUMNS.forEach((col, i) => {
    const cell = headerRow.getCell(i + 1)
    cell.value     = col.required ? `${col.header}  ✱` : col.header
    cell.font      = { bold: true, size: 9, name: 'Calibri', color: { argb: C.WHITE } }
    cell.fill      = { type: 'pattern', pattern: 'solid', fgColor: { argb: col.required ? C.RED_MID : C.GRAY_MID } }
    cell.alignment = { vertical: 'middle', horizontal: 'center', wrapText: false }
    cell.border    = {
      top:    { style: 'thin',   color: { argb: col.required ? C.RED_MID : C.GRAY_DARK } },
      bottom: { style: 'medium', color: { argb: col.required ? C.RED_MID : C.GRAY_DARK } },
      left:   { style: 'thin',   color: { argb: C.BORDER_MID } },
      right:  { style: 'thin',   color: { argb: C.BORDER_MID } },
    }
  })

  // ── ROW 4: Hint row (locked, part of header) ─────────────────────────────
  const sampleRow = ws.getRow(4)
  sampleRow.height = 20

  const sampleData: Record<string, string> = {
    code: 'e.g. FINACLE_CORE_KE',
    name: 'Finacle Core Kenya', tier: 'T1', subsidiary: 'KE',
    vendor: 'Infosys', description: 'Core banking system for Kenya operations',
    hasDr: 'Y', drCapability: 'FULL_FAILOVER',
    dcEndpoint: 'https://finacle.dc.equitybank.co.ke',
    drEndpoint: 'https://finacle.dr.equitybank.co.ke',
    businessOwner: 'Jane Doe', businessOwnerEmail: 'jane.doe@equitybank.co.ke',
    techOwnerName: 'John Doe', techOwnerEmail: 'john.doe@equitybank.co.ke',
    customerFacing: 'Y', notes: '',
  }

  COLUMNS.forEach((col, i) => {
    const cell      = sampleRow.getCell(i + 1)
    cell.value      = sampleData[col.key] ?? ''
    cell.font       = { italic: true, size: 9, name: 'Calibri', color: { argb: C.HINT_TEXT } }
    cell.fill       = { type: 'pattern', pattern: 'solid', fgColor: { argb: C.HINT_BG } }
    cell.alignment  = { vertical: 'middle', wrapText: false }
    cell.border     = {
      top:    { style: 'thin',   color: { argb: C.HINT_BDR } },
      bottom: { style: 'medium', color: { argb: C.HINT_BDR } },
      left:   { style: 'thin',   color: { argb: C.HINT_BDR } },
      right:  { style: 'thin',   color: { argb: C.HINT_BDR } },
    }
    cell.protection = { locked: true }
    // Add tooltip note on first cell so users see the full hint on hover
    if (i === 0) {
      cell.note = { texts: [{ text: 'EXAMPLE ROW — This row will NOT be imported.\nIt is locked for reference only.\nStart entering your data from row 5 onwards.' }] }
    }
  })

  // ── ROWS 5+: Data area ────────────────────────────────────────────────────
  const DATA_START = 5
  const DATA_END   = 1004  // 1000 rows

  COLUMNS.forEach((col, colIdx) => {
    const excelCol = colIdx + 1

    for (let row = DATA_START; row <= DATA_END; row++) {
      const isAlt  = (row - DATA_START) % 2 === 1
      const cell   = ws.getCell(row, excelCol)

      cell.fill       = { type: 'pattern', pattern: 'solid',
                          fgColor: { argb: isAlt ? C.ROW_ALT : C.WHITE } }
      cell.font       = { size: 10, name: 'Calibri', color: { argb: 'FF111827' } }
      cell.alignment  = { vertical: 'middle', wrapText: false }
      cell.border     = {
        left:   { style: 'thin', color: { argb: C.BORDER } },
        right:  { style: 'thin', color: { argb: C.BORDER } },
        bottom: { style: 'thin', color: { argb: C.BORDER } },
      }
      cell.protection = { locked: false }
    }

    // Vertical divider between required and optional
    if (colIdx === REQ_COUNT - 1) {
      for (let row = DATA_START; row <= DATA_END; row++) {
        ws.getCell(row, excelCol).border = {
          ...ws.getCell(row, excelCol).border,
          right: { style: 'medium', color: { argb: C.DIVIDER } },
        }
      }
    }

    // Apply dropdown validation
    if (col.validation) {
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      ;(ws as any).dataValidations.add(
        `${colLetter(excelCol)}${DATA_START}:${colLetter(excelCol)}${DATA_END}`,
        col.validation,
      )
    }
  })

  // ── Sheet protection (header locked, data area open) ─────────────────────
  await ws.protect('', {
    selectLockedCells:   true,
    selectUnlockedCells: true,
    formatCells:         false,
    formatColumns:       false,
    formatRows:          false,
    insertRows:          false,
    deleteRows:          false,
    sort:                false,
    autoFilter:          false,
  })

  // ── Sheet 2: Guide ────────────────────────────────────────────────────────

  const guide = wb.addWorksheet('📖 Guide', {
    properties: { tabColor: { argb: C.GRAY_DARK } },
  })
  guide.columns = [{ key: 'a', width: 26 }, { key: 'b', width: 70 }]

  const gr = (a: string, b: string, style?: 'title' | 'section' | 'normal') => {
    const row = guide.addRow({ a, b })
    row.height = style === 'title' ? 26 : style === 'section' ? 20 : 17
    if (style === 'title') {
      row.eachCell(cell => {
        cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: C.RED_DARK } }
        cell.font = { bold: true, size: 12, name: 'Calibri', color: { argb: C.WHITE } }
        cell.alignment = { vertical: 'middle' }
      })
    } else if (style === 'section') {
      row.eachCell(cell => {
        cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: C.GRAY_DARK } }
        cell.font = { bold: true, size: 10, name: 'Calibri', color: { argb: C.WHITE } }
        cell.alignment = { vertical: 'middle' }
      })
    } else {
      row.getCell(1).font = { bold: !!b, size: 10, name: 'Calibri', color: { argb: C.GRAY_DARK } }
      row.getCell(2).font = { size: 10, name: 'Calibri' }
    }
  }

  gr('EQUITY BANK DR PLATFORM', '  Application Import Template — User Guide', 'title')
  gr('', '')
  gr('HOW TO USE', '', 'section')
  gr('Step 1', 'Download this template and open it in Excel.')
  gr('Step 2', 'Row 4 (blue hint row) is a locked example — it will NOT be imported. Start your data on row 5.')
  gr('Step 3', 'Enter one application per row starting at row 5.')
  gr('Step 4', 'Columns A–D are REQUIRED. Rows missing any of these are skipped with an error.')
  gr('Step 5', 'Use the dropdown menus — values must match exactly (case-sensitive).')
  gr('Step 6', 'Save as .xlsx and upload via the Import Applications page.')
  gr('', '')
  gr('COLOUR CODING', '', 'section')
  gr('Pink columns (A–D)',  'Required fields — must be filled for every row.')
  gr('Gray columns (E–P)',  'Optional fields — leave blank if not applicable.')
  gr('Blue hint row (row 4)', 'Locked example row — for reference only, cannot be edited.')
  gr('', '')
  gr('COLUMN REFERENCE', '', 'section')
  COLUMNS.forEach((col, i) => {
    const req = col.required ? '[Required]' : '[Optional]'
    gr(`${colLetter(i + 1)}  ${col.header}  ${req}`, col.note ?? '')
  })
  gr('', '')
  gr('IMPORT BEHAVIOUR', '', 'section')
  gr('New application',  'A row with a Code not in the system creates a new application.')
  gr('Update existing',  'A row whose Code already exists updates that application.')
  gr('Row errors',       'Rows with missing required fields or invalid values are skipped and reported.')
  gr('Dependencies',     'App-to-app dependencies cannot be imported — add them from the application detail page after import.')
  gr('Multiple endpoints', 'Only one DC Endpoint and one DR Endpoint can be imported per row. Separate multiple URLs with a semicolon (;) in the same cell. Additional endpoints can be managed from the application detail page.')

  // ── Write file ────────────────────────────────────────────────────────────

  return wb.xlsx.writeBuffer().then(buffer => {
    const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' })
    const url  = URL.createObjectURL(blob)
    const a    = document.createElement('a')
    a.href     = url
    a.download = 'DR_Platform_Applications_Import_Template.xlsx'
    a.click()
    URL.revokeObjectURL(url)
  })
}

// ── Helper ────────────────────────────────────────────────────────────────────

function colLetter(n: number): string {
  let s = ''
  while (n > 0) { n--; s = String.fromCharCode(65 + (n % 26)) + s; n = Math.floor(n / 26) }
  return s
}

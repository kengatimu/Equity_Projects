package com.equitybank.drplatform.service;

import com.equitybank.drplatform.entity.ApplicationEntity;
import com.equitybank.drplatform.repository.ApplicationRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

/**
 * Exports the full Application Registry to an Excel workbook.
 *
 * Column layout (A–I) intentionally mirrors ApplicationImportService so that
 * an exported file can be re-imported after editing — round-trip safe.
 *
 *   A  Code           (unique key — immutable)
 *   B  Name
 *   C  Tier           (T1 / T2 / T3)
 *   D  Subsidiary ID
 *   E  Tech Owner Email  (resolved via UserRepository if available; blank otherwise)
 *   F  Has DR         (Y / N)
 *   G  DR Capability
 *   H  Vendor
 *   I  Description
 *
 * Additional read-only columns (not imported, for reference only):
 *   J  DC Endpoint
 *   K  DR Endpoint
 *   L  Direct Customer Impact (Y / N)
 *   M  Active (Y / N)
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ApplicationExportService {

    private final ApplicationRepository applicationRepository;

    // ── Column indices ──────────────────────────────────────────────────────

    private static final String[] HEADERS = {
        "Code", "Name", "Tier", "Subsidiary ID",
        "Tech Owner Email", "Has DR (Y/N)", "DR Capability", "Vendor", "Description",
        // read-only reference columns
        "DC Endpoint", "DR Endpoint", "Direct Customer Impact (Y/N)", "Active (Y/N)"
    };

    /** Columns A–I are import-compatible; J onwards are read-only reference. */
    private static final int IMPORT_BOUNDARY = 9;

    // ── Public API ──────────────────────────────────────────────────────────

    @Transactional(readOnly = true)
    public byte[] exportAll() throws IOException {
        List<ApplicationEntity> apps = applicationRepository.findByIsActiveTrue();
        return buildWorkbook(apps);
    }

    // ── Workbook construction ───────────────────────────────────────────────

    private byte[] buildWorkbook(List<ApplicationEntity> apps) throws IOException {
        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Applications");

            // ── Styles ──
            CellStyle headerStyle = buildHeaderStyle(workbook);
            CellStyle refHeaderStyle = buildRefHeaderStyle(workbook);
            CellStyle yesStyle = buildYesStyle(workbook);
            CellStyle noStyle  = buildNoStyle(workbook);
            CellStyle monoStyle = buildMonoStyle(workbook);

            // ── Header row ──
            Row header = sheet.createRow(0);
            for (int i = 0; i < HEADERS.length; i++) {
                Cell cell = header.createCell(i);
                cell.setCellValue(HEADERS[i]);
                cell.setCellStyle(i < IMPORT_BOUNDARY ? headerStyle : refHeaderStyle);
            }
            header.setHeightInPoints(18);

            // ── Data rows ──
            int rowNum = 1;
            for (ApplicationEntity app : apps) {
                Row row = sheet.createRow(rowNum++);
                setCell(row, 0, app.getCode(),            monoStyle);
                setCell(row, 1, app.getName(),            null);
                setCell(row, 2, app.getTier(),            null);
                setCell(row, 3, app.getSubsidiaryId(),    null);
                setCell(row, 4, "",                       null);   // owner email — no join here; kept blank
                setBoolCell(row, 5, app.isHasDr(),        yesStyle, noStyle);
                setCell(row, 6, nullSafe(app.getDrCapability()),  null);
                setCell(row, 7, nullSafe(app.getVendor()),        null);
                setCell(row, 8, nullSafe(app.getDescription()),   null);
                // reference-only
                setCell(row, 9,  nullSafe(app.getDcEndpoint()),   monoStyle);
                setCell(row, 10, nullSafe(app.getDrEndpoint()),   monoStyle);
                setBoolCell(row, 11, app.isDirectCustomerImpact(), yesStyle, noStyle);
                setBoolCell(row, 12, app.isActive(),               yesStyle, noStyle);
            }

            // ── Column widths ──
            int[] widths = {18, 36, 8, 14, 30, 12, 20, 20, 40, 40, 40, 24, 10};
            for (int i = 0; i < widths.length; i++) {
                sheet.setColumnWidth(i, widths[i] * 256);
            }

            // ── Freeze header row ──
            sheet.createFreezePane(0, 1);

            // ── Auto-filter on header row ──
            sheet.setAutoFilter(new org.apache.poi.ss.util.CellRangeAddress(
                    0, rowNum - 1, 0, HEADERS.length - 1));

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            workbook.write(out);
            log.info("Export complete: {} applications written", apps.size());
            return out.toByteArray();
        }
    }

    // ── Cell helpers ────────────────────────────────────────────────────────

    private void setCell(Row row, int col, String value, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value != null ? value : "");
        if (style != null) cell.setCellStyle(style);
    }

    private void setBoolCell(Row row, int col, boolean value, CellStyle yesStyle, CellStyle noStyle) {
        Cell cell = row.createCell(col);
        cell.setCellValue(value ? "Y" : "N");
        cell.setCellStyle(value ? yesStyle : noStyle);
    }

    private String nullSafe(String s) { return s != null ? s : ""; }

    // ── Style builders ──────────────────────────────────────────────────────

    private CellStyle buildHeaderStyle(XSSFWorkbook wb) {
        CellStyle s = wb.createCellStyle();
        Font f = wb.createFont();
        f.setBold(true);
        f.setColor(IndexedColors.WHITE.getIndex());
        s.setFont(f);
        s.setFillForegroundColor(IndexedColors.DARK_RED.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        s.setAlignment(HorizontalAlignment.CENTER);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorder(s);
        return s;
    }

    private CellStyle buildRefHeaderStyle(XSSFWorkbook wb) {
        CellStyle s = wb.createCellStyle();
        Font f = wb.createFont();
        f.setBold(true);
        f.setColor(IndexedColors.WHITE.getIndex());
        s.setFont(f);
        s.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        s.setAlignment(HorizontalAlignment.CENTER);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        setBorder(s);
        return s;
    }

    private CellStyle buildYesStyle(XSSFWorkbook wb) {
        CellStyle s = wb.createCellStyle();
        Font f = wb.createFont();
        f.setColor(IndexedColors.DARK_GREEN.getIndex());
        f.setBold(true);
        s.setFont(f);
        s.setAlignment(HorizontalAlignment.CENTER);
        return s;
    }

    private CellStyle buildNoStyle(XSSFWorkbook wb) {
        CellStyle s = wb.createCellStyle();
        Font f = wb.createFont();
        f.setColor(IndexedColors.GREY_50_PERCENT.getIndex());
        s.setFont(f);
        s.setAlignment(HorizontalAlignment.CENTER);
        return s;
    }

    private CellStyle buildMonoStyle(XSSFWorkbook wb) {
        CellStyle s = wb.createCellStyle();
        Font f = wb.createFont();
        f.setFontName("Courier New");
        f.setFontHeightInPoints((short) 9);
        s.setFont(f);
        return s;
    }

    private void setBorder(CellStyle s) {
        s.setBorderBottom(BorderStyle.THIN);
        s.setBottomBorderColor(IndexedColors.WHITE.getIndex());
    }
}

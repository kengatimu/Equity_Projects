package com.equitybank.drplatform.service;

import com.equitybank.drplatform.entity.ApplicationEntity;
import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.repository.ApplicationRepository;
import com.equitybank.drplatform.repository.UserRepository;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class ApplicationImportService {

    private final ApplicationRepository applicationRepository;
    private final UserRepository userRepository;

    @Getter
    @AllArgsConstructor
    public static class ImportResult {
        private final int imported;
        private final int updated;
        private final int skipped;
        private final List<String> errors;
        private final List<String> warnings;
    }

    /**
     * Expected Excel columns (A–P):
     *
     *  Identity (required)
     *   A = Code             UPPERCASE_SNAKE unique identifier
     *   B = Name             Full display name
     *
     *  Classification (required)
     *   C = Tier             T1 | T2 | T3
     *   D = Subsidiary       KE | UG | TZ | RW | DRC | SS | GROUP
     *
     *  Basic Info (optional)
     *   E = Vendor
     *   F = Description
     *
     *  DR Configuration (optional)
     *   G = Has DR           Y | N
     *   H = DR Capability    FULL_FAILOVER | APP_ONLY | DB_ONLY | APP_REPOINT | PARTIAL |
     *                        ACTIVE_ACTIVE | ROLLBACK_DRILL | COLD_STANDBY | TABLETOP | EXTENDED_OPS
     *   I = DC Endpoint      Primary DC-side URL
     *   J = DR Endpoint      Primary DR-site URL (relevant when Has DR = Y)
     *
     *  Ownership (optional)
     *   K = Business Owner Name
     *   L = Business Owner Email
     *   M = Tech Owner Name
     *   N = Tech Owner Email  Resolved to platform user if found
     *
     *  Risk & Notes (optional)
     *   O = Customer Facing  Y | N
     *   P = Notes
     */
    public ImportResult parseAndImport(MultipartFile file) throws IOException {
        int imported = 0, updated = 0, skipped = 0;
        List<String> errors    = new ArrayList<>();
        List<String> warnings  = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0);
            int totalRows = sheet.getLastRowNum();

            // Rows 0–3 are the template header (title banner, section labels,
            // column headers, locked hint row) — data begins at row index 4 (Excel row 5).
            for (int rowNum = 4; rowNum <= totalRows; rowNum++) {
                Row row = sheet.getRow(rowNum);
                if (row == null) { skipped++; continue; }

                try {
                    // ── Required fields ──────────────────────────────────────
                    String code         = getCellValue(row, 0);  // A
                    String name         = getCellValue(row, 1);  // B
                    String tier         = getCellValue(row, 2);  // C
                    String subsidiaryId = getCellValue(row, 3);  // D

                    if (code.isBlank() || name.isBlank() || tier.isBlank() || subsidiaryId.isBlank()) {
                        errors.add("Row " + (rowNum + 1) + ": Missing required field (Code / Name / Tier / Subsidiary)");
                        skipped++;
                        continue;
                    }

                    if (!tier.matches("T1|T2|T3")) {
                        errors.add("Row " + (rowNum + 1) + ": Invalid tier '" + tier + "' — must be T1, T2, or T3");
                        skipped++;
                        continue;
                    }

                    // ── Optional fields ──────────────────────────────────────
                    String vendor          = getCellValue(row, 4);   // E
                    String description     = getCellValue(row, 5);   // F
                    String hasDrStr        = getCellValue(row, 6);   // G
                    String drCapability    = getCellValue(row, 7);   // H
                    String dcEndpoint      = getCellValue(row, 8);   // I
                    String drEndpoint      = getCellValue(row, 9);   // J
                    String businessOwner   = getCellValue(row, 10);  // K
                    String bizOwnerEmail   = getCellValue(row, 11);  // L
                    String techOwnerName   = getCellValue(row, 12);  // M
                    String techOwnerEmail  = getCellValue(row, 13);  // N
                    String custFacingStr   = getCellValue(row, 14);  // O
                    String notes           = getCellValue(row, 15);  // P

                    boolean hasDr              = "Y".equalsIgnoreCase(hasDrStr)  || "YES".equalsIgnoreCase(hasDrStr);
                    boolean directCustImpact   = "Y".equalsIgnoreCase(custFacingStr) || "YES".equalsIgnoreCase(custFacingStr);

                    Optional<ApplicationEntity> existing = applicationRepository.findByCode(code);

                    if (existing.isPresent()) {
                        // ── Update ────────────────────────────────────────────
                        ApplicationEntity app = existing.get();
                        app.setName(name);
                        app.setTier(tier);
                        app.setSubsidiaryId(subsidiaryId);
                        app.setVendor(blankToNull(vendor));
                        app.setDescription(blankToNull(description));
                        app.setHasDr(hasDr);
                        app.setDrCapability(blankToNull(drCapability));
                        app.setDcEndpoint(blankToNull(dcEndpoint));
                        if (hasDr) app.setDrEndpoint(blankToNull(drEndpoint));
                        app.setBusinessOwner(blankToNull(businessOwner));
                        app.setBusinessOwnerEmail(blankToNull(bizOwnerEmail));
                        app.setTechOwnerName(blankToNull(techOwnerName));
                        app.setTechOwnerEmail(blankToNull(techOwnerEmail));
                        app.setDirectCustomerImpact(directCustImpact);
                        app.setNotes(blankToNull(notes));
                        if (!techOwnerEmail.isBlank()) {
                            userRepository.findByEmail(techOwnerEmail)
                                          .ifPresent(u -> app.setTechOwnerId(u.getId()));
                        }
                        applicationRepository.save(app);
                        updated++;
                        // Warn on incomplete DR profile (imported but flagged)
                        if (hasDr && (drCapability == null || drCapability.isBlank()))
                            warnings.add("Row " + (rowNum + 1) + " [" + code + "]: Has DR = Y but DR Capability is missing — update via the application detail page.");
                        if (hasDr && (drEndpoint == null || drEndpoint.isBlank()))
                            warnings.add("Row " + (rowNum + 1) + " [" + code + "]: Has DR = Y but DR Endpoint is missing.");
                        if (techOwnerName == null || techOwnerName.isBlank())
                            warnings.add("Row " + (rowNum + 1) + " [" + code + "]: No Technical Owner — assign one to ensure runbook accountability.");

                    } else {
                        // ── Create ────────────────────────────────────────────
                        ApplicationEntity.ApplicationEntityBuilder builder = ApplicationEntity.builder()
                                .code(code)
                                .name(name)
                                .tier(tier)
                                .subsidiaryId(subsidiaryId)
                                .vendor(blankToNull(vendor))
                                .description(blankToNull(description))
                                .hasDr(hasDr)
                                .drCapability(blankToNull(drCapability))
                                .dcEndpoint(blankToNull(dcEndpoint))
                                .drEndpoint(hasDr ? blankToNull(drEndpoint) : null)
                                .businessOwner(blankToNull(businessOwner))
                                .businessOwnerEmail(blankToNull(bizOwnerEmail))
                                .techOwnerName(blankToNull(techOwnerName))
                                .techOwnerEmail(blankToNull(techOwnerEmail))
                                .directCustomerImpact(directCustImpact)
                                .notes(blankToNull(notes))
                                .isActive(true);

                        if (!techOwnerEmail.isBlank()) {
                            userRepository.findByEmail(techOwnerEmail)
                                          .ifPresent(u -> builder.techOwnerId(u.getId()));
                        }
                        applicationRepository.save(builder.build());
                        imported++;
                        // Warn on incomplete DR profile
                        if (hasDr && (blankToNull(drCapability) == null))
                            warnings.add("Row " + (rowNum + 1) + " [" + code + "]: Has DR = Y but DR Capability is missing — update via the application detail page.");
                        if (hasDr && (blankToNull(drEndpoint) == null))
                            warnings.add("Row " + (rowNum + 1) + " [" + code + "]: Has DR = Y but DR Endpoint is missing.");
                        if (blankToNull(techOwnerName) == null)
                            warnings.add("Row " + (rowNum + 1) + " [" + code + "]: No Technical Owner — assign one to ensure runbook accountability.");
                    }

                } catch (Exception e) {
                    errors.add("Row " + (rowNum + 1) + ": " + e.getMessage());
                    skipped++;
                }
            }
        }

        log.info("Import complete: imported={}, updated={}, skipped={}, errors={}, warnings={}",
                 imported, updated, skipped, errors.size(), warnings.size());
        return new ImportResult(imported, updated, skipped, errors, warnings);
    }

    private String getCellValue(Row row, int colIndex) {
        Cell cell = row.getCell(colIndex, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
        if (cell == null) return "";
        return switch (cell.getCellType()) {
            case STRING  -> cell.getStringCellValue().trim();
            case NUMERIC -> String.valueOf((long) cell.getNumericCellValue());
            case BOOLEAN -> cell.getBooleanCellValue() ? "Y" : "N";
            default      -> "";
        };
    }

    private String blankToNull(String s) {
        return (s == null || s.isBlank()) ? null : s;
    }
}

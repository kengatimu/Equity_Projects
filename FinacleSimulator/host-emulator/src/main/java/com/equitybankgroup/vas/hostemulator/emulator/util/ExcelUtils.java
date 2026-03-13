/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.vas.hostemulator.emulator.util;

import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.Expose;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.logging.Level;
import java.util.stream.Collector;
import java.util.stream.StreamSupport;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import lombok.Data;
import lombok.ToString;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;


/**
 *
 * @author ronaldcheruiyot
 */
public class ExcelUtils {
    
    private static final String FILE_NAME = "/Users/ronaldcheruiyot/Documents/java-projects/GAG/host-emulator/src/main/resources/files/31M4_Catalogue_VENS.xlsx";
    
    static Set<String> warehouseCodes = new HashSet<>();   
    static Set<String> producerCodes = new HashSet<>();   
    static Set<String> markCodes = new HashSet<>();   
    static Set<String> bagCodes = new HashSet<>();    
    static Set<String> gradeCodes = new HashSet<>();   
    
    public ExcelUtils()
    {
        Collections.addAll(warehouseCodes, "CTCW");
        Collections.addAll(producerCodes, "KTDA");
        Collections.addAll(markCodes, "MUDETE", "SIONGO", "GACHEGE", "GATUNGURU", "THUMAITA", "IKUMBI", "MUNGANIA", "RUKURIRI", "BOITO", "MUDETE");
        
    }
    
    private static final Collector<M4CatalogVO, LinkedHashSet<M4CatalogVO>, LinkedHashSet<M4CatalogVO>> LINKED_HASHSET_CATALOG_VO_COLLECTOR = Collector.of(
            LinkedHashSet<M4CatalogVO>::new,
            (acc, t) -> acc.add(t),
            (left, right) -> {
                left.addAll(right);
                return left;
            }
    );

    
    public enum Sheet {

        MAIN("Main_Catalogue"), SECONDARY("Secondary_Catalogue"), M4("Sheet1");

        private String value;

        Sheet(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }
    
    @Data
    @ToString
    public static class M4CatalogVO {

        public Sheet sheet;
        public Row row;
        @Expose
        public Map<String, Exception> exceptionMap;
        @Expose
        public String broker;
        @Expose
        public String category;
        @Expose
        public String factory;
        @Expose
        public String sellingMark;
        @Expose
        public String lotNo;
        @Expose
        public Integer reprint;
        @Expose
        public Integer bags;
        @Expose
        public Integer netWeight;
        @Expose
        public String grade;
        @Expose
        public String invoiceNo;
        @Expose
        public Double askingPrice;
        @Expose
        public String rainforest;
        @Expose
        public String certifications;
        @Expose
        public String saleDate;
        @Expose
        public Integer totalWeight;
        @Expose
        public Integer tareWeight;
        @Expose
        public Integer totalGrossWeight;
        @Expose
        public String warrantNumber;
        @Expose
        public Integer originalWeight;
        @Expose
        public String warehouse;
        @Expose
        public String warehouseLocation;
        @Expose
        public String producerName;
        @Expose
        public String producerCode;

        public M4CatalogVO(@NotNull Sheet sheet, @NotNull Row row, @org.hibernate.validator.constraints.NotEmpty Set<String> warehouseCodes, @NotEmpty Set<String> producerCodes, @org.hibernate.validator.constraints.NotEmpty Set<String> markCodes, @org.hibernate.validator.constraints.NotEmpty Set<String> bagCodes, @org.hibernate.validator.constraints.NotEmpty Set<String> gradeCodes, boolean hasReprint) {
            this.sheet = sheet;
            this.row = row;
            this.exceptionMap = Maps.newLinkedHashMap();
            broker = row.getCell(0).toString();
            category = row.getCell(1).toString();
            factory = row.getCell(2).toString();
            warehouse = row.getCell(19).toString();
            if (!warehouseCodes.contains(warehouse)) {
                exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(2).getColumnIndex()), new IllegalStateException("Warehouse " + warehouse + " invalid"));
            }
            try {
                askingPrice = Double.valueOf(row.getCell(10).toString());
            } catch (NumberFormatException e) {
                askingPrice = new Double(0.0);
            }
            try {
                lotNo = row.getCell(4).toString();
            } catch (NumberFormatException e) {
                exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(6).getColumnIndex()), e);
            }
            this.producerCode = row.getCell(22).toString();
            if (!producerCodes.contains(producerCode)) {
                exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(7).getColumnIndex()), new IllegalStateException("Producer " + producerCode + " invalid"));
            }
            String markValue = row.getCell(3).toString();
            String[] markEntries = markValue.trim().split("-");
            this.sellingMark = markEntries[0];
            if (!markCodes.contains(sellingMark)) {
                exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(8).getColumnIndex()), new IllegalStateException("Mark " + sellingMark + " invalid"));
            }
            this.grade = row.getCell(8).toString();
            if (!gradeCodes.contains(grade)) {
                //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(9).getColumnIndex()), new IllegalStateException("Grade " + grade + " invalid"));
            }

            this.saleDate = row.getCell(13).toString();

            /**
             * if reprint is present use default implementation else use custom
             *
             */
            if (hasReprint) {
                this.invoiceNo = row.getCell(9).toString();
                try {
                    this.bags = Double.valueOf(row.getCell(6).toString()).intValue();
                } catch (NumberFormatException e) {
                    exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(14).getColumnIndex()), e);
                }

//                this.bag = row.getCell(15).toString();
//                if (!bagCodes.contains(bag)) {
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(15).getColumnIndex()), new IllegalStateException("Bag " + bag + " invalid"));
//                }
                try {
                    Double dNet = Double.valueOf(row.getCell(7).toString());
                    this.netWeight = (int) (Math.round(dNet));

                } catch (NumberFormatException e) {
                    exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(16).getColumnIndex()), e);
                }

                try {

                    Double dGross = Double.valueOf(row.getCell(16).toString());
                    this.totalGrossWeight = (int) (Math.round(dGross));

                } catch (NumberFormatException e) {
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(17).getColumnIndex()), e);
                    this.totalGrossWeight = 0;
                }

                try {
                    Double dWeight = Double.valueOf(row.getCell(14).toString());
                    this.totalWeight = (int) (Math.round(dWeight));

                } catch (NumberFormatException e) {
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(18).getColumnIndex()), e);
                    this.totalWeight = 0;
                }

                try {
                    Double dTare = Double.valueOf(row.getCell(15).toString());
                    this.tareWeight = (int) (Math.round(dTare));
                } catch (NumberFormatException e) {
                    this.tareWeight = 0;
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(19).getColumnIndex()), e);

                }

                try {

                    Double dReprint = Double.valueOf(row.getCell(5).toString());
                    this.reprint = dReprint.intValue();

                } catch (NumberFormatException e) {

                    this.reprint = 0;
                }

            } else {
                this.invoiceNo = row.getCell(9).toString();
                try {
                    this.bags = Double.valueOf(row.getCell(6).toString()).intValue();
                } catch (NumberFormatException e) {
                    exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(14).getColumnIndex()), e);
                }

//                this.bag = row.getCell(15).toString();
//                if (!bagCodes.contains(bag)) {
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(15).getColumnIndex()), new IllegalStateException("Bag " + bag + " invalid"));
//                }
                try {
                    Double dNet = Double.valueOf(row.getCell(7).toString());
                    this.netWeight = (int) (Math.round(dNet));

                } catch (NumberFormatException e) {
                    exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(16).getColumnIndex()), e);
                }

                try {

                    Double dGross = Double.valueOf(row.getCell(16).toString());
                    this.totalGrossWeight = (int) (Math.round(dGross));

                } catch (NumberFormatException e) {
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(17).getColumnIndex()), e);
                    this.totalGrossWeight = 0;
                }

                try {
                    Double dWeight = Double.valueOf(row.getCell(14).toString());
                    this.totalWeight = (int) (Math.round(dWeight));

                } catch (NumberFormatException e) {
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(18).getColumnIndex()), e);
                    this.totalWeight = 0;
                }

                try {
                    Double dTare = Double.valueOf(row.getCell(15).toString());
                    this.tareWeight = (int) (Math.round(dTare));
                } catch (NumberFormatException e) {
                    this.tareWeight = 0;
                    //exceptionMap.put(row.getRowNum() + 1 + CellReference.convertNumToColString(row.getCell(19).getColumnIndex()), e);

                }

                try {

                    Double dReprint = Double.valueOf(row.getCell(5).toString());
                    this.reprint = dReprint.intValue();

                } catch (NumberFormatException e) {

                    this.reprint = 0;
                }
            }

            try {
                this.certifications = row.getCell(12).toString();
            } catch (Exception e) {
                this.certifications = "";
            }

//            this.entryNo = row.getCell(3).toString();
        }
    }
    public Set<M4CatalogVO> readModified(@NotEmpty byte[] catalogBytes, @NotNull Sheet sheet, boolean hasReprint) throws RollBackCheckedException {
        try (final ByteArrayInputStream inputStream = new ByteArrayInputStream(catalogBytes)) {
            Workbook wb = null;
            try {
                wb = WorkbookFactory.create(inputStream);
            } catch (InvalidFormatException ex) {
                java.util.logging.Logger.getLogger(ExcelUtils.class.getName()).log(Level.SEVERE, null, ex);
            } catch (EncryptedDocumentException ex) {
                java.util.logging.Logger.getLogger(ExcelUtils.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            
            if(wb == null) throw new RollBackCheckedException("Workbook is null");
                       
            final Optional<org.apache.poi.ss.usermodel.Sheet> sheetOptional = Optional.ofNullable(wb.getSheet(sheet.getValue()));
//            if (!sheetOptional.isPresent()) {
//                if (!(sheet == Sheet.M4)) {
//                    throw new RollBackCheckedException("Primary Sheet not found : " + sheet.getValue());
//                } else {
//                    HashSet<M4CatalogParser.M4CatalogVO> EmptySet = new HashSet<>();
//                    return EmptySet;
//                }
//            } else {

                //without the reprint column, packages column becomes index 13, initially was 14, see above
                return StreamSupport.stream(sheetOptional.get().spliterator(), false)
                        .filter(row -> row.getCell(5) != null)
                        .filter(row -> row.getCell(5).getCellType() == Cell.CELL_TYPE_NUMERIC)
                        .map(row -> new M4CatalogVO(sheet, row, warehouseCodes, producerCodes, markCodes, bagCodes, gradeCodes, hasReprint)).collect(LINKED_HASHSET_CATALOG_VO_COLLECTOR);
//            }
        } catch (IOException e) {
            System.out.println("UPLOAD ERROR ======= " + e.getMessage());
            throw new RollBackCheckedException(e);
        }
    }
    
    public static void main(String[] args) throws IOException, RollBackCheckedException {
        ExcelUtils utils = new ExcelUtils();
        Path path = Paths.get(FILE_NAME);
        byte[] fileBytes = Files.readAllBytes(path);
        System.out.println("File read successfully. Byte array length: " + fileBytes.length);
        Set<M4CatalogVO> catalogs = utils.readModified(fileBytes, ExcelUtils.Sheet.M4, true);
         Gson gson = new GsonBuilder()
                        .excludeFieldsWithoutExposeAnnotation()
                        .setPrettyPrinting()
                        .create();
        for(M4CatalogVO catalog : catalogs)
        {
            System.out.println(gson.toJson(catalog));
        }
    }
    
}

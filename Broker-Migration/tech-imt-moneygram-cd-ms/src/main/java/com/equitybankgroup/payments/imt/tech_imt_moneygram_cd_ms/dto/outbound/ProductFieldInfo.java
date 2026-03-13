package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;


import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums.DataType;
import lombok.Data;

@Data
public class ProductFieldInfo {
    private String xmlTag;
    private String visibility;
    private String fieldLabel;
    private int displayOrder;
    private String fieldCategory;
    private String fieldCategoryLabel;
    private boolean dynamic;
    private long fieldMax;
    private long fieldMin;
    private String dataType;
    private boolean enumerated;
    private String defaultValue;
    private String validationRegEx;
    private String arrayName;
    private int arrayLength;
    private String exampleFormat;
    private EnumeratedValues enumeratedValues;

    private boolean isValidVisibilityType(String dataType) {
        try {
            DataType.valueOf(dataType.toUpperCase());
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public void setVisibilityType(String dataType) {
        if (isValidVisibilityType(dataType)) {
            this.visibility = dataType;
        } else {
            throw new IllegalArgumentException("Invalid data type: " + dataType);
        }
    }

    private boolean isValidDataType(String dataType) {
        try {
            DataType.valueOf(dataType.toUpperCase());
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public void setDataType(String dataType) {
        if (isValidDataType(dataType)) {
            this.dataType = dataType;
        } else {
            throw new IllegalArgumentException("Invalid data type: " + dataType);
        }
    }
}

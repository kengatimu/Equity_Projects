package com.papss.middleware.enums;

public enum CategoryPurpose {

    SUPP("Invoice Payment"),
    CASH("Cash Payment"),
    CCRD("Credit Card Payment"),
    GOVT("GOVT Payment");

    public String description;

    CategoryPurpose(final String description) {
        this.description = description;
    }

    public static CategoryPurpose findByValue(String value) {
        CategoryPurpose result = null;
        for (CategoryPurpose code : values()) {
            if (code.name().equalsIgnoreCase(value)) {
                result = code;
                break;
            }
        }
        return result;
    }

}

package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CategoryPurposeTest {

    @Test
    void values_valueOf_and_findByValue() {
        CategoryPurpose[] vals = CategoryPurpose.values();
        assertArrayEquals(new CategoryPurpose[]{CategoryPurpose.SUPP, CategoryPurpose.CASH, CategoryPurpose.CCRD, CategoryPurpose.GOVT}, vals);

        assertEquals(CategoryPurpose.SUPP, CategoryPurpose.valueOf("SUPP"));
        assertEquals(CategoryPurpose.GOVT, CategoryPurpose.findByValue("govt"));
        assertNull(CategoryPurpose.findByValue("unknown"));

        assertEquals("Invoice Payment", CategoryPurpose.SUPP.description);
        assertEquals("GOVT Payment", CategoryPurpose.GOVT.description);
    }
}

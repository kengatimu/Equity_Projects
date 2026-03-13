package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class StatusCodesTest {

    @Test
    void values_and_valueOf_work() {
        StatusCodes[] vals = StatusCodes.values();
        assertArrayEquals(new StatusCodes[]{
                StatusCodes.ACTC,
                StatusCodes.RCVD,
                StatusCodes.PART,
                StatusCodes.RJCT,
                StatusCodes.PDNG,
                StatusCodes.ACCP,
                StatusCodes.ACSP,
                StatusCodes.ACSC,
                StatusCodes.ACWC
        }, vals);

        assertEquals(StatusCodes.ACCP, StatusCodes.valueOf("ACCP"));
        assertEquals(StatusCodes.ACSC, StatusCodes.valueOf("ACSC"));
    }
}

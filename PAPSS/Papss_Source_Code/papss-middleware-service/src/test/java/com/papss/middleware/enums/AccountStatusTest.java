package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AccountStatusTest {

    @Test
    void values_and_valueOf_work() {
        AccountStatus[] vals = AccountStatus.values();
        assertEquals(2, vals.length);
        assertEquals(AccountStatus.ACTIVE, vals[0]);
        assertEquals(AccountStatus.INACTIVE, vals[1]);

        assertEquals(AccountStatus.ACTIVE, AccountStatus.valueOf("ACTIVE"));
        assertEquals(AccountStatus.INACTIVE, AccountStatus.valueOf("INACTIVE"));
    }
}

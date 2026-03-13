package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AccountTypeTest {

    @Test
    void values_and_valueOf_work() {
        AccountType[] vals = AccountType.values();
        assertArrayEquals(new AccountType[]{AccountType.SA_3, AccountType.NOSTRO, AccountType.CA, AccountType.SSA_3, AccountType.ALL}, vals);

        assertEquals(AccountType.SA_3, AccountType.valueOf("SA_3"));
        assertEquals(AccountType.NOSTRO, AccountType.valueOf("NOSTRO"));
        assertEquals(AccountType.CA, AccountType.valueOf("CA"));
        assertEquals(AccountType.SSA_3, AccountType.valueOf("SSA_3"));
        assertEquals(AccountType.ALL, AccountType.valueOf("ALL"));
    }
}

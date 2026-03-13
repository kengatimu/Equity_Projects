package com.equitybank.gag.papss.ots.jpos.jposService;

public interface ISOUtilityService {

    String generateSTAN(); // 6-digit unique STAN

    String getDateField7();  // MMddHHmmss

    String getDateField12(); // yyMMddHHmmss

    String getDateField17(); // MMdd
}

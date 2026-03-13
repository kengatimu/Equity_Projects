package com.papss.middleware.enums;

public enum LocalInstrument {

    ET("Central Bank Settlement Model for Eligible Transactions"),
    SSA3("Commercial Bank Settlement Model for Local Currency Transactions"),
    USDP("Commercial Bank Settlement Model for USD Currency Transactions");
    //    AGR("Agricultural Development"),
//    CAR("SCHEMA CODE FOR GTB FOR BUYING CARS"),
//    CODE("TESTEE"),
//    DEFI("Rice Planting"),
//    DEL("Delly Mortage"),
//    DLT("Dynamic Limit Test"),
//    EDU("tester"),
//
//    GAM("GAMBIA GAM"),
//    GGG("Ghana GGG"),
//    GMS("Represent SME transactions of the Gambia"),
//    GNN("GUINEA GNN"),
//    IUAT("For UAT"),
//    JNET("JAIZ Non Eligible visible Tnx"),
//    LLL("Liberia LLL"),
//    LMT("Limit Tests"),
//    NET("Non-Eligible Transactions"),
//    NNN("Nigeria NNN"),
//    REI("Rare Earth Import Transactions"),
//    RST("Payment for Resort"),
//    SMM("Sample LI"),
//    SSS("SSS"),
//    TIN("Just test"),
//    TNAM("TINAM SQUEELAT"),
//    TST("test payment"),
//    WHO("WHO");
    private final String description;

    LocalInstrument(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}

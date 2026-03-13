package com.papss.middleware.utils;

public class RegularExpressions {
    public final static String ALPHANUMERIC = "^[A-Za-z0-9_]+$";
    public final static String NUMERIC = "^[0-9]*$";
    public final static String ALPHABETS = "^[A-Za-z]*$";
    public final static String ALPHABETSORNUMERIC = "^(?=.*[a-zA-Z])(?=.*[0-9])[A-Za-z0-9]|[A-Za-z]+$";
    public final static String ISODATE = "\\d{4}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[1-2]\\d|3[0-1])T(?:[0-1]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+|)(?:Z|(?:\\+|\\-)(?:\\d{2}):?(?:\\d{2}))";

}

load data
APPEND into table CUSTOM.EXCANRE_TABLE
TRAILING NULLCOLS
(PAYMENT_DPA terminated by "|",
CLIENTCDSNO terminated by "|", 
ACCOUNTNUMBER	terminated by "|", 
AMOUNT terminated by "|", 
ASATDATE terminated by "|",
BANK_ID terminated by "|")

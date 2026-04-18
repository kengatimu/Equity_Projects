load data
append into table CUSTOM.EQU_UPLOAD_TABLE
TRAILING NULLCOLS
(UPLDREFNUM terminated by "|",
 UPLDNAME terminated by "|",
 AMOUNT terminated "|" ,
 FILE_NAME terminated "|" ,
 RCRE_USER_ID terminated "|" ,
 PF_NUMBER  terminated by "|",
 BANK_ID terminated by whitespace)

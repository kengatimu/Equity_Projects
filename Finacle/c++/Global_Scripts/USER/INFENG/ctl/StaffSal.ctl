load data
APPEND into table CUSTOM.STAFFSAL
TRAILING NULLCOLS
(SOLID char terminated by "|",
OLDACC  char terminated by "|", 
AMT    char terminated by "|", 
TRANTYPE  char terminated by "|",
BANK_ID    char terminated by whitespace) 

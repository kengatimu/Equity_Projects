load data
APPEND INTO TABLE CUSTOM.STATEMENTCHRGS
TRAILING NULLCOLS
(foracid  terminated by ",",
page terminated by ",",
bank_id terminated by whitespace)

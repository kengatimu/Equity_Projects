load data
infile 'Directdebit.TXT'
append
into table CUSTOM.c_dds
TRAILING NULLCOLS
(RECTYPE  position (1:5), 
CLIENTREF position (6:25), 
CLIENTNAME position (26:125),
BANKCODE position (126:127),
BRANCHCODE position (129:135),
CLIENTACNO position (136:155), 
CLIENTBANKBRANCH position (156:205), 
CLIENTBANKNAME   position (206:255), 
AMOUNT   position (256:265), 
POLICYNO position (266:275), 
DUEDATE  position (286:295) DATE "DD/MM/YYYY",
bank_id  position (296:303)
)

load data
infile 'KBA_Directdebit.TXT'
Append
into table CUSTOM.C_KBADDS
TRAILING NULLCOLS
(ReasonCode  position(1:2),
 EFTTranCode position(3:4),
 Amount  position(5:19),
 DebitBankCode position(20:21),
 DebitBankBranch position(22:23),
 DebitAcctNum	 position(26:38),
 CreditbankCode  position(39:40),
 CreditBankBranch  position(41:43),
 CreditAcctNum	 position(46:58),
 InstBankCode    position(59:60),
 InstBankBranch  position(61:63),
 originator_code position(64:67),
 originator_ref position(68:82),
 policyNum1	position(83:102),
 policyNum2	position(103:122),
 remarks        position(123:147),
 Bank_id        position(159:160) 	
)


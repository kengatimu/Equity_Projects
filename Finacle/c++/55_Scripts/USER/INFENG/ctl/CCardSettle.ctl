load data
infile 'CCARDFILE.TXT'
Append
into table CUSTOM.C_CCST
TRAILING NULLCOLS
(Row_code	Position(1:2),	
Row_number	Position(3:8),	
Transfer_number	Position(9:18),	
Transfer_code	Position(19:26),	
Debit_Account	Position(27:58),	
Credit_Account	Position(59:90),	
Transfer_amount	Position(91:105),	
Transfer_local_amount  Position(106:120),	
Transfer_Descriptor    Position(121:220),
Amount_sign            Position(221:221),	
Group_Identifier       Position(222:230),	
Transfer_type          Position(231:231),	
Reference_number       Position(232:263),	
Reserved               Position(264:270),	
Terminal_symbol        Position(271:271),	
Delimiter              Position(272:274),
bank_id		       Position(275:276)	
 ) 

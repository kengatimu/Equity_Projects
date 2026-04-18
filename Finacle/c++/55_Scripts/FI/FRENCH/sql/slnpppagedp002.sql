---------------------------------------------------------------------------------
--    File Name                  : slnpppagedp002.sql
--    Tables Used                : STAFFSAL
--    Date                       : 27.02.2013
--    Author                     : DhanaPrabhakaran
--    Assumptions                : NA
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>      		 <Description>
--       1.          27.02.2013     DhanaPrabhakaran            Original Version
-----------------------------------------------------------------------------------
DELETE CUSTOM.STAFFSAL WHERE bank_id='&1'
/
COMMIT
/
EXIT
/

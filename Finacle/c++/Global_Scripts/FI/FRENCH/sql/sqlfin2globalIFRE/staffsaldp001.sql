---------------------------------------------------------------------------------
--    File Name                  : staffsaldp001.sql
--    Tables Used                : STAFFSAL
--    Date                       : 22.02.2013
--    Author                     : Prakash
--    Assumptions                : NA
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>       <Description>
--       1.          22.02.2013     Prakash             Original Version
-----------------------------------------------------------------------------------

------------------------------------------------------------------------------------
---Deleting the alll rows from STAFFSAL Table befoe uploading the file
------------------------------------------------------------------------------------

DELETE CUSTOM.STAFFSAL WHERE bank_id='&1'
/
commit
/
EXIT
/

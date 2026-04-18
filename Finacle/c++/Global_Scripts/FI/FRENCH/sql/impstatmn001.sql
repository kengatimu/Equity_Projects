------------------------------------------------------------------------------------------
--    Name		: impstatmn001.sql
--    Description     	: This is used to run for checking the stats of dtd and dth tables.
--    Date            	: 20-02-2013
--    Author          	: Rajavel
--    Input           	: NA
--    Output		: NA
--    Called Script	: NA
--    Calling Script	: NA
--    Menu Option	: NA 
--    Modification Log  :
--    Srl. No		 Date		Author		 Description.   
--    -------		--------	------		----------------
--     1.0		20-02-2013	Rajavel	        Original Version
------------------------------------------------------------------------------------- 


EXEC DBMS_STATS.IMPORT_TABLE_STATS(OWNNAME=>'TBAADM',TABNAME=>'DAILY_TRAN_DETAIL_TABLE',STATTAB=>'DTD_DTH_STATS',CASCADE=>TRUE)
/
EXEC DBMS_STATS.IMPORT_TABLE_STATS(OWNNAME=>'TBAADM',TABNAME=>'DAILY_TRAN_HEADER_TABLE',STATTAB=>'DTD_DTH_STATS',CASCADE=>TRUE)
/
EXIT

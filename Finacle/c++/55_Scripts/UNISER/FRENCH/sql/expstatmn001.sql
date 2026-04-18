------------------------------------------------------------------------------------------
--    Name					: expstatmn001.sql
--    Description     		: This is used to run for checking the stats of dtd and dth tables.
--    Date            		: 20-02-2013
--    Author          		: Rajavel
--    Input           		: NA
--    Output		        : NA
--    Called Script		 	: NA
--    Calling Script		: NA
--    Menu Option			: NA 
--    Modification Log   	:
--    Srl. No		 Date		Author		 Description.   
--    -------		--------	------		----------------
--     1.0		  20-02-2013	Rajavel	    Original Version
------------------------------------------------------------------------------------- 
spool a.txt
analyze TABLE TBAADM.DAILY_TRAN_DETAIL_TABLE compute statistics
/
analyze TABLE TBAADM.DAILY_TRAN_HEADER_TABLE compute statistics
/
EXEC DBMS_STATS.EXPORT_TABLE_STATS(OWNNAME=>'TBAADM',TABNAME=>'DAILY_TRAN_DETAIL_TABLE',STATTAB=>'DTD_DTH_STATS',CASCADE=>TRUE,STATOWN=>'CUSTOM')
/
EXEC DBMS_STATS.EXPORT_TABLE_STATS(OWNNAME=>'TBAADM',TABNAME=>'DAILY_TRAN_HEADER_TABLE',STATTAB=>'DTD_DTH_STATS',CASCADE=>TRUE,STATOWN=>'CUSTOM')
/
spool off
EXIT

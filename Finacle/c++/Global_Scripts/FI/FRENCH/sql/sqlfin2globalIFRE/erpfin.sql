set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool erpfin.lst

/
truncate table CUSTOM.DAILY_MOVEMENTS drop storage;

truncate table CUSTOM.FIN_ORACLE_STAGING drop storage;

commit
/
spool off;

exit;



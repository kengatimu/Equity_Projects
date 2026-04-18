set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool dailymv.lst

exec CUSTOM.INSERT_INTO_DAILY_MOVEMENTS_DR('&3')
/
commit
/
exec CUSTOM.INSERT_INTO_STAGING_DR('&3')
/
commit
/
spool off;
exit;

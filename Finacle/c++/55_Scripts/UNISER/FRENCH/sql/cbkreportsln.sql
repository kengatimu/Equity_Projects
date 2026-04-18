set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool cbkreportsln.lst

/
exec CUSTOM.NORM_LOANS_CBK_PROC_2015_B ('&1', '05-oct-2015')
/
commit
/
spool off;
exit;



set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool atmshare.lst

declare
    cursor c1 is select to_char(db_stat_date -1 ,'DD-MON-RRRR') as calender_date from tbaadm.gct where  DC_alias='54';
begin
for i in c1 loop
begin          
 custom.compute_atm_comm_dist_new(i.calender_date);
  end;
commit;
end loop;
end;
/
commit;
/
declare
    cursor c1 is select to_char(db_stat_date -1 ,'DD-MON-RRRR') as calender_date from tbaadm.gct where  DC_alias='54';
begin
for i in c1 loop
begin          
 custom.compute_atm_comm_dist_sum(i.calender_date);
  end;
commit;
end loop;
end;
/
commit;
/
update CUSTOM.ATM_SHARE_TOTPOST set process_flag='M'  WHERE process_flag='N' and ATM_SOL_COMM !=0 AND  ATM_SHARE_TOTPOST.bank_id = '54' and rownum<5000;
/
commit;
/
exit
/

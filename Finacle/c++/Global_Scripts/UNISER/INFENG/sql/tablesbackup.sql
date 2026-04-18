/
insert into CUSTOM.SMS_STAGE_TABLE_CHANNEL_HIST  select * from CUSTOM.SMS_STAGE_TABLE_CHANNEL where TRAN_DATE<=(select to_char(db_stat_date -3,'DD-MON-RRRR') from tbaadm.gct where bank_id='54')
/
commit;
/
delete from CUSTOM.SMS_STAGE_TABLE_CHANNEL where TRAN_DATE<=(select to_char(db_stat_date -3,'DD-MON-RRRR') from tbaadm.gct where bank_id='54')
/
commit;
/
insert into CUSTOM.SMS_STAGE_TABLE_HISTORY  select * from CUSTOM.SMS_STAGE_TABLE where TRAN_DATE<=(select to_char(db_stat_date -3,'DD-MON-RRRR') from tbaadm.gct where bank_id='54')
/
commit;
/
delete from CUSTOM.SMS_STAGE_TABLE where TRAN_DATE<=(select to_char(db_stat_date -3,'DD-MON-RRRR') from tbaadm.gct where bank_id='54')
/
commit;
/
insert into CUSTOM.C_UBP_DETAILS_HIST  select * from CUSTOM.C_UBP where TRAN_DATE<=(select to_char(db_stat_date -30,'DD-MON-RRRR') from tbaadm.gct where bank_id='54')
/
commit;
/
delete from CUSTOM.C_UBP where TRAN_DATE<=(select to_char(db_stat_date -30,'DD-MON-RRRR') from tbaadm.gct where bank_id='54')
/
commit;
/
delete  from CUSTOM.OTHERS_EXEMPTION_TABLE  where EXEMPT_CODE='DISBURSE' and del_flg='N'  and substr(PHONE_NUMBER,-9) in (
select substr(PHONENO,-9) from tbaadm.cphone  where bank_id='54' and   substr(PHONENO,-9)  in  (select  substr(PHONE_NUMBER,-9)   from CUSTOM.OTHERS_EXEMPTION_TABLE  where EXEMPT_CODE='DISBURSE' and del_flg='N' )
and PHONE_B2KID not in (select cif_id from tbaadm.gam  where bank_id='54' and schm_code='SB190' and acct_cls_flg='N'));
/
commit;
/
update   custom.MOBEE_PUSH_SMS set MESSAGE_STATUS='Z' where MESSAGE_STATUS=1;
/
commit;
/
insert into    custom.MOBEE_PUSH_SMS_HISTORY  select * from custom.MOBEE_PUSH_SMS where  MESSAGE_STATUS='Z';
/
commit;
/
delete from  custom.MOBEE_PUSH_SMS where  MESSAGE_STATUS='Z';
/
commit;
/
truncate table TBAADM.PRINT_QUEUE_TABLE;
/
COMMIT
/
exit
/

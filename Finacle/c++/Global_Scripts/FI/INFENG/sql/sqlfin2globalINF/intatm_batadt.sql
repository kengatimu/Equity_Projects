/
update tbaadm.ftrt set STATUS='B' where bank_id='54' and REQUEST_DATE=(select to_char(db_stat_date ,'DD-MON-RRRR') from tbaadm.gct where bank_id='54')  and STATUS!='B' and (TR_REF_NUM,bank_id) in (select TREA_REF_NUM,bank_id from tbaadm.dtd where bank_id='54' and PSTD_FLG='Y');
/
commit;
/
update tbaadm.ftrt set STATUS='B' where bank_id='56' and REQUEST_DATE=(select to_char(db_stat_date ,'DD-MON-RRRR') from tbaadm.gct where bank_id='56')  and STATUS!='B' and (TR_REF_NUM,bank_id) in (select TREA_REF_NUM,bank_id from tbaadm.dtd where bank_id='56' and PSTD_FLG='Y');
/
commit;
/
update tbaadm.ftrt set STATUS='B' where bank_id='50' and REQUEST_DATE=(select to_char(db_stat_date ,'DD-MON-RRRR') from tbaadm.gct where bank_id='50')  and STATUS!='B' and (TR_REF_NUM,bank_id) in (select TREA_REF_NUM,bank_id from tbaadm.dtd where bank_id='50' and PSTD_FLG='Y');
/
commit;
/
update tbaadm.ftrt set STATUS='B' where bank_id='11' and REQUEST_DATE=(select to_char(db_stat_date ,'DD-MON-RRRR') from tbaadm.gct where bank_id='11')  and STATUS!='B' and (TR_REF_NUM,bank_id) in (select TREA_REF_NUM,bank_id from tbaadm.dtd where bank_id='11' and PSTD_FLG='Y');
/
commit;
/
update tbaadm.ftrt set STATUS='B' where bank_id='55' and REQUEST_DATE=(select to_char(db_stat_date ,'DD-MON-RRRR') from tbaadm.gct where bank_id='55')  and STATUS!='B' and (TR_REF_NUM,bank_id) in (select TREA_REF_NUM,bank_id from tbaadm.dtd where bank_id='55' and PSTD_FLG='Y');
/
commit;
/
exit
/

/
declare
cursor c1 is select acid from custom.dutyaccountss;
begin
for i in c1 loop
insert into custom.DUTYPERIOD_ALL  select (select to_char(db_stat_date -2,'DD-MON-RRRR')  from tbaadm.gct where  DC_alias='54' ) enddate,(select to_char(db_stat_date -3 ,'DD-MON-RRRR') from tbaadm
.gct where  DC_alias='54' )  startdate,    (select sol_id||'3400103506'  from tbaadm.gam where acid=i.acid and Bank_id='54') excisedutyacc,(select sol_id from tbaadm.gam where acid=i.acid and Bank_id='54') SOL_ID
     ,tbaadm.commonpackage.eabbal('54', i.acid,(select db_stat_date -2  from tbaadm.gct where  DC_alias='54')) ENDPERIOD ,
tbaadm.commonpackage.eabbal('54', i.acid,(select db_stat_date -3  from tbaadm.gct where  DC_alias='54')) STARTPERIOD ,
 (tbaadm.commonpackage.eabbal('54', i.acid,(select db_stat_date -2  from tbaadm.gct where  DC_alias='54')) -  tbaadm.commonpackage.eabbal('54', i.acid,(select db_stat_date -3  from tbaadm.gct where  DC_alias='54'))) DIFFAMOUNT,
  ( ( (tbaadm.commonpackage.eabbal('54', i.acid,(select db_stat_date -2  from tbaadm.gct where  DC_alias='54')) - tbaadm.commonpackage.eabbal('54', i.acid,(select db_stat_date -3  from tbaadm.gct where  DC_alias='54'))) +
(nvl((select sum(tran_amt) from tbaadm.htd h1 where  part_tran_type = 'D' and pstd_flg = 'Y' and del_flg = 'N' and bank_id='54' and tran_date in  (select to_char(db_stat_date -2,'DD-MON-RRRR')  from tbaadm.gct where  DC_alias='54' )  and h1.acid=i.acid and (h1.TRAN_PARTICULAR like '%EXC DTY%' OR TRAN_PARTICULAR ='EOY PL BAL TRANSFER 2021 TO HO') ),0)-
nvl( (select sum(tran_amt) from tbaadm.htd h1 where part_tran_type = 'C' and pstd_flg = 'Y' and del_flg = 'N' and bank_id='54' and  tran_date in  (select to_char(db_stat_date -2,'DD-MON-RRRR')  from tbaadm.gct where  DC_alias='54' )  and h1.acid=i.acid and (h1.TRAN_PARTICULAR like '%EXC DTY%' OR TRAN_PARTICULAR ='EOY PL BAL TRANSFER 2021 TO HO') ) ,0) ))  *0.166666667)  PERCNTAMOUNT,
nvl((select sum(tran_amt) from tbaadm.htd h1 where  part_tran_type = 'D' and pstd_flg = 'Y' and del_flg = 'N' and bank_id='54' and tran_date in  (select to_char(db_stat_date -2,'DD-MON-RRRR')  from tbaadm.gct where  DC_alias='54' )  and h1.acid=i.acid and (h1.TRAN_PARTICULAR like '%EXC DTY%' OR TRAN_PARTICULAR ='EOY PL BAL TRANSFER 2021 TO HO') ),0)-
nvl( (select sum(tran_amt) from tbaadm.htd h1 where part_tran_type = 'C' and pstd_flg = 'Y' and del_flg = 'N' and bank_id='54' and  tran_date in  (select to_char(db_stat_date -2,'DD-MON-RRRR')  from tbaadm.gct where  DC_alias='54' )  and h1.acid=i.acid and (h1.TRAN_PARTICULAR like '%EXC DTY%' OR TRAN_PARTICULAR ='EOY PL BAL TRANSFER 2021 TO HO') ) ,0) dif ,
  (select foracid from tbaadm.gam where acid=i.acid and gam.Bank_id='54') FORACID,(select acct_name from tbaadm.gam where acid=i.acid and Bank_id='54' ) ACCT_NAME ,(select to_char(db_stat_date,'DD-MON-RRRR')
  from tbaadm.gct where  DC_alias='54') PROCESSDATE, '@' PROCESSFLG,custom.exciseduty_seq.nextval from dual;
commit;
end loop;
end;
/
commit;
/
exit
/

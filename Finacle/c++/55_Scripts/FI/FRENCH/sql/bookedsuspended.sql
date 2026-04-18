/
exec custom.booked_int_insert;
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722418965' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763545524' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='BOOKED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR') 
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','vTotal') ||' Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR') 
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','vTotal') ||' Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722418965' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR') 
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','vTotal') ||' Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763545524' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended On '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST' and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR') 
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'  
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED INTEREST','vTotal ','SUSPENDED INTEREST','vTotal') ||' Kes: '||trim((to_char(SUM(AMOUNT_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.BOOKED_SUS_INT_TABLE bs
where item='SUSPENDED INTEREST'
and BOD_DATE >=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
GROUP BY item)) ,0,'54');
/
commit;
/
----- Highestall
---- Bookedhigh
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleBKHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked KES '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='KES' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%'  and bank_id='54'
and del_flg='N' and tran_amt>2000000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Bookedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='KES' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%'
and bank_id='54'   and del_flg='N'  and tran_amt>2000000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleBKHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked KES '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='KES' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%'  and bank_id='54'
and del_flg='N' and tran_amt>2000000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Bookedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='KES' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%'
and bank_id='54'   and del_flg='N'  and tran_amt>2000000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleBKHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked USD '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='USD' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%'  and bank_id='54'
and del_flg='N' and tran_amt>19000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Bookedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='USD' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%'
and bank_id='54'   and del_flg='N'  and tran_amt>19000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleBKHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked USD '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='USD' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%'  and bank_id='54'
and del_flg='N' and tran_amt>19000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Bookedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='USD' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%'
and bank_id='54'   and del_flg='N'  and tran_amt>19000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleBKHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked GBP '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='GBP' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%'  and bank_id='54'
and del_flg='N' and tran_amt>16000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Bookedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='GBP' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%'
and bank_id='54'   and del_flg='N'  and tran_amt>16000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleBKHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  'Booked GBP '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='GBP' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%'  and bank_id='54'
and del_flg='N' and tran_amt>16000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Bookedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked from tbaadm.htd where acid in(  
select   acid   from tbaadm.gam where   bank_id='54' and acct_crncy_code='GBP' and  bacid in (select INT_PANDL_BACID_DR from tbaadm.gsp where schm_type='LAA'  and bank_id='54') )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%'
and bank_id='54'   and del_flg='N'  and tran_amt>16000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
---- Highest Suspended
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleSUSPHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended KES '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked 
from tbaadm.htd where acid in (select acid   from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='KES'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
    and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') ) ) 
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%' 
and bank_id='54' and del_flg='N' and tran_amt>150000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Suspendedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked
from tbaadm.htd where acid in (select acid  
 from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='KES'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') )  )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%'
and bank_id='54'   and del_flg='N'  and tran_amt>1500000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleSUSPHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended KES '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked 
from tbaadm.htd where acid in (select acid   from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='KES'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
    and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') ) ) 
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%' 
and bank_id='54' and del_flg='N' and tran_amt>150000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Suspendedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked
from tbaadm.htd where acid in (select acid  
 from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='KES'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') )  )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%'
and bank_id='54'   and del_flg='N'  and tran_amt>1500000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleSUSPHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended USD '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked 
from tbaadm.htd where acid in (select acid   from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='USD'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
    and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') ) ) 
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%' 
and bank_id='54' and del_flg='N' and tran_amt>9000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Suspendedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked
from tbaadm.htd where acid in (select acid  
 from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='USD'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') )  )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%'
and bank_id='54'   and del_flg='N'  and tran_amt>9000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleSUSPHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended USD '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked 
from tbaadm.htd where acid in (select acid   from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='USD'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
    and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') ) ) 
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%' 
and bank_id='54' and del_flg='N' and tran_amt>9000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Suspendedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked
from tbaadm.htd where acid in (select acid  
 from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='USD'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') )  )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%'
and bank_id='54'   and del_flg='N'  and tran_amt>9000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleSUSPHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended GBP '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked 
from tbaadm.htd where acid in (select acid   from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='GBP'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
    and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') ) ) 
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%' 
and bank_id='54' and del_flg='N' and tran_amt>8000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Suspendedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked
from tbaadm.htd where acid in (select acid  
 from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='GBP'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') )  )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%'
and bank_id='54'   and del_flg='N'  and tran_amt>8000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleSUSPHIGH', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct  ' Suspended GBP '||''|| TO_CHAR((TO_DATE(sysdate-1,'DD-MM-RRRR')),'DD-MON-RRRR') 
as Booked
from dual
union all
select * from ( select 'KE:'||''||trim(sol_id)||' '||trim(tran_id)||' '||TO_CHAR((TO_DATE(tran_date,'DD-MM-RRRR')),'DD-MON-RRRR')||' '|| trim(to_char((tran_amt),'999,999,999,999,999.99'))||' '||
replace(replace(replace(tran_particular,':',''),' ',''),'-','')
||' '||TRAN_CRNCY_CODE||' '||(select trim(SOL_DESC) from tbaadm.sol where sol.sol_id=htd.sol_id) as  Booked 
from tbaadm.htd where acid in (select acid   from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='GBP'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
    and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') ) ) 
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%' and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%' 
and bank_id='54' and del_flg='N' and tran_amt>8000 order by tran_amt desc) where  rownum<7
union all
select * from ( select 'vTotal Suspendedhighest '||''|| trim(to_char((sum(tran_amt)),'999,999,999,999,999.99')) as     Booked
from tbaadm.htd where acid in (select acid  
 from  tbaadm.gam where bank_id='54' and gam.acct_crncy_code='GBP'  and bacid in (select distinct(INT_SUSP_BACID) from tbaadm.aip where bank_id='54' 
and schm_code in(select schm_code from tbaadm.gsp where schm_type='LAA'and del_flg!='Y' and bank_id='54') )  )
and PART_TRAN_TYPE='C'  and tran_date>=TO_CHAR((TO_DATE(sysdate-6,'DD-MM-RRRR')),'DD-MON-RRRR')
and tran_particular not like '%Consolidated%' and tran_particular not like '%SOL xfr%'  and tran_particular not like '%EOY PL BAL TRANSFER 2018%' and TRAN_PARTICULAR not like '%Scheme Code xfr for%'
and bank_id='54'   and del_flg='N'  and tran_amt>8000 order by tran_amt desc)  where  rownum<7)) ,0,'54');
/
commit;
/
exit
/

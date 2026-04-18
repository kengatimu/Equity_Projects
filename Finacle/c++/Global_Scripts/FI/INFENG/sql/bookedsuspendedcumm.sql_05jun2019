/
exec CUSTOM.CUMM_BOOKED_SUS_INSERT;
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Booked On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Booked On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722418965' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Booked On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
                    MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
                     CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763545524' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Booked On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'BOOKED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='BOOKED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763626695' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Suspended On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'SUSPENDED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722395534' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Suspended On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'SUSPENDED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254722418965' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Suspended On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'SUSPENDED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
insert into  CUSTOM.MOBEE_PUSH_SMS (REF_NO, LANGUAGE, INSTITUTION_CODE, MOBILE_NUMBER, MESSAGE_ARRIEVED_DATE, MESSAGE_PRIORITY,
MESSAGE_STATUS, MESSAGE_VALIDITY_PERIOD, DEPARTMENT, MESSAGE_TEXT,retry_count, BANK_ID ) values (
CUSTOM.MOBEE_PUSH_SMS_SEQUENCE.nextval,'EN','068', '254763545524' ,sysdate,'4','0','86400000','FinacleBKSUSP', (select listagg(Booked,' ') within group ( order by Booked)
from (
select distinct (select 'Cumm Suspended On '||''|| to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY ) 
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED' and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY  )
GROUP BY  COUNTRY
union all
select (select decode (Bank_id,'54','KE','11','SS','55','TZ','50','RW','56', 'UG','99','FS') from tbaadm.gct where del_flg='N'and gct.bank_id=bs.COUNTRY) ||':'||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'  and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item,COUNTRY
union all
select 
 decode(item,'SUSPENDED','vTotal ','SUSPENDED INTEREST','SUSP') ||'Kes: '||trim((to_char(SUM(CUMULATIVE_SUM_KES),'999,999,999,999,999.99')))
as Booked
from CUSTOM.CUMM_SUS_BOOKED_TABLE bs
where item='SUSPENDED'
and BOD_DATE =(select to_char(DC_CLS_DATE,'DD-Mon-RRRR') from tbaadm.gct where del_flg='N' and gct.bank_id=bs.COUNTRY )
GROUP BY item)) ,0,'54');
/
commit;
/
exit
/

/
create table custom.rollback_USD_done_two_DR as 
SELECT REMARKS,gam.cif_Id,htd.value_date,gam.sol_id,gam.foracid,gam.acct_name,htd.TRAN_AMT,htd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
htd.TRAN_PARTICULAR,gam.schm_code ,htd.tran_id,htd.TRAN_DATE,htd.TRAN_TYPE,htd.TRAN_SUB_TYPE,htd.del_flg,hth.init_sol_id,
htd.REF_NUM,RATE_CODE,RATE,htd.ENTRY_USER_ID,  htd.TRAN_PARTICULAR_2,htd.tran_rmks,
( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end) order by htd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) order by (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.htd ,tbaadm.gam,tbaadm.hth WHERE gam.acid=htd.ACID 
and htd.tran_id=hth.TRAN_ID
and htd.bank_id =gam.bank_id 
and htd.bank_id =hth.bank_id
and htd.tran_date = hth.tran_date
and htd.bank_id = '43'
AND HTD.DEL_FLG='N'
and htd.tran_date>='07-nov-2024'
and gam.foracid='15051317030110'
and htd.PART_TRAN_TYPE='D'
union all
SELECT REMARKS,gam.cif_Id,dtd.value_date,gam.sol_id,gam.foracid,gam.acct_name,dtd.TRAN_AMT,dtd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
dtd.TRAN_PARTICULAR,gam.schm_code ,dtd.tran_id,dtd.TRAN_DATE,dtd.TRAN_TYPE,dtd.TRAN_SUB_TYPE,dtd.del_flg,dth.init_sol_id,
dtd.REF_NUM,RATE_CODE,RATE,dtd.ENTRY_USER_ID,  dtd.TRAN_PARTICULAR_2,dtd.tran_rmks,
( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end) order by dtd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) order by (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.dtd ,tbaadm.gam,tbaadm.dth WHERE gam.acid=dtd.ACID 
and dtd.tran_id=dth.TRAN_ID
and dtd.bank_id =gam.bank_id 
and dtd.bank_id =dth.bank_id
and dtd.tran_date = dth.tran_date
and dtd.bank_id = '43'
AND dtd.DEL_FLG='N'
and dtd.tran_date>='07-nov-2024'
and gam.foracid='15051317030110'
and dtd.PART_TRAN_TYPE='D';
/
commit;
/
create table custom.rollback_USD_done_two_CR as 
SELECT REMARKS,gam.cif_Id,htd.value_date,gam.sol_id,gam.foracid,gam.acct_name,htd.TRAN_AMT,htd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
htd.TRAN_PARTICULAR,gam.schm_code ,htd.tran_id,htd.TRAN_DATE,htd.TRAN_TYPE,htd.TRAN_SUB_TYPE,htd.del_flg,hth.init_sol_id,
htd.REF_NUM,RATE_CODE,RATE,htd.ENTRY_USER_ID,  htd.TRAN_PARTICULAR_2,htd.tran_rmks,
( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end) order by htd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) order by (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.htd ,tbaadm.gam,tbaadm.hth WHERE gam.acid=htd.ACID 
and htd.tran_id=hth.TRAN_ID
and htd.bank_id =gam.bank_id 
and htd.bank_id =hth.bank_id
and htd.tran_date = hth.tran_date
and htd.bank_id = '43'
AND HTD.DEL_FLG='N'
and htd.tran_date>='07-nov-2024'
and gam.foracid='15051317030110'
and htd.PART_TRAN_TYPE='C'
union all
SELECT REMARKS,gam.cif_Id,dtd.value_date,gam.sol_id,gam.foracid,gam.acct_name,dtd.TRAN_AMT,dtd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
dtd.TRAN_PARTICULAR,gam.schm_code ,dtd.tran_id,dtd.TRAN_DATE,dtd.TRAN_TYPE,dtd.TRAN_SUB_TYPE,dtd.del_flg,dth.init_sol_id,
dtd.REF_NUM,RATE_CODE,RATE,dtd.ENTRY_USER_ID,  dtd.TRAN_PARTICULAR_2,dtd.tran_rmks,
( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end) order by dtd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) order by (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.dtd ,tbaadm.gam,tbaadm.dth WHERE gam.acid=dtd.ACID 
and dtd.tran_id=dth.TRAN_ID
and dtd.bank_id =gam.bank_id 
and dtd.bank_id =dth.bank_id
and dtd.tran_date = dth.tran_date
and dtd.bank_id = '43'
AND dtd.DEL_FLG='N'
and dtd.tran_date>='07-nov-2024'
and gam.foracid='15051317030110'
and dtd.PART_TRAN_TYPE='C';
/
commit;
/
create table custom.rollback_CDF_done_two_DR as 
SELECT REMARKS,gam.cif_Id,htd.value_date,gam.sol_id,gam.foracid,gam.acct_name,htd.TRAN_AMT,htd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
htd.TRAN_PARTICULAR,gam.schm_code ,htd.tran_id,htd.TRAN_DATE,htd.TRAN_TYPE,htd.TRAN_SUB_TYPE,htd.del_flg,hth.init_sol_id,
htd.REF_NUM,RATE_CODE,RATE,htd.ENTRY_USER_ID,  htd.TRAN_PARTICULAR_2,htd.tran_rmks,
( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end) order by htd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) order by (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.htd ,tbaadm.gam,tbaadm.hth WHERE gam.acid=htd.ACID 
and htd.tran_id=hth.TRAN_ID
and htd.bank_id =gam.bank_id 
and htd.bank_id =hth.bank_id
and htd.tran_date = hth.tran_date
and htd.bank_id = '43'
AND HTD.DEL_FLG='N'
and htd.tran_date>='07-nov-2024'
and gam.foracid='15051317030152'
and htd.PART_TRAN_TYPE='D'
union all
SELECT REMARKS,gam.cif_Id,dtd.value_date,gam.sol_id,gam.foracid,gam.acct_name,dtd.TRAN_AMT,dtd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
dtd.TRAN_PARTICULAR,gam.schm_code ,dtd.tran_id,dtd.TRAN_DATE,dtd.TRAN_TYPE,dtd.TRAN_SUB_TYPE,dtd.del_flg,dth.init_sol_id,
dtd.REF_NUM,RATE_CODE,RATE,dtd.ENTRY_USER_ID,  dtd.TRAN_PARTICULAR_2,dtd.tran_rmks,
( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end) order by dtd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) order by (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.dtd ,tbaadm.gam,tbaadm.dth WHERE gam.acid=dtd.ACID 
and dtd.tran_id=dth.TRAN_ID
and dtd.bank_id =gam.bank_id 
and dtd.bank_id =dth.bank_id
and dtd.tran_date = dth.tran_date
and dtd.bank_id = '43'
AND dtd.DEL_FLG='N'
and dtd.tran_date>='07-nov-2024'
and gam.foracid='15051317030152'
and dtd.PART_TRAN_TYPE='D';
/
commit;
/
create table custom.rollback_CDF_done_two_CR as 
SELECT REMARKS,gam.cif_Id,htd.value_date,gam.sol_id,gam.foracid,gam.acct_name,htd.TRAN_AMT,htd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
htd.TRAN_PARTICULAR,gam.schm_code ,htd.tran_id,htd.TRAN_DATE,htd.TRAN_TYPE,htd.TRAN_SUB_TYPE,htd.del_flg,hth.init_sol_id,
htd.REF_NUM,RATE_CODE,RATE,htd.ENTRY_USER_ID,  htd.TRAN_PARTICULAR_2,htd.tran_rmks,
( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when htd.TRAN_PARTICULAR_2 like '%/%' then substr(htd.TRAN_PARTICULAR_2,1,instr(htd.TRAN_PARTICULAR_2,'/') - 1) else htd.TRAN_PARTICULAR_2  end) order by htd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR) order by (gam.foracid||''||htd.TRAN_AMT||''||htd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.htd ,tbaadm.gam,tbaadm.hth WHERE gam.acid=htd.ACID 
and htd.tran_id=hth.TRAN_ID
and htd.bank_id =gam.bank_id 
and htd.bank_id =hth.bank_id
and htd.tran_date = hth.tran_date
and htd.bank_id = '43'
AND HTD.DEL_FLG='N'
and htd.tran_date>='07-nov-2024'
and gam.foracid='15051317030152'
and htd.PART_TRAN_TYPE='C'
union all
SELECT REMARKS,gam.cif_Id,dtd.value_date,gam.sol_id,gam.foracid,gam.acct_name,dtd.TRAN_AMT,dtd.PART_TRAN_TYPE,REF_AMt,ACCT_CRNCY_CODE,
dtd.TRAN_PARTICULAR,gam.schm_code ,dtd.tran_id,dtd.TRAN_DATE,dtd.TRAN_TYPE,dtd.TRAN_SUB_TYPE,dtd.del_flg,dth.init_sol_id,
dtd.REF_NUM,RATE_CODE,RATE,dtd.ENTRY_USER_ID,  dtd.TRAN_PARTICULAR_2,dtd.tran_rmks,
( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end)  
as TRAN_PARTICULAR2  ,row_number() over(partition by ( case when dtd.TRAN_PARTICULAR_2 like '%/%' then substr(dtd.TRAN_PARTICULAR_2,1,instr(dtd.TRAN_PARTICULAR_2,'/') - 1) else dtd.TRAN_PARTICULAR_2  end) order by dtd.TRAN_PARTICULAR_2 desc ) as rowmm
,(gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) as Unique_trans
,row_number() over( partition by  (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR) order by (gam.foracid||''||dtd.TRAN_AMT||''||dtd.TRAN_PARTICULAR)  desc )  as rowmm_trans
from tbaadm.dtd ,tbaadm.gam,tbaadm.dth WHERE gam.acid=dtd.ACID 
and dtd.tran_id=dth.TRAN_ID
and dtd.bank_id =gam.bank_id 
and dtd.bank_id =dth.bank_id
and dtd.tran_date = dth.tran_date
and dtd.bank_id = '43'
AND dtd.DEL_FLG='N'
and dtd.tran_date>='07-nov-2024'
and gam.foracid='15051317030152'
and dtd.PART_TRAN_TYPE='C';
/
commit;
/
exec CUSTOM.SMS_INSERT_PROC_TZ;
/
commit;
/
exec custom.SMS_STAGE_TABLE_ALERTS_PROC;
/
commit;
/
exec CUSTOM.SMS_INSERT_PROC_ALERTSM;
/
commit;
/
exec CUSTOM.SMS_PROC_TRANSALERTS_2;
/
commit;
/
exec CUSTOM.SMS_INSERT_PROC_TRANSALERTS_2;
/
commit;
/
update  tbaadm.gac set FREE_CODE_7='' where gac.bank_id='43' and gac.acid in (select acid from tbaadm.gam  where bank_id='43' and schm_code='CA212') and FREE_CODE_7='AGENT'
/
commit;
/
update tbaadm.adt  set auth_id='SYSTEM' where bank_id='43' and table_name='DAT' and auth_id='!' and ENTERER_ID in ('BJMS43' ,'CN01473');
/
commit;
/
update crmuser.accounts_mod set RECORDSTATUS ='F' ,CURRENTSTEP='2'  where recordstatus='D' and bank_id ='54'and orgkey in (select cif_id from custom.bulk_cif where entity_cre_flg ='F') AND RECORDSTATUS ='D';
/
commit;
/
UPDATE CRMUSER.ACCOUNTS SET ENTITY_CRE_FLAG ='Y' ,RECORDSTATUS ='A'  WHERE ORGKEY IN (SELECT CIF_ID FROM CUSTOM.BULK_CIF WHERE ENTITY_CRE_FLG ='K') and RECORDSTATUS='I' and ENTITY_CRE_FLAG='N';
/
commit;
/
UPDATE CRMUSER.ACCOUNTS SET ENTITY_CRE_FLAG ='Y' ,RECORDSTATUS ='A'  WHERE ORGKEY IN (SELECT CIF_ID FROM CUSTOM.BULK_CIF WHERE ENTITY_CRE_FLG ='V' and bank_id ='56') and RECORDSTATUS='I' and ENTITY_CRE_FLAG='N';
/
commit;
/
insert into custom.address_duplicate_drc  select orgkey, 'DUP', 'DRC', null, ADDRESSCATEGORY ,count (*), '43'  from CRMUSER.ADDRESS where bank_id ='43'    having  count (*) > 1 group by orgkey, ADDRESSCATEGORY; 
/
commit;
/
declare
vcount number;
vaddressid number;
cursor c1 is  select  * from  (select orgkey, ADDRESSCATEGORY ,count (*)   from CRMUSER.ADDRESS where bank_id ='43'  having  count (*) > 1 group by orgkey, ADDRESSCATEGORY) 
where orgkey in  (select foracid from custom.address_duplicate_drc  where ENTITY_CRE_FLG = 'DUP') ;
begin
for i in c1 loop
select  count(*) into  vcount from  CRMUSER.address where bank_id='43' and  ORGKEY=i.orgkey and ADDRESSCATEGORY=i.ADDRESSCATEGORY   ;
if(vcount>1) then
select  min(ADDRESSID)  into  vaddressid  from  CRMUSER.address where bank_id='43' and  ORGKEY=i.orgkey  and ADDRESSCATEGORY=i.ADDRESSCATEGORY ;
INSERT INTO custom.address_duplicates select *   from CRMUSER.ADDRESS where bank_id='43'  and  ORGKEY =i.orgkey   and ADDRESSCATEGORY=i.ADDRESSCATEGORY  and ADDRESSID = vaddressid;
commit;
delete CRMUSER.address where bank_id='43'  and  ORGKEY =i.orgkey   and ADDRESSCATEGORY=i.ADDRESSCATEGORY  and ADDRESSID = vaddressid;
update   custom.address_duplicate_drc set ENTITY_CRE_FLG ='XX' where  foracid = i.orgkey   and CUST_PREF=i.ADDRESSCATEGORY;
commit;
end if;
end loop;
end;
/
commit;
/
exit;
/

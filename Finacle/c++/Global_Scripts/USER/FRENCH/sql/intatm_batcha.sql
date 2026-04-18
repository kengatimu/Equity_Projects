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

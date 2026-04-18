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

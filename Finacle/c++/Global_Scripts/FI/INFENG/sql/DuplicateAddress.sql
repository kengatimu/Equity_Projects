---------------------------------------------------------------------------------
--    File Name                  : DuplicateAddress.sql 
--    Tables Used                : CRMUSER.address,custom.address_duplicates
--    Date                       : 04-06-2021
--    Author                     : IRUNGU JAMES 
--    Assumptions                : NA
--    Modification History    :
--	<Serial No.>	<Date>		<Author Name>		<Description>
--	1.		04-06-2021	IRUNGU JAMES		Original Version
-----------------------------------------------------------------------------------


declare
vcount number;
vaddressid number;
cursor c1 is select orgkey, ADDRESSCATEGORY ,count (*)   from CRMUSER.ADDRESS where bank_id ='&1' and orgkey = '&2'   having  count (*) > 1 group by orgkey, ADDRESSCATEGORY;
begin
for i in c1 loop
select  count(*) into  vcount from  CRMUSER.address where bank_id='&1' and  ORGKEY=i.orgkey and ADDRESSCATEGORY=i.ADDRESSCATEGORY   ;
if(vcount>1) then
select  min(ADDRESSID)  into  vaddressid  from  CRMUSER.address where bank_id='&1' and  ORGKEY=i.orgkey  and ADDRESSCATEGORY=i.ADDRESSCATEGORY ;
INSERT INTO custom.address_duplicates select *   from CRMUSER.ADDRESS where bank_id='&1'  and  ORGKEY =i.orgkey   and ADDRESSCATEGORY=i.ADDRESSCATEGORY  and ADDRESSID = vaddressid;
commit;
delete CRMUSER.address where bank_id='&1'  and  ORGKEY =i.orgkey   and ADDRESSCATEGORY=i.ADDRESSCATEGORY  and ADDRESSID = vaddressid;
commit;
end if;
end loop;
end;
/
commit;
/
exit
/
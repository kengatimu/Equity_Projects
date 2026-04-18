---------------------------------------------------------------------------------
--    File Name                  : FPC.sql 
--    Tables Used                : CRMUSER.Tradefinance
--    Date                       : 12-10-2022
--    Author                     : IRUNGU JAMES 
--    Assumptions                : NA
--    Modification History    :
--	<Serial No.>	<Date>		<Author Name>		<Description>
--	1.		12-10-2022	IRUNGU JAMES		Original Version
-----------------------------------------------------------------------------------


declare
vhome   number;
cursor c1 is   select ORGKEY, ACCOUNTID, CORE_CUST_ID,BANK_ID, NAME  from   CRMUSER.accounts a where bank_id ='&1' and orgkey not in (select cif_id from crmuser.fpc where bank_id ='&1')
 and  ENTITY_CRE_FLAG ='Y' and CORP_ID is null and  RECORDSTATUS ='A' and SUSPENDED ='N'  and  orgkey not in (select ORGKEY from crmuser.ACCOUNTS_MOD where bank_id ='&1') 
 and bank_id ='&1'and orgkey ='&2';
  begin
 for i in c1 loop
update CRMUSER.ACCOUNTS SET TFPARTYFLAG ='Y' WHERE  orgkey =i.ORGKEY  ;
COMMIT;
Insert into CRMUSER.TRADEFINANCE   (TRADE_FINANCE_ID, BANK_ID, INLAND_TRADE_ALLOWED, CUST_NATIVE, DEL_FLG, CORE_CUST_ID, BODATECREATED, BOCREATEDBY, BODATEMODIFIED, BOMODIFIEDBY, 
   CONCURDETECT_X, SECURITYILHINT, SECURITYIUHINT, SECURITYGLHINT, SECURITYGUHINT, ACCOUNTID, ENTITY_CRE_FLG, ORGKEY,NAME, TMDATE)
 Values
   (crmuser.TRADE_FINANCE_ID.nextval, i.BANK_ID,  'Y', 'Y', 'N', i.CORE_CUST_ID , sysdate , 426250,sysdate , 426250, 3, 0, 0, 0, 0, i.ACCOUNTID, 'Y', i.ORGKEY , i.NAME ,sysdate);
COMMIT;
end loop;
end;
/
commit;
/
exit
/
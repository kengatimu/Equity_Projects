---------------------------------------------------------------------------------
--    File Name                  : FPCCOPR.sql 
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
cursor c1 is   select CORP_ID, CORE_CUST_ID,STATE,BANK_ID,  CITY, COUNTRY,name, orgkey from CRMUSER.accounts a where bank_id ='&1'
and orgkey not in (select cif_id from crmuser.fpc where bank_id ='&1') and orgkey ='&2' and  ENTITY_CRE_FLAG ='Y' and CORP_ID is not null
and  RECORDSTATUS ='A' and SUSPENDED ='N'  and  orgkey not in (select corp_key from crmuser.corporate_mod where bank_id ='&1') and bank_id ='&1';
 begin
for i in c1 loop
update CRMUSER.ACCOUNTS SET TFPARTYFLAG ='Y' WHERE  orgkey =i.orgkey  ;
COMMIT;
Insert into CRMUSER.TRADEFINANCE
   (TRADE_FINANCE_ID, BANK_ID, CORP_ID, DC_MARGINPERCENTAGE, CRNCY_CODE, INDIVIDUALCORPFLAG, STATE_DESC, CORPORATE_NAME, DEL_FLG, CITY, CORE_CUST_ID,
   BODATECREATED, BOCREATEDBY, BODATEMODIFIED, BOMODIFIEDBY, CONCURDETECT_X, SECURITYILHINT, SECURITYIUHINT, SECURITYGLHINT, SECURITYGUHINT, CNTRY_DESC,
   CUST_FLG, ENTITY_CRE_FLG, ORGKEY, NAME, TMDATE)
 Values
   (crmuser.TRADE_FINANCE_ID.nextval , i.BANK_ID, i.CORP_ID, 0, 'CDF', 'C', i.STATE, i.name , 'N', i.CITY , i.CORE_CUST_ID ,
   sysdate, 426250, sysdate , 426250, 2, 0, 0, 0, 0, i.COUNTRY, 
   'Y', 'Y', i.orgkey , i.name , sysdate );
commit;
end loop;
end;
/
commit;
/
exit
/
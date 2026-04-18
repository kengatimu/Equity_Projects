---------------------------------------------------------------------------------
--    File Name                  : MissedCharges.sql 
--    Tables Used                : DTD,HTD,SOL,c_ctdt
--    Date                       : 21-March_2021
--    Author                     : IRUNGU JAMES 
--    Assumptions                : NA
--    Modification History    :
--	<Serial No.>	<Date>		<Author Name>		<Description>
--	1.		21.03.2021	IRUNGU JAMES		Original Version
-----------------------------------------------------------------------------------


INSERT INTO CUSTOM.UNCOLLECTED_CHARGE   select  CHARGE ,  Sol_id,  foracid  , acct_crncy_code , schm_code , schm_type ,  tran_date , tran_id , TRAN_TYPE ,TRAN_SUB_TYPE , TRAN_AMT,TRAN_PARTICULAR,  INSTRMNT_TYPE,
 INSTRMNT_DATE,INSTRMNT_NUM, DTH_INIT_SOL_ID ,sol_desc,  entry_user_id,PSTD_DATE ,null,null,null,CITY_BRNCH , CITY_ACCT ,null,null,null,null,null,null,null,null,null from  (select  'Y' CHARGE ,  Sol_id,  foracid  , acct_crncy_code , schm_code , schm_type ,  tran_date , tran_id , TRAN_TYPE ,TRAN_SUB_TYPE , TRAN_AMT,TRAN_PARTICULAR,  INSTRMNT_TYPE,
 INSTRMNT_DATE,INSTRMNT_NUM, DTH_INIT_SOL_ID ,sol_desc,  entry_user_id,PSTD_DATE ,CITY_BRNCH , CITY_ACCT from   (select (select  CITY  from custom.SOL_CITY_BCDC  where  sol_id = gam.sol_id) CITY_ACCT,     (select  CITY from custom.SOL_CITY_BCDC  where  sol_id = DTH_INIT_SOL_ID) CITY_BRNCH  
, gam.Sol_id,  foracid  , acct_crncy_code , schm_code , schm_type ,  tran_date , tran_id , TRAN_TYPE ,TRAN_SUB_TYPE , TRAN_AMT,TRAN_PARTICULAR,  INSTRMNT_TYPE,INSTRMNT_DATE,INSTRMNT_NUM, DTH_INIT_SOL_ID ,sol_desc,  entry_user_id,PSTD_DATE
from  tbaadm.dtd  a , tbaadm.gam, tbaadm.sol where DTH_INIT_SOL_ID =sol.sol_id and TRAN_date  =  '&2'  and a.bank_id ='43' and  TRAN_SUB_TYPE  ='NP' and gam.acid =a.acid  and   gam.sol_id   in (select sol_id from tbaadm.sst where set_id = '&1')
and schm_type in ('CAA') and gam.bank_id =a.bank_id and  ( tran_id ,tran_date,foracid )  not in (select parent_tran_id,parent_tran_date,foracid   from  tbaadm.gam,  custom.c_ctdt  where PARENT_TRAN_date = '&2' and sol_id  in (select sol_id from tbaadm.sst where set_id ='&1')
and acct_id =foracid )  and ACCT_CRNCY_CODE !='CDF'  and schm_code not in ('CA790','CA290') ) ) ; 
commit;
UPDATE CUSTOM.UNCOLLECTED_CHARGE set  CHARGE_EVENTID ='CWNOINSTR' where  INSTRMNT_TYPE is null and  processed is null;
commit;
UPDATE CUSTOM.UNCOLLECTED_CHARGE set  CHARGE_EVENTID ='CWINSTSC' where  INSTRMNT_TYPE is not null and  processed is null;
Commit;
update CUSTOM.UNCOLLECTED_CHARGE  set  ROW_NUM =rownum where sol_id = '&1' and  processed is null;
Commit;

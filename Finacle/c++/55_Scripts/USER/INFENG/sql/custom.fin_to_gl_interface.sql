DROP PACKAGE CUSTOM.FIN_TO_GL_INTERFACE;

CREATE OR REPLACE PACKAGE CUSTOM.FIN_TO_GL_INTERFACE AS
PROCEDURE INSERT_INTO_DAILY_MOVEMENTS(vBankId VARCHAR2) ;
PROCEDURE INSERT_INTO_STAGING(vBankId VARCHAR2) ;
procedure validate_account(v_foracid in varchar2, v_out_name OUT VARCHAR2,vBankId VARCHAR2); 
procedure get_last_bankers_cheque_used(v_sol_id in varchar2, v_Cheque_no OUT VARCHAR2,vBankId VARCHAR2);
procedure get_ap_cheque_status_from_fin(v_sol_id IN varchar2,v_cheque  IN varchar2, v_status OUT VARCHAR2,vBankId VARCHAR2);
PROCEDURE INSERT_INTO_RATES_STAGING (p_rate_type in varchar2,vBankId VARCHAR2);
procedure validate_employee_account(v_emp_id in varchar2, v_account in varchar2,v_emp_id_out OUT varchar2,vBankId VARCHAR2);
END FIN_TO_GL_INTERFACE;
/


DROP SYNONYM ERPGL.FIN_TO_GL_INTERFACE;

CREATE SYNONYM ERPGL.FIN_TO_GL_INTERFACE FOR CUSTOM.FIN_TO_GL_INTERFACE;


GRANT EXECUTE ON CUSTOM.FIN_TO_GL_INTERFACE TO CEOD_USERS;

GRANT EXECUTE ON CUSTOM.FIN_TO_GL_INTERFACE TO CUSTOM;

GRANT EXECUTE ON CUSTOM.FIN_TO_GL_INTERFACE TO ERPGL;



DROP PACKAGE BODY CUSTOM.FIN_TO_GL_INTERFACE;

CREATE OR REPLACE PACKAGE BODY CUSTOM.FIN_TO_GL_INTERFACE
AS
PROCEDURE INSERT_INTO_DAILY_MOVEMENTS(vBankId VARCHAR2)  IS
vAcctDate date;
vUserID varchar2(50);
        --, STATUS, ERROR_CODE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE,LAST_UPDATED_BY
        
cursor  cu1 is
select tran_date ,value_date, BRANCH, DEPARTMENT,ACCOUNT1,ACCOUNT2, 
     PRODUCT, CHANNEL,BACID,CUST_ID,tran_crncy_code,gl_sub_head_code,
    AMOUNT ,DECODE(CHARGED_OFF,'Y',CHARGED_OFF,(DECODE(l.foracid,NULL,' ','Y')))CHARGED_OFF
        from     
   (select a.tran_date ,a.value_date,a.acid,a.bank_id,a.sol_id BRANCH,a.ref_num DEPARTMENT,SUBSTR(B.FORACID,4,10)ACCOUNT1,B.SCHM_TYPE ACCOUNT2, 
    B.SCHM_CODE PRODUCT,C.DELIVERY_CHANNEL_ID CHANNEL,B.BACID,A.CUST_ID,a.tran_crncy_code,b.gl_sub_head_code,
    DECODE(PART_TRAN_TYPE,'D',A.TRAN_AMT*-1,A.TRAN_AMT)AMOUNT ,DECODE(SUBSTR(B.FORACID,4,10),'0000100920','Y','') CHARGED_OFF
    from tbaadm.dtd A,tbaadm.GAM B,tbaadm.dTH C where  
    A.ACID=B.ACID AND A.BANK_ID = vBankId AND B.BANK_ID = vBankId AND C.BANK_ID = vBankId AND A.TRAN_DATE=C.TRAN_DATE AND A.TRAN_ID=C.TRAN_ID AND A.tran_date>=vAcctDate and A.tran_date<=vAcctDate 
    and A.del_flg='N')k left join 
        (select a.acid,a.bank_id,b.foracid,b.clr_bal_amt from tbaadm.cot a,tbaadm.gam b where a.acid=b.acid and a.BANK_ID = vBankId and b.BANK_ID = vBankId and CHRGE_OFF_DATE is not null )l on k.acid=l.acid and k.BANK_ID = vBankId AND l.BANK_ID = vBankId;

BEGIN


select  db_stat_date 
into    vAcctDate
from    tbaadm.gct where BANK_ID = vBankId;

select  sys_context('USERENV','SESSION_USER') 
INTO    vUserID
from    dual;


INSERT  INTO CUSTOM.DAILY_MOVEMENTS_HISTORY
SELECT * FROM CUSTOM.DAILY_MOVEMENTS;
COMMIT;

EXECUTE IMMEDIATE 'truncate table CUSTOM.DAILY_MOVEMENTS drop storage';

for i in cu1 loop
INSERT  INTO    DAILY_MOVEMENTS 
        (TRAN_DATE, VALUE_DATE, BRANCH, DEPARTMENT, ACCOUNT1, ACCOUNT2, PRODUCT, CHANNEL, BACID, CUST_ID, TRAN_CRNCY_CODE, 
        GL_SUB_HEAD_CODE, AMOUNT, STATUS, ERROR_CODE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, 
        LAST_UPDATED_BY,CHARGED_OFF )
values  (I.TRAN_DATE, I.VALUE_DATE, I.BRANCH, I.DEPARTMENT, I.ACCOUNT1, I.ACCOUNT2, I.PRODUCT, I.CHANNEL, I.BACID, I.CUST_ID, I.TRAN_CRNCY_CODE, 
        I.GL_SUB_HEAD_CODE, I.AMOUNT, 'U','', SYSDATE, vUserID, SYSDATE, 11, I.CHARGED_OFF);

 END LOOP;

--COMMIT; 
 
END INSERT_INTO_DAILY_MOVEMENTS;


PROCEDURE INSERT_INTO_STAGING(vBankId VARCHAR2)  IS
vAcctDate date;
vUserID varchar2(50);
net_diff number;
written_off_diff number;
diff_amount number;
cust_written_off_diff number;
a_amount number;
errorCode varchar2(150 byte);
s_number number;

--OFFICE
cursor cu1 is
select  
'FINACLE'SOURCE,TO_CHAR(TRAN_date,'DD-MON-YYYY')TRAN_DATE,'EBFIN'COMPANY,branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT,vBankId),'DEFAULT')DEPARTMENT,
DECODE(gl_sub_head_code,'30011','30011','30013','30013','30012','30012',account1)ACCOUNT,
DECODE(gl_sub_head_code,'80001',ACCOUNT1,'80002',ACCOUNT1,'80003',ACCOUNT1,'60001',ACCOUNT1,
'60002',ACCOUNT1,'60003',ACCOUNT1,'60004',ACCOUNT1,'60005',ACCOUNT1,'60006',ACCOUNT1,'DEFAULT')product,
DECODE(CHANNEL,NULL,'DEFAULT',CHANNEL)CHANNEL,DECODE(GL_SUB_HEAD_CODE,'30016',ACCOUNT1,'13006',ACCOUNT1,'DEFAULT') INTERCOMPANY,' 'SEGMENT8,''SEGMENT9,''SEGMENT10,''SEGMENT11,''SEGMENT12,
TRAN_CRNCY_CODE ACCT_CRNCY,''EXCHANGE_RATE,DECODE(TRAN_CRNCY_CODE,'KES','','Corporate')EXCHANGE_RATE_TYPE,
''JOURNAL_SOURCE, ''JOURNAL_TYPE,
DECODE(SUBSTR(SUM(AMOUNT),1,1),'-',SUM(AMOUNT)*-1,0)DR,DECODE(SUBSTR(SUM(AMOUNT),1,1),'-',0,SUM(AMOUNT))CR,
 ''MESSAGE,'N'STATUS,''ERROR_CODE,CREATED_BY,
LAST_UPDATED_BY,''LEDGER_NAME, CHARGED_OFF
 from CUSTOM.daily_movements
WHERE ACCOUNT2 NOT IN ('CAA','SBA','LAA','FBA','TDA') 
AND NVL(BACID,'X') <>'ISO'
GROUP BY TO_CHAR(TRAN_date,'DD-MON-YYYY'),branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT,vBankId),'DEFAULT'),
DECODE(gl_sub_head_code,'30011','30011','30013','30013','30012','30012',account1),
CHANNEL,DECODE(GL_SUB_HEAD_CODE,'30016',ACCOUNT1,'13006',ACCOUNT1,'DEFAULT'),TRAN_CRNCY_CODE,DECODE(gl_sub_head_code,'80001',ACCOUNT1,'80002',ACCOUNT1,'80003',ACCOUNT1,'60001',ACCOUNT1,
'60002',ACCOUNT1,'60003',ACCOUNT1,'60004',ACCOUNT1,'60005',ACCOUNT1,'60006',ACCOUNT1,'DEFAULT'),CREATED_BY,LAST_UPDATED_BY,CHARGED_OFF
UNION all
-- CUSTOMER
select 'FINACLE'SOURCE,TO_CHAR(TRAN_date,'DD-MON-YYYY')TRAN_DATE,'EBFIN'COMPANY,branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT,vBankId),'DEFAULT') DEPARTMENT,decode(CHARGED_OFF,'Y','OBA',account2) ACCOUNT,product,
DECODE(CHANNEL,NULL,'FAB',CHANNEL)CHANNEL,'DEFAULT' INTERCOMPANY,' 'SEGMENT8,''SEGMENT9,''SEGMENT10,''SEGMENT11,''SEGMENT12
,TRAN_CRNCY_CODE ACCT_CRNCY,
''EXCHANGE_RATE,DECODE(TRAN_CRNCY_CODE,'KES','','Corporate')EXCHANGE_RATE_TYPE,
''JOURNAL_SOURCE, ''JOURNAL_TYPE,
DECODE(SUBSTR(SUM(AMOUNT),1,1),'-',SUM(AMOUNT)*-1,0)DR,DECODE(SUBSTR(SUM(AMOUNT),1,1),'-',0,SUM(AMOUNT))CR,
 ''MESSAGE,'N'STATUS,''ERROR_CODE,CREATED_BY,
LAST_UPDATED_BY,''LEDGER_NAME, CHARGED_OFF
 from CUSTOM.daily_movements
WHERE ACCOUNT2 IN ('CAA','SBA','LAA','FBA','TDA')
GROUP BY TO_CHAR(TRAN_date,'DD-MON-YYYY'),branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT,vBankId),'DEFAULT'),
decode(CHARGED_OFF,'Y','OBA',account2),PRODUCT,CHANNEL,TRAN_CRNCY_CODE,CREATED_BY,LAST_UPDATED_BY,CHARGED_OFF;

BEGIN

select  db_stat_date 
into    vAcctDate
from    tbaadm.gct where BANK_ID = vBankId ;

select  sys_context('USERENV','SESSION_USER') 
INTO    vUserID
from    dual;



net_diff :=0;
written_off_diff :=0;
diff_amount :=0;
cust_written_off_diff :=0;
a_amount :=0;

for j in cu1 loop
INSERT  INTO CUSTOM.FIN_ORACLE_STAGING
        (SOURCE, ACCT_DATE, COMPANY, SOL_ID, DEPARTMENT, FORACID, PRODUCT, CHANNEL, INTERCOMPANY, SEGMENT8, 
        SEGMENT9, SEGMENT10, SEGMENT11, SEGMENT12,ACCT_CURNCY, EXCHANGE_RATE, EXCHANGE_RATE_TYPE,
        JOURNAL_SOURCE, JOURNAL_TYPE, DEBIT, CREDIT, MESSAGE, STATUS, ERROR_CODE, CREATION_DATE, CREATED_BY, 
        LAST_UPDATE_DATE, LAST_UPDATED_BY, LEDGER_NAME,CHARGED_OFF)
VALUES  (j.SOURCE,J.TRAN_DATE,J.COMPANY, J.BRANCH,J.DEPARTMENT, J.ACCOUNT, J.PRODUCT, J.CHANNEL, J.INTERCOMPANY, J.SEGMENT8, J.SEGMENT9, J.SEGMENT10,
        J.SEGMENT11, J.SEGMENT12, J.ACCT_CRNCY, J.EXCHANGE_RATE, J.EXCHANGE_RATE_TYPE, J.JOURNAL_SOURCE, J.JOURNAL_TYPE, J.DR, J.CR, J.MESSAGE, 
        J.STATUS, J.ERROR_CODE, SYSDATE, vUserID, SYSDATE,11, J.LEDGER_NAME ,J.CHARGED_OFF );    
END LOOP;
--COMMIT;


update DAILY_MOVEMENTS 
set status='P';
--commit;


select nvl(sum(debit)-sum(credit),0)
into net_diff
from CUSTOM.FIN_ORACLE_STAGING
where ACCT_DATE =vAcctDate
and charged_off!='O';

select nvl(sum(credit)-sum(debit),0)
into written_off_diff
from CUSTOM.FIN_ORACLE_STAGING
where ACCT_DATE =vAcctDate
and charged_off='Y'
and foracid='0000100920';

select nvl(sum(credit)-sum(debit),0)
into cust_written_off_diff
from CUSTOM.FIN_ORACLE_STAGING
where ACCT_DATE =vAcctDate
and charged_off='Y'
and foracid!='0000100920';

select  written_off_diff  + cust_written_off_diff 
into diff_amount
from dual;

select net_diff - diff_amount
into a_amount
from dual;

select SIGN(net_diff) into s_number from dual;

    if  net_diff <100 then
       
       IF  s_number = -1 THEN
            Insert into CUSTOM.FIN_ORACLE_STAGING
            (SOURCE, ACCT_DATE, COMPANY, SOL_ID, DEPARTMENT, FORACID, PRODUCT, CHANNEL, INTERCOMPANY, ACCT_CURNCY, DEBIT, CREDIT, MESSAGE, STATUS, ERROR_CODE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY, PROCESS_ID)
            Values
            ('FINACLE', vAcctDate, 'EBFIN', '000', 'DEFAULT', '18306', 'DEFAULT', 'DEFAULT', 'DEFAULT', 'KES', abs(net_diff), 0, '', 'N', '.4', vAcctDate, vUserID, vAcctDate, 11, 1037676);
            COMMIT;
       ELSE
            IF s_number = 1 THEN
            
            Insert into CUSTOM.FIN_ORACLE_STAGING
            (SOURCE, ACCT_DATE, COMPANY, SOL_ID, DEPARTMENT, FORACID, PRODUCT, CHANNEL, INTERCOMPANY, ACCT_CURNCY, DEBIT, CREDIT, MESSAGE, STATUS, ERROR_CODE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY, PROCESS_ID)
            Values
            ('FINACLE', vAcctDate, 'EBFIN', '000', 'DEFAULT', '18306', 'DEFAULT', 'DEFAULT', 'DEFAULT', 'KES',0 ,abs(net_diff), '', 'N', '.4', vAcctDate, vUserID, vAcctDate, 11, 1037676);
            COMMIT;
            
            END IF;
    END IF;

  end if;


------
if  a_amount=0  AND  diff_amount =0 then

                
        update  CUSTOM.FIN_ORACLE_STAGING
              set status='I', message='PROCESSED IN FINACLE' WHERE ACCT_DATE=vAcctDate;
  else 
        update  CUSTOM.FIN_ORACLE_STAGING 
        set     status='I',message='DR AND CR IMBALANCE', error_code=a_amount WHERE ACCT_DATE=vAcctDate;
END IF;
------
if diff_amount!=0 then
           update  CUSTOM.FIN_ORACLE_STAGING 
           set     status='I',message='CHARGE OFF IMBALANCE', error_code=diff_amount WHERE ACCT_DATE=vAcctDate;
END IF;

 --- commit;
END INSERT_INTO_STAGING;
---
--AP VALIDATE FINACLE ACCOUNT

procedure validate_account(v_foracid in varchar2, v_out_name OUT VARCHAR2,vBankId VARCHAR2) as
begin
select acct_name 
into v_out_name
from tbaadm.gam
where foracid=v_foracid
and acct_cls_flg !='Y'
and del_flg ='N'
and gam.BANK_ID = vBankId ;
exception
when no_data_found then
v_out_name :='Account not found';

END validate_account;

--ADDDED BY TIMO
procedure get_ap_cheque_status_from_fin(v_sol_id IN varchar2,v_cheque  IN varchar2, v_status OUT VARCHAR2,vBankId VARCHAR2) as
v_dd_date DATE;
begin
select MAX(DD_STATUS_DATE),dd_status 
into v_dd_date,v_status 
from tbaadm.dst 
where trim(dd_num)=v_cheque 
and issu_br_code=v_sol_id
and dst.BANK_ID = vBankId 
GROUP BY DD_NUM ,DD_STATUS;
exception
when no_data_found then
v_status :='CHQ NOT MAINTAINED';
END get_ap_cheque_status_from_fin; 


procedure get_last_bankers_cheque_used(v_sol_id in varchar2, v_Cheque_no OUT VARCHAR2,vBankId VARCHAR2) as
begin
select trim(max(dd_num+1)) 
into v_Cheque_no
from tbaadm.dst
where ISSU_BR_CODE=v_sol_id and dst.BANK_ID = vBankId ;

exception
when no_data_found then
v_Cheque_no :='0';
END get_last_bankers_cheque_used; 

/**PROCEDURE INSERT_INTO_RATES_STAGING  AS
vAcctDate date ;
vUserID varchar2(50);
v_from varchar2(50);
v_to varchar2(50);
v_id varchar2(50);
v_rate varchar2(50);
v_rate_type varchar2(50);


    
    cursor pick_current_rates
    is
   SELECT    b.FXD_CRNCY_CODE "FROM_CURR" ,b.VAR_CRNCY_CODE "TO_CURR" ,TO_CHAR(b.RTLIST_DATE,'DD-MON-YYYY') "START_DATE" ,
        TO_CHAR(b.RTLIST_DATE,'DD-MON-YYYY') "END_DATE" , decode(b.RATECODE,'REVAL','CORPORATE','TTS','SPOT')"RATE_TYPE" ,
        B.VAR_CRNCY_UNITS "RATE",
        b.RTLIST_NUM "VERSION"
        FROM RTL b,
            (SELECT VAR_CRNCY_CODE,FXD_CRNCY_CODE,RTLIST_DATE,MAX(RTLIST_NUM)TEST FROM RTL 
            WHERE ( VAR_CRNCY_CODE='KES' OR FXD_CRNCY_CODE='KES')
             AND RTLIST_DATE=vAcctDate
             AND RATECODE ='REVAL' 
             GROUP BY VAR_CRNCY_CODE,FXD_CRNCY_CODE,RTLIST_DATE)C
             where b.FXD_CRNCY_CODE=c.FXD_CRNCY_CODE 
             AND b.VAR_CRNCY_CODE=c.VAR_CRNCY_CODE 
             AND b.RTLIST_DATE=c.RTLIST_DATE 
             AND b.RTLIST_NUM=c.TEST 
             AND b.RATECODE ='REVAL';
    
   Cursor insert_rates IS 
    select PROCESS_ID, FROM_CURR, TO_CURR, START_DATE, END_DATE, RATE_TYPE "TYPE", RATE, CREATED_BY, CREATION_DATE, 
    LAST_UPDATED_BY, LAST_UPDATE_DATE, PROCESSED_FLAG, ERROR_CODE, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3
    from CUSTOM.FIN_DAILY_RATE
    where PROCESSED_FLAG ='I';
    
BEGIN


select  db_stat_date 
into    vAcctDate
from    tbaadm.gct;

select  sys_context('USERENV','SESSION_USER') 
INTO    vUserID
from    dual;


EXECUTE IMMEDIATE 'truncate table CUSTOM.FIN_DAILY_RATE drop storage';

for I in pick_current_rates
loop

    INSERT INTO CUSTOM.FIN_DAILY_RATE
    ( FROM_CURR, TO_CURR, START_DATE, END_DATE, RATE_TYPE, RATE, VERSION, CREATED_BY, 
    CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, PROCESSED_FLAG, ERROR_CODE, ATTRIBUTE1,
     ATTRIBUTE2, ATTRIBUTE3) 
     VALUES
     ( I.FROM_CURR, I.TO_CURR, I.START_DATE, I.END_DATE, I.RATE_TYPE, I.RATE, I.VERSION, vUserID,  SYSDATE, 
     vUserID, SYSDATE, 'N', '', '','', '');
     
end loop;
COMMIT;

select FROM_CURR,TO_CURR,process_id,RATE_TYPE,RATE into v_from,v_to,v_id,v_rate_type,v_rate from CUSTOM.FIN_DAILY_RATE
 where FROM_CURR='JPY' and TO_CURR='KES' AND RATE_TYPE='CORPORATE';
 
 V_RATE :=TBAADM.CommonPackage.getConvRate(v_from,v_to,v_rate,vAcctDate);
 
UPDATE CUSTOM.FIN_DAILY_RATE SET RATE=V_RATE  WHERE FROM_CURR ='JPY' AND TO_CURR='KES' AND PROCESS_ID= v_id;

update CUSTOM.FIN_DAILY_RATE set PROCESSED_FLAG='I';
COMMIT;

begin
for I in insert_rates loop
insert into xxgl.XXGL_DAILY_RATE@ERP_LINK
( FROM_CURR, TO_CURR, START_DATE, END_DATE, TYPE, RATE, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, 
LAST_UPDATE_DATE, PROCESSED_FLAG, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3)
values
(i.FROM_CURR, i.TO_CURR, i.START_DATE, i.END_DATE, i.TYPE, i.RATE, -1, sysdate, -1, 
SYSDATE, 'N', i.ATTRIBUTE1, i.ATTRIBUTE2, i.ATTRIBUTE3);
end loop;
COMMIT;
END;


END INSERT_INTO_RATES_STAGING;

**/

PROCEDURE INSERT_INTO_RATES_STAGING (p_rate_type in varchar2,vBankId VARCHAR2) AS
vAcctDate date ;
vUserID varchar2(50);
v_from varchar2(50);
v_to varchar2(50);
v_id varchar2(50);
v_rate varchar2(50);
v_rate_type varchar2(50);


    
    cursor pick_current_rates
    is
   SELECT   b.FXD_CRNCY_CODE "FROM_CURR" ,b.VAR_CRNCY_CODE "TO_CURR" ,TO_CHAR(b.RTLIST_DATE,'DD-MON-YYYY') "START_DATE" ,
        TO_CHAR(b.RTLIST_DATE,'DD-MON-YYYY') "END_DATE" , decode(b.RATECODE,'REVAL','Corporate','MEAN','1000','TTS','Spot')"RATE_TYPE" ,
       -- TBAADM.CommonPackage.getConvRate(b.FXD_CRNCY_CODE,b.VAR_CRNCY_CODE,B.VAR_CRNCY_UNITS,TO_CHAR(b.RTLIST_DATE,'DD-MON-YYYY')) "RATE",
       VAR_CRNCY_UNITS "RATE",
        b.RTLIST_NUM "VERSION"
        FROM tbaadm.RTL b,
            (SELECT VAR_CRNCY_CODE,FXD_CRNCY_CODE,RTLIST_DATE,MAX(RTLIST_NUM)TEST FROM TBAADM.RTL
            WHERE ( VAR_CRNCY_CODE='KES' OR FXD_CRNCY_CODE='KES')
             AND RTLIST_DATE=vAcctDate
             AND RATECODE = decode(P_RATE_TYPE,'Corporate','REVAL','1000','MEAN','Spot','TTS') 
             GROUP BY VAR_CRNCY_CODE,FXD_CRNCY_CODE,RTLIST_DATE)C
             where b.FXD_CRNCY_CODE=c.FXD_CRNCY_CODE 
             AND b.VAR_CRNCY_CODE=c.VAR_CRNCY_CODE 
             AND b.RTLIST_DATE=c.RTLIST_DATE 
             AND b.RTLIST_NUM=c.TEST 
             AND b.RATECODE  =decode(P_RATE_TYPE,'Corporate','REVAL','1000','MEAN','Spot','TTS')
             AND b.BANK_ID = vBankId  ;
             
BEGIN

select  db_stat_date  
into    vAcctDate
from    tbaadm.gct where BANK_ID = vBankId ;

--vAcctDate:='20-JAN-2012';

select  sys_context('USERENV','SESSION_USER') 
INTO    vUserID
from    dual;


EXECUTE IMMEDIATE 'truncate table CUSTOM.FIN_DAILY_RATE drop storage';

for I in pick_current_rates
loop

    INSERT INTO CUSTOM.FIN_DAILY_RATE
    ( FROM_CURR, TO_CURR, START_DATE, END_DATE, RATE_TYPE, RATE, VERSION, CREATED_BY, 
    CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE, PROCESSED_FLAG, ERROR_CODE, ATTRIBUTE1,
     ATTRIBUTE2, ATTRIBUTE3) 
     VALUES
     ( I.FROM_CURR, I.TO_CURR, I.START_DATE, I.END_DATE, I.RATE_TYPE, I.RATE, I.VERSION, vUserID,  SYSDATE, 
     -1, SYSDATE, 'N', '', '','', '');
     
end loop;
COMMIT;

update CUSTOM.FIN_DAILY_RATE set PROCESSED_FLAG='I';
COMMIT;
END INSERT_INTO_RATES_STAGING;


procedure validate_employee_account(v_emp_id in varchar2, v_account in varchar2,v_emp_id_out OUT varchar2,vBankId VARCHAR2) as
v_cust_id varchar2(10);
begin
select cmg.cust_emp_id,gam.cust_id
into v_emp_id_out,v_cust_id
from tbaadm.gam,tbaadm.cmg,tbaadm.tba_gen_emp_tbl
where gam.cust_id=cmg.cust_id
and cmg.cust_emp_id=tba_gen_emp_tbl.EMP_ID
and gam.foracid=v_account
AND cmg.cust_emp_id=v_emp_id
and gam.ACCT_CLS_FLG='N'
and tba_gen_emp_tbl.DEL_FLG='N'
and gam.schm_code='SB190'
and cmg.ENTITY_CRE_FLG='Y'
and gam.BANK_ID = vBankId 
and cmg.BANK_ID = vBankId ;
Exception
when others then
v_emp_id_out:='N/A';
END validate_employee_account;

END FIN_TO_GL_INTERFACE;
/


DROP SYNONYM ERPGL.FIN_TO_GL_INTERFACE;

CREATE SYNONYM ERPGL.FIN_TO_GL_INTERFACE FOR CUSTOM.FIN_TO_GL_INTERFACE;


GRANT EXECUTE ON CUSTOM.FIN_TO_GL_INTERFACE TO CEOD_USERS;

GRANT EXECUTE ON CUSTOM.FIN_TO_GL_INTERFACE TO CUSTOM;

GRANT EXECUTE ON CUSTOM.FIN_TO_GL_INTERFACE TO ERPGL;




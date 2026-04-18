DROP PROCEDURE CUSTOM.INSERT_INTO_STAGING_B;

CREATE OR REPLACE PROCEDURE CUSTOM.INSERT_INTO_STAGING_B(vBankId VARCHAR2)  IS
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
'FINACLE'SOURCE,TO_CHAR(TRAN_date,'DD-MON-YYYY')TRAN_DATE,'EBFIN'COMPANY,branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT),'DEFAULT')DEPARTMENT,
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
GROUP BY TO_CHAR(TRAN_date,'DD-MON-YYYY'),branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT),'DEFAULT'),
DECODE(gl_sub_head_code,'30011','30011','30013','30013','30012','30012',account1),
CHANNEL,DECODE(GL_SUB_HEAD_CODE,'30016',ACCOUNT1,'13006',ACCOUNT1,'DEFAULT'),TRAN_CRNCY_CODE,DECODE(gl_sub_head_code,'80001',ACCOUNT1,'80002',ACCOUNT1,'80003',ACCOUNT1,'60001',ACCOUNT1,
'60002',ACCOUNT1,'60003',ACCOUNT1,'60004',ACCOUNT1,'60005',ACCOUNT1,'60006',ACCOUNT1,'DEFAULT'),CREATED_BY,LAST_UPDATED_BY,CHARGED_OFF
UNION all
-- CUSTOMER
select 'FINACLE'SOURCE,TO_CHAR(TRAN_date,'DD-MON-YYYY')TRAN_DATE,'EBFIN'COMPANY,branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT),'DEFAULT') DEPARTMENT,decode(CHARGED_OFF,'Y','OBA',account2) ACCOUNT,product,
DECODE(CHANNEL,NULL,'FAB',CHANNEL)CHANNEL,'DEFAULT' INTERCOMPANY,' 'SEGMENT8,''SEGMENT9,''SEGMENT10,''SEGMENT11,''SEGMENT12
,TRAN_CRNCY_CODE ACCT_CRNCY,
''EXCHANGE_RATE,DECODE(TRAN_CRNCY_CODE,'KES','','Corporate')EXCHANGE_RATE_TYPE,
''JOURNAL_SOURCE, ''JOURNAL_TYPE,
DECODE(SUBSTR(SUM(AMOUNT),1,1),'-',SUM(AMOUNT)*-1,0)DR,DECODE(SUBSTR(SUM(AMOUNT),1,1),'-',0,SUM(AMOUNT))CR,
 ''MESSAGE,'N'STATUS,''ERROR_CODE,CREATED_BY,
LAST_UPDATED_BY,''LEDGER_NAME, CHARGED_OFF
 from CUSTOM.daily_movements
WHERE ACCOUNT2 IN ('CAA','SBA','LAA','FBA','TDA')
GROUP BY TO_CHAR(TRAN_date,'DD-MON-YYYY'),branch,decode(branch,'000',RETURN_COST_CENTER(DEPARTMENT),'DEFAULT'),
decode(CHARGED_OFF,'Y','OBA',account2),PRODUCT,CHANNEL,TRAN_CRNCY_CODE,CREATED_BY,LAST_UPDATED_BY,CHARGED_OFF;

BEGIN

--select  db_stat_date 
--into    vAcctDate
--from    gct;
vAcctDate := '31-JAN-2012';

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
and status<>'I'
and charged_off!='O';

select nvl(sum(credit)-sum(debit),0)
into written_off_diff
from CUSTOM.FIN_ORACLE_STAGING
where ACCT_DATE =vAcctDate
and charged_off='Y'
and foracid='0000100920'
and status<>'I';

select nvl(sum(credit)-sum(debit),0)
into cust_written_off_diff
from CUSTOM.FIN_ORACLE_STAGING
where ACCT_DATE =vAcctDate
and charged_off='Y'
and foracid!='0000100920'
and status<>'I';

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
              set status='I', message='PROCESSED IN FINACLE' WHERE ACCT_DATE=vAcctDate
              and status<>'I';
  else 
        update  CUSTOM.FIN_ORACLE_STAGING 
        set     status='I',message='DR AND CR IMBALANCE', error_code=a_amount WHERE ACCT_DATE=vAcctDate
and status<>'I' ;
END IF;
------
if diff_amount!=0 then
           update  CUSTOM.FIN_ORACLE_STAGING 
           set     status='I',message='CHARGE OFF IMBALANCE', error_code=diff_amount WHERE ACCT_DATE=vAcctDate
           and status<>'I';
END IF;

 --- commit;
END INSERT_INTO_STAGING_B;
/

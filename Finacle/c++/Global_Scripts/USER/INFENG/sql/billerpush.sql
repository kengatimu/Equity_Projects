/
declare
cursor c1 is 
select BILLER_ID,substr(BILLER_NAME,0,59) BILLER_NAME,FREE_TEXT1,FREE_TEXT4,FREE_TEXT5,BANK_ID from tbaadm.brgt where FREE_CODE3='POL'  and BILLER_ID not  in
( select SERVICE_CODE  from  PYMNTS_eq.SERVICE_CODE_MASTER@POLARISLINK.EBSAFRICA.COM  );
begin
for i in c1 loop
    MERGE INTO PYMNTS_eq.SERVICE_CODE_MASTER@POLARISLINK.EBSAFRICA.COM  A USING DUAL ON (A.SERVICE_CODE = i.BILLER_ID AND a.UNIT_ID =i.BILLER_ID)
WHEN NOT MATCHED THEN
  INSERT
    (
      A.SERVICE_CODE,
      A.SERVICE_NAME,
      A.ENQU_MODE,
      A.SETTLEMENT_DETAIL,
      A.ALERT_FREQUENT,
      A.PMT_MODE,
      A.TRAN_ID,
      A.PROVIDER,
      A.DISPLAY_FLAG,
      A.UNIT_ID,
      A.VALTYPE,
      A.LST_UPDATE_TIME,
      A.MAKER_ID,
      a.MAKER_DATE,
      A.CHECKER_ID,
      A.CHECKER_DATE,
      A.STATUS,
      A.CHNG_COUNT,
      A.SERVICE_CODE2
    )
    VALUES
    (
      i.BILLER_ID,
      i.BILLER_NAME,
      'Y',
      i.FREE_TEXT1,
      'W',
      'Y',
      '',
      '',
      'Y',
      i.BANK_ID,
      i.FREE_TEXT4,
      SYSDATE,
      'SYSTEM',
      SYSDATE,
      'SYSTEM',
      SYSDATE,
      'O',
      0,
      i.FREE_TEXT5
    )
    WHEN MATCHED THEN
  UPDATE
  SET A.SERVICE_NAME    = i.BILLER_NAME,
    A.VALTYPE           = i.FREE_TEXT4,
    A.SETTLEMENT_DETAIL = i.FREE_TEXT1,
    A.LST_UPDATE_TIME   = SYSDATE,
    A.MAKER_DATE        = SYSDATE,
    A.CHECKER_DATE      = SYSDATE,
    A.STATUS            = 'O',
    A.CHNG_COUNT        = A.CHNG_COUNT+1,
    A.SERVICE_CODE2     =i.FREE_TEXT5;
commit;
end loop;
end;
/
commit;
/
commit;
/
exit
/

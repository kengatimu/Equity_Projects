DROP PACKAGE CUSTOM.OCLGIRPT_PACK_TZ;

CREATE OR REPLACE PACKAGE CUSTOM.OCLGIRPT_PACK_TZ AS
PROCEDURE OCLGIRPT_PROC_TZ(inp_str IN varchar2,
    out_retcode OUT number,
    out_rec out varchar2);
END OCLGIRPT_PACK_TZ;
/


DROP PACKAGE BODY CUSTOM.OCLGIRPT_PACK_TZ;

CREATE OR REPLACE PACKAGE BODY CUSTOM.OCLGIRPT_PACK_TZ AS
    inp_SolId         TBAADM.SOL.SOL_ID%TYPE;
    inp_ZoneDate    TBAADM.OCI.clg_zone_date%TYPE;
    inp_ZoneCode    TBAADM.OCI.clg_zone_code%TYPE;
    inp_BankId     TBAADM.GAM.bank_id%TYPE;
    out_num            varchar2(20);
    out_bankCode    varchar2(20);
    out_brCode        varchar2(20);
    out_payiAcct    varchar2(20);
    out_ccy            varchar2(20);
    out_instId        varchar2(20);
    out_tranCode    varchar2(20);
    out_repCode        varchar2(20);
    out_instAmt        NUMBER(38);
    out_clrZoneDate    varchar2(20);
    out_gamSolId    varchar2(20);
    out_foracid        varchar2(20);
    out_ociSolId    varchar2(20);

    OutArr        TBAADM.basp0099.ArrayType;
---------------------------------------------------------------------------------
--Cursor
---------------------------------------------------------------------------------
CURSOR OCLGIRPT_CURS(inp_SolId varchar2,inp_ZoneDate date,inp_ZoneCode varchar2)
IS
SELECT
    LPAD(0,2,0),
    SUBSTR(OCI.bank_code,1,2),
    SUBSTR(OCI.br_code,1,3),
    LPAD(TRIM(SUBSTR(OCI.paying_acct_id,4,10)),10,'0'),
    DECODE(OCI.crncy_code,'TZS','00','USD','60','EUR','62','00'),
    LPAD(TRIM(SUBSTR(OCI.instrmnt_id,3,8)),6,'0'),
    OCI.tran_code,
    SUBSTR(rep_code,1,1),
    LPAD(TRIM(OCI.instrmnt_amt*100),13,0),
    TO_CHAR(OCI.clg_zone_date+1,'YYYYMMDD'),
    GAM.SOL_ID,
    SUBSTR(GAM.foracid,4),
    OCP.SOL_ID
FROM
    TBAADM.OCI,
    TBAADM.OCP,
    TBAADM.GAM
WHERE
    OCI.sol_id = OCP.sol_id
    AND OCI.clg_zone_date = OCP.clg_zone_date
    AND OCI.clg_zone_code = OCP.clg_zone_code
    AND OCI.set_num = OCP.set_num
    AND GAM.ACID=OCP.acid
    AND OCI.del_flg = 'N'
    AND GAM.del_flg = 'N'
    AND GAM.entity_cre_flg = 'Y'
    AND OCI.del_flg ='N'
    AND OCI.sol_id in (SELECT sol_id
                FROM TBAADM.SST
                WHERE SST.set_id = inp_SolId
                AND del_flg ='N')
    AND OCI.clg_zone_date = inp_ZoneDate
    AND OCI.clg_zone_code = inp_ZoneCode
    AND OCI.bank_id = OCP.bank_id
    AND OCP.bank_id = GAM.bank_id
    AND GAM.bank_id = inp_BankId;
---------------------------------------------------------------
--PROCEDURE BODY
----------------------------------------------------------------
PROCEDURE OCLGIRPT_PROC_TZ(inp_str IN varchar2,
    out_retcode OUT number,
    out_rec out varchar2) AS
BEGIN
    out_retcode:= 0;
    TBAADM.basp0099.formInputArr(inp_str,OutArr);
    inp_SolId:=UPPER(OutArr(0));
    inp_ZoneDate:=TO_DATE(OutArr(1),'DD-MM-YYYY');
    inp_ZoneCode:=UPPER(OutArr(2));
    inp_BankId:=OutArr(3);

IF(not OCLGIRPT_CURS%ISOPEN) THEN
  --{
        OPEN OCLGIRPT_CURS(inp_SolId,inp_ZoneDate,inp_ZoneCode);
  --}
END IF;
---------------------------------------------------------------------
-- Fetch the data from cursor
---------------------------------------------------------------------
FETCH OCLGIRPT_CURS
INTO
    out_num,
    out_bankCode,
    out_brCode,
    out_payiAcct,
    out_ccy,
    out_instId,
    out_tranCode,
    out_repCode,
    out_instAmt,
    out_clrZoneDate,
    out_gamSolId,
    out_foracid,
    out_ociSolId;

IF (OCLGIRPT_CURS%NOTFOUND) THEN
--{
  CLOSE OCLGIRPT_CURS;
  out_retcode :=1;
  return;
--}
END IF;

out_rec := (
    out_num            ||'^'||
    out_bankCode    ||'^'||
    out_brCode        ||'^'||
    out_payiAcct    ||'^'||
    out_ccy            ||'^'||
    out_instId        ||'^'||
    out_tranCode    ||'^'||
    out_repCode        ||'^'||
    out_instAmt        ||'^'||
    out_clrZoneDate    ||'^'||
    out_gamSolId    ||'^'||
    out_foracid        ||'^'||
    out_ociSolId);

END OCLGIRPT_PROC_TZ;
END OCLGIRPT_PACK_TZ;
/





DROP SYNONYM CUSTOM.OCLGIRPT_PACK_TZ1;

CREATE SYNONYM CUSTOM.OCLGIRPT_PACK_TZ1 FOR CUSTOM.OCLGIRPT_PACK_TZ;

GRANT EXECUTE ON CUSTOM.OCLGIRPT_PACK_TZ TO ALLTAB;

GRANT EXECUTE ON CUSTOM.OCLGIRPT_PACK_TZ TO TBAADM;

GRANT EXECUTE ON CUSTOM.OCLGIRPT_PACK_TZ TO TBAGEN;

GRANT EXECUTE ON CUSTOM.OCLGIRPT_PACK_TZ TO TBAUTIL;

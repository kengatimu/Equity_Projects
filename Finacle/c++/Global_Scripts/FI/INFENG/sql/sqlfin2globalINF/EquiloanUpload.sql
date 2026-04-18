SET PAGES 0
SET HEADING OFF
set trims on
set verify off
set feed off
set term off
set linesize 250

col uu  new_value v_userid noprint
col fi  new_value v_file noprint
col fn  new_value v_filename noprint
col tmp  new_value v_tmp noprint

SELECT '&1' tmp FROM DUAL
/
SELECT SUBSTR('&v_tmp',1,INSTR('&v_tmp','/') - 1) uu,SUBSTR('&v_tmp',INSTR('&v_tmp','/') + 1) tmp FROM DUAL
/
SELECT '&v_tmp' fi FROM DUAL
/
SELECT SUBSTR('&v_file',1,INSTR('&v_file','.') - 1)||TO_CHAR(sysdate,'ddmmyy')||'.TXT' fn FROM DUAL
/
DECLARE

v_FORACID           VARCHAR2(100):=null;
v_ACCT_NAME         VARCHAR2(100):=null;
v_valid             VARCHAR2(100):=null;
v_remarks           VARCHAR2(100):=null;
v_solid             VARCHAR2(100):=null;
v_cls               VARCHAR2(100):=null;
v_bal               VARCHAR2(100):=null;
v_choff             VARCHAR2(100):=null;

BEGIN
--(
    FOR i IN (SELECT * FROM CUSTOM.EQU_UPLOAD_TABLE) LOOP
    --{
    
    v_valid          :='Y';
    v_remarks        :='Success';
    v_FORACID        :=null;
    v_ACCT_NAME      :=null;
    v_solid          :=null;
    v_cls            :=null;
    v_bal            :=null;
    v_choff          :=null;

    
    BEGIN
    --(
        SELECT 
                GAM.foracid,GAM.acct_name,GAM.sol_id,GAM.acct_cls_flg,ABS(clr_bal_amt),GAC.chrge_off_flg
        INTO 
                v_FORACID,v_ACCT_NAME,v_solid,v_cls,v_bal,v_choff  
        FROM    
                CUSTOM.C_ETT,TBAADM.GAM,TBAADM.GAC
        WHERE 
                GAM.foracid             =C_ETT.foracid
                AND GAM.acid            =GAC.acid
                AND C_ETT.equirefnum    =i.upldrefnum
                AND GAM.bank_id         = ;
        
        EXCEPTION
        
        WHEN NO_DATA_FOUND THEN
        BEGIN
        --(
            SELECT 
                    GAM.foracid,GAM.acct_name,GAM.sol_id,GAM.acct_cls_flg,ABS(clr_bal_amt),GAC.chrge_off_flg
            INTO 
                    V_FORACID,v_ACCT_NAME,v_solid,v_cls,v_bal,v_choff 
            FROM    
                    GAM,GAC 
            WHERE 
                    GAM.acid=GAC.acid
                    AND GAM.foracid=i.UPLDREFNUM;

            EXCEPTION

            WHEN NO_DATA_FOUND THEN
                v_valid         := 'N';
                v_remarks       := 'No Matching Record Found';

            WHEN TOO_MANY_ROWS THEN
            
                v_valid         := 'N';
                v_remarks       := 'Duplicate Record Exist';

            WHEN OTHERS THEN

                v_valid         :='N';
                v_remarks       :='DATABASE ERROR';
        -- )
        END;
        WHEN TOO_MANY_ROWS THEN

            v_valid         := 'N';
            v_remarks       := 'Duplicate Record Found';

        WHEN OTHERS THEN
        
            v_valid     :='N';
            v_remarks   :='DATABASE ERROR';
    -- )    
    END;
        
    IF ((v_bal < i.AMOUNT) OR (v_bal = 0)) THEN
    --{
        v_valid     :='N';
        v_remarks   :='Loan a/c going into credit';
    --}
    END IF ;
    
    IF v_cls='Y' THEN
    --{
        v_valid     :='N';
        v_remarks   :='Account Closed';
    --}
    END IF;
    IF v_choff ='Y' THEN
    --{
        v_valid     :='N';
        v_remarks   :='Charged Off Account';
    --}
    END IF;
        
    UPDATE 
            CUSTOM.EQU_UPLOAD_TABLE 
    SET 
           EQU_UPLOAD_TABLE.foracid=v_foracid,
           EQU_UPLOAD_TABLE.acct_name=v_ACCT_NAME,
           EQU_UPLOAD_TABLE.sol_id=v_solid,
           EQU_UPLOAD_TABLE.valid=v_valid, 
           EQU_UPLOAD_TABLE.remarks=v_remarks, 
           EQU_UPLOAD_TABLE.upldstatus='P'
    WHERE 
            EQU_UPLOAD_TABLE.upldrefnum=i.upldrefnum;
    
    COMMIT;
    --}
    END LOOP;
 --)
END;
/

spool &v_filename

SELECT 
        UPLDREFNUM||'|'||PF_NUMBER||'|'||UPLDNAME||'|'||AMOUNT||'|'||FORACID||'|'||ACCT_NAME
        ||'|'||SOL_ID||'|'||VALID||'|'||REMARKS
FROM 
        CUSTOM.EQU_UPLOAD_TABLE
/
spool off

spool EquiloanUpload.lst

SELECT 
        sol_id||'|'||foracid||'|'||AMOUNT||'|'||'C'||'|'||FILE_NAME
FROM 
        CUSTOM.EQU_UPLOAD_TABLE
WHERE 
        VALID='Y'
/

SELECT 
        sol_id||'|'||sol_id||''||'3000100774'||'|'||AMOUNT||'|'||'C'||'|'||FILE_NAME||' '||UPLDNAME
FROM 
        CUSTOM.EQU_UPLOAD_TABLE
WHERE 
        VALID='N'
/

SELECT 
            '000'||'|'||'0003000100774'||'|'||sum(amount)||'|'||'D' ||'|'||FILE_NAME
FROM 
            CUSTOM.EQU_UPLOAD_TABLE
GROUP BY
            FILE_NAME
/

spool off
EXIT;

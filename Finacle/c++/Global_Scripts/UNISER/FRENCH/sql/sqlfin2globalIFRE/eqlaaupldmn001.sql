----------------------------------------------------------------------------------------------------------------
-- Name                          :   eqlaaupldmn001.sql
-- Date                          :   22-02-2013
-- Description                   :   This sql is used to generate spool file.
-- Author                        :   Samrat Saha
-- Reference                     :
-- Modification History  :
--  <Serial No.>  <Date>         <AuthorName>            <Description>
----------------------------------------------------------------------------
--  1           22-02-2013      Samrat Saha              Original version
--	2			05-06-2013		Samrat Saha				 Added bank_id 
----------------------------------------------------------------------------------------------------------------

spool eqUpld1876.txt
SET PAGES 0
SET HEADING OFF
set trims on
set verify off
set feed off
set term off
set linesize 250
set serveroutput on

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
    FOR i IN (SELECT * FROM CUSTOM.EQU_UPLOAD_TABLE WHERE EQU_UPLOAD_TABLE.BANK_ID='&2' ) LOOP
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
                GAM.foracid,
                GAM.acct_name,
                GAM.sol_id,
                GAM.acct_cls_flg,
                ABS(clr_bal_amt),
                GAC.chrge_off_flg
        INTO 
                v_FORACID,
                v_ACCT_NAME,
                v_solid,
                v_cls,
                v_bal,
                v_choff  
        FROM    
                CUSTOM.C_ETT,TBAADM.GAM,TBAADM.GAC
        WHERE 
                GAM.foracid             = C_ETT.foracid
                AND GAM.acid            = GAC.acid
                AND C_ETT.equirefnum    = i.upldrefnum
                AND GAC.bank_id         = GAM.bank_id
                AND GAM.bank_id         = C_ETT.bank_id
                AND GAM.bank_id         = '&2';
        
        EXCEPTION
        
            WHEN NO_DATA_FOUND THEN
            BEGIN
            --(
                SELECT 
                        GAM.foracid,
                        GAM.acct_name,
                        GAM.sol_id,
                        GAM.acct_cls_flg,
                        ABS(clr_bal_amt),
                        GAC.chrge_off_flg
                INTO 
                        V_FORACID,
                        v_ACCT_NAME,
                        v_solid,
                        v_cls,
                        v_bal,
                        v_choff 
                FROM    
                        TBAADM.GAM,TBAADM.GAC 
                WHERE 
                        GAM.acid        = GAC.acid
                AND     GAM.foracid     = i.UPLDREFNUM
                AND     GAM.bank_id     = GAC.bank_id
                AND     GAM.bank_id     = '&2';

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
           EQU_UPLOAD_TABLE.upldstatus='P',EQU_UPLOAD_TABLE.bank_id='&2'
    WHERE 
            EQU_UPLOAD_TABLE.upldrefnum=i.upldrefnum
    AND		EQU_UPLOAD_TABLE.bank_id='&2';
    
    COMMIT;
    --}
    END LOOP;
 --)
 
END;
/

spool off
/

spool &6
SELECT 
        UPLDREFNUM||'|'||PF_NUMBER||'|'||UPLDNAME||'|'||AMOUNT||'|'||FORACID||'|'||ACCT_NAME
        ||'|'||SOL_ID||'|'||VALID||'|'||REMARKS
FROM 
        CUSTOM.EQU_UPLOAD_TABLE
WHERE   
      EQU_UPLOAD_TABLE.bank_id='&2'
/
spool off;

spool &1


SELECT 
        sol_id||'|'||sol_id||''||CUSTOM.getCparamValue('SQLFORACID1','EQUPLD','&2')||'|'||AMOUNT||'|'||'C'||'|&3|'||FILE_NAME||' '||UPLDNAME
FROM 
        CUSTOM.EQU_UPLOAD_TABLE
WHERE 
        VALID='N'
AND     EQU_UPLOAD_TABLE.bank_id='&2'
/

SELECT 
           sol_id || '|' || CUSTOM.getCparamValue('SQLFORACID2','EQUPLD','&2') || '|' || sum(amount) || '|' || 'D' ||'|' || '&3' ||'|'|| FILE_NAME
FROM 
            CUSTOM.EQU_UPLOAD_TABLE
WHERE       
            EQU_UPLOAD_TABLE.bank_id='&2'
AND 	    VALID='N'
GROUP BY
            FILE_NAME,sol_id
/

spool off;


spool &7

SELECT 
        sol_id||'|'||foracid||'|'||AMOUNT||'|'||'C'||'|&3|'||FILE_NAME||'|'||(select to_char(db_stat_date,'DD-MM-YYYY') from tbaadm.gct where bank_id='&2')
FROM 
        CUSTOM.EQU_UPLOAD_TABLE
WHERE 
        VALID='Y'
AND     EQU_UPLOAD_TABLE.bank_id='&2'
/

spool off;

spool &8

SELECT 
        CUSTOM.getCparamValue('SQLFORACID2','EQUPLD','&2') 
FROM 
        DUAL
/

spool off;

EXIT;

--====================================================================================================                    
-- Table Name             : C_OFLOW_VAT_HIST_TBL     
-- Synonym Name           : CLFVTH
-- Date                   : 26-SEP-2018                    
-- Description            : This table is history table for accounts already processed by the VOFLP batch  
-- Author                 : AnuragGhosh_D     
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================
DROP TABLE CUSTOM.C_OFLOW_VAT_HIST_TBL CASCADE CONSTRAINTS;
/
CREATE TABLE CUSTOM.C_OFLOW_VAT_HIST_TBL
(
  FORACID            VARCHAR2(20 BYTE),
  ACID               VARCHAR2(20 BYTE),
  SOL_ID             VARCHAR2(20 BYTE),
  ACCT_CCY_CODE      VARCHAR2(20 BYTE),
  OFLOW_AMT          NUMBER(20,6),
  NEXT_INT_DMD_DATE  DATE,
  LCHG_TIME          DATE,
  RCRE_TIME          DATE,
  LAST_RUN_DATE      DATE,
  RCRE_USER_ID       VARCHAR2(15 BYTE),
  LCHG_USER_ID       VARCHAR2(15 BYTE),
  BANK_ID            VARCHAR2(20 BYTE)
)
/* STORE_START */
INITRANS 64 STORAGE (FREELISTS 16) 
TABLESPACE CUSTOM
/* STORE_END */
/
DROP SYNONYM CUSTOM.CLFVTH;
/
CREATE SYNONYM CUSTOM.CLFVTH FOR CUSTOM.C_OFLOW_VAT_HIST_TBL;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OFLOW_VAT_HIST_TBL TO TBAADM;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OFLOW_VAT_HIST_TBL TO TBAGEN;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OFLOW_VAT_HIST_TBL TO TBAUTIL;
/
COMMIT;
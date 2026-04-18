--====================================================================================================                    
-- Table Name             : C_LOAN_VAT_TRAN_TBL  
-- Synonym Name           : CLVTT
-- Date                   : 26-SEP-2018                    
-- Description            : This table is used for maintaing the Vat transaction details for the loan account    
-- Author                 : AnuragGhosh_D     
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================
DROP TABLE CUSTOM.C_LOAN_VAT_TRAN_TBL CASCADE CONSTRAINTS;
/
CREATE TABLE CUSTOM.C_LOAN_VAT_TRAN_TBL
(
  FORACID        VARCHAR2(20 BYTE),
  ACID           VARCHAR2(20 BYTE),
  SOL_ID         VARCHAR2(20 BYTE),
  ACCT_CCY_CODE  VARCHAR2(20 BYTE),
  INDEM_AMT_FCY  NUMBER(20,6),
  INDEM_AMT_LCY  NUMBER(20,6),
  VAT_AMT_FCY    NUMBER(20,6),
  VAT_AMT_LCY    NUMBER(20,6),
  VAT_PCNT       NUMBER(20,6),
  TRAN_DATE      DATE,
  TRAN_AMT       NUMBER(20,6),
  RATE_CODE      VARCHAR2(35 BYTE),
  RATE           VARCHAR2(30 BYTE),
  DR_CR_IND      VARCHAR2(2 BYTE),
  LCHG_TIME      DATE,
  RCRE_TIME      DATE,
  RCRE_USER_ID   VARCHAR2(15 BYTE),
  LCHG_USER_ID   VARCHAR2(15 BYTE),
  BANK_ID        VARCHAR2(20 BYTE),
  VAT_TRAN_ID    VARCHAR2(16 BYTE),
  SAT_TRAN_ID    VARCHAR2(16 BYTE)
)
/* STORE_START */
INITRANS 64 STORAGE (FREELISTS 16) 
TABLESPACE CUSTOM
/* STORE_END */
/
DROP SYNONYM CUSTOM.CLVTT;
/
CREATE SYNONYM CUSTOM.CLVTT FOR CUSTOM.C_LOAN_VAT_TRAN_TBL;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_LOAN_VAT_TRAN_TBL TO TBAADM;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_LOAN_VAT_TRAN_TBL TO TBAGEN;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_LOAN_VAT_TRAN_TBL TO TBAUTIL;
/
COMMIT;
--====================================================================================================                    
-- Table Name             : C_OFLOW_VAT_TBL 
-- Synonym Name           : CLFVT
-- Index Name		  : IDX_ACID_BANKID_OFLOW
-- Date                   : 26-SEP-2018                    
-- Description            : This table is main table for accounts to be picked up and  processed by the VOFLP batch  
-- Author                 : AnuragGhosh_D     
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================
DROP TABLE CUSTOM.C_OFLOW_VAT_TBL CASCADE CONSTRAINTS;
/
CREATE TABLE CUSTOM.C_OFLOW_VAT_TBL
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
CREATE UNIQUE INDEX CUSTOM.IDX_ACID_BANKID_OFLOW
	ON CUSTOM.C_OFLOW_VAT_TBL(ACID, BANK_ID)
	/* STORE_START */
	storage ( PCTINCREASE 0 )
	TABLESPACE CUSTOM
	/* STORE_END */
/
DROP SYNONYM CUSTOM.CLFVT;
/
CREATE SYNONYM CUSTOM.CLFVT FOR CUSTOM.C_OFLOW_VAT_TBL;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OFLOW_VAT_TBL TO TBAADM;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OFLOW_VAT_TBL TO TBAGEN;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OFLOW_VAT_TBL TO TBAUTIL;
/
COMMIT;
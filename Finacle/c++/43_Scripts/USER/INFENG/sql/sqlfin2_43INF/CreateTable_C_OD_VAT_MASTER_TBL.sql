--====================================================================================================                    
-- Table Name             : C_OD_VAT_MASTER_TBL     
-- Synonym Name           : COVTM
-- Index Name		  : IDX_ACID_BANKID
-- Date                   : 26-SEP-2018                    
-- Description            : This table is used for maintaing the total Vat amounts for the OD account    
-- Author                 : AnuragGhosh_D     
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================
DROP TABLE CUSTOM.C_OD_VAT_MASTER_TBL CASCADE CONSTRAINTS;
/
CREATE TABLE CUSTOM.C_OD_VAT_MASTER_TBL
(
  FORACID          VARCHAR2(20 BYTE),
  ACID             VARCHAR2(20 BYTE),
  SOL_ID           VARCHAR2(20 BYTE),
  ACCT_CCY_CODE    VARCHAR2(20 BYTE),
  TOT_DR_INT_FCY   NUMBER(20,6),
  TOT_VAT_AMT_FCY  NUMBER(20,6),
  TOT_DR_INT_LCY   NUMBER(20,6),
  TOT_VAT_AMT_LCY  NUMBER(20,6),
  LCHG_TIME        DATE,
  RCRE_TIME        DATE,
  RCRE_USER_ID     VARCHAR2(15 BYTE),
  LCHG_USER_ID     VARCHAR2(15 BYTE),
  BANK_ID          VARCHAR2(20 BYTE)
)
/* STORE_START */
INITRANS 64 STORAGE (FREELISTS 16) 
TABLESPACE CUSTOM
/* STORE_END */
/
CREATE UNIQUE INDEX CUSTOM.IDX_ACID_BANKID
	ON CUSTOM.C_OD_VAT_MASTER_TBL(ACID, BANK_ID)
	/* STORE_START */
	storage ( PCTINCREASE 0 )
	TABLESPACE CUSTOM
	/* STORE_END */
/
DROP SYNONYM CUSTOM.COVTM;
/
CREATE SYNONYM CUSTOM.COVTM FOR CUSTOM.C_OD_VAT_MASTER_TBL;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OD_VAT_MASTER_TBL TO TBAADM;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OD_VAT_MASTER_TBL TO TBAGEN;
/
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CUSTOM.C_OD_VAT_MASTER_TBL TO TBAUTIL;
/
COMMIT;
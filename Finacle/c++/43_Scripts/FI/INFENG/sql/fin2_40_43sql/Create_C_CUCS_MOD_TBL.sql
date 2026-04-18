--====================================================================================================                    
-- Table Name             : CUSTOM.C_CUCS_MOD_TBL
-- Date                   : 07-JUN-2019                    
-- Description            : .     
-- Author                 : Sridevi Vutukuru       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================

DROP TABLE CUSTOM.C_CUCS_MOD_TBL CASCADE CONSTRAINTS;

CREATE TABLE "CUSTOM"."C_CUCS_MOD_TBL" 
(	
	ACCT_NUMBER			VARCHAR2(16 CHAR),
	CHEQUE_NUM			VARCHAR2(16 CHAR),
	CHEQUE_AMT			NUMBER(20,4),
	STATUS				CHAR(1 BYTE),				
	DEL_FLG				CHAR(1 BYTE),
	ENTITY_CRE_FLG		CHAR(1 BYTE),
	CHARGE_COLLECTED	NUMBER(20,4),
	CHARGE_TRAN_ID		VARCHAR2(9 CHAR),
	CHARGE_TRAN_DATE	DATE,
	PAID_AMT			NUMBER(20,4),
	LIEN_FLG			CHAR(1 BYTE),
	TRAN_ID				VARCHAR2(9 CHAR),
	TRAN_DATE			DATE,
	BANK_ID				VARCHAR2(8 CHAR),
	RCRE_TIME		 	DATE,
	RCRE_USER_ID		VARCHAR2(20 CHAR),
	LCHG_TIME			DATE,
	LCHG_USER_ID		VARCHAR2(20 CHAR),
	REMARKS				VARCHAR2(100 CHAR)
);

CREATE UNIQUE INDEX "CUSTOM"."IDX_CUCS_MOD" ON "CUSTOM"."C_CUCS_TBL_MOD" ("ACCT_NUMBER", "CHEQUE_NUM", "BANK_ID");

DROP SYNONYM CUSTOM.C_CUCS_MOD;

CREATE SYNONYM CUSTOM.C_CUCS_MOD FOR CUSTOM.C_CUCS_MOD_TBL;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_CUCS_MOD_TBL TO TBAADM;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_CUCS_MOD_TBL TO TBAGEN;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_CUCS_MOD_TBL TO TBAUTIL;

COMMIT;

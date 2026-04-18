--====================================================================================================                    
-- Table Name             : CUSTOM.C_PNAT_ACCRUAL_TBL
-- Date                   : 10-JUL-2019                    
-- Description            : .     
-- Author                 : Sridevi Vutukuru       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================

DROP TABLE CUSTOM.C_PNAT_ACCRUAL_TBL CASCADE CONSTRAINTS;

CREATE TABLE "CUSTOM"."C_PNAT_ACCRUAL_TBL" 
(	
	FORACID 		VARCHAR2(16 CHAR), 
	ACID 			VARCHAR2(11 CHAR), 
	SOL_ID 			VARCHAR2(8 CHAR), 
	ACCT_CCY_CODE 	VARCHAR2(3 CHAR), 
	ACCRUAL_DATE	DATE,
	CLR_BAL_AMT		NUMBER(20,4),
	PRODUCT_FOR_INT_RATE	VARCHAR2(20 CHAR),
	INTEREST_AMOUNT	VARCHAR2(20 CHAR),
	RCRE_USER_ID 	VARCHAR2(15 CHAR), 
	RCRE_TIME 		DATE, 
	LCHG_USER_ID 	VARCHAR2(15 CHAR), 
	LCHG_TIME 		DATE, 
	BANK_ID 		VARCHAR2(8 CHAR)
);
 		
DROP SYNONYM CUSTOM.C_PNAT_ACCRUAL;

CREATE SYNONYM CUSTOM.C_PNAT_ACCRUAL FOR CUSTOM.C_PNAT_ACCRUAL_TBL;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_PNAT_ACCRUAL_TBL TO TBAADM;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_PNAT_ACCRUAL_TBL TO TBAGEN;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_PNAT_ACCRUAL_TBL TO TBAUTIL;

COMMIT;

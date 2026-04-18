--====================================================================================================                    
-- Table Name             : CUSTOM.C_PNAT_WAIVING_TBL
-- Date                   : 10-JUL-2019                    
-- Description            : .     
-- Author                 : Sridevi Vutukuru       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================

DROP TABLE CUSTOM.C_PNAT_WAIVING_TBL CASCADE CONSTRAINTS;

CREATE TABLE "CUSTOM"."C_PNAT_WAIVING_TBL" 
(	
	FORACID 		VARCHAR2(16 CHAR), 
	ACID 			VARCHAR2(11 CHAR), 
	SOL_ID 			VARCHAR2(8 CHAR), 
	ACCT_CCY_CODE 	VARCHAR2(3 CHAR), 
	ADDITIONAL_WAVING_OFF_AMT  NUMBER(20,4),
	WAVING_OFF_BOD_DATE DATE,
	WAVING_OFF_REASON VARCHAR2(200 CHAR), 
	RCRE_USER_ID 	VARCHAR2(15 CHAR), 
	RCRE_TIME 		DATE, 
	LCHG_USER_ID 	VARCHAR2(15 CHAR), 
	LCHG_TIME 		DATE, 
	BANK_ID 		VARCHAR2(8 CHAR)
);

DROP SYNONYM CUSTOM.C_PNAT_WAIVING;

CREATE SYNONYM CUSTOM.C_PNAT_WAIVING FOR CUSTOM.C_PNAT_WAIVING_TBL;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_PNAT_WAIVING_TBL TO TBAADM;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_PNAT_WAIVING_TBL TO TBAGEN;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_PNAT_WAIVING_TBL TO TBAUTIL;

COMMIT;

--====================================================================================================                    
-- Table Name             : CUSTOM.ACCT_MANAGER_NAME_MOD
-- Synonym Name           :	NA                  
-- Date                   : 20-Jun-2018                    
-- Description            : This table is used for maintaing the A/C Manager ID field.     
-- Author                 : Nagamani Boddu      
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================

DROP TABLE CUSTOM.ACCT_MANAGER_NAME_MOD CASCADE CONSTRAINTS;

CREATE TABLE CUSTOM.ACCT_MANAGER_NAME_MOD
(
	ACCOUNT_MANAGER_NAME VARCHAR2(30),
    LC_OR_BG_NUMBER VARCHAR2(30),
    LC_OR_BG_TYPE VARCHAR2(20),
    BANK_ID VARCHAR2(8),
    RCRE_USER_ID   VARCHAR2(20),
    RCRE_TIME      DATE,
    LCHG_USER_ID   VARCHAR2(20),
    LCHG_TIME      DATE,
    ENTITY_CRE_FLG  CHAR(1),
    DEL_FLG CHAR(1)
);


DROP SYNONYM CUSTOM.ACMGR_MOD;

CREATE SYNONYM CUSTOM.ACMGR_MOD FOR CUSTOM.ACCT_MANAGER_NAME;

CREATE UNIQUE INDEX "CUSTOM"."ACCT_MGR_MOD_INDX" ON "CUSTOM"."ACCT_MANAGER_NAME_MOD" ("BANK_ID", "LC_OR_BG_NUMBER"); 

GRANT INSERT, SELECT, UPDATE, DELETE ON CUSTOM.ACCT_MANAGER_NAME_MOD TO TBAADM;

GRANT INSERT, SELECT, UPDATE, DELETE ON CUSTOM.ACCT_MANAGER_NAME_MOD TO TBAGEN;

GRANT INSERT, SELECT, UPDATE, DELETE ON CUSTOM.ACCT_MANAGER_NAME_MOD TO TBAUTIL; 

COMMIT;

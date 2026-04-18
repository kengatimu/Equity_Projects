
--====================================================================================================                    
-- Table Name             : CUSTOM_CEXCHRT_MOD_TABLE
-- Date                   : 05-JUL-2018                    
-- Description            : This table is used for maintaing the margin details.    
-- Author                 : Shiva Krishna D       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================

DROP TABLE CUSTOM.CUSTOM_CEXCHRT_MOD_TABLE CASCADE CONSTRAINTS;

CREATE TABLE "CUSTOM"."CUSTOM_CEXCHRT_MOD_TABLE" 
   (	ROLE_ID		VARCHAR2(15 CHAR),
FROM_CURRENCY	VARCHAR2(8 CHAR),
TO_CURRENCY	VARCHAR2(8 CHAR),
ENTITY_CRE_FLG	CHAR(1 BYTE),
DEL_FLG	CHAR(1 BYTE),
LCHG_USER_ID	VARCHAR2(15 CHAR),
LCHG_TIME	DATE,
RCRE_USER_ID	VARCHAR2(15 CHAR),
RCRE_TIME	DATE,
BANK_ID	VARCHAR2(3 CHAR),
TRANSFER_MARGIN_AMT	VARCHAR2(8 CHAR),
CASH_MARGIN_AMT		VARCHAR2(8 CHAR),
RATE	VARCHAR2(8 CHAR)
   );

DROP SYNONYM CUSTOM.CUSTOM_CEXCHRT_MOD;

CREATE SYNONYM CUSTOM.CUSTOM_CEXCHRT_MOD FOR CUSTOM.CUSTOM_CEXCHRT_MOD_TABLE;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.CUSTOM_CEXCHRT_MOD_TABLE TO TBAADM;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.CUSTOM_CEXCHRT_MOD_TABLE TO TBAGEN;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.CUSTOM_CEXCHRT_MOD_TABLE TO TBAUTIL;

COMMIT;

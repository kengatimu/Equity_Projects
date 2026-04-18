--====================================================================================================                    
-- Table Name             : CUSTOM.C_COMM_MAINT
-- Date                   : 05-JUL-2018                    
-- Description            : This table is used for maintaing the LC BG Commission Details.     
-- Author                 : Shiva Krishna D       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================
DROP TABLE CUSTOM.C_COMM_MAINT CASCADE CONSTRAINTS;

CREATE TABLE "CUSTOM"."C_COMM_MAINT" 
   (	LC_OR_BG_NUMBER	VARCHAR2(20 BYTE),
LC_OR_BG_TYPE	VARCHAR2(20 BYTE),
COMM_FREQ	VARCHAR2(15 BYTE),
COMM_START_DATE	DATE,
COMM_CODE	VARCHAR2(8 BYTE),
COMM_FLG	VARCHAR2(1 BYTE),
NEXT_COMM_DATE	DATE,
DEL_FLG	CHAR(1 BYTE),
ENTITY_CRE_FLG	CHAR(1 BYTE),
RCRE_USER_ID	VARCHAR2(15 BYTE),
RCRE_TIME	DATE,
LCHG_USER_ID	VARCHAR2(15 BYTE),
LCHG_TIME	DATE,
BANK_ID	VARCHAR2(8 BYTE)
);

CREATE UNIQUE INDEX "CUSTOM"."IDX_MAPPING_COMMAINT" ON "CUSTOM"."C_COMM_MAINT" ("BANK_ID", "LC_OR_BG_NUMBER","COMM_CODE");
 
DROP SYNONYM CUSTOM.C_COMMAINT;

CREATE SYNONYM CUSTOM.C_COMMAINT FOR CUSTOM.C_COMM_MAINT;


GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM_MAINT TO TBAADM;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM_MAINT TO TBAGEN;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM_MAINT TO TBAUTIL;

COMMIT;

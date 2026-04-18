
--====================================================================================================                    
-- Table Name             : CUSTOM.C_COMM_MAINT_TRAN
-- Date                   : 05-JUL-2018                    
-- Description            : This table is used for maintaing the Commission Transactions.     
-- Author                 : Shiva Krishna D       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================

DROP TABLE CUSTOM.C_COMM_MAINT_TRAN CASCADE CONSTRAINTS;

CREATE TABLE "CUSTOM"."C_COMM_MAINT_TRAN" 
   (	LC_OR_BG_NUMBER	VARCHAR2(20 BYTE),
LC_OR_BG_TYPE	VARCHAR2(20 BYTE),
TRAN_ID	VARCHAR2(20 BYTE),
TRAN_DATE	DATE,
TRAN_AMT	NUMBER(20,4),
RATE_CODE   VARCHAR2(20 BYTE),
RCRE_USER_ID	VARCHAR2(20 BYTE),
RCRE_TIME	DATE,
BANK_ID	VARCHAR2(20 BYTE)
   );


  CREATE UNIQUE INDEX "CUSTOM"."IDX_COMM_TXN" ON "CUSTOM"."C_COMM_MAINT_TRAN" ("LC_OR_BG_NUMBER","BANK_ID");
 
 DROP SYNONYM CUSTOM.C_COMM_TRAN;

CREATE SYNONYM CUSTOM.C_COMM_TRAN FOR CUSTOM.C_COMM_MAINT_TRAN;


GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM_MAINT_TRAN TO TBAADM;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM_MAINT_TRAN TO TBAGEN;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM_MAINT_TRAN TO TBAUTIL;

COMMIT;
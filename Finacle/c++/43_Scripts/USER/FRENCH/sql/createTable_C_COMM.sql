
--====================================================================================================                    
-- Table Name             : CUSTOM.C_COMM
-- Date                   : 05-JUL-2018                    
-- Description            : This table is used for maintaing the Commission Codes.     
-- Author                 : Shiva Krishna D       
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================

DROP TABLE CUSTOM.C_COMM CASCADE CONSTRAINTS;

CREATE TABLE "CUSTOM"."C_COMM" 
   (	COMM_CODE	VARCHAR2(15 CHAR),
COMM_DESC	VARCHAR2(100 CHAR),
CRNCY_CODE	VARCHAR2(3 CHAR),
VAT_RATE	NUMBER(20,4),
MIN_COMM	NUMBER(20,4),
COMM_PCNT	NUMBER(20,4),
DEL_FLG		CHAR(1),
RCRE_USER_ID	VARCHAR2(15 CHAR),
RCRE_TIME	DATE,
LCHG_USER_ID	VARCHAR2(15 CHAR),
LCHG_TIME	DATE,
BANK_ID	VARCHAR2(8 CHAR)
   );


  CREATE UNIQUE INDEX "CUSTOM"."IDX_COMM" ON "CUSTOM"."C_COMM" ("COMM_CODE","BANK_ID" );
 
 DROP SYNONYM CUSTOM.C_COM;

CREATE SYNONYM CUSTOM.C_COM FOR CUSTOM.C_COMM;


GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM TO TBAADM;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM TO TBAGEN;

GRANT INSERT, SELECT, UPDATE,DELETE ON CUSTOM.C_COMM TO TBAUTIL;

COMMIT;

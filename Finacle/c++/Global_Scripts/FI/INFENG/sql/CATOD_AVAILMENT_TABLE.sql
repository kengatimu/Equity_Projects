--  -----------------------------------------------------------------------------------------------
--   File Name               : create_table_CATOD_AVAILMENT_TABLE.sql
--   Author                  : Nitin Prabhakar
--   Date                    : 04-04-2013
--   Bank                    : Equity Bank
--   Description             : Creates Custom table CATOD_AVAILMENT_TABLE.
--   SYNONYM                 : C_TODA
--   INDEX                   : IDX_CUSTOM_C_TODA
--   Reviewed By             : 
--     SLN       Date         Author             Changes Summary  
--      1     04-04-2013   Nitin Prabhakar       Original file
--  -----------------------------------------------------------------------------------------------
DROP TABLE CATOD_AVAILMENT_TABLE CASCADE CONSTRAINTS;

CREATE TABLE CATOD_AVAILMENT_TABLE
(
REQUEST_ID        VARCHAR2 (16 Byte),
SANCT_ID          VARCHAR2 (16 Byte),
ACCT_NUM          VARCHAR2 (16 Byte),
CUST_ID           VARCHAR2 (9 Byte),
CARD_NUM          VARCHAR2 (19 Byte),
ACCT_NAME         VARCHAR2 (80 Byte),
SOL_ID            VARCHAR2 (8 Byte),
REQ_AMT           NUMBER (20,2),
PERIOD            NUMBER (2),
STATUS_FLG        CHAR (1 Byte)             DEFAULT 'P',
REMARKS           VARCHAR2 (30 Byte),
CREATED_BY        VARCHAR2 (15 Byte)        NOT NULL,
CREATED_DATE      DATE,
MODIFIED_BY       VARCHAR2 (15 Byte),
MODIFIED_DATE     DATE,
VERIFY_BY         VARCHAR2 (15 Byte),
VERIFY_DATE       DATE,
ADV_AMT           NUMBER (20,2),
PERMITTED_USER    VARCHAR2 (15 Byte),
FREE_TEXT         VARCHAR2 (100 Byte),
UPLOAD_STATUS     VARCHAR2 (3 Byte),
GRANT_DATE        DATE,
EXPIRY_DATE       DATE,
LODGED_USER       VARCHAR2 (15 Byte),
LODGED_DATE       DATE,
VERIFIED_USER     VARCHAR2 (15 Byte),
VERIFIED_DATE     DATE,
RCRE_USER         VARCHAR2 (15 Byte),
RCRE_DATE         DATE,
LCHG_USER         VARCHAR2 (15 Byte),
LCHG_DATE         DATE,
MSG_IND           CHAR (1 Byte)             DEFAULT 'B',
EMAIL_FLG         CHAR (1 Byte)             DEFAULT 'N',
SMS_FLG           CHAR (1 Byte)             DEFAULT 'N',
IS_DELETED        CHAR (1 Byte)             DEFAULT 'N',
MAX_LIMIT         NUMBER (20,2),
FREE_TEXT_1       VARCHAR2 (50 Byte),
BANK_ID           VARCHAR2 (8 Byte),
CHARGE_AMT        NUMBER (20,2)
)
TABLESPACE CUSTOM_TBLS;

DROP SYNONYM CUSTOM.C_TODA;

CREATE SYNONYM CUSTOM.C_TODA FOR CATOD_AVAILMENT_TABLE;


DROP SYNONYM TBAADM.C_TODA;

CREATE SYNONYM TBAADM.C_TODA FOR CATOD_AVAILMENT_TABLE;


DROP SYNONYM TBAGEN.C_TODA;

CREATE SYNONYM TBAGEN.C_TODA FOR CATOD_AVAILMENT_TABLE;


DROP SYNONYM TBAUTIL.C_TODA;

CREATE SYNONYM TBAUTIL.C_TODA FOR CATOD_AVAILMENT_TABLE;

CREATE  UNIQUE INDEX IDX_CUSTOM_C_TODA
ON CATOD_AVAILMENT_TABLE( REQUEST_ID,BANK_ID )
TABLESPACE CUSTOM_IDXSPACE;
 
GRANT DELETE, INSERT, SELECT, UPDATE ON CATOD_AVAILMENT_TABLE TO SYSTEM;

GRANT DELETE, INSERT, SELECT, UPDATE ON CATOD_AVAILMENT_TABLE TO TBAADM;

GRANT DELETE, INSERT, SELECT, UPDATE ON CATOD_AVAILMENT_TABLE TO TBAGEN;

GRANT DELETE, INSERT, SELECT, UPDATE ON CATOD_AVAILMENT_TABLE TO TBAUTIL;

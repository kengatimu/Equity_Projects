--====================================================================================================
-- Table Name: CUST_SOURCE_OF_FUNDS_TBL
-- Synonym Name : C_SFT
-- Date: 30-JAN-2019
-- Description: This table is used for maintaining Source of Funds.
-- Author: Anshul_Singh04
-- Modification History :
--<Version No.> <Date> <Author Name> <Description>
--====================================================================================================

DROP TABLE CUSTOM.CUST_SOURCE_OF_FUNDS_TBL CASCADE CONSTRAINTS;

CREATE TABLE CUSTOM.CUST_SOURCE_OF_FUNDS_TBL
(
	SOURCE_ID				VARCHAR2(9 CHAR),
	SOURCE_DESC			   	VARCHAR2(50 CHAR),
	RCRE_USER_ID       		VARCHAR2(15 CHAR),
	RCRE_TIME          		DATE,
	BANK_ID            		VARCHAR2(8 CHAR)
);

DROP INDEX CUSTOM.IDX_SRC_FNDS_TBL;

CREATE UNIQUE INDEX CUSTOM.IDX_SRC_FNDS_TBL ON CUSTOM.CUST_SOURCE_OF_FUNDS_TBL
(SOURCE_ID,BANK_ID);

DROP SYNONYM CUSTOM.C_SFT;

CREATE SYNONYM CUSTOM.C_SFT FOR CUSTOM.CUST_SOURCE_OF_FUNDS_TBL;

GRANT DELETE, INSERT, SELECT, UPDATE ON CUSTOM.CUST_SOURCE_OF_FUNDS_TBL TO TBAADM;

GRANT DELETE, INSERT, SELECT, UPDATE ON CUSTOM.CUST_SOURCE_OF_FUNDS_TBL TO TBAGEN;

GRANT DELETE, INSERT, SELECT, UPDATE ON CUSTOM.CUST_SOURCE_OF_FUNDS_TBL TO TBAUTIL;


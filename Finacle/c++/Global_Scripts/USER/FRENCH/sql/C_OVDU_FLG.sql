--====================================================================================================
-- Table Name                   : CUST_OVDU_FLG_TBL
-- Synonym Name                 : C_OVDU_FLG
-- Index Name                   :
-- Unique Index On              :
-- Date                         :
-- Description                  : This sql script is used to create a customized CUST_OVDU_FLG_TBL table
-- Author                       :
-- Bank                         : EQUITY BANK
-- Modification History :
-- <Version No.>    <Date>        <Author Name>         <Description>
--    0.1      	   03-06-2013     Maniraj Avayaraj
--====================================================================================================

Rem TABLE NAME: CUST_OVDU_FLG_TBL

DROP TABLE custom.CUST_OVDU_FLG_TBL
/

CREATE TABLE custom.CUST_OVDU_FLG_TBL
(
CUST_ACCT VARCHAR2(16 CHAR),
OVDU_FLG  CHAR(1 CHAR),
REN_DATE  DATE,
BANK_ID   VARCHAR2(8 CHAR)
)
TABLESPACE CUSTOM_TBLS
/

DROP INDEX CUSTOM.IDX_CUST_OVDU_1
/
CREATE INDEX CUSTOM.IDX_CUST_OVDU_1 ON CUSTOM.CUST_OVDU_FLG_TBL
(CUST_ACCT,REN_DATE)
/

DROP SYNONYM CUSTOM.C_OVDU_FLG
/
CREATE SYNONYM CUSTOM.C_OVDU_FLG FOR CUSTOM.CUST_OVDU_FLG_TBL
/

DROP SYNONYM TBAADM.C_OVDU_FLG
/
CREATE SYNONYM TBAADM.C_OVDU_FLG FOR CUSTOM.CUST_OVDU_FLG_TBL
/

DROP SYNONYM TBAGEN.C_OVDU_FLG
/
CREATE SYNONYM TBAGEN.C_OVDU_FLG FOR CUSTOM.CUST_OVDU_FLG_TBL
/

DROP SYNONYM TBAUTIL.C_OVDU_FLG
/
CREATE SYNONYM TBAUTIL.C_OVDU_FLG FOR CUSTOM.CUST_OVDU_FLG_TBL
/

GRANT DELETE, INSERT, SELECT, UPDATE ON CUSTOM.CUST_OVDU_FLG_TBL TO TBAADM
/

GRANT DELETE, INSERT, SELECT, UPDATE ON CUSTOM.CUST_OVDU_FLG_TBL TO TBAGEN
/

GRANT SELECT ON CUSTOM.CUST_OVDU_FLG_TBL TO TBAUTIL
/

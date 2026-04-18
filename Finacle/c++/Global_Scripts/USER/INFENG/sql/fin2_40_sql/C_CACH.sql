--====================================================================================================
-- Table Name                                   : ASSET_CLASSFN_HIST
-- Synonym Name                                 : C_CPT
-- Date                                         : 10-06-2013
-- Description                                  : This sql script is used to create a custom table custom.ASSET_CLASSFN_HIST
-- Author                                       : KALVIN JOSEPH
-- Bank                                         : EQUITY BANK
-- Modification History   :
-- <Version No.>    <Date>        <Author Name>          <Description>
--  0.1              10-06-2013    KALVIN JOSEPH       Draft Version   
--====================================================================================================

DROP TABLE custom.ASSET_CLASSFN_HIST;

DROP  SYNONYM custom.C_CACH;

DROP  SYNONYM tbagen.C_CACH;

DROP  SYNONYM tbautil.C_CACH;

DROP  SYNONYM tbaadm.C_CACH;

CREATE TABLE custom.ASSET_CLASSFN_HIST
(
      FORACID        VARCHAR2(16 BYTE),
      BANK_ID	     VARCHAR2(10 BYTE),
      LAST_ADJ_DATE  DATE,
      RSHDL_DATE     DATE,
      UPGR_WATCH_DATE DATE,
      UPGR_NORMAL_DATE DATE,
      CLR_BAL_AMT  NUMBER(10,2),
      OLD_DPD	  VARCHAR2(10 BYTE),
      CURRENT_DPD VARCHAR2(10 BYTE),
      DEL_FLG   char(1 BYTE),
      LCHG_USER VARCHAR2(15 BYTE),
      LCHG_DATE DATE,
      CACH_SRL_NUM NUMBER 
)
TABLESPACE CUSTOM_TBLS;

CREATE  SYNONYM custom.C_CACH for custom.ASSET_CLASSFN_HIST;

CREATE  SYNONYM tbagen.C_CACH for custom.ASSET_CLASSFN_HIST;

CREATE  SYNONYM tbautil.C_CACH for custom.ASSET_CLASSFN_HIST;

CREATE  SYNONYM tbaadm.C_CACH for custom.ASSET_CLASSFN_HIST;

CREATE UNIQUE INDEX IDX_C_CACH on custom.ASSET_CLASSFN_HIST(FORACID,CACH_SRL_NUM,BANK_ID) TABLESPACE CUSTOM_IDXSPACE;

GRANT ALL ON custom.ASSET_CLASSFN_HIST to TBAGEN,TBAUTIL,TBAADM;


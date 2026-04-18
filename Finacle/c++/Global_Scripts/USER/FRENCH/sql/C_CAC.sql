--====================================================================================================
-- Table Name                                   : ASSET_CLASSFN
-- Synonym Name                                 : C_CAC
-- Date                                         : 10-06-2013
-- Description                                  : This sql script is used to create a custom table custom.ASSET_CLASSFN
-- Author                                       : KALVIN JOSEPH
-- Bank                                         : EQUITY BANK
-- Modification History   :
-- <Version No.>    <Date>        <Author Name>          <Description>
--  0.1              10-06-2013    KALVIN JOSEPH       Draft Version   
--====================================================================================================

DROP TABLE custom.ASSET_CLASSFN;

DROP  SYNONYM custom.C_CAC;

DROP  SYNONYM tbagen.C_CAC;

DROP  SYNONYM tbautil.C_CAC;

DROP  SYNONYM tbaadm.C_CAC;

CREATE TABLE custom.ASSET_CLASSFN
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
	 RCRE_USER VARCHAR2(15 BYTE),
	 RCRE_DATE DATE,
	 LCHG_USER VARCHAR2(15 BYTE),
	 LCHG_DATE DATE,
	 CACH_SRL_NUM NUMBER    
)
TABLESPACE CUSTOM_TBLS;

CREATE  SYNONYM custom.C_CAC for custom.ASSET_CLASSFN;

CREATE  SYNONYM tbagen.C_CAC for custom.ASSET_CLASSFN;

CREATE  SYNONYM tbautil.C_CAC for custom.ASSET_CLASSFN;

CREATE  SYNONYM tbaadm.C_CAC for custom.ASSET_CLASSFN;

CREATE UNIQUE INDEX IDX_C_CAC on CUSTOM.ASSET_CLASSFN(FORACID,BANK_ID) TABLESPACE CUSTOM_IDXSPACE;

GRANT ALL ON custom.ASSET_CLASSFN to TBAGEN,TBAUTIL,TBAADM;



--====================================================================================================
-- Table Name                                   : C_HTD
-- Date                                         : 07-08-2013
-- Description                                  : This sql script is used to create a custom table C_HTD
-- Author                                       : Nithya Murugesan 
-- Bank                                         : EQUITY BANK
-- Modification History   :
-- <Version No.>    <Date>        <Author Name>          <Description>
--  0.1             07-08-2013    Nithya Murugesan      Draft Version   
--====================================================================================================
--DROP TABLE CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE CASCADE CONSTRAINTS;

CREATE TABLE CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE
(
  TRAN_DATE                DATE,
  TRAN_ID                  VARCHAR2(9 CHAR),
  PART_TRAN_SRL_NUM        VARCHAR2(4 CHAR),
  DEL_FLG                  CHAR(1 BYTE),
  TRAN_TYPE                CHAR(1 BYTE),
  TRAN_SUB_TYPE            VARCHAR2(2 CHAR),
  PART_TRAN_TYPE           CHAR(1 BYTE),
  GL_SUB_HEAD_CODE         VARCHAR2(5 CHAR),
  ACID                     VARCHAR2(11 CHAR),
  VALUE_DATE               DATE,
  TRAN_AMT                 NUMBER(20,4),
  TRAN_PARTICULAR          VARCHAR2(50 CHAR),
  ENTRY_USER_ID            VARCHAR2(15 CHAR),
  PSTD_USER_ID             VARCHAR2(15 CHAR),
  VFD_USER_ID              VARCHAR2(15 CHAR),
  ENTRY_DATE               DATE,
  PSTD_DATE                DATE,
  VFD_DATE                 DATE,
  RPT_CODE                 VARCHAR2(5 CHAR),
  REF_NUM                  VARCHAR2(20 CHAR),
  INSTRMNT_TYPE            VARCHAR2(5 CHAR),
  INSTRMNT_DATE            DATE,
  INSTRMNT_NUM             VARCHAR2(16 CHAR),
  INSTRMNT_ALPHA           VARCHAR2(6 CHAR),
  TRAN_RMKS                VARCHAR2(30 CHAR),
  PSTD_FLG                 CHAR(1 BYTE),
  PRNT_ADVC_IND            CHAR(1 BYTE),
  AMT_RESERVATION_IND      CHAR(1 BYTE),
  RESERVATION_AMT          NUMBER(20,4),
  RESTRICT_MODIFY_IND      CHAR(1 BYTE),
  LCHG_USER_ID             VARCHAR2(15 CHAR),
  LCHG_TIME                DATE,
  RCRE_USER_ID             VARCHAR2(15 CHAR),
  RCRE_TIME                DATE,
  CUST_ID                  VARCHAR2(9 CHAR),
  VOUCHER_PRINT_FLG        CHAR(1 BYTE),
  MODULE_ID                VARCHAR2(3 CHAR),
  BR_CODE                  VARCHAR2(6 CHAR),
  FX_TRAN_AMT              NUMBER(20,4),
  RATE_CODE                VARCHAR2(5 CHAR),
  RATE                     NUMBER(21,10),
  CRNCY_CODE               VARCHAR2(3 CHAR),
  NAVIGATION_FLG           CHAR(1 BYTE),
  TRAN_CRNCY_CODE          VARCHAR2(3 CHAR),
  REF_CRNCY_CODE           VARCHAR2(3 CHAR),
  REF_AMT                  NUMBER(20,4),
  SOL_ID                   VARCHAR2(8 CHAR),
  BANK_CODE                VARCHAR2(6 CHAR),
  TREA_REF_NUM             VARCHAR2(16 CHAR),
  TREA_RATE                NUMBER(21,10),
  TS_CNT                   NUMBER(5),
  GST_UPD_FLG              CHAR(1 BYTE),
  ISO_FLG                  CHAR(1 BYTE),
  EABFAB_UPD_FLG           CHAR(1 BYTE),
  LIFT_LIEN_FLG            CHAR(1 BYTE),
  PROXY_POST_IND           CHAR(1 BYTE),
  SI_SRL_NUM               VARCHAR2(12 CHAR),
  SI_ORG_EXEC_DATE         DATE,
  PR_SRL_NUM               VARCHAR2(9 CHAR),
  SERIAL_NUM               VARCHAR2(4 CHAR),
  DEL_MEMO_PAD             CHAR(1 BYTE),
  UAD_MODULE_ID            VARCHAR2(6 CHAR),
  UAD_MODULE_KEY           VARCHAR2(256 CHAR),
  REVERSAL_DATE            DATE,
  REVERSAL_VALUE_DATE      DATE,
  PTTM_EVENT_TYPE          VARCHAR2(5 CHAR),
  PROXY_ACID               VARCHAR2(11 CHAR),
  TOD_ENTITY_TYPE          VARCHAR2(5 CHAR),
  TOD_ENTITY_ID            VARCHAR2(50 CHAR),
  DTH_INIT_SOL_ID          VARCHAR2(8 CHAR),
  REGULARIZATION_AMT       NUMBER(20,4),
  PRINCIPAL_PORTION_AMT    NUMBER(20,4),
  TF_ENTITY_SOL_ID         VARCHAR2(8 CHAR),
  TRAN_PARTICULAR_2        VARCHAR2(50 CHAR),
  TRAN_PARTICULAR_CODE     VARCHAR2(5 CHAR),
  TR_STATUS                CHAR(1 BYTE),
  SVS_TRAN_ID              VARCHAR2(25 CHAR),
  CRNCY_HOL_CHK_DONE_FLG   CHAR(1 BYTE),
  REFERRAL_ID              VARCHAR2(12 CHAR),
  PARTY_CODE               VARCHAR2(9 CHAR),
  GL_DATE                  DATE,
  BKDT_TRAN_FLG            CHAR(1 BYTE),
  BANK_ID                  VARCHAR2(8 CHAR),
  IMPL_CASH_PART_TRAN_FLG  CHAR(1 BYTE),
  PTRAN_CHRG_EXISTS_FLG    CHAR(1 BYTE),
  MUD_POOL_BAL_BUILD_FLG   CHAR(1 BYTE),
  GL_SEGMENT_STRING        VARCHAR2(50 CHAR)
)
TABLESPACE CUSTOM_TBLS
PCTUSED    0
PCTFREE    10
INITRANS   64
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX CUSTOM_IDXSPACE ON CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE
(TRAN_DATE, TRAN_ID, PART_TRAN_SRL_NUM, BANK_ID)
LOGGING
TABLESPACE CUSTOM_TBLS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--DROP SYNONYM CUSTOM.C_HTD;

CREATE SYNONYM CUSTOM.C_HTD FOR CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE;


--DROP SYNONYM TBAGEN.C_HTD;

CREATE SYNONYM TBAGEN.C_HTD FOR CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE;


--DROP SYNONYM TBAUTIL.C_HTD;

CREATE SYNONYM TBAUTIL.C_HTD FOR CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE;


--DROP SYNONYM TBAADM.C_HTD;

CREATE SYNONYM TBAADM.C_HTD FOR CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE;


GRANT DELETE, INSERT, SELECT, UPDATE ON CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE TO CRMUSER;

GRANT DELETE, INSERT, SELECT, UPDATE ON CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE TO TBAGEN;

GRANT SELECT ON CUSTOM.CUSTOM_HIST_TRAN_DTL_TABLE TO TBAUTIL;

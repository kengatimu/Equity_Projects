--------------------------------------------------------------------------------
Rem     This file will create custom.CUST_DENOM_MASTER_DR_TMP
Rem     with the following characteristics.


Rem TABLE NAME: CUST_DENOM_MASTER_DR_TMP

DROP table custom.CUST_DENOM_MASTER_DR_TMP
/
DROP  SYNONYM custom.C_DENM_DR
/
DROP  SYNONYM tbagen.C_DENM_DR
/
DROP  SYNONYM tbautil.C_DENM_DR
/
DROP  SYNONYM TBAADM.C_DENM_DR
/
CREATE TABLE custom.CUST_DENOM_MASTER_DR_TMP
(	
	SOL_ID			varchar2(20) not null,
	CRNCY_CODE         VARCHAR2(5) not null,
	DENOM_IND              CHAR(1) not null,
	DENOM_VALUE        NUMBER(10,2) not null,
	DENOM_COUNT           NUMBER(20),
	teller_id              varchar2(20),
	RCRE_USER_ID        VARCHAR2(15) not null,	  
	RCRE_TIME          DATE  not null,
	LCHG_USER_ID      VARCHAR2(15) not null,
	LCHG_TIME         DATE  not null,
	DEL_FLG           char(1) not null,
	bank_id		  varchar(8 char)
)
TABLESPACE CUSTOM_TBLS
/
CREATE  SYNONYM custom.C_DENM_DR for custom.CUST_DENOM_MASTER_DR_TMP
/
CREATE  SYNONYM tbagen.C_DENM_DR for custom.CUST_DENOM_MASTER_DR_TMP
/
CREATE  SYNONYM tbautil.C_DENM_DR for custom.CUST_DENOM_MASTER_DR_TMP
/
CREATE SYNONYM TBAADM.C_DENM_DR FOR CUSTOM.CUST_DENOM_MASTER_DR_TMP
/

CREATE UNIQUE INDEX IDX_CUST_DENOM_MASTER_DR_TMP on  custom.CUST_DENOM_MASTER_DR_TMP(SOL_ID,CRNCY_CODE,DENOM_IND,DENOM_VALUE,TELLER_ID,bank_id)
TABLESPACE CUSTOM_IDXSPACE 
/

GRANT select, insert, update, delete on custom.CUST_DENOM_MASTER_DR_TMP to tbagen,tbaadm
/ 
GRANT SELECT on custom.CUST_DENOM_MASTER_DR_TMP to tbautil
/ 


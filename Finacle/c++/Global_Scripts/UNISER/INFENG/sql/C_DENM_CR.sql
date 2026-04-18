
Rem     This file will create custom.CUST_DENOM_MASTER_CR_TMP
Rem     with the following characteristics.

Rem TABLE NAME: CUST_DENOM_MASTER_CR_TMP

DROP table custom.CUST_DENOM_MASTER_CR_TMP
/
DROP  SYNONYM custom.C_DENM_CR
/
DROP  SYNONYM tbagen.C_DENM_CR
/
DROP  SYNONYM tbautil.C_DENM_CR
/
DROP  SYNONYM TBAADM.C_DENM_CR
/
CREATE TABLE custom.CUST_DENOM_MASTER_CR_TMP
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
CREATE  SYNONYM custom.C_DENM_CR for custom.CUST_DENOM_MASTER_CR_TMP
/
CREATE  SYNONYM tbagen.C_DENM_CR for custom.CUST_DENOM_MASTER_CR_TMP
/
CREATE  SYNONYM tbautil.C_DENM_CR for custom.CUST_DENOM_MASTER_CR_TMP
/
CREATE SYNONYM TBAADM.C_DENM_CR FOR CUSTOM.CUST_DENOM_MASTER_CR_TMP
/
CREATE UNIQUE INDEX C_DENM_CR on  custom.CUST_DENOM_MASTER_CR_TMP(SOL_ID,CRNCY_CODE,DENOM_IND,DENOM_VALUE,TELLER_ID,bank_id)
TABLESPACE CUSTOM_IDXSPACE 
/

GRANT select, insert, update, delete  on custom.CUST_DENOM_MASTER_CR_TMP to tbagen,tbaadm
/ 
GRANT select  on custom.CUST_DENOM_MASTER_CR_TMP to tbautil
/ 

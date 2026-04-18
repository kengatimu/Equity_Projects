Rem     This file will create custom.CUST_DENOM_MASTER
Rem     with the following characteristics.

Rem TABLE NAME: CUST_DENOM_MASTER

DROP table custom.CUST_DENOM_MASTER
/
DROP  SYNONYM custom.C_DENM
/
DROP  SYNONYM tbagen.C_DENM
/
DROP  SYNONYM tbautil.C_DENM
/
DROP  SYNONYM TBAADM.C_DENM
/

CREATE TABLE custom.CUST_DENOM_MASTER
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
CREATE  SYNONYM custom.C_DENM for custom.CUST_DENOM_MASTER
/
CREATE  SYNONYM tbagen.C_DENM for custom.CUST_DENOM_MASTER
/
CREATE  SYNONYM tbautil.C_DENM for custom.CUST_DENOM_MASTER
/
CREATE  SYNONYM TBAADM.C_DENM FOR CUSTOM.CUST_DENOM_MASTER
/

CREATE UNIQUE INDEX IDX_CUST_DENOM_MASTER on  custom.CUST_DENOM_MASTER(SOL_ID,CRNCY_CODE,DENOM_IND,DENOM_VALUE,TELLER_ID,bank_id)
TABLESPACE CUSTOM_IDXSPACE 
/

GRANT select ,delete,update,insert on custom.CUST_DENOM_MASTER to tbagen,tbaadm
/ 
GRANT select  on custom.CUST_DENOM_MASTER to tbautil
/ 

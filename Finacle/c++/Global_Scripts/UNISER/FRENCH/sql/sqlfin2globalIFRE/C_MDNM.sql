Rem     This file will create custom.CUST_MAIN_DENOM_MASTER
Rem     with the following characteristics.

Rem TABLE NAME: CUST_MAIN_DENOM_MASTER

DROP table custom.CUST_MAIN_DENOM_MASTER
/
DROP  SYNONYM custom.C_MDNM
/
DROP  SYNONYM tbagen.C_MDNM
/
DROP  SYNONYM tbautil.C_MDNM
/
DROP SYNONYM TBAADM.C_MDNM
/


CREATE TABLE custom.CUST_MAIN_DENOM_MASTER
(	
	SOL_ID			varchar2(20) not null,
	CRNCY_CODE         VARCHAR2(5) not null,
	DENOM_IND              CHAR(1) not null,
	DENOM_VALUE        NUMBER(10,2) not null,
	RCRE_USER_ID        VARCHAR2(15) not null,	  
	RCRE_TIME          DATE  not null,
	LCHG_USER_ID      VARCHAR2(15) not null,
	LCHG_TIME         DATE  not null,
	DEL_FLG           char(1) not null,
	bank_id		  varchar2(8)
)
TABLESPACE CUSTOM_TBLS
/
CREATE  SYNONYM custom.C_MDNM for custom.CUST_MAIN_DENOM_MASTER
/
CREATE  SYNONYM tbagen.C_MDNM for custom.CUST_MAIN_DENOM_MASTER
/
CREATE  SYNONYM tbautil.C_MDNM for custom.CUST_MAIN_DENOM_MASTER
/
CREATE SYNONYM TBAADM.C_MDNM FOR CUSTOM.CUST_MAIN_DENOM_MASTER
/

CREATE UNIQUE INDEX IDX_CUST_MAIN_DENOM_MASTER on  custom.CUST_MAIN_DENOM_MASTER(CRNCY_CODE,DENOM_IND,DENOM_VALUE)
TABLESPACE CUSTOM_IDXSPACE
/

GRANT select ,update,delete,insert  on custom.CUST_MAIN_DENOM_MASTER to tbagen,tbaadm
/ 
GRANT select   on custom.CUST_MAIN_DENOM_MASTER to tbautil
/

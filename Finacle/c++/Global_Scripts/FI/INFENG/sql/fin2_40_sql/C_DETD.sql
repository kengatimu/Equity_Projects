Rem TABLE NAME: CUST_DENOM_TRAN_DETAIL

DROP TABLE custom.CUST_DENOM_TRAN_DETAIL 
/
DROP  SYNONYM custom.C_DETD
/
DROP  SYNONYM tbagen.C_DETD
/
DROP  SYNONYM tbautil.C_DETD
/
DROP SYNONYM TBAADM.C_DETD
/

CREATE TABLE custom.CUST_DENOM_TRAN_DETAIL
(
	SOL_ID			VARCHAR2(20) not null,
	DXFER_ID            VARCHAR2(13) not null,
	DXFER_FLG            char(3) not null,
	PTRAN_TYPE            char(1) not null,
	CRNCY_CODE         VARCHAR2(3) not null,
	DENOM_IND              CHAR(1) not null,
	DENOM_VALUE        varchar2(80) not null,
	DENOM_COUNT           varchar2(80) not null,
	TYPE			varchar2(2),
	TELLER_ID              varchar2(20) not null,
	TRAN_DATE              DATE NOT NULL,
	VALUE_DATE             DATE NOT NULL,
	AUTH_MATRIX_ID		varchar2(5),
	PART_TRAN_SRL_NUM	varchar(4 char)  not null,
	RCRE_USER_ID        VARCHAR2(15) not null,	  
	RCRE_TIME          DATE  not null,
	LCHG_USER_ID      VARCHAR2(15) not null,
	LCHG_TIME         DATE  not null, 
	BANK_ID            VARCHAR2(8 CHAR)
)
TABLESPACE CUSTOM_TBLS
/
CREATE  SYNONYM custom.C_DETD for custom.CUST_DENOM_TRAN_DETAIL 
/
CREATE  SYNONYM tbagen.C_DETD for custom.CUST_DENOM_TRAN_DETAIL 
/
CREATE  SYNONYM tbautil.C_DETD for custom.CUST_DENOM_TRAN_DETAIL 
/
CREATE SYNONYM TBAADM.C_DETD FOR CUSTOM.CUST_DENOM_TRAN_DETAIL
/
CREATE UNIQUE INDEX IDX_C_DETD on CUST_DENOM_TRAN_DETAIL(SOL_ID, DXFER_ID, CRNCY_CODE, DENOM_IND, TRAN_DATE, DXFER_FLG, PTRAN_TYPE, TELLER_ID, TYPE, PART_TRAN_SRL_NUM)
TABLESPACE CUSTOM_IDXSPACE 
/

GRANT select ,delete,update,insert on custom.CUST_DENOM_TRAN_DETAIL to tbagen,tbaadm
/
GRANT select on custom.CUST_DENOM_TRAN_DETAIL to tbautil
/


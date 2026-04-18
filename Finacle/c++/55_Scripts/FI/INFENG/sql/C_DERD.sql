--------------------------------------------------------------------------------
Rem     This file will create custom.CUST_DENOM_ROUNDOFF_DETAIL
Rem     with the following characteristics.

Rem TABLE NAME: CUST_DENOM_ROUNDOFF_DETAIL

DROP TABLE custom.CUST_DENOM_ROUNDOFF_DETAIL 
/
DROP  SYNONYM custom.C_DERD
/
DROP  SYNONYM tbagen.C_DERD
/
DROP  SYNONYM tbautil.C_DERD
/
DROP  SYNONYM TBAADM.C_DERD
/
CREATE TABLE custom.CUST_DENOM_ROUNDOFF_DETAIL
(
	SOL_ID		    VARCHAR2(20) not null,
	DXFER_ID            VARCHAR2(13) not null,
	DXFER_FLG            char(3) not null,
	PTRAN_TYPE            char(1) not null,
	CRNCY_CODE         VARCHAR2(3) not null,
	TRAN_DATE              date not null,
	ROUNDOFF_AMT            number(10,2) not null,
	TELLER_ID               varchar2(15) not null,
	STATUS			char(1),
	AUTH_MATRIX_ID		varchar2(5),
	bank_id		  varchar(8 char)
)
TABLESPACE CUSTOM_TBLS
/
CREATE  SYNONYM custom.C_DERD for custom.CUST_DENOM_ROUNDOFF_DETAIL 
/
CREATE  SYNONYM tbagen.C_DERD for custom.CUST_DENOM_ROUNDOFF_DETAIL 
/
CREATE  SYNONYM tbautil.C_DERD for custom.CUST_DENOM_ROUNDOFF_DETAIL 
/
CREATE SYNONYM TBAADM.C_DERD FOR CUSTOM.CUST_DENOM_ROUNDOFF_DETAIL
/
CREATE UNIQUE INDEX IDX_C_DERD on custom.CUST_DENOM_ROUNDOFF_DETAIL(sol_id,dxfer_id,dxfer_flg,ptran_type,crncy_code,tran_date,teller_id)
TABLESPACE CUSTOM_IDXSPACE
/

GRANT select ,delete,insert,update on custom.CUST_DENOM_ROUNDOFF_DETAIL to tbagen,tbaadm
/ 
GRANT select  on custom.CUST_DENOM_ROUNDOFF_DETAIL to tbautil
/ 

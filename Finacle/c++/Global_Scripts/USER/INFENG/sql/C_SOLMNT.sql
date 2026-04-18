--------------------------------------------------------------------------------
Rem     This file will create custom.CUST_SOL_MAINTANANCE
Rem     with the following characteristics.

Rem TABLE NAME: CUST_SOL_MAINTANANCE

DROP table custom.CUST_SOL_MAINTANANCE
/
DROP SYNONYM custom.C_SOLMNT
/
DROP SYNONYM tbagen.C_SOLMNT
/
DROP SYNONYM tbautil.C_SOLMNT
/
DROP SYNONYM TBAADM.C_SOLMNT
/

CREATE TABLE custom.CUST_SOL_MAINTANANCE
(	
	SOL_ID			varchar2(20) not null,
	DIS_FLG			varchar2(1) not null,
	BANK_ID            VARCHAR2(8 CHAR)
)
TABLESPACE CUSTOM_TBLS
/
CREATE  SYNONYM custom.C_SOLMNT for custom.CUST_SOL_MAINTANANCE
/
CREATE  SYNONYM tbagen.C_SOLMNT for custom.CUST_SOL_MAINTANANCE
/
CREATE  SYNONYM tbautil.C_SOLMNT for custom.CUST_SOL_MAINTANANCE
/
CREATE SYNONYM TBAADM.C_SOLMNT FOR CUSTOM.CUST_SOL_MAINTANANCE
/
CREATE UNIQUE INDEX IDX_CUST_SOL_MAINTANANCE on  custom.CUST_SOL_MAINTANANCE(SOL_ID,DIS_FLG)
TABLESPACE CUSTOM_IDXSPACE 
/

GRANT select, delete,update,insert  on custom.CUST_SOL_MAINTANANCE to tbagen,tbaadm
/ 
GRANT select   on custom.CUST_SOL_MAINTANANCE to tbautil
/ 

--====================================================================================================
-- Table Name               : CUST_BONUS_INTEREST_BOOKING
-- Synonym Name             : C_BIB
-- Index Name               : IDX_CUST_BI_BOOKING
-- Unique Index On          : TRAN_ID,TRAN_DATE,BANK_ID
-- Date                     : 26-JUN-2010
-- Description              : This sql is used to create a customized CUST_BONUS_INTEREST_BOOKING table,
--                              which is used for storing  bonus interest accrual details
-- Author                   : Harini P
-- Bank                     : EQUITY BANK
-- Modification History     :
--      <Version No.>   <Date>      <Author Name>       <Description>
--      0.1             25-Jul-10    Harini P           Draft Version
--      0.2		25-11-2011   Parikshith.V	Recon for V2
--====================================================================================================

Rem     This file will create custom.CUST_BONUS_INTEREST_BOOKING
Rem     with the following characteristics.

Rem TABLE NAME: CUST_BONUS_INTEREST_BOOKING
Rem SYNONYM: C_BIB

--DROP table custom.CUST_BONUS_INTEREST_BOOKING
--/
--DROP  SYNONYM custom.C_BIB
--/
--DROP  SYNONYM tbagen.C_BIB
--/
--DROP  SYNONYM tbautil.C_BIB
--/
--DROP  SYNONYM tbaadm.C_BIB
--/

CREATE TABLE custom.CUST_BONUS_INTEREST_BOOKING
(	
	TRAN_ID				VARCHAR2(20) not null,
	TRAN_DATE			DATE not null,
    REV_TRAN_ID         VARCHAR2(20),
	REV_TRAN_DATE       DATE,
	ACID 				VARCHAR2(11) not null,		
	BONUS_BKD_AMT		NUMBER(20,4) not null,
	RCRE_USER_ID        VARCHAR2(15) not null,	  
	RCRE_TIME         	DATE  not null,
	LCHG_USER_ID	    VARCHAR2(15) not null,
	LCHG_TIME	        DATE  not null,
	STATUS_FLG          CHAR(1) not null,
	BANK_ID 			VARCHAR2(8) not null
)
TABLESPACE CUSTOM_TBLS
/
CREATE  SYNONYM custom.C_BIB for custom.CUST_BONUS_INTEREST_BOOKING
/
CREATE  SYNONYM tbagen.C_BIB for custom.CUST_BONUS_INTEREST_BOOKING
/
CREATE  SYNONYM tbautil.C_BIB for custom.CUST_BONUS_INTEREST_BOOKING
/
CREATE  SYNONYM tbaadm.C_BIB for custom.CUST_BONUS_INTEREST_BOOKING
/

CREATE UNIQUE INDEX IDX_CUST_BI_BOOKING on  custom.CUST_BONUS_INTEREST_BOOKING(TRAN_ID,TRAN_DATE,BANK_ID)
TABLESPACE CUSTOM_IDXSPACE 
/
GRANT select ,delete,update,insert on custom.CUST_BONUS_INTEREST_BOOKING to tbagen,tbaadm
/ 
GRANT select  on custom.CUST_BONUS_INTEREST_BOOKING to tbautil
/ 

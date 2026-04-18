--====================================================================================================
-- Table Name               : CUST_BONUS_INTEREST_APPLY
-- Synonym Name             : C_BIA
-- Index Name               : IDX_CUST_BI_APPLY
-- Unique Index On          : TRAN_ID,TRAN_DATE,BANK_ID
-- Date                     : 26-JUN-2010
-- Description              : This sql is used to create a customized CUST_BONUS_INTEREST_APPLY table,
--                              which is used for storing  bonus interest payment details
-- Author                   : Harini P
-- Bank                     : EQUITY BANK
-- Modification History     :
--      <Version No.>   <Date>      <Author Name>       <Description>
--      0.1             25-Jul-10    Harini P           Draft Version
--      0.2		25-11-2011	Parikshith.V	    Recon for V2
--====================================================================================================

Rem     This file will create custom.CUST_BONUS_INTEREST_APPLY
Rem     with the following characteristics.

Rem TABLE NAME: CUST_BONUS_INTEREST_APPLY
Rem SYNONYM: C_BIA

--DROP table custom.CUST_BONUS_INTEREST_APPLY
--/
--DROP  SYNONYM custom.C_BIA
--/
--DROP  SYNONYM tbagen.C_BIA
--/
--DROP  SYNONYM tbautil.C_BIA
--/
--DROP  SYNONYM tbaadm.C_BIA
--/

CREATE TABLE custom.CUST_BONUS_INTEREST_APPLY
(	
	TRAN_ID				VARCHAR2(20) not null,
	TRAN_DATE			DATE not null,
	WHT_TRAN_ID			VARCHAR2(20) ,
	ACID 				VARCHAR2(11) not null,		
	BONUS_AMT	NUMBER(20,4) not null,
	WHT_AMT		NUMBER(20,4) not null,
	RCRE_USER_ID        VARCHAR2(15) not null,	  
	RCRE_TIME         	DATE  not null,
	LCHG_USER_ID	    VARCHAR2(15) not null,
	LCHG_TIME	        DATE  not null,
	BANK_ID 			VARCHAR2(8) not null
)
TABLESPACE CUSTOM_TBLS
/
CREATE OR REPLACE SYNONYM custom.C_BIA for custom.CUST_BONUS_INTEREST_APPLY
/
CREATE OR REPLACE SYNONYM tbagen.C_BIA for custom.CUST_BONUS_INTEREST_APPLY
/
CREATE OR REPLACE SYNONYM tbautil.C_BIA for custom.CUST_BONUS_INTEREST_APPLY
/
CREATE OR REPLACE SYNONYM tbaadm.C_BIA for custom.CUST_BONUS_INTEREST_APPLY
/

CREATE UNIQUE INDEX IDX_CUST_BI_APPLY on  custom.CUST_BONUS_INTEREST_APPLY(TRAN_ID,TRAN_DATE,BANK_ID)
TABLESPACE CUSTOM_IDXSPACE 
/
GRANT select ,delete,update,insert on custom.CUST_BONUS_INTEREST_APPLY to tbagen,tbaadm
/ 
GRANT select  on custom.CUST_BONUS_INTEREST_APPLY to tbautil
/ 

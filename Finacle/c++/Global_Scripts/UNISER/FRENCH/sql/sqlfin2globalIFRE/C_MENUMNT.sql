--====================================================================================================
-- Table Name           : CUST_SOL_MAINTANANCE
-- Synonym Name         : C_MENUMNT
-- Index Name           : 
-- Unique Index On      : 
-- Date                 : 6 june-2013
-- Description          : This sql script is used to create a customized CUST_SOL_MAINTANANCE
-- Author               : 
-- Module       : DENOM
-- Menu Name        : HDENSOL
-- Bank                 : STANDARD BANK
-- Modification History :
--                      <Version No.>    <Date>        <Author Name>    <Description>
--                          0.1         11-Jul-10       Sandeep Patil   Draft Version
--====================================================================================================

Rem     This file will create custom.CUST_SOL_MAINTANANCE
Rem     with the following characteristics.

Rem TABLE NAME: CUST_SOL_MAINTANANCE

DROP table custom.CUST_MENU_MAINTANANCE
/
DROP SYNONYM custom.C_MENUMNT
/
DROP SYNONYM tbagen.C_MENUMNT
/
DROP SYNONYM tbautil.C_MENUMNT
/
DROP SYNONYM tbaadm.C_MENUMNT
/

CREATE TABLE custom.CUST_MENU_MAINTANANCE
(
    MENU_ID      VARCHAR2(20) not null,
DIS_FLG     VARCHAR2(1) not null,
    BANK_ID     VARCHAR2 (8 Char) not null
)
/
CREATE  SYNONYM custom.C_MENUMNT for custom.CUST_MENU_MAINTANANCE
/
CREATE  SYNONYM tbagen.C_MENUMNT for custom.CUST_MENU_MAINTANANCE
/
CREATE  SYNONYM tbautil.C_MENUMNT for custom.CUST_MENU_MAINTANANCE
/
CREATE  SYNONYM tbaadm.C_MENUMNT for custom.CUST_MENU_MAINTANANCE
/
CREATE UNIQUE INDEX IDX_CUST_MENU_MAINTANANCE on  custom.CUST_MENU_MAINTANANCE(MENU_ID,DIS_FLG,BANK_ID)
/
GRANT select, delete,update,insert  on custom.CUST_MENU_MAINTANANCE to tbagen,tbaadm
/
GRANT select   on custom.CUST_MENU_MAINTANANCE to tbautil
/

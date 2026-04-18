set numformat 999999999999.99
SET SERVEROUTPUT ON  size 100000
set maxdata 60000
set lines 225
set pages 1000
set pagesize 0
set term off
set echo off
set pause off
set verify off
set feed off

spool BGPrnt3.lst

DECLARE

-- CURSORS:
  
	--none

-- VARIABLES:

	loc_Client_Name1						varchar2(50);
	loc_Address_NUMBER						varchar2(50);
	loc_Address_STREET						varchar2(50);
	loc_Address_AREA						varchar2(50);
	loc_Address_CITY						varchar2(50);
	loc_Address_COUNTRY						varchar2(50);
	loc_City_name							varchar2(50);
	loc_Date							varchar2(50);
	loc_Client_Name2						varchar2(50);
	loc_Legal_Rep							varchar2(50);
	loc_end							varchar2(3);


BEGIN

   BEGIN --[
    select name,
    ADDRESS1,
    ADDRESS2,
    ADDRESS3,
    (select REF_DESC from tbaadm.rct 
    where bank_id='&3' and ref_rec_type='01' 
    and ref_code=t1.city_code),
    (select REF_DESC from tbaadm.rct 
    where bank_id='&3' and ref_rec_type='03' 
    and ref_code=t1.CNTRY_CODE),
    (select REF_DESC from tbaadm.rct where bank_id='&3' and ref_rec_type='01' and ref_code=(
    select city_code from tbaadm.sol where sol_id='&2')),
    (select to_char(issue_date,'YYYY') from tbaadm.bgm where bg_srl_num='&1'),Name,
	(select ref_desc from tbaadm.rct where bank_id='&3' and REF_REC_TYPE='98' and ref_code=(
	select Free_code3 from tbaadm.bgm where bg_srl_num='&1')), 'END'
	into loc_Client_Name1,loc_Address_NUMBER,loc_Address_STREET,loc_Address_AREA,loc_Address_CITY,loc_Address_COUNTRY,
	loc_City_name,loc_Date,loc_Client_Name2,loc_Legal_Rep, loc_end
    from tbaadm.tfat t1 where addr_b2kid=(select BG_B2KID from tbaadm.bgm where bg_srl_num='&1')
    and addr_id='BGOUPY' and del_flg='N';

    EXCEPTION
    WHEN no_data_found THEN
         loc_Client_Name1	  	  := NULL;
		 loc_Address_NUMBER		  := NULL;
		 loc_Address_STREET		  := NULL;
		 loc_Address_AREA		  := NULL;
		 loc_Address_CITY		  := NULL;
		 loc_Address_COUNTRY      := NULL;
		 loc_City_name			  := NULL;
		 loc_Date				  := NULL;
		 loc_Client_Name2	      := NULL;
		 loc_Legal_Rep	          := NULL;

    END; --]

       dbms_output.put_line( loc_Client_Name1 ||'|'|| loc_Address_NUMBER    ||'|'||
							 loc_Address_STREET ||'|'|| loc_Address_AREA   ||'|'||
							 loc_Address_CITY ||'|'|| loc_Address_COUNTRY   ||'|'||
							 loc_City_name ||'|'|| loc_Date   ||'|'||  loc_Client_Name2 ||'|'||  loc_Legal_Rep ||'|'||  loc_end							 );
END; 
/
spool off
exit

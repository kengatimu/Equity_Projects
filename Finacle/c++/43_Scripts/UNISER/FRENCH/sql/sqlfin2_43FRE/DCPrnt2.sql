set numformat 999999999999.99
SET SERVEROUTPUT ON  size 100000
set maxdata 60000
set lines 600
set pages 1000
set pagesize 0
set term off
set echo off
set pause off
set verify off
set feed off

spool DCPrnt2.lst

DECLARE

-- CURSORS
  
    --none

-- VARIABLES

	loc_shpd_prd			varchar2(150);
	loc_shpd_term           varchar2(150);
	loc_plc_exp             varchar2(150);
	loc_goodsrv_dtls        varchar2(150);
	loc_issue_bank          varchar2(150);
	loc_issue_addr          varchar2(150);
	loc_appl_name           varchar2(150);
	loc_issue_sol           varchar2(150);
	loc_issue_date          varchar2(150);
	loc_end   				varchar2(3);


BEGIN

   BEGIN --[
        select text,
		SHIPMENT_TERMS,
		PLACE_OF_EXPIRY,
		(select text
		from tbaadm.tftt t where text_id=d.dc_b2kid
		and t.bank_id=d.bank_id
		and module_id='DOCCR'
		and text_type='G'
		and d.bank_id=t.bank_id),
		(select name from  tbaadm.tfat t where addr_b2kid=d.dc_b2kid
		and t.bank_id=d.bank_id
		and addr_id='DCISBK'
		and addr_type='S'),
		(select address1 from  tbaadm.tfat t where addr_b2kid=d.dc_b2kid
		and t.bank_id=d.bank_id
		and addr_id='DCISBK'
		and addr_type='S'),
		(select name from  tbaadm.tfat t where addr_b2kid=d.dc_b2kid
		and t.bank_id=d.bank_id
		and addr_id='DCAPBK'
		and addr_type='S'),
		(select REF_DESC from tbaadm.rct where bank_id='&2' and ref_rec_type='01' and ref_code=(
		select city_code from tbaadm.sol where sol_id=d.sol_id and bank_id='&2')),
		DATE_OPND,'end'
		into loc_shpd_prd, loc_shpd_term, loc_plc_exp, loc_goodsrv_dtls, 
		loc_issue_bank, loc_issue_addr, loc_appl_name, loc_issue_sol, 
		loc_issue_date, loc_end 
		from tbaadm.tftt t,tbaadm.dcmm d where text_id=dc_b2kid
		and t.bank_id=d.bank_id
		and d.dc_ref_num='&1'
		and module_id='DOCCR'
		and text_type='O'
		and d.bank_id='&2';

    EXCEPTION
    WHEN no_data_found THEN
			loc_shpd_prd			:= NULL;
			loc_shpd_term           := NULL;
			loc_plc_exp             := NULL;
			loc_goodsrv_dtls        := NULL;
			loc_issue_bank          := NULL;
			loc_issue_addr          := NULL;
			loc_appl_name           := NULL;
			loc_issue_sol           := NULL;
			loc_issue_date          := NULL;
			loc_end   				:= NULL;

         
    END; --]

       dbms_output.put_line( 
            loc_shpd_prd			||'|'||
			loc_shpd_term           ||'|'||
			loc_plc_exp             ||'|'||
			loc_goodsrv_dtls        ||'|'||
			loc_issue_bank          ||'|'||
			loc_issue_addr          ||'|'||
			loc_appl_name           ||'|'||
			loc_issue_sol           ||'|'||
			loc_issue_date          ||'|'||
			loc_end                            
                             );
END; 
/
spool off
exit

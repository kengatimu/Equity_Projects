---------------------------------------------------------------------------------
--Name			: MassAcct.Sql                                                            
--Description		: It will Extract Mass acctouts opened                             
--Date			: 10-08-2021                                                              
--Author		: Irungu James                                                            
--Input			: NA                                                                      
--Output		: NA                                                                      
--1.0			04-06-2021		Irungu James		Original Version          
---------------------------------------------------------------------------------
set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool MassAcct.lst
select gam.sol_id||'|'||gam.foracid||'|'||gam.iban_number||'|'||substr(gam.ACCT_NAME,1,30)||'|'|| gam.schm_code||'|'||acct_crncy_code||'|'||gam.cif_id ||'|'||c.NATIONAL_ID ||'|'|| gam.acct_opn_date  from CUSTOM.BULK_CIF_DRC_SELF c, tbaadm.gam 
where c.ENTITY_CRE_FLG ='S' and c.foracid =gam.foracid 
and c.SEQUENCE ='&2'
and gam.bank_id ='&1';
spool off;
exit;
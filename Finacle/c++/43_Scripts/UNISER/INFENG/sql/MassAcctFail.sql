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
spool MassAcctFail.lst
select sol_id||'|'||NATIONAL_ID||'|'|| substr(FIRST_NAME,1,30) ||'|'|| schm_code||'|'||CRNCY||'|'|| cif_id ||'|'|| substr(error_code,1,70)   from CUSTOM.BULK_CIF_DRC_SELF 
where ENTITY_CRE_FLG !='S'and SEQUENCE ='&2' and bank_id ='&1';
spool off;
exit;

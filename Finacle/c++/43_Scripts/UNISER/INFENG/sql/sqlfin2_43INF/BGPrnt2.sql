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

spool BGPrnt2.lst

DECLARE

-- CURSORS:
  
	--none

-- VARIABLES:

	loc_crncy_code1				varchar2(150);
	loc_BG_amount1	            varchar2(150);
	loc_ben_name	            varchar2(150);
	loc_ben_add1	            varchar2(150);
	loc_ben_city	            varchar2(150);
	loc_ben_area	            varchar2(150);
	loc_Client_Name	            varchar2(150);
	loc_Market_Ref	            varchar2(150);
	loc_BOD	                    varchar2(150);
	loc_Purpose_of_BG	        varchar2(150);
	loc_crncy_code2	            varchar2(150);
	loc_BG_amount2	            varchar2(150);
	loc_Eff_date	            varchar2(150);
	loc_Exp_date	            varchar2(150);
	loc_SOL_City	            varchar2(150);
	loc_Issue_date	            varchar2(150);
	loc_Responsible1	        varchar2(150);
	loc_Resp1_designation	    varchar2(150);
	loc_Responsible2	        varchar2(150);
	loc_Resp2_designation	    varchar2(150);
	loc_end                     varchar2(3);


BEGIN

   BEGIN --[
       select 
    (select crncy_code from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
    (select bg_amt from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
    name,
    address1,
   (select REF_DESC from tbaadm.rct 
   where bank_id='&3' and ref_rec_type='01' 
   and ref_code=t1.city_code),
   address3,
   (select name  from tbaadm.tfat t1 where addr_b2kid=(select BG_B2KID from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3')
   and addr_id='BGOUPY' and del_flg='N'),
   --'AOI N°F04/CGPMP/MINIAGRI/2017',
   (select PLACE_LODGEMNT_CLAIM from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
   (select to_char(db_stat_date,'monthYYYY') from tbaadm.gct where bank_id='&3'),
   (select purpose_of_bg from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
   (select crncy_code from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
   (select bg_amt from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
   (select to_char(effective_date,'dd monthyyyy') from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
   (select to_char(bg_expiry_date,'dd monthyyyy') from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
   (select REF_DESC from tbaadm.rct where bank_id='&3' and ref_rec_type='01' and ref_code=(
   select city_code from tbaadm.sol where sol_id='&2')),
   (select to_char(issue_date,'dd monthyyyy') from tbaadm.bgm where bg_srl_num='&1' and bank_id='&3'),
   (select ref_desc from tbaadm.rct where bank_id='&3' and REF_REC_TYPE='96' and ref_code=(
   select Free_code1 from tbaadm.bgm where bg_srl_num='&1')),
   (select ref_desc from tbaadm.get,tbaadm.upr,tbaadm.rct
   where lower(trim(emp_name)) = (select lower(trim(ref_desc)) from tbaadm.rct where bank_id='&3' and REF_REC_TYPE='96' and ref_code=(
   select Free_code1 from tbaadm.bgm where bg_srl_num='&1'))
   and get.del_flg='N'
   and get.emp_id=upr.user_emp_id
   and ref_rec_type='29' and bank_id='&3'
   and ref_code=user_work_class),
   (select ref_desc from tbaadm.rct where bank_id='&3' and REF_REC_TYPE='97' and ref_code=(
   select Free_code2 from tbaadm.bgm where bg_srl_num='&1')),
   (select ref_desc from tbaadm.get,tbaadm.upr,tbaadm.rct
   where lower(trim(emp_name)) = (select lower(trim(ref_desc)) from tbaadm.rct where bank_id='&3' and REF_REC_TYPE='97' and ref_code=(
   select Free_code2 from tbaadm.bgm where bg_srl_num='&1'))
   and get.del_flg='N'
   and get.emp_id=upr.user_emp_id
   and ref_rec_type='29' and bank_id='&3'
   and ref_code=user_work_class), 'end'
  into loc_crncy_code1, loc_BG_amount1, loc_ben_name, loc_ben_add1, loc_ben_city, loc_ben_area, 
  loc_Client_Name, loc_Market_Ref, loc_BOD, loc_Purpose_of_BG, loc_crncy_code2, loc_BG_amount2, 
  loc_Eff_date, loc_Exp_date, loc_SOL_City, loc_Issue_date, loc_Responsible1, loc_Resp1_designation, 
  loc_Responsible2, loc_Resp2_designation, loc_end
   from tbaadm.tfat t1 where addr_b2kid=(select BG_B2KID from tbaadm.bgm where bg_srl_num='&1')
   and addr_id='BGOTPY' and del_flg='N'
   and addr_type='S';

    EXCEPTION
    WHEN no_data_found THEN
        loc_crncy_code1				:= NULL;
		loc_BG_amount1	            := NULL;
		loc_ben_name	            := NULL;
		loc_ben_add1	            := NULL;
		loc_ben_city	            := NULL;
		loc_ben_area	            := NULL;
		loc_Client_Name	            := NULL;
		loc_Market_Ref	            := NULL;
		loc_BOD	                    := NULL;
		loc_Purpose_of_BG	        := NULL;
		loc_crncy_code2	            := NULL;
		loc_BG_amount2	            := NULL;
		loc_Eff_date	            := NULL;
		loc_Exp_date	            := NULL;
		loc_SOL_City	            := NULL;
		loc_Issue_date	            := NULL;
		loc_Responsible1	        := NULL;
		loc_Resp1_designation	    := NULL;
		loc_Responsible2	        := NULL;
		loc_Resp2_designation	    := NULL;
		loc_end                     := NULL;
		 
    END; --]

       dbms_output.put_line(loc_crncy_code1				||'|'||
							loc_BG_amount1	            ||'|'||
							loc_ben_name	            ||'|'||
							loc_ben_name	            ||'|'||
							loc_ben_add1	            ||'|'||
							loc_ben_city	            ||'|'||
							loc_ben_area	            ||'|'||
							loc_Client_Name	            ||'|'||
							loc_Market_Ref	            ||'|'||
							loc_BOD	                    ||'|'||
							loc_Purpose_of_BG	        ||'|'||
							loc_crncy_code2	            ||'|'||
							loc_BG_amount2	            ||'|'||
							loc_Eff_date	            ||'|'||
							loc_Exp_date	            ||'|'||
							loc_SOL_City	            ||'|'||
							loc_Issue_date	            ||'|'||
							loc_Responsible1	        ||'|'||
							loc_Resp1_designation	    ||'|'||
							loc_Responsible2	        ||'|'||
							loc_Resp2_designation	    ||'|'||
							loc_end                                     
							 );
END; 
/
spool off
exit

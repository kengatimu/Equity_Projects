---------------------------------------------------------------------------------
--    File Name                  : hruserval.sql
--    Tables Used                : GAM
--    Date                       : 22.02.2013
--    Author                     : Gokulkrishna
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          22.02.2013     Gokulkrishna                  Original Version
-----------------------------------------------------------------------------------
set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool hruserval.lst
select UPR.sol_id||'|'|| emp_id ||'|'|| user_id ||'|'||emp_name||' Role_Id  '||role_id ||' Workclass  '|| user_work_class||' Bank_id  '||home_bank_id as Employee_details
from tbaadm.upr ,tbaadm.get where emp_id = user_emp_id and user_work_class  not in ('011') and VIRTUAL_FLG ='N'
and upr.del_flg='N' and upr.sol_id= '&1' AND home_bank_id='&2' and   lpad(emp_id,5,0) not  in ( SELECT DISTINCT  lpad(papf.employee_number,5,0) 
FROM hr.per_all_people_f@ERPLINK papf, hr.per_all_assignments_f@ERPLINK paaf, hr.per_person_types@ERPLINK ppt, hr.per_periods_of_service@ERPLINK pps,
per_assignment_status_types@ERPLINK past, apps.hr_locations@ERPLINK loc  WHERE papf.person_id = paaf.person_id AND ppt.person_type_id = papf.person_type_id
AND ppt.user_person_type = 'Employee' AND pps.person_id = papf.person_id AND pps.person_id = paaf.person_id  AND loc.location_id = paaf.location_id
AND papf.business_group_id = '81' AND paaf.business_group_id = '81' AND past.user_status not IN ('%Seconded%')
AND pps.period_of_service_id = paaf.period_of_service_id AND SYSDATE BETWEEN papf.effective_start_date
AND papf.effective_end_date AND SYSDATE BETWEEN paaf.effective_start_date  AND paaf.effective_end_date);
spool off;
exit;

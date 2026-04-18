CREATE OR REPLACE procedure EQUITY_CIFEAppGroup AS
cursor c_user_id is select loginid from crmuser.users where loginid in 
    (select user_id from tbaadm.upr where role_id in ('BRM','AMO') and home_bank_id='54' and del_flg='N');
v_grpid crmuser.SRMGROUPS.GROUPID%TYPE;
cur_id c_user_id%ROWTYPE;
v_login_id crmuser.users.loginid%TYPE;
v_person_id CRMUSER.USERS.PERSONID%TYPE;


begin
select groupid into v_grpid from crmuser.srmgroups where groupname in 
(select labelcode from crmuser.miscdictionary where localetext like 'CIF EDIT APPROVERS' and rownum <=1);

open c_user_id;
  loop
    fetch c_user_id into cur_id;
    EXIT WHEN c_user_id%NOTFOUND;
    v_login_id := cur_id.loginid;
    
    select personid into v_person_id from crmuser.users where loginid = v_login_id and ROWNUM <= 1;   
    
   
    Insert into CRMUSER.USER_GROUPS
       (PERSONID, GROUPID, BANK_ID, ROLEID, EXTENSIONID, 
        TMDATE)
     Values
       (v_person_id, v_grpid, '54', '1', NULL, 
    SYSDATE);
    
    Update crmuser.agent_entity_details set primarygroupid = v_grpid where personid =v_person_id and bank_id='54';
     
        commit;
end loop;
close c_user_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL;
    WHEN OTHERS THEN
        ROLLBACK;
end EQUITY_CIFEAppGroup;
/

set define off; 
variable mopNum varchar2(5); 
begin 
select nvl(to_char(max(to_number(mop_num))+1), '1') into :mopNum from tbaadm.mno where menu_id = 'FIMNU'; 
exception when no_data_found then 
    :mopNum := 1; 
end; 

/ 
drop table tbaadm.tmp_mod 
/ 
create table tbaadm.tmp_mod as  
    (select * from tbaadm.mod  
    where mop_id = 'HACM') 
/ 
set define off; 
variable mopNum varchar2(5); 
begin 
select nvl(to_char(max(to_number(mop_num))+1), '1') from tbaadm.mno where menu_id = 'FIMNU'; 
exception when no_data_found then 
    :mopNum := 1; 
end; 
/ 
drop table tbaadm.tmp_mod 
/ 
create table tbaadm.tmp_mod as  
    (select * from tbaadm.mod  
    where mop_id = 'HACM') 
/ 
update tbaadm.tmp_mod  
    set MOP_ID = 'CORPSIG', 
    MOP_TYPE = 'U', 
    EXE_NAME='https://$W/finbranch',  
    INPUT_FILENAME = 'Customize/Customize_ctrl.jsp?sessionid=$S', ADDITIONAL_PARAMS='&CORPSIG=$TCORPSIG=$SCORPSIG=$CCORPSIG=$' 
/ 
commit 
/ 
delete from tbaadm.mod where MOP_ID='CORPSIG' 
/ 
insert into tbaadm.mod select * from tbaadm.tmp_mod 
/ 
commit 
/ 
drop table tbaadm.tmp_mod 
/ 
create table tbaadm.tmp_mod as  
    (select * from tbaadm.mod_txt  
    where MOP_ID = 'HACM') 
/ 
update tbaadm.tmp_mod  
    set MOP_ID = 'CORPSIG' ,  
    USER_MOP_ID = 'CORPSIG',  
    MOP_TEXT = 'CORPSIG' 
/ 
commit 
/ 
delete from tbaadm.mod_txt where MOP_ID='CORPSIG' 
/ 
insert into tbaadm.mod_txt select * from tbaadm.tmp_mod 
/ 
commit 
/ 
drop table tbaadm.tmp_mod 
/ 
drop table tbaadm.tmp_oat 
/ 
create table tbaadm.tmp_oat as  
    (select * from tbaadm.oat  
    where mop_id = 'HACM')
/
update tbaadm.tmp_oat
    set MOP_ID = 'CORPSIG' 
/ 
commit 
/
delete from tbaadm.oat where MOP_ID='CORPSIG' 
/ 
insert into tbaadm.oat select * from tbaadm.tmp_oat 
/ 
commit
/
drop table tbaadm.tmp_oat
/ 
create table tbaadm.tmp_mod as      
    (select * from tbaadm.mno where MOP_ID = 'HACM') 
/ 
update tbaadm.tmp_mod  
    set MOP_ID = 'CORPSIG', 
    MOP_NUM='72',  
    menu_id = 'FIMNU' 
/ 
commit 
/ 
delete from tbaadm.mno where MOP_ID='CORPSIG' 
/ 
insert into tbaadm.mno select * from tbaadm.tmp_mod 
/ 
commit 
/ 

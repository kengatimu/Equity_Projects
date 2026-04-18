-------------------------------------------------------------------------------------------------------
-- Name                 : CreateMenu_CTRM_54.sql
-- Date                 : 28-Aug-2013
-- Description          : This script is used for creating a new custom menu CTRM.
-- Author               : Nitin Prabhakar
-------------------------------------------------------------------------------------------------------
set verify off
set head off
set trims on
set pages 0
variable mopNum varchar2(2);
begin
select nvl(to_char(max(to_number(mop_num))+1), '01') into :mopNum from tbaadm.mno where menu_id = 'ONSDBMNU' and bank_id = '54';
end;
/
delete tbaadm.mod where mop_id = 'CTRM' and bank_id = '54';
set escape \
INSERT INTO tbaadm.MOD  VALUES('CTRM','Y','N','U','https://$W/$A/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CTRM\&mtype=F','C','BT','TT','FT','MT','','','BT','CO','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'002010900N901999N','','54','','N','','');
delete tbaadm.oat where mop_id = 'CTRM' and bank_id = '54';
insert into tbaadm.oat values ('CTRM', 'GU', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'54');
insert into tbaadm.oat values ('CTRM', 'DB', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'54');
delete tbaadm.mod_txt where mop_id = 'CTRM' and bank_id = '54';
insert into tbaadm.mod_txt values ('CTRM', 'INFENG', 'CTRM', 'Temp Role ID Maintenance', '','Y', 'TBAADM', 'TBAADM', sysdate,sysdate,'0','54');
delete tbaadm.mno where mop_id = 'CTRM' and bank_id = '54';
begin
insert into tbaadm.mno values ('ONSDBMNU', :mopNum, 'CTRM','Y','U','TBAADM', sysdate, 'TBAADM', sysdate,'0','54');
end;
/
commit
/

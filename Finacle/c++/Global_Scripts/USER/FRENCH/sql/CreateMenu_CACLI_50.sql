-------------------------------------------------------------------------------------------------------
-- Name                 : CreateMenu_CACLI_50.sql
-- Date                 : 17-June-2013
-- Description          : This script is used for creating a new custom menu CACLI.
-- Author               : Nitin Kumar
-------------------------------------------------------------------------------------------------------
set verify off
set head off
set trims on
set pages 0
variable mopNum varchar2(2);
begin
select nvl(to_char(max(to_number(mop_num))+1), '01') into :mopNum from tbaadm.mno where menu_id = 'ONSDBMNU' and bank_id = '50';
end;
/
delete tbaadm.mod where mop_id = 'CACLI' and bank_id = '50';
set escape \
INSERT INTO tbaadm.MOD  VALUES('CACLI','Y','N','U','https://$W/$A/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CACLI\&mtype=F','C','BT','TT','FT','MT','','','BT','CO','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'002010900N901999N','','50','','N','','');
delete tbaadm.oat where mop_id = 'CACLI' and bank_id = '50';
insert into tbaadm.oat values ('CACLI', 'GU', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'50');
insert into tbaadm.oat values ('CACLI', 'DB', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'50');
delete tbaadm.mod_txt where mop_id = 'CACLI' and bank_id = '50';
insert into tbaadm.mod_txt values ('CACLI', 'INFENG', 'CACLI', 'Custom Parameter Maintenance', '','Y', 'TBAADM', 'TBAADM', sysdate,sysdate,'0','50');
delete tbaadm.mno where mop_id = 'CACLI' and bank_id = '50';
begin
insert into tbaadm.mno values ('ONSDBMNU', :mopNum, 'CACLI','Y','U','TBAADM', sysdate, 'TBAADM', sysdate,'0','50');
end;
/
commit
/

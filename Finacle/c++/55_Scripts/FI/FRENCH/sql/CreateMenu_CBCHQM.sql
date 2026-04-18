-------------------------------------------------------------------------------------------------------
-- Name                 : CreateMenu_CBCHQM.sql
-- Date                 : 06-Nov-2013
-- Description          : This script is used for creating a new custom menu CBCHQM.
-- Author               : Bharath
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
delete tbaadm.mod where mop_id = 'CBCHQM' and bank_id = '54';
set escape \
INSERT INTO tbaadm.MOD  VALUES('CBCHQM','Y','N','U','https://$W/$A/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CBCHQM','C','BT','TT','FT','MT','','','BT','CO','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'002010900N901999N','','54','','N','','');
delete tbaadm.oat where mop_id = 'CBCHQM' and bank_id = '54';
insert into tbaadm.oat values ('CBCHQM', 'GU', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'54');
insert into tbaadm.oat values ('CBCHQM', 'DB', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'54');
delete tbaadm.mod_txt where mop_id = 'CBCHQM' and bank_id = '54';
insert into tbaadm.mod_txt values ('CBCHQM', 'INFENG', 'CBCHQM', 'Bankers Cheque Book Request Maintenance', '','Y', 'TBAADM', 'TBAADM', sysdate,sysdate,'0','54');
delete tbaadm.mno where mop_id = 'CBCHQM' and bank_id = '54';
begin
insert into tbaadm.mno values ('ONSDBMNU', :mopNum, 'CBCHQM','Y','U','TBAADM', sysdate, 'TBAADM', sysdate,'0','54');
end;
/
commit
/

begin
select nvl(to_char(max(to_number(mop_num))+1), '01') into :mopNum from tbaadm.mno where menu_id = 'ONSDBMNU' and bank_id = '55';
end;
/
delete tbaadm.mod where mop_id = 'CBCHQM' and bank_id = '55';
set escape \
INSERT INTO tbaadm.MOD  VALUES('CBCHQM','Y','N','U','https://$W/$A/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CBCHQM','C','BT','TT','FT','MT','','','BT','CO','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'002010900N901999N','','55','','N','','');
delete tbaadm.oat where mop_id = 'CBCHQM' and bank_id = '55';
insert into tbaadm.oat values ('CBCHQM', 'GU', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'55');
insert into tbaadm.oat values ('CBCHQM', 'DB', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'55');
delete tbaadm.mod_txt where mop_id = 'CBCHQM' and bank_id = '55';
insert into tbaadm.mod_txt values ('CBCHQM', 'INFENG', 'CBCHQM', 'Bankers Cheque Book Request Maintenance', '','Y', 'TBAADM', 'TBAADM', sysdate,sysdate,'0','55');
delete tbaadm.mno where mop_id = 'CBCHQM' and bank_id = '55';
begin
insert into tbaadm.mno values ('ONSDBMNU', :mopNum, 'CBCHQM','Y','U','TBAADM', sysdate, 'TBAADM', sysdate,'0','55');
end;
/
commit
/

begin
select nvl(to_char(max(to_number(mop_num))+1), '01') into :mopNum from tbaadm.mno where menu_id = 'ONSDBMNU' and bank_id = '56';
end;
/
delete tbaadm.mod where mop_id = 'CBCHQM' and bank_id = '56';
set escape \
INSERT INTO tbaadm.MOD  VALUES('CBCHQM','Y','N','U','https://$W/$A/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CBCHQM','C','BT','TT','FT','MT','','','BT','CO','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'002010900N901999N','','56','','N','','');
delete tbaadm.oat where mop_id = 'CBCHQM' and bank_id = '56';
insert into tbaadm.oat values ('CBCHQM', 'GU', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'56');
insert into tbaadm.oat values ('CBCHQM', 'DB', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'56');
delete tbaadm.mod_txt where mop_id = 'CBCHQM' and bank_id = '56';
insert into tbaadm.mod_txt values ('CBCHQM', 'INFENG', 'CBCHQM', 'Bankers Cheque Book Request Maintenance', '','Y', 'TBAADM', 'TBAADM', sysdate,sysdate,'0','56');
delete tbaadm.mno where mop_id = 'CBCHQM' and bank_id = '56';
begin
insert into tbaadm.mno values ('ONSDBMNU', :mopNum, 'CBCHQM','Y','U','TBAADM', sysdate, 'TBAADM', sysdate,'0','56');
end;
/
commit
/

begin
select nvl(to_char(max(to_number(mop_num))+1), '01') into :mopNum from tbaadm.mno where menu_id = 'ONSDBMNU' and bank_id = '50';
end;
/
delete tbaadm.mod where mop_id = 'CBCHQM' and bank_id = '50';
set escape \
INSERT INTO tbaadm.MOD  VALUES('CBCHQM','Y','N','U','https://$W/$A/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CBCHQM','C','BT','TT','FT','MT','','','BT','CO','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'002010900N901999N','','50','','N','','');
delete tbaadm.oat where mop_id = 'CBCHQM' and bank_id = '50';
insert into tbaadm.oat values ('CBCHQM', 'GU', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'50');
insert into tbaadm.oat values ('CBCHQM', 'DB', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'50');
delete tbaadm.mod_txt where mop_id = 'CBCHQM' and bank_id = '50';
insert into tbaadm.mod_txt values ('CBCHQM', 'INFENG', 'CBCHQM', 'Bankers Cheque Book Request Maintenance', '','Y', 'TBAADM', 'TBAADM', sysdate,sysdate,'0','50');
delete tbaadm.mno where mop_id = 'CBCHQM' and bank_id = '50';
begin
insert into tbaadm.mno values ('ONSDBMNU', :mopNum, 'CBCHQM','Y','U','TBAADM', sysdate, 'TBAADM', sysdate,'0','50');
end;
/
commit
/

begin
select nvl(to_char(max(to_number(mop_num))+1), '01') into :mopNum from tbaadm.mno where menu_id = 'ONSDBMNU' and bank_id = '11';
end;
/
delete tbaadm.mod where mop_id = 'CBCHQM' and bank_id = '11';
set escape \
INSERT INTO tbaadm.MOD  VALUES('CBCHQM','Y','N','U','https://$W/$A/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CBCHQM','C','BT','TT','FT','MT','','','BT','CO','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'002010900N901999N','','11','','N','','');
delete tbaadm.oat where mop_id = 'CBCHQM' and bank_id = '11';
insert into tbaadm.oat values ('CBCHQM', 'GU', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'11');
insert into tbaadm.oat values ('CBCHQM', 'DB', 'TBAADM', sysdate, 'TBAADM', sysdate, 0,'11');
delete tbaadm.mod_txt where mop_id = 'CBCHQM' and bank_id = '11';
insert into tbaadm.mod_txt values ('CBCHQM', 'INFENG', 'CBCHQM', 'Bankers Cheque Book Request Maintenance', '','Y', 'TBAADM', 'TBAADM', sysdate,sysdate,'0','11');
delete tbaadm.mno where mop_id = 'CBCHQM' and bank_id = '11';
begin
insert into tbaadm.mno values ('ONSDBMNU', :mopNum, 'CBCHQM','Y','U','TBAADM', sysdate, 'TBAADM', sysdate,'0','11');
end;
/
commit
/

SET ESC \;

delete from tbaadm.MOD WHERE mop_ID = 'CDMM' and bank_id='43';
delete from tbaadm.MOD_TXT WHERE mop_ID = 'CDMM' and bank_id='43';
delete from tbaadm.MNO WHERE mop_ID = 'CDMM' and bank_id='43';
delete from tbaadm.OAT WHERE mop_ID = 'CDMM' and bank_id='43';
commit;

variable mopNum varchar2(3);


begin
SELECT NVL(TO_CHAR(MAX(TO_NUMBER(MOP_NUM))+1), '43') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'ONSDBMNU' and bank_id='43';
end;
/

INSERT INTO tbaadm.MOD
(mop_id,entity_cre_flg,del_flg,mop_type,exe_name,input_filename,additional_params,db_status,mop_term_class_1,
mop_term_class_2,mop_term_class_3,mop_term_class_4,mop_term_class_5,mop_term_class_6,mop_term_class_7,
mop_term_class_8,mop_term_class_9,mop_term_class_10,mop_menu_param,mop_menu_secu_ind,mop_acpt_passwd_flg,
mop_term_type,mop_execution_type,node_type,log_operation_flg,mod_tenor,lchg_user_id,
rcre_user_id,lchg_time,rcre_time,ts_cnt,work_class,template_details,bank_id)
VALUES('CDMM','Y','N','U','https://$W/finbranch/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CDMM\&mtype=F','F
','BT','','','','','','','','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'001010999N','','43');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','INFENG','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'43');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','FRENCH','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'43');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','GU','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'43');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('ONSDBMNU',:mopNum,'CDMM','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'43');
end;
/



COMMIT;

delete from tbaadm.MOD WHERE mop_ID = 'CDMM' and bank_id='11';
delete from tbaadm.MOD_TXT WHERE mop_ID = 'CDMM' and bank_id='11';
delete from tbaadm.MNO WHERE mop_ID = 'CDMM' and bank_id='11';
delete from tbaadm.OAT WHERE mop_ID = 'CDMM' and bank_id='11';
commit;

variable mopNum varchar2(3);


begin
SELECT NVL(TO_CHAR(MAX(TO_NUMBER(MOP_NUM))+1), '11') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'ONSDBMNU' and bank_id='11';
end;
/

INSERT INTO tbaadm.MOD
(mop_id,entity_cre_flg,del_flg,mop_type,exe_name,input_filename,additional_params,db_status,mop_term_class_1,
mop_term_class_2,mop_term_class_3,mop_term_class_4,mop_term_class_5,mop_term_class_6,mop_term_class_7,
mop_term_class_8,mop_term_class_9,mop_term_class_10,mop_menu_param,mop_menu_secu_ind,mop_acpt_passwd_flg,
mop_term_type,mop_execution_type,node_type,log_operation_flg,mod_tenor,lchg_user_id,
rcre_user_id,lchg_time,rcre_time,ts_cnt,work_class,template_details,bank_id)
VALUES('CDMM','Y','N','U','https://$W/finbranch/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CDMM\&mtype=F','F
','BT','','','','','','','','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'001010999N','','11');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','INFENG','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'11');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','FRENCH','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'11');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','GU','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'11');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('ONSDBMNU',:mopNum,'CDMM','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'11');
end;
/

COMMIT;


delete from tbaadm.MOD WHERE mop_ID = 'CDMM' and bank_id='50';
delete from tbaadm.MOD_TXT WHERE mop_ID = 'CDMM' and bank_id='50';
delete from tbaadm.MNO WHERE mop_ID = 'CDMM' and bank_id='50';
delete from tbaadm.OAT WHERE mop_ID = 'CDMM' and bank_id='50';
commit;

variable mopNum varchar2(3);


begin
SELECT NVL(TO_CHAR(MAX(TO_NUMBER(MOP_NUM))+1), '50') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'ONSDBMNU' and bank_id='50';
end;
/

INSERT INTO tbaadm.MOD
(mop_id,entity_cre_flg,del_flg,mop_type,exe_name,input_filename,additional_params,db_status,mop_term_class_1,
mop_term_class_2,mop_term_class_3,mop_term_class_4,mop_term_class_5,mop_term_class_6,mop_term_class_7,
mop_term_class_8,mop_term_class_9,mop_term_class_10,mop_menu_param,mop_menu_secu_ind,mop_acpt_passwd_flg,
mop_term_type,mop_execution_type,node_type,log_operation_flg,mod_tenor,lchg_user_id,
rcre_user_id,lchg_time,rcre_time,ts_cnt,work_class,template_details,bank_id)
VALUES('CDMM','Y','N','U','https://$W/finbranch/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CDMM\&mtype=F','F
','BT','','','','','','','','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'001010999N','','50');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','INFENG','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'50');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','FRENCH','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'50');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','GU','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'50');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('ONSDBMNU',:mopNum,'CDMM','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'50');
end;
/


COMMIT;


delete from tbaadm.MOD WHERE mop_ID = 'CDMM' and bank_id='54';
delete from tbaadm.MOD_TXT WHERE mop_ID = 'CDMM' and bank_id='54';
delete from tbaadm.MNO WHERE mop_ID = 'CDMM' and bank_id='54';
delete from tbaadm.OAT WHERE mop_ID = 'CDMM' and bank_id='54';
commit;

variable mopNum varchar2(3);


begin
SELECT NVL(TO_CHAR(MAX(TO_NUMBER(MOP_NUM))+1), '54') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'ONSDBMNU' and bank_id='54';
end;
/

INSERT INTO tbaadm.MOD
(mop_id,entity_cre_flg,del_flg,mop_type,exe_name,input_filename,additional_params,db_status,mop_term_class_1,
mop_term_class_2,mop_term_class_3,mop_term_class_4,mop_term_class_5,mop_term_class_6,mop_term_class_7,
mop_term_class_8,mop_term_class_9,mop_term_class_10,mop_menu_param,mop_menu_secu_ind,mop_acpt_passwd_flg,
mop_term_type,mop_execution_type,node_type,log_operation_flg,mod_tenor,lchg_user_id,
rcre_user_id,lchg_time,rcre_time,ts_cnt,work_class,template_details,bank_id)
VALUES('CDMM','Y','N','U','https://$W/finbranch/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CDMM\&mtype=F','F
','BT','','','','','','','','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'001010999N','','54');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','INFENG','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'54');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','FRENCH','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'54');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','GU','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'54');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('ONSDBMNU',:mopNum,'CDMM','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'54');
end;
/

COMMIT;


delete from tbaadm.MOD WHERE mop_ID = 'CDMM' and bank_id='55';
delete from tbaadm.MOD_TXT WHERE mop_ID = 'CDMM' and bank_id='55';
delete from tbaadm.MNO WHERE mop_ID = 'CDMM' and bank_id='55';
delete from tbaadm.OAT WHERE mop_ID = 'CDMM' and bank_id='55';
commit;

variable mopNum varchar2(3);


begin
SELECT NVL(TO_CHAR(MAX(TO_NUMBER(MOP_NUM))+1), '55') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'ONSDBMNU' and bank_id='55';
end;
/

INSERT INTO tbaadm.MOD
(mop_id,entity_cre_flg,del_flg,mop_type,exe_name,input_filename,additional_params,db_status,mop_term_class_1,
mop_term_class_2,mop_term_class_3,mop_term_class_4,mop_term_class_5,mop_term_class_6,mop_term_class_7,
mop_term_class_8,mop_term_class_9,mop_term_class_10,mop_menu_param,mop_menu_secu_ind,mop_acpt_passwd_flg,
mop_term_type,mop_execution_type,node_type,log_operation_flg,mod_tenor,lchg_user_id,
rcre_user_id,lchg_time,rcre_time,ts_cnt,work_class,template_details,bank_id)
VALUES('CDMM','Y','N','U','https://$W/finbranch/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CDMM\&mtype=F','F
','BT','','','','','','','','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'001010999N','','55');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','INFENG','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'55');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','FRENCH','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'55');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','GU','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'55');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('ONSDBMNU',:mopNum,'CDMM','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'55');
end;
/

COMMIT;


delete from tbaadm.MOD WHERE mop_ID = 'CDMM' and bank_id='56';
delete from tbaadm.MOD_TXT WHERE mop_ID = 'CDMM' and bank_id='56';
delete from tbaadm.MNO WHERE mop_ID = 'CDMM' and bank_id='56';
delete from tbaadm.OAT WHERE mop_ID = 'CDMM' and bank_id='56';
commit;

variable mopNum varchar2(3);


begin
SELECT NVL(TO_CHAR(MAX(TO_NUMBER(MOP_NUM))+1), '56') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'ONSDBMNU' and bank_id='56';
end;
/

INSERT INTO tbaadm.MOD
(mop_id,entity_cre_flg,del_flg,mop_type,exe_name,input_filename,additional_params,db_status,mop_term_class_1,
mop_term_class_2,mop_term_class_3,mop_term_class_4,mop_term_class_5,mop_term_class_6,mop_term_class_7,
mop_term_class_8,mop_term_class_9,mop_term_class_10,mop_menu_param,mop_menu_secu_ind,mop_acpt_passwd_flg,
mop_term_type,mop_execution_type,node_type,log_operation_flg,mod_tenor,lchg_user_id,
rcre_user_id,lchg_time,rcre_time,ts_cnt,work_class,template_details,bank_id)
VALUES('CDMM','Y','N','U','https://$W/finbranch/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CDMM\&mtype=F','F
','BT','','','','','','','','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'001010999N','','56');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','INFENG','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'56');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','FRENCH','CDMM','Mapping Data Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'56');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('CDMM','GU','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'56');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID)
VALUES('ONSDBMNU',:mopNum,'CDMM','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'56');
end;
/

COMMIT;

SET ESC OFF;

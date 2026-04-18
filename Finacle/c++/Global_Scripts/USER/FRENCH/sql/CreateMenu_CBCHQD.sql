#---------------------------------------------------------------------------------
#--    File Name                  : CreateMenu_CBCHQD.sql
#--    Date                       : 01.08.2013
#--    Author                     : Hari Mohan Verma
#--    Assumptions                : NIL
#--    Modification History    :
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          01.08.2013     Hari Mohan Verma		Original Version
#-----------------------------------------------------------------------------------

SET ESC \;


delete from tbaadm.mod where mop_id = 'CBCHQD';
delete from tbaadm.mod_txt where mop_id = 'CBCHQD';
delete from tbaadm.mno where mop_id = 'CBCHQD';
delete from tbaadm.oat where mop_id = 'CBCHQD';

variable mopNum varchar2(2);

begin
SELECT NVL(TO_CHAR(TO_NUMBER(MAX(MOP_NUM))+1), '1') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'ONSMNU';
end;
/

INSERT INTO tbaadm.MOD (mop_id,entity_cre_flg,del_flg,mop_type,exe_name,input_filename,additional_params,db_status,mop_term_class_1, mop_term_class_2,mop_term_class_3,mop_term_class_4,mop_term_class_5,mop_term_class_6,mop_term_class_7, mop_term_class_8,mop_term_class_9,mop_term_class_10,mop_menu_param,mop_menu_secu_ind,mop_acpt_passwd_flg, mop_term_type,mop_execution_type,node_type,log_operation_flg,mod_tenor,lchg_user_id, rcre_user_id,lchg_time,rcre_time,ts_cnt,work_class,template_details,bank_id) VALUES('CBCHQD','Y','N','U','https://$W/finbranch/','Customize/Customize_ctrl.jsp?sessionid=$S','\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CBCHQD\&mtype=F','F','BT','','','','','','','','','','FINW','M','N','','','','','F','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'001010999N','','54');

INSERT INTO tbaadm.MOD_TXT (MOP_ID,LANG_CODE,USER_MOP_ID,MOP_TEXT,MOP_HELP_TEXT,ENTITY_CRE_FLG,LCHG_USER_ID,RCRE_USER_ID,LCHG_TIME,RCRE_TIME,TS_CNT,BANK_ID) VALUES('CBCHQD','INFENG','CBCHQD','Cheque Book Maintenance','','Y','TBAADM','TBAADM',SYSDATE,SYSDATE,0,'54');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID) VALUES('CBCHQD','GU','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'54');

INSERT INTO tbaadm.OAT (MOP_ID,APPL_ID,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID) VALUES('CBCHQD','DB','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'54');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,BANK_ID) VALUES('ONSMNU',:mopNum,'CBCHQD','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'54');
end;
/
COMMIT;
SET ESC OFF;

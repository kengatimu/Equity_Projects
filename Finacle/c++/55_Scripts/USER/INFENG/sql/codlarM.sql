SET ESC \;

delete from tbaadm.mod where mop_id = 'CODLAR' and bank_id = '54';
delete from tbaadm.mod_txt where mop_id = 'CODLAR' and bank_id = '54';
delete from tbaadm.mno where mop_id = 'CODLAR' and bank_id = '54';
delete from tbaadm.oat where mop_id = 'CODLAR' and bank_id = '54';

variable mopNum varchar2(2);

begin
SELECT NVL(TO_CHAR(TO_NUMBER(MAX(MOP_NUM))+1), '1') into :mopNum FROM tbaadm.MNO WHERE MENU_ID = 'SYSOPER';
end;
/

Insert into TBAADM.MENU_OPTION_DEFN_TABLE
   (MOP_ID, ENTITY_CRE_FLG, DEL_FLG, MOP_TYPE, EXE_NAME, INPUT_FILENAME, ADDITIONAL_PARAMS, DB_STATUS, MOP_TERM_CLASS_1, MOP_MENU_PARAM, MOP_MENU_SECU_IND, MOP_ACPT_PASSWD_FLG, MOD_TENOR, LCHG_USER_ID, RCRE_USER_ID, LCHG_TIME, RCRE_TIME, TS_CNT, WORK_CLASS, BANK_ID)
 Values
   ('CODLAR', 'Y', 'N', 'U', 'https://$W/finbranch/', 'Customize/Customize_ctrl.jsp?sessionid=$S', '\&sectok=$T\&finsessionid=$S\&fabsessionid=$C\&mo=CODLAR\&mtype=F', 'C', 'BT', 'FINW', 'M', 'N', 'F', 'TBAADM', 'TBAADM', sysdate, sysdate, 0, '010100999N055999N065999N061999N060999N070999N069999N066999N067999N070999N', '54');

Insert into TBAADM.MENU_OPTION_TEXT_TABLE
   (MOP_ID, LANG_CODE, USER_MOP_ID, MOP_TEXT, ENTITY_CRE_FLG, LCHG_USER_ID, RCRE_USER_ID, LCHG_TIME, RCRE_TIME, TS_CNT, BANK_ID)
 Values
   ('CODLAR', 'INFENG', 'CODLAR', 'OD Loan Rescheduling', 'Y', 'TBAADM', 'TBAADM', SYSDATE, SYSDATE, 0, '54');

Insert into TBAADM.OPTION_APPLICATION_TABLE
   (MOP_ID, APPL_ID, LCHG_USER_ID, LCHG_TIME, RCRE_USER_ID, RCRE_TIME, TS_CNT, BANK_ID)
 Values
   ('CODLAR', 'GU', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, 0, '54');

begin
INSERT INTO tbaadm.MNO (MENU_ID,MOP_NUM,MOP_ID,ENTITY_CRE_FLG,MENU_TYPE,LCHG_USER_ID,LCHG_TIME,RCRE_USER_ID,RCRE_TIME,TS_CNT,
BANK_ID)
VALUES('SYSOPER',:mopNum,'CODLAR','Y','U','TBAADM',SYSDATE,'TBAADM',SYSDATE,0,'54');
end;
/


COMMIT;
SET ESC OFF;


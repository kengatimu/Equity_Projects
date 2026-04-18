/
exec  custom.SMS_LOANS_PROC;
/
commit;
/
exec  CUSTOM.SMS_EAZZYLOAN_PROC;
/
commit;
/
exec  CUSTOM.SMS_EAZZYPLUSLOAN_PROC;
/
commit;
/
exec  CUSTOM.SMS_LOANS_UG_PROC;
/
commit;
/
exec  CUSTOM.SMS_EAZZYLOAN_PROC_56;
/
commit;
/
exec  CUSTOM.SMS_EAZZYLOAN_PROC_55;
/
commit;
/
exec  CUSTOM.SMS_ECOMOTOLOAN_PROC;
/
commit;
/
exec  CUSTOM.SMS_MKEYLOAN_PROC;
/
commit;
/
exec  CUSTOM.SMS_STOCKLOAN_PROCC;
/
commit;
/
exec  CUSTOM.SMS_EAZZYRW_PROC;
/
commit;
/
exec CUSTOM.SMS_JOHARILOAN_PROC;
/
commit;
/
update  TBAADM.FCFTT set FREE_CODE_3='T' WHERE bank_id='43' and  ACID in  (SELECT ACID FROM TBAADM.GAM WHERE schm_code='CA212' AND BANK_ID='43' and acct_cls_flg='N' AND ENTITY_CRE_FLG = 'Y' AND DEL_FLG = 'N')
AND FREE_CODE_3 !='T' and FREE_CODE_3 !='M' AND BANK_ID = '43' AND ENTITY_CRE_FLG = 'Y' AND DEL_FLG = 'N';
/
commit;
/
exit
/


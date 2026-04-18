/
exec CUSTOM.SMS_INSERT_PROC_TZ;
/
commit;
/
exec custom.SMS_STAGE_TABLE_ALERTS_PROC;
/
commit;
/
exec CUSTOM.SMS_INSERT_PROC_ALERTSM;
/
commit;
/
exec CUSTOM.SMS_PROC_TRANSALERTS_2;
/
commit;
/
exec CUSTOM.SMS_INSERT_PROC_TRANSALERTS_2;
/
commit;
/
update crmuser.accounts_mod set RECORDSTATUS ='F' ,CURRENTSTEP='2'  where recordstatus='D' and bank_id ='54'and orgkey in (select cif_id from custom.bulk_cif where entity_cre_flg ='F') AND RECORDSTATUS ='D';
/
commit;
/
UPDATE CRMUSER.ACCOUNTS SET ENTITY_CRE_FLAG ='Y' ,RECORDSTATUS ='A'  WHERE ORGKEY IN (SELECT CIF_ID FROM CUSTOM.BULK_CIF WHERE ENTITY_CRE_FLG ='K') and RECORDSTATUS='I' and ENTITY_CRE_FLAG='N';
/
commit;
/
----delete  from tbaadm.lgi where user_id='FIVUSR54' and CONTEXT_SOL_ID!='000';
/
commit;
/
commit;
/
exit
/

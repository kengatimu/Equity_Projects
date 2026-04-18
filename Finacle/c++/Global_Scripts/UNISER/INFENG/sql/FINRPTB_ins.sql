SET DEFINE OFF;
--
--SQL Statement which produced this data:
--  SELECT ROWID, TBAADM.FINRPTB.* FROM tbaadm.FINRPTB where bank_id='43'  and rpt_tmpl_name like 'DCPrnt%.jasper'
--
Insert into TBAADM.FINRPTB
   (rpt_tmpl_name, bank_id, del_flg, rpt_format, prnt_dialog_flag, compression_flag, passwd_prot_flag, permissions, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt)
 Values
   ('DCPrnt1.jasper', '43', 'N', 1, 'N', 'N', 'N', 0, 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 1);
Insert into TBAADM.FINRPTB
   (rpt_tmpl_name, bank_id, del_flg, rpt_format, prnt_dialog_flag, compression_flag, passwd_prot_flag, permissions, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt)
 Values
   ('DCPrnt2.jasper', '43', 'N', 1, 'N', 'N', 'N', 0, 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 1);
Insert into TBAADM.FINRPTB
   (rpt_tmpl_name, bank_id, del_flg, rpt_format, prnt_dialog_flag, compression_flag, passwd_prot_flag, permissions, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt)
 Values
   ('DCPrnt3.jasper', '43', 'N', 1, 'N', 'N', 'N', 0, 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 1);
Insert into TBAADM.FINRPTB
   (rpt_tmpl_name, bank_id, del_flg, rpt_format, prnt_dialog_flag, compression_flag, passwd_prot_flag, permissions, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt)
 Values
   ('DCPrnt4.jasper', '43', 'N', 1, 'N', 'N', 'N', 0, 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 'SYSTEM', TO_DATE('03/12/2014 18:48:13', 'MM/DD/YYYY HH24:MI:SS'), 1);
COMMIT;

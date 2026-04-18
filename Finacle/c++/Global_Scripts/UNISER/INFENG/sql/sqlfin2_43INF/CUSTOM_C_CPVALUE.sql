SET DEFINE OFF;
Insert into CUSTOM.C_CPVALUE
   (parameter_id, levelcode_1, parameter_value, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, bank_id, module_name)
 Values
   ('COMMISSION_LCBG_BACID', 'ALL', ' ', 'Y', 'N', 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), '43', 'OT');
   
   Insert into CUSTOM.C_CPVALUE
   (parameter_id, levelcode_1, parameter_value, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, bank_id, module_name)
 Values
   ('COMMISSION_LCBG_VAT_BACID', 'ALL', ' ', 'Y', 'N', 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), '43', 'OT');
   
   COMMIT;
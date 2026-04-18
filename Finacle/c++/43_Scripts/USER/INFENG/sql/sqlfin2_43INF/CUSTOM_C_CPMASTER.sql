SET DEFINE OFF;

Insert into CUSTOM.C_CPMASTER
   (module_name, parameter_level, parameter_id, parameter_desc, parameter_type, query_id, list_type, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, bank_id)
 Values
   ('OT', 'BNKL', 'COMMISSION_LCBG_BACID', 'GL', 'AN', ' ', 'FT', 'Y', 'N', 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), '43');
   
   Insert into CUSTOM.C_CPMASTER
   (module_name, parameter_level, parameter_id, parameter_desc, parameter_type, query_id, list_type, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, bank_id)
 Values
   ('OT', 'BNKL', 'COMMISSION_LCBG_VAT_BACID', 'GL', 'AN', ' ', 'FT', 'Y', 'N', 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), 'TBAADM', TO_DATE('07/07/2018 09:47:54', 'MM/DD/YYYY HH24:MI:SS'), '43');
   
   COMMIT;

SET DEFINE OFF;
--
--SQL Statement which produced this data:
--  SELECT ROWID, CUSTOM.C_CPVALUE.* FROM  custom.c_cpvalue where  module_name='ODA'
--
Insert into CUSTOM.C_CPMASTER
   (MODULE_NAME, PARAMETER_LEVEL, PARAMETER_ID, PARAMETER_DESC, PARAMETER_TYPE, QUERY_ID, LIST_TYPE, ENTITY_CRE_FLG, DEL_FLG, RCRE_USER_ID, RCRE_TIME, LCHG_USER_ID, LCHG_TIME, BANK_ID)
 Values
   ('ODA', 'BNKL', 'ODA_VAT_SCHM', 'VAT ON OD APPLICABLE SCHMS', 'AN', ' ', 'FT', 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, '43');
Insert into CUSTOM.C_CPVALUE
   (bank_id, parameter_id, parameter_value, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, module_name)
 Values
   ('43', 'ODA_VAT_SCHM','OD601,OD602', 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, 'ODA');
Insert into CUSTOM.C_CPMASTER
   (MODULE_NAME, PARAMETER_LEVEL, PARAMETER_ID, PARAMETER_DESC, PARAMETER_TYPE, QUERY_ID, LIST_TYPE, ENTITY_CRE_FLG, DEL_FLG, RCRE_USER_ID, RCRE_TIME, LCHG_USER_ID, LCHG_TIME, BANK_ID)
 Values
   ('OT', 'BNKL', 'COMM_VAT_PERCENT', 'VAT PERCENT', 'AN', ' ', 'FT', 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, '43');
Insert into CUSTOM.C_CPVALUE
   (bank_id, parameter_id, parameter_value, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, module_name)
 Values
   ('43', 'COMM_VAT_PERCENT', '16' , 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, 'OT');
Insert into CUSTOM.C_CPMASTER
   (MODULE_NAME, PARAMETER_LEVEL, PARAMETER_ID, PARAMETER_DESC, PARAMETER_TYPE, QUERY_ID, LIST_TYPE, ENTITY_CRE_FLG, DEL_FLG, RCRE_USER_ID, RCRE_TIME, LCHG_USER_ID, LCHG_TIME, BANK_ID)
 Values
   ('OT', 'BNKL', 'COMMISSION_VAT_BACID', 'VAT BACID', 'AN', ' ', 'FT', 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, '43');
Insert into CUSTOM.C_CPVALUE
   (bank_id, parameter_id, parameter_value, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, module_name)
 Values
   ('43', 'COMMISSION_VAT_BACID', 'VAT', 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, 'OT');
Insert into CUSTOM.C_CPMASTER
   (MODULE_NAME, PARAMETER_LEVEL, PARAMETER_ID, PARAMETER_DESC, PARAMETER_TYPE, QUERY_ID, LIST_TYPE, ENTITY_CRE_FLG, DEL_FLG, RCRE_USER_ID, RCRE_TIME, LCHG_USER_ID, LCHG_TIME, BANK_ID)
 Values
   ('LOANS', 'BNKL', 'LOANS_VAT_SCHM', 'VAT ON LOANS APPLICABLE SCHMS', 'AN', ' ', 'FT', 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, '43');
Insert into CUSTOM.C_CPVALUE
   (bank_id, parameter_id, parameter_value, entity_cre_flg, del_flg, rcre_user_id, rcre_time, lchg_user_id, lchg_time, module_name)
 Values
   ('43', 'LOANS_VAT_SCHM', 'LA511,LA512,LA513,LA514,LA515,LA516,LA517,LA518,LA519,LA520,LA521,LA522,LA523,LA524,LA525,LA526,LA527,LA528,LA529,LA570,LA571,LA572,LA573,LA574,LA590,LA591,LA592,LA593,LA594,LA595,LA596,LA597,LA598,LA599,LA600,LA601,LA602,LA603,LA604', 'Y', 'N', 'TBAADM', SYSDATE, 'TBAADM', SYSDATE, 'LOANS');
COMMIT;
SET DEFINE OFF;
--
--SQL Statement which produced this data:
--  SELECT ROWID, TBAADM.LRCT.* FROM tbaadm.lrct where ref_rec_type='SBF01'
--
Insert into TBAADM.LRCT
   (ref_rec_type, ref_code, del_flg, ref_desc, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt, bank_id, schm_ref_type, alt1_ref_desc)
Values
   ('SBF01', 'Leaflets', 'N', 'Leaflets', 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 0, '43', 'RA', 'Affichage');
Insert into TBAADM.LRCT
   (ref_rec_type, ref_code, del_flg, ref_desc, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt, bank_id, schm_ref_type, alt1_ref_desc)
Values
   ('SBF01', 'News Papers', 'N', 'News Papers', 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 0, '43', 'RA', 'Presse');
Insert into TBAADM.LRCT
   (ref_rec_type, ref_code, del_flg, ref_desc, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt, bank_id, schm_ref_type, alt1_ref_desc)
Values
   ('SBF01', 'Others', 'N', 'Others', 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'),0, '43', 'RA', 'Autres');
Insert into TBAADM.LRCT
   (ref_rec_type, ref_code, del_flg, ref_desc, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt, bank_id, schm_ref_type, alt1_ref_desc)
Values
   ('SBF01', 'Radio', 'N', 'Radio', 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 0, '43', 'RA', 'Radio');
Insert into TBAADM.LRCT
   (ref_rec_type, ref_code, del_flg, ref_desc, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt, bank_id, schm_ref_type, alt1_ref_desc)
Values
   ('SBF01', 'Relations', 'N', 'Relations', 'VIN1', TO_DATE('12/02/2016 09:41:45', 'MM/DD/YYYY HH24:MI:SS'), 'VIN1', TO_DATE('12/02/2016 09:41:45', 'MM/DD/YYYY HH24:MI:SS'), 0, '43', 'RA', 'Relations');
Insert into TBAADM.LRCT
   (ref_rec_type, ref_code, del_flg, ref_desc, lchg_user_id, lchg_time, rcre_user_id, rcre_time, ts_cnt, bank_id, schm_ref_type, alt1_ref_desc)
Values
   ('SBF01', 'Television', 'N', 'Television', 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 'VIN1', TO_DATE('12/02/2016 09:45:19', 'MM/DD/YYYY HH24:MI:SS'), 0, '43', 'RA', 'Télévision');

COMMIT;

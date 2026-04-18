insert into tbaadm.aac
(ACID, ACCT_ACCESS_CODE, LCHG_USER_ID, LCHG_TIME, RCRE_USER_ID, RCRE_TIME, TS_CNT, bank_id)
 select ACID, 'STAFF', LCHG_USER_ID, LCHG_TIME, RCRE_USER_ID, RCRE_TIME, TS_CNT, bank_id
 from tbaadm.gam where gam.schm_code in  ('SB190' ,'CA290','SB190' ,'CA790') 
 and gam.bank_id ='43'
 and gam.acct_cls_flg='N' 
 and gam.acid not in (select aac.acid from tbaadm.aac where bank_id = '43' )
/
commit
/
exit 


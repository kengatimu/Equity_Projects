insert into tbaadm.aac
(ACID, ACCT_ACCESS_CODE, LCHG_USER_ID, LCHG_TIME, RCRE_USER_ID, RCRE_TIME, TS_CNT, bank_id)
 select ACID, 'STAFF', LCHG_USER_ID, LCHG_TIME, RCRE_USER_ID, RCRE_TIME, TS_CNT, bank_id
 from tbaadm.gam where gam.schm_code='SB190' 
 and gam.bank_id ='11'
 and gam.del_flg!='Y'
 and gam.acid not in (select aac.acid from tbaadm.aac where bank_id = '11' )
/
commit
/
exit 


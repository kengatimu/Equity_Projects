/
create table custom.BULK_LIEN_COLLECTION_DRC as
select g.acid,g.sol_id,g.foracid,l.B2K_TYPE,l.B2K_ID,g.bank_id,l.LIEN_AMT,g.acct_crncy_code  ,LIEN_EXPIRY_DATE,LIEN_REASON_CODE,LIEN_REMARKS,ALT_CRNCY_CODE,  REQUEST_DEPARTMENT   COLLECTION_ACCOUNT,l.USER_ID,l.RCRE_USER_ID,l.RCRE_TIME
,concat(FORACID,B2K_ID) Unique_id,l.LIEN_AMT DMD_AMT_LIEN, decode(REQUESTED_BY_DESC,REQUESTED_BY_DESC,' ')  TRAN_ID,LIEN_EXPIRY_DATE LAST_ADJ_DATE,decode(l.LIEN_AMT,l.LIEN_AMT,'0') ADJ_AMT_LIEN,decode(l.LIEN_AMT,l.LIEN_AMT,'0') PENDING_AMT_LIEN,
decode(l.LIEN_AMT,l.LIEN_AMT,'0') NO_OF_ADJ_LIEN,decode(l.LIEN_AMT,l.LIEN_AMT,'0') TOTAL_ADJ_AMT,
 decode(l.RCRE_USER_ID,l.RCRE_USER_ID,' ')  LAST_ADJ_USER_ID,
decode(REQUESTED_BY_DESC,REQUESTED_BY_DESC,' ')   FREE_TEXT1,decode(REQUESTED_BY_DESC,REQUESTED_BY_DESC,' ')   FREE_TEXT2,decode(REQUESTED_BY_DESC,REQUESTED_BY_DESC,' ')   FREE_TEXT3,
g.del_flg ACTUAL_ADJ_FLG
from tbaadm.alt l ,tbaadm.gam g where  l.acid=g.acid  AND g.bank_id='43'
and g.bank_id='43' and l.B2K_TYPE='ULIEN' and g.bank_id=l.bank_id;
/
commit;
/



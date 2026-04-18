 CREATE OR REPLACE FUNCTION "CUSTOM"."FN_CORP_CHECK" (bankId varchar2,inpAcctId varchar2) RETURN varchar2
IS
cifId    varchar2(20);
acctNum  varchar2(16);
strFld   varchar2(10);
RetCorp varchar2(20);
outResp varchar2(100);
BEGIN
BEGIN
	select crm.corp_key,gam.foracid,(select STRUSERFIELD10 from crmuser.corporate where bank_id=bankId
and corp_key in (select cif_id from tbaadm.gam where foracid=inpAcctId and bank_id=bankId)) as STRUSERFIELD10  into cifId,acctNum,strFld
from crmuser.corporate crm,tbaadm.gam gam
where crm.bank_id=gam.bank_id
and crm.corp_key=gam.cif_id
and gam.del_flg<>'Y'
and gam.foracid=inpAcctId
and gam.bank_id=bankId
and crm.bank_id=bankId
and gam.entity_cre_flg='Y'
and gam.acct_cls_flg<>'Y'
and gam.acct_opn_date>='01-feb-2020'
and gam.acct_ownership<>'O';
    EXCEPTION WHEN NO_DATA_FOUND THEN
	cifId:='NA';
	acctNum:='NA';
	strFld:='NAO';
END;
Begin
select ENTITYTYPE into RetCorp from crmuser.cif_id_master where bank_id=bankId and cifid in (select cif_id from tbaadm.gam where foracid=inpAcctId and bank_id=bankId);
    EXCEPTION WHEN NO_DATA_FOUND THEN
	RetCorp:='NA';
END;
	if(RetCorp='Corporate')then
	if((strFld is not null) or (cifId is not null))then
		if(strFld='001')then
			outResp:='Y';
		end if;
		if(strFld!='001')then
			outResp:='N';
		end if;
		if(strFld='NAO')then
			outResp:='Y';
		end if;
	end if;
	else
			outResp:='Y';
	end if;
	---outResp:=outResp ||'|'|| strFld ||'|'|| RetCorp;
return  outResp;
END fn_corp_check;

/

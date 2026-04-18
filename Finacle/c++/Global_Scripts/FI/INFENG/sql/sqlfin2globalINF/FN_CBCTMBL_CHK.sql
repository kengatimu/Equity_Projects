--------------------------------------------------------
--  DDL for Function FN_CBCTMBL_CHK
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "CUSTOM"."FN_CBCTMBL_CHK" (bankId varchar2,inpAcctId varchar2,inpTranAmt number,inpTranType varchar2) RETURN varchar2
IS
newAcctCnt number(30) default 0;
newAcid varchar2(20) default null;
oldAcctCnt number(10) default 0;
oldAcid varchar2(20) default null;
fromdate date;
rAmtCrdtdCnt varchar2(1000);
rAmtCrdtd varchar2(1000) default 0;
rcrDtdMaxOne number(30) default 0;
rcrDtdMinOne number(30) default 0;
rcrDtdAvgOne number(30) default 0;
rcrDtdMaxMinCntOne  varchar2(1000) default 0;
rcrDtdMaxTwo number(30) default 0;
rcrDtdMinTwo number(30) default 0;
rcrDtdAvgTwo number(30) default 0;
rcrDtdMaxMinCntTwo  varchar2(1000) default 0;
rcrDtdMaxThree number(30) default 0;
rcrDtdMinThree number(30) default 0;
rcrDtdAvgThree number(30) default 0;
rcrDtdMaxMinCntThree  varchar2(1000) default 0;
rcrDtdMaxFour number(30) default 0;
rcrDtdMinFour number(30) default 0;
rcrDtdAvgFour number(30) default 0;
rcrDtdMaxMinCntFour  varchar2(1000) default 0;
rcrDtdMaxFive number(30) default 0;
rcrDtdMinFive number(30) default 0;
rcrDtdAvgFive number(30) default 0;
rcrDtdMaxMinCntFive  varchar2(1000) default 0;
rcrDtdMaxSix number(30) default 0;
rcrDtdMinSix number(30) default 0;
rcrDtdAvgSix number(30) default 0;
rcrDtdMaxMinCntSix  varchar2(1000) default 0;
rcrDtdMaxSeven number(30) default 0;
rcrDtdMinSeven number(30) default 0;
rcrDtdAvgSeven number(30) default 0;
rcrDtdMaxMinCntSeven  varchar2(1000) default 0;
rcrDtdMaxEight number(30) default 0;
rcrDtdMinEight number(30) default 0;
rcrDtdAvgEight number(30) default 0;
rcrDtdMaxMinCntEight  varchar2(1000) default 0;
rcrDtdMaxNine number(30) default 0;
rcrDtdMinNine number(30) default 0;
rcrDtdAvgNine number(30) default 0;
rcrDtdMaxMinCntNine  varchar2(1000) default 0;
rcrDtdMaxZero number(30) default 0;
rcrDtdMinZero number(30) default 0;
rcrDtdAvgZero number(30) default 0;
rcrDtdMaxMinCntZero  varchar2(1000) default 0;
releaseLienAmt number(16,3) default 0;
releaseLienDate date;
isLienAfterLienYN varchar2(2) default 'N';
drcrdtdhtdPattern varchar2(2);
RdPattern varchar2(2);
RhPattern varchar2(2);
isLienReleased varchar2(2);
AoutResp varchar2(20) default 'N';
RepYN Char(1);
OneYN Char(1);
TwoYN Char(1);
ThreeYN Char(1);
FourYN Char(1);
FiveYN Char(1);
SixYN Char(1);
SevenYN Char(1);
EigthYN Char(1);
NineYN Char(1);
ZeroYN Char(1);
FoutResp Char(1);
TenYN Varchar2(1000);
outResp varchar2(4000);
BEGIN
BEGIN
	select count(foracid),acid into newAcctCnt,newAcid
	from tbaadm.gam
	where bank_id=bankId
	and entity_cre_flg='Y'
	and del_flg='N'
	and foracid=inpAcctId
	and to_date(acct_opn_date,'DD-MM-RR') between
	(select to_date(db_stat_date,'DD-MM-RR')-7 from tbaadm.gct where bank_id=bankId)
	and (select to_date(db_stat_date,'DD-MM-RR')from tbaadm.gct where bank_id=bankId)
	group by foracid,acid;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        newAcctCnt:=0;
	newAcid:=null;
END;
if(newAcid is null)then
	Begin
	select count(foracid),acid into oldAcctCnt,oldAcid
	from tbaadm.gam
	where bank_id=bankId
	and entity_cre_flg='Y'
	and del_flg='N'
	and foracid=inpAcctId
	group by foracid,acid;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        oldAcctCnt:=0;
	oldAcid:=null;
	ENd;
end if;
if(oldAcid is not null)then
	newAcid:=oldAcid;
end if;
BEGIN
select (select db_stat_date from tbaadm.gct where bank_id=bankId) - to_char(parameter_value)
into fromdate
from custom.c_cpvalue,custom.c_cpmaster
 where
 c_cpmaster.bank_id = c_cpvalue.bank_id  and
 c_cpmaster.module_name = c_cpvalue.module_name  and
 c_cpmaster.parameter_id = c_cpvalue.parameter_id and
 c_cpvalue.del_flg != 'Y' and
 c_cpvalue.entity_cre_flg = 'Y' and
 c_cpmaster.bank_id = bankId and
 c_cpmaster.module_name = 'TRANVAL' and
 c_cpvalue.parameter_id = 'CHNLSTCHK';
    EXCEPTION WHEN NO_DATA_FOUND THEN
        fromdate:='31-12-2099';
END;
---repeated credit tran amount
Begin
select  nvl(listagg(count(tran_amt),',') within group(order by count(tran_amt)),0) as rAmtCrdtdCnt,
	nvl(listagg(tran_amt,',') within group(order by tran_amt),0) into rAmtCrdtdCnt,rAmtCrdtd
from tbaadm.dtd
where bank_id=bankId
and acid=newAcid
and pstd_flg='Y'
and part_tran_type='C'
--and tran_amt=555
and module_id='DCI'
and to_date(dtd.tran_date,'DD-MM-RR') = (select to_date(db_stat_date,'DD-MM-RR') from tbaadm.gct where bank_id=bankId)
--/*
and to_date(dtd.tran_date,'DD-MM-RR')
between to_date(fromdate,'DD-MM-RR')
and (select to_date(db_stat_date,'DD-MM-RR')
from tbaadm.gct where bank_id=bankId)
--*/
group by tran_amt
having count(tran_amt) > 3;
    EXCEPTION WHEN NO_DATA_FOUND THEN
	rAmtCrdtdCnt:=null;
	rAmtCrdtd:=null;
End;
Begin
--repeated 1
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 1, 1, 'i')) as rcrDtdMaxOne,
min(regexp_count(tranAmt, 1, 1, 'i')) as rcrDtdMinOne,
avg(regexp_count(tranAmt, 1, 1, 'i')) as rcrDtdAvgOne,
nvl(listagg(count(regexp_count(tranAmt, 1, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,1, 1, 'i'))),0)
as rcrDtdMaxMinCntOne into rcrDtdMaxOne,rcrDtdMinOne,rcrDtdAvgOne,rcrDtdMaxMinCntOne
from rcdtd
having max(regexp_count(tranAmt,1, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
	rcrDtdMaxOne:=0;
	rcrDtdMinOne:=0;
	rcrDtdAvgOne:=0;
	rcrDtdMaxMinCntOne:=0;
End;
Begin
--repeated 2
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 2, 1, 'i')) as rcrDtdMaxTwo,
min(regexp_count(tranAmt, 2, 1, 'i')) as rcrDtdMinTwo,
avg(regexp_count(tranAmt, 2, 1, 'i')) as rcrDtdAvgTwo,
nvl(listagg(count(regexp_count(tranAmt, 2, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,2, 1, 'i'))),0)
as rcrDtdMaxMinCntTwo into rcrDtdMaxTwo,rcrDtdMinTwo,rcrDtdAvgTwo,rcrDtdMaxMinCntTwo
from rcdtd
having max(regexp_count(tranAmt,2, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
	rcrDtdMaxTwo:=0;
	rcrDtdMinTwo:=0;
	rcrDtdAvgTwo:=0;
	rcrDtdMaxMinCntTwo:=0;
End;
Begin
--repeated 3
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 3, 1, 'i')) as rcrDtdMaxThree,
min(regexp_count(tranAmt, 3, 1, 'i')) as rcrDtdMinThree,
avg(regexp_count(tranAmt, 3, 1, 'i')) as rcrDtdAvgThree,
nvl(listagg(count(regexp_count(tranAmt, 3, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,3, 1, 'i'))),0)
as rcrDtdMaxMinCntThree into rcrDtdMaxThree,rcrDtdMinThree,rcrDtdAvgThree,rcrDtdMaxMinCntThree
from rcdtd
having max(regexp_count(tranAmt,3, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxThree:=0;
        rcrDtdMinThree:=0;
        rcrDtdAvgThree:=0;
        rcrDtdMaxMinCntThree:=0;
End;
Begin
--repeated 4
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 4, 1, 'i')) as rcrDtdMaxFour,
min(regexp_count(tranAmt, 4, 1, 'i')) as rcrDtdMinFour,
avg(regexp_count(tranAmt, 4, 1, 'i')) as rcrDtdAvgFour,
nvl(listagg(count(regexp_count(tranAmt, 4, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,4, 1, 'i'))),0)
as rcrDtdMaxMinCntFour into rcrDtdMaxFour,rcrDtdMinFour,rcrDtdAvgFour,rcrDtdMaxMinCntFour
from rcdtd
having max(regexp_count(tranAmt,4, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxFour:=0;
        rcrDtdMinFour:=0;
        rcrDtdAvgFour:=0;
        rcrDtdMaxMinCntFour:=0;
End;
Begin
--repeated 5
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 5, 1, 'i')) as rcrDtdMaxFive,
min(regexp_count(tranAmt, 5, 1, 'i')) as rcrDtdMinFive,
avg(regexp_count(tranAmt, 5, 1, 'i')) as rcrDtdAvgFive,
nvl(listagg(count(regexp_count(tranAmt, 5, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,5, 1, 'i'))),0)
as rcrDtdMaxMinCntFive into rcrDtdMaxFive,rcrDtdMinFive,rcrDtdAvgFive,rcrDtdMaxMinCntFive
from rcdtd
having max(regexp_count(tranAmt,5, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxFive:=0;
        rcrDtdMinFive:=0;
        rcrDtdAvgFive:=0;
        rcrDtdMaxMinCntFive:=0;
End;
Begin
--repeated 6
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 6, 1, 'i')) as rcrDtdMaxSix,
min(regexp_count(tranAmt, 6, 1, 'i')) as rcrDtdMinSix,
avg(regexp_count(tranAmt, 6, 1, 'i')) as rcrDtdAvgSix,
nvl(listagg(count(regexp_count(tranAmt, 6, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,6, 1, 'i'))),0)
as rcrDtdMaxMinCntSix into rcrDtdMaxSix,rcrDtdMinSix,rcrDtdAvgSix,rcrDtdMaxMinCntSix
from rcdtd
having max(regexp_count(tranAmt,6, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxSix:=0;
        rcrDtdMinSix:=0;
        rcrDtdAvgSix:=0;
        rcrDtdMaxMinCntSix:=0;
End;
Begin
--repeated 7
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 7, 1, 'i')) as rcrDtdMaxSeven,
min(regexp_count(tranAmt, 7, 1, 'i')) as rcrDtdMinSeven,
avg(regexp_count(tranAmt, 7, 1, 'i')) as rcrDtdAvgSeven,
nvl(listagg(count(regexp_count(tranAmt, 7, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,7, 1, 'i'))),0)
as rcrDtdMaxMinCntSeven into rcrDtdMaxSeven,rcrDtdMinSeven,rcrDtdAvgSeven,rcrDtdMaxMinCntSeven
from rcdtd
having max(regexp_count(tranAmt,7, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxSeven:=0;
        rcrDtdMinSeven:=0;
        rcrDtdAvgSeven:=0;
        rcrDtdMaxMinCntSeven:=0;
End;
Begin
--repeated 8
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 8, 1, 'i')) as rcrDtdMaxEight,
min(regexp_count(tranAmt, 8, 1, 'i')) as rcrDtdMinEight,
avg(regexp_count(tranAmt, 8, 1, 'i')) as rcrDtdAvgEight,
nvl(listagg(count(regexp_count(tranAmt, 8, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,8, 1, 'i'))),0)
as rcrDtdMaxMinCntEight into rcrDtdMaxEight,rcrDtdMinEight,rcrDtdAvgEight,rcrDtdMaxMinCntEight
from rcdtd
having max(regexp_count(tranAmt,8, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxEight:=0;
        rcrDtdMinEight:=0;
        rcrDtdAvgEight:=0;
        rcrDtdMaxMinCntEight:=0;
End;
Begin
--repeated 9
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 9, 1, 'i')) as rcrDtdMaxNine,
min(regexp_count(tranAmt, 9, 1, 'i')) as rcrDtdMinNine,
avg(regexp_count(tranAmt, 9, 1, 'i')) as rcrDtdAvgNine,
nvl(listagg(count(regexp_count(tranAmt, 9, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,9, 1, 'i'))),0)
as rcrDtdMaxMinCntNine into rcrDtdMaxNine,rcrDtdMinNine,rcrDtdAvgNine,rcrDtdMaxMinCntNine
from rcdtd
having max(regexp_count(tranAmt,9, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxNine:=0;
        rcrDtdMinNine:=0;
        rcrDtdAvgNine:=0;
        rcrDtdMaxMinCntNine:=0;
End;
Begin
--repeated 0
with rcdtd as (select tran_amt as tranAmt from tbaadm.dtd
        where bank_id=bankId
        and acid=newAcid
        and pstd_flg='Y'
        and part_tran_type='C'
        and module_id='DCI'
        and to_date(dtd.tran_date,'DD-MM-RR')
        between to_date(fromdate,'DD-MM-RR')
        and (select to_date(db_stat_date,'DD-MM-RR')
        from tbaadm.gct where bank_id=bankId)
)
select
max(regexp_count(tranAmt, 0, 1, 'i')) as rcrDtdMaxZero,
min(regexp_count(tranAmt, 0, 1, 'i')) as rcrDtdMinZero,
avg(regexp_count(tranAmt, 0, 1, 'i')) as rcrDtdAvgZero,
nvl(listagg(count(regexp_count(tranAmt, 0, 1, 'i')),',')
within group(order by count(regexp_count(tranAmt,0, 1, 'i'))),0)
as rcrDtdMaxMinCntZero into rcrDtdMaxZero,rcrDtdMinZero,rcrDtdAvgZero,rcrDtdMaxMinCntZero
from rcdtd
having max(regexp_count(tranAmt,0, 1, 'i')) >0
group by tranAmt;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        rcrDtdMaxZero:=0;
        rcrDtdMinZero:=0;
        rcrDtdAvgZero:=0;
        rcrDtdMaxMinCntZero:=0;
End;
BEGIN
select nvl(lien_amt,1),nvl(to_date(modify_bod_date,'DD-MM-RR'),'31-DEC-2099')
into releaseLienAmt,releaseLienDate  from tbaadm.alh where bank_id=bankId
and acid = newAcid
and lien_reason_code='LSTM'
and srl_num in (select max(srl_num) from tbaadm.alh where bank_id=bankId
and acid = newAcid
and lien_reason_code='LSTM');
        EXCEPTION WHEN NO_DATA_FOUND THEN
        releaseLienAmt:=1;
        releaseLienDate:='31-DEC-2099';
END;

	if((newAcctCnt >= 1) and(inpTranType='D')) then
			FoutResp:='N';
	end if;
	if((newAcctCnt >= 1) and(inpTranType='C')) then
                if((rAmtCrdtdCnt is not null) and (rAmtCrdtdCnt!='0'))then
			AoutResp:='Y';
			RepYN:='Y';
		end if;
		if(rcrDtdMaxOne>=4)then
			AoutResp:='Y';
			OneYN:='Y';
		end if;
		if(rcrDtdMaxTwo>=4)then
			AoutResp:='Y';
			TwoYN:='Y';
		end if;
		if(rcrDtdMaxThree>=4)then
			AoutResp:='Y';
			ThreeYN:='Y';
		end if;
		if(rcrDtdMaxFour>=4)then
			AoutResp:='Y';
			FourYN:='Y';
		end if;
		if(rcrDtdMaxFive>=4)then
			AoutResp:='Y';
			FiveYN:='Y';
		end if;
		if(rcrDtdMaxSix>=4)then
			AoutResp:='Y';
			SixYN:='Y';
		end if;
		if(rcrDtdMaxSeven>=4)then
			AoutResp:='Y';
			SevenYN:='Y';
		end if;
		if(rcrDtdMaxEight>=4)then
			AoutResp:='Y';
			EigthYN:='Y';
		end if;
		if(rcrDtdMaxNine>=4)then
			AoutResp:='Y';
			NineYN:='Y';
		end if;
		if(rcrDtdMaxZero>=4)then
			AoutResp:='Y';
			ZeroYN:='Y';
		end if;
		if((releaseLienAmt>0)and(AoutResp='Y'))then
			FoutResp:='Y';
		end if;
		if((releaseLienAmt<=0)and(AoutResp='Y') and (releaseLienDate<sysdate))then
			FoutResp:='Y';
		else
			FoutResp:='N';
		end if;
	end if;
        if((newAcctCnt <= 0) and(inpTranType='C')) then
		FoutResp:='N';
	end if;
        if((newAcctCnt <= 0) and(inpTranType='D')) then
                if((rAmtCrdtdCnt is not null) and (rAmtCrdtdCnt!='0'))then
                        AoutResp:='Y';
			RepYN:='Y';
                end if;
                if(rcrDtdMaxOne>=4)then
                        AoutResp:='Y';
			OneYN:='Y';
                end if;
                if(rcrDtdMaxTwo>=4)then
                        AoutResp:='Y';
			TwoYN:='Y';
                end if;
                if(rcrDtdMaxThree>=4)then
                        AoutResp:='Y';
			ThreeYN:='Y';
                end if;
                if(rcrDtdMaxFour>=4)then
                        AoutResp:='Y';
			FourYN:='Y';
                end if;
                if(rcrDtdMaxFive>=4)then
                        AoutResp:='Y';
			FiveYN:='Y';
                end if;
                if(rcrDtdMaxSix>=4)then
                        AoutResp:='Y';
			SixYN:='Y';
                end if;
                if(rcrDtdMaxSeven>=4)then
                        AoutResp:='Y';
			SevenYN:='Y';
                end if;
                if(rcrDtdMaxEight>=4)then
                        AoutResp:='Y';
			EigthYN:='Y';
                end if;
                if(rcrDtdMaxNine>=4)then
                        AoutResp:='Y';
			NineYN:='Y';
                end if;
                if(rcrDtdMaxZero>=4)then
                        AoutResp:='Y';
			ZeroYN:='Y';
                end if;
                if((releaseLienAmt>0)and(AoutResp='Y'))then
                        FoutResp:='Y';
                end if;
                --if((releaseLienAmt<=0)and(AoutResp='Y'))then
		if((releaseLienAmt<=0)and(AoutResp='Y') and (releaseLienDate<sysdate))then
                        FoutResp:='Y';
		else
			FoutResp:='N';
                end if;
	end if;
		TenYN:=RepYN||','||OneYN||','||TwoYN||','||ThreeYN||','||FourYN||','||FiveYN||','||SixYN||','||SevenYN||','||EigthYN||','||NineYN||','||ZeroYN;
	--Y|1|0|1|4|4|1|4|1||1|4|3
	outResp:=FoutResp||'|'||newAcctCnt||'|'||oldAcctCnt||'|'||fromdate||'|'||AoutResp||'|'||rAmtCrdtdCnt||'|'||rcrDtdMaxOne||'|'||rcrDtdMaxTwo||'|'||rcrDtdMaxThree||'|'||rcrDtdMaxFour||'|'||rcrDtdMaxFive||'|'||rcrDtdMaxSix||'|'||rcrDtdMaxSeven||'|'||rcrDtdMaxEight||'|'||rcrDtdMaxNine||'|'||rcrDtdMaxZero||'|'||releaseLienAmt||'|'||TenYN;
return  outResp;
END FN_CBCTMBL_CHK;

/


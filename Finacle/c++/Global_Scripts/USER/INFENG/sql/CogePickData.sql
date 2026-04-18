/
insert into CUSTOM.COGE_OFFLINE_TRANSACTIONS
select * from
(select a.ope||a.eve||a.age event_number, a.eta event_status,decode(a.ope,'181',a.comb,'193',a.comb, a.age1||a.ncp1||a.clc1) debit_account,trim(n.lib2) currency1,a.mon1,a.lib1,a.age2||a.ncp2||a.clc2 credit_account,trim(m.lib2) currency2,a.uti channels,a.lib2,a.lib6,a.lib10, a.mnat AMT_LCY
	,CAST('' AS VARCHAR2(20)) PST_FLAG,CAST('' AS VARCHAR2(20)) TRN_ID,CAST('' AS VARCHAR2(20)) FREETEXT1,CAST('' AS VARCHAR2(20)) FREETEXT2
	from prod.bkeve@COGE_FINACLE_LINK.EBSAFRICA.COM a
	join prod.bknom@COGE_FINACLE_LINK.EBSAFRICA.COM n on n.cacc=a.dev1 and n.ctab='005'
	join prod.bknom@COGE_FINACLE_LINK.EBSAFRICA.COM m on m.cacc=a.dev2 and m.ctab='005'
	where a.UTI IN ('EBANK','WALLET','MOBILEUSSD','AGENCY','SIMTEL','ETAX2021','ADMIN','MASTER','SCHOOLGEAR')
	and a.nat<>'AGEVIR' and a.eta in ('VA','VF','FO') and a.ope<>'190' AND ( (a.dsai='30-DEC-23'
			and a.ope||a.eve||a.age in (select x.ope||x.eve||x.age from prod.bkeve_eod_0016@COGE_FINACLE_LINK.EBSAFRICA.COM x)) or a.dsai>'31-DEC-23'))
 where  EVENT_NUMBER not  in  (select EVENT_NUMBER from CUSTOM.COGE_OFFLINE_TRANSACTIONS  );
/
commit;
/
exit
/


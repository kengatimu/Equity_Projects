spool otherskenya2.lst
/
declare
cursor c1 is 
 select SIGNID, to_char(EXPIRYDATE,'DD-MON-RRRR') as EXPIRYDATE from custom.expired_imagaes_drc where pull_flg='77';
begin
for i in c1 loop
   update SVSUSER.SIGNMAINTENANCE set  EXPIRYDATE=i.EXPIRYDATE  where SIGNID in (select SIGNID from custom.expired_imagaes_drc ) and SIGNID=i.SIGNID;
commit;
update custom.expired_imagaes_drc  set pull_flg='88' where SIGNID=i.SIGNID;
commit;
end loop;
end;
/
commit;
/
exit;
/

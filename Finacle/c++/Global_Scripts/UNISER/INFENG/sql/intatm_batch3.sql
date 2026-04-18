spool otherskenya4.lst
/
declare
cursor c1 is 
select SIGNID from custom.expired_imagaes_drc where pull_flg='N4';
begin
for i in c1 loop
   update SVSUSER.SIGNMAINTENANCE set  EXPIRYDATE='01-jan-2099' where SIGNID in (select SIGNID from custom.expired_imagaes_drc ) and SIGNID=i.SIGNID;
commit;
update custom.expired_imagaes_drc  set pull_flg='77' where SIGNID=i.SIGNID;
commit;
end loop;
end;
/
commit;
/
exit;
/

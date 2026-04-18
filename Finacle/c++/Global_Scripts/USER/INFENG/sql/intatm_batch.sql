spool others.lst
/
Update crmuser.phoneemail set phoneemailtype = 'HOMEEML' where phoneemailid = '127337009' and orgkey = '54200440052' and phoneemailtype = 'COMMEML';

update crmuser.accounts set RECORDSTATUS='A', ENTITY_CRE_FLAG='Y' where orgkey in ('54308339206','54308343114');

commit;


exit
/

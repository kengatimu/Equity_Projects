/
exec  CUSTOM.SMS_STAGE_PROC_DTD_56; 
/
commit;
/
exec  CUSTOM.SMS_INSERT_PROC_UG; 
/
commit;
/
exec  CUSTOM.SMS_STAGE_PROC_DTD_LOANS_BGDMS; 
/
commit;
/
exit
/
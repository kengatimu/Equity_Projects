set serveroutput on

exec CUSTOM.input_single_facility('&1','&2')

commit
/


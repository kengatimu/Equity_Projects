/
truncate table custom.statement_jobs drop storage;

truncate table custom.statement_header drop storage;

truncate table custom.statement_details drop storage;

begin
CUSTOM.gen_statement_foracid_nhif('0950261868298','01-Jul-2022','30-Jun-2023','54','SK04908');
end;
/


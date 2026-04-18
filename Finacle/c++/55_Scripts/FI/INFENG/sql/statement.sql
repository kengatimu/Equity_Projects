/
truncate table custom.statement_jobs drop storage;

truncate table custom.statement_header drop storage;

truncate table custom.statement_details drop storage;

begin
CUSTOM.gen_statement_foracid_nhif('0360280138816'01-Jan-2023','30-Jun-2023','54','SK04908');
end;
/

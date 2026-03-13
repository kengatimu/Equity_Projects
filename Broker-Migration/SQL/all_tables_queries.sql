select *
  from telco_b2c_transaction_details
 where rrn = '100001001010'
 order by id desc;

select *
  from telco_b2c_status_details
  where rrn = '100001001010'
 order by id desc;

select *
  from telco_b2c_payload_details
 where rrn = '100001001000'
 order by id desc;

select *
  from cbs_transaction_details
 where rrn = '100001001000'
 order by id desc;

desc telco_b2c_transaction_details;

-- drop table telco_b2c_transaction_details;
-- drop table telco_b2c_status_details;
-- drop table telco_b2c_payload_details;
-- drop table telco_b2c_callback;
-- drop table telco_b2c_param_configs;
-- drop table cbs_transaction_details;


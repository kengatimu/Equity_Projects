CREATE OR REPLACE procedure custom.input_single_facility
(v_finacle_acct varchar2, v_bank_id varchar2)
is
/********************************************************************************************
Author : Mark M. Kiambo
Date: 14th May 2010
Description:
For the the purpose of inserting Finacle Accounts into the CMS_FACILITY_DTLS 
table, to enable lien marking of a collateral.

Grants to: mkiambo, nkirimi, sminjire and ekahuria.

*********************************************************************************************/
v_count1 number := 0;
v_count2 number := 0;
V_COUNT3 NUMBER := 0;
v_schm_type varchar2(12);
v_app_id_c number;
v_sanct_lim number := 0;
v_old_amt number := 0;
v_err_code varchar2(50);
v_facility_id varchar2(20);
v_facility_amt number (18,2);
v_facility_type varchar2(20);
v_customer_name varchar2(100);
v_facility_currency varchar2(20);
v_cust__id varchar2(20);
v_source_system varchar2(20);
v_err_msg varchar2(1000);

begin
-- to alter the session time_zone settings for SQLDeveloper users, who may encounter an error 
-- when trying to execute the program.
--execute immediate 'Alter session set time_zone = local';

  SELECT COUNT(1), SCHM_type, sanct_lim
  into v_count2, v_schm_type, v_sanct_lim
  from tbaadm.gam
  WHERE GAM.FORACID = V_FINACLE_ACCT 
	AND GAM.bank_id = v_bank_id
  GROUP BY SCHM_type, sanct_lim;-- check the existance of the account in Finacle
  
	dbms_output.put_line('AccountNo:'||V_FINACLE_ACCT||' BankId:'||v_bank_id);

  IF V_COUNT2 = 1 and v_schm_type = 'LAA'
  then
  -- check if the account is already in the table.. 
    select count(1)
    into v_count1
    from EQUITYCMS.cms_facility_dtls@FINACLE_CAS
    where facility_id = v_finacle_acct;
    
    if v_count1 = 1
    then
       select FACILITY_AMT
       into v_old_amt
       from EQUITYCMS.CMS_FACILITY_DTLS@FINACLE_CAS
       where FACILITY_ID = v_finacle_acct;

      
      if v_old_Amt <> v_sanct_lim
      then 

          UPDATE EQUITYCMS.CMS_FACILITY_DTLS@FINACLE_CAS
          set FACILITY_AMT = v_sanct_lim
          where FACILITY_ID = v_finacle_acct;
          commit;
          --dbms_output.put_line ('Account '|| v_finacle_acct || ' updated sanction from '|| v_old_amt ||' to ' || v_sanct_lim );
       else 
      raise_application_error(-20000, 'A record exists for the account '||v_finacle_acct||'. Kindly check ....');
      end if;
    elsif v_count1 = 0
    THEN 
   
      select count(1)
      into v_count3
      from EQT_CAS.cas_finacle_account_dtl@FINACLE_CAS cfad
      where cfad.fin_acc_no = v_finacle_acct ;
      -- check if the loan was originated from CAS
      
      if v_count3 = 1
      then
      
      select app_id_c
      into v_app_id_c
      from EQT_CAS.cas_finacle_account_dtl@FINACLE_CAS cfad
      where cfad.fin_acc_no = v_finacle_acct;
      
        --dbms_output.put_line('The Loan Account was originated from CAS. The Corresponding app_id for '||v_finacle_acct||' is '||v_app_id_c);
        
      elsif v_count3 = 0
      then
        select foracid facility_id, sanct_lim facility_Amt, schm_code facility_type, acct_name customer_name, gam.acct_crncy_code facility_currency,
        cust_id, 'FINACLE' source_system
        into v_facility_id, v_facility_amt, v_facility_type, v_customer_name, v_facility_currency, v_cust__id, v_source_system
        from tbaadm.gam
        where foracid = v_finacle_acct
	and bank_id = v_bank_id;
        
        insert into EQUITYCMS.cms_facility_dtls@FINACLE_CAS
        values
        (v_facility_id, v_facility_amt, v_facility_type, v_customer_name, v_facility_currency, v_cust__id, v_source_system ); -- the actual insert
        commit;
        
        --dbms_output.put_line('The Data for Loan Account '||v_finacle_acct||' has been updated Successfully.');
      end if;
    else
      raise_application_error(-20000, 'The Account '||v_finacle_acct||' does not exist...');
      null;
    end if;
    
  ELSIF V_COUNT2 = 1 AND V_SCHM_TYPE IN ('SBA', 'CAA') 
  THEN 
    select count(1)
    into v_count1
    from EQUITYCMS.cms_facility_dtls@FINACLE_CAS
    where facility_id = v_finacle_acct;
    
    IF V_COUNT1 = 1
    THEN
       select FACILITY_AMT
       into v_old_amt
       from EQUITYCMS.CMS_FACILITY_DTLS@FINACLE_CAS
       where FACILITY_ID = v_finacle_acct;

    
      UPDATE EQUITYCMS.CMS_FACILITY_DTLS@FINACLE_CAS
      set FACILITY_AMT = v_sanct_lim
      where FACILITY_ID = v_finacle_acct;
      commit;
      
      --dbms_output.put_line ('Account '|| v_finacle_acct || ' updated sanction from '|| v_old_amt ||' to ' || v_sanct_lim );
      
      elsif V_COUNT1 = 0
      then
        select foracid facility_id, sanct_lim facility_Amt, schm_code|| '- OD' facility_type, acct_name customer_name, gam.acct_crncy_code facility_currency,
        cust_id, 'FINACLE' source_system
        into v_facility_id, v_facility_amt, v_facility_type, v_customer_name, v_facility_currency, v_cust__id, v_source_system
        from tbaadm.gam
        where foracid = v_finacle_acct
	and bank_id = v_bank_id;
        
        insert into EQUITYCMS.CMS_FACILITY_DTLS@FINACLE_CAS
        values
        (v_facility_id, v_facility_amt, v_facility_type, v_customer_name, v_facility_currency, v_cust__id, v_source_system);
        commit;
        
        --dbms_output.put_line('The Data for Loan Account '||v_finacle_acct||' has been updated Successfully.');
      
      end if;
   
    else 
    raise_application_error(-20000, 'The Account '|| v_finacle_acct || ' is either invalid or is not a lienable account. Kindly check.. ');
      
  end if;

exception
when others
then
v_err_code := sqlcode;
v_err_msg := sqlerrm(sqlcode);
  --dbms_output.put_line('The Program encountered an error - '||v_err_code||' - '||v_err_msg);

end;
/

grant execute,debug on custom.input_single_facility to tbaadm, tbagen, tbautil
/


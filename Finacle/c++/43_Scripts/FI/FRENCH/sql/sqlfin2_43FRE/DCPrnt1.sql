set numformat 999999999999.99
SET SERVEROUTPUT ON  size 100000
set maxdata 60000
set lines 600
set pages 1000
set pagesize 0
set term off
set echo off
set pause off
set verify off
set feed off

spool DCPrnt1.lst

DECLARE

-- CURSORS
  
    --none

-- VARIABLES

    loc_appl_name        varchar2(150);
    loc_appl_add        varchar2(150);
    loc_appl_phone        varchar2(150);
    loc_appl_email        varchar2(150);
    loc_avail_bank        varchar2(150);
    loc_avail_BIC        varchar2(150);
    loc_date_exp        varchar2(150);
    loc_val_plc            varchar2(150);
    loc_adv_bank        varchar2(150);
    loc_appl_bank        varchar2(150);
    loc_ben_bank        varchar2(150);
    loc_ben_addr        varchar2(150);
    loc_dc_ccy            varchar2(150);
    loc_dc_amt            varchar2(150);
    loc_days_shpd        varchar2(150);
    loc_draw_name        varchar2(150);
    loc_draw_fld        varchar2(150);
    loc_draw_days        varchar2(150);
    loc_plc_exp            varchar2(150);
    loc_port_loading    varchar2(150);    
    loc_port_discharge    varchar2(150);    
    loc_plc_origin        varchar2(150);
    loc_date_shpd        varchar2(150);
    loc_end             varchar2(3);


BEGIN

   BEGIN --[
        select t.name,
        address1,
        (select phoneno from tbaadm.cphone where  preferredflag='Y' and 
        phone_b2kid=(select cif_id from tbaadm.cmg where cust_id=d.issu_party_code and bank_id=d.bank_id) and bank_id=d.bank_id),
        (select email from tbaadm.cemail where  preferredflag='Y' and 
        email_b2kid=(select cif_id from tbaadm.cmg where cust_id=d.issu_party_code and bank_id=d.bank_id) and bank_id=d.bank_id),
        (select Name from tbaadm.tfat where addr_b2kid=d.DC_B2KID
        and addr_id='DCAWBK'
        and bank_id=d.bank_id
        and addr_type='S'),
        (select bic_code from tbaadm.tfat where addr_b2kid=d.DC_B2KID
        and addr_id='DCAWBK'
        and bank_id=d.bank_id
        and addr_type='S'),
        d.EXPIRY_DATE,
        (select REF_DESC from tbaadm.rct where bank_id=d.bank_id and ref_rec_type='01' and ref_code=(
        select city_code from tbaadm.sol where sol_id=d.sol_id and bank_id=d.bank_id)),
        (select Name from tbaadm.tfat where addr_b2kid=d.DC_B2KID
        and addr_id='DCADBK'
        and bank_id=d.bank_id
        and addr_type='S'),
        (select name from tbaadm.tfat where addr_b2kid=d.DC_B2KID
        and addr_id='DCAPBK'
        and bank_id=d.bank_id
        and addr_type='S'),
        (select name from tbaadm.tfat where addr_b2kid=d.DC_B2KID
        and addr_id='DCOTPY'
        and addr_type='S'
        and bank_id=d.bank_id
        ),
        (select address1 from tbaadm.tfat where addr_b2kid=d.DC_B2KID
        and addr_id='DCOTPY'
        and addr_type='S'
        and bank_id=d.bank_id
        ),
        d.ACTL_CRNCY_CODE,
        d.OPEN_VALUE,
        ((LAST_SHIP_DATE-(select db_stat_date from tbaadm.gct where bank_id=d.bank_id))),
        (select name from tbaadm.tfat where addr_b2kid=d.DC_B2KID
        and addr_id='DCDRBK'
        and addr_type='S'),
        free_text1,
        free_text2,
        PLACE_OF_EXPIRY,
        Port_OF_ORIGIN,
        Port_OF_DESTIN,
        Place_OF_ORIGIN,
        LAST_SHIP_DATE, 'end'
        into loc_appl_name , loc_appl_add , loc_appl_phone , loc_appl_email , loc_avail_bank , 
        loc_avail_BIC , loc_date_exp , loc_val_plc , loc_adv_bank , loc_appl_bank , 
        loc_ben_bank , loc_ben_addr , loc_dc_ccy , loc_dc_amt , loc_days_shpd , 
        loc_draw_name , loc_draw_fld , loc_draw_days , loc_plc_exp , loc_port_loading , 
        loc_port_discharge , loc_plc_origin , loc_date_shpd , loc_end
        from tbaadm.tfat t,tbaadm.dcmm d where addr_b2kid=dc_b2kid
        and t.bank_id=d.bank_id
        and d.dc_ref_num='&1'
        and addr_id='DCOUPY'
        and addr_type='S'
        and d.bank_id='&2';

    EXCEPTION
    WHEN no_data_found THEN
         loc_appl_name             := NULL;
         loc_appl_add            := NULL;
         loc_appl_phone          := NULL;
         loc_appl_email          := NULL;
         loc_avail_bank          := NULL;
         loc_avail_BIC           := NULL;
         loc_date_exp            := NULL;
         loc_val_plc             := NULL;
         loc_adv_bank            := NULL;
         loc_appl_bank           := NULL;
         loc_ben_bank            := NULL;
         loc_ben_addr            := NULL;
         loc_dc_ccy              := NULL;
         loc_dc_amt              := NULL;
         loc_days_shpd           := NULL;
         loc_draw_name           := NULL;
         loc_draw_fld            := NULL;
         loc_draw_days           := NULL;
         loc_plc_exp             := NULL;
         loc_port_loading        := NULL;
         loc_port_discharge      := NULL;
         loc_plc_origin          := NULL;
         loc_date_shpd           := NULL;
         loc_end                 := NULL;

         
    END; --]

       dbms_output.put_line( 
            loc_appl_name            ||'|'||
            loc_appl_add            ||'|'||
            loc_appl_phone          ||'|'||
            loc_appl_email          ||'|'||
            loc_avail_bank          ||'|'||
            loc_avail_BIC           ||'|'||
            loc_date_exp            ||'|'||
            loc_val_plc             ||'|'||
            loc_adv_bank            ||'|'||
            loc_appl_bank           ||'|'||
            loc_ben_bank            ||'|'||
            loc_ben_addr            ||'|'||
            loc_dc_ccy              ||'|'||
            loc_dc_amt              ||'|'||
            loc_days_shpd           ||'|'||
            loc_draw_name           ||'|'||
            loc_draw_fld            ||'|'||
            loc_draw_days           ||'|'||
            loc_plc_exp             ||'|'||
            loc_port_loading        ||'|'||
            loc_port_discharge      ||'|'||
            loc_plc_origin          ||'|'||
            loc_date_shpd           ||'|'||
            loc_end                              
                             );
END; 
/
spool off
exit

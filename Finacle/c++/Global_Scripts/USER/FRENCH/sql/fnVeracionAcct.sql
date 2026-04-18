CREATE OR REPLACE FUNCTION CUSTOM.VERACIOUS_ACCT(
v_foracid varchar,v_bankId varchar
)
RETURN varchar
IS 
v_foracidGot tbaadm.gam.foracid%type;
v_count number := 0;
cnt number := 0;
v_foracidRet tbaadm.gam.foracid%type;

begin
dbms_output.put_line('INPUT : '  ||v_foracid ||  ' ' || v_bankId);

for c in (select sol_id from tbaadm.sol where bank_id = v_bankId and del_flg = 'N')
loop
    dbms_output.put_line('Ok '  || c.sol_id);
    
    select count(1) into v_count 
    from tbaadm.gam
    where foracid = c.sol_id||v_foracid
    and bank_id = v_bankId
    and NVL(acct_cls_flg,'Y') = 'N'
    and NVL(del_flg,'Y') = 'N';
    
    dbms_output.put_line('Count : '  || v_count );
    
    if(v_count = 1)then
          dbms_output.put_line('GOT IT TIMES : ' || cnt);  
           select foracid into v_foracidGot 
           from tbaadm.gam
           where foracid = c.sol_id||v_foracid;
    
          v_foracidRet := v_foracidGot;
          cnt := cnt + 1;
    END IF;
    
end loop;

if (cnt = 1 ) THEN
   dbms_output.put_line('true');
   return v_foracidRet;
else if ( cnt > 1 ) then
        dbms_output.put_line('false');
        return '2';
    else
        dbms_output.put_line('false');
        return '0';   
    end if;
end if;


end;
/

show err

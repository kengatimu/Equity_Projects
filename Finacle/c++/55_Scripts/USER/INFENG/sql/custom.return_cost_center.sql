DROP FUNCTION CUSTOM.RETURN_COST_CENTER;

CREATE OR REPLACE FUNCTION CUSTOM.RETURN_COST_CENTER (vCostCenter in varchar2,vBankId in varchar2)RETURN VARCHAR2 IS
    nCount NUMBER;
BEGIN
    select count(1) into nCount 
    from tbaadm.rct 
    where ref_rec_type ='AK'
    and bank_id = vBankId
    and ref_code = vCostCenter;
    if nCount = 1 then
     return(vCostCenter);
    else
     return('DEFAULT');
    end if;
EXCEPTION
WHEN OTHERS THEN
RAISE_APPLICATION_ERROR(-20000,'Cost center check failed ...'||SQLCODE);
END;
/

CREATE OR REPLACE FUNCTION CUSTOM.VALIDATE_IPO_APPLICATION (vCDSNo IN VARCHAR2,  vCRBAnkAccountNo IN VARCHAR2, nTransactionAmout IN NUMBER,nBankId IN VARCHAR2)
RETURN VARCHAR2 
AS
vReturnValue    VARCHAR2(25);
nIPOUnitPrice   NUMBER;
nMinimumShares  NUMBER;
vIPOid          VARCHAR2(15);
vTotalCharges   NUMBER :=0;
nShareBlockSize NUMBER;
vAccountName    VARCHAR2(240);
vSourceCode     VARCHAR2(1);
vEQT            VARCHAR2(10);
    
CURSOR cIPOCharges (vIPOCode IN VARCHAR2)
IS
SELECT 
	* FROM CUSTOM.IPO_DEFAULT_CHARGES 
WHERE  
	IPO_DEFAULT_CHARGES .idc_ipo_code = vipocode
AND IPO_DEFAULT_CHARGES.bank_id = nBankId;

BEGIN
--(
    --Step 1. Check if CDS account is valid
    BEGIN
    --(
        SELECT 
			cdup_prefix, 
			TRIM(cdup_other_names||' '||cdup_surname), 
        'C'
        INTO 
			vReturnValue, 
			vAccountName, 
 			vSourceCode
        FROM 
			CUSTOM.CDSC_DMP
        WHERE 
        	CDSC_DMP.cdup_prefix = vcdsno
        AND CDSC_DMP.bank_id = nBankId;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        BEGIN
        --(

			vEQT:=CUSTOM.getCparamValue( 'EEQT','LOANDISB',nBankId);
			SELECT 
				ctn_serial_no,  
				TRIM(ctn_surname||' '||ctn_other_names),
				'T'
			INTO 
				vReturnValue, 
				vAccountName,
				vSourceCode
			FROM 
				CUSTOM.CDSC_TEMP_NUMBERS
			WHERE 
				CTN_SERIAL_NO =  vEQT||vCDSNo
			AND CDSC_TEMP_NUMBERS.bank_id = nBankId;
			
			EXCEPTION
			
			WHEN NO_DATA_FOUND THEN
				vReturnValue:= NULL;
			WHEN OTHERS THEN
				vReturnValue:='ZZ';      
        --)       
        END;
        WHEN OTHERS THEN
			vReturnValue:='ZY';
			vSourceCode :='E';
    --)    
    END;

    DBMS_OUTPUT.PUT_LINE('vReturnValue='||vReturnValue||' vAccountName='||vAccountName||' vSourceCode='||vSourceCode);

    --Step 2. Check  if  amount to debit is valid (This should only be done if the first validation has been satisfied)
    -- DB Error while searching for CDS account
    IF vReturnValue IN ('ZY','ZZ') THEN
    --{
		vSourceCode:='E';
		RETURN (vSourceCode||'|99|INTERNAL ERROR');
    --} 
    ELSE
    --{
		IF vReturnValue IS NOT NULL THEN
		--{		
			--Step 2a. Check if the amount meets minum amout requirements 
		BEGIN
		--(
			SELECT 
				ipo_unit_price, 
				ipo_min_shares, 
				ipo_code, 
				ipo_block_size
			INTO 
				nIPOUnitPrice, 
				nMinimumShares, 
				vIPOid, 
				nShareBlockSize
			FROM 
				CUSTOM.IPOS A, 
				CUSTOM.IPO_ACCOUNTS B
			WHERE 
      A.ipo_code = B.acc_ipo_code
			AND IPO_CLS_FLG = 'N'
			AND B.ACC_FORACID = vCRBankAccountNO
			AND A.bank_id = nBankId 
      AND A.bank_id = B.bank_id;
			EXCEPTION
			WHEN NO_DATA_FOUND THEN
				vSourceCode:='E';
			RETURN(vSourceCode||'|04|INVALID COLLECTION ACCOUNT');                
			WHEN OTHERS THEN 
				vSourceCode:='E';
			RETURN(vSourceCode||'|99|INTERNAL ERROR');
		--) 
		END;
		-- Total Up all charges. (Assumption is that the amount passed to this function is inclusive of charges)
		BEGIN 
		--(
			FOR I IN cIPOCharges (vIPOid)LOOP
			--{
				IF I.IDC_APPLICABLE_ON =  'F' THEN
				--{
					vTotalCharges := vTotalCharges + (I.IDC_MULTIPLIER/I.IDC_DIVISOR);
				--}
				END IF;
			--}
			END LOOP;
			EXCEPTION
				WHEN OTHERS THEN
					NULL;
		--)
		END;
		
		--Insufficient amount to purchase minimum shares plus pay IPO processing charges.
		IF nvl(nTransactionAmout,0) < nvl(vTotalCharges,0)+(nvl(nIPOUnitPrice,0) * nvl(nMinimumShares,0)) THEN 
		--{
			vSourceCode := 'E';
			RETURN(vSourceCode||'|02|INSUFFICIENT AMOUNT TO DEBIT');
			ELSE
			--{
				--Check if amount can buy complete blocks of shares
				IF MOD(nTransactionAmout - (nvl(vTotalCharges,0)+(nvl(nIPOUnitPrice,0) * nvl(nMinimumShares,0))), (nvl(nIPOUnitPrice,0) * nShareBlockSize)) <>0 THEN
				--{
					vSourceCode:='E';
					RETURN(vSourceCode||'|03|INVALID AMOUNT');
				--}
				ELSE
				--{
					RETURN(vSourceCode||'|00|'||vAccountName);
				--}
				END IF;
			--}
			END IF;
		--}
		ELSE --CDS account number not found(Return value is null)
		--{
			vSourceCode := 'E';
			RETURN(vSourceCode||'|01|INVALID CDS ACCOUNT');
		--}
		END IF;
    --}
    END IF;
--)
END;
/

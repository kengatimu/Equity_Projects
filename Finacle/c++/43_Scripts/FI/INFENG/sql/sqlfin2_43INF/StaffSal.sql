---------------------------------------------------------------------------------
--    File Name                  : StaffSal.sql 
--    Tables Used                : GAM,DATALOAD_ACC_MAP,STAFFSAL,STAFFSALERR
--    Date                       : 27.02.2013
--    Author                     : DhanaPrabhakaran 
--    Assumptions                : NA
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>		<Description>
--       1.          27.02.2013     DhanaPrabhakaran            Original Version
-----------------------------------------------------------------------------------
DECLARE
	v_cnt NUMBER :=0;
BEGIN

	DELETE CUSTOM.STAFFSALERR;

	UPDATE 
		CUSTOM.STAFFSAL 
	SET 
		newacc	= (SELECT 
						newacc 
					FROM 
						CUSTOM.DATALOAD_ACC_MAP a ,TBAADM.GAM
					WHERE 
						solid = a.sol_id 
						AND SUBSTR(STAFFSAL.oldacc,4) = a.oldacc
						AND a.newacc = GAM.foracid
						AND GAM.bank_id = &1);
				
FOR i IN (SELECT solid,oldacc,amt,trantype FROM CUSTOM.STAFFSAL WHERE newacc IS NULL) LOOP
--{
	v_cnt := 0;
	
	SELECT 
		COUNT(1)
	INTO 
		v_cnt
	FROM 
		TBAADM.GAM
	WHERE
		foracid = TRIM(i.oldacc)
		AND bank_id = &1;
	 
	IF (NVL(v_cnt,0)  != 0) THEN
	  	
		UPDATE 
			CUSTOM.STAFFSAL
		SET 
			newacc = i.oldacc
	 	WHERE 
			oldacc = i.oldacc
			AND newacc IS NULL;
		ELSE
			INSERT INTO CUSTOM.STAFFSALERR (solid, oldacc, amt, trantype, errtext) 
			VALUES(i.solid,i.oldacc,i.amt,i.trantype,'Account does not exists or its closed');
	END IF;
	  
	COMMIT;
--}
END LOOP;


UPDATE 
	CUSTOM.STAFFSAL
SET 
	newacc = oldacc
WHERE 
	newacc IS NULL;
COMMIT;
END;
/
spool StaffSalerrFATAL.log
SELECT * FROM CUSTOM.STAFFSALERR
/
spool off

SET PAGES 0
SET HEADING OFF
SET trims ON
SET verify OFF
SET feedback OFF

spool StaffSal.lst
SELECT TRIM(solid)||'|'||TRIM(newacc)||'|'||TRIM(amt)||'|'||TRIM(trantype) FROM CUSTOM.STAFFSAL
ORDER BY srno
/
spool off
/

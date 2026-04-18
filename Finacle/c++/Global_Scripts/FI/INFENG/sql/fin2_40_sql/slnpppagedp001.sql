---------------------------------------------------------------------------------
--    File Name                  : slnpppagedp001.sql 
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

	DELETE CUSTOM.STAFFSALERR WHERE bank_id = '&1';

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
						AND a.bank_id = GAM.bank_id
						AND GAM.bank_id = '&1')
	WHERE bank_id = '&1';
				
FOR i IN (SELECT solid,oldacc,amt,trantype FROM CUSTOM.STAFFSAL WHERE newacc IS NULL and bank_id='&1') LOOP
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
		AND bank_id = '&1';
	 
	IF (NVL(v_cnt,0) != 0) THEN
	  	
		UPDATE 
			CUSTOM.STAFFSAL
		SET 
			newacc = i.oldacc
	 	WHERE 
			oldacc = i.oldacc
			AND bank_id = '&1'
			AND newacc IS NULL;
		ELSE
			INSERT INTO CUSTOM.STAFFSALERR (solid, oldacc, amt, trantype, errtext, bank_id) 
			VALUES(i.solid,i.oldacc,i.amt,i.trantype,'Account does not exists or its closed', '&1');
	END IF;
	  
	COMMIT;
--}
END LOOP;


UPDATE 
	CUSTOM.STAFFSAL
SET 
	newacc = oldacc
WHERE 
	newacc IS NULL
	 AND bank_id = '&1';
COMMIT;
END;
/

SET PAGES 0
SET HEADING OFF
SET trims ON
SET verify OFF
SET feedback OFF

spool &5
--SELECT * FROM CUSTOM.STAFFSALERR WHERE bank_id='&1'
SELECT TRIM(STAFFSALERR.solid)||'|'||TRIM(oldacc)||'|'||TRIM(amt)||'|'||TRIM(trantype)||'|'||'&3' ||'|'||errtext  FROM CUSTOM.STAFFSALERR WHERE bank_id = '&1'
/
spool off

spool &2
SELECT TRIM(solid)||'|'||TRIM(newacc)||'|'||TRIM(amt)||'|'||TRIM(trantype) ||'|'||'&3' ||'|'||'&4' FROM CUSTOM.STAFFSAL WHERE bank_id='&1' 
ORDER BY srno
/
spool off

--=================================================================================================================*
-- Name                          :   stmchrgmnmn001.sql
-- Date                          :   25-02-2013
-- Description                   :   This sql is used generate data for Statement.
-- Author                        :   Saurabh Sinha
-- Reference                     :
-- Modification History  :
--  <Serial No.>  <Date>         <AuthorName>            <Description>
----------------------------------------------------------------------------
--   1           25-02-2013      Saurabh Sinha               Original version
--=================================================================================================================*
SET PAGES 0
SET HEADING OFF
SET TRIMS ON
SET VERIFY OFF
SET FEED OFF
SET TERM OFF
SET LINESIZE 250
SET SERVEROUTPUT ON


DECLARE
	v_cnt		NUMBER :=0;
	v_sol_id	TBAADM.GAM.sol_id%TYPE ;
	v_bank_id	TBAADM.GAM.bank_id%TYPE ;

BEGIN
	SELECT
		'&1'
	INTO
		v_bank_id
	FROM 
		DUAL;

	FOR i IN ( 	
			SELECT 
				STATEMENTCHRGS.foracid,
				STATEMENTCHRGS.page 
			FROM 
				CUSTOM.STATEMENTCHRGS
			WHERE
				STATEMENTCHRGS.bank_id = v_bank_id
		)
	LOOP
		v_cnt	:= 0;

		SELECT 
			COUNT(1)
		INTO 
			v_cnt
		FROM 
			TBAADM.GAM
		WHERE 
			GAM.foracid = TRIM(i.foracid)
			AND GAM.bank_id = v_bank_id;
		
		IF (NVL(v_cnt,0) = 0) THEN
		--{
			UPDATE 
				CUSTOM.STATEMENTCHRGS
			SET 
				STATEMENTCHRGS.sol_id = '&8'
			WHERE 
				STATEMENTCHRGS.foracid = i.foracid
				AND STATEMENTCHRGS.bank_id = v_bank_id;
		--}
		ELSE
		--{
			SELECT 
				GAM.sol_id
			INTO
				v_sol_id
			FROM 
				TBAADM.GAM
			WHERE 
				GAM.foracid = TRIM(i.foracid)
				AND GAM.bank_id = v_bank_id;
			
			UPDATE 
				CUSTOM.STATEMENTCHRGS
			SET 
				STATEMENTCHRGS.sol_id = v_sol_id
			WHERE
				STATEMENTCHRGS.foracid = i.foracid
				AND STATEMENTCHRGS.bank_id = v_bank_id;
		--}
		END IF;
		COMMIT;

	END LOOP;
END;
/
spool off
/
SPOOL &2

(SELECT 
	sol_id||'|'||foracid||'|'||'D'||'|'||'&4'||'|'||'&6'||'|'||'&5'
FROM 
	CUSTOM.STATEMENTCHRGS 
WHERE
	STATEMENTCHRGS.bank_id = '&1') UNION ALL
(SELECT 
	'&7'||'|'||sol_id||'&3'||'|'||'C'||'|'||((count(1)*'&4'))||'|'||'&6'||'|'||'&5'
FROM 
	CUSTOM.STATEMENTCHRGS 
WHERE
	STATEMENTCHRGS.bank_id = '&1'
GROUP BY 
	sol_id);

SPOOL OFF

EXIT;

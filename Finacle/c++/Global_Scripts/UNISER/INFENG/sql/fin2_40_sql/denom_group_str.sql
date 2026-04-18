CREATE OR REPLACE FUNCTION custom.DENOM_GROUP_STR(
tellerId varchar,crncy varchar,solId varchar,ind char,
tranId varchar, tranDate date
)
RETURN varchar
IS
CURSOR c1 IS
	SELECT A.denom_ind,(A.denom_count - B.denom_count) denom_count FROM custom.C_DENM A, custom.C_DENM_DR B
	WHERE A.crncy_code = B.crncy_code AND A.denom_value = B.denom_value AND A.denom_ind = B.denom_ind 
	AND A.sol_id = B.sol_id AND A.teller_id = B.teller_id  
	AND A.teller_id = tellerId AND A.CRNCY_CODE = crncy AND A.sol_id = solId 
	AND A.denom_ind = ind AND A.del_flg != 'Y'
	ORDER BY A.Denom_Ind,A.Denom_Value DESC;

i c1%rowtype;
resultStr VARCHAR2(100):='';
denomCnt NUMBER:=0;
tranDenomCntStr VARCHAR2(100):='';
tranDenomValStr VARCHAR2(100):='';
tranDenomCnt VARCHAR2(10):='';
tranDenomVal VARCHAR2(10):='';
cnt NUMBER:=0;
startPos NUMBER;
endPos NUMBER;
BEGIN
	IF(TRIM(tranId) IS NOT NULL) THEN
		tranDenomCntStr := denom_str_add(tranId,tranDate,crncy,ind);
	END IF;	
	FOR i IN c1
	LOOP
		IF (tranDenomCntStr IS NOT NULL) THEN
			IF (cnt = 0) THEN
				startPos := 1;
			ELSE
				startPos := INSTR(tranDenomCntStr,'-',1,cnt) + 1;
			END IF;
			endPos := INSTR(tranDenomCntStr,'-',1,cnt+1);
			tranDenomCnt := SUBSTR(tranDenomCntStr,startPos,endPos-startPos);
			IF(TRIM(tranDenomCnt) IS NULL) THEN
				denomCnt := i.denom_count;
			ELSE
				denomCnt := i.denom_count + tranDenomCnt;
			END IF;
		ELSE
			denomCnt := i.denom_count;
		END IF;
		resultStr := CONCAT(resultStr, CONCAT(denomCnt,'-'));
		cnt := cnt + 1;
	END LOOP;
	RETURN(substr(resultStr,0,length(resultStr)-1));
END denom_group_str;
/
create or replace synonym tbagen.denom_group_str for custom.denom_group_str
/
create or replace synonym tbautil.denom_group_str for custom.denom_group_str
/
grant execute on custom.denom_group_str to tbagen,tbautil
/


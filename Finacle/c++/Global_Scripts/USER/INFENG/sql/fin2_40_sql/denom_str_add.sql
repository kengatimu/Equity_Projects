CREATE OR REPLACE FUNCTION custom.DENOM_STR_ADD(
tranId varchar, tranDate date,crncy varchar,ind char
)
RETURN varchar
IS
CURSOR c1 IS
	SELECT TO_CHAR(denom_count) denom_count FROM custom.c_detd 
	WHERE dxfer_id = tranId AND tran_date = tranDate AND ptran_type='D' AND dxfer_flg = 'E'
	AND crncy_code = crncy AND denom_ind=ind AND (type IS NULL OR type = 'GB');

i c1%rowtype;
resultStr VARCHAR2(100):='';
totalStr VARCHAR2(100):='';
endStr CHAR:='N';
str1 VARCHAR2(100):='';
str2 VARCHAR2(100):='';
incnt NUMBER:=0;
cnt NUMBER:=0;
startPos1 NUMBER:=100;
startPos2 NUMBER:=100;
endPos1 NUMBER;
endPos2 NUMBER;
BEGIN
FOR i IN c1
LOOP
	IF (cnt = 0) THEN
		totalStr := i.denom_count;
	ELSE
		WHILE endStr = 'N' LOOP
			dbms_output.put_line('WHILE START');
			dbms_output.put_line('totalStr='||totalStr);
			dbms_output.put_line('i.denom_count='||i.denom_count);
			IF (incnt = 0) THEN
				startPos1	:= 1;
				startPos2	:= 1;
			ELSE
				startPos1	:= INSTR(totalStr,'-',1,incnt) + 1;
				startPos2	:= INSTR(i.denom_count,'-',1,incnt) + 1;
				IF (startPos1 = 1) THEN
					endStr := 'Y';
				END IF;
			END IF;
			IF (endStr = 'N') THEN
				endPos1	:=	INSTR(totalStr,'-',1,incnt+1);
				endPos2	:=	INSTR(i.denom_count,'-',1,incnt+1);
				dbms_output.put_line('startPos1='||startPos1);
				dbms_output.put_line('endPos1='||endPos1);

				IF (endPos1 = 0) THEN
					str1 := SUBSTR(totalStr,startPos1);
					str2 := SUBSTR(i.denom_count,startPos2);
					dbms_output.put_line('STR1 IN='||str1);
				ELSE
					str1 := SUBSTR(totalStr,startPos1,endPos1-startPos1);
					str2 := SUBSTR(i.denom_count,startPos2,endPos2-startPos2);
				END IF;
				
				dbms_output.put_line('STR1='||str1);
				dbms_output.put_line('STR2='||str2);

				resultStr := CONCAT(CONCAT(resultStr,(TO_NUMBER(str1) + TO_NUMBER(str2))),'-');
				dbms_output.put_line('resultStr='||resultStr);
				incnt := incnt + 1;
			END IF;
			dbms_output.put_line('WHILE END');
		END LOOP;
		totalStr := SUBSTR(resultStr,0,LENGTH(resultStr)-1);
		resultStr := '';
		endStr := 'N';
	END IF;
	cnt := cnt + 1;
	incnt := 0;
END LOOP;
dbms_output.put_line('RETRUN ='||totalStr);
RETURN(totalStr);
END DENOM_STR_ADD;
/
create or replace synonym tbagen.DENOM_STR_ADD for custom.DENOM_STR_ADD
/
create or replace synonym tbautil.DENOM_STR_ADD for custom.DENOM_STR_ADD
/
grant execute on custom.DENOM_STR_ADD to tbautil,tbagen
/


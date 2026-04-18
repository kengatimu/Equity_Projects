DROP PACKAGE CUSTOM.EQUITYCOMMONPACK;

CREATE OR REPLACE PACKAGE CUSTOM.EQUITYCommonPack AS

PROCEDURE GETCHQDIGIT(inForacid IN VARCHAR2,
                    inSortCode IN VARCHAR2,
                    outChqDigit OUT VARCHAR2);
END EQUITYCommonPack;
/

DROP PACKAGE BODY CUSTOM.EQUITYCOMMONPACK;

CREATE OR REPLACE PACKAGE BODY CUSTOM.EQUITYCommonPack AS
PROCEDURE GETCHQDIGIT(inForacid IN VARCHAR2,
                    inSortCode IN VARCHAR2,
                    outChqDigit OUT VARCHAR2) IS
A1    NUMBER;
A2    NUMBER;
A3    NUMBER;
A4    NUMBER;
A5    NUMBER;
A6    NUMBER;
A7    NUMBER;
A8    NUMBER;
A9    NUMBER;
A10    NUMBER;
S1    NUMBER;
S2    NUMBER;
S3    NUMBER;
S4    NUMBER;
S5    NUMBER;
T1    NUMBER;
T2    NUMBER;
T3    NUMBER;


BEGIN

    A1    := TO_NUMBER(SUBSTR(inForacid,4,1));
    A2    := TO_NUMBER(SUBSTR(inForacid,5,1));
    A3    := TO_NUMBER(SUBSTR(inForacid,6,1));
    A4    := TO_NUMBER(SUBSTR(inForacid,7,1));
    A5    := TO_NUMBER(SUBSTR(inForacid,8,1));
    A6    := TO_NUMBER(SUBSTR(inForacid,9,1));
    A7    := TO_NUMBER(SUBSTR(inForacid,10,1));
    A8    := TO_NUMBER(SUBSTR(inForacid,11,1));
    A9    := TO_NUMBER(SUBSTR(inForacid,12,1));
    A10    := TO_NUMBER(SUBSTR(inForacid,13,1));
    S1    := TO_NUMBER(SUBSTR(inSortCode,1,1));
    S2    := TO_NUMBER(SUBSTR(inSortCode,2,1));
    S3    := TO_NUMBER(SUBSTR(inSortCode,3,1));
    S4    := TO_NUMBER(SUBSTR(inSortCode,4,1));
    S5    := TO_NUMBER(SUBSTR(inSortCode,5,1));
    T1:= (A10+A8+A6+A4+A2+S4+S2);
    T2:= FLOOR((2*A9)/10) + ((2*A9)MOD 10);
    T2:= T2 + FLOOR((2*A7)/10) + ((2*A7)MOD 10);
    T2:= T2 + FLOOR((2*A5)/10) + ((2*A5)MOD 10);
    T2:= T2 + FLOOR((2*A3)/10) + ((2*A3)MOD 10);
    T2:= T2 + FLOOR((2*A1)/10) + ((2*A1)MOD 10);
    T2:= T2 + FLOOR((2*S5)/10) + ((2*S5)MOD 10);
    T2:= T2 + FLOOR((2*S3)/10) + ((2*S3)MOD 10);
    T2:= T2 + FLOOR((2*S1)/10) + ((2*S1)MOD 10);
     T3:= (T1 + T2)MOD 10;

    IF T3 > 0 THEN
        T3:= 10 - T3;
    END IF;

    outChqDigit:=T3;


END GETCHQDIGIT;
-----------------------------------------------------------
--End of the Package
-----------------------------------------------------------
END EQUITYCommonPack;
/


GRANT EXECUTE ON CUSTOM.EQUITYCOMMONPACK TO ALLTAB;

GRANT EXECUTE ON CUSTOM.EQUITYCOMMONPACK TO TBAADM;

GRANT EXECUTE ON CUSTOM.EQUITYCOMMONPACK TO TBAGEN;

GRANT EXECUTE ON CUSTOM.EQUITYCOMMONPACK TO TBAUTIL;

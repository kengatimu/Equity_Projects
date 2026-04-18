create or replace FUNCTION        CUST_GetPenaltyAmtForODA (
   inp_acctid   VARCHAR2,
   inp_cifid    VARCHAR2,
   inp_scheme   VARCHAR2,
   inp_amount   VARCHAR2,
   inp_bankid   VARCHAR2
)
   RETURN VARCHAR2
AS
   PERCENT     VARCHAR2 (50) := '0';
   out_rec     VARCHAR2 (50) := '0';
   tempcount   NUMBER        := 0;
BEGIN
   SELECT COUNT (*)
     INTO tempcount
     FROM custom.c_ppt
    WHERE level_id IN (inp_acctid, inp_cifid, inp_scheme)
      AND del_flg = 'N'
      AND bank_id = inp_bankid;

   IF tempcount = 0
   THEN
      RETURN '0';
   END IF;

   SELECT NVL (MAX (penalty_prcnt), '999')
     INTO PERCENT
     FROM custom.c_ppt
    WHERE level_type = 'A'
      AND level_id = inp_acctid
      AND del_flg = 'N'
      AND bank_id = inp_bankid;

   IF PERCENT != '999'
   THEN
      RETURN PERCENT;
   END IF;

   SELECT NVL (MAX (penalty_prcnt), '999')
     INTO PERCENT
     FROM custom.c_ppt
    WHERE level_type = 'C'
      AND level_id = inp_cifid
      AND del_flg = 'N'
      AND bank_id = inp_bankid;

   IF PERCENT != '999'
   THEN
      RETURN PERCENT;
   END IF;

   SELECT NVL (MAX (penalty_prcnt), '999')
     INTO PERCENT
     FROM custom.c_ppt
    WHERE level_type = 'S'
      AND level_id = inp_scheme
      AND del_flg = 'N'
      AND bank_id = inp_bankid;

   IF PERCENT != '999'
   THEN
	RETURN PERCENT;
   END IF;
   
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN '0';
END;

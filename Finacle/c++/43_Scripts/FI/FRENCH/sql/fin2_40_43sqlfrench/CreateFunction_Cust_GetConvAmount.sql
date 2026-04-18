/* Formatted on 2018/12/06 13:26 (Formatter Plus v4.8.8) */
--====================================================================================================
-- Function Name: custom.cust_GetConvAmount
-- Synonym Name : 
-- Date: 01-Feb-2019
-- Description: This function is use to convert the amount.
-- Author: Anshul_Singh04
-- Modification History :
--<Version No.> <Date> <Author Name> <Description>
--====================================================================================================

/* Formatted on 2019/02/01 13:55 (Formatter Plus v4.8.8) */
CREATE OR REPLACE FUNCTION custom.cust_GetConvAmount (inp_amount VARCHAR2)
   RETURN VARCHAR2
AS
   tmp_amt   VARCHAR2 (20) := '0';
BEGIN
   SELECT REPLACE (inp_amount, '.', '')
     INTO tmp_amt
     FROM DUAL;

   SELECT REPLACE (tmp_amt, ',', '.')
     INTO tmp_amt
     FROM DUAL;

   SELECT CEIL (tmp_amt)
     INTO tmp_amt
     FROM DUAL;

   RETURN tmp_amt;
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN '0';
END;

GRANT EXECUTE ON custom.cust_GetConvAmount TO tbaadm;

GRANT EXECUTE ON custom.cust_GetConvAmount TO tbautil;

GRANT EXECUTE ON custom.cust_GetConvAmount TO tbagen;

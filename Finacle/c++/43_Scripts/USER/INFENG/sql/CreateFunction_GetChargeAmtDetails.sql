/* Formatted on 2018/10/19 09:36 (Formatter Plus v4.8.8) */
--====================================================================================================
-- Function Name: custom.cust_getchargeamtdetails
-- Synonym Name : 
-- Date: 18-Oct-2018
-- Description: This function is used fetch the Charge and VAT amount of Charge Transaction.
-- Author: Anshul_Singh04
-- Modification History :
--<Version No.> <Date> <Author Name> <Description>
--====================================================================================================

CREATE OR REPLACE FUNCTION custom.cust_getchargeamtdetails (
   trantype   VARCHAR2,
   tranid     VARCHAR2,
   trandate   DATE,
   srlnum     VARCHAR2,
   bankid     VARCHAR2,
   evnttype   VARCHAR2
)
   RETURN VARCHAR2
AS
   out_rec     VARCHAR2 (50)  := 'NNN~0';
   crncycode   VARCHAR2 (3)   := 'NNN';
   amount      NUMBER (20, 4) := 0;
BEGIN
   IF trantype = 'T'
   THEN
      SELECT   NVL (coll_crncy_code, 'NNN'), NVL (SUM (actual_amt_coll), '0')
          INTO crncycode, amount
          FROM tbaadm.cxl
         WHERE parent_tran_id = tranid
           AND parent_tran_date = trandate
           AND parent_tran_srl_num = LPAD (srlnum, '4', ' ')
           AND bank_id = bankid
           AND event_type = evnttype
      GROUP BY event_type, coll_crncy_code;
   ELSE
      SELECT   NVL (coll_crncy_code, 'NNN'), NVL (SUM (actual_amt_coll), '0')
          INTO crncycode, amount
          FROM tbaadm.cxl
         WHERE chrg_tran_id = tranid
           AND chrg_tran_date = trandate
           AND bank_id = bankid
           AND event_type = evnttype
      GROUP BY event_type, coll_crncy_code;
   END IF;

   SELECT CONCAT (crncycode, CONCAT ('~', amount))
     INTO out_rec
     FROM DUAL;

   RETURN out_rec;
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN 'XXX~0';
END;
/

--====================================================================================================                    
-- Table Name             : CUSTOM.GETINTERESTPARTS    
-- Date                   : 26-SEP-2018                    
-- Description            : This function will return the parts on interest and penal interest being satisfied by the HLASPAY payment 
-- Author                 : AnuragGhosh_D     
-- Modification History   :                    
-- <Version No.>         <Date>                 <Author Name>               <Description>                    
--====================================================================================================


CREATE OR REPLACE FUNCTION CUSTOM.GETINTERESTPARTS (
   v_foracid           IN   VARCHAR2,
   v_sat_amt           IN   VARCHAR2,
   v_contextbankid     IN   VARCHAR2,
   v_normal_or_penal   IN   VARCHAR2
)
   RETURN NUMBER
IS
BEGIN
   DECLARE
      v_pidem_cnt        NUMBER := 0;
      v_pidem_amt        NUMBER := 0;
      v_indem_amt        NUMBER := 0;
      v_normal_sat_amt   NUMBER := 0;
      v_penal_sat_amt    NUMBER := 0;
      v_int_sat_amt      NUMBER := v_sat_amt;
      v_tot_normal_amt     NUMBER := 0;
      v_tot_penal_amt     NUMBER := 0;

      
      CURSOR maincursor
      IS
         SELECT DISTINCT dmd_eff_date
                    FROM tbaadm.ldt
                   WHERE bank_id = v_contextbankid
                     AND acid =
                            (SELECT acid
                               FROM tbaadm.gam
                              WHERE foracid = v_foracid
                                AND bank_id = v_contextbankid)
                     AND dmd_amt != tot_adj_amt
                     AND del_flg = 'N'
                     AND dmd_flow_id IN ('INDEM')
                     union
                     SELECT DISTINCT dmd_eff_date
                    FROM tbaadm.la_pdt
                   WHERE bank_id = v_contextbankid
                     AND acid =
                            (SELECT acid
                               FROM tbaadm.gam
                              WHERE foracid = v_foracid
                                AND bank_id = v_contextbankid)
                     AND dmd_amt != tot_adj_amt
                     AND del_flg = 'N'
                     AND dmd_flow_id IN ('APDEM')
                ORDER BY dmd_eff_date ASC;
   BEGIN
   v_tot_penal_amt :=0;
   v_tot_normal_amt :=0;
   
      FOR lnrec IN maincursor
      LOOP
         --DBMS_OUTPUT.PUT_LINE(LNREC.dmd_eff_date||'|'||v_foracid);
         BEGIN
         
            v_pidem_amt := 0;
            v_indem_amt := 0;
         
            IF (v_int_sat_amt > 0)
            THEN
               SELECT COUNT (1)
                 INTO v_pidem_cnt
                 FROM tbaadm.la_pdt
                WHERE bank_id = v_contextbankid
                  AND acid =
                         (SELECT acid
                            FROM tbaadm.gam
                           WHERE foracid = v_foracid
                             AND bank_id = v_contextbankid)
                  AND dmd_amt != tot_adj_amt
                  AND del_flg = 'N'
                  AND dmd_eff_date = lnrec.dmd_eff_date
                  AND dmd_flow_id IN ('APDEM');

               IF (v_pidem_cnt > 0)
               THEN
                  SELECT (dmd_amt - tot_adj_amt)
                    INTO v_pidem_amt
                    FROM tbaadm.la_pdt
                   WHERE bank_id = v_contextbankid
                     AND acid =
                            (SELECT acid
                               FROM tbaadm.gam
                              WHERE foracid = v_foracid
                                AND bank_id = v_contextbankid)
                     AND dmd_amt != tot_adj_amt
                     AND del_flg = 'N'
                     AND dmd_eff_date = lnrec.dmd_eff_date
                     AND dmd_flow_id IN ('APDEM');

                  SELECT (dmd_amt - tot_adj_amt)
                    INTO v_indem_amt
                    FROM tbaadm.ldt
                   WHERE bank_id = v_contextbankid
                     AND acid =
                            (SELECT acid
                               FROM tbaadm.gam
                              WHERE foracid = v_foracid
                                AND bank_id = v_contextbankid)
                     AND dmd_amt != tot_adj_amt
                     AND del_flg = 'N'
                     AND dmd_eff_date = lnrec.dmd_eff_date
                     AND dmd_flow_id IN ('INDEM');
               ELSE
                  SELECT (dmd_amt - tot_adj_amt)
                    INTO v_indem_amt
                    FROM tbaadm.ldt
                   WHERE bank_id = v_contextbankid
                     AND acid =
                            (SELECT acid
                               FROM tbaadm.gam
                              WHERE foracid = v_foracid
                                AND bank_id = v_contextbankid)
                     AND dmd_amt != tot_adj_amt
                     AND del_flg = 'N'
                     AND dmd_eff_date = lnrec.dmd_eff_date
                     AND dmd_flow_id IN ('INDEM');
               END IF;

               IF (v_pidem_amt > 0)
               THEN
                  --IF (v_int_sat_amt > v_pidem_amt)
                  --THEN
                     v_tot_penal_amt := v_tot_penal_amt + v_pidem_amt;
                     DBMS_OUTPUT.put_line ('v_tot_penal_amt'||'|'||v_tot_penal_amt);
                     --v_int_sat_amt := v_int_sat_amt - v_pidem_amt;
                  --ELSE
                     --v_penal_sat_amt := v_penal_sat_amt + v_int_sat_amt;
                     --v_int_sat_amt := 0;
                  --END IF;
               END IF;

               IF (v_indem_amt > 0)
               THEN
                  --IF (v_int_sat_amt > v_indem_amt)
                  --THEN
                     v_tot_normal_amt := v_tot_normal_amt + v_indem_amt;
                     DBMS_OUTPUT.put_line ('v_tot_normal_amt'||'|'||v_tot_normal_amt);
                     --v_int_sat_amt := v_int_sat_amt - v_indem_amt;
                  --ELSE
                     --v_normal_sat_amt := v_normal_sat_amt + v_int_sat_amt;
                     --v_int_sat_amt := 0;
                  --END IF;
               END IF;
            END IF;
         END;
      END LOOP;
      
      IF (v_tot_penal_amt > 0)
               THEN
                  IF (v_int_sat_amt > v_tot_penal_amt)
                  THEN
                     v_penal_sat_amt := v_tot_penal_amt;
                     v_int_sat_amt := v_int_sat_amt - v_tot_penal_amt;
                  ELSE
                     v_penal_sat_amt := v_int_sat_amt;
                     v_int_sat_amt := 0;
                  END IF;
               END IF;
      
      IF (v_tot_normal_amt > 0)
               THEN
                  IF (v_int_sat_amt > v_tot_normal_amt)
                  THEN
                     v_normal_sat_amt := v_tot_normal_amt;
                     v_int_sat_amt := v_int_sat_amt - v_tot_normal_amt;
                  ELSE
                     v_normal_sat_amt := v_int_sat_amt;
                     v_int_sat_amt := 0;
                  END IF;
               END IF;

      --DBMS_OUTPUT.put_line (v_normal_sat_amt || '|' || v_penal_sat_amt);
      IF (v_normal_or_penal = 'N')
      THEN
         RETURN v_normal_sat_amt;
      ELSE
         RETURN v_penal_sat_amt;
      END IF;
   END;
END getinterestparts;
/

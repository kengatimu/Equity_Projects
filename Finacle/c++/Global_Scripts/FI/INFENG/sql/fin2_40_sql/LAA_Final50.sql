SET head off
SET feedback off
SET verify off
SET serveroutput on size 1000000
SET trimspool on

DECLARE

V_INT_SUSPENSE_AMT        TBAADM.COT.INT_SUSPENSE_AMT%TYPE;
V_PENAL_INT_SUSPENSE_AMT    TBAADM.COT.PENAL_INT_SUSPENSE_AMT%TYPE;
V_PENDING_INTEREST         TBAADM.COT.PENDING_INTEREST%TYPE;
V_Susp_acid            TBAADM.GAM.ACID%TYPE;
V_SUSP_foracid            TBAADM.GAM.FORACID%TYPE;
V_SUSP_bacid            TBAADM.GAM.BACID%TYPE;
V_DR_SUSP            TBAADM.COT.INT_SUSPENSE_AMT%TYPE;
V_CR_SUSP            TBAADM.COT.INT_SUSPENSE_AMT%TYPE;
V_TOT_INT_SUSP            TBAADM.COT.INT_SUSPENSE_AMT%TYPE;
V_EIT_BOOK_NRML            TBAADM.EIT.NRML_BOOKED_AMOUNT_DR%TYPE;    
V_EIT_BOOK_PNL            TBAADM.EIT.NRML_BOOKED_AMOUNT_DR%TYPE;    
V_LDT_OUTST_NRML            TBAADM.LDT.DMD_AMT%TYPE;   
V_LDT_OUTST_PNL            TBAADM.LDT.DMD_AMT%TYPE;     
V_INT_DMD_OS            TBAADM.LAM.INT_DMD_OS%TYPE;
V_PAL_acid            TBAADM.GAM.ACID%TYPE;
V_PAL_foracid            TBAADM.GAM.FORACID%TYPE;
V_PAL_bacid            TBAADM.GAM.BACID%TYPE;
v_remarks                      VARCHAR2(200) := NULL;
v_commit_counter               NUMBER(5) := 0;
v_remarks1                      VARCHAR2(200) := NULL;
v_record_processed             NUMBER(8) := 1;

CURSOR MainCursor is
    Select 
        foracid, 
        A.acid, 
        Sol_id,  
        acct_opn_date, 
        acct_cls_flg, 
        clr_bal_amt, 
        acct_crncy_code, 
        schm_code, 
        pd_flg, 
        chrge_off_flg, 
        pd_xfer_date, 
        PD_RE_XFER_DATE,
        A.BANK_ID
        from tbaadm.GAM A  , tbaadm.GAC B 
        where entity_cre_flg  = 'Y' 
        and del_flg ='N'  
        and schm_type = 'LAA' 
        and A.bank_id ='50'
        and A.acid = B.acid 
        and ((pd_flg = 'Y' and ( chrge_off_flg= 'Y' or chrge_off_flg= 'N')) or( pd_flg = 'N' and PD_RE_XFER_DATE is not Null))
        and A.BANK_ID=B.BANK_ID
        --and A.sol_id >= '000' and A.sol_id <= '008'
	and A.sol_id = '&&1'
        and A.BANK_ID= '50'
    order by sol_id;

BEGIN

    FOR GamGac_rec IN MainCursor
           LOOP
        BEGIN
        
    -- For fetching COT details
        
        BEGIN
            Select 
            NVL(INT_SUSPENSE_AMT,0), 
            NVL(PENAL_INT_SUSPENSE_AMT,0), 
            NVL(PENDING_INTEREST,0) 
            INTO V_INT_SUSPENSE_AMT, V_PENAL_INT_SUSPENSE_AMT, V_PENDING_INTEREST 
            from tbaadm.COT 
            where acid = GamGac_rec.acid    
            and Bank_id = GamGac_rec.bank_id;
                EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          v_remarks := v_remarks||'NO COT Rec, ';
                   END;        
        
    -- For fetching Partitioned Acid
        BEGIN
            Select acid, foracid, bacid
            INTO V_Susp_acid, V_SUSP_foracid, V_SUSP_bacid
            from tbaadm.gam 
            where bacid in (
                Select distinct(int_susp_bacid)
                from tbaadm.aip  
                where schm_code = GamGac_rec.schm_code
                and Bank_id = GamGac_rec.bank_id 
                and sol_id = GamGac_rec.sol_id
                and MAIN_ASSET_CLASS='NPA')
                and acct_crncy_code = GamGac_rec.acct_crncy_code 
                and SOL_ID=GamGac_rec.sol_id
                and bank_id=GamGac_rec.bank_id;
        EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_remarks := v_remarks||'NO SUS BACID, ';
                   END;  

	    -- For fetching P and L Account Details
        BEGIN
            Select acid, foracid, bacid
            INTO V_PAL_acid, V_PAL_foracid, V_PAL_bacid
            from tbaadm.gam 
            where bacid in (
                Select INT_PANDL_BACID_DR 
		from tbaadm.GSP 
                where schm_code = GamGac_rec.schm_code
                and Bank_id = GamGac_rec.bank_id)
                and acct_crncy_code = GamGac_rec.acct_crncy_code 
                and SOL_ID=GamGac_rec.sol_id
                and bank_id=GamGac_rec.bank_id;
        EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_remarks := v_remarks||'NO SUS BACID, ';
                   END;   
        
        
    -- For fecthing ACPART details    
    
        BEGIN
            Select  

            nvl(sum(decode(acpart.part_tran_type,'D','-1',0)*nvl(acpart.tran_amt,0)),0),
            nvl(sum(decode(acpart.part_tran_type,'C','1',0)*nvl(acpart.tran_amt,0)),0),
            nvl(sum(decode(acpart.part_tran_type,'D','-1',1)*nvl(acpart.tran_amt,0)),0)
            INTO V_DR_SUSP, V_CR_SUSP,V_TOT_INT_SUSP
            from tbaadm.acpart  
            where b2k_type = 'ACCNT' 
            and b2k_id = GamGac_rec.acid
            and partitioned_Acid = V_Susp_acid
            and Bank_id = GamGac_rec.bank_id 
			and pstd_flg = 'Y'
            group by b2k_id;                 
        EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          v_remarks := v_remarks||'NO PART DATA, ';
                   END;
     
    -- For fecthing LDT Normal interest Outstanding details    
            
        BEGIN
             Select NVL(sum(dmd_amt - tot_adj_amt),0)
             INTO V_LDT_OUTST_NRML
             from tbaadm.LDT
             where  ldt.acid = GamGac_rec.acid
             and ldt.dmd_flow_id in ('INDEM') 
             and dmd_amt != tot_adj_amt
             and Bank_id = GamGac_rec.bank_id 
             and Bank_id = GamGac_rec.bank_id 
             group by LDT.acid;         
        EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          v_remarks := v_remarks||'NO INDEM LDT, ';
                   END; 

         -- For fecthing LDT Penal interest Outstanding details    
            
        BEGIN
             Select NVL(sum(dmd_amt - tot_adj_amt),0)
             INTO V_LDT_OUTST_PNL
             from tbaadm.LDT
             where  ldt.acid = GamGac_rec.acid
             and ldt.dmd_flow_id in ('PIDEM') 
             and dmd_amt != tot_adj_amt
             and Bank_id = GamGac_rec.bank_id 
             and Bank_id = GamGac_rec.bank_id 
             group by LDT.acid;         
        EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          v_remarks := v_remarks||'NO PIDEM LDT, ';
                   END;     
    
    -- For fecthing LAM Outstanding details    
            
        BEGIN
             Select NVL(INT_DMD_OS,0)
             INTO V_INT_DMD_OS
             from tbaadm.LAM
             where lam.acid =  GamGac_rec.acid
             and Bank_id = GamGac_rec.bank_id; 
        EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          v_remarks := v_remarks||'NO LAM, ';
                   END;    
                   
    -- For fecthing EIT Outstanding details    
            
        BEGIN
             Select NVL((EIT.NRML_BOOKED_AMOUNT_DR - EIT.NRML_INTEREST_AMOUNT_DR),0), NVL((EIT.PENAL_BOOKED_AMOUNT_DR - EIT.PENAL_INTEREST_AMOUNT_DR),0)
             INTO V_EIT_BOOK_NRML, V_EIT_BOOK_PNL
             from tbaadm.EIT 
             where eit.entity_id = GamGac_rec.acid
             and Bank_id = GamGac_rec.bank_id;
        EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          v_remarks := v_remarks||'NO EIT';
                   END;    
    
    
-- For inserting data into custom table        

        --Dbms_Output.Put_Line(GamGac_rec.foracid||GamGac_rec.Sol_id||GamGac_rec.acct_opn_date||GamGac_rec.acct_cls_flg||GamGac_rec.clr_bal_amt||GamGac_rec.acct_crncy_code||GamGac_rec.schm_code||GamGac_rec.pd_flg||GamGac_rec.chrge_off_flg||GamGac_rec.pd_xfer_date||GamGac_rec.PD_RE_XFER_DATE);
        --Dbms_Output.Put_Line(V_INT_SUSPENSE_AMT||V_PENAL_INT_SUSPENSE_AMT||V_PENDING_INTEREST||V_Susp_acid||V_SUSP_foracid||V_SUSP_bacid||V_DR_SUSP||V_CR_SUSP||V_TOT_INT_SUSP||V_EIT_BOOK_NRML||V_EIT_BOOK_PNL||V_LDT_OUTST);    
        --Dbms_Output.Put_Line(v_remarks);
                
        insert into CUSTOM.SUSP_DET_TBL_FINAL_ALL_FC values(GamGac_rec.acid,GamGac_rec.foracid,GamGac_rec.Sol_id,GamGac_rec.acct_opn_date,GamGac_rec.acct_cls_flg,
        GamGac_rec.clr_bal_amt,GamGac_rec.acct_crncy_code,GamGac_rec.schm_code,GamGac_rec.pd_flg,GamGac_rec.chrge_off_flg,GamGac_rec.pd_xfer_date,
        GamGac_rec.PD_RE_XFER_DATE,V_INT_SUSPENSE_AMT,V_PENAL_INT_SUSPENSE_AMT,V_PENDING_INTEREST,V_Susp_acid,V_SUSP_foracid,V_SUSP_bacid,V_PAL_acid,V_PAL_foracid,
        V_PAL_bacid,V_DR_SUSP,V_CR_SUSP,V_TOT_INT_SUSP,V_EIT_BOOK_NRML,V_EIT_BOOK_PNL,V_INT_DMD_OS, V_LDT_OUTST_NRML, V_LDT_OUTST_PNL,GamGac_rec.bank_id,
    v_remarks,NULL,'N');
        
         v_remarks:= NULL;
        V_INT_SUSPENSE_AMT              := 0;
        V_PENAL_INT_SUSPENSE_AMT   := 0;
        V_PENDING_INTEREST               := 0;
        V_DR_SUSP                              := 0;
        V_CR_SUSP                              := 0;
        V_TOT_INT_SUSP                     := 0;
        V_EIT_BOOK_NRML                   := 0;
        V_EIT_BOOK_PNL                      := 0;
        V_INT_DMD_OS                        := 0;
         V_LDT_OUTST_NRML                := 0;
         V_LDT_OUTST_PNL                  := 0;
        
        
         v_commit_counter := v_commit_counter + 1;
                
         IF v_commit_counter = 500 THEN
            COMMIT;
            v_commit_counter := 0;
        END IF;      

                     
    --COMMIT;
      
    EXCEPTION
        WHEN OTHERS THEN
            COMMIT;   
    v_remarks := ' Record, Ora Number - '||SQLCODE||' Error Msg - '||substr(SQLERRM, 1, 200);
        DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED AT '||v_remarks);
        
        commit;
            END;
         END LOOP;
   END;
   /

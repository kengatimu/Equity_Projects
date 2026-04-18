/* Formatted on 2013/02/15 15:10 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PACKAGE CUSTOM.c_eit_tran_fetch_pack
AS
   PROCEDURE c_eit_appl_tran_fetch_proc (
      lv_appltrandt                IN OUT   DATE,
      lv_appltranid                IN OUT   VARCHAR2,
      lv_bkdtranid                  IN       VARCHAR2,
      lv_acid                      IN       VARCHAR2,
      lv_foracid                   IN       VARCHAR2,
      lv_solid                     IN       VARCHAR2,
      lv_schm_type                 IN       VARCHAR2,
      lv_schm_code                 IN       VARCHAR2,
      lv_eodbal                    IN       NUMBER,
      lv_unclrbalamt               IN       NUMBER,
      lv_futbalamt                 IN       NUMBER,
      lv_lienamt                   IN       NUMBER,
      lv_glsub                     IN       VARCHAR2,
      lv_intcollflg                IN       CHAR,
      lv_intpdflg                  IN       CHAR,
      lv_crdrflg                   IN       CHAR,
      lv_intrate                   IN       NUMBER,
      lv_bkdappl_flg               IN       CHAR,
      lv_accruptodt                IN       DATE,
      lv_accr_upto_amt_cr          IN OUT   NUMBER,
      lv_accr_upto_amt_dr          IN OUT   NUMBER,
      lv_accr_amt_today_cr         IN OUT   NUMBER,
      lv_accr_amt_today_dr         IN OUT   NUMBER,
      lv_bkduptodt                 IN       DATE,
      lv_bkd_upto_amt_cr           IN OUT   NUMBER,
      lv_bkd_upto_amt_dr           IN OUT   NUMBER,
      lv_bkd_amt_today_cr          IN OUT   NUMBER,
      lv_bkd_amt_today_dr          IN OUT   NUMBER,
      lv_appl_upto_amt_cr          IN OUT   NUMBER,
      lv_appl_upto_amt_dr          IN OUT   NUMBER,
      lv_appl_amt_today_cr         IN OUT   NUMBER,
      lv_appl_amt_today_dr         IN OUT   NUMBER,
      lv_segment                   IN       VARCHAR2,
      lv_subsegment                IN       VARCHAR2,
      lv_freecode7                 IN       VARCHAR2,
      lv_rcreuserid                IN       VARCHAR2,
      lv_rcretime                  IN       DATE,
      lv_lchguserid                IN       VARCHAR2,
      lv_lchgtime                  IN       DATE,
      lv_bankid                    IN       VARCHAR2,
      out_rec                      OUT      VARCHAR2,
      lv_accr_penal_amt_today_dr   IN OUT   NUMBER,
      lv_bkd_penal_amt_today_dr    IN OUT   NUMBER,
      lv_appl_penal_amt_today_dr   IN OUT   NUMBER,
      lv_accr_penal_upto_dr        IN       NUMBER,
      lv_bkd_penal_upto_dr         IN       NUMBER,
      lv_appl_penal_upto_dr        IN       NUMBER,
      lv_applamtdr_ovdu            IN OUT   NUMBER,
      lv_bkdamtdr_ovdu             IN OUT   NUMBER,
      lv_accramtdr_ovdu            IN OUT   NUMBER,
      lv_acctcrncy           IN         VARCHAR2,
      lv_prevdate           IN        DATE,
      lv_nrml_int_book_dr_diff1    IN       NUMBER,
      lv_penl_int_book_dr_diff1    IN       NUMBER,
      lv_ovdu_int_book_diff1       IN       NUMBER,
      lv_nrml_int_book_cr_diff1    IN       NUMBER,
      lv_unique_id           IN        VARCHAR2
   );

PROCEDURE c_eit_appl_tran_fetch_proc_oda (
    lv_appltrandt                IN OUT   DATE,
    lv_appltranid                IN OUT   VARCHAR2,
    lv_bkdtranid                 IN       VARCHAR2,
    lv_acid                      IN       VARCHAR2,
    lv_foracid                   IN       VARCHAR2,
    lv_solid                     IN       VARCHAR2,
    lv_schm_type                 IN       VARCHAR2,
    lv_schm_code                 IN       VARCHAR2,
    lv_eodbal                    IN       NUMBER,
    lv_unclrbalamt               IN       NUMBER,
    lv_futbalamt                 IN       NUMBER,
    lv_lienamt                   IN       NUMBER,
    lv_glsub                     IN       VARCHAR2,
    lv_intcollflg                IN       CHAR,
    lv_intpdflg                  IN       CHAR,
    lv_crdrflg                   IN       CHAR,
    lv_intrate                   IN       NUMBER,
    lv_bkdappl_flg               IN       CHAR,
    lv_accruptodt                IN       DATE,
    lv_accr_upto_amt_cr          IN OUT   NUMBER,
    lv_accr_upto_amt_dr          IN OUT   NUMBER,
    lv_accr_amt_today_cr         IN OUT   NUMBER,
    lv_accr_amt_today_dr         IN OUT   NUMBER,
    lv_bkduptodt                 IN       DATE,
    lv_bkd_upto_amt_cr           IN OUT   NUMBER,
    lv_bkd_upto_amt_dr           IN OUT   NUMBER,
    lv_bkd_amt_today_cr          IN OUT   NUMBER,
    lv_bkd_amt_today_dr          IN OUT   NUMBER,
    lv_appl_upto_amt_cr          IN OUT   NUMBER,
    lv_appl_upto_amt_dr          IN OUT   NUMBER,
    lv_appl_amt_today_cr         IN OUT   NUMBER,
    lv_appl_amt_today_dr         IN OUT   NUMBER,
    lv_segment                   IN       VARCHAR2,
    lv_subsegment                IN       VARCHAR2,
    lv_freecode7                 IN       VARCHAR2,
    lv_rcreuserid                IN       VARCHAR2,
    lv_rcretime                  IN       DATE,
    lv_lchguserid                IN       VARCHAR2,
    lv_lchgtime                  IN       DATE,
    lv_bankid                    IN       VARCHAR2,
    out_rec                      OUT      VARCHAR2,
    lv_accr_penal_amt_today_dr   IN OUT   NUMBER,
    lv_bkd_penal_amt_today_dr    IN OUT   NUMBER,
    lv_appl_penal_amt_today_dr   IN OUT   NUMBER,
    lv_accr_penal_upto_dr        IN OUT   NUMBER,
    lv_bkd_penal_upto_dr         IN OUT   NUMBER,
    lv_appl_penal_upto_dr        IN OUT   NUMBER,
    lv_applamtdr_ovdu            IN OUT   NUMBER,
    lv_bkdamtdr_ovdu             IN       NUMBER,
    lv_accramtdr_ovdu            IN       NUMBER,
    lv_accruptodtcr              IN       DATE,
    lv_accruptodtdr              IN       DATE,
    lv_bkduptodtcr               IN       DATE,
    lv_bkduptodtdr               IN       DATE,
    lv_appltrandtcr              IN OUT   DATE,
    lv_appltrandtdr              IN OUT   DATE,
    lv_bkdtranidcr               IN OUT   VARCHAR2,
    lv_bkdtraniddr               IN OUT   VARCHAR2,
    lv_appltranidcr              IN OUT   VARCHAR2,
    lv_appltraniddr              IN OUT   VARCHAR2,
    lv_acctcrncy         IN       VARCHAR2,
    lv_prevdate                 IN       DATE,
    lv_unique_id         IN      VARCHAR2
   );


   PROCEDURE c_eit_book_tran_fetch_proc (
      lv_bkduptodt                IN       DATE,
      lv_bkdtranid                IN       VARCHAR2,
      lv_acctcrncy                IN       VARCHAR2,
      lv_foracid                  IN       VARCHAR2,
      lv_solid                    IN       VARCHAR2,
      lv_schm_type                IN       VARCHAR2,
      lv_schm_code                IN       VARCHAR2,
      lv_eodbal                   IN       NUMBER,
      lv_unclrbalamt              IN       NUMBER,
      lv_futbalamt                IN       NUMBER,
      lv_lienamt                  IN       NUMBER,
      lv_glsub                    IN       VARCHAR2,
      lv_intcollflg               IN       CHAR,
      lv_intpdflg                 IN       CHAR,
      lv_crdrflg                  IN       CHAR,
      lv_intrate                  IN       NUMBER,
      lv_bkdappl_flg              IN       CHAR,
      lv_accruptodt               IN       DATE,
      lv_accr_upto_amt_cr         IN OUT   NUMBER,
      lv_accr_upto_amt_dr         IN OUT   NUMBER,
      lv_accr_amt_today_cr        IN OUT   NUMBER,
      lv_accr_amt_today_dr        IN OUT   NUMBER,
      lv_bkd_upto_amt_cr          IN OUT   NUMBER,
      lv_bkd_upto_amt_dr          IN OUT   NUMBER,
      lv_bkd_amt_today_cr         IN OUT   NUMBER,
      lv_bkd_amt_today_dr         IN OUT   NUMBER,
      lv_appltrandt               IN       DATE,
      lv_appl_upto_amt_cr         IN OUT   NUMBER,
      lv_appl_upto_amt_dr         IN OUT   NUMBER,
      lv_appl_amt_today_cr        IN OUT   NUMBER,
      lv_appl_amt_today_dr        IN OUT   NUMBER,
      lv_segment                  IN       VARCHAR2,
      lv_subsegment               IN       VARCHAR2,
      lv_freecode7                IN       VARCHAR2,
      lv_rcreuserid               IN       VARCHAR2,
      lv_rcretime                 IN       DATE,
      lv_lchguserid               IN       VARCHAR2,
      lv_lchgtime                 IN       DATE,
      lv_bankid                   IN       VARCHAR2,
      out_rec                     OUT      VARCHAR2,
      lv_bkdamtdr_ovdu           IN       NUMBER,
      lv_applamtdr_ovdu          IN       NUMBER,
      lv_accramtdr_ovdu          IN       NUMBER,
      lv_bkd_penal_amt_today_dr  IN       NUMBER,
      lv_accr_penal_amt_today_dr IN       NUMBER,
      lv_appl_penal_amt_today_dr IN       NUMBER,
      lv_accr_penal_upto_dr      IN       NUMBER,
      lv_bkd_penal_upto_dr       IN       NUMBER,
      lv_appl_penal_upto_dr      IN       NUMBER,
      lv_acid                    IN       VARCHAR2,
      lv_unique_id         IN      VARCHAR2
   );

   PROCEDURE c_eit_book_tran_fetch_proc_oda (
         lv_bkduptodt               IN       DATE,
         lv_bkdtranid               IN       VARCHAR2,
         lv_acctcrncy               IN       VARCHAR2,
         lv_foracid                 IN       VARCHAR2,
         lv_solid                   IN       VARCHAR2,
         lv_schm_type               IN       VARCHAR2,
         lv_schm_code               IN       VARCHAR2,
         lv_eodbal                  IN       NUMBER,
         lv_unclrbalamt             IN       NUMBER,
         lv_futbalamt               IN       NUMBER,
         lv_lienamt                 IN       NUMBER,
         lv_glsub                   IN       VARCHAR2,
         lv_intcollflg              IN       CHAR,
         lv_intpdflg                IN       CHAR,
         lv_crdrflg                 IN       CHAR,
         lv_intrate                 IN       NUMBER,
         lv_bkdappl_flg             IN       CHAR,
         lv_accruptodt              IN       DATE,
         lv_accr_upto_amt_cr        IN OUT   NUMBER,
         lv_accr_upto_amt_dr        IN OUT   NUMBER,
         lv_accr_amt_today_cr       IN OUT   NUMBER,
         lv_accr_amt_today_dr       IN OUT   NUMBER,
         lv_bkd_upto_amt_cr         IN OUT   NUMBER,
         lv_bkd_upto_amt_dr         IN OUT   NUMBER,
         lv_bkd_amt_today_cr        IN OUT   NUMBER,
         lv_bkd_amt_today_dr        IN OUT   NUMBER,
         lv_appltrandt              IN       DATE,
         lv_appl_upto_amt_cr        IN OUT   NUMBER,
         lv_appl_upto_amt_dr        IN OUT   NUMBER,
         lv_appl_amt_today_cr       IN OUT   NUMBER,
         lv_appl_amt_today_dr       IN OUT   NUMBER,
         lv_segment                 IN       VARCHAR2,
         lv_subsegment              IN       VARCHAR2,
         lv_freecode7               IN       VARCHAR2,
         lv_rcreuserid              IN       VARCHAR2,
         lv_rcretime                IN       DATE,
         lv_lchguserid              IN       VARCHAR2,
         lv_lchgtime                IN       DATE,
         lv_bankid                  IN       VARCHAR2,
         out_rec                    OUT      VARCHAR2,
         lv_bkdamtdr_ovdu           IN       NUMBER,
         lv_applamtdr_ovdu          IN       NUMBER,
         lv_accramtdr_ovdu          IN       NUMBER,
         lv_bkd_penal_amt_today_dr     IN       NUMBER,
         lv_accr_penal_amt_today_dr     IN       NUMBER,
         lv_appl_penal_amt_today_dr     IN       NUMBER,
         lv_accr_penal_upto_dr          IN       NUMBER,
         lv_bkd_penal_upto_dr           IN       NUMBER,
         lv_appl_penal_upto_dr          IN       NUMBER,
         lv_accruptodtcr            IN       DATE,
         lv_accruptodtdr            IN       DATE,
         lv_bkduptodtcr             IN       DATE,
         lv_bkduptodtdr             IN       DATE,
         lv_appltrandtcr            IN       DATE,
         lv_appltrandtdr            IN       DATE,
         lv_bkdtranidcr             IN       VARCHAR2,
         lv_bkdtraniddr             IN       VARCHAR2,
         lv_appltranidcr            IN       VARCHAR2,
         lv_appltraniddr            IN       VARCHAR2,
         lv_acid                    IN       VARCHAR2,
         lv_unique_id                IN     VARCHAR2
   );

    PROCEDURE c_eit_tran_fetch_proc_bonus (
         lv_bkduptodt               IN       DATE,
         lv_bkdtranid               IN       VARCHAR2,
         lv_acctcrncy               IN       VARCHAR2,
         lv_foracid                 IN       VARCHAR2,
         lv_solid                   IN       VARCHAR2,
         lv_schm_type               IN       VARCHAR2,
         lv_schm_code               IN       VARCHAR2,
         lv_eodbal                  IN       NUMBER,
         lv_unclrbalamt             IN       NUMBER,
         lv_futbalamt               IN       NUMBER,
         lv_lienamt                 IN       NUMBER,
         lv_glsub                   IN       VARCHAR2,
         lv_intcollflg              IN       CHAR,
         lv_intpdflg                IN       CHAR,
         lv_crdrflg                 IN       CHAR,
         lv_intrate                 IN       NUMBER,
         lv_bkdappl_flg             IN       CHAR,
         lv_accruptodt              IN       DATE,
         lv_accr_upto_amt_cr        IN       NUMBER,
         lv_accr_upto_amt_dr        IN       NUMBER,
         lv_accr_amt_today_cr       IN OUT   NUMBER,
         lv_accr_amt_today_dr       IN OUT   NUMBER,
         lv_bkd_upto_amt_cr         IN       NUMBER,
         lv_bkd_upto_amt_dr         IN       NUMBER,
         lv_bkd_amt_today_cr        IN OUT   NUMBER,
         lv_bkd_amt_today_dr        IN OUT   NUMBER,
         lv_appltrandt              IN       DATE,
         lv_appl_upto_amt_cr        IN       NUMBER,
         lv_appl_upto_amt_dr        IN       NUMBER,
         lv_appl_amt_today_cr       IN OUT   NUMBER,
         lv_appl_amt_today_dr       IN OUT   NUMBER,
         lv_segment                 IN       VARCHAR2,
         lv_subsegment              IN       VARCHAR2,
         lv_freecode7               IN       VARCHAR2,
         lv_rcreuserid              IN       VARCHAR2,
         lv_rcretime                IN       DATE,
         lv_lchguserid              IN       VARCHAR2,
         lv_lchgtime                IN       DATE,
         lv_bankid                  IN       VARCHAR2,
         out_rec                    OUT      VARCHAR2,
         lv_bkdamtdr_ovdu           IN       NUMBER,
         lv_applamtdr_ovdu          IN       NUMBER,
         lv_accramtdr_ovdu          IN       NUMBER,
         lv_bkd_penal_amt_today_dr     IN       NUMBER,
         lv_acid                    IN       VARCHAR2,
         lv_bonusBooking            IN       CHAR,
         lv_bonusApp                IN       CHAR,
         lv_eitdate            IN       DATE,
         lv_unique_id                IN     VARCHAR2
   );
   --------------------------------------------
   --Defining cursor for C_BIA and C_BIB tables
   ---------------------------------------------
   CURSOR bibtranfetch_cur (
         cin_acid         tbaadm.gam.acid%TYPE,
         cin_tran_dt      DATE,
         cin_bank_id      tbaadm.gam.bank_id%TYPE
      )
      IS
         (SELECT tran_id,rev_tran_id,bonus_bkd_amt,status_flg
            FROM c_bib
           WHERE acid=cin_acid
             AND ((tran_date = cin_tran_dt) OR (rev_tran_date=cin_tran_dt))
             AND bank_id = cin_bank_id);

    CURSOR biatranfetch_cur (
            cin_acid         tbaadm.gam.acid%TYPE,
            cin_tran_dt      DATE,
            cin_bank_id      tbaadm.gam.bank_id%TYPE
         )
         IS
            (SELECT tran_id,bonus_amt
               FROM c_bia
              WHERE acid=cin_acid
                AND tran_date = cin_tran_dt
             AND bank_id = cin_bank_id);
END c_eit_tran_fetch_pack;
/

CREATE OR REPLACE PACKAGE BODY CUSTOM.c_eit_tran_fetch_pack
AS
   PROCEDURE c_eit_appl_tran_fetch_proc (
     lv_appltrandt                IN OUT   DATE,
           lv_appltranid                IN OUT   VARCHAR2,
           lv_bkdtranid               IN       VARCHAR2,
           lv_acid                      IN       VARCHAR2,
           lv_foracid                   IN       VARCHAR2,
           lv_solid                     IN       VARCHAR2,
           lv_schm_type                 IN       VARCHAR2,
           lv_schm_code                 IN       VARCHAR2,
           lv_eodbal                    IN       NUMBER,
           lv_unclrbalamt               IN       NUMBER,
           lv_futbalamt                 IN       NUMBER,
           lv_lienamt                   IN       NUMBER,
           lv_glsub                     IN       VARCHAR2,
           lv_intcollflg                IN       CHAR,
           lv_intpdflg                  IN       CHAR,
           lv_crdrflg                   IN       CHAR,
           lv_intrate                   IN       NUMBER,
           lv_bkdappl_flg               IN       CHAR,
           lv_accruptodt                IN       DATE,
           lv_accr_upto_amt_cr          IN OUT   NUMBER,
           lv_accr_upto_amt_dr          IN OUT   NUMBER,
           lv_accr_amt_today_cr         IN OUT   NUMBER,
           lv_accr_amt_today_dr         IN OUT   NUMBER,
           lv_bkduptodt                 IN       DATE,
           lv_bkd_upto_amt_cr           IN OUT   NUMBER,
           lv_bkd_upto_amt_dr           IN OUT   NUMBER,
           lv_bkd_amt_today_cr          IN OUT   NUMBER,
           lv_bkd_amt_today_dr          IN OUT   NUMBER,
           lv_appl_upto_amt_cr          IN OUT   NUMBER,
           lv_appl_upto_amt_dr          IN OUT   NUMBER,
           lv_appl_amt_today_cr         IN OUT   NUMBER,
           lv_appl_amt_today_dr         IN OUT   NUMBER,
           lv_segment                   IN       VARCHAR2,
           lv_subsegment                IN       VARCHAR2,
           lv_freecode7                 IN       VARCHAR2,
           lv_rcreuserid                IN       VARCHAR2,
           lv_rcretime                  IN       DATE,
           lv_lchguserid                IN       VARCHAR2,
           lv_lchgtime                  IN       DATE,
           lv_bankid                    IN       VARCHAR2,
           out_rec                      OUT      VARCHAR2,
           lv_accr_penal_amt_today_dr   IN OUT   NUMBER,
           lv_bkd_penal_amt_today_dr    IN OUT   NUMBER,
           lv_appl_penal_amt_today_dr   IN OUT   NUMBER,
           lv_accr_penal_upto_dr        IN       NUMBER,
           lv_bkd_penal_upto_dr         IN       NUMBER,
           lv_appl_penal_upto_dr        IN       NUMBER,
           lv_applamtdr_ovdu            IN OUT   NUMBER,
           lv_bkdamtdr_ovdu             IN OUT   NUMBER,
           lv_accramtdr_ovdu            IN OUT   NUMBER,
           lv_acctcrncy                IN      VARCHAR2,
           lv_prevdate                IN     DATE,
           lv_nrml_int_book_dr_diff1    IN       NUMBER,
           lv_penl_int_book_dr_diff1    IN       NUMBER,
           lv_ovdu_int_book_diff1       IN       NUMBER,
           lv_nrml_int_book_cr_diff1    IN       NUMBER,
           lv_unique_id                IN     VARCHAR2
   )
   AS
      lv_penbacid                  tbaadm.gam.bacid%TYPE;
      lv_penforacid                tbaadm.gam.foracid%TYPE;
      lv_bacid                     tbaadm.gam.bacid%TYPE;
      lv_glacc                     tbaadm.gam.foracid%TYPE;
      lv_trancount                 NUMBER;
      lv_errmsg                    VARCHAR2 (100);
      lv_pdflg                     tbaadm.AIP.PAST_DUE_FLG%TYPE;
      lv_ptransrlnum               tbaadm.dtd.part_tran_srl_num%TYPE;
      lv_tranpart                  tbaadm.dtd.tran_particular%TYPE;
      lv_tranamt                   tbaadm.dtd.tran_amt%TYPE;
      lv_tranpart2                 tbaadm.dtd.tran_particular_2%TYPE;
      lv_tranrmks                  tbaadm.dtd.tran_rmks%TYPE;
      lv_ptrantype                 tbaadm.dtd.part_tran_type%TYPE;
      lv_trancrncy                 tbaadm.dtd.tran_crncy_code%TYPE;
      lv_credit_debit_ind         CHAR(1)        :='N';
      lv_glacid                tbaadm.gam.acid%TYPE;
      lv_pd_xfer_date            DATE;
      lv_pd_re_xfer_date        DATE;
      lv_susp_bacid                tbaadm.AIP.int_susp_bacid%type;
      lv_pen_susp_bacid            tbaadm.AIP.penal_int_susp_bacid%type;
      lv_nrml_amt_inserted_cr             NUMBER(22,6);
      lv_nrml_amt_inserted_dr             NUMBER(22,6);
      lv_penl_amt_inserted_dr             NUMBER(22,6);
      lv_ovdu_amt_inserted_dr             NUMBER(22,6);
      lv_pandl_bacid                tbaadm.gam.bacid%TYPE;
      lv_pandl_glacid                tbaadm.gam.acid%TYPE;
      lv_pandl_glacc                 tbaadm.gam.foracid%TYPE;
      lv_nrml_amt_inserted        NUMBER(22,6);

   BEGIN
      --{
      IF (lv_crdrflg != 'N')
      THEN
         --{

         -------------------------------------------
         --Fetching pd transfer date from GAC table
         ------------------------------------------
         BEGIN
         --{

         select pd_xfer_date,pd_re_xfer_date
         into lv_pd_xfer_date,lv_pd_re_xfer_date
         from tbaadm.gac
         where acid=lv_acid
         and bank_id=lv_bankid;


         EXCEPTION
             WHEN NO_DATA_FOUND
             THEN
             lv_pd_xfer_date:=null;
             lv_pd_re_xfer_date:=null;
         --out_rec :=out_rec|| ' PD Transfer date not fetched'|| lv_acid;

       --}
         END;

         BEGIN
         --{
             select PAST_DUE_FLG,int_susp_bacid,penal_int_susp_bacid
         into lv_pdflg,lv_susp_bacid,lv_pen_susp_bacid
         from tbaadm.AIP, tbaadm.acd , tbaadm.gam
         where acd.b2k_id = tbaadm.gam.acid
         and tbaadm.gam.schm_code = tbaadm.AIP.schm_code
         and tbaadm.AIP.MAIN_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.MAIN_CLASSIFICATION_SYSTEM,acd.MAIN_CLASSIFICATION_USER)
         and tbaadm.AIP.SUB_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.SUB_CLASSIFICATION_SYSTEM,acd.SUB_CLASSIFICATION_USER)
         and tbaadm.AIP.B2K_TYPE = 'ACCNT'
         and acd.B2K_TYPE = 'ACCNT'
         and tbaadm.AIP.del_flg !='Y'
         and foracid = lv_foracid
         and tbaadm.gam.bank_id = lv_bankid
         and acd.bank_id = tbaadm.gam.bank_id
         and tbaadm.AIP.bank_id = tbaadm.gam.bank_id;

         EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
         lv_pdflg:='';
         --out_rec :=out_rec|| ' PD flg not fetched'|| lv_acid;

         --}
         END;



    IF((lv_appltrandt is NULL) OR (lv_appltrandt < lv_prevdate))
    THEN
    --{
        lv_appltrandt:=lv_prevdate;

        BEGIN
        --{

            select tran_id
            into lv_appltranid
            from tbaadm.int_adm
            where tran_date=lv_prevdate
            and acid=lv_acid
            and bank_id=lv_bankid
            and rownum<2;
            EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            NULL;
            --out_rec :=out_rec|| ' INT_ADM query failed'|| lv_acid;

        --}
        END;
    --}
    END IF;

           ----------------------------------------------------------------------------
           --Subtracting the amount for which booking is not yet done since this amount
           --will be debited/credited to P/L account directly
           ----------------------------------------------------------------------------

           IF(lv_schm_type!='SBA')
           THEN
           --{
            IF(lv_nrml_int_book_cr_diff1>0)
            THEN
            --{
                IF(lv_appl_amt_today_cr>0)
                THEN
                --{
                    lv_appl_amt_today_cr:=(lv_appl_amt_today_cr) - lv_nrml_int_book_cr_diff1;
                --}
                END IF;

                IF(lv_bkd_amt_today_cr>0)
                THEN
                --{
                    lv_bkd_amt_today_cr:=lv_bkd_amt_today_cr - lv_nrml_int_book_cr_diff1;
                --}
                END IF;

            --}
            END IF;

            IF(lv_nrml_int_book_dr_diff1>0)
            THEN
            --{
                IF(lv_appl_amt_today_dr>0)
                THEN
                --{
                    lv_appl_amt_today_dr:=(lv_appl_amt_today_dr) - lv_nrml_int_book_dr_diff1;
                --}
                END IF;

                IF(lv_bkd_amt_today_dr>0)
                THEN
                --{
                    lv_bkd_amt_today_dr:=lv_bkd_amt_today_dr - lv_nrml_int_book_dr_diff1;
                --}
                END IF;

            --}
            END IF;

            IF(lv_penl_int_book_dr_diff1>0)
            THEN
            --{
                IF(lv_appl_penal_amt_today_dr>0)
                THEN
                --{
                    lv_appl_penal_amt_today_dr:=lv_appl_penal_amt_today_dr - lv_penl_int_book_dr_diff1;
                --}
                END IF;

                IF(lv_bkd_penal_amt_today_dr>0)
                THEN
                --{
                    lv_bkd_penal_amt_today_dr:=lv_bkd_penal_amt_today_dr - lv_penl_int_book_dr_diff1;
                --}
                END IF;

            --}
                   END IF;

                   IF(lv_ovdu_int_book_diff1>0)
            THEN
            --{
                IF(lv_applamtdr_ovdu>0)
                THEN
                --{
                    lv_applamtdr_ovdu:=lv_applamtdr_ovdu - lv_ovdu_int_book_diff1;
                --}
                END IF;

                IF(lv_bkdamtdr_ovdu>0)
                THEN
                --{
                    lv_bkdamtdr_ovdu:=lv_bkdamtdr_ovdu - lv_ovdu_int_book_diff1;
                --}
                END IF;

            --}
                 END IF;
           --}
           END IF;


            IF((lv_appl_amt_today_cr!=0) OR (lv_appl_amt_today_dr!=0))
            THEN
            --{

                    BEGIN
                  --{
                  ----------------------------------------------------------------

                  -- Fetching int coll bacid or int paid bacid based on cr/dr ind.

                  ----------------------------------------------------------------

                     SELECT DECODE (lv_crdrflg,
                            'D', int_coll_bacid,
                            int_paid_bacid
                           )
                       INTO lv_bacid
                       FROM tbaadm.gsp p
                       WHERE p.schm_code = lv_schm_code
                       AND p.bank_id = lv_bankid
                       AND p.schm_type = lv_schm_type;


                 BEGIN
                 --{
                      -----------------------------------------------
                      --Checking the past due flag  and
                      --deriving PAST_DUE_INT_COLL_BACID
                      -----------------------------------------------

                      IF(lv_appl_amt_today_dr !=0 )

                      THEN
                     --{
                        IF(lv_pdflg='Y') THEN
                          --{
                              IF((lv_schm_type!='LAA') AND (lv_schm_type!='CLA'))
                             THEN
                             --{
                                SELECT PAST_DUE_INT_COLL_BACID
                                INTO lv_bacid
                                FROM tbaadm.gsp p
                                WHERE p.schm_code = lv_schm_code
                                AND p.bank_id = lv_bankid
                                AND p.schm_type = lv_schm_type;
                             --}
                             ELSE
                             --{
                                 ----------------------------------------------------------------
                                --If pd flg is Y and pd_xfer_date is equal to appltrandt
                                --then the account is transferring as non performing today only.
                                --But LAGEN would have generated the demand in interest receivable
                                --as it runs before ACLLA(Asset Classfication)
                                ----------------------------------------------------------------
                                 IF((lv_pd_xfer_date!=lv_appltrandt) OR (lv_pd_xfer_date is null))
                                 THEN
                                 --{
                                     SELECT PAST_DUE_INT_COLL_BACID
                                    INTO lv_bacid
                                    FROM tbaadm.gsp p
                                    WHERE p.schm_code = lv_schm_code
                                    AND p.bank_id = lv_bankid
                                    AND p.schm_type = lv_schm_type;
                                 --}
                                 END IF;

                             --}
                             END IF;


                          --}
                          ELSE
                          --{
                              ----------------------------------------------------------------
                            --If pd flg is N and pd_re_xfer_date is equal to appltrandt
                            --then the account is transferring as performing today only.
                            --But LAGEN would have generated the demand in past due account
                            --as it runs before ACLLA(Asset Classfication)
                            ----------------------------------------------------------------
                            IF((lv_schm_type='LAA') OR (lv_schm_type='CLA'))
                            THEN
                            --{
                                IF(lv_pd_re_xfer_date=lv_appltrandt)
                                THEN
                                --{
                                    SELECT PAST_DUE_INT_COLL_BACID
                                    INTO lv_bacid
                                    FROM tbaadm.gsp p
                                    WHERE p.schm_code = lv_schm_code
                                    AND p.bank_id = lv_bankid
                                    AND p.schm_type = lv_schm_type;
                                --}
                                END IF;
                            --}
                            END IF;
                          --}
                        END IF;


                     --}
                     END IF;




                     --}
                 END;
                           -------------------------------------------------------------

                          -- Fetching account id for bacid.

                          -------------------------------------------------------------
                          SELECT foracid,acid
                          INTO lv_glacc,lv_glacid
                          FROM tbaadm.gam
                          WHERE bacid = lv_bacid
                          AND sol_id = lv_solid
                          AND acct_crncy_code = lv_acctcrncy
                          AND bank_id = lv_bankid;

                          EXCEPTION
                          WHEN NO_DATA_FOUND
                          THEN
                            -- out_rec :=out_rec|| ' tbaadm.gam  query didnt fetch any Record '|| lv_acid;
                             GOTO applnextrec;

                    --}
                    END;

                       BEGIN
                   --{

                    IF(lv_crdrflg='C')
                    THEN
                    --{
                        IF(lv_appl_amt_today_cr>0)
                        THEN
                        --{
                            lv_credit_debit_ind:='C';
                        --}
                        ELSE
                        --{

                            lv_credit_debit_ind:='D';
                        --}
                        END IF;
                    --}
                    ELSE
                    --{
                        IF((lv_appl_amt_today_dr>0))
                        THEN
                        --{
                            lv_credit_debit_ind:='D';
                        --}
                        ELSE
                        --{

                            lv_credit_debit_ind:='C';
                        --}
                        END IF;
                    --}
                    END IF;
                    ----------------------------------------

                    -- fetching tran details from tbaadm.dctd_acli

                    ----------------------------------------

                       SELECT part_tran_srl_num, tran_particular, tran_amt,
                          tran_particular_2, tran_rmks, part_tran_type,
                          tran_crncy_code
                     INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                          lv_tranpart2, lv_tranrmks, lv_ptrantype,
                          lv_trancrncy
                     FROM tbaadm.dctd_acli
                     WHERE tran_id = LPAD (lv_appltranid, 9)
                     AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                     AND tran_date = lv_appltrandt
                     AND pstd_flg = 'Y'
                     AND del_flg != 'Y'
                     AND bank_id = lv_bankid
                     AND ROWNUM < 2;


                    out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                       lv_ptransrlnum:='';
                       lv_tranpart:='';
                       lv_tranamt:='';
                       lv_tranpart2:='';
                       lv_tranrmks:='';
                       lv_ptrantype:='';
                       lv_trancrncy:='';



                --}
                    END;


                -------------------------------------------------------------

                   -- C_EIT insert

                   -------------------------------------------------------------
                   BEGIN
                  --{
                  INSERT INTO c_eit
                          (tran_date, bacid, gl_acct_no,
                           tran_id, part_tran_srl_num,
                           tran_amt,
                           tran_crncy,
                           part_tran_type,
                           tran_particular,
                           tran_particular_2,
                           tran_remarks, customer_account_no, sol_id,
                           schm_type, schm_code, eod_closing_balance,
                           eod_un_clr_bal_amt, eod_future_bal_amt,
                           eod_lien_amt, gl_sub_head_code,
                           int_coll_flag, int_paid_flag,
                           debit_credit_ind, interest_rate,
                           int_appl_flg, accrued_upto_date,
                           accrued_upto_amount,
                           accrued_amount_today,
                           booked_upto_date,
                           booked_upto_amount,
                           booked_amount_today,
                           applied_upto_date,
                           applied_upto_amount,
                           applied_amount_today,
                           SEGMENT, sub_segment, free_code_7,
                           rcre_user_id, rcre_time, lchg_user_id,
                           lchg_time, bank_id,unq_identifier
                          )
                       VALUES (lv_appltrandt, lv_bacid, lv_glacc,
                           lv_appltranid, lv_ptransrlnum,
                           lv_tranamt,
                           lv_trancrncy,
                           lv_ptrantype,
                           lv_tranpart,
                           lv_tranpart2,
                           lv_tranrmks, lv_foracid, lv_solid,
                           lv_schm_type, lv_schm_code, lv_eodbal,
                           lv_unclrbalamt, lv_futbalamt,
                           lv_lienamt, lv_glsub,
                           lv_intcollflg, lv_intpdflg,
                           DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                           lv_bkdappl_flg, lv_accruptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_accr_upto_amt_cr,
                               lv_accr_upto_amt_dr
                              ),
                           DECODE (lv_crdrflg,
                               'C', lv_accr_amt_today_cr,
                               lv_accr_amt_today_dr
                              ),
                           lv_bkduptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_bkd_upto_amt_cr,
                               lv_bkd_upto_amt_dr
                              ),
                           0,
                           lv_appltrandt,
                           DECODE (lv_crdrflg,
                               'C', lv_appl_upto_amt_cr,
                               lv_appl_upto_amt_dr
                              ),
                           abs(DECODE (lv_crdrflg,
                               'C', lv_appl_amt_today_cr,
                               lv_appl_amt_today_dr
                              )),
                           lv_segment, lv_subsegment, lv_freecode7,
                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                           lv_lchgtime, lv_bankid,lv_unique_id
                          );

                  COMMIT;


                   EXCEPTION
                  WHEN OTHERS
                  THEN
                  --DBMS_OUTPUT.put_line (SQLERRM);
                    -- lv_errmsg := SUBSTR(SQLERRM,0,100);
                     out_rec := out_rec || 'Insert uncusscessful';

                   --}
                END;


        --}
            END IF;

           ------------------------------------
           --Inserting the booked amount today
           ------------------------------------
           IF((lv_bkd_amt_today_cr!=0) OR (lv_bkd_amt_today_dr!=0))
           THEN
           --{


                IF(lv_crdrflg='C')
                THEN
                --{
                    IF(lv_bkd_amt_today_cr>0)
                    THEN
                    --{
                        lv_credit_debit_ind:='C';
                    --}
                    ELSE
                    --{

                        lv_credit_debit_ind:='D';
                    --}
                    END IF;
                --}
                ELSE
                --{
                    IF((lv_bkd_amt_today_dr>0))
                    THEN
                    --{
                        lv_credit_debit_ind:='D';
                    --}
                    ELSE
                    --{

                        lv_credit_debit_ind:='C';
                    --}
                    END IF;
                --}
                END IF;

                ------------------------------------------------------
                --Fetching the Interest Payable/Receivable,P/L account
                ------------------------------------------------------

                BEGIN
                --{
                    SELECT DECODE (lv_crdrflg,
                            'D', int_coll_bacid,
                            int_paid_bacid
                           ),DECODE (lv_crdrflg,
                            'D', int_pandl_bacid_dr,
                            int_pandl_bacid_cr
                           )
                       INTO lv_bacid,lv_pandl_bacid
                       FROM tbaadm.gsp p
                       WHERE p.schm_code = lv_schm_code
                       AND p.bank_id = lv_bankid
                       AND p.schm_type = lv_schm_type;
                 EXCEPTION
                 WHEN NO_DATA_FOUND
                 THEN
                 --out_rec :=out_rec|| ' tbaadm.gsp  query didnt fetch any Record '|| lv_schm_code;
                 GOTO applnextrec;

                 --}
                 END;


                BEGIN
                --{
                    IF(lv_bkd_amt_today_dr!=0)
                    THEN
                    --{
                        IF(lv_bkd_amt_today_dr>0)
                        THEN
                        --{
                              ---------------------------

                              -- Fetching int coll bacid
                              ---------------------------
                              IF(lv_pdflg='Y')
                              THEN
                              --{
                                SELECT past_due_int_coll_bacid
                                INTO lv_bacid
                                FROM tbaadm.gsp p
                                WHERE p.schm_code = lv_schm_code
                                AND p.bank_id = lv_bankid
                                AND p.schm_type = lv_schm_type;

                                lv_pandl_bacid:=lv_susp_bacid;
                              --}
                              ELSE
                              --{
                                SELECT int_coll_bacid,int_pandl_bacid_dr
                                INTO lv_bacid,lv_pandl_bacid
                                FROM tbaadm.gsp p
                                WHERE p.schm_code = lv_schm_code
                                AND p.bank_id = lv_bankid
                                AND p.schm_type = lv_schm_type;
                              --}
                              END IF;




                        --}
                        ELSE
                        --{
                            IF(lv_pdflg='Y') THEN
                              --{
                                IF((lv_schm_type!='LAA') AND (lv_schm_type!='CLA'))
                                 THEN
                                 --{
                                    SELECT PAST_DUE_INT_COLL_BACID
                                    INTO lv_bacid
                                    FROM tbaadm.gsp p
                                    WHERE p.schm_code = lv_schm_code
                                    AND p.bank_id = lv_bankid
                                    AND p.schm_type = lv_schm_type;
                                    lv_pandl_bacid:=lv_susp_bacid;
                                 --}
                                 ELSE
                                 --{
                                    ----------------------------------------------------------------
                                    --If pd flg is Y and pd_xfer_date is equal to appltrandt
                                    --then the account is transferring as non performing today only.
                                    --But LAGEN would have generated the demand in interest receivable
                                    --as it runs before ACLLA(Asset Classfication)
                                    ----------------------------------------------------------------
                                    IF((lv_pd_xfer_date!=lv_appltrandt) OR (lv_pd_xfer_date is null))
                                    THEN
                                    --{
                                        SELECT PAST_DUE_INT_COLL_BACID
                                        INTO lv_bacid
                                        FROM tbaadm.gsp p
                                        WHERE p.schm_code = lv_schm_code
                                        AND p.bank_id = lv_bankid
                                        AND p.schm_type = lv_schm_type;
                                        lv_pandl_bacid:=lv_susp_bacid;
                                    --}
                                    END IF;

                                 --}
                                END IF;


                              --}
                              ELSE
                              --{
                                ----------------------------------------------------------------
                                --If pd flg is N and pd_re_xfer_date is equal to appltrandt
                                --then the account is transferring as performing today only.
                                --But LAGEN would have generated the demand in past due account
                                --as it runs before ACLLA(Asset Classfication)
                                ----------------------------------------------------------------
                                IF((lv_schm_type='LAA') OR (lv_schm_type='CLA'))
                                THEN
                                --{
                                    IF(lv_pd_re_xfer_date=lv_appltrandt)
                                    THEN
                                    --{
                                        SELECT PAST_DUE_INT_COLL_BACID
                                        INTO lv_bacid
                                        FROM tbaadm.gsp p
                                        WHERE p.schm_code = lv_schm_code
                                        AND p.bank_id = lv_bankid
                                        AND p.schm_type = lv_schm_type;
                                        lv_pandl_bacid:=lv_susp_bacid;
                                    --}
                                    END IF;
                                --}
                                END IF;
                              --}
                              END IF;
                        --}
                        END IF;
                    --}
                    END IF;




                      ------------------------------------

                      -- Fetching account id for bacid.

                      ------------------------------------
                      SELECT foracid,acid
                      INTO lv_glacc,lv_glacid
                      FROM tbaadm.gam
                      WHERE bacid = lv_bacid
                      AND sol_id = lv_solid
                      AND acct_crncy_code = lv_acctcrncy
                      AND bank_id = lv_bankid;

                       SELECT foracid,acid
                      INTO lv_pandl_glacc,lv_pandl_glacid
                      FROM tbaadm.gam
                      WHERE bacid = lv_pandl_bacid
                      AND sol_id = lv_solid
                      AND acct_crncy_code = lv_acctcrncy
                          AND bank_id = lv_bankid;


                  EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     --out_rec :=out_rec|| ' tbaadm.gam  query didnt fetch any Record '|| lv_acid;



                    GOTO applnextrec;
                --}
                END;

                ----------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                ----------------------------------------
             BEGIN
             --{
                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                 FROM tbaadm.dctd_acli
                 WHERE tran_id = LPAD (lv_bkdtranid, 9)
                 AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                 AND tran_date = lv_bkduptodt
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                EXCEPTION
                WHEN NO_DATA_FOUND
                THEN

                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';

            --}
            END;

                               -------------------------------------------------------------

                   -- C_EIT insert

                   -------------------------------------------------------------
                   BEGIN
                  --{
                  INSERT INTO c_eit
                          (tran_date, bacid, gl_acct_no,
                           tran_id, part_tran_srl_num,
                           tran_amt,
                           tran_crncy,
                           part_tran_type,
                           tran_particular,
                           tran_particular_2,
                           tran_remarks, customer_account_no, sol_id,
                           schm_type, schm_code, eod_closing_balance,
                           eod_un_clr_bal_amt, eod_future_bal_amt,
                           eod_lien_amt, gl_sub_head_code,
                           int_coll_flag, int_paid_flag,
                           debit_credit_ind, interest_rate,
                           int_appl_flg, accrued_upto_date,
                           accrued_upto_amount,
                           accrued_amount_today,
                           booked_upto_date,
                           booked_upto_amount,
                           booked_amount_today,
                           applied_upto_date,
                           applied_upto_amount,
                           applied_amount_today,
                           SEGMENT, sub_segment, free_code_7,
                           rcre_user_id, rcre_time, lchg_user_id,
                           lchg_time, bank_id,unq_identifier
                          )
                       VALUES (lv_bkduptodt, lv_bacid, lv_glacc,
                           lv_bkdtranid, lv_ptransrlnum,
                           lv_tranamt,
                           lv_trancrncy,
                           lv_ptrantype,
                           lv_tranpart,
                           lv_tranpart2,
                           lv_tranrmks, lv_foracid, lv_solid,
                           lv_schm_type, lv_schm_code, lv_eodbal,
                           lv_unclrbalamt, lv_futbalamt,
                           lv_lienamt, lv_glsub,
                           lv_intcollflg, lv_intpdflg,
                           DECODE(lv_credit_debit_ind,'C','C','D'), lv_intrate,
                           lv_bkdappl_flg, lv_accruptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_accr_upto_amt_cr,
                               lv_accr_upto_amt_dr
                              ),
                           DECODE (lv_crdrflg,
                               'C', lv_accr_amt_today_cr,
                               lv_accr_amt_today_dr
                              ),
                           lv_bkduptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_bkd_upto_amt_cr,
                               lv_bkd_upto_amt_dr
                              ),
                           abs(DECODE (lv_crdrflg,
                               'C', lv_bkd_amt_today_cr,
                               lv_bkd_amt_today_dr
                              )),
                           lv_appltrandt,
                           DECODE (lv_crdrflg,
                               'C', lv_appl_upto_amt_cr,
                               lv_appl_upto_amt_dr
                              ),
                           0,
                           lv_segment, lv_subsegment, lv_freecode7,
                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                           lv_lchgtime, lv_bankid,lv_unique_id
                          );
                          COMMIT;

                        BEGIN
                          --{
                            SELECT part_tran_srl_num, tran_particular, tran_amt,
                            tran_particular_2, tran_rmks, part_tran_type,
                            tran_crncy_code
                            INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                            lv_tranpart2, lv_tranrmks, lv_ptrantype,
                            lv_trancrncy
                            FROM tbaadm.dctd_acli
                            WHERE tran_id = LPAD (lv_bkdtranid, 9)
                            AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                             OR (acid = lv_pandl_glacid))
                            AND tran_date = lv_bkduptodt
                            AND pstd_flg = 'Y'
                            AND del_flg != 'Y'
                            AND bank_id = lv_bankid
                            AND ROWNUM < 2;
                           EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                           NULL;
                          --}
                          END;

                           INSERT INTO c_eit
                          (tran_date, bacid, gl_acct_no,
                           tran_id, part_tran_srl_num,
                           tran_amt,
                           tran_crncy,
                           part_tran_type,
                           tran_particular,
                           tran_particular_2,
                           tran_remarks, customer_account_no, sol_id,
                           schm_type, schm_code, eod_closing_balance,
                           eod_un_clr_bal_amt, eod_future_bal_amt,
                           eod_lien_amt, gl_sub_head_code,
                           int_coll_flag, int_paid_flag,
                           debit_credit_ind, interest_rate,
                           int_appl_flg, accrued_upto_date,
                           accrued_upto_amount,
                           accrued_amount_today,
                           booked_upto_date,
                           booked_upto_amount,
                           booked_amount_today,
                           applied_upto_date,
                           applied_upto_amount,
                           applied_amount_today,
                           SEGMENT, sub_segment, free_code_7,
                           rcre_user_id, rcre_time, lchg_user_id,
                           lchg_time, bank_id,unq_identifier
                          )
                       VALUES (lv_bkduptodt, lv_pandl_bacid, lv_pandl_glacc,
                           lv_bkdtranid, lv_ptransrlnum,
                           lv_tranamt,
                           lv_trancrncy,
                           lv_ptrantype,
                           lv_tranpart,
                           lv_tranpart2,
                           lv_tranrmks, lv_foracid, lv_solid,
                           lv_schm_type, lv_schm_code, lv_eodbal,
                           lv_unclrbalamt, lv_futbalamt,
                           lv_lienamt, lv_glsub,
                           lv_intcollflg, lv_intpdflg,
                           DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                           lv_bkdappl_flg, lv_accruptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_accr_upto_amt_cr,
                               lv_accr_upto_amt_dr
                              ),
                           DECODE (lv_crdrflg,
                               'C', lv_accr_amt_today_cr,
                               lv_accr_amt_today_dr
                              ),
                           lv_bkduptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_bkd_upto_amt_cr,
                               lv_bkd_upto_amt_dr
                              ),
                           abs(DECODE (lv_crdrflg,
                               'C', lv_bkd_amt_today_cr,
                               lv_bkd_amt_today_dr
                              )),
                           lv_appltrandt,
                           DECODE (lv_crdrflg,
                               'C', lv_appl_upto_amt_cr,
                               lv_appl_upto_amt_dr
                              ),
                           0,
                           lv_segment, lv_subsegment, lv_freecode7,
                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                           lv_lchgtime, lv_bankid,lv_unique_id
                          );



                  COMMIT;


                   EXCEPTION
                  WHEN OTHERS
                  THEN

                     out_rec := out_rec || 'Insert uncusscessful';

                   --}
                END;


           --}
           END IF;



               --------------------------------------
               --Inserting record for penal interest
               --------------------------------------

               IF((lv_appl_penal_amt_today_dr!=0)) THEN
               --{


               BEGIN
               --{
              IF(lv_pdflg='Y') THEN
              --{
                IF((lv_schm_type!='LAA') AND (lv_schm_type!='CLA'))
                 THEN
                 --{
                    SELECT PAST_DUE_PENAL_INT_COLL_BACID
                    INTO lv_penbacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                    AND p.bank_id = lv_bankid
                    AND p.schm_type = lv_schm_type;

                 --}
                 ELSE
                 --{
                    ----------------------------------------------------------------
                    --If pd flg is Y and pd_xfer_date is equal to appltrandt
                    --then the account is transferring as non performing today only.
                    --But LAGEN would have generated the demand in interest receivable
                    --as it runs before ACLLA(Asset Classfication)
                    ----------------------------------------------------------------
                    IF((lv_pd_xfer_date!=lv_appltrandt) OR (lv_pd_xfer_date is null))
                    THEN
                    --{
                        SELECT PAST_DUE_PENAL_INT_COLL_BACID
                        INTO lv_penbacid
                        FROM tbaadm.gsp p
                        WHERE p.schm_code = lv_schm_code
                        AND p.bank_id = lv_bankid
                        AND p.schm_type = lv_schm_type;

                    --}
                    ELSE
                    --{
                        SELECT pen_coll_bacid
                        INTO lv_penbacid
                        FROM tbaadm.gsp p
                        WHERE p.schm_code = lv_schm_code
                        AND p.bank_id = lv_bankid
                        AND p.schm_type = lv_schm_type;

                    --}
                    END IF;

                 --}
                END IF;
              --}
              ELSE
              --{
                SELECT pen_coll_bacid
                INTO lv_penbacid
                FROM tbaadm.gsp p
                WHERE p.schm_code = lv_schm_code
                AND p.bank_id = lv_bankid
                AND p.schm_type = lv_schm_type;

                ----------------------------------------------------------------
                --If pd flg is N and pd_re_xfer_date is equal to appltrandt
                --then the account is transferring as performing today only.
                --But LAGEN would have generated the demand in past due account
                --as it runs before ACLLA(Asset Classfication)
                ----------------------------------------------------------------
                IF((lv_schm_type='LAA') OR (lv_schm_type='CLA'))
                THEN
                --{
                    IF(lv_pd_re_xfer_date=lv_appltrandt)
                    THEN
                    --{
                        SELECT PAST_DUE_PENAL_INT_COLL_BACID
                        INTO lv_penbacid
                        FROM tbaadm.gsp p
                        WHERE p.schm_code = lv_schm_code
                        AND p.bank_id = lv_bankid
                        AND p.schm_type = lv_schm_type;

                    --}
                    END IF;
                --}
                END IF;
              --}
              END IF;

                    SELECT foracid,acid
                     INTO lv_penforacid,lv_glacid
                     FROM tbaadm.gam
                     WHERE bacid = lv_penbacid
                     AND sol_id = lv_solid
                     AND acct_crncy_code = lv_acctcrncy
                     AND bank_id = lv_bankid;

                --------------------------------------------------

                --Assigning penal interest amount to normal
                --interest valraiable for data insertion purposes.

                --------------------------------------------------
                lv_bacid := lv_penbacid;
                lv_glacc := lv_penforacid;



             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   out_rec :=out_rec|| ' Penal int bacid not present '|| lv_acid;


             --}
             END;

                   BEGIN
               --{

                IF((lv_appl_penal_amt_today_dr>0))
                THEN
                --{
                    lv_credit_debit_ind:='D';
                --}
                ELSE
                --{

                    lv_credit_debit_ind:='C';
                --}
                END IF;

                ----------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                ----------------------------------------

                SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                 FROM tbaadm.dctd_acli
                 WHERE tran_id = LPAD (lv_appltranid, 9)
                 AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                 OR (acid = lv_glacid))
                 AND tran_date = lv_appltrandt
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
                END;


            -------------------------------------------------------------

            -- C_EIT insert

            -------------------------------------------------------------

            BEGIN
               --{
               lv_tranpart:='Penal Interest';
               INSERT INTO c_eit
                       (tran_date, bacid, gl_acct_no,
                    tran_id, part_tran_srl_num,
                    tran_amt,
                    tran_crncy,
                    part_tran_type,
                    tran_particular,
                    tran_particular_2,
                    tran_remarks, customer_account_no, sol_id,
                    schm_type, schm_code, eod_closing_balance,
                    eod_un_clr_bal_amt, eod_future_bal_amt,
                    eod_lien_amt, gl_sub_head_code,
                    int_coll_flag, int_paid_flag,
                    debit_credit_ind, interest_rate,
                    int_appl_flg, accrued_upto_date,
                    accrued_upto_amount,
                    accrued_amount_today,
                    booked_upto_date,
                    booked_upto_amount,
                    booked_amount_today,
                    applied_upto_date,
                    applied_upto_amount,
                    applied_amount_today,
                    SEGMENT, sub_segment, free_code_7,
                    rcre_user_id, rcre_time, lchg_user_id,
                    lchg_time, bank_id,unq_identifier
                       )
                VALUES (lv_appltrandt, lv_bacid, lv_glacc,
                    lv_appltranid, lv_ptransrlnum,
                    lv_tranamt,
                    lv_trancrncy,
                    lv_ptrantype,
                    lv_tranpart,
                    lv_tranpart2,
                    lv_tranrmks, lv_foracid, lv_solid,
                    lv_schm_type, lv_schm_code, lv_eodbal,
                    lv_unclrbalamt, lv_futbalamt,
                    lv_lienamt, lv_glsub,
                    lv_intcollflg, lv_intpdflg,
                    DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                    lv_bkdappl_flg, lv_accruptodt,
                    lv_accr_penal_upto_dr,
                    lv_accr_penal_amt_today_dr,
                    lv_bkduptodt,
                    lv_bkd_penal_upto_dr,
                    0,
                    lv_appltrandt,
                    lv_appl_penal_upto_dr,
                    abs(lv_appl_penal_amt_today_dr),
                    lv_segment, lv_subsegment, lv_freecode7,
                    lv_rcreuserid, lv_rcretime, lv_lchguserid,
                    lv_lchgtime, lv_bankid,lv_unique_id
                       );

               COMMIT;

            EXCEPTION
               WHEN OTHERS
               THEN
               --DBMS_OUTPUT.put_line (SQLERRM);
                 -- lv_errmsg := SUBSTR(SQLERRM,0,100);
                  out_rec := out_rec || 'Insert unsuccessfull';

            --}
            END;

           --}

               END IF;


           ------------------------------------
           --Inserting the booked amount today
           ------------------------------------
           IF((lv_bkd_penal_amt_today_dr!=0))
           THEN
           --{

                IF(lv_bkd_penal_amt_today_dr>0)
                THEN
                --{
                    lv_credit_debit_ind:='D';
                --}
                ELSE
                --{

                    lv_credit_debit_ind:='C';
                --}
                END IF;

                BEGIN
                   --{
                          SELECT pen_coll_bacid,penal_pandl_bacid
                   INTO lv_bacid,lv_pandl_bacid
                   FROM tbaadm.gsp p
                   WHERE p.schm_code = lv_schm_code
                   AND p.bank_id = lv_bankid
                   AND p.schm_type = lv_schm_type;

                  IF(lv_bkd_penal_amt_today_dr>0)
                  THEN
                  --{
                       IF(lv_pdflg='Y') THEN
                      --{
                        SELECT PAST_DUE_PENAL_INT_COLL_BACID
                        INTO lv_bacid
                        FROM tbaadm.gsp p
                        WHERE p.schm_code = lv_schm_code
                        AND p.bank_id = lv_bankid
                        AND p.schm_type = lv_schm_type;

                        lv_pandl_bacid:=lv_pen_susp_bacid;
                      --}
                      END IF;
                  --}
                  ELSE
                  --{
                      IF(lv_pdflg='Y') THEN
                      --{
                        IF((lv_schm_type!='LAA') AND (lv_schm_type!='CLA'))
                         THEN
                         --{
                            SELECT PAST_DUE_PENAL_INT_COLL_BACID
                            INTO lv_bacid
                            FROM tbaadm.gsp p
                            WHERE p.schm_code = lv_schm_code
                            AND p.bank_id = lv_bankid
                            AND p.schm_type = lv_schm_type;

                            lv_pandl_bacid:=lv_pen_susp_bacid;

                         --}
                         ELSE
                         --{
                            ----------------------------------------------------------------
                            --If pd flg is Y and pd_xfer_date is equal to appltrandt
                            --then the account is transferring as non performing today only.
                            --But LAGEN would have generated the demand in interest receivable
                            --as it runs before ACLLA(Asset Classfication)
                            ----------------------------------------------------------------
                            IF((lv_pd_xfer_date!=lv_appltrandt) OR (lv_pd_xfer_date is null))
                            THEN
                            --{
                                SELECT PAST_DUE_PENAL_INT_COLL_BACID
                                INTO lv_bacid
                                FROM tbaadm.gsp p
                                WHERE p.schm_code = lv_schm_code
                                AND p.bank_id = lv_bankid
                                AND p.schm_type = lv_schm_type;

                                lv_pandl_bacid:=lv_pen_susp_bacid;

                            --}
                            END IF;

                         --}
                        END IF;
                      --}
                      ELSE
                      --{

                        ----------------------------------------------------------------
                        --If pd flg is N and pd_re_xfer_date is equal to appltrandt
                        --then the account is transferring as performing today only.
                        --But LAGEN would have generated the demand in past due account
                        --as it runs before ACLLA(Asset Classfication)
                        ----------------------------------------------------------------
                        IF((lv_schm_type='LAA') OR (lv_schm_type='CLA'))
                        THEN
                        --{
                            IF(lv_pd_re_xfer_date=lv_appltrandt)
                            THEN
                            --{
                                SELECT PAST_DUE_PENAL_INT_COLL_BACID
                                INTO lv_bacid
                                FROM tbaadm.gsp p
                                WHERE p.schm_code = lv_schm_code
                                AND p.bank_id = lv_bankid
                                AND p.schm_type = lv_schm_type;

                                lv_pandl_bacid:=lv_pen_susp_bacid;

                            --}
                            END IF;
                        --}
                        END IF;
                      --}
                      END IF;
                  --}
                  END IF;


                     SELECT foracid,acid
                     INTO lv_glacc,lv_glacid
                     FROM tbaadm.gam
                     WHERE bacid = lv_bacid
                     AND sol_id = lv_solid
                     AND acct_crncy_code = lv_acctcrncy
                     AND bank_id = lv_bankid;

                     SELECT foracid,acid
                     INTO lv_pandl_glacc,lv_pandl_glacid
                     FROM tbaadm.gam
                     WHERE bacid = lv_pandl_bacid
                     AND sol_id = lv_solid
                     AND acct_crncy_code = lv_acctcrncy
                     AND bank_id = lv_bankid;

                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       out_rec :=out_rec|| ' Penal int bacid not present '|| lv_acid;



                 --}
                END;

            BEGIN
               --{
                ----------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                 FROM tbaadm.dctd_acli
                 WHERE tran_id = LPAD (lv_bkdtranid, 9)
                 AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                 OR (acid = lv_glacid))
                 AND tran_date = lv_bkduptodt
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';



            --}
            END;


            -------------------------------------------------------------

               -- C_EIT insert

               -------------------------------------------------------------
               BEGIN
              --{
              INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_bkduptodt, lv_bacid, lv_glacc,
                       lv_bkdtranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       DECODE(lv_credit_debit_ind,'C','C','D'), lv_intrate,
                       lv_bkdappl_flg, lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       DECODE (lv_crdrflg,
                           'C', lv_accr_amt_today_cr,
                           lv_accr_amt_today_dr
                          ),
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       abs(lv_bkd_penal_amt_today_dr),
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       0,
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                      );
                      COMMIT;

                      BEGIN
                      --{
                        SELECT part_tran_srl_num, tran_particular, tran_amt,
                        tran_particular_2, tran_rmks, part_tran_type,
                        tran_crncy_code
                        INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                        lv_tranpart2, lv_tranrmks, lv_ptrantype,
                        lv_trancrncy
                        FROM tbaadm.dctd_acli
                        WHERE tran_id = LPAD (lv_bkdtranid, 9)

                        AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                         OR (acid = lv_pandl_glacid))
                        AND tran_date = lv_bkduptodt
                        AND pstd_flg = 'Y'
                        AND del_flg != 'Y'
                        AND bank_id = lv_bankid
                        AND ROWNUM < 2;
                       EXCEPTION
                       WHEN NO_DATA_FOUND
                       THEN
                       NULL;
                      --}
                      END;
                      --P/L Entry
                         INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                    VALUES (lv_bkduptodt, lv_pandl_bacid, lv_pandl_glacc,
                       lv_bkdtranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                       lv_bkdappl_flg, lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       DECODE (lv_crdrflg,
                           'C', lv_accr_amt_today_cr,
                           lv_accr_amt_today_dr
                          ),
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       abs(lv_bkd_penal_amt_today_dr),
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       0,
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                          );

              COMMIT;


               EXCEPTION
              WHEN OTHERS
              THEN

                 out_rec := out_rec || 'Insert unsucessful';

               --}
            END;

           --}
           END IF;


               IF((lv_applamtdr_ovdu != 0))
               THEN
               --{

                           BEGIN
                   --{

                    SELECT ovdu_int_paid_bacid
                    INTO lv_bacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                    AND p.bank_id = lv_bankid
                    AND p.schm_type = lv_schm_type;


                    SELECT foracid,acid
                    INTO lv_glacc,lv_glacid
                    FROM tbaadm.gam
                    WHERE bacid = lv_bacid
                    AND sol_id = lv_solid
                    AND acct_crncy_code = lv_acctcrncy
                    AND bank_id = lv_bankid;


                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       out_rec :=out_rec|| ' Overdue bacid not present '|| lv_acid;
                 --}
                END;

                           BEGIN
                   --{
                       IF(lv_crdrflg='C')
                       THEN
                       --{
                           IF((lv_applamtdr_ovdu>0))
                        THEN
                        --{
                            lv_credit_debit_ind:='C';
                        --}
                        ELSE
                        --{

                            lv_credit_debit_ind:='D';
                        --}
                        END IF;
                       --}
                       ELSE
                       --{
                           IF((lv_applamtdr_ovdu>0))
                        THEN
                        --{
                            lv_credit_debit_ind:='D';
                        --}
                        ELSE
                        --{

                            lv_credit_debit_ind:='C';
                        --}
                        END IF;
                       --}
                       END IF;



                    ----------------------------------------

                    -- fetching tran details from tbaadm.dctd_acli

                    ----------------------------------------

                       SELECT part_tran_srl_num, tran_particular, tran_amt,
                          tran_particular_2, tran_rmks, part_tran_type,
                          tran_crncy_code
                     INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                          lv_tranpart2, lv_tranrmks, lv_ptrantype,
                          lv_trancrncy
                      FROM tbaadm.dctd_acli
                      WHERE tran_id = LPAD (lv_appltranid, 9)
                      AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                      OR (acid = lv_glacid))
                      AND tran_date = lv_appltrandt
                      AND pstd_flg = 'Y'
                      AND del_flg != 'Y'
                      AND bank_id = lv_bankid
                      AND ROWNUM < 2;


                    --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                       lv_ptransrlnum:='';
                       lv_tranpart:='';
                       lv_tranamt:='';
                       lv_tranpart2:='';
                       lv_tranrmks:='';
                       lv_ptrantype:='';
                       lv_trancrncy:='';
                --}
                END;

                -------------------------------------------------------------

                -- C_EIT insert

                -------------------------------------------------------------

                BEGIN
                   --{
                   lv_tranpart:='Overdue Interest';
                   INSERT INTO c_eit
                           (tran_date, bacid, gl_acct_no,
                        tran_id, part_tran_srl_num,
                        tran_amt,
                        tran_crncy,
                        part_tran_type,
                        tran_particular,
                        tran_particular_2,
                        tran_remarks, customer_account_no, sol_id,
                        schm_type, schm_code, eod_closing_balance,
                        eod_un_clr_bal_amt, eod_future_bal_amt,
                        eod_lien_amt, gl_sub_head_code,
                        int_coll_flag, int_paid_flag,
                        debit_credit_ind, interest_rate,
                        int_appl_flg, accrued_upto_date,
                        accrued_upto_amount,
                        accrued_amount_today,
                        booked_upto_date,
                        booked_upto_amount,
                        booked_amount_today,
                        applied_upto_date,
                        applied_upto_amount,
                        applied_amount_today,
                        SEGMENT, sub_segment, free_code_7,
                        rcre_user_id, rcre_time, lchg_user_id,
                        lchg_time, bank_id,unq_identifier
                           )
                    VALUES (lv_appltrandt, lv_bacid, lv_glacc,
                        lv_appltranid, lv_ptransrlnum,
                        lv_tranamt,
                        lv_trancrncy,
                        lv_ptrantype,
                        lv_tranpart,
                        lv_tranpart2,
                        lv_tranrmks, lv_foracid, lv_solid,
                        lv_schm_type, lv_schm_code, lv_eodbal,
                        lv_unclrbalamt, lv_futbalamt,
                        lv_lienamt, lv_glsub,
                        lv_intcollflg, lv_intpdflg,
                        DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                        lv_bkdappl_flg, lv_accruptodt,
                        lv_accr_upto_amt_dr,
                        abs(lv_accramtdr_ovdu),
                        lv_bkduptodt,
                        lv_bkd_upto_amt_dr,
                        0,
                        lv_appltrandt,
                        lv_appl_upto_amt_dr,
                        abs(lv_applamtdr_ovdu),
                        lv_segment, lv_subsegment, lv_freecode7,
                        lv_rcreuserid, lv_rcretime, lv_lchguserid,
                        lv_lchgtime, lv_bankid,lv_unique_id
                           );


                   COMMIT;

                EXCEPTION
                   WHEN OTHERS
                   THEN

                      out_rec := out_rec || 'Insert unsuccessfull';

                --}
                END;

                   --}
                   END IF;



        ------------------------------------
        --Inserting booked overdue interest
        ------------------------------------

        IF(lv_bkdamtdr_ovdu!=0)
        THEN
        --{
            IF(lv_crdrflg='C')
            THEN
            --{
                IF((lv_bkdamtdr_ovdu>0))
                THEN
                --{
                    lv_credit_debit_ind:='C';
                --}
                ELSE
                --{

                    lv_credit_debit_ind:='D';
                --}
                END IF;
            --}
            ELSE
            --{
                IF((lv_bkdamtdr_ovdu>0))
                THEN
                --{
                    lv_credit_debit_ind:='D';
                --}
                ELSE
                --{

                    lv_credit_debit_ind:='C';
                --}
                END IF;
            --}
            END IF;

            BEGIN
               --{

                SELECT ovdu_int_paid_bacid,OVDU_INT_PANDL_BACID_CR
                INTO lv_bacid,lv_pandl_bacid
                FROM tbaadm.gsp p
                WHERE p.schm_code = lv_schm_code
                AND p.bank_id = lv_bankid
                AND p.schm_type = lv_schm_type;


                SELECT foracid,acid
                INTO lv_glacc,lv_glacid
                FROM tbaadm.gam
                WHERE bacid = lv_bacid
                AND sol_id = lv_solid
                AND acct_crncy_code = lv_acctcrncy
                AND bank_id = lv_bankid;

                SELECT foracid,acid
                INTO lv_pandl_glacc,lv_pandl_glacid
                FROM tbaadm.gam
                WHERE bacid = lv_pandl_bacid
                AND sol_id = lv_solid
                AND acct_crncy_code = lv_acctcrncy
                AND bank_id = lv_bankid;


             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   out_rec :=out_rec|| ' Overdue bacid not present '|| lv_acid;
             --}
            END;

            BEGIN
            --{
                 ----------------------------------------

                 -- fetching tran details from tbaadm.dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                  FROM tbaadm.dctd_acli
                  WHERE tran_id = LPAD (lv_bkdtranid, 9)
                  AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                  OR (acid = lv_glacid))
                  AND tran_date = lv_bkduptodt
                  AND pstd_flg = 'Y'
                  AND del_flg != 'Y'
                  AND bank_id = lv_bankid
                  AND ROWNUM < 2;


                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';


            --}
            END;

                -------------------------------------------------------------

                   -- C_EIT insert

                   -------------------------------------------------------------
                   BEGIN
                  --{
                  INSERT INTO c_eit
                          (tran_date, bacid, gl_acct_no,
                           tran_id, part_tran_srl_num,
                           tran_amt,
                           tran_crncy,
                           part_tran_type,
                           tran_particular,
                           tran_particular_2,
                           tran_remarks, customer_account_no, sol_id,
                           schm_type, schm_code, eod_closing_balance,
                           eod_un_clr_bal_amt, eod_future_bal_amt,
                           eod_lien_amt, gl_sub_head_code,
                           int_coll_flag, int_paid_flag,
                           debit_credit_ind, interest_rate,
                           int_appl_flg, accrued_upto_date,
                           accrued_upto_amount,
                           accrued_amount_today,
                           booked_upto_date,
                           booked_upto_amount,
                           booked_amount_today,
                           applied_upto_date,
                           applied_upto_amount,
                           applied_amount_today,
                           SEGMENT, sub_segment, free_code_7,
                           rcre_user_id, rcre_time, lchg_user_id,
                           lchg_time, bank_id,unq_identifier
                          )
                       VALUES (lv_bkduptodt, lv_bacid, lv_glacc,
                           lv_bkdtranid, lv_ptransrlnum,
                           lv_tranamt,
                           lv_trancrncy,
                           lv_ptrantype,
                           lv_tranpart,
                           lv_tranpart2,
                           lv_tranrmks, lv_foracid, lv_solid,
                           lv_schm_type, lv_schm_code, lv_eodbal,
                           lv_unclrbalamt, lv_futbalamt,
                           lv_lienamt, lv_glsub,
                           lv_intcollflg, lv_intpdflg,
                           DECODE(lv_credit_debit_ind,'C','C','D'), lv_intrate,
                           lv_bkdappl_flg, lv_accruptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_accr_upto_amt_cr,
                               lv_accr_upto_amt_dr
                              ),
                           abs(lv_accramtdr_ovdu),
                           lv_bkduptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_bkd_upto_amt_cr,
                               lv_bkd_upto_amt_dr
                              ),
                           abs(lv_bkdamtdr_ovdu),
                           lv_appltrandt,
                           DECODE (lv_crdrflg,
                               'C', lv_appl_upto_amt_cr,
                               lv_appl_upto_amt_dr
                              ),
                           0,
                           lv_segment, lv_subsegment, lv_freecode7,
                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                           lv_lchgtime, lv_bankid,lv_unique_id
                          );
                          COMMIT;

                        BEGIN
                          --{
                            SELECT part_tran_srl_num, tran_particular, tran_amt,
                            tran_particular_2, tran_rmks, part_tran_type,
                            tran_crncy_code
                            INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                            lv_tranpart2, lv_tranrmks, lv_ptrantype,
                            lv_trancrncy
                            FROM tbaadm.dctd_acli
                            WHERE tran_id = LPAD (lv_bkdtranid, 9)
                            AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                             OR (acid = lv_pandl_glacid))
                            AND tran_date = lv_bkduptodt
                            AND pstd_flg = 'Y'
                            AND del_flg != 'Y'
                            AND bank_id = lv_bankid
                            AND ROWNUM < 2;
                           EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                           NULL;
                          --}
                          END;
                          --P/L Entry
                          INSERT INTO c_eit
                          (tran_date, bacid, gl_acct_no,
                           tran_id, part_tran_srl_num,
                           tran_amt,
                           tran_crncy,
                           part_tran_type,
                           tran_particular,
                           tran_particular_2,
                           tran_remarks, customer_account_no, sol_id,
                           schm_type, schm_code, eod_closing_balance,
                           eod_un_clr_bal_amt, eod_future_bal_amt,
                           eod_lien_amt, gl_sub_head_code,
                           int_coll_flag, int_paid_flag,
                           debit_credit_ind, interest_rate,
                           int_appl_flg, accrued_upto_date,
                           accrued_upto_amount,
                           accrued_amount_today,
                           booked_upto_date,
                           booked_upto_amount,
                           booked_amount_today,
                           applied_upto_date,
                           applied_upto_amount,
                           applied_amount_today,
                           SEGMENT, sub_segment, free_code_7,
                           rcre_user_id, rcre_time, lchg_user_id,
                           lchg_time, bank_id,unq_identifier
                          )
                       VALUES (lv_bkduptodt, lv_pandl_bacid, lv_pandl_glacc,
                           lv_bkdtranid, lv_ptransrlnum,
                           lv_tranamt,
                           lv_trancrncy,
                           lv_ptrantype,
                           lv_tranpart,
                           lv_tranpart2,
                           lv_tranrmks, lv_foracid, lv_solid,
                           lv_schm_type, lv_schm_code, lv_eodbal,
                           lv_unclrbalamt, lv_futbalamt,
                           lv_lienamt, lv_glsub,
                           lv_intcollflg, lv_intpdflg,
                           DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                           lv_bkdappl_flg, lv_accruptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_accr_upto_amt_cr,
                               lv_accr_upto_amt_dr
                              ),
                           abs(lv_accramtdr_ovdu),
                           lv_bkduptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_bkd_upto_amt_cr,
                               lv_bkd_upto_amt_dr
                              ),
                           abs(lv_bkdamtdr_ovdu),
                           lv_appltrandt,
                           DECODE (lv_crdrflg,
                               'C', lv_appl_upto_amt_cr,
                               lv_appl_upto_amt_dr
                              ),
                           0,
                           lv_segment, lv_subsegment, lv_freecode7,
                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                           lv_lchgtime, lv_bankid,lv_unique_id
                          );



                  COMMIT;


                   EXCEPTION
                  WHEN OTHERS
                  THEN

                     out_rec := out_rec || 'Insert unsucessful';

                   --}
                END;

        --}
        END IF;



            -----------------------------------------------
            --Inserting the amount which directly goes into
            --P/L account
            ------------------------------------------------

            IF((lv_schm_type!='SBA') AND ((lv_nrml_int_book_cr_diff1>0) OR (lv_nrml_int_book_dr_diff1>0)))
            THEN
            --{


                BEGIN
                   --{

                    SELECT DECODE (lv_crdrflg,
                            'D', INT_PANDL_BACID_DR,
                            INT_PANDL_BACID_CR
                           )
                    INTO lv_bacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                    AND p.bank_id = lv_bankid
                    AND p.schm_type = lv_schm_type;

                    -----------------------------------------------
                      --Checking the past due flag  and
                      --deriving PAST_DUE_INT_COLL_BACID
                      -----------------------------------------------

                      IF(lv_nrml_int_book_dr_diff1 !=0 )

                      THEN
                     --{
                        IF(lv_pdflg='Y') THEN
                          --{
                            IF((lv_schm_type!='LAA') AND (lv_schm_type!='CLA'))
                             THEN
                             --{
                                lv_bacid:=lv_susp_bacid;
                             --}
                             ELSE
                             --{
                                ----------------------------------------------------------------
                                --If pd flg is Y and pd_xfer_date is equal to appltrandt
                                --then the account is transferring as non performing today only.
                                --But LAGEN would have generated the demand in interest receivable
                                --as it runs before ACLLA(Asset Classfication)
                                ----------------------------------------------------------------
                                IF((lv_pd_xfer_date!=lv_appltrandt) OR (lv_pd_xfer_date is null))
                                THEN
                                --{
                                    lv_bacid:=lv_susp_bacid;
                                --}
                                END IF;

                             --}
                            END IF;


                          --}
                        END IF;

                        IF(lv_pdflg='N') THEN
                        --{
                            ----------------------------------------------------------------
                            --If pd flg is N and pd_re_xfer_date is equal to appltrandt
                            --then the account is transferring as performing today only.
                            --But LAGEN would have generated the demand in past due account
                            --as it runs before ACLLA(Asset Classfication)
                            ----------------------------------------------------------------
                            IF((lv_schm_type='LAA') OR (lv_schm_type='CLA'))
                            THEN
                            --{
                                IF(lv_pd_re_xfer_date=lv_appltrandt)
                                THEN
                                --{
                                    lv_bacid:=lv_susp_bacid;
                                --}
                                END IF;
                            --}
                            END IF;

                        --}
                        END IF;
                     --}
                     END IF;


                    SELECT foracid,acid
                    INTO lv_glacc,lv_glacid
                    FROM tbaadm.gam
                    WHERE bacid = lv_bacid
                    AND sol_id = lv_solid
                    AND acct_crncy_code = lv_acctcrncy
                    AND bank_id = lv_bankid;


                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       out_rec :=out_rec|| ' P/L account not present '|| lv_acid;
                 --}
                END;

                BEGIN
                   --{
                    IF(lv_crdrflg='C')
                    THEN
                    --{
                        IF((lv_nrml_int_book_cr_diff1>0))
                        THEN
                        --{
                            lv_credit_debit_ind:='C';
                        --}
                        ELSE
                        --{

                            lv_credit_debit_ind:='D';
                        --}
                        END IF;
                    --}
                    ELSE
                    --{
                        IF((lv_nrml_int_book_dr_diff1>0))
                        THEN
                        --{
                            lv_credit_debit_ind:='D';
                        --}
                        ELSE
                        --{

                            lv_credit_debit_ind:='C';
                        --}
                        END IF;
                    --}
                    END IF;



                    ----------------------------------------

                    -- fetching tran details from tbaadm.dctd_acli

                    ----------------------------------------


                       SELECT part_tran_srl_num, tran_particular, tran_amt,
                          tran_particular_2, tran_rmks, part_tran_type,
                          tran_crncy_code
                     INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                          lv_tranpart2, lv_tranrmks, lv_ptrantype,
                          lv_trancrncy
                      FROM tbaadm.dctd_acli
                      WHERE tran_id = LPAD (lv_appltranid, 9)
                      AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                      OR (acid = lv_glacid))
                      AND tran_date = lv_appltrandt
                      AND pstd_flg = 'Y'
                      AND del_flg != 'Y'
                      AND bank_id = lv_bankid
                      AND ROWNUM < 2;


                    --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                       lv_ptransrlnum:='';
                       lv_tranpart:='';
                       lv_tranamt:='';
                       lv_tranpart2:='';
                       lv_tranrmks:='';
                       lv_ptrantype:='';
                       lv_trancrncy:='';
                --}
                END;

                lv_nrml_amt_inserted_cr:=lv_nrml_int_book_cr_diff1;
                lv_nrml_amt_inserted_dr:=lv_nrml_int_book_dr_diff1;


                IF(lv_crdrflg='C')
                THEN
                --{
                    lv_nrml_amt_inserted:=lv_nrml_amt_inserted_cr;
                --}
                ELSE
                --{
                    lv_nrml_amt_inserted:=lv_nrml_amt_inserted_dr;
                --}
                END IF;



                IF(lv_nrml_amt_inserted>0)
                THEN
                --{
                    -------------------------------------------------------------

                       -- C_EIT insert

                       -------------------------------------------------------------
                       BEGIN
                      --{
                      INSERT INTO c_eit
                              (tran_date, bacid, gl_acct_no,
                               tran_id, part_tran_srl_num,
                               tran_amt,
                               tran_crncy,
                               part_tran_type,
                               tran_particular,
                               tran_particular_2,
                               tran_remarks, customer_account_no, sol_id,
                               schm_type, schm_code, eod_closing_balance,
                               eod_un_clr_bal_amt, eod_future_bal_amt,
                               eod_lien_amt, gl_sub_head_code,
                               int_coll_flag, int_paid_flag,
                               debit_credit_ind, interest_rate,
                               int_appl_flg, accrued_upto_date,
                               accrued_upto_amount,
                               accrued_amount_today,
                               booked_upto_date,
                               booked_upto_amount,
                               booked_amount_today,
                               applied_upto_date,
                               applied_upto_amount,
                               applied_amount_today,
                               SEGMENT, sub_segment, free_code_7,
                               rcre_user_id, rcre_time, lchg_user_id,
                               lchg_time, bank_id,unq_identifier
                              )
                           VALUES (lv_appltrandt, lv_bacid, lv_glacc,
                               lv_appltranid, lv_ptransrlnum,
                               lv_tranamt,
                               lv_trancrncy,
                               lv_ptrantype,
                               lv_tranpart,
                               lv_tranpart2,
                               lv_tranrmks, lv_foracid, lv_solid,
                               lv_schm_type, lv_schm_code, lv_eodbal,
                               lv_unclrbalamt, lv_futbalamt,
                               lv_lienamt, lv_glsub,
                               lv_intcollflg, lv_intpdflg,
                               DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                               lv_bkdappl_flg, lv_accruptodt,
                               DECODE (lv_crdrflg,
                                   'C', lv_accr_upto_amt_cr,
                                   lv_accr_upto_amt_dr
                                  ),
                               DECODE (lv_crdrflg,
                                   'C', lv_accr_amt_today_cr,
                                   lv_accr_amt_today_dr
                                  ),
                               lv_bkduptodt,
                               DECODE (lv_crdrflg,
                                   'C', lv_bkd_upto_amt_cr,
                                   lv_bkd_upto_amt_dr
                                  ),
                               0,
                               lv_appltrandt,
                               DECODE (lv_crdrflg,
                                   'C', lv_appl_upto_amt_cr,
                                   lv_appl_upto_amt_dr
                                  ),
                               abs(lv_nrml_amt_inserted),
                               lv_segment, lv_subsegment, lv_freecode7,
                               lv_rcreuserid, lv_rcretime, lv_lchguserid,
                               lv_lchgtime, lv_bankid,lv_unique_id
                          );




                      COMMIT;


                           EXCEPTION
                      WHEN OTHERS
                      THEN
                          out_rec := out_rec || 'Insert uncusscessful';

                           --}
                           END;

                   --}
                END IF;


            --}
            END IF;

            ----------------------------------------------------
            --Inserting the penal interest which goes into
            --P/L account directly
            ----------------------------------------------------

            IF((lv_schm_type!='SBA') AND (lv_penl_int_book_dr_diff1>0))
            THEN
            --{
                IF((lv_penl_int_book_dr_diff1>0))
                THEN
                --{
                    lv_credit_debit_ind:='D';
                --}
                ELSE
                --{

                    lv_credit_debit_ind:='C';
                --}
                END IF;


                BEGIN
                   --{

                  IF(lv_pdflg='Y') THEN
                  --{
                    IF((lv_schm_type!='LAA') AND (lv_schm_type!='CLA'))
                     THEN
                     --{
                        lv_penbacid:=lv_pen_susp_bacid;
                     --}
                     ELSE
                     --{
                        ----------------------------------------------------------------
                        --If pd flg is Y and pd_xfer_date is equal to appltrandt
                        --then the account is transferring as non performing today only.
                        --But LAGEN would have generated the demand in interest receivable
                        --as it runs before ACLLA(Asset Classfication)
                        ----------------------------------------------------------------
                        IF((lv_pd_xfer_date!=lv_appltrandt) OR (lv_pd_xfer_date is null))
                        THEN
                        --{
                            lv_penbacid:=lv_pen_susp_bacid;
                        --}
                        ELSE
                        --{
                            SELECT PENAL_PANDL_BACID
                            INTO lv_penbacid
                            FROM tbaadm.gsp p
                            WHERE p.schm_code = lv_schm_code
                            AND p.bank_id = lv_bankid
                            AND p.schm_type = lv_schm_type;

                        --}
                        END IF;

                     --}
                    END IF;
                  --}
                  ELSE
                  --{
                    SELECT PENAL_PANDL_BACID
                    INTO lv_penbacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                    AND p.bank_id = lv_bankid
                    AND p.schm_type = lv_schm_type;

                    ----------------------------------------------------------------
                    --If pd flg is N and pd_re_xfer_date is equal to appltrandt
                    --then the account is transferring as performing today only.
                    --But LAGEN would have generated the demand in past due account
                    --as it runs before ACLLA(Asset Classfication)
                    ----------------------------------------------------------------
                    IF((lv_schm_type='LAA') OR (lv_schm_type='CLA'))
                    THEN
                    --{
                        IF(lv_pd_re_xfer_date=lv_appltrandt)
                        THEN
                        --{
                            lv_penbacid:=lv_pen_susp_bacid;
                        --}
                        END IF;
                    --}
                    END IF;
                  --}
                  END IF;

                      SELECT foracid,acid
                      INTO lv_penforacid,lv_glacid
                      FROM tbaadm.gam
                      WHERE bacid = lv_penbacid
                      AND sol_id = lv_solid
                      AND acct_crncy_code = lv_acctcrncy
                      AND bank_id = lv_bankid;

                    --------------------------------------------------

                    --Assigning penal interest amount to normal
                    --interest valraiable for data insertion purposes.

                    --------------------------------------------------
                    lv_bacid := lv_penbacid;
                    lv_glacc := lv_penforacid;



                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       out_rec :=out_rec|| ' Penal int PANDL bacid not present '|| lv_acid;
            --}
             END;

             BEGIN
            --{
                ----------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                  FROM tbaadm.dctd_acli
                  WHERE tran_id = LPAD (lv_appltranid, 9)
                  AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                  OR (acid = lv_glacid))
                  AND tran_date = lv_appltrandt
                  AND pstd_flg = 'Y'
                  AND del_flg != 'Y'
                  AND bank_id = lv_bankid
                  AND ROWNUM < 2;


                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
            END;

            lv_penl_amt_inserted_dr:=lv_penl_int_book_dr_diff1;

            IF(lv_penl_amt_inserted_dr>0)
            THEN
            --{
                -------------------------------------------------------------

                -- C_EIT insert

                -------------------------------------------------------------

                BEGIN
                   --{
                   lv_tranpart:='Penal Interest';
                   INSERT INTO c_eit
                           (tran_date, bacid, gl_acct_no,
                        tran_id, part_tran_srl_num,
                        tran_amt,
                        tran_crncy,
                        part_tran_type,
                        tran_particular,
                        tran_particular_2,
                        tran_remarks, customer_account_no, sol_id,
                        schm_type, schm_code, eod_closing_balance,
                        eod_un_clr_bal_amt, eod_future_bal_amt,
                        eod_lien_amt, gl_sub_head_code,
                        int_coll_flag, int_paid_flag,
                        debit_credit_ind, interest_rate,
                        int_appl_flg, accrued_upto_date,
                        accrued_upto_amount,
                        accrued_amount_today,
                        booked_upto_date,
                        booked_upto_amount,
                        booked_amount_today,
                        applied_upto_date,
                        applied_upto_amount,
                        applied_amount_today,
                        SEGMENT, sub_segment, free_code_7,
                        rcre_user_id, rcre_time, lchg_user_id,
                        lchg_time, bank_id,unq_identifier
                           )
                    VALUES (lv_appltrandt, lv_bacid, lv_glacc,
                        lv_appltranid, lv_ptransrlnum,
                        lv_tranamt,
                        lv_trancrncy,
                        lv_ptrantype,
                        lv_tranpart,
                        lv_tranpart2,
                        lv_tranrmks, lv_foracid, lv_solid,
                        lv_schm_type, lv_schm_code, lv_eodbal,
                        lv_unclrbalamt, lv_futbalamt,
                        lv_lienamt, lv_glsub,
                        lv_intcollflg, lv_intpdflg,
                        DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                        lv_bkdappl_flg, lv_accruptodt,
                        lv_accr_penal_upto_dr,
                        lv_accr_penal_amt_today_dr,
                        lv_bkduptodt,
                        lv_bkd_penal_upto_dr,
                        0,
                        lv_appltrandt,
                        lv_appl_penal_upto_dr,
                        abs(lv_penl_amt_inserted_dr),
                        lv_segment, lv_subsegment, lv_freecode7,
                        lv_rcreuserid, lv_rcretime, lv_lchguserid,
                        lv_lchgtime, lv_bankid,lv_unique_id
                           );

                   COMMIT;


                EXCEPTION
                   WHEN OTHERS
                   THEN

                      out_rec := out_rec || 'Insert unsuccessfull';

                --}
                END;
            --}
            END IF;



        --}
        END IF;

        ----------------------------------------------------
         --Inserting the overdue interest which goes into
         --P/L account directly
        ----------------------------------------------------

        IF((lv_schm_type!='SBA') AND (lv_ovdu_int_book_diff1>0))
        THEN
        --{
            IF(lv_crdrflg='C')
            THEN
            --{
                IF((lv_ovdu_int_book_diff1>0))
                THEN
                --{
                    lv_credit_debit_ind:='C';
                --}
                ELSE
                --{

                    lv_credit_debit_ind:='D';
                --}
                END IF;
            --}
            ELSE
            --{
                IF((lv_ovdu_int_book_diff1>0))
                THEN
                --{
                    lv_credit_debit_ind:='D';
                --}
                ELSE
                --{

                    lv_credit_debit_ind:='C';
                --}
                END IF;
            --}
            END IF;


               BEGIN
               --{

                SELECT OVDU_INT_PANDL_BACID_CR
                INTO lv_bacid
                FROM tbaadm.gsp p
                WHERE p.schm_code = lv_schm_code
                AND p.bank_id = lv_bankid
                AND p.schm_type = lv_schm_type;


                SELECT foracid,acid
                INTO lv_glacc,lv_glacid
                FROM tbaadm.gam
                WHERE bacid = lv_bacid
                AND sol_id = lv_solid
                AND acct_crncy_code = lv_acctcrncy
                AND bank_id = lv_bankid;


             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   out_rec :=out_rec|| ' Overdue bacid not present '|| lv_acid;
             --}
            END;

            BEGIN
            --{
                ----------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                  FROM tbaadm.dctd_acli
                  WHERE tran_id = LPAD (lv_appltranid, 9)
                  AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                  AND tran_date = lv_appltrandt
                  AND pstd_flg = 'Y'
                  AND del_flg != 'Y'
                  AND bank_id = lv_bankid
                  AND ROWNUM < 2;

                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
            END;

            lv_ovdu_amt_inserted_dr:=lv_ovdu_int_book_diff1;


            IF(lv_ovdu_amt_inserted_dr>0)
            THEN
            --{
                -------------------------------------------------------------

                   -- C_EIT insert

                   -------------------------------------------------------------
                   BEGIN
                  --{
                  INSERT INTO c_eit
                          (tran_date, bacid, gl_acct_no,
                           tran_id, part_tran_srl_num,
                           tran_amt,
                           tran_crncy,
                           part_tran_type,
                           tran_particular,
                           tran_particular_2,
                           tran_remarks, customer_account_no, sol_id,
                           schm_type, schm_code, eod_closing_balance,
                           eod_un_clr_bal_amt, eod_future_bal_amt,
                           eod_lien_amt, gl_sub_head_code,
                           int_coll_flag, int_paid_flag,
                           debit_credit_ind, interest_rate,
                           int_appl_flg, accrued_upto_date,
                           accrued_upto_amount,
                           accrued_amount_today,
                           booked_upto_date,
                           booked_upto_amount,
                           booked_amount_today,
                           applied_upto_date,
                           applied_upto_amount,
                           applied_amount_today,
                           SEGMENT, sub_segment, free_code_7,
                           rcre_user_id, rcre_time, lchg_user_id,
                           lchg_time, bank_id,unq_identifier
                          )
                       VALUES (lv_appltrandt, lv_bacid, lv_glacc,
                           lv_appltranid, lv_ptransrlnum,
                           lv_tranamt,
                           lv_trancrncy,
                           lv_ptrantype,
                           lv_tranpart,
                           lv_tranpart2,
                           lv_tranrmks, lv_foracid, lv_solid,
                           lv_schm_type, lv_schm_code, lv_eodbal,
                           lv_unclrbalamt, lv_futbalamt,
                           lv_lienamt, lv_glsub,
                           lv_intcollflg, lv_intpdflg,
                           DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                           lv_bkdappl_flg, lv_accruptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_accr_upto_amt_cr,
                               lv_accr_upto_amt_dr
                              ),
                           DECODE (lv_crdrflg,
                               'C', lv_accr_amt_today_cr,
                               lv_accr_amt_today_dr
                              ),
                           lv_bkduptodt,
                           DECODE (lv_crdrflg,
                               'C', lv_bkd_upto_amt_cr,
                               lv_bkd_upto_amt_dr
                              ),
                           0,
                           lv_appltrandt,
                           DECODE (lv_crdrflg,
                               'C', lv_appl_upto_amt_cr,
                               lv_appl_upto_amt_dr
                              ),
                           abs(lv_ovdu_amt_inserted_dr),
                           lv_segment, lv_subsegment, lv_freecode7,
                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                           lv_lchgtime, lv_bankid,lv_unique_id
                          );


                  COMMIT;


                   EXCEPTION
                  WHEN OTHERS
                  THEN

                     out_rec := out_rec || 'Insert uncusscessful';

                   --}
                      END;
            --}
            END IF;


        --}
        END IF;

               <<applnextrec>>
               out_rec := out_rec || '| Fetch next rec |';


      --}
      END IF;
   END c_eit_appl_tran_fetch_proc;

   PROCEDURE c_eit_appl_tran_fetch_proc_oda (
         lv_appltrandt                IN OUT   DATE,
         lv_appltranid                IN OUT   VARCHAR2,
         lv_bkdtranid                 IN       VARCHAR2,
         lv_acid                      IN       VARCHAR2,
         lv_foracid                   IN       VARCHAR2,
         lv_solid                     IN       VARCHAR2,
         lv_schm_type                 IN       VARCHAR2,
         lv_schm_code                 IN       VARCHAR2,
         lv_eodbal                    IN       NUMBER,
         lv_unclrbalamt               IN       NUMBER,
         lv_futbalamt                 IN       NUMBER,
         lv_lienamt                   IN       NUMBER,
         lv_glsub                     IN       VARCHAR2,
         lv_intcollflg                IN       CHAR,
         lv_intpdflg                  IN       CHAR,
         lv_crdrflg                   IN       CHAR,
         lv_intrate                   IN       NUMBER,
         lv_bkdappl_flg               IN       CHAR,
         lv_accruptodt                IN       DATE,
         lv_accr_upto_amt_cr          IN OUT   NUMBER,
         lv_accr_upto_amt_dr          IN OUT   NUMBER,
         lv_accr_amt_today_cr         IN OUT   NUMBER,
         lv_accr_amt_today_dr         IN OUT   NUMBER,
         lv_bkduptodt                 IN       DATE,
         lv_bkd_upto_amt_cr           IN OUT   NUMBER,
         lv_bkd_upto_amt_dr           IN OUT   NUMBER,
         lv_bkd_amt_today_cr          IN OUT   NUMBER,
         lv_bkd_amt_today_dr          IN OUT   NUMBER,
         lv_appl_upto_amt_cr          IN OUT   NUMBER,
         lv_appl_upto_amt_dr          IN OUT   NUMBER,
         lv_appl_amt_today_cr         IN OUT   NUMBER,
         lv_appl_amt_today_dr         IN OUT   NUMBER,
         lv_segment                   IN       VARCHAR2,
         lv_subsegment                IN       VARCHAR2,
         lv_freecode7                 IN       VARCHAR2,
         lv_rcreuserid                IN       VARCHAR2,
         lv_rcretime                  IN       DATE,
         lv_lchguserid                IN       VARCHAR2,
         lv_lchgtime                  IN       DATE,
         lv_bankid                    IN       VARCHAR2,
         out_rec                      OUT      VARCHAR2,
         lv_accr_penal_amt_today_dr   IN OUT   NUMBER,
         lv_bkd_penal_amt_today_dr    IN OUT   NUMBER,
         lv_appl_penal_amt_today_dr   IN OUT   NUMBER,
         lv_accr_penal_upto_dr        IN OUT   NUMBER,
         lv_bkd_penal_upto_dr         IN OUT   NUMBER,
         lv_appl_penal_upto_dr        IN OUT   NUMBER,
         lv_applamtdr_ovdu            IN OUT   NUMBER,
         lv_bkdamtdr_ovdu             IN       NUMBER,
         lv_accramtdr_ovdu            IN       NUMBER,
         lv_accruptodtcr              IN       DATE,
         lv_accruptodtdr       IN       DATE,
         lv_bkduptodtcr               IN       DATE,
         lv_bkduptodtdr        IN       DATE,
         lv_appltrandtcr              IN OUT   DATE,
         lv_appltrandtdr       IN OUT   DATE,
         lv_bkdtranidcr               IN OUT   VARCHAR2,
         lv_bkdtraniddr               IN OUT   VARCHAR2,
         lv_appltranidcr              IN OUT   VARCHAR2,
         lv_appltraniddr              IN OUT   VARCHAR2,
         lv_acctcrncy              IN       VARCHAR2,
         lv_prevdate              IN       DATE,
         lv_unique_id              IN       VARCHAR2
      )
      AS
         lv_penbacid             tbaadm.gam.bacid%TYPE;
         lv_penforacid           tbaadm.gam.foracid%TYPE;
         lv_bacid                tbaadm.gam.bacid%TYPE;
         lv_glacc                tbaadm.gam.foracid%TYPE;
         lv_trancount            NUMBER;
         lv_errmsg               VARCHAR2 (100);
         lv_pdflg                tbaadm.AIP.PAST_DUE_FLG%TYPE;
         lv_ptransrlnum          tbaadm.dtd.part_tran_srl_num%TYPE;
         lv_tranpart              tbaadm.dtd.tran_particular%TYPE;
         lv_tranamt               tbaadm.dtd.tran_amt%TYPE;
         lv_tranpart2             tbaadm.dtd.tran_particular_2%TYPE;
         lv_tranrmks              tbaadm.dtd.tran_rmks%TYPE;
         lv_ptrantype             tbaadm.dtd.part_tran_type%TYPE;
         lv_trancrncy             tbaadm.dtd.tran_crncy_code%TYPE;
         lv_credit_debit_ind         CHAR(1)              :='N';
         lv_glacid            tbaadm.gam.acid%type;
         lv_susp_bacid                    tbaadm.AIP.int_susp_bacid%type;
         lv_pen_susp_bacid        tbaadm.AIP.penal_int_susp_bacid%type;
         lv_pandl_bacid                tbaadm.gam.bacid%TYPE;
     lv_pandl_glacid            tbaadm.gam.acid%TYPE;
           lv_pandl_glacc             tbaadm.gam.foracid%TYPE;

      BEGIN
         --{
         out_rec :=out_rec|| ' lvcrdrflg:'|| lv_crdrflg;
         IF (lv_crdrflg != 'N')
         THEN
            --{
                      ------------------
                 --Fetching pd_flg
                 ------------------
                 BEGIN
             --{
                 select PAST_DUE_FLG,int_susp_bacid,penal_int_susp_bacid
                 into lv_pdflg,lv_susp_bacid,lv_pen_susp_bacid
                 from tbaadm.AIP, tbaadm.acd , tbaadm.gam
                 where acd.b2k_id = tbaadm.gam.acid
                 and tbaadm.gam.schm_code = tbaadm.AIP.schm_code
                 and tbaadm.AIP.MAIN_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.MAIN_CLASSIFICATION_SYSTEM,acd.MAIN_CLASSIFICATION_USER)
                 and tbaadm.AIP.SUB_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.SUB_CLASSIFICATION_SYSTEM,acd.SUB_CLASSIFICATION_USER)
                 and tbaadm.AIP.B2K_TYPE = 'ACCNT'
                 and acd.B2K_TYPE = 'ACCNT'
                 and tbaadm.AIP.del_flg !='Y'
                 and foracid = lv_foracid
                 and tbaadm.gam.bank_id = lv_bankid
                 and acd.bank_id = tbaadm.gam.bank_id
                 and tbaadm.AIP.bank_id = tbaadm.gam.bank_id;

                 EXCEPTION
                 WHEN NO_DATA_FOUND
                 THEN
                 lv_pdflg:='';
                 out_rec :=out_rec|| ' PD flg not fetched'|| lv_acid;

             --}
             END;

                 IF(lv_appltrandt is NULL)
            THEN
            --{
                lv_appltrandtdr:=lv_prevdate;
                lv_appltrandtcr:=lv_prevdate;
                BEGIN
                --{

                    select tran_id
                    into lv_appltranid
                    from tbaadm.int_adm
                    where tran_date=lv_prevdate
                    and acid=lv_acid
                    and bank_id=lv_bankid
                    and rownum<2;
                    lv_appltranidcr:=lv_appltranid;
                    lv_appltraniddr:=lv_appltranid;
                    EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                    out_rec :=out_rec|| ' INT_ADM query failed'|| lv_acid;

                --}
                END;
            --}
            END IF;



            -------------------------------------------------
            -- Checking whether credit interest applied today
          -------------------------------------------------
            IF(lv_appl_amt_today_cr!=0) THEN
            --{

                    IF(lv_appl_amt_today_cr>0)
                    THEN
                    --{
                        lv_credit_debit_ind:='C';
                    --}
                    ELSE
                    --{
                        lv_credit_debit_ind:='D';
                    --}
                    END IF;

                       BEGIN
                 --{

                     ---------------------------

                     -- Fetching int paid bacid

                     ---------------------------

                    SELECT int_paid_bacid

                    INTO lv_bacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                    AND p.bank_id = lv_bankid
                    AND p.schm_type = lv_schm_type;

                     -------------------------------------------------------------

                     -- Fetching account id for bacid.

                     -------------------------------------------------------------
                     SELECT foracid,acid
                     INTO lv_glacc,lv_glacid
                     FROM tbaadm.gam
                     WHERE bacid = lv_bacid
                     AND sol_id = lv_solid
                     AND acct_crncy_code = lv_acctcrncy
                     AND bank_id = lv_bankid;


                     EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                     out_rec :=out_rec|| ' tbaadm.gam  query didnt fetch any Record '|| lv_acid;

                     GOTO applnextrec;
              --}
                          END;
                    ----------------------------------------

            -- fetching tran details from tbaadm.dctd_acli

            ----------------------------------------
            BEGIN
               --{

                SELECT part_tran_srl_num, tran_particular, tran_amt,
                tran_particular_2, tran_rmks, part_tran_type,
                tran_crncy_code
                INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                lv_tranpart2, lv_tranrmks, lv_ptrantype,
                lv_trancrncy
                FROM tbaadm.dctd_acli
                WHERE tran_id = LPAD (lv_appltranidcr, 9)
                AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                AND tran_date = lv_appltrandtcr
                AND pstd_flg = 'Y'
                AND del_flg != 'Y'
                AND bank_id = lv_bankid
                AND ROWNUM < 2;


                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';

            --}
            END;


             -------------------------------------------------------------

              -- C_EIT insert

              -------------------------------------------------------------
              BEGIN
                 --{
                 INSERT INTO c_eit
                     (tran_date, bacid, gl_acct_no,
                      tran_id, part_tran_srl_num,
                      tran_amt,
                      tran_crncy,
                      part_tran_type,
                      tran_particular,
                      tran_particular_2,
                      tran_remarks, customer_account_no, sol_id,
                      schm_type, schm_code, eod_closing_balance,
                      eod_un_clr_bal_amt, eod_future_bal_amt,
                      eod_lien_amt, gl_sub_head_code,
                      int_coll_flag, int_paid_flag,
                      debit_credit_ind, interest_rate,
                      int_appl_flg, accrued_upto_date,
                      accrued_upto_amount,
                      accrued_amount_today,
                      booked_upto_date,
                      booked_upto_amount,
                      booked_amount_today,
                      applied_upto_date,
                      applied_upto_amount,
                      applied_amount_today,
                      SEGMENT, sub_segment, free_code_7,
                      rcre_user_id, rcre_time, lchg_user_id,
                      lchg_time, bank_id,unq_identifier
                     )
                  VALUES (lv_appltrandtcr, lv_bacid, lv_glacc,
                      lv_appltranidcr, lv_ptransrlnum,
                      lv_tranamt,
                      lv_trancrncy,
                      lv_ptrantype,
                      lv_tranpart,
                      lv_tranpart2,
                      lv_tranrmks, lv_foracid, lv_solid,
                      lv_schm_type, lv_schm_code, lv_eodbal,
                      lv_unclrbalamt, lv_futbalamt,
                      lv_lienamt, lv_glsub,
                      lv_intcollflg, lv_intpdflg,
                      DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                      lv_bkdappl_flg, lv_accruptodtcr,
                      lv_accr_upto_amt_cr,
                      lv_accr_amt_today_cr,
                      lv_bkduptodtcr,
                      lv_bkd_upto_amt_cr,
                      0,
                      lv_appltrandtcr,
                      lv_appl_upto_amt_cr,
                      abs(lv_appl_amt_today_cr),
                      lv_segment, lv_subsegment, lv_freecode7,
                      lv_rcreuserid, lv_rcretime, lv_lchguserid,
                      lv_lchgtime, lv_bankid,lv_unique_id
                     );


                 COMMIT;


              EXCEPTION
                 WHEN OTHERS
                 THEN
                 --DBMS_OUTPUT.put_line (SQLERRM);

                out_rec := out_rec || 'insert failed';
              --}
              END;


                 --}
                 END IF;

          ------------------------------------
          --Inserting the booked amount today
          ------------------------------------
          IF(lv_bkd_amt_today_cr!=0)
          THEN
          --{

               BEGIN
                 --{

                     ---------------------------

                     -- Fetching int paid bacid

                     ---------------------------

                    SELECT int_paid_bacid,int_pandl_bacid_cr

                    INTO lv_bacid,lv_pandl_bacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                    AND p.bank_id = lv_bankid
                    AND p.schm_type = lv_schm_type;

                     -------------------------------------------------------------

                     -- Fetching account id for bacid.

                     -------------------------------------------------------------
                     SELECT foracid,acid
                     INTO lv_glacc,lv_glacid
                     FROM tbaadm.gam
                     WHERE bacid = lv_bacid
                     AND sol_id = lv_solid
                     AND acct_crncy_code = lv_acctcrncy
                     AND bank_id = lv_bankid;

                     SELECT foracid,acid
                     INTO lv_pandl_glacc,lv_pandl_glacid
                     FROM tbaadm.gam
                     WHERE bacid = lv_pandl_bacid
                     AND sol_id = lv_solid
                     AND acct_crncy_code = lv_acctcrncy
                     AND bank_id = lv_bankid;

                     EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                     out_rec :=out_rec|| ' tbaadm.gam  query didnt fetch any Record '|| lv_acid;

                     GOTO applnextrec;
              --}
                          END;

            BEGIN
               --{
                IF(lv_bkd_amt_today_cr>0)
                THEN
                --{
                    lv_credit_debit_ind:='C';
                --}
                ELSE
                --{
                    lv_credit_debit_ind:='D';
                --}
                END IF;
                ----------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                  FROM tbaadm.dctd_acli
                  WHERE tran_id = LPAD (lv_bkdtranidcr, 9)
                  AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                  AND tran_date = lv_bkduptodtcr
                  AND pstd_flg = 'Y'
                  AND del_flg != 'Y'
                  AND bank_id = lv_bankid
                  AND ROWNUM < 2;


                --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';



            --}
            END;

            -------------------------------------------------------------

              -- C_EIT insert

              -------------------------------------------------------------
              BEGIN
                 --{
                 INSERT INTO c_eit
                     (tran_date, bacid, gl_acct_no,
                      tran_id, part_tran_srl_num,
                      tran_amt,
                      tran_crncy,
                      part_tran_type,
                      tran_particular,
                      tran_particular_2,
                      tran_remarks, customer_account_no, sol_id,
                      schm_type, schm_code, eod_closing_balance,
                      eod_un_clr_bal_amt, eod_future_bal_amt,
                      eod_lien_amt, gl_sub_head_code,
                      int_coll_flag, int_paid_flag,
                      debit_credit_ind, interest_rate,
                      int_appl_flg, accrued_upto_date,
                      accrued_upto_amount,
                      accrued_amount_today,
                      booked_upto_date,
                      booked_upto_amount,
                      booked_amount_today,
                      applied_upto_date,
                      applied_upto_amount,
                      applied_amount_today,
                      SEGMENT, sub_segment, free_code_7,
                      rcre_user_id, rcre_time, lchg_user_id,
                      lchg_time, bank_id,unq_identifier
                     )
                  VALUES (lv_bkduptodtcr, lv_bacid, lv_glacc,
                      lv_bkdtranidcr, lv_ptransrlnum,
                      lv_tranamt,
                      lv_trancrncy,
                      lv_ptrantype,
                      lv_tranpart,
                      lv_tranpart2,
                      lv_tranrmks, lv_foracid, lv_solid,
                      lv_schm_type, lv_schm_code, lv_eodbal,
                      lv_unclrbalamt, lv_futbalamt,
                      lv_lienamt, lv_glsub,
                      lv_intcollflg, lv_intpdflg,
                      DECODE(lv_credit_debit_ind,'C','C','D'), lv_intrate,
                      lv_bkdappl_flg, lv_accruptodtcr,
                      lv_accr_upto_amt_cr,
                      lv_accr_amt_today_cr,
                      lv_bkduptodtcr,
                      lv_bkd_upto_amt_cr,
                      abs(lv_bkd_amt_today_cr),
                      lv_appltrandtcr,
                      lv_appl_upto_amt_cr,
                      0,
                      lv_segment, lv_subsegment, lv_freecode7,
                      lv_rcreuserid, lv_rcretime, lv_lchguserid,
                      lv_lchgtime, lv_bankid,lv_unique_id
                     );
                     COMMIT;
                     BEGIN
                      --{
                        SELECT part_tran_srl_num, tran_particular, tran_amt,
                        tran_particular_2, tran_rmks, part_tran_type,
                        tran_crncy_code
                        INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                        lv_tranpart2, lv_tranrmks, lv_ptrantype,
                        lv_trancrncy
                        FROM tbaadm.dctd_acli
                        WHERE tran_id = LPAD (lv_bkdtranidcr, 9)
                        AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                         OR (acid = lv_pandl_glacid))
                        AND tran_date = lv_bkduptodtcr
                        AND pstd_flg = 'Y'
                        AND del_flg != 'Y'
                        AND bank_id = lv_bankid
                        AND ROWNUM < 2;
                       EXCEPTION
                       WHEN NO_DATA_FOUND
                       THEN
                       NULL;
                      --}
                      END;

                     INSERT INTO c_eit
                     (tran_date, bacid, gl_acct_no,
                      tran_id, part_tran_srl_num,
                      tran_amt,
                      tran_crncy,
                      part_tran_type,
                      tran_particular,
                      tran_particular_2,
                      tran_remarks, customer_account_no, sol_id,
                      schm_type, schm_code, eod_closing_balance,
                      eod_un_clr_bal_amt, eod_future_bal_amt,
                      eod_lien_amt, gl_sub_head_code,
                      int_coll_flag, int_paid_flag,
                      debit_credit_ind, interest_rate,
                      int_appl_flg, accrued_upto_date,
                      accrued_upto_amount,
                      accrued_amount_today,
                      booked_upto_date,
                      booked_upto_amount,
                      booked_amount_today,
                      applied_upto_date,
                      applied_upto_amount,
                      applied_amount_today,
                      SEGMENT, sub_segment, free_code_7,
                      rcre_user_id, rcre_time, lchg_user_id,
                      lchg_time, bank_id,unq_identifier
                     )
                    VALUES (lv_bkduptodtcr, lv_pandl_bacid, lv_pandl_glacc,
                      lv_bkdtranidcr, lv_ptransrlnum,
                      lv_tranamt,
                      lv_trancrncy,
                      lv_ptrantype,
                      lv_tranpart,
                      lv_tranpart2,
                      lv_tranrmks, lv_foracid, lv_solid,
                      lv_schm_type, lv_schm_code, lv_eodbal,
                      lv_unclrbalamt, lv_futbalamt,
                      lv_lienamt, lv_glsub,
                      lv_intcollflg, lv_intpdflg,
                      DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                      lv_bkdappl_flg, lv_accruptodtcr,
                      lv_accr_upto_amt_cr,
                      lv_accr_amt_today_cr,
                      lv_bkduptodtcr,
                      lv_bkd_upto_amt_cr,
                      abs(lv_bkd_amt_today_cr),
                      lv_appltrandtcr,
                      lv_appl_upto_amt_cr,
                      0,
                      lv_segment, lv_subsegment, lv_freecode7,
                      lv_rcreuserid, lv_rcretime, lv_lchguserid,
                      lv_lchgtime, lv_bankid,lv_unique_id
                     );



                 COMMIT;


              EXCEPTION
                 WHEN OTHERS
                 THEN
                 --DBMS_OUTPUT.put_line (SQLERRM);

                out_rec := out_rec || 'insert failed';
              --}
            END;

          --}
          END IF;

                <<applnextrec>>
                out_rec := out_rec || '| Fetch next rec |';



            IF((lv_appl_amt_today_dr !=0) OR (lv_appl_penal_amt_today_dr !=0) OR (lv_bkd_penal_amt_today_dr!=0) OR (lv_bkd_amt_today_dr!=0)) THEN
            --{



                IF((lv_appl_amt_today_dr!=0) OR (lv_bkd_amt_today_dr!=0))
                THEN
                --{

                    IF(lv_appl_amt_today_dr>0)
                    THEN
                    --{
                        lv_credit_debit_ind:='D';
                    --}
                    ELSE
                    --{
                        lv_credit_debit_ind:='C';
                    --}
                    END IF;

                    BEGIN
                     --{

                        -----------------------------------------------------------
                        --Checking the past due flag in GAC table and
                        --deriving past_due_int_coll_bacid
                        -----------------------------------------------------------

                        IF(lv_pdflg='Y') THEN
                          --{
                            SELECT PAST_DUE_INT_COLL_BACID
                            INTO lv_bacid
                            FROM tbaadm.gsp p
                            WHERE p.schm_code = lv_schm_code
                            AND p.bank_id = lv_bankid
                            AND p.schm_type = lv_schm_type;

                            lv_pandl_bacid:=lv_susp_bacid;


                         --}
                         ELSE
                         --{
                            SELECT int_coll_bacid,int_pandl_bacid_dr

                            INTO lv_bacid,lv_pandl_bacid
                            FROM tbaadm.gsp p
                            WHERE p.schm_code = lv_schm_code
                            AND p.bank_id = lv_bankid
                            AND p.schm_type = lv_schm_type;
                         --}
                         END IF;


                        -------------------------------------------------------------

                        -- Fetching account id for bacid.

                        -------------------------------------------------------------
                             SELECT foracid,acid
                             INTO lv_glacc,lv_glacid
                             FROM tbaadm.gam
                             WHERE bacid = lv_bacid
                             AND sol_id = lv_solid
                             AND acct_crncy_code = lv_acctcrncy
                             AND bank_id = lv_bankid;

                             SELECT foracid,acid
                             INTO lv_pandl_glacc,lv_pandl_glacid
                             FROM tbaadm.gam
                             WHERE bacid = lv_pandl_bacid
                             AND sol_id = lv_solid
                             AND acct_crncy_code = lv_acctcrncy
                             AND bank_id = lv_bankid;
                      EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                      out_rec :=out_rec|| ' tbaadm.gam  query didnt fetch any Record '|| lv_acid;

                      GOTO applnextrec2;


                      --}
                      END;


                    ----------------------------------------

                    -- fetching tran details from tbaadm.dctd_acli

                    ----------------------------------------
                    BEGIN
                       --{

                        SELECT part_tran_srl_num, tran_particular, tran_amt,
                        tran_particular_2, tran_rmks, part_tran_type,
                        tran_crncy_code
                        INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                        lv_tranpart2, lv_tranrmks, lv_ptrantype,
                        lv_trancrncy
                        FROM tbaadm.dctd_acli
                        WHERE tran_id = LPAD (lv_appltraniddr, 9)
                        AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                         OR (acid = lv_glacid))
                        AND tran_date = lv_appltrandtdr
                        AND pstd_flg = 'Y'
                        AND del_flg != 'Y'
                        AND bank_id = lv_bankid
                        AND ROWNUM < 2;


                        --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltraniddr;
                           lv_ptransrlnum:='';
                           lv_tranpart:='';
                           lv_tranamt:='';
                           lv_tranpart2:='';
                           lv_tranrmks:='';
                           lv_ptrantype:='';
                           lv_trancrncy:='';

                    --}
                    END;

                  out_rec := out_rec || '| BEFORE INSERT|';

                    IF(lv_appl_amt_today_dr!=0)
                    THEN
                    --{
                         ---------------------
                          -- C_EIT insert

                          ---------------------
                          BEGIN
                             --{
                             INSERT INTO c_eit
                                 (tran_date, bacid, gl_acct_no,
                                  tran_id, part_tran_srl_num,
                                  tran_amt,
                                  tran_crncy,
                                  part_tran_type,
                                  tran_particular,
                                  tran_particular_2,
                                  tran_remarks, customer_account_no, sol_id,
                                  schm_type, schm_code, eod_closing_balance,
                                  eod_un_clr_bal_amt, eod_future_bal_amt,
                                  eod_lien_amt, gl_sub_head_code,
                                  int_coll_flag, int_paid_flag,
                                  debit_credit_ind, interest_rate,
                                  int_appl_flg, accrued_upto_date,
                                  accrued_upto_amount,
                                  accrued_amount_today,
                                  booked_upto_date,
                                  booked_upto_amount,
                                  booked_amount_today,
                                  applied_upto_date,
                                  applied_upto_amount,
                                  applied_amount_today,
                                  SEGMENT, sub_segment, free_code_7,
                                  rcre_user_id, rcre_time, lchg_user_id,
                                  lchg_time, bank_id,unq_identifier
                                 )
                              VALUES (lv_appltrandtdr, lv_bacid, lv_glacc,
                                  lv_appltraniddr, lv_ptransrlnum,
                                  lv_tranamt,
                                  lv_trancrncy,
                                  lv_ptrantype,
                                  lv_tranpart,
                                  lv_tranpart2,
                                  lv_tranrmks, lv_foracid, lv_solid,
                                  lv_schm_type, lv_schm_code, lv_eodbal,
                                  lv_unclrbalamt, lv_futbalamt,
                                  lv_lienamt, lv_glsub,
                                  lv_intcollflg, lv_intpdflg,
                                  DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                                  lv_bkdappl_flg, lv_accruptodtdr,
                                  lv_accr_upto_amt_dr,
                                  lv_accr_amt_today_dr,
                                  lv_bkduptodtdr,
                                  lv_bkd_upto_amt_dr,
                                  0,
                                  lv_appltrandtdr,
                                  lv_appl_upto_amt_dr,
                                  abs(lv_appl_amt_today_dr),
                                  lv_segment, lv_subsegment, lv_freecode7,
                                  lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                  lv_lchgtime, lv_bankid,lv_unique_id
                                 );

                             COMMIT;


                          EXCEPTION
                             WHEN OTHERS
                             THEN

                            out_rec := out_rec || 'insert failed';
                          --}
                              END;
                    --}
                    END IF;



                                  ------------------------------------
                                  --Inserting the booked amount today
                                  ------------------------------------
                                  IF(lv_bkd_amt_today_dr!=0)
                                  THEN
                                  --{
                    BEGIN
                    --{
                        IF(lv_bkd_amt_today_dr>0)
                        THEN
                        --{
                            lv_credit_debit_ind:='D';
                        --}
                        ELSE
                        --{
                            lv_credit_debit_ind:='C';
                        --}
                        END IF;
                        ----------------------------------------

                        -- fetching tran details from tbaadm.dctd_acli

                        ----------------------------------------

                           SELECT part_tran_srl_num, tran_particular, tran_amt,
                              tran_particular_2, tran_rmks, part_tran_type,
                              tran_crncy_code
                         INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                              lv_tranpart2, lv_tranrmks, lv_ptrantype,
                              lv_trancrncy
                          FROM tbaadm.dctd_acli
                          WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                          AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                           OR (acid = lv_glacid))
                          AND tran_date = lv_bkduptodtdr
                          AND pstd_flg = 'Y'
                          AND del_flg != 'Y'
                          AND bank_id = lv_bankid
                          AND ROWNUM < 2;


                       -- out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                           lv_ptransrlnum:='';
                           lv_tranpart:='';
                           lv_tranamt:='';
                           lv_tranpart2:='';
                           lv_tranrmks:='';
                           lv_ptrantype:='';
                           lv_trancrncy:='';



                    --}
                    END;

                     ---------------------
                       -- C_EIT insert

                      ---------------------
                      BEGIN
                         --{
                         INSERT INTO c_eit
                             (tran_date, bacid, gl_acct_no,
                              tran_id, part_tran_srl_num,
                              tran_amt,
                              tran_crncy,
                              part_tran_type,
                              tran_particular,
                              tran_particular_2,
                              tran_remarks, customer_account_no, sol_id,
                              schm_type, schm_code, eod_closing_balance,
                              eod_un_clr_bal_amt, eod_future_bal_amt,
                              eod_lien_amt, gl_sub_head_code,
                              int_coll_flag, int_paid_flag,
                              debit_credit_ind, interest_rate,
                              int_appl_flg, accrued_upto_date,
                              accrued_upto_amount,
                              accrued_amount_today,
                              booked_upto_date,
                              booked_upto_amount,
                              booked_amount_today,
                              applied_upto_date,
                              applied_upto_amount,
                              applied_amount_today,
                              SEGMENT, sub_segment, free_code_7,
                              rcre_user_id, rcre_time, lchg_user_id,
                              lchg_time, bank_id,unq_identifier
                             )
                          VALUES (lv_bkduptodtdr, lv_bacid, lv_glacc,
                              lv_bkdtraniddr, lv_ptransrlnum,
                              lv_tranamt,
                              lv_trancrncy,
                              lv_ptrantype,
                              lv_tranpart,
                              lv_tranpart2,
                              lv_tranrmks, lv_foracid, lv_solid,
                              lv_schm_type, lv_schm_code, lv_eodbal,
                              lv_unclrbalamt, lv_futbalamt,
                              lv_lienamt, lv_glsub,
                              lv_intcollflg, lv_intpdflg,
                              DECODE(lv_credit_debit_ind,'C','C','D'), lv_intrate,
                              lv_bkdappl_flg, lv_accruptodtdr,
                              lv_accr_upto_amt_dr,
                              lv_accr_amt_today_dr,
                              lv_bkduptodtdr,
                              lv_bkd_upto_amt_dr,
                              abs(lv_bkd_amt_today_dr),
                              lv_appltrandtdr,
                              lv_appl_upto_amt_dr,
                              0,
                              lv_segment, lv_subsegment, lv_freecode7,
                              lv_rcreuserid, lv_rcretime, lv_lchguserid,
                              lv_lchgtime, lv_bankid,lv_unique_id
                             );
                             COMMIT;

                            BEGIN
                              --{
                                SELECT part_tran_srl_num, tran_particular, tran_amt,
                                tran_particular_2, tran_rmks, part_tran_type,
                                tran_crncy_code
                                INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                                lv_tranpart2, lv_tranrmks, lv_ptrantype,
                                lv_trancrncy
                                FROM tbaadm.dctd_acli
                                WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                                AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                                 OR (acid = lv_pandl_glacid))
                                AND tran_date = lv_bkduptodtdr
                                AND pstd_flg = 'Y'
                                AND del_flg != 'Y'
                                AND bank_id = lv_bankid
                                AND ROWNUM < 2;
                               EXCEPTION
                               WHEN NO_DATA_FOUND
                               THEN
                               NULL;
                              --}
                            END;

                            INSERT INTO c_eit
                             (tran_date, bacid, gl_acct_no,
                              tran_id, part_tran_srl_num,
                              tran_amt,
                              tran_crncy,
                              part_tran_type,
                              tran_particular,
                              tran_particular_2,
                              tran_remarks, customer_account_no, sol_id,
                              schm_type, schm_code, eod_closing_balance,
                              eod_un_clr_bal_amt, eod_future_bal_amt,
                              eod_lien_amt, gl_sub_head_code,
                              int_coll_flag, int_paid_flag,
                              debit_credit_ind, interest_rate,
                              int_appl_flg, accrued_upto_date,
                              accrued_upto_amount,
                              accrued_amount_today,
                              booked_upto_date,
                              booked_upto_amount,
                              booked_amount_today,
                              applied_upto_date,
                              applied_upto_amount,
                              applied_amount_today,
                              SEGMENT, sub_segment, free_code_7,
                              rcre_user_id, rcre_time, lchg_user_id,
                              lchg_time, bank_id,unq_identifier
                             )
                            VALUES (lv_bkduptodtdr, lv_pandl_bacid, lv_pandl_glacc,
                              lv_bkdtraniddr, lv_ptransrlnum,
                              lv_tranamt,
                              lv_trancrncy,
                              lv_ptrantype,
                              lv_tranpart,
                              lv_tranpart2,
                              lv_tranrmks, lv_foracid, lv_solid,
                              lv_schm_type, lv_schm_code, lv_eodbal,
                              lv_unclrbalamt, lv_futbalamt,
                              lv_lienamt, lv_glsub,
                              lv_intcollflg, lv_intpdflg,
                              DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                              lv_bkdappl_flg, lv_accruptodtdr,
                              lv_accr_upto_amt_dr,
                              lv_accr_amt_today_dr,
                              lv_bkduptodtdr,
                              lv_bkd_upto_amt_dr,
                              abs(lv_bkd_amt_today_dr),
                              lv_appltrandtdr,
                              lv_appl_upto_amt_dr,
                              0,
                              lv_segment, lv_subsegment, lv_freecode7,
                              lv_rcreuserid, lv_rcretime, lv_lchguserid,
                              lv_lchgtime, lv_bankid,lv_unique_id
                                 );


                         COMMIT;


                      EXCEPTION
                         WHEN OTHERS
                         THEN


                        out_rec := out_rec || 'insert failed';
                      --}
                    END;


                                      --}
                                      END IF;
                --}
                END IF;



                                  IF((lv_appl_penal_amt_today_dr!=0) OR (lv_bkd_penal_amt_today_dr!=0))
                                  THEN
                                  --{
                                      IF(lv_appl_penal_amt_today_dr>0)
                    THEN
                    --{
                        lv_credit_debit_ind:='D';
                    --}
                    ELSE
                    --{
                        lv_credit_debit_ind:='C';
                    --}
                    END IF;

                    BEGIN
                    --{
                         IF(lv_pdflg='Y') THEN
                         --{
                            SELECT PAST_DUE_PENAL_INT_COLL_BACID
                            INTO lv_penbacid
                            FROM tbaadm.gsp p
                            WHERE p.schm_code = lv_schm_code
                            AND p.bank_id = lv_bankid
                            AND p.schm_type = lv_schm_type;

                            lv_pandl_bacid:=lv_pen_susp_bacid;
                          --}
                          ELSE
                          --{
                            SELECT pen_coll_bacid,penal_pandl_bacid
                            INTO lv_penbacid,lv_pandl_bacid
                            FROM tbaadm.gsp p
                            WHERE p.schm_code = lv_schm_code
                            AND p.bank_id = lv_bankid;
                          --}
                          END IF;


                            SELECT foracid,acid
                            INTO lv_penforacid,lv_glacid
                            FROM tbaadm.gam
                            WHERE bacid = lv_penbacid
                            AND sol_id = lv_solid
                            AND acct_crncy_code = lv_acctcrncy
                            AND bank_id = lv_bankid;

                            SELECT foracid,acid
                            INTO lv_pandl_glacc,lv_pandl_glacid
                            FROM tbaadm.gam
                            WHERE bacid = lv_pandl_bacid
                            AND sol_id = lv_solid
                            AND acct_crncy_code = lv_acctcrncy
                            AND bank_id = lv_bankid;

                            ----------------------------------------------------------

                            --Assigning penal interest amount
                            --to normal interest variable for data insertion purposes.

                            ----------------------------------------------------------
                            lv_bacid := lv_penbacid;
                            lv_glacc := lv_penforacid;


                         EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                         out_rec :=out_rec|| ' Penal int bacid not present '|| lv_acid;
                         GOTO applnextrec2;
                     --}
                                         END;
                    ----------------------------------------

                    -- fetching tran details from tbaadm.dctd_acli

                    ----------------------------------------
                    BEGIN
                       --{

                        SELECT part_tran_srl_num, tran_particular, tran_amt,
                        tran_particular_2, tran_rmks, part_tran_type,
                        tran_crncy_code
                        INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                        lv_tranpart2, lv_tranrmks, lv_ptrantype,
                        lv_trancrncy
                        FROM tbaadm.dctd_acli
                        WHERE tran_id = LPAD (lv_appltraniddr, 9)
                        AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                         OR (acid = lv_glacid))
                        AND tran_date = lv_appltrandtdr
                        AND pstd_flg = 'Y'
                        AND del_flg != 'Y'
                        AND bank_id = lv_bankid
                        AND ROWNUM < 2;


                        --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                           lv_ptransrlnum:='';
                           lv_tranpart:='';
                           lv_tranamt:='';
                           lv_tranpart2:='';
                           lv_tranrmks:='';
                           lv_ptrantype:='';
                           lv_trancrncy:='';

                    --}
                    END;

                                      IF(lv_appl_penal_amt_today_dr!=0)
                                      THEN
                                      --{
                                            ---------------------
                           -- C_EIT insert

                           ---------------------
                           lv_tranpart:='Penal Interest';
                           BEGIN
                              --{
                              INSERT INTO c_eit
                                  (tran_date, bacid, gl_acct_no,
                                   tran_id, part_tran_srl_num,
                                   tran_amt,
                                   tran_crncy,
                                   part_tran_type,
                                   tran_particular,
                                   tran_particular_2,
                                   tran_remarks, customer_account_no, sol_id,
                                   schm_type, schm_code, eod_closing_balance,
                                   eod_un_clr_bal_amt, eod_future_bal_amt,
                                   eod_lien_amt, gl_sub_head_code,
                                   int_coll_flag, int_paid_flag,
                                   debit_credit_ind, interest_rate,
                                   int_appl_flg, accrued_upto_date,
                                   accrued_upto_amount,
                                   accrued_amount_today,
                                   booked_upto_date,
                                   booked_upto_amount,
                                   booked_amount_today,
                                   applied_upto_date,
                                   applied_upto_amount,
                                   applied_amount_today,
                                   SEGMENT, sub_segment, free_code_7,
                                   rcre_user_id, rcre_time, lchg_user_id,
                                   lchg_time, bank_id,unq_identifier
                                  )
                               VALUES (lv_appltrandtdr, lv_bacid, lv_glacc,
                                   lv_appltraniddr,  lv_ptransrlnum,
                                   lv_tranamt,
                                   lv_trancrncy,
                                   lv_ptrantype,
                                   lv_tranpart,
                                   lv_tranpart2,
                                   lv_tranrmks, lv_foracid, lv_solid,
                                   lv_schm_type, lv_schm_code, lv_eodbal,
                                   lv_unclrbalamt, lv_futbalamt,
                                   lv_lienamt, lv_glsub,
                                   lv_intcollflg, lv_intpdflg,
                                   DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                                   lv_bkdappl_flg, lv_accruptodtdr,
                                   lv_accr_penal_upto_dr,
                                   lv_accr_penal_amt_today_dr,
                                   lv_bkduptodtdr,
                                   lv_bkd_penal_upto_dr,
                                   0,
                                   lv_appltrandtdr,
                                   lv_appl_penal_upto_dr,
                                   abs(lv_appl_penal_amt_today_dr),
                                   lv_segment, lv_subsegment, lv_freecode7,
                                   lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                   lv_lchgtime, lv_bankid,lv_unique_id
                                  );

                              COMMIT;

                           EXCEPTION
                              WHEN OTHERS
                              THEN

                             out_rec := out_rec || 'insert failed';
                           --}
                          END;
                                      --}
                                      END IF;



                      --------------------------------------
                      --Inserting booked penal amount today
                      --------------------------------------
                      IF(lv_bkd_penal_amt_today_dr!=0)
                      THEN
                      --{

                        BEGIN
                        --{
                            IF(lv_bkd_penal_amt_today_dr>0)
                            THEN
                            --{
                                lv_credit_debit_ind:='D';
                            --}
                            ELSE
                            --{
                                lv_credit_debit_ind:='C';
                            --}
                            END IF;

                            ----------------------------------------

                            -- fetching tran details from tbaadm.dctd_acli

                            ----------------------------------------

                               SELECT part_tran_srl_num, tran_particular, tran_amt,
                                  tran_particular_2, tran_rmks, part_tran_type,
                                  tran_crncy_code
                             INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                                  lv_tranpart2, lv_tranrmks, lv_ptrantype,
                                  lv_trancrncy
                              FROM tbaadm.dctd_acli
                              WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                              AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                               OR (acid = lv_glacid))
                              AND tran_date = lv_bkduptodtdr
                              AND pstd_flg = 'Y'
                              AND del_flg != 'Y'
                              AND bank_id = lv_bankid
                              AND ROWNUM < 2;


                            --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                         EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                               --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_appltranid;
                               lv_ptransrlnum:='';
                               lv_tranpart:='';
                               lv_tranamt:='';
                               lv_tranpart2:='';
                               lv_tranrmks:='';
                               lv_ptrantype:='';
                               lv_trancrncy:='';

                        --}
                        END;

                         ---------------------
                           -- C_EIT insert

                           ---------------------
                           lv_tranpart:='Penal Interest';
                           BEGIN
                              --{
                              INSERT INTO c_eit
                                  (tran_date, bacid, gl_acct_no,
                                   tran_id, part_tran_srl_num,
                                   tran_amt,
                                   tran_crncy,
                                   part_tran_type,
                                   tran_particular,
                                   tran_particular_2,
                                   tran_remarks, customer_account_no, sol_id,
                                   schm_type, schm_code, eod_closing_balance,
                                   eod_un_clr_bal_amt, eod_future_bal_amt,
                                   eod_lien_amt, gl_sub_head_code,
                                   int_coll_flag, int_paid_flag,
                                   debit_credit_ind, interest_rate,
                                   int_appl_flg, accrued_upto_date,
                                   accrued_upto_amount,
                                   accrued_amount_today,
                                   booked_upto_date,
                                   booked_upto_amount,
                                   booked_amount_today,
                                   applied_upto_date,
                                   applied_upto_amount,
                                   applied_amount_today,
                                   SEGMENT, sub_segment, free_code_7,
                                   rcre_user_id, rcre_time, lchg_user_id,
                                   lchg_time, bank_id,unq_identifier
                                  )
                               VALUES (lv_bkduptodtdr, lv_bacid, lv_glacc,
                                   lv_bkdtraniddr,  lv_ptransrlnum,
                                   lv_tranamt,
                                   lv_trancrncy,
                                   lv_ptrantype,
                                   lv_tranpart,
                                   lv_tranpart2,
                                   lv_tranrmks, lv_foracid, lv_solid,
                                   lv_schm_type, lv_schm_code, lv_eodbal,
                                   lv_unclrbalamt, lv_futbalamt,
                                   lv_lienamt, lv_glsub,
                                   lv_intcollflg, lv_intpdflg,
                                   DECODE(lv_credit_debit_ind,'C','C','D'), lv_intrate,
                                   lv_bkdappl_flg, lv_accruptodtdr,
                                   lv_accr_penal_upto_dr,
                                   lv_accr_penal_amt_today_dr,
                                   lv_bkduptodtdr,
                                   lv_bkd_penal_upto_dr,
                                   abs(lv_bkd_penal_amt_today_dr),
                                   lv_appltrandtdr,
                                   lv_appl_penal_upto_dr,
                                   0,
                                   lv_segment, lv_subsegment, lv_freecode7,
                                   lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                   lv_lchgtime, lv_bankid,lv_unique_id
                                  );
                                  COMMIT;

                                  BEGIN
                                  --{
                                    SELECT part_tran_srl_num, tran_particular, tran_amt,
                                    tran_particular_2, tran_rmks, part_tran_type,
                                    tran_crncy_code
                                    INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                                    lv_tranpart2, lv_tranrmks, lv_ptrantype,
                                    lv_trancrncy
                                    FROM tbaadm.dctd_acli
                                    WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                                    AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                                     OR (acid = lv_pandl_glacid))
                                    AND tran_date = lv_bkduptodtdr
                                    AND pstd_flg = 'Y'
                                    AND del_flg != 'Y'
                                    AND bank_id = lv_bankid
                                    AND ROWNUM < 2;
                                   EXCEPTION
                                   WHEN NO_DATA_FOUND
                                   THEN
                                   NULL;
                                  --}
                                END;

                                INSERT INTO c_eit
                              (tran_date, bacid, gl_acct_no,
                               tran_id, part_tran_srl_num,
                               tran_amt,
                               tran_crncy,
                               part_tran_type,
                               tran_particular,
                               tran_particular_2,
                               tran_remarks, customer_account_no, sol_id,
                               schm_type, schm_code, eod_closing_balance,
                               eod_un_clr_bal_amt, eod_future_bal_amt,
                               eod_lien_amt, gl_sub_head_code,
                               int_coll_flag, int_paid_flag,
                               debit_credit_ind, interest_rate,
                               int_appl_flg, accrued_upto_date,
                               accrued_upto_amount,
                               accrued_amount_today,
                               booked_upto_date,
                               booked_upto_amount,
                               booked_amount_today,
                               applied_upto_date,
                               applied_upto_amount,
                               applied_amount_today,
                               SEGMENT, sub_segment, free_code_7,
                               rcre_user_id, rcre_time, lchg_user_id,
                               lchg_time, bank_id,unq_identifier
                              )
                           VALUES (lv_bkduptodtdr, lv_pandl_bacid, lv_pandl_glacc,
                               lv_bkdtraniddr,  lv_ptransrlnum,
                               lv_tranamt,
                               lv_trancrncy,
                               lv_ptrantype,
                               lv_tranpart,
                               lv_tranpart2,
                               lv_tranrmks, lv_foracid, lv_solid,
                               lv_schm_type, lv_schm_code, lv_eodbal,
                               lv_unclrbalamt, lv_futbalamt,
                               lv_lienamt, lv_glsub,
                               lv_intcollflg, lv_intpdflg,
                               DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                               lv_bkdappl_flg, lv_accruptodtdr,
                               lv_accr_penal_upto_dr,
                               lv_accr_penal_amt_today_dr,
                               lv_bkduptodtdr,
                               lv_bkd_penal_upto_dr,
                               abs(lv_bkd_penal_amt_today_dr),
                               lv_appltrandtdr,
                               lv_appl_penal_upto_dr,
                               0,
                               lv_segment, lv_subsegment, lv_freecode7,
                               lv_rcreuserid, lv_rcretime, lv_lchguserid,
                               lv_lchgtime, lv_bankid,lv_unique_id
                              );



                              COMMIT;


                           EXCEPTION
                              WHEN OTHERS
                              THEN

                             out_rec := out_rec || 'insert failed';
                           --}
                        END;



                      --}
                      END IF;

                                  --}
                                  END IF;

                                  <<applnextrec2>>
                                  out_rec := out_rec || '| Fetch next rec |';


            --}
            END IF;



         --}
         END IF;
   END c_eit_appl_tran_fetch_proc_oda;

   PROCEDURE c_eit_book_tran_fetch_proc (
            lv_bkduptodt                IN       DATE,
           lv_bkdtranid                IN       VARCHAR2,
           lv_acctcrncy                IN       VARCHAR2,
           lv_foracid                  IN       VARCHAR2,
           lv_solid                    IN       VARCHAR2,
           lv_schm_type                IN       VARCHAR2,
           lv_schm_code                IN       VARCHAR2,
           lv_eodbal                   IN       NUMBER,
           lv_unclrbalamt              IN       NUMBER,
           lv_futbalamt                IN       NUMBER,
           lv_lienamt                  IN       NUMBER,
           lv_glsub                    IN       VARCHAR2,
           lv_intcollflg               IN       CHAR,
           lv_intpdflg                 IN       CHAR,
           lv_crdrflg                  IN       CHAR,
           lv_intrate                  IN       NUMBER,
           lv_bkdappl_flg              IN       CHAR,
           lv_accruptodt               IN       DATE,
           lv_accr_upto_amt_cr         IN OUT   NUMBER,
           lv_accr_upto_amt_dr         IN OUT   NUMBER,
           lv_accr_amt_today_cr        IN OUT   NUMBER,
           lv_accr_amt_today_dr        IN OUT   NUMBER,
           lv_bkd_upto_amt_cr          IN OUT   NUMBER,
           lv_bkd_upto_amt_dr          IN OUT   NUMBER,
           lv_bkd_amt_today_cr         IN OUT   NUMBER,
           lv_bkd_amt_today_dr         IN OUT   NUMBER,
           lv_appltrandt               IN       DATE,
           lv_appl_upto_amt_cr         IN OUT   NUMBER,
           lv_appl_upto_amt_dr         IN OUT   NUMBER,
           lv_appl_amt_today_cr        IN OUT   NUMBER,
           lv_appl_amt_today_dr        IN OUT   NUMBER,
           lv_segment                  IN       VARCHAR2,
           lv_subsegment               IN       VARCHAR2,
           lv_freecode7                IN       VARCHAR2,
           lv_rcreuserid               IN       VARCHAR2,
           lv_rcretime                 IN       DATE,
           lv_lchguserid               IN       VARCHAR2,
           lv_lchgtime                 IN       DATE,
           lv_bankid                   IN       VARCHAR2,
           out_rec                     OUT      VARCHAR2,
           lv_bkdamtdr_ovdu                IN       NUMBER,
           lv_applamtdr_ovdu               IN       NUMBER,
           lv_accramtdr_ovdu               IN       NUMBER,
           lv_bkd_penal_amt_today_dr       IN       NUMBER,
           lv_accr_penal_amt_today_dr      IN       NUMBER,
           lv_appl_penal_amt_today_dr      IN       NUMBER,
           lv_accr_penal_upto_dr           IN       NUMBER,
           lv_bkd_penal_upto_dr            IN       NUMBER,
           lv_appl_penal_upto_dr           IN       NUMBER,
           lv_acid                         IN       VARCHAR2,
           lv_unique_id                 IN      VARCHAR2
   )
   AS
      lv_bacid                 tbaadm.gam.bacid%TYPE;
      lv_glacid                tbaadm.gam.acid%TYPE;
      lv_glacc                 tbaadm.gam.foracid%TYPE;
      lv_ptransrlnum           tbaadm.dtd.part_tran_srl_num%TYPE;
      lv_tranpart              tbaadm.dtd.tran_particular%TYPE;
      lv_tranamt               tbaadm.dtd.tran_amt%TYPE;
      lv_tranpart2             tbaadm.dtd.tran_particular_2%TYPE;
      lv_tranrmks              tbaadm.dtd.tran_rmks%TYPE;
      lv_ptrantype             tbaadm.dtd.part_tran_type%TYPE;
      lv_trancrncy             tbaadm.dtd.tran_crncy_code%TYPE;
      lv_errmsg                VARCHAR2 (100);
      lv_trancount            NUMBER;
      lv_pdflg                tbaadm.AIP.PAST_DUE_FLG%TYPE;
      lv_credit_debit_ind     CHAR(1)        :='N';
      lv_pandl_bacid            tbaadm.gam.bacid%TYPE;
      lv_pandl_glacid            tbaadm.gam.acid%TYPE;
      lv_pandl_glacc             tbaadm.gam.foracid%TYPE;
      lv_susp_bacid        tbaadm.gam.bacid%TYPE;
      lv_pen_susp_bacid        tbaadm.gam.bacid%TYPE;

   BEGIN
      --{
      IF (lv_crdrflg != 'N')
      THEN
               ------------------
         --Fetching pd_flg
         ------------------
         BEGIN
         --{

            select PAST_DUE_FLG,int_susp_bacid,penal_int_susp_bacid
             into lv_pdflg,lv_susp_bacid,lv_pen_susp_bacid
             from tbaadm.AIP, tbaadm.acd , tbaadm.gam
             where acd.b2k_id = tbaadm.gam.acid
             and tbaadm.gam.schm_code = tbaadm.AIP.schm_code
             and tbaadm.AIP.MAIN_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.MAIN_CLASSIFICATION_SYSTEM,acd.MAIN_CLASSIFICATION_USER)
             and tbaadm.AIP.SUB_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.SUB_CLASSIFICATION_SYSTEM,acd.SUB_CLASSIFICATION_USER)
             and tbaadm.AIP.B2K_TYPE = 'ACCNT'
             and acd.B2K_TYPE = 'ACCNT'
             and tbaadm.AIP.del_flg !='Y'
             and foracid = lv_foracid
             and tbaadm.gam.bank_id = lv_bankid
             and acd.bank_id = tbaadm.gam.bank_id
             and tbaadm.AIP.bank_id = tbaadm.gam.bank_id;


             EXCEPTION
             WHEN NO_DATA_FOUND
             THEN
             lv_pdflg:='';
             lv_susp_bacid:='';
             lv_pen_susp_bacid:='';

             out_rec :=out_rec|| ' PD flg not fetched'|| lv_acid;

           --}
               END;

               IF((lv_bkd_amt_today_cr!=0) OR (lv_bkd_amt_today_dr!=0))
               THEN
               --{
                            BEGIN
                     --{
                    -------------------------------------------------------------

                    -- Fetching payable/receivable bacid for account.

                    -------------------------------------------------------------

                    SELECT DECODE (lv_crdrflg,
                          'C', int_paid_bacid,
                          int_coll_bacid
                         ),DECODE (lv_crdrflg,
                          'C', int_pandl_bacid_cr,
                          int_pandl_bacid_dr
                         )
                    INTO lv_bacid,lv_pandl_bacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                    AND p.bank_id = lv_bankid
                    AND p.schm_type = lv_schm_type;


                     -----------------------------------------------------------
                     --Checking the past due flag and
                     --deriving past_due_int_coll_bacid
                     -----------------------------------------------------------
                 IF((lv_bkd_amt_today_dr!=0) OR
                 ((lv_bkdamtdr_ovdu != 0) AND ((lv_schm_type != 'TDA') AND (lv_schm_type != 'TUA')))
                 )
                 THEN
                 --{
                     IF(lv_pdflg='Y') THEN
                      --{
                        SELECT PAST_DUE_INT_COLL_BACID
                        INTO lv_bacid
                        FROM tbaadm.gsp p
                        WHERE p.schm_code = lv_schm_code
                        AND p.bank_id = lv_bankid
                        AND p.schm_type = lv_schm_type;

                        lv_pandl_bacid:=lv_susp_bacid;
                      --}
                      END IF;
                 --}
                 END IF;



                        --out_rec := out_rec || '| After payable/receivable a/c fetch|';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           out_rec :=out_rec|| 'tbaadm.gsp query didnt fetch any Record  '|| lv_schm_code;

                           GOTO booknextrec;
                     --}
                     END;

                    -------------------------------------------------------------

                     -- fetching account id for above fetched bacid

                     -------------------------------------------------------------
                     BEGIN
                     --{
                            SELECT acid, foracid
                              INTO lv_glacid, lv_glacc
                              FROM tbaadm.gam g
                             WHERE bacid = lv_bacid
                               AND sol_id = lv_solid
                               AND acct_crncy_code = lv_acctcrncy
                               AND bank_id = lv_bankid;

                    SELECT acid, foracid
                    INTO lv_pandl_glacid, lv_pandl_glacc
                    FROM tbaadm.gam g
                    WHERE bacid = lv_pandl_bacid
                    AND sol_id = lv_solid
                    AND acct_crncy_code = lv_acctcrncy
                               AND bank_id = lv_bankid;

                        --out_rec := out_rec || '| After payable/receivable a/c fetch|';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           out_rec :=out_rec || 'tbaadm.gsp query didnt fetch any Record  ' || lv_bacid;

                           GOTO booknextrec;
                     --}
                     END;

                     ------------------------------------------

                     -- fetching tran details from tbaadm.dctd_acli

                     ------------------------------------------
                     BEGIN
                        --{

                                IF(lv_crdrflg='C')
                        THEN
                        --{
                            IF(lv_bkd_amt_today_cr>0)
                            THEN
                            --{
                                lv_credit_debit_ind:='C';
                            --}
                            ELSE
                            --{

                                lv_credit_debit_ind:='D';
                            --}
                            END IF;
                        --}
                        ELSE
                        --{
                            IF(lv_bkd_amt_today_dr>0)
                            THEN
                            --{
                                lv_credit_debit_ind:='D';
                            --}
                            ELSE
                            --{

                                lv_credit_debit_ind:='C';
                            --}
                            END IF;
                        --}
                           END IF;

                        SELECT part_tran_srl_num, tran_particular, tran_amt,
                        tran_particular_2, tran_rmks, part_tran_type,
                        tran_crncy_code
                        INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                        lv_tranpart2, lv_tranrmks, lv_ptrantype,
                        lv_trancrncy
                        FROM tbaadm.dctd_acli
                        WHERE tran_id = LPAD (lv_bkdtranid, 9)
                        AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                         OR (acid = lv_glacid))
                        AND tran_date = lv_bkduptodt
                        AND pstd_flg = 'Y'
                        AND del_flg != 'Y'
                        AND bank_id = lv_bankid
                        AND ROWNUM < 2;


                        --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                           lv_ptransrlnum:='';
                           lv_tranpart:='';
                           lv_tranamt:='';
                           lv_tranpart2:='';
                           lv_tranrmks:='';
                           lv_ptrantype:='';
                           lv_trancrncy:='';



                     --}
                     END;

                     out_rec := out_rec || '| BEFORE INSERT |';


                     BEGIN
                        --{

                        -------------------------------------------------------------

                        -- C_EIT insert.

                        -------------------------------------------------------------
                        INSERT INTO c_eit
                                    (tran_date, bacid, gl_acct_no, tran_id,
                                     part_tran_srl_num, tran_amt, tran_crncy,
                                     part_tran_type, tran_particular, tran_particular_2,
                                     tran_remarks, customer_account_no, sol_id,
                                     schm_type, schm_code, eod_closing_balance,
                                     eod_un_clr_bal_amt, eod_future_bal_amt,
                                     eod_lien_amt, gl_sub_head_code, int_coll_flag,
                                     int_paid_flag, debit_credit_ind, interest_rate,
                                     int_appl_flg, accrued_upto_date,
                                     accrued_upto_amount,
                                     accrued_amount_today,
                                     booked_upto_date,
                                     booked_upto_amount,
                                     booked_amount_today,
                                     applied_upto_date,
                                     applied_upto_amount,
                                     applied_amount_today,
                                     SEGMENT, sub_segment, free_code_7,
                                     rcre_user_id, rcre_time, lchg_user_id,
                                     lchg_time, bank_id,unq_identifier
                                    )
                             VALUES (lv_bkduptodt, lv_bacid, lv_glacc, lv_bkdtranid,
                                     lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                                     lv_ptrantype, lv_tranpart, lv_tranpart2,
                                     lv_tranrmks, lv_foracid, lv_solid,
                                     lv_schm_type, lv_schm_code, lv_eodbal,
                                     lv_unclrbalamt, lv_futbalamt,
                                     lv_lienamt, lv_glsub, lv_intcollflg,
                                     lv_intpdflg, lv_credit_debit_ind, lv_intrate,
                                     lv_bkdappl_flg, lv_accruptodt,
                                     DECODE (lv_crdrflg,
                                             'C', lv_accr_upto_amt_cr,
                                             lv_accr_upto_amt_dr
                                            ),
                                     DECODE (lv_crdrflg,
                                             'C', lv_accr_amt_today_cr,
                                             lv_accr_amt_today_dr
                                            ),
                                     lv_bkduptodt,
                                     DECODE (lv_crdrflg,
                                             'C', lv_bkd_upto_amt_cr,
                                             lv_bkd_upto_amt_dr
                                            ),
                                     abs(DECODE (lv_crdrflg,
                                             'C', lv_bkd_amt_today_cr,
                                             lv_bkd_amt_today_dr
                                            )),
                                     lv_appltrandt,
                                     DECODE (lv_crdrflg,
                                             'C', lv_appl_upto_amt_cr,
                                             lv_appl_upto_amt_dr
                                            ),
                                     0,
                                     lv_segment, lv_subsegment, lv_freecode7,
                                     lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                     lv_lchgtime, lv_bankid,lv_unique_id
                                    );
                                    COMMIT;

                                     BEGIN
                          --{
                            SELECT part_tran_srl_num, tran_particular, tran_amt,
                            tran_particular_2, tran_rmks, part_tran_type,
                            tran_crncy_code
                            INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                            lv_tranpart2, lv_tranrmks, lv_ptrantype,
                            lv_trancrncy
                            FROM tbaadm.dctd_acli
                            WHERE tran_id = LPAD (lv_bkdtranid, 9)
                            AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                             OR (acid = lv_pandl_glacid))
                            AND tran_date = lv_bkduptodt
                            AND pstd_flg = 'Y'
                            AND del_flg != 'Y'
                            AND bank_id = lv_bankid
                            AND ROWNUM < 2;
                           EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                           NULL;
                          --}
                          END;

                           --------------------------
                           --Inserting P/L entry
                           --------------------------

                        INSERT INTO c_eit
                        (tran_date, bacid, gl_acct_no, tran_id,
                         part_tran_srl_num, tran_amt, tran_crncy,
                         part_tran_type, tran_particular, tran_particular_2,
                         tran_remarks, customer_account_no, sol_id,
                         schm_type, schm_code, eod_closing_balance,
                         eod_un_clr_bal_amt, eod_future_bal_amt,
                         eod_lien_amt, gl_sub_head_code, int_coll_flag,
                         int_paid_flag, debit_credit_ind, interest_rate,
                         int_appl_flg, accrued_upto_date,
                         accrued_upto_amount,
                         accrued_amount_today,
                         booked_upto_date,
                         booked_upto_amount,
                         booked_amount_today,
                         applied_upto_date,
                         applied_upto_amount,
                         applied_amount_today,
                         SEGMENT, sub_segment, free_code_7,
                         rcre_user_id, rcre_time, lchg_user_id,
                         lchg_time, bank_id,unq_identifier
                        )
                        VALUES (lv_bkduptodt, lv_pandl_bacid, lv_pandl_glacc, lv_bkdtranid,
                         lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                         lv_ptrantype, lv_tranpart, lv_tranpart2,
                         lv_tranrmks, lv_foracid, lv_solid,
                         lv_schm_type, lv_schm_code, lv_eodbal,
                         lv_unclrbalamt, lv_futbalamt,
                         lv_lienamt, lv_glsub, lv_intcollflg,
                         lv_intpdflg, DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                         lv_bkdappl_flg, lv_accruptodt,
                         DECODE (lv_crdrflg,
                             'C', lv_accr_upto_amt_cr,
                             lv_accr_upto_amt_dr
                            ),
                         DECODE (lv_crdrflg,
                             'C', lv_accr_amt_today_cr,
                             lv_accr_amt_today_dr
                            ),
                         lv_bkduptodt,
                         DECODE (lv_crdrflg,
                             'C', lv_bkd_upto_amt_cr,
                             lv_bkd_upto_amt_dr
                            ),
                         abs(DECODE (lv_crdrflg,
                             'C', lv_bkd_amt_today_cr,
                             lv_bkd_amt_today_dr
                            )),
                         lv_appltrandt,
                         DECODE (lv_crdrflg,
                             'C', lv_appl_upto_amt_cr,
                             lv_appl_upto_amt_dr
                            ),
                         0,
                         lv_segment, lv_subsegment, lv_freecode7,
                         lv_rcreuserid, lv_rcretime, lv_lchguserid,
                         lv_lchgtime, lv_bankid,lv_unique_id
                                    );

                        COMMIT;


                     EXCEPTION
                        WHEN OTHERS
                        THEN

                           out_rec := out_rec || 'inser fail';
                     --}
                       END;
               --}
               END IF;


         -----------------------------------------------------------------------------------
         --Checking whether penal amount is not equal to zero and inserting one more record
         -----------------------------------------------------------------------------------
         IF(lv_bkd_penal_amt_today_dr!=0) THEN
         --{
                   -------------------------------------------------------------

                   -- Fetching penal receivable bacid for account.

                   -------------------------------------------------------------
                   BEGIN
                   IF(lv_pdflg='Y') THEN
                   --{
                       SELECT past_due_penal_int_coll_bacid
            INTO lv_bacid
            FROM tbaadm.gsp p
            WHERE p.schm_code = lv_schm_code
                        AND p.bank_id = lv_bankid;

                        lv_pandl_bacid:=lv_pen_susp_bacid;
                   --}
                   ELSE
                   --{
                       SELECT pen_coll_bacid,penal_pandl_bacid
            INTO lv_bacid,lv_pandl_bacid
            FROM tbaadm.gsp p
            WHERE p.schm_code = lv_schm_code
                        AND p.bank_id = lv_bankid;
                   --}
                   END IF;



                  EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       out_rec :=out_rec|| 'tbaadm.gsp query didnt fetch any Record  '|| lv_schm_code;
                       GOTO booknextrec;


                  END;

                 -------------------------------------------------------------

                 -- fetching account id for above fetched bacid

                 -------------------------------------------------------------
                 BEGIN
                 --{
                        SELECT acid, foracid
                          INTO lv_glacid, lv_glacc
                          FROM tbaadm.gam g
                         WHERE bacid = lv_bacid
                           AND sol_id = lv_solid
                           AND acct_crncy_code = lv_acctcrncy
                           AND bank_id = lv_bankid;

                           SELECT acid, foracid
            INTO lv_pandl_glacid, lv_pandl_glacc
            FROM tbaadm.gam g
            WHERE bacid = lv_pandl_bacid
            AND sol_id = lv_solid
            AND acct_crncy_code = lv_acctcrncy
                           AND bank_id = lv_bankid;

                    --out_rec := out_rec || '| After payable/receivable a/c fetch|';
                 EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                       --out_rec :=out_rec || 'tbaadm.gam query didnt fetch any Record  ' || lv_bacid;

                       GOTO booknextrec;
                 --}
                 END;

                 ------------------------------------------

         -- fetching tran details from tbaadm.dctd_acli

         ------------------------------------------
         BEGIN
            --{

            IF(lv_bkd_penal_amt_today_dr>0)
            THEN
            --{
                lv_credit_debit_ind:='D';
            --}
            ELSE
            --{

                lv_credit_debit_ind:='C';
            --}
            END IF;

            SELECT part_tran_srl_num, tran_particular, tran_amt,
            tran_particular_2, tran_rmks, part_tran_type,
            tran_crncy_code
            INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
            lv_tranpart2, lv_tranrmks, lv_ptrantype,
            lv_trancrncy
            FROM tbaadm.dctd_acli
            WHERE tran_id = LPAD (lv_bkdtranid, 9)
            AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
            AND tran_date = lv_bkduptodt
            AND pstd_flg = 'Y'
            AND del_flg != 'Y'
            AND bank_id = lv_bankid
            AND ROWNUM < 2;

            --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
               lv_ptransrlnum:='';
               lv_tranpart:='';
               lv_tranamt:='';
               lv_tranpart2:='';
               lv_tranrmks:='';
               lv_ptrantype:='';
               lv_trancrncy:='';
          --}
        END;

                BEGIN
                --{

                        -------------------------------------------------------------

                        -- C_EIT insert.

                        -------------------------------------------------------------
                        lv_tranpart:='Penal Interest';
                        INSERT INTO c_eit
                                    (tran_date, bacid, gl_acct_no, tran_id,
                                     part_tran_srl_num, tran_amt, tran_crncy,
                                     part_tran_type, tran_particular, tran_particular_2,
                                     tran_remarks, customer_account_no, sol_id,
                                     schm_type, schm_code, eod_closing_balance,
                                     eod_un_clr_bal_amt, eod_future_bal_amt,
                                     eod_lien_amt, gl_sub_head_code, int_coll_flag,
                                     int_paid_flag, debit_credit_ind, interest_rate,
                                     int_appl_flg, accrued_upto_date,
                                     accrued_upto_amount,
                                     accrued_amount_today,
                                     booked_upto_date,
                                     booked_upto_amount,
                                     booked_amount_today,
                                     applied_upto_date,
                                     applied_upto_amount,
                                     applied_amount_today,
                                     SEGMENT, sub_segment, free_code_7,
                                     rcre_user_id, rcre_time, lchg_user_id,
                                     lchg_time, bank_id,unq_identifier
                                    )
                             VALUES (lv_bkduptodt, lv_bacid, lv_glacc, lv_bkdtranid,
                                     lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                                     lv_ptrantype, lv_tranpart, lv_tranpart2,
                                     lv_tranrmks, lv_foracid, lv_solid,
                                     lv_schm_type, lv_schm_code, lv_eodbal,
                                     lv_unclrbalamt, lv_futbalamt,
                                     lv_lienamt, lv_glsub, lv_intcollflg,
                                     lv_intpdflg, lv_credit_debit_ind, lv_intrate,
                                     lv_bkdappl_flg, lv_accruptodt,
                                     lv_accr_penal_upto_dr,
                                     lv_accr_penal_amt_today_dr,
                                     lv_bkduptodt,
                                     lv_bkd_penal_upto_dr,
                                     abs(lv_bkd_penal_amt_today_dr),
                                     lv_appltrandt,
                                     lv_appl_penal_upto_dr,
                                     0,
                                     lv_segment, lv_subsegment, lv_freecode7,
                                     lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                     lv_lchgtime, lv_bankid,lv_unique_id
                                    );
                                    COMMIT;
                               BEGIN
                  --{
                    SELECT part_tran_srl_num, tran_particular, tran_amt,
                    tran_particular_2, tran_rmks, part_tran_type,
                    tran_crncy_code
                    INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                    lv_tranpart2, lv_tranrmks, lv_ptrantype,
                    lv_trancrncy
                    FROM tbaadm.dctd_acli
                    WHERE tran_id = LPAD (lv_bkdtranid, 9)
                    AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                     OR (acid = lv_pandl_glacid))
                    AND tran_date = lv_bkduptodt
                    AND pstd_flg = 'Y'
                    AND del_flg != 'Y'
                    AND bank_id = lv_bankid
                    AND ROWNUM < 2;
                   EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                   NULL;
                  --}
                   END;
                      ---------------------
                      --Inserting P/L Entry
                      ---------------------
                     INSERT INTO c_eit
                  (tran_date, bacid, gl_acct_no, tran_id,
                   part_tran_srl_num, tran_amt, tran_crncy,
                   part_tran_type, tran_particular, tran_particular_2,
                   tran_remarks, customer_account_no, sol_id,
                   schm_type, schm_code, eod_closing_balance,
                   eod_un_clr_bal_amt, eod_future_bal_amt,
                   eod_lien_amt, gl_sub_head_code, int_coll_flag,
                   int_paid_flag, debit_credit_ind, interest_rate,
                   int_appl_flg, accrued_upto_date,
                   accrued_upto_amount,
                   accrued_amount_today,
                   booked_upto_date,
                   booked_upto_amount,
                   booked_amount_today,
                   applied_upto_date,
                   applied_upto_amount,
                   applied_amount_today,
                   SEGMENT, sub_segment, free_code_7,
                   rcre_user_id, rcre_time, lchg_user_id,
                   lchg_time, bank_id,unq_identifier
                  )
               VALUES (lv_bkduptodt, lv_pandl_bacid, lv_pandl_glacc, lv_bkdtranid,
                   lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                   lv_ptrantype, lv_tranpart, lv_tranpart2,
                   lv_tranrmks, lv_foracid, lv_solid,
                   lv_schm_type, lv_schm_code, lv_eodbal,
                   lv_unclrbalamt, lv_futbalamt,
                   lv_lienamt, lv_glsub, lv_intcollflg,
                   lv_intpdflg, DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                   lv_bkdappl_flg, lv_accruptodt,
                   lv_accr_penal_upto_dr,
                   lv_accr_penal_amt_today_dr,
                   lv_bkduptodt,
                   lv_bkd_penal_upto_dr,
                   abs(lv_bkd_penal_amt_today_dr),
                   lv_appltrandt,
                   lv_appl_penal_upto_dr,
                   0,
                   lv_segment, lv_subsegment, lv_freecode7,
                   lv_rcreuserid, lv_rcretime, lv_lchguserid,
                   lv_lchgtime, lv_bankid,lv_unique_id
                  );


                            COMMIT;


                     EXCEPTION
                        WHEN OTHERS
                        THEN
                        out_rec := out_rec || 'insert fail';
                     --}
                 END;
         --}
         END IF;

         ------------------------------------
    --Inserting booked overdue interest
    ------------------------------------

    IF(lv_bkdamtdr_ovdu!=0)
    THEN
    --{
        IF(lv_crdrflg='C')
        THEN
        --{
            IF((lv_bkdamtdr_ovdu>0))
            THEN
            --{
                lv_credit_debit_ind:='C';
            --}
            ELSE
            --{

                lv_credit_debit_ind:='D';
            --}
            END IF;

        --}
        ELSE
        --{
            IF((lv_bkdamtdr_ovdu>0))
            THEN
            --{
                lv_credit_debit_ind:='D';
            --}
            ELSE
            --{

                lv_credit_debit_ind:='C';
            --}
            END IF;

        --}
        END IF;



        BEGIN
           --{

            SELECT ovdu_int_paid_bacid,OVDU_INT_PANDL_BACID_CR
            INTO lv_bacid,lv_pandl_bacid
            FROM tbaadm.gsp p
            WHERE p.schm_code = lv_schm_code
            AND p.bank_id = lv_bankid
            AND p.schm_type = lv_schm_type;


            SELECT foracid,acid
            INTO lv_glacc,lv_glacid
            FROM tbaadm.gam
            WHERE bacid = lv_bacid
            AND sol_id = lv_solid
            AND acct_crncy_code = lv_acctcrncy
            AND bank_id = lv_bankid;

            SELECT foracid,acid
            INTO lv_pandl_glacc,lv_pandl_glacid
            FROM tbaadm.gam
            WHERE bacid = lv_pandl_bacid
            AND sol_id = lv_solid
            AND acct_crncy_code = lv_acctcrncy
            AND bank_id = lv_bankid;


         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               out_rec :=out_rec|| ' Overdue bacid not present '|| lv_acid;
         --}
        END;

        BEGIN
        --{
             ----------------------------------------

             -- fetching tran details from tbaadm.dctd_acli

            ----------------------------------------

               SELECT part_tran_srl_num, tran_particular, tran_amt,
                  tran_particular_2, tran_rmks, part_tran_type,
                  tran_crncy_code
             INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                  lv_tranpart2, lv_tranrmks, lv_ptrantype,
                  lv_trancrncy
              FROM tbaadm.dctd_acli
              WHERE tran_id = LPAD (lv_bkdtranid, 9)
              AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
              AND tran_date = lv_bkduptodt
              AND pstd_flg = 'Y'
              AND del_flg != 'Y'
              AND bank_id = lv_bankid
              AND ROWNUM < 2;

           -- out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
               lv_ptransrlnum:='';
               lv_tranpart:='';
               lv_tranamt:='';
               lv_tranpart2:='';
               lv_tranrmks:='';
               lv_ptrantype:='';
               lv_trancrncy:='';


        --}
        END;
        lv_tranrmks:='Overdue Interest';
        -------------------------------------------------------------

           -- C_EIT insert

           -------------------------------------------------------------
           BEGIN
          --{
          INSERT INTO c_eit
                  (tran_date, bacid, gl_acct_no,
                   tran_id, part_tran_srl_num,
                   tran_amt,
                   tran_crncy,
                   part_tran_type,
                   tran_particular,
                   tran_particular_2,
                   tran_remarks, customer_account_no, sol_id,
                   schm_type, schm_code, eod_closing_balance,
                   eod_un_clr_bal_amt, eod_future_bal_amt,
                   eod_lien_amt, gl_sub_head_code,
                   int_coll_flag, int_paid_flag,
                   debit_credit_ind, interest_rate,
                   int_appl_flg, accrued_upto_date,
                   accrued_upto_amount,
                   accrued_amount_today,
                   booked_upto_date,
                   booked_upto_amount,
                   booked_amount_today,
                   applied_upto_date,
                   applied_upto_amount,
                   applied_amount_today,
                   SEGMENT, sub_segment, free_code_7,
                   rcre_user_id, rcre_time, lchg_user_id,
                   lchg_time, bank_id,unq_identifier
                  )
               VALUES (lv_bkduptodt, lv_bacid, lv_glacc,
                   lv_bkdtranid, lv_ptransrlnum,
                   lv_tranamt,
                   lv_trancrncy,
                   lv_ptrantype,
                   lv_tranpart,
                   lv_tranpart2,
                   lv_tranrmks, lv_foracid, lv_solid,
                   lv_schm_type, lv_schm_code, lv_eodbal,
                   lv_unclrbalamt, lv_futbalamt,
                   lv_lienamt, lv_glsub,
                   lv_intcollflg, lv_intpdflg,
                   lv_credit_debit_ind, lv_intrate,
                   lv_bkdappl_flg, lv_accruptodt,
                   DECODE (lv_crdrflg,
                       'C', lv_accr_upto_amt_cr,
                       lv_accr_upto_amt_dr
                      ),
                   abs(lv_accramtdr_ovdu),
                   lv_bkduptodt,
                   DECODE (lv_crdrflg,
                       'C', lv_bkd_upto_amt_cr,
                       lv_bkd_upto_amt_dr
                      ),
                   abs(lv_bkdamtdr_ovdu),
                   lv_appltrandt,
                   DECODE (lv_crdrflg,
                       'C', lv_appl_upto_amt_cr,
                       lv_appl_upto_amt_dr
                      ),
                   0,
                   lv_segment, lv_subsegment, lv_freecode7,
                   lv_rcreuserid, lv_rcretime, lv_lchguserid,
                   lv_lchgtime, lv_bankid,lv_unique_id
                  );
                  COMMIT;

                  BEGIN
                  --{
                    SELECT part_tran_srl_num, tran_particular, tran_amt,
                    tran_particular_2, tran_rmks, part_tran_type,
                    tran_crncy_code
                    INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                    lv_tranpart2, lv_tranrmks, lv_ptrantype,
                    lv_trancrncy
                    FROM tbaadm.dctd_acli
                    WHERE tran_id = LPAD (lv_bkdtranid, 9)
                    AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                     OR (acid = lv_pandl_glacid))
                    AND tran_date = lv_bkduptodt
                    AND pstd_flg = 'Y'
                    AND del_flg != 'Y'
                    AND bank_id = lv_bankid
                    AND ROWNUM < 2;
                   EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                   NULL;
                  --}
                    END;
                  --------------------------------------
                  --Inserting P/L entry
                  ---------------------------------------

                  INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_bkduptodt, lv_pandl_bacid, lv_pandl_glacc,
                       lv_bkdtranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                       lv_bkdappl_flg, lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       abs(lv_accramtdr_ovdu),
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       abs(lv_bkdamtdr_ovdu),
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       0,
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                  );


          COMMIT;


           EXCEPTION
          WHEN OTHERS
          THEN

            -- lv_errmsg := SUBSTR(SQLERRM,0,100);
             out_rec := out_rec || 'Insert unsucessful';

           --}
           END;


    --}
END IF;


         <<booknextrec>>
         out_rec := out_rec || '| Fetch next rec |';
      --}
      END IF;
   END c_eit_book_tran_fetch_proc;

      PROCEDURE c_eit_book_tran_fetch_proc_oda (
          lv_bkduptodt               IN       DATE,
      lv_bkdtranid               IN       VARCHAR2,
      lv_acctcrncy               IN       VARCHAR2,
      lv_foracid                 IN       VARCHAR2,
      lv_solid                   IN       VARCHAR2,
      lv_schm_type               IN       VARCHAR2,
      lv_schm_code               IN       VARCHAR2,
      lv_eodbal                  IN       NUMBER,
      lv_unclrbalamt             IN       NUMBER,
      lv_futbalamt               IN       NUMBER,
      lv_lienamt                 IN       NUMBER,
      lv_glsub                   IN       VARCHAR2,
      lv_intcollflg              IN       CHAR,
      lv_intpdflg                IN       CHAR,
      lv_crdrflg                 IN       CHAR,
      lv_intrate                 IN       NUMBER,
      lv_bkdappl_flg             IN       CHAR,
      lv_accruptodt              IN       DATE,
      lv_accr_upto_amt_cr        IN OUT   NUMBER,
      lv_accr_upto_amt_dr        IN OUT   NUMBER,
      lv_accr_amt_today_cr       IN OUT   NUMBER,
      lv_accr_amt_today_dr       IN OUT   NUMBER,
      lv_bkd_upto_amt_cr         IN OUT   NUMBER,
      lv_bkd_upto_amt_dr         IN OUT   NUMBER,
      lv_bkd_amt_today_cr        IN OUT   NUMBER,
      lv_bkd_amt_today_dr        IN OUT   NUMBER,
      lv_appltrandt              IN       DATE,
      lv_appl_upto_amt_cr        IN OUT   NUMBER,
      lv_appl_upto_amt_dr        IN OUT   NUMBER,
      lv_appl_amt_today_cr       IN OUT   NUMBER,
      lv_appl_amt_today_dr       IN OUT   NUMBER,
      lv_segment                 IN       VARCHAR2,
      lv_subsegment              IN       VARCHAR2,
      lv_freecode7               IN       VARCHAR2,
      lv_rcreuserid              IN       VARCHAR2,
      lv_rcretime                IN       DATE,
      lv_lchguserid              IN       VARCHAR2,
      lv_lchgtime                IN       DATE,
      lv_bankid                  IN       VARCHAR2,
      out_rec                    OUT      VARCHAR2,
      lv_bkdamtdr_ovdu           IN       NUMBER,
      lv_applamtdr_ovdu          IN       NUMBER,
      lv_accramtdr_ovdu          IN       NUMBER,
      lv_bkd_penal_amt_today_dr     IN       NUMBER,
      lv_accr_penal_amt_today_dr     IN       NUMBER,
      lv_appl_penal_amt_today_dr     IN       NUMBER,
      lv_accr_penal_upto_dr          IN       NUMBER,
      lv_bkd_penal_upto_dr           IN       NUMBER,
      lv_appl_penal_upto_dr          IN       NUMBER,
      lv_accruptodtcr            IN       DATE,
      lv_accruptodtdr            IN       DATE,
      lv_bkduptodtcr             IN       DATE,
      lv_bkduptodtdr             IN       DATE,
      lv_appltrandtcr            IN       DATE,
      lv_appltrandtdr            IN       DATE,
      lv_bkdtranidcr             IN       VARCHAR2,
      lv_bkdtraniddr             IN       VARCHAR2,
      lv_appltranidcr            IN       VARCHAR2,
      lv_appltraniddr            IN       VARCHAR2,
          lv_acid                    IN       VARCHAR2,
          lv_unique_id                IN     VARCHAR2
      )
      AS
         lv_bacid             tbaadm.gam.bacid%TYPE;
         lv_glacid            tbaadm.gam.acid%TYPE;
         lv_glacc             tbaadm.gam.foracid%TYPE;
         lv_ptransrlnum       tbaadm.dtd.part_tran_srl_num%TYPE;
         lv_tranpart          tbaadm.dtd.tran_particular%TYPE;
         lv_tranamt           tbaadm.dtd.tran_amt%TYPE;
         lv_tranpart2         tbaadm.dtd.tran_particular_2%TYPE;
         lv_tranrmks          tbaadm.dtd.tran_rmks%TYPE;
         lv_ptrantype         tbaadm.dtd.part_tran_type%TYPE;
         lv_trancrncy         tbaadm.dtd.tran_crncy_code%TYPE;
         lv_errmsg            VARCHAR2 (100);
         lv_trancount         NUMBER;
         lv_pdflg             tbaadm.AIP.PAST_DUE_FLG%TYPE;
         lv_credit_debit_ind     CHAR(1)        :='N';
         lv_pandl_bacid         tbaadm.gam.bacid%TYPE;
     lv_pandl_glacid        tbaadm.gam.acid%TYPE;
     lv_pandl_glacc         tbaadm.gam.foracid%TYPE;
     lv_susp_bacid        tbaadm.gam.bacid%TYPE;
         lv_pen_susp_bacid    tbaadm.gam.bacid%TYPE;
      BEGIN
         --{
         IF (lv_crdrflg != 'N')
         THEN
            --{
            ------------------
             --Fetching pd_flg
             ------------------
             BEGIN
             --{

                 select PAST_DUE_FLG,int_susp_bacid,penal_int_susp_bacid
                 into lv_pdflg,lv_susp_bacid,lv_pen_susp_bacid
                 from tbaadm.AIP, tbaadm.acd , tbaadm.gam
                 where acd.b2k_id = tbaadm.gam.acid
                 and tbaadm.gam.schm_code = tbaadm.AIP.schm_code
                 and tbaadm.AIP.MAIN_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.MAIN_CLASSIFICATION_SYSTEM,acd.MAIN_CLASSIFICATION_USER)
                 and tbaadm.AIP.SUB_ASSET_CLASS = DECODE(ASSET_CONTROL_FLG,'S',acd.SUB_CLASSIFICATION_SYSTEM,acd.SUB_CLASSIFICATION_USER)
                 and tbaadm.AIP.B2K_TYPE = 'ACCNT'
                 and acd.B2K_TYPE = 'ACCNT'
                 and tbaadm.AIP.del_flg !='Y'
                 and foracid = lv_foracid
                 and tbaadm.gam.bank_id = lv_bankid
                 and acd.bank_id = tbaadm.gam.bank_id
                 and tbaadm.AIP.bank_id = tbaadm.gam.bank_id;


                 EXCEPTION
                 WHEN NO_DATA_FOUND
                 THEN
                 lv_pdflg:='';
                 lv_susp_bacid:='';
                 lv_pen_susp_bacid:='';

                     out_rec :=out_rec|| ' PD flg not fetched'|| lv_acid;

               --}
                       END;
             IF((lv_bkd_amt_today_dr!=0) OR (lv_bkd_penal_amt_today_dr!=0))
             THEN
             --{

                     IF(lv_bkd_amt_today_dr!=0)
                     THEN
                     --{
                         BEGIN
                --{

                     -----------------------------------------------------------
                     --Checking the past due flag in GAC table and
                     --deriving past_due_int_coll_bacid
                     -----------------------------------------------------------
                     IF(lv_pdflg='Y')
                     THEN
                     --{
                           SELECT PAST_DUE_INT_COLL_BACID
                           INTO lv_bacid
                           FROM tbaadm.gsp p
                           WHERE p.schm_code = lv_schm_code
                           AND p.bank_id = lv_bankid
                           AND p.schm_type = lv_schm_type;

                           lv_pandl_bacid:=lv_susp_bacid;
                     --}
                     ELSE
                     --{
                         SELECT  int_coll_bacid,int_pandl_bacid_dr
                         INTO lv_bacid,lv_pandl_bacid
                         FROM tbaadm.gsp p
                         WHERE p.schm_code = lv_schm_code
                         AND p.bank_id = lv_bankid
                         AND p.schm_type = lv_schm_type;
                     --}
                     END IF;


                   EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                  out_rec :=out_rec|| 'tbaadm.gsp query didnt fetch any Record '|| lv_schm_code;


                  GOTO booknextrec;
                  --}
                  END;

               -------------------------------------------------------------

                -- fetching account id for above fetched bacid

                -------------------------------------------------------------
                BEGIN
                --{
                           SELECT acid, foracid
                     INTO lv_glacid, lv_glacc
                     FROM tbaadm.gam g
                    WHERE bacid = lv_bacid
                      AND sol_id = lv_solid
                      AND acct_crncy_code = lv_acctcrncy
                      AND bank_id = lv_bankid;

                      SELECT acid, foracid
                    INTO lv_pandl_glacid, lv_pandl_glacc
                    FROM tbaadm.gam g
                    WHERE bacid = lv_pandl_bacid
                    AND sol_id = lv_solid
                    AND acct_crncy_code = lv_acctcrncy
                      AND bank_id = lv_bankid;

                   out_rec := out_rec || '| After payable/receivable a/c fetch|';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                  out_rec :=
                     out_rec || 'tbaadm.gam query didnt fetch any Record  ' || lv_bacid;
                  GOTO booknextrec;
                --}
                END;

               -------------------------------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                -------------------------------------------------------------
                BEGIN
                   --{
                    IF(lv_bkd_amt_today_dr>0)
                    THEN
                    --{
                        lv_credit_debit_ind:='D';
                    --}
                    ELSE
                    --{
                        lv_credit_debit_ind:='C';
                    --}
                    END IF;


                    SELECT part_tran_srl_num, tran_particular, tran_amt,
                    tran_particular_2, tran_rmks, part_tran_type,
                    tran_crncy_code
                    INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                    lv_tranpart2, lv_tranrmks, lv_ptrantype,
                    lv_trancrncy
                    FROM tbaadm.dctd_acli
                    WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                    AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                    AND tran_date = lv_bkduptodtdr
                    AND pstd_flg = 'Y'
                    AND del_flg != 'Y'
                    AND bank_id = lv_bankid
                    AND ROWNUM < 2;


                       --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                  --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                lv_ptransrlnum:='';
                    lv_tranpart:='';
                    lv_tranamt:='';
                    lv_tranpart2:='';
                    lv_tranrmks:='';
                    lv_ptrantype:='';
                       lv_trancrncy:='';



                --}
                END;


                out_rec := out_rec || '| BEFORE INSERT |';


                BEGIN
                   --{

                   -------------------------------------------------------------

                   -- C_EIT insert.

                   -------------------------------------------------------------
                   INSERT INTO c_eit
                       (tran_date, bacid, gl_acct_no, tran_id,
                        part_tran_srl_num, tran_amt, tran_crncy,
                        part_tran_type, tran_particular, tran_particular_2,
                        tran_remarks, customer_account_no, sol_id,
                        schm_type, schm_code, eod_closing_balance,
                        eod_un_clr_bal_amt, eod_future_bal_amt,
                        eod_lien_amt, gl_sub_head_code, int_coll_flag,
                        int_paid_flag, debit_credit_ind, interest_rate,
                        int_appl_flg, accrued_upto_date,
                        accrued_upto_amount,
                        accrued_amount_today,
                        booked_upto_date,
                        booked_upto_amount,
                        booked_amount_today,
                        applied_upto_date,
                        applied_upto_amount,
                        applied_amount_today,
                        SEGMENT, sub_segment, free_code_7,
                        rcre_user_id, rcre_time, lchg_user_id,
                        lchg_time, bank_id,unq_identifier
                       )
                    VALUES (lv_bkduptodtdr, lv_bacid, lv_glacc, lv_bkdtraniddr,
                        lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                        lv_ptrantype, lv_tranpart, lv_tranpart2,
                        lv_tranrmks, lv_foracid, lv_solid,
                        lv_schm_type, lv_schm_code, lv_eodbal,
                        lv_unclrbalamt, lv_futbalamt,
                        lv_lienamt, lv_glsub, lv_intcollflg,
                        lv_intpdflg, lv_credit_debit_ind, lv_intrate,
                        lv_bkdappl_flg, lv_accruptodtdr,
                        lv_accr_upto_amt_dr,
                        lv_accr_amt_today_dr,
                        lv_bkduptodtdr,
                        lv_bkd_upto_amt_dr,
                        abs(lv_bkd_amt_today_dr),
                        lv_appltrandtdr,
                        lv_appl_upto_amt_dr,
                        0,
                        lv_segment, lv_subsegment, lv_freecode7,
                        lv_rcreuserid, lv_rcretime, lv_lchguserid,
                        lv_lchgtime, lv_bankid,lv_unique_id
                       );
                       COMMIT;

                       BEGIN
                          --{
                            SELECT part_tran_srl_num, tran_particular, tran_amt,
                            tran_particular_2, tran_rmks, part_tran_type,
                            tran_crncy_code
                            INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                            lv_tranpart2, lv_tranrmks, lv_ptrantype,
                            lv_trancrncy
                            FROM tbaadm.dctd_acli
                            WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                            AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                             OR (acid = lv_pandl_glacid))
                            AND tran_date = lv_bkduptodtdr
                            AND pstd_flg = 'Y'
                            AND del_flg != 'Y'
                            AND bank_id = lv_bankid
                            AND ROWNUM < 2;
                           EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                           NULL;
                          --}
                    END;
                       INSERT INTO c_eit
                       (tran_date, bacid, gl_acct_no, tran_id,
                        part_tran_srl_num, tran_amt, tran_crncy,
                        part_tran_type, tran_particular, tran_particular_2,
                        tran_remarks, customer_account_no, sol_id,
                        schm_type, schm_code, eod_closing_balance,
                        eod_un_clr_bal_amt, eod_future_bal_amt,
                        eod_lien_amt, gl_sub_head_code, int_coll_flag,
                        int_paid_flag, debit_credit_ind, interest_rate,
                        int_appl_flg, accrued_upto_date,
                        accrued_upto_amount,
                        accrued_amount_today,
                        booked_upto_date,
                        booked_upto_amount,
                        booked_amount_today,
                        applied_upto_date,
                        applied_upto_amount,
                        applied_amount_today,
                        SEGMENT, sub_segment, free_code_7,
                        rcre_user_id, rcre_time, lchg_user_id,
                        lchg_time, bank_id,unq_identifier
                       )
                    VALUES (lv_bkduptodtdr, lv_pandl_bacid, lv_pandl_glacc, lv_bkdtraniddr,
                        lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                        lv_ptrantype, lv_tranpart, lv_tranpart2,
                        lv_tranrmks, lv_foracid, lv_solid,
                        lv_schm_type, lv_schm_code, lv_eodbal,
                        lv_unclrbalamt, lv_futbalamt,
                        lv_lienamt, lv_glsub, lv_intcollflg,
                        lv_intpdflg, DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                        lv_bkdappl_flg, lv_accruptodtdr,
                        lv_accr_upto_amt_dr,
                        lv_accr_amt_today_dr,
                        lv_bkduptodtdr,
                        lv_bkd_upto_amt_dr,
                        abs(lv_bkd_amt_today_dr),
                        lv_appltrandtdr,
                        lv_appl_upto_amt_dr,
                        0,
                        lv_segment, lv_subsegment, lv_freecode7,
                        lv_rcreuserid, lv_rcretime, lv_lchguserid,
                        lv_lchgtime, lv_bankid,lv_unique_id
                       );


                   COMMIT;


                EXCEPTION
                   WHEN OTHERS
                   THEN
                --DBMS_OUTPUT.put_line (SQLERRM);

                  out_rec := out_rec || 'fail';
                --}
                           END;
                     --}
                     END IF;

                 -----------------------------------------------------------------------------------
                 --Checking whether penal amount is not equal to zero and inserting one more record
                 -----------------------------------------------------------------------------------
                 IF(lv_bkd_penal_amt_today_dr!=0)
                 THEN
                 --{
                        -------------------------------------------------------------

                        -- Fetching penal receivable bacid for account.

                        -------------------------------------------------------------
            BEGIN

                IF(lv_pdflg='Y')
                THEN
                --{
                    SELECT past_due_penal_int_coll_bacid
                    INTO lv_bacid
                    FROM tbaadm.gsp p
                    WHERE p.schm_code = lv_schm_code
                                   AND p.bank_id = lv_bankid;

                                   lv_pandl_bacid:=lv_pen_susp_bacid;
                --}
                ELSE
                --{
                     SELECT pen_coll_bacid,penal_pandl_bacid
                     INTO lv_bacid,lv_pandl_bacid
                     FROM tbaadm.gsp p
                     WHERE p.schm_code = lv_schm_code
                                    AND p.bank_id = lv_bankid;
                --}
                END IF;



                        --out_rec := out_rec || '| After payable/receivable a/c fetch|';
                       EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           out_rec :=out_rec|| 'tbaadm.gsp query didnt fetch any Record  '|| lv_schm_code;


                           GOTO booknextrec;
                       END;

                    -------------------------------------------------------------

                     -- fetching account id for above fetched bacid

                     -------------------------------------------------------------
                     BEGIN
                     --{
                            SELECT acid, foracid
                              INTO lv_glacid, lv_glacc
                              FROM tbaadm.gam g
                             WHERE bacid = lv_bacid
                               AND sol_id = lv_solid
                               AND acct_crncy_code = lv_acctcrncy
                               AND bank_id = lv_bankid;

                               SELECT acid, foracid
                INTO lv_pandl_glacid, lv_pandl_glacc
                FROM tbaadm.gam g
                WHERE bacid = lv_pandl_bacid
                AND sol_id = lv_solid
                AND acct_crncy_code = lv_acctcrncy
                               AND bank_id = lv_bankid;

                        --out_rec := out_rec || '| After payable/receivable a/c fetch|';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           out_rec :=
                          out_rec || 'tbaadm.gsp query didnt fetch any Record  ' || lv_bacid;
                           GOTO booknextrec;
                     --}
                     END;

                          -------------------------------------------------------------

                -- fetching tran details from tbaadm.dctd_acli

                -------------------------------------------------------------
                BEGIN
                   --{
                    IF(lv_bkd_penal_amt_today_dr>0)
                    THEN
                    --{
                        lv_credit_debit_ind:='D';
                    --}
                    ELSE
                    --{
                        lv_credit_debit_ind:='C';
                    --}
                    END IF;

                         SELECT part_tran_srl_num, tran_particular, tran_amt,
                    tran_particular_2, tran_rmks, part_tran_type,
                    tran_crncy_code
                    INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                    lv_tranpart2, lv_tranrmks, lv_ptrantype,
                    lv_trancrncy
                    FROM tbaadm.dctd_acli
                    WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                    AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                    AND tran_date = lv_bkduptodtdr
                    AND pstd_flg = 'Y'
                    AND del_flg != 'Y'
                    AND bank_id = lv_bankid
                    AND ROWNUM < 2;


                       --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                  --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                lv_ptransrlnum:='';
                    lv_tranpart:='';
                    lv_tranamt:='';
                    lv_tranpart2:='';
                    lv_tranrmks:='';
                    lv_ptrantype:='';
                       lv_trancrncy:='';



                --}
                END;

                -------------------------------------------------------------

                                            -- C_EIT insert.

                            -------------------------------------------------------------

                    BEGIN
                            --{


                            lv_tranpart:='Penal Interest';
                            INSERT INTO c_eit
                                (tran_date, bacid, gl_acct_no, tran_id,
                                 part_tran_srl_num, tran_amt, tran_crncy,
                                 part_tran_type, tran_particular, tran_particular_2,
                                 tran_remarks, customer_account_no, sol_id,
                                 schm_type, schm_code, eod_closing_balance,
                                 eod_un_clr_bal_amt, eod_future_bal_amt,
                                 eod_lien_amt, gl_sub_head_code, int_coll_flag,
                                 int_paid_flag, debit_credit_ind, interest_rate,
                                 int_appl_flg, accrued_upto_date,
                                 accrued_upto_amount,
                                 accrued_amount_today,
                                 booked_upto_date,
                                 booked_upto_amount,
                                 booked_amount_today,
                                 applied_upto_date,
                                 applied_upto_amount,
                                 applied_amount_today,
                                 SEGMENT, sub_segment, free_code_7,
                                 rcre_user_id, rcre_time, lchg_user_id,
                                 lchg_time, bank_id,unq_identifier
                                )
                             VALUES (lv_bkduptodtdr, lv_bacid, lv_glacc, lv_bkdtraniddr,
                                 lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                                 lv_ptrantype, lv_tranpart, lv_tranpart2,
                                 lv_tranrmks, lv_foracid, lv_solid,
                                 lv_schm_type, lv_schm_code, lv_eodbal,
                                 lv_unclrbalamt, lv_futbalamt,
                                 lv_lienamt, lv_glsub, lv_intcollflg,
                                 lv_intpdflg, lv_credit_debit_ind, lv_intrate,
                                 lv_bkdappl_flg, lv_accruptodtdr,
                                 lv_accr_penal_upto_dr,
                                 lv_accr_penal_amt_today_dr,
                                 lv_bkduptodtdr,
                                 lv_bkd_penal_upto_dr,
                                 abs(lv_bkd_penal_amt_today_dr),
                                 lv_appltrandtdr,
                                 lv_appl_penal_upto_dr,
                                 0,
                                 lv_segment, lv_subsegment, lv_freecode7,
                                 lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                 lv_lchgtime, lv_bankid,lv_unique_id
                                );
                                COMMIT;
                                 BEGIN
                  --{
                    SELECT part_tran_srl_num, tran_particular, tran_amt,
                    tran_particular_2, tran_rmks, part_tran_type,
                    tran_crncy_code
                    INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                    lv_tranpart2, lv_tranrmks, lv_ptrantype,
                    lv_trancrncy
                    FROM tbaadm.dctd_acli
                    WHERE tran_id = LPAD (lv_bkdtraniddr, 9)
                    AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                     OR (acid = lv_pandl_glacid))
                    AND tran_date = lv_bkduptodtdr
                    AND pstd_flg = 'Y'
                    AND del_flg != 'Y'
                    AND bank_id = lv_bankid
                    AND ROWNUM < 2;
                   EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                   NULL;
                  --}
                   END;
                INSERT INTO c_eit
                (tran_date, bacid, gl_acct_no, tran_id,
                 part_tran_srl_num, tran_amt, tran_crncy,
                 part_tran_type, tran_particular, tran_particular_2,
                 tran_remarks, customer_account_no, sol_id,
                 schm_type, schm_code, eod_closing_balance,
                 eod_un_clr_bal_amt, eod_future_bal_amt,
                 eod_lien_amt, gl_sub_head_code, int_coll_flag,
                 int_paid_flag, debit_credit_ind, interest_rate,
                 int_appl_flg, accrued_upto_date,
                 accrued_upto_amount,
                 accrued_amount_today,
                 booked_upto_date,
                 booked_upto_amount,
                 booked_amount_today,
                 applied_upto_date,
                 applied_upto_amount,
                 applied_amount_today,
                 SEGMENT, sub_segment, free_code_7,
                 rcre_user_id, rcre_time, lchg_user_id,
                 lchg_time, bank_id,unq_identifier
                )
             VALUES (lv_bkduptodtdr, lv_pandl_bacid, lv_pandl_glacc, lv_bkdtraniddr,
                 lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                 lv_ptrantype, lv_tranpart, lv_tranpart2,
                 lv_tranrmks, lv_foracid, lv_solid,
                 lv_schm_type, lv_schm_code, lv_eodbal,
                 lv_unclrbalamt, lv_futbalamt,
                 lv_lienamt, lv_glsub, lv_intcollflg,
                 lv_intpdflg, DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
                 lv_bkdappl_flg, lv_accruptodtdr,
                 lv_accr_penal_upto_dr,
                 lv_accr_penal_amt_today_dr,
                 lv_bkduptodtdr,
                 lv_bkd_penal_upto_dr,
                 abs(lv_bkd_penal_amt_today_dr),
                 lv_appltrandtdr,
                 lv_appl_penal_upto_dr,
                 0,
                 lv_segment, lv_subsegment, lv_freecode7,
                 lv_rcreuserid, lv_rcretime, lv_lchguserid,
                 lv_lchgtime, lv_bankid,lv_unique_id
                );


                            COMMIT;


                         EXCEPTION
                            WHEN OTHERS
                            THEN


                               out_rec := out_rec || 'fail';
                         --}
                    END;
                --}
                 END IF;


            <<booknextrec>>
            out_rec := out_rec || '| Fetch next rec |';
             --}
             END IF;

             IF(lv_bkd_amt_today_cr!=0)
             THEN
             --{
             BEGIN
            --{
                SELECT  int_paid_bacid,int_pandl_bacid_cr
                INTO lv_bacid,lv_pandl_bacid
                FROM tbaadm.gsp p
                WHERE p.schm_code = lv_schm_code
                AND p.bank_id = lv_bankid
                AND p.schm_type = lv_schm_type;

                out_rec := out_rec || '| After payable/receivable a/c fetch|';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
              out_rec :=out_rec|| 'tbaadm.gsp query didnt fetch any Record  '|| lv_schm_code;

              GOTO booknextrec2;
            --}
            END;

            -------------------------------------------------------------

            -- fetching account id for above fetched bacid

            -------------------------------------------------------------
            BEGIN
            --{
               SELECT acid, foracid
               INTO lv_glacid, lv_glacc
               FROM tbaadm.gam g
               WHERE bacid = lv_bacid
               AND sol_id = lv_solid
               AND acct_crncy_code = lv_acctcrncy
               AND bank_id = lv_bankid;

               SELECT acid, foracid
               INTO lv_pandl_glacid, lv_pandl_glacc
               FROM tbaadm.gam g
               WHERE bacid = lv_pandl_bacid
               AND sol_id = lv_solid
               AND acct_crncy_code = lv_acctcrncy
               AND bank_id = lv_bankid;


            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
              out_rec :=
                 out_rec || 'tbaadm.gam query didnt fetch any Record  ' || lv_bacid;
              GOTO booknextrec2;
            --}
            END;

                -------------------------------------------------------------

                -- fetching tran details from tbaadm.dtd, if no record present then etd used.

                -------------------------------------------------------------
                BEGIN
                   --{

                       IF(lv_bkd_amt_today_cr>0)
            THEN
            --{
                lv_credit_debit_ind:='C';
            --}
            ELSE
            --{
                lv_credit_debit_ind:='D';
            --}
                        END IF;


            SELECT part_tran_srl_num, tran_particular, tran_amt,
            tran_particular_2, tran_rmks, part_tran_type,
            tran_crncy_code
            INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
            lv_tranpart2, lv_tranrmks, lv_ptrantype,
            lv_trancrncy
            FROM tbaadm.dctd_acli
            WHERE tran_id = LPAD (lv_bkdtranidcr, 9)
            AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
            AND tran_date = lv_bkduptodtcr
            AND pstd_flg = 'Y'
            AND del_flg != 'Y'
            AND bank_id = lv_bankid
            AND ROWNUM < 2;


                   --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                  --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                       lv_ptransrlnum:='';
               lv_tranpart:='';
               lv_tranamt:='';
               lv_tranpart2:='';
               lv_tranrmks:='';
               lv_ptrantype:='';
               lv_trancrncy:='';

                --}
                END;


                out_rec := out_rec || '| BEFORE INSERT |';


                BEGIN
                   --{

                   -------------------------------------------------------------

                   -- C_EIT insert.

                   -------------------------------------------------------------
                   INSERT INTO c_eit
                       (tran_date, bacid, gl_acct_no, tran_id,
                        part_tran_srl_num, tran_amt, tran_crncy,
                        part_tran_type, tran_particular, tran_particular_2,
                        tran_remarks, customer_account_no, sol_id,
                        schm_type, schm_code, eod_closing_balance,
                        eod_un_clr_bal_amt, eod_future_bal_amt,
                        eod_lien_amt, gl_sub_head_code, int_coll_flag,
                        int_paid_flag, debit_credit_ind, interest_rate,
                        int_appl_flg, accrued_upto_date,
                        accrued_upto_amount,
                        accrued_amount_today,
                        booked_upto_date,
                        booked_upto_amount,
                        booked_amount_today,
                        applied_upto_date,
                        applied_upto_amount,
                        applied_amount_today,
                        SEGMENT, sub_segment, free_code_7,
                        rcre_user_id, rcre_time, lchg_user_id,
                        lchg_time, bank_id,unq_identifier
                       )
                    VALUES (lv_bkduptodtcr, lv_bacid, lv_glacc, lv_bkdtranidcr,
                        lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                        lv_ptrantype, lv_tranpart, lv_tranpart2,
                        lv_tranrmks, lv_foracid, lv_solid,
                        lv_schm_type, lv_schm_code, lv_eodbal,
                        lv_unclrbalamt, lv_futbalamt,
                        lv_lienamt, lv_glsub, lv_intcollflg,
                        lv_intpdflg, lv_credit_debit_ind, lv_intrate,
                        lv_bkdappl_flg, lv_accruptodtcr,
                        lv_accr_upto_amt_cr,
                        lv_accr_amt_today_cr,
                        lv_bkduptodtcr,
                        lv_bkd_upto_amt_cr,
                        abs(lv_bkd_amt_today_cr),
                        lv_appltrandtcr,
                        lv_appl_upto_amt_cr,
                        0,
                        lv_segment, lv_subsegment, lv_freecode7,
                        lv_rcreuserid, lv_rcretime, lv_lchguserid,
                        lv_lchgtime, lv_bankid,lv_unique_id
                       );
                       COMMIT;
                        BEGIN
              --{
                SELECT part_tran_srl_num, tran_particular, tran_amt,
                tran_particular_2, tran_rmks, part_tran_type,
                tran_crncy_code
                INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                lv_tranpart2, lv_tranrmks, lv_ptrantype,
                lv_trancrncy
                FROM tbaadm.dctd_acli
                WHERE tran_id = LPAD (lv_bkdtranidcr, 9)
                AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                     OR (acid = lv_pandl_glacid))
                AND tran_date = lv_bkduptodtcr
                AND pstd_flg = 'Y'
                AND del_flg != 'Y'
                AND bank_id = lv_bankid
                AND ROWNUM < 2;
               EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
               NULL;
              --}
               END;

        INSERT INTO c_eit
              (tran_date, bacid, gl_acct_no, tran_id,
               part_tran_srl_num, tran_amt, tran_crncy,
               part_tran_type, tran_particular, tran_particular_2,
               tran_remarks, customer_account_no, sol_id,
               schm_type, schm_code, eod_closing_balance,
               eod_un_clr_bal_amt, eod_future_bal_amt,
               eod_lien_amt, gl_sub_head_code, int_coll_flag,
               int_paid_flag, debit_credit_ind, interest_rate,
               int_appl_flg, accrued_upto_date,
               accrued_upto_amount,
               accrued_amount_today,
               booked_upto_date,
               booked_upto_amount,
               booked_amount_today,
               applied_upto_date,
               applied_upto_amount,
               applied_amount_today,
               SEGMENT, sub_segment, free_code_7,
               rcre_user_id, rcre_time, lchg_user_id,
               lchg_time, bank_id,unq_identifier
              )
           VALUES (lv_bkduptodtcr, lv_pandl_bacid, lv_pandl_glacc, lv_bkdtranidcr,
               lv_ptransrlnum, lv_tranamt, lv_trancrncy,
               lv_ptrantype, lv_tranpart, lv_tranpart2,
               lv_tranrmks, lv_foracid, lv_solid,
               lv_schm_type, lv_schm_code, lv_eodbal,
               lv_unclrbalamt, lv_futbalamt,
               lv_lienamt, lv_glsub, lv_intcollflg,
               lv_intpdflg, DECODE(lv_credit_debit_ind,'C','D','C'), lv_intrate,
               lv_bkdappl_flg, lv_accruptodtcr,
               lv_accr_upto_amt_cr,
               lv_accr_amt_today_cr,
               lv_bkduptodtcr,
               lv_bkd_upto_amt_cr,
               abs(lv_bkd_amt_today_cr),
               lv_appltrandtcr,
               lv_appl_upto_amt_cr,
               0,
               lv_segment, lv_subsegment, lv_freecode7,
               lv_rcreuserid, lv_rcretime, lv_lchguserid,
               lv_lchgtime, lv_bankid,lv_unique_id
                       );


                   COMMIT;


                EXCEPTION
                   WHEN OTHERS
                   THEN
            --DBMS_OUTPUT.put_line (SQLERRM);

                  out_rec := out_rec || 'fail';
                --}
                END;

            <<booknextrec2>>
            out_rec := out_rec || '| Fetch next rec |';
             --}
             END IF;


         --}
         END IF;
   END c_eit_book_tran_fetch_proc_oda;

   PROCEDURE c_eit_tran_fetch_proc_bonus (
         lv_bkduptodt           IN       DATE,
         lv_bkdtranid           IN       VARCHAR2,
         lv_acctcrncy           IN       VARCHAR2,
         lv_foracid             IN       VARCHAR2,
         lv_solid               IN       VARCHAR2,
         lv_schm_type           IN       VARCHAR2,
         lv_schm_code           IN       VARCHAR2,
         lv_eodbal              IN       NUMBER,
         lv_unclrbalamt         IN       NUMBER,
         lv_futbalamt           IN       NUMBER,
         lv_lienamt             IN       NUMBER,
         lv_glsub               IN       VARCHAR2,
         lv_intcollflg          IN       CHAR,
         lv_intpdflg            IN       CHAR,
         lv_crdrflg             IN       CHAR,
         lv_intrate             IN       NUMBER,
         lv_bkdappl_flg         IN       CHAR,
         lv_accruptodt          IN       DATE,
         lv_accr_upto_amt_cr    IN       NUMBER,
         lv_accr_upto_amt_dr    IN       NUMBER,
         lv_accr_amt_today_cr   IN OUT   NUMBER,
         lv_accr_amt_today_dr   IN OUT   NUMBER,
         lv_bkd_upto_amt_cr     IN       NUMBER,
         lv_bkd_upto_amt_dr     IN       NUMBER,
         lv_bkd_amt_today_cr    IN OUT   NUMBER,
         lv_bkd_amt_today_dr    IN OUT   NUMBER,
         lv_appltrandt          IN       DATE,
         lv_appl_upto_amt_cr    IN       NUMBER,
         lv_appl_upto_amt_dr    IN       NUMBER,
         lv_appl_amt_today_cr   IN OUT   NUMBER,
         lv_appl_amt_today_dr   IN OUT   NUMBER,
         lv_segment             IN       VARCHAR2,
         lv_subsegment          IN       VARCHAR2,
         lv_freecode7           IN       VARCHAR2,
         lv_rcreuserid          IN       VARCHAR2,
         lv_rcretime            IN       DATE,
         lv_lchguserid          IN       VARCHAR2,
         lv_lchgtime            IN       DATE,
         lv_bankid              IN       VARCHAR2,
         out_rec                OUT      VARCHAR2,
         lv_bkdamtdr_ovdu       IN       NUMBER,
         lv_applamtdr_ovdu      IN       NUMBER,
         lv_accramtdr_ovdu      IN       NUMBER,
         lv_bkd_penal_amt_today_dr  IN    NUMBER,
         lv_acid             IN       VARCHAR2,
         lv_bonusBooking    IN        CHAR,
         lv_bonusApp        IN        CHAR,
         lv_eitdate            IN        DATE,
         lv_unique_id        IN     VARCHAR2
      )
      AS
         lv_bacid         tbaadm.gam.bacid%TYPE;
         lv_glacid        tbaadm.gam.acid%TYPE;
         lv_glacc         tbaadm.gam.foracid%TYPE;
         lv_ptransrlnum   tbaadm.dtd.part_tran_srl_num%TYPE;
         lv_tranpart      tbaadm.dtd.tran_particular%TYPE;
         lv_tranamt       tbaadm.dtd.tran_amt%TYPE;
         lv_tranpart2     tbaadm.dtd.tran_particular_2%TYPE;
         lv_tranrmks      tbaadm.dtd.tran_rmks%TYPE;
         lv_ptrantype     tbaadm.dtd.part_tran_type%TYPE;
         lv_trancrncy     tbaadm.dtd.tran_crncy_code%TYPE;
         lv_errmsg        VARCHAR2 (100);
         lv_trancount     NUMBER;
         lv_pandl_bacid   tbaadm.gam.bacid%TYPE;
     lv_pandl_glacid  tbaadm.gam.acid%TYPE;
     lv_pandl_glacc   tbaadm.gam.foracid%TYPE;

      BEGIN
         --{
         IF (lv_crdrflg != 'N')
         THEN


            BEGIN
            --{

           -------------------------------------------------------------

            -- Fetching payable bacid for account.

           -------------------------------------------------------------

        SELECT  int_paid_bacid,INT_PANDL_BACID_CR

        INTO lv_bacid,lv_pandl_bacid
        FROM tbaadm.gsp p
        WHERE p.schm_code = lv_schm_code
        AND p.bank_id = lv_bankid;


               --out_rec := out_rec || '| After payable/receivable a/c fetch|';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  out_rec :=out_rec|| 'tbaadm.gsp query didnt fetch any Record  '|| lv_schm_code;

                  GOTO bonusnextrec;
            --}
            END;

               -------------------------------------------------------------

                -- fetching account id for above fetched bacid

                -------------------------------------------------------------
                BEGIN
                --{
                       SELECT acid, foracid
                     INTO lv_glacid, lv_glacc
                     FROM tbaadm.gam g
                    WHERE bacid = lv_bacid
                      AND sol_id = lv_solid
                      AND acct_crncy_code = lv_acctcrncy
                      AND bank_id = lv_bankid;

                      SELECT acid, foracid
            INTO lv_pandl_glacid, lv_pandl_glacc
            FROM tbaadm.gam g
            WHERE bacid = lv_pandl_bacid
            AND sol_id = lv_solid
            AND acct_crncy_code = lv_acctcrncy
                      AND bank_id = lv_bankid;

                       --out_rec := out_rec || '| After payable/receivable a/c fetch|';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                  out_rec :=
                     out_rec || 'tbaadm.gsp query didnt fetch any Record  ' || lv_bacid;
                  GOTO bonusnextrec;
                --}
                END;

          IF(lv_bonusBooking='Y')
          THEN
          --{
              FOR v_tranfetch IN bibtranfetch_cur (lv_acid,lv_eitdate,lv_bankid)

                       LOOP
                       --{
                                 -----------------------------------------

                           -- fetching tran details from tbaadm.dctd_acli

                           -----------------------------------------
                           BEGIN
                              --{

                    SELECT part_tran_srl_num, tran_particular, tran_amt,
                    tran_particular_2, tran_rmks, part_tran_type,
                    tran_crncy_code
                    INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                    lv_tranpart2, lv_tranrmks, lv_ptrantype,
                    lv_trancrncy
                    FROM tbaadm.dctd_acli
                    WHERE tran_id = LPAD (DECODE (v_tranfetch.status_flg, 'R',v_tranfetch.rev_tran_id,v_tranfetch.tran_id), 9)
                    AND acid=lv_glacid
                    AND tran_date = lv_eitdate
                    AND pstd_flg = 'Y'
                    AND del_flg != 'Y'
                    AND bank_id = lv_bankid
                    AND ROWNUM < 2;


                              --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                                 lv_ptransrlnum:='';
                                 lv_tranpart:='';
                                 lv_tranamt:='';
                                 lv_tranpart2:='';
                                 lv_tranrmks:='';
                                 lv_ptrantype:='';
                                 lv_trancrncy:='';


                           --}
                           END;

                           out_rec := out_rec || '| BEFORE INSERT |';



                           BEGIN
                              --{

                              IF(lv_tranrmks='')
                              THEN
                              lv_tranrmks:='Bonus Interest Booking';
                              END IF;
                              lv_bkd_amt_today_cr:=v_tranfetch.bonus_bkd_amt;

                              -------------------------------------------------------------

                              -- C_EIT insert.

                              -------------------------------------------------------------
                              INSERT INTO c_eit
                                          (tran_date, bacid, gl_acct_no, tran_id,
                                           part_tran_srl_num, tran_amt, tran_crncy,
                                           part_tran_type, tran_particular, tran_particular_2,
                                           tran_remarks, customer_account_no, sol_id,
                                           schm_type, schm_code, eod_closing_balance,
                                           eod_un_clr_bal_amt, eod_future_bal_amt,
                                           eod_lien_amt, gl_sub_head_code, int_coll_flag,
                                           int_paid_flag, debit_credit_ind, interest_rate,
                                           int_appl_flg, accrued_upto_date,
                                           accrued_upto_amount,
                                           accrued_amount_today,
                                           booked_upto_date,
                                           booked_upto_amount,
                                           booked_amount_today,
                                           applied_upto_date,
                                           applied_upto_amount,
                                           applied_amount_today,
                                           SEGMENT, sub_segment, free_code_7,
                                           rcre_user_id, rcre_time, lchg_user_id,
                                           lchg_time, bank_id,unq_identifier
                                          )
                                   VALUES (lv_eitdate, lv_bacid, lv_glacc, DECODE (v_tranfetch.status_flg, 'R',v_tranfetch.rev_tran_id,v_tranfetch.tran_id),
                                           lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                                           lv_ptrantype, lv_tranpart, lv_tranpart2,
                                           lv_tranrmks, lv_foracid, lv_solid,
                                           lv_schm_type, lv_schm_code, lv_eodbal,
                                           lv_unclrbalamt, lv_futbalamt,
                                           lv_lienamt, lv_glsub, lv_intcollflg,
                                           lv_intpdflg, DECODE (v_tranfetch.status_flg, 'R', 'D', 'C'), lv_intrate,
                                           'B', lv_accruptodt,
                                           DECODE (lv_crdrflg,
                                                   'C', lv_accr_upto_amt_cr,
                                                   lv_accr_upto_amt_dr
                                                  ),
                                           DECODE (lv_crdrflg,
                                                   'C', lv_accr_amt_today_cr,
                                                   lv_accr_amt_today_dr
                                                  ),
                                           lv_bkduptodt,
                                           DECODE (lv_crdrflg,
                                                   'C', lv_bkd_upto_amt_cr,
                                                   lv_bkd_upto_amt_dr
                                                  ),
                                           abs(lv_bkd_amt_today_cr),
                                           lv_appltrandt,
                                           DECODE (lv_crdrflg,
                                                   'C', lv_appl_upto_amt_cr,
                                                   lv_appl_upto_amt_dr
                                                  ),
                                           0,
                                           lv_segment, lv_subsegment, lv_freecode7,
                                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                           lv_lchgtime, lv_bankid,lv_unique_id
                                          );

                                          COMMIT;
                                          BEGIN
                          --{

                        SELECT part_tran_srl_num, tran_particular, tran_amt,
                        tran_particular_2, tran_rmks, part_tran_type,
                        tran_crncy_code
                        INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                        lv_tranpart2, lv_tranrmks, lv_ptrantype,
                        lv_trancrncy
                        FROM tbaadm.dctd_acli
                        WHERE tran_id = LPAD (DECODE (v_tranfetch.status_flg, 'R',v_tranfetch.rev_tran_id,v_tranfetch.tran_id), 9)
                        AND acid=lv_pandl_glacid
                        AND tran_date = lv_eitdate
                        AND pstd_flg = 'Y'
                        AND del_flg != 'Y'
                        AND bank_id = lv_bankid
                        AND ROWNUM < 2;

                         EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                            NULL;


                           --}
                                      END;

                                         INSERT INTO c_eit
                                          (tran_date, bacid, gl_acct_no, tran_id,
                                           part_tran_srl_num, tran_amt, tran_crncy,
                                           part_tran_type, tran_particular, tran_particular_2,
                                           tran_remarks, customer_account_no, sol_id,
                                           schm_type, schm_code, eod_closing_balance,
                                           eod_un_clr_bal_amt, eod_future_bal_amt,
                                           eod_lien_amt, gl_sub_head_code, int_coll_flag,
                                           int_paid_flag, debit_credit_ind, interest_rate,
                                           int_appl_flg, accrued_upto_date,
                                           accrued_upto_amount,
                                           accrued_amount_today,
                                           booked_upto_date,
                                           booked_upto_amount,
                                           booked_amount_today,
                                           applied_upto_date,
                                           applied_upto_amount,
                                           applied_amount_today,
                                           SEGMENT, sub_segment, free_code_7,
                                           rcre_user_id, rcre_time, lchg_user_id,
                                           lchg_time, bank_id,unq_identifier
                                          )
                                   VALUES (lv_eitdate, lv_pandl_bacid, lv_pandl_glacc, DECODE (v_tranfetch.status_flg, 'R',v_tranfetch.rev_tran_id,v_tranfetch.tran_id),
                                           lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                                           lv_ptrantype, lv_tranpart, lv_tranpart2,
                                           lv_tranrmks, lv_foracid, lv_solid,
                                           lv_schm_type, lv_schm_code, lv_eodbal,
                                           lv_unclrbalamt, lv_futbalamt,
                                           lv_lienamt, lv_glsub, lv_intcollflg,
                                           lv_intpdflg, DECODE (v_tranfetch.status_flg, 'R', 'C', 'D'), lv_intrate,
                                           'B', lv_accruptodt,
                                           DECODE (lv_crdrflg,
                                                   'C', lv_accr_upto_amt_cr,
                                                   lv_accr_upto_amt_dr
                                                  ),
                                           DECODE (lv_crdrflg,
                                                   'C', lv_accr_amt_today_cr,
                                                   lv_accr_amt_today_dr
                                                  ),
                                           lv_bkduptodt,
                                           DECODE (lv_crdrflg,
                                                   'C', lv_bkd_upto_amt_cr,
                                                   lv_bkd_upto_amt_dr
                                                  ),
                                           abs(lv_bkd_amt_today_cr),
                                           lv_appltrandt,
                                           DECODE (lv_crdrflg,
                                                   'C', lv_appl_upto_amt_cr,
                                                   lv_appl_upto_amt_dr
                                                  ),
                                           0,
                                           lv_segment, lv_subsegment, lv_freecode7,
                                           lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                           lv_lchgtime, lv_bankid,lv_unique_id
                                          );

                                     --DBMS_OUTPUT.put_line (SQLERRM);

                              COMMIT;
                             --DBMS_OUTPUT.put_line (SQLERRM);

                           EXCEPTION
                              WHEN OTHERS
                              THEN
                                --DBMS_OUTPUT.put_line (SQLERRM);

                                 out_rec := out_rec || 'inser fail';
                           --}
                        END;

                       --}
                       END LOOP;
          --}
          END IF;

               IF(lv_bonusApp='Y')
                  THEN
                  --{
                      FOR v_tranfetch IN biatranfetch_cur (lv_acid,lv_eitdate,lv_bankid)

                               LOOP
                               --{
                                      -----------------------------------------

                                   -- fetching tran details from tbaadm.dctd_acli

                                   -----------------------------------------
                                   BEGIN
                                      --{
                                          SELECT COUNT (1)
                                            INTO lv_trancount
                                            FROM tbaadm.dctd_acli
                                           WHERE tran_id = LPAD (v_tranfetch.tran_id, 9)
                                             AND part_tran_type = 'D'
                                             AND tran_date = lv_eitdate
                                             AND pstd_flg = 'Y'
                                             AND del_flg != 'Y'
                                             AND bank_id = lv_bankid;

                                      IF (lv_trancount != 0)
                                      THEN
                                      --{
                                             SELECT part_tran_srl_num, tran_particular, tran_amt,
                                      tran_particular_2, tran_rmks, part_tran_type,
                                      tran_crncy_code
                                      INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                                      lv_trancrncy
                                      FROM tbaadm.dctd_acli
                                      WHERE tran_id = LPAD (v_tranfetch.tran_id, 9)
                                    AND part_tran_type = 'D'
                                    AND tran_date = lv_eitdate
                                    AND pstd_flg = 'Y'
                                    AND del_flg != 'Y'
                                          AND bank_id = lv_bankid
                                      AND ROWNUM < 2;
                                      --}
                                      END IF;

                                      --out_rec := out_rec || '| After tbaadm.dctd_acli query 1|';
                                   EXCEPTION
                                      WHEN NO_DATA_FOUND
                                      THEN
                                         --out_rec :=out_rec|| 'tbaadm.dctd_acli query didnt fetch any Record 1 '|| lv_bkdtranid;
                                         lv_ptransrlnum:='';
                                         lv_tranpart:='';
                                         lv_tranamt:='';
                                         lv_tranpart2:='';
                                         lv_tranrmks:='';
                                         lv_ptrantype:='';
                                         lv_trancrncy:='';

                                   -- GOTO bonusnextrec;

                                   --}
                                   END;

                                   DBMS_OUTPUT.put_line (lv_ptransrlnum);
                                   DBMS_OUTPUT.put_line (lv_tranpart);
                                   DBMS_OUTPUT.put_line (lv_tranamt);
                                   DBMS_OUTPUT.put_line (lv_glacc);
                                   out_rec := out_rec || '| BEFORE INSERT |';



                                   BEGIN
                                      --{

                                      IF(lv_tranrmks='')
                                      THEN
                                      lv_tranrmks:='Bonus Interest Application';
                                      END IF;
                                      lv_appl_amt_today_cr:=v_tranfetch.bonus_amt;

                                      -------------------------------------------------------------

                                      -- C_EIT insert.

                                      -------------------------------------------------------------
                                      INSERT INTO c_eit
                                                  (tran_date, bacid, gl_acct_no, tran_id,
                                                   part_tran_srl_num, tran_amt, tran_crncy,
                                                   part_tran_type, tran_particular, tran_particular_2,
                                                   tran_remarks, customer_account_no, sol_id,
                                                   schm_type, schm_code, eod_closing_balance,
                                                   eod_un_clr_bal_amt, eod_future_bal_amt,
                                                   eod_lien_amt, gl_sub_head_code, int_coll_flag,
                                                   int_paid_flag, debit_credit_ind, interest_rate,
                                                   int_appl_flg, accrued_upto_date,
                                                   accrued_upto_amount,
                                                   accrued_amount_today,
                                                   booked_upto_date,
                                                   booked_upto_amount,
                                                   booked_amount_today,
                                                   applied_upto_date,
                                                   applied_upto_amount,
                                                   applied_amount_today,
                                                   SEGMENT, sub_segment, free_code_7,
                                                   rcre_user_id, rcre_time, lchg_user_id,
                                                   lchg_time, bank_id,unq_identifier
                                                  )
                                           VALUES (lv_eitdate, lv_bacid, lv_glacc, v_tranfetch.tran_id,
                                                   lv_ptransrlnum, lv_tranamt, lv_trancrncy,
                                                   lv_ptrantype, lv_tranpart, lv_tranpart2,
                                                   lv_tranrmks, lv_foracid, lv_solid,
                                                   lv_schm_type, lv_schm_code, lv_eodbal,
                                                   lv_unclrbalamt, lv_futbalamt,
                                                   lv_lienamt, lv_glsub, lv_intcollflg,
                                                   lv_intpdflg, 'D', lv_intrate,
                                                   'A', lv_accruptodt,
                                                   DECODE (lv_crdrflg,
                                                           'C', lv_accr_upto_amt_cr,
                                                           lv_accr_upto_amt_dr
                                                          ),
                                                   DECODE (lv_crdrflg,
                                                           'C', lv_accr_amt_today_cr,
                                                           lv_accr_amt_today_dr
                                                          ),
                                                   lv_bkduptodt,
                                                   DECODE (lv_crdrflg,
                                                           'C', lv_bkd_upto_amt_cr,
                                                           lv_bkd_upto_amt_dr
                                                          ),
                                                   0,
                                                   lv_appltrandt,
                                                   DECODE (lv_crdrflg,
                                                           'C', lv_appl_upto_amt_cr,
                                                           lv_appl_upto_amt_dr
                                                          ),
                                                   abs(lv_appl_amt_today_cr),
                                                   lv_segment, lv_subsegment, lv_freecode7,
                                                   lv_rcreuserid, lv_rcretime, lv_lchguserid,
                                                   lv_lchgtime, lv_bankid,lv_unique_id
                                                  );
                                             --DBMS_OUTPUT.put_line (SQLERRM);

                                      COMMIT;
                                     --DBMS_OUTPUT.put_line (SQLERRM);

                                   EXCEPTION
                                      WHEN OTHERS
                                      THEN
                                        --DBMS_OUTPUT.put_line (SQLERRM);

                                         out_rec := out_rec || 'insert fail';
                                   --}
                                END;

                               --}
                               END LOOP;
                  --}
          END IF;


            <<bonusnextrec>>
            out_rec := out_rec || '| Fetch next rec |';
         --}
         END IF;
   END c_eit_tran_fetch_proc_bonus;
END c_eit_tran_fetch_pack;
/

CREATE OR REPLACE SYNONYM tbaadm.c_eit_tran_fetch_pack FOR custom.c_eit_tran_fetch_pack
/
CREATE OR REPLACE SYNONYM tbagen.c_eit_tran_fetch_pack FOR custom.c_eit_tran_fetch_pack
/
CREATE OR REPLACE SYNONYM tbautil.c_eit_tran_fetch_pack FOR custom.c_eit_tran_fetch_pack
/
GRANT EXECUTE ON custom.c_eit_tran_fetch_pack TO tbagen,tbautil,tbaadm
/

--====================================================================================================
-- Name                                   : CommonPackage.sql
-- Date                                   : 22-07-2013
-- Description                            : This sql script is used to procedures and functions
-- Author                                 : Nithya Murugesan 
-- Bank                                   : EQUITY BANK
-- Modification History   :
-- <Version No.>    <Date>        <Author Name>          <Description>
--  0.1             22-07-2013    Nithya Murugesan      Modified the function eabBal.   
--====================================================================================================
CREATE OR REPLACE PACKAGE tbaadm.CommonPackage AS
-----------------------------------------------------------------------
-- PROCEDURE getRctDesc
-- Gets the ref_desc for a given ref_rec_type and ref_code.
-----------------------------------------------------------------------
PROCEDURE getRctDesc(inp_bank_id     IN varchar2, 
                    inp_rec_ref_type IN varchar2,
                    inp_ref_code IN varchar2,
                    out_ref_desc OUT varchar2);

-----------------------------------------------------------------------
-- PROCEDURE getAcctSanctionLimit
-- Gets the Sanction Limit for an A/c.
-----------------------------------------------------------------------
PROCEDURE getAcctSanctionLimit( inp_bank_id         IN    varchar2,
                                inp_asOnDate        IN    DATE,
                                inp_acid            IN    VARCHAR2,
                                out_sanction_lim    OUT   NUMBER);

-----------------------------------------------------------------------
-- PROCEDURE isAcctRenewalPending
-- Checks if sanction limit is pending for renewal
-----------------------------------------------------------------------
PROCEDURE isAcctRenewalPending(inp_bank_id         IN    varchar2,
                               inp_asOnDate            IN    DATE,
                                inp_acid                IN    VARCHAR2,
                                out_renewal_pending_flg    OUT NUMBER);

-----------------------------------------------------------------------
-- PROCEDURE isSecurityOverDue
-- Checks if sanction limit is pending for renewal
-----------------------------------------------------------------------
PROCEDURE isSecurityOverDue(inp_bank_id         IN    varchar2,
                            inp_asOnDate        IN    DATE,
                            inp_acid            IN    VARCHAR2,
                            inp_secu_type_ind    IN    VARCHAR2,
                            out_sec_overdue_flg    OUT NUMBER);

-----------------------------------------------------------------------
-- PROCEDURE getAcctDrawingPower
-- Gets the Drawing Power for an A/c.
-----------------------------------------------------------------------
PROCEDURE getAcctDrawingPower(inp_bank_id         IN    varchar2,
                              inp_asOnDate        IN    DATE,
                              inp_acid            IN    VARCHAR2,
                              out_drawing_power   OUT NUMBER);

-----------------------------------------------------------------------
-- Sarvjeet  FUNCTION getSanctioningAuthority
-- Gets the latest Sanctioning authority of an account as on given date
-----------------------------------------------------------------------
FUNCTION getAcctSanctionLimitFunc(inp_bank_id    IN    varchar2, 
                                   inp_asOnDate  IN DATE,
                                   inp_acid      IN VARCHAR2) RETURN NUMBER;
-----------------------------------------------------------------------

-------------------------------------------------------------------------
-- PROCEDURE getFrequencyNextDate
-- Gets the Next Frequency Date for a loan installment
-----------------------------------------------------------------------
PROCEDURE getFrequencyNextDate(inp_bank_id    IN    varchar2,
                               freq_code        IN VARCHAR2,
                               freq_week_num    IN char,
                               freq_week_day    IN NUMBER,
                               freq_start_dd    IN NUMBER,
                               in_date            IN date,
                               out_date         OUT date);
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------
-- FUNCTION getSanctioningAuthority
-- Gets the latest Sanctioning authority of an account as on given date
-----------------------------------------------------------------------
FUNCTION getSanctioningAuthority(inp_bank_id    IN    varchar2, inp_asOnDate        IN    DATE, inp_acid        IN    VARCHAR2) RETURN VARCHAR2;
-----------------------------------------------------------------------
-- FUNCTION getSanctioningLevelAuth
-- Gets the latest Sanctioning authority level of an account as on given date
-----------------------------------------------------------------------
FUNCTION getSanctioningAuthLevel(inp_bank_id    IN    varchar2, inp_asOnDate        IN    DATE, inp_acid            IN    VARCHAR2) RETURN VARCHAR2;

FUNCTION getBudgetAmount (inp_bank_id    IN    varchar2,
                          inp_asOnDate   IN         DATE, inp_Solid        IN        VARCHAR2, inp_gl_subhead   IN         VARCHAR2) RETURN NUMBER;

-----------------------------------------------------------------------
-- FUNCTION getIntTblCode
-- Gets the Interest Table Code
-----------------------------------------------------------------------
FUNCTION getIntTableCode(inp_bank_id    IN    varchar2,
                         inp_asOnDate       IN  VARCHAR2,
                         inp_changeUpToDate  IN  VARCHAR2,
                         inp_acid            IN  VARCHAR2) RETURN VARCHAR2;


-----------------------------------------------------------------------
-- PROCEDURE getAcctSanctionLimitForPeriod
-- Gets the Sanction Limit for an A/c.
-----------------------------------------------------------------------
PROCEDURE getAcctSanctionLimitForPeriod(inp_bank_id IN varchar2,
                                inp_fromDate        IN DATE,
                                inp_toDate            IN DATE,
                                inp_acid            IN VARCHAR2,
                                out_sanction_lim    OUT NUMBER);

-----------------------------------------------------------------------
-- PROCEDURE getTOD_UnregularizedAmtForPer
-- Gets the Sanction Limit for an A/c.
-----------------------------------------------------------------------
PROCEDURE getTOD_UnregularizedAmtForPer(inp_bank_id IN varchar2,
                                inp_fromDate       IN DATE,
                                inp_toDate          IN DATE,
                                inp_acid            IN VARCHAR2,
                                out_availed_amt    OUT NUMBER);


-----------------------------------------------------------------------
-- PROCEDURE getLimitIdSanctionLimit
-- Gets the Sanction Limit of Limit Id as on given date
-----------------------------------------------------------------------
PROCEDURE getLimitIdSanctionLimit(  inp_bank_id IN varchar2,
                                    inp_asOnDate        IN DATE,
                                    inp_limitId            IN VARCHAR2,
                                    out_sanction_lim    OUT NUMBER,
                                    out_crncy_code      OUT VARCHAR2);

-----------------------------------------------------------------------
-- PROCEDURE get_PlGlsubheadCode_AsonAmt
-- Gets the amount of Glsubheadcode as on given date
-- This procedure can be called by Income and Expenses Glsubhead codes only.
-- For Income and Expenses Glsubhead codes amount will be initialised to zero after the end of september
-- so in this procedure's return amount will be the sum of ason date and end sep amount
-----------------------------------------------------------------------
PROCEDURE get_PlGlsubheadCode_AsonAmt ( inp_bank_id IN varchar2,
                                        ip_glsubheadcode    IN  varchar2,
                                        ip_sol_id           IN  varchar2,
                                        ip_crncy_code       IN  varchar2,
                                        ip_asOnDate         IN  date,
                                        out_ason_amount     OUT NUMBER);

-----------------------------------------------------------------------
-- FUNCTION get_GlsubheadCode_AsonAmt
-- Gets the amount of Glsubheadcode as on given date
-----------------------------------------------------------------------
FUNCTION get_GlsubheadCode_AsonAmt (inp_bank_id IN varchar2,
                       ip_glsubheadcode  IN varchar2,
                       ip_sol_id            IN varchar2,
                       ip_crncy_code        IN varchar2,
                       asOnDate             IN date) RETURN NUMBER;

-----------------------------------------------------------------------
-- PROCEDURE getDisbursementAmount
-- Gets the Disbursed amount till the given date
-----------------------------------------------------------------------
FUNCTION getDisbursementAmount (inp_bank_id IN varchar2,
                                inp_asOnDate    IN DATE,
                                inp_acid        IN VARCHAR2) RETURN NUMBER;

-----------------------------------------------------------------------
-- PROCEDURE getDisbursementAmountForPeriod
-- Gets the Disbursed amount between from date and to date
-----------------------------------------------------------------------
FUNCTION getDisbursementAmountForPeriod (inp_bank_id IN varchar2,
                                         inp_fromDate    IN DATE,
                                         inp_toDate        IN DATE,
                                         inp_acid        IN VARCHAR2) RETURN NUMBER;
-----------------------------------------------------------------------
-- FUNCTION getFirstSanctionDate
-- Gets the First Sanction Date for an A/c as on given date
-----------------------------------------------------------------------
FUNCTION getFirstSanctionDate(inp_bank_id IN varchar2,
                            inp_asOnDate        IN DATE,
                            inp_acid            IN VARCHAR2,
                            inp_acct_opn_date    IN DATE) RETURN DATE;

-----------------------------------------------------------------------
-- FUNCTION getDocumentDate
-- Gets the Document Date for an A/c as on given date
-----------------------------------------------------------------------
FUNCTION getDocumentDate(  inp_bank_id IN varchar2,
                           inp_asOnDate        IN DATE,
                           inp_acid            IN VARCHAR2,
                           inp_acct_opn_date   IN DATE) RETURN DATE;

-----------------------------------------------------------------------
-- FUNCTION getLastSanctionDate
-- Gets the Last Sanction Date for an A/c as on given date
-----------------------------------------------------------------------
FUNCTION getLastSanctionDate ( inp_bank_id IN varchar2,
                               inp_asOnDate IN DATE,
                               inp_acid     IN VARCHAR2,
                               inp_acct_opn_date IN DATE) RETURN DATE;

-----------------------------------------------------------------------
-- FUNCTION getLastExpiryDate
-- Gets the Last Expiry Date for an A/c as on given date
-----------------------------------------------------------------------
FUNCTION getLastExpiryDate ( inp_bank_id IN varchar2,
                             inp_asOnDate IN DATE,
                             inp_acid      IN VARCHAR2,
                             inp_acct_opn_date IN DATE) RETURN DATE;

-----------------------------------------------------------------------
-- FUNCTION eabBal
-- Gets the Account balance as on given date
-----------------------------------------------------------------------
FUNCTION eabBal(inp_bank_id  varchar2,v_acid            varchar2,
                v_as_on_date    DATE) RETURN NUMBER;
-----------------------------------------------------------------------
-- FUNCTION getlatestbalconfdate
-- Gets the Latest Balance Confirmation Date
-- Input     :Foracid
-- Output     :Date
-----------------------------------------------------------------------
--PROCEDURE getlatestbalconfdate(inp_foracid IN VARCHAR2,conf_date OUT DATE);

-----------------------------------------------------------------------
-- FUNCTION eabBalexclintsusp
-- Gets the Account balance excluding interest in suspense,as on given date
-----------------------------------------------------------------------
FUNCTION eabBalexclintsusp(inp_bank_id  varchar2, v_acid            varchar2, v_as_on_date    DATE) RETURN NUMBER;

FUNCTION getGlBalLcy     (inp_bank_id  varchar2,
                          setId            varchar2,
                           glCode            varchar2,
                          glTransDate        date ) RETURN NUMBER ;

FUNCTION getGlBalFcy(    inp_bank_id  varchar2,
                         setId            varchar2,
                         glCode            varchar2,
                         glTransDate        date)  RETURN NUMBER ;

FUNCTION getGlSubHeadBalLcy(inp_bank_id  varchar2,setId varchar2, glSubheadCode varchar2, glTransDate    date) RETURN NUMBER;


FUNCTION getGlSubHeadBalFcy(inp_bank_id  varchar2,
                            iSetId varchar2,
                            glSubHeadCode varchar2,
                            inpAsOnDate date) RETURN NUMBER;

FUNCTION getConvertedAmount(    inp_bank_id  varchar2,
                                balance NUMBER,
                                fCrncyCode VARCHAR2,
                                iCrncyCode VARCHAR2,
                                inpRateCode    VARCHAR2,
                                inpAsOnDate DATE) return NUMBER;

FUNCTION getConvRate(    inp_bank_id  varchar2,
                         fixedCrncyCode     varchar2,
                         varCrncyCode     varchar2,
                         Rate_Code         varchar2,
                         inpAsOnDate     date) RETURN NUMBER ;

FUNCTION getAvgBal( inp_bank_id  varchar2,
                    acctAcid VARCHAR2,
                    fromDate DATE,
                    toDate DATE) RETURN NUMBER;


FUNCTION calculateprovisionheldSchmCode(inp_bank_id  varchar2,
                                        schmCode   tbaadm.gam.schm_code%type,
                                        asOnDate   date) RETURN NUMBER ;

FUNCTION calculateProvisionheldYearly(inp_bank_id  varchar2,
                                      acctid   tbaadm.gam.acid%type,
                                      trandate tbaadm.gam.acct_cls_date%type) RETURN NUMBER ;

PROCEDURE getAssetClassfnDetails(   inp_bank_id  varchar2,
                                    inputDate            IN DATE,
                                    accountId            IN VARCHAR2,
                                    assetClassfnSrlNum    OUT    VARCHAR2,
                                    userMainClassfnCode    OUT    VARCHAR2,
                                    userSubClassfnCode    OUT    VARCHAR2,
                                    userClassfnDate        OUT    VARCHAR2);

PROCEDURE getClassfnofAsset(inp_bank_id  varchar2,
                            inputDate           IN DATE,
                            accountId           IN VARCHAR2,
                            lv_stdregular        OUT NUMBER,
                            lv_stdirregular        OUT NUMBER,
                            lv_substandard        OUT NUMBER,
                            lv_doubtfulassets    OUT NUMBER,
                            lv_lossassets        OUT NUMBER);


FUNCTION selAchCode(        inp_bank_id  varchar2,
                            inputdate        DATE,
                            accountId        VARCHAR2) RETURN VARCHAR2;

FUNCTION selNpaOrNot(       inp_bank_id  varchar2,
                            inputdt        DATE,
                            acctid        VARCHAR2) RETURN NUMBER;

PROCEDURE linktblcode(      inp_bank_id  varchar2,
                            inp_crncycode IN VARCHAR2,
                            inp_bod_date IN DATE,
                            inp_tblCode IN VARCHAR2,
                            out_flag OUT NUMBER,
                            out_interestRate OUT NUMBER);

FUNCTION isLinkedtoBaseTblCode( inp_bank_id  varchar2,
                                intTableCode VARCHAR2,
                                baseTblCode VARCHAR2,
                                crncyCode VARCHAR2) RETURN INTEGER;

PROCEDURE getBaseRate(      inp_bank_id  varchar2,
                            intTableCode IN VARCHAR2,
                            asOnDate IN DATE,
                            crncyCode IN VARCHAR2,
                            foundFlg OUT INTEGER,
                            baseRate OUT NUMBER);

FUNCTION getTranAmtForPeriod(    inp_bank_id  varchar2,
                                 StartDate    tbaadm.eab.eod_date%type,
                                 EndDate     tbaadm.eab.eod_date%type,
                                 AccountId   tbaadm.gam.acid%type) RETURN NUMBER;

FUNCTION eabBalInAED(inp_bank_id  varchar2,
                     inpacid   VARCHAR2,
                   inpAsOnDate DATE) RETURN NUMBER;


--------------------------------------------------------------------------------
FUNCTION GetEABValueBal(inp_bank_id  varchar2, v_foracid       varchar2,
                        v_as_on_date    date) RETURN NUMBER;
---------------------------------------------------------------------------------


FUNCTION eabBalForacid( inp_bank_id  varchar2, v_foracid  varchar2,
                                v_as_on_date   date) RETURN NUMBER;

FUNCTION getDemandAmount (    inp_bank_id     IN  varchar2,
                              inp_asOnDate    IN DATE,
                              inp_acid        IN VARCHAR2) RETURN NUMBER;

FUNCTION getDemandAmountForPeriod (     inp_bank_id    IN  varchar2,
                                        inp_fromDate   IN DATE,
                                        inp_toDate     IN DATE,
                                        inp_acid       IN VARCHAR2)RETURN NUMBER;

FUNCTION getRecoveryAmount (  inp_bank_id     IN varchar2,
                              inp_asOnDate    IN DATE,
                              inp_acid        IN VARCHAR2) RETURN NUMBER;

FUNCTION getRecoveryAmountForPeriod (   inp_bank_id    IN varchar2,
                                        inp_fromDate   IN DATE,
                                        inp_toDate     IN DATE,
                                        inp_acid       IN VARCHAR2)RETURN NUMBER;

FUNCTION getOverdueAmount ( inp_bank_id    IN varchar2,
                            inp_asOnDate    IN DATE,
                            inp_acid        IN VARCHAR2) RETURN NUMBER;

FUNCTION getCurFinYearEod(inp_bank_id    varchar2,asOnDate Date) RETURN DATE;
FUNCTION getCurFinYearBegin(inp_bank_id    varchar2,asOnDate Date) RETURN DATE;
FUNCTION getMonBegDate(inp_bank_id    varchar2,asOnDate Date) RETURN DATE;
FUNCTION getCurrHalfyearBegin(inp_bank_id    varchar2,asOnDate Date) RETURN DATE;
FUNCTION getQrtrBegin(inp_bank_id    varchar2,asOnDate Date) RETURN DATE;
FUNCTION getBoddate(inp_bank_id    varchar2) RETURN DATE;
FUNCTION getSolDesc(inp_bank_id    varchar2, inp_SolId  VARCHAR2 ) RETURN varchar2;

FUNCTION fnGetRctDesc( inp_bank_id    IN varchar2,
                       inp_rec_ref_type IN varchar2,
                       inp_ref_code IN varchar2) RETURN varchar2;

FUNCTION getPrvMonthFridayDate (inp_bank_id varchar2, asOnDate Date) RETURN DATE;

FUNCTION IntsuspAmt(inp_bank_id varchar2, v_acid  varchar2,v_as_on_date   DATE) RETURN NUMBER;

FUNCTION ProvisionAmt(inp_bank_id varchar2, v_acid  varchar2,v_as_on_date   DATE) RETURN NUMBER;
-----------------------------------------------------------------------------------------
-- PROCEDURE  creditOrdebitSumForPeriod
-- Gets the  Credit or Debit Summation for an account for a given period
-------------------------------------------------------------------------------------------
PROCEDURE creditOrdebitSumForPeriod(    inp_bank_id    IN varchar2,
                                        inp_fromdate IN Date,
                                        inp_todate IN Date,
                                        inp_acid IN tbaadm.GAM.acid%type,
                                        inp_db_cr_flag IN varchar2,
                                        out_amount OUT tbaadm.DTD.tran_amt%type);

-----------------------------------------------------------------------------------------
-- PROCEDURE  creditOrdebitSumAsOnDate
-- Gets the  Credit or Debit Summation for an account as on date
-------------------------------------------------------------------------------------------
PROCEDURE creditOrdebitSumAsOnDate(     inp_bank_id    IN varchar2,
                                        inp_asOnDate IN Date,
                                        inp_acid IN tbaadm.GAM.acid%type,
                                        inp_db_cr_flag IN varchar2,
                                        out_amount OUT tbaadm.DTD.tran_amt%type);
-------------------------------------------------------------------------
-- PROCEDURE getMaturityPeriod
-- Gets the No of Days for Maturity from inp_asOnDate
-----------------------------------------------------------------------
PROCEDURE getMaturityPeriod(    inp_bank_id    IN varchar2,
                                inp_acid IN tbaadm.GAM.acid%TYPE,
                                inp_asOnDate IN DATE,
                                out_daysToMature OUT NUMBER);


-----------------------------------------------------------------------
-- FUNCTION getOSAmtOfDCsInAED
-- Gets outstanding amount of Documentary credits as on given date in AED
-----------------------------------------------------------------------
FUNCTION getOSAmtOfDCsInAED(    inp_bank_id    IN varchar2,
                                inp_dc_b2kid        IN  VARCHAR2,
                                inp_dc_crncy_code   IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER;

-----------------------------------------------------------------------
-- FUNCTION getOSAmtOfBGsInAED
-- Gets outstanding amount of Bank guarantees as on given date in AED
-----------------------------------------------------------------------
FUNCTION getOSAmtOfBGsInAED(    inp_bank_id    IN varchar2,
                                inp_bg_b2kid        IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER;

-----------------------------------------------------------------------
-- FUNCTION getOSAmtOfBGsInAEDTradeFinance
-- Gets outstanding amount of Bank guarantees as on given date in AED For Trade Finance
-----------------------------------------------------------------------
FUNCTION getOSAmtOfBGsInAEDTradeFinance(    inp_bank_id    IN varchar2,
                                inp_bg_b2kid        IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER;

-----------------------------------------------------------------------
-- FUNCTION getOSAmtOfFCsInAED
-- Gets outstanding amount of Forward contracts as on given date in AED
-----------------------------------------------------------------------
FUNCTION getOSAmtOfFCsInAED(    inp_bank_id    IN varchar2,
                                inp_frwrd_cntrct_num    IN  VARCHAR2,
                                inp_sol_id              IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER;

-----------------------------------------------------------------------
-- FUNCTION getOSAmtOfFcyBillsInAED
-- Gets outstanding amount of foreign bills as on given date in AED
-----------------------------------------------------------------------
FUNCTION getOSAmtOfFcyBillsInAED(   inp_bank_id    IN varchar2,
                                    inp_bill_id         IN  VARCHAR2,
                                    inp_sol_id          IN  VARCHAR2,
                                    inp_bill_amt_aed    IN  NUMBER,
                                    inp_asOnDate        IN DATE) RETURN NUMBER;

-----------------------------------------------------------------------
-- FUNCTION getOSAmtOfInlandBills
-- Gets outstanding amount of inland bills as on given date in AED
-----------------------------------------------------------------------
FUNCTION getOSAmtOfInlandBills( inp_bank_id    IN varchar2,
                                inp_bill_id         IN  VARCHAR2,
                                inp_sol_id          IN  VARCHAR2,
                                inp_reg_type        IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER;

FUNCTION getTotCrDrGlSubheadForPeriod(    inp_bank_id    IN varchar2,
                                          inp_glsubrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                          inp_fromdate IN Date,
                                          inp_todate IN Date) RETURN NUMBER;
FUNCTION getTotCrDrPlaceHolderForPeriod(  inp_bank_id    IN varchar2,
                                          inp_plrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                          inp_fromdate IN Date,
                                          inp_todate IN Date) RETURN NUMBER;
FUNCTION getTotCrDrAccountsForPeriod(     inp_bank_id    IN varchar2,
                                          inp_acrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                          inp_fromdate IN Date,
                                          inp_todate IN Date) RETURN NUMBER;
FUNCTION getTotCrGlSubheadForPeriod(      inp_bank_id    IN varchar2,
                                          inp_glsubrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                          inp_fromdate IN Date,
                                          inp_todate IN Date) RETURN NUMBER;
FUNCTION getTotCrPlaceHolderForPeriod(    inp_bank_id    IN varchar2,
                                          inp_plrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                          inp_fromdate IN Date,
                                          inp_todate IN Date) RETURN NUMBER;
FUNCTION getTotCrAccountsForPeriod(       inp_bank_id    IN varchar2,
                                          inp_acrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                          inp_fromdate IN Date,
                                          inp_todate IN Date) RETURN NUMBER;

FUNCTION getDPDCounter(inp_bank_id     varchar2,
                                inp_acid    VARCHAR2,
                                inp_date    DATE
                            )    RETURN        NUMBER;

PROCEDURE getAcctAvgBal (inp_bank_id IN  varchar2,
                         in_acid     IN  tbaadm.EAB.acid          %TYPE,
                         in_fromDate IN  tbaadm.EAB.eod_date      %TYPE,
                         in_toDate   IN  tbaadm.EAB.eod_date      %TYPE,
                         in_balType  IN  CHAR,
                         out_maxAmt  OUT tbaadm.EAB.tran_date_bal %TYPE,
                         out_minAmt  OUT tbaadm.EAB.tran_date_bal %TYPE,
                         out_avgAmt  OUT tbaadm.EAB.tran_date_bal %TYPE)  ;                 
                   
FUNCTION get_last_working_date (inp_bank_id IN  varchar2,p_from_date IN DATE := SYSDATE)
        RETURN DATE;

----------------------------------------------------------------------
-- PROCEDURE getNextPrevWorkDay
-- Gives previous or next working day
-----------------------------------------------------------------------

PROCEDURE getNextPrevWorkDay(inp_bank_id IN  varchar2,
                             inpEntityId               IN      VARCHAR2,
                                                                inpEntityType           IN      VARCHAR2,
                                                                inpDate                         IN      DATE,
                                                                nextOrPrevFlg   IN VARCHAR2,
                                                                nextPrevWorkingDate     OUT DATE); 




FUNCTION getpreviousboddate (inp_bank_id  varchar2, cal_type VARCHAR2,cal_id VARCHAR2,p_date DATE) 
        RETURN VARCHAR2;

-----------------------------------------------------------------------
-- FUNCTION GetAvailBalForAcct
-- Gets the Effective Available Balance of the account
-----------------------------------------------------------------------
FUNCTION GetAvailBalForAcct(inp_bank_id IN  varchar2,
                            inp_acid    IN      VARCHAR2,
                            inp_date    IN      DATE)
                            RETURN NUMBER;


--------------------------------------------------------------------------------
-- Function : getBranchNameBySolId()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getBranchNameBySolId(lv_sol_id  varchar2,lv_bank_id in varchar2)
RETURN Varchar2;

-----------------------------------------------------------------------
-- FUNCTION getEMI
-- Gets the Installment Amount for the given Acid
-----------------------------------------------------------------------
FUNCTION    getEMI(lv_acid   tbaadm.gam.acid%type,lv_asondate DATE,bankId varchar2)
RETURN NUMBER;


FUNCTION  getIntRateForLa(lv_acid VARCHAR2,asondate date ,bankId varchar2)
return number;

-----------------------------------------------------------------------
-- FUNCTION getLoanTenor
-- Gets the tenor for the loan account (acid)
-----------------------------------------------------------------------
FUNCTION getLoanTenor(inp_acid IN VARCHAR2,bankId varchar2)
RETURN VARCHAR2;

---------------------------------------------------------------------------------
-- Function : getOutStanding()
-- Desc     : Returns the outstanding amount for a loan account (acid)
-----------------------------------------------------------------------------------
FUNCTION  getOutStanding(lv_acid tbaadm.gam.acid%type, lv_asondate Date,lv_type varchar2,bankId varchar2)
                            RETURN  Number;

------------------------------------------------------------------------------
-- Function : getChangeInBaseIntRate()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getChangeInBaseIntRate(var_acid in varchar2, var_crncy_code in varchar2,lv_asondate in date, lv_bank_id in varchar2)
return Number;
         
        
----------------------------------------------------------------------------
---- Following functions/procedures added for Depoists Module by Parikshith
---- Section START
----------------------------------------------------------------------------


----*************************************************************
--  *   PROCEDURE CUSTOM_getLaIntVersionSlab                      *
--  *      This Procedure returns the interest rate for a         *
--  *    version for the balanced amount for a Loan Account *
--  *    If no record is found                           *
--  *    then value of out_foundFlg is set to 0                *
--  *    Otherwise the value of out_foundFlg is set to 1       *
---**************************************************************
   PROCEDURE custom_getlaintversionslab (
      inp_crncycode          IN       VARCHAR2,
      inp_inttblcode         IN       VARCHAR2,
      inp_inttblversion      IN       VARCHAR2,
      inp_slabdrcrflg        IN       CHAR,
      inp_slabamt            IN       VARCHAR2,
      inp_ratetype           IN       CHAR,
      inp_loan_period_mths   IN       VARCHAR2,
      inp_loan_period_days   IN       VARCHAR2,
      out_intrate            OUT      VARCHAR2,
      out_indtype            OUT      VARCHAR2,
      out_beginslabamt       OUT      VARCHAR2,
      out_foundflg           OUT      NUMBER,
      inp_bankId	      IN       VARCHAR2
   );

----*************************************************************
--  *   PROCEDURE CUSTOM_getLaIntVersionSlabAll                   *
--  *    This Procedure returns the 2 Interest Rates for a        *
--  *       Version for the Balance Amt for a Loan A/c.           *
--  *    If no record is found                           *
--  *    then value of out_foundFlg is set to 0                *
--  *    Otherwise the value of out_foundFlg is set to 1       *
---**************************************************************
   PROCEDURE custom_getlaintversionslaball (
      inp_crncycode          IN       VARCHAR2,
      inp_inttblcode         IN       VARCHAR2,
      inp_inttblversion      IN       VARCHAR2,
      inp_slabdrcrflg        IN       CHAR,
      inp_slabamt            IN       VARCHAR2,
      inp_loan_period_mths   IN       VARCHAR2,
      inp_loan_period_days   IN       VARCHAR2,
      out_normalrate         OUT      VARCHAR2,
      out_penalrate          OUT      VARCHAR2,
      out_indtype            OUT      VARCHAR2,
      out_beginslabamt       OUT      VARCHAR2,
      out_foundflg           OUT      NUMBER,
      inp_bankId	     IN       VARCHAR2
   );

   ----************************************************************
--  *   PROCEDURE CUSTOM_getIntVersionSlab                     *
--  *    This Procedure returns the Interest Rate for a        *
--  *       Version for the Balance Amt                        *
--  *    If no record is found for the Version Slab,        *
--  *    then value of out_foundFlg is set to 1403          *
--  *    Otherwise the value of out_foundFlg is set to 0    *
---*************************************************************
   PROCEDURE custom_getintversionslab (
      inp_crncycode       IN       VARCHAR2,
      inp_inttblcode      IN       VARCHAR2,
      inp_inttblversion   IN       VARCHAR2,
      inp_slabdrcrflg     IN       CHAR,
      inp_slabamt         IN       VARCHAR2,
      inp_ratetype        IN       CHAR,
      out_intrate         OUT      VARCHAR2,
      out_indtype         OUT      VARCHAR2,
      out_beginslabamt    OUT      VARCHAR2,
      out_foundflg        OUT      NUMBER,
      inp_bankId           IN       VARCHAR2
   );

   
   PROCEDURE custom_gettdintversionslab (
      inp_crncycode                 IN       VARCHAR2,
      inp_inttblcode                IN       VARCHAR2,
      inp_inttblversion             IN       VARCHAR2,
      inp_slabdrcrflg               IN       CHAR,
      inp_slabamt                   IN       VARCHAR2,
      inp_ratetype                  IN       CHAR,
      inp_deposit_period_mths       IN       VARCHAR2,
      inp_deposit_period_days       IN       VARCHAR2,
      inp_dep_period_in_days_only   IN       VARCHAR2,
      inp_contract_startdate        IN       VARCHAR2,
      inp_contract_enddate          IN       VARCHAR2,
      out_intrate                   OUT      VARCHAR2,
      out_indtype                   OUT      VARCHAR2,
      out_beginslabamt              OUT      VARCHAR2,
      out_foundflg                  OUT      NUMBER,
      inp_bankId            IN       VARCHAR2
   );
   
----************************************************************
--  *   PROCEDURE CUSTOM_getIntRate_TD                         *
--  *    This Procedure returns the Normal Interest Rate       *
--  *         for an A/c as on a particular date, with respect *
--  *         to change_upto_date                              *
---*************************************************************
   PROCEDURE custom_getintrate_TD (
      inp_asondate       IN       date,
      inp_acid           IN       VARCHAR2,
      inp_slabamt        IN       VARCHAR2,
      inp_slabdrcrflg    IN       CHAR,
      inp_ratetype       IN       CHAR,
      inp_bankID    IN     VARCHAR2,
      out_intrate        OUT      VARCHAR2,
      out_indtype        OUT      VARCHAR2,
      out_beginslabamt   OUT      VARCHAR2,
      out_foundflg       OUT      NUMBER
   );
   

----************************************************************
--  *   PROCEDURE CUSTOM_getIntTblVersion                      *
--  *    This Procedure returns the Interest Rate for a        *
--  *       Version for the Balance Amt                        *
--  *    If no record is found for the Table Code,          *
--  *    then value of out_foundFlg is set to 1403          *
--  *    Otherwise the value of out_foundFlg is set to 0    *
---*************************************************************
   PROCEDURE custom_getinttblversion (
      inp_crncycode             IN       VARCHAR2,
      inp_asondate              IN       date,
      inp_changeuptodate        IN       VARCHAR2,
      inp_itc_int_tbl_ver_num   IN       VARCHAR2,
      inp_inttblcode            IN       VARCHAR2,
      out_inttblversion         OUT      VARCHAR2,
      out_basepcntcr            OUT      VARCHAR2,
      out_basepcntdr            OUT      VARCHAR2,
      out_foundflg              OUT      NUMBER,
      inp_bankId        IN    VARCHAR2
   );
   

----************************************************************
--  *   PROCEDURE CUSTOM_getIntTblCode                         *
--  *      This Procedure returns the interest table code      *
--  *    for an A/c as on a particular date.                *
--  *    If no record is found for the A/c,                 *
--  *    then value of out_foundFlg is set to 0             *
--  *    Otherwise the value of out_foundFlg is set to 1    *
---*************************************************************
   PROCEDURE custom_getinttblcode (
      inp_asondate          IN OUT   date,
      inp_changeuptodate    IN       date,
      inp_acid              IN       VARCHAR2,
      out_inttblcode        OUT      VARCHAR2,
      out_custcrprefpcnt    OUT      VARCHAR2,
      out_custdrprefpcnt    OUT      VARCHAR2,
      out_idcrprefpcnt      OUT      VARCHAR2,
      out_iddrprefpcnt      OUT      VARCHAR2,
      out_foundflg          OUT      NUMBER,
--***************************************
      out_min_int_pcnt_cr   OUT      VARCHAR2,
      out_min_int_pcnt_dr   OUT      VARCHAR2,
      out_max_int_pcnt_cr   OUT      VARCHAR2,
      out_max_int_pcnt_dr   OUT      VARCHAR2,
      out_pegged_flg        OUT      CHAR,
      out_itc_int_ver       OUT      VARCHAR2,
      inp_bankId        IN    VARCHAR2,
      inp_crncy            IN        VARCHAR2
--***************************************
   );

----************************************************************
--  *   PROCEDURE CUSTOM_getIntVersionSlabAll                         *
--  *    This Procedure returns the Interest Rate for a        *
--  *       Version for the Balance Amt  for a TD A/c          *
--  *    Returns all the 3 rates.                              *
--  *    If no record is found for the Version Slab,        *
--  *    then value of out_foundFlg is set to 1403          *
--  *    Otherwise the value of out_foundFlg is set to 0    *
---*************************************************************
   PROCEDURE custom_gettdintversionslaball (
      inp_crncycode                 IN       VARCHAR2,
      inp_inttblcode                IN       VARCHAR2,
      inp_inttblversion             IN       VARCHAR2,
      inp_slabdrcrflg               IN       CHAR,
      inp_slabamt                   IN       VARCHAR2,
      inp_deposit_period_mths       IN       VARCHAR2,
      inp_deposit_period_days       IN       VARCHAR2,
      inp_contract_startdate        IN       VARCHAR2,
      inp_contract_enddate          IN       VARCHAR2,
      inp_dep_period_in_days_only   IN       VARCHAR2,
      out_normalrate                OUT      VARCHAR2,
      out_penalrate                 OUT      VARCHAR2,
      out_extnrate                  OUT      VARCHAR2,
      out_indtype                   OUT      VARCHAR2,
      out_beginslabamt              OUT      VARCHAR2,
      out_foundflg                  OUT      NUMBER
   );
   
   
      ----************************************************************
--  *   PROCEDURE CUSTOM_getEffectiveROI                             *
--  *   This Procedure returns the effective rate of interest *
--  * considering BASE, DIFFERENTIAL and PREFERENTIALS      *
---*************************************************************
   PROCEDURE custom_geteffectiveroi (
      inp_ratetype          IN       CHAR,
      inp_slabdrcrflg       IN       CHAR,
      inp_schemetype        IN       VARCHAR2,
      inp_custcrprefpcnt    IN       VARCHAR2,
      inp_custdrprefpcnt    IN       VARCHAR2,
      inp_idcrprefpcnt      IN       VARCHAR2,
      inp_iddrprefpcnt      IN       VARCHAR2,
      inp_basepcntcr        IN       VARCHAR2,
      inp_basepcntdr        IN       VARCHAR2,
      inp_diffintrate       IN       VARCHAR2,
--*****************************************************
      inp_min_int_pcnt_cr   IN       VARCHAR2,
      inp_min_int_pcnt_dr   IN       VARCHAR2,
      inp_max_int_pcnt_cr   IN       VARCHAR2,
      inp_max_int_pcnt_dr   IN       VARCHAR2,
      inp_pegged_flg        IN       CHAR,
--*****************************************************
      out_intrate           OUT      VARCHAR2,
      inp_bankId             IN       VARCHAR2
   );
 -------------------------------------------------------------------------
---- Function getCrIntRate_unverified
---- Gets the Credit Interest for a SBA/CAA/TDA A/c.
-------------------------------------------------------------------------
--
FUNCTION getCrIntRate_unverified(v_acid varchar2,v_balance NUMBER, v_as_on_date DATE, v_bankId varchar2) RETURN NUMBER;


 -------------------------------------------------------------------------
---- Section END/ By Parikshith
-------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Function : getCountOfChar()
-- Desc     : Returns the no of times a character exists in a string(string, char)
--------------------------------------------------------------------------------
FUNCTION getCountOfChar(lv_string VARCHAR2,lv_char CHAR )
    RETURN NUMBER;
--------------------------------------

--------------------------------------
--FUNCTION format_str
--return the ### ### # format string, for example,input '131301013002', output '13 130 101 300 2'
--------------------------------------
FUNCTION format_str(str in varchar2)
                   return varchar2;

--------------------------------------------------------------------------------
-- Function : getOldIntRate()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getOldIntRate(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2,lv_crncy_code in varchar2)
       return Number;

--------------------------------------------------------------------------------
-- Function : getNewIntRate()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getNewIntRate(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2,lv_crncy_code in varchar2)
       return Number;

--------------------------------------------------------------------------------
-- Function : getOldlimit()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getOldlimit(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2)
       return Number;

--------------------------------------------------------------------------------
-- Function : getNewlimit()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getNewlimit(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2)
       return Number;

--------------------------------------------------------------------------------
-- Function : getExpDateOfOldIntRate()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getExpDateOfOldIntRate(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2,lv_crncy_code in varchar2)
       return date;

--------------------------------------------------------------------------------
-- Function : getExpDateOfNewIntRate()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getExpDateOfNewIntRate(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2,lv_crncy_code in varchar2)
       return date;

-------------------------------------------------------------------------------
-- Function : getprovisionamountBetDatesDr
-- Desc     :
-------------------------------------------------------------------------------
function getprovisionamountBetDatesDr(inp_cursor_acid IN tbaadm.gam.acid%type,inp_schm_code  IN tbaadm.gam.schm_code%type,startdate IN date,enddate IN DATE, inp_bank_id in varchar2)
return number;

--------------------------------------------------------------------------------
-- Function : getprovisionamountBetDatesCr
-- Desc     :
-------------------------------------------------------------------------------
function getprovisionamountBetDatesCr(inp_cursor_acid IN tbaadm.gam.acid%type,inp_schm_code  IN tbaadm.gam.schm_code%type,startdate IN date,enddate IN DATE, inp_bank_id in varchar2)
return number;

--------------------------------------------------------------------------------
-- Function : isNumeric
-- Desc     : Checks if given input is a numeric value (caters for decimals). Added by Vignesh 
-------------------------------------------------------------------------------

function isNumeric (inp_string IN VARCHAR2)
return VARCHAR2;

--------------------------------------------------------------------------------
-- Function : getDrIntRate_unverified
-- Reconciled from CustCommonPack.sql in V1.0
--------------------------------------------------------------------------------

FUNCTION getDrIntRate_unverified(v_acid varchar2,v_balance NUMBER, v_as_on_date DATE, v_bankId varchar2) 
RETURN NUMBER;

-----------------------------------------------------------------------------------------------------
--FUNCTION loanschminterest
-----------------------------------------------------------------------------------------------------
FUNCTION loanschminterest(inp_inttblcode varchar2, inp_inttblversion varchar2,inp_slabdrcrflg varchar2, inp_bankId varchar2, loc_slabamtabs varchar2, inp_loan_period_mths varchar2, inp_loan_period_days varchar2, inp_crncycode varchar2)
return varchar2;

END CommonPackage;
/
CREATE OR REPLACE PACKAGE BODY tbaadm.CommonPackage AS

OutArr              tbaadm.basp0099.ArrayType;
glAmt            tbaadm.GST.tot_cr_bal%type:=0;
totalGLBal        tbaadm.GST.tot_cr_bal%type:=0;
glSubheadCode    tbaadm.GST.gl_sub_head_code%type;
solId            tbaadm.SOL.sol_id%type;
crncyCode        tbaadm.GSH.crncy_Code%type;
rate            tbaadm.RTL.VAR_CRNCY_UNITS%type;
ExRate            tbaadm.RTL.VAR_CRNCY_UNITS%type;
ConvertAmount   number(20,4):=0.00;
EAB_amt             number(20,4):=0.00;
glSubHead_amt   number(20,4):=0.00;
glCode_amt          number(20,4):=0.00;


PROCEDURE getRctDesc(inp_bank_id      IN  varchar2,
                     inp_rec_ref_type IN varchar2,
                     inp_ref_code     IN varchar2,
                     out_ref_desc     OUT varchar2) AS

BEGIN
        SELECT  ref_desc
          INTO  out_ref_desc
          FROM  tbaadm.RCT
         WHERE  RCT.bank_id = inp_bank_id  
           AND  RCT.ref_rec_type=inp_rec_ref_type
           AND  RCT.ref_code=inp_ref_code;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        BEGIN
            out_ref_desc := '';
        END;
        RETURN;
END getRctDesc;
-------------------------------------------------------------------------------

PROCEDURE getAcctSanctionLimit( inp_bank_id      IN varchar2,
                                inp_asOnDate     IN DATE,
                                inp_acid         IN VARCHAR2,
                                out_sanction_lim OUT NUMBER) AS
BEGIN
    SELECT    NVL(SUM(SANCT_LIM),0)
    INTO    out_sanction_lim
    FROM    tbaadm.LHT, tbaadm.LHET
    WHERE   LHT.BANK_ID = inp_bank_id
    AND     LHT.BANK_ID = LHET.BANK_ID
    AND     LHT.ACID = inp_acid
    AND     LHT.ENTITY_CRE_FLG = 'Y'
    AND     LHT.ACID = LHET.ACID
    AND     LHT.SERIAL_NUM = LHET.SERIAL_NUM
    AND     LHT.APPLICABLE_DATE <= inp_asOnDate
    AND     LHET.LIM_INACTIVE_DATE > inp_asOnDate
    AND     LHET.LCHG_TIME = (    SELECT    MAX(ONE.LCHG_TIME)
                                   FROM    tbaadm.LHET ONE
                                   WHERE      ONE.bank_id = inp_bank_id
                                   AND        ONE.ACID = LHT.ACID
                                   AND        ONE.SERIAL_NUM = LHT.SERIAL_NUM);
END getAcctSanctionLimit;
-----------------------------------------------------------------------------------

PROCEDURE isAcctRenewalPending( inp_bank_id         IN    varchar2,
                                inp_asOnDate            IN DATE,
                                inp_acid                IN VARCHAR2,
                                out_renewal_pending_flg OUT NUMBER) AS
BEGIN
    SELECT    1
    INTO    out_renewal_pending_flg
    FROM    dual
    WHERE    EXISTS(    SELECT    1
                    FROM    tbaadm.LHT, tbaadm.LHET
                    WHERE    LHT.BANK_ID = inp_bank_id
                      AND     LHT.BANK_ID = LHET.BANK_ID
                      AND     LHT.ACID = inp_acid
                      AND     LHT.ENTITY_CRE_FLG = 'Y'
                      AND     LHT.ACID = LHET.ACID
                      AND     LHT.SERIAL_NUM = LHET.SERIAL_NUM
                      AND     LHT.APPLICABLE_DATE <= inp_asOnDate
                      AND     LHT.LIM_EXP_DATE < inp_asOnDate
                      AND     LHET.LIM_INACTIVE_DATE > inp_asOnDate
                      AND     LHET.LCHG_TIME = (    SELECT    MAX(ONE.LCHG_TIME)
                                                FROM    tbaadm.LHET ONE
                                                WHERE      ONE.bank_id = inp_bank_id
                                                AND        ONE.ACID = LHT.ACID
                                                AND        ONE.SERIAL_NUM = LHT.SERIAL_NUM));
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    BEGIN
        out_renewal_pending_flg := 0;
    END;
END isAcctRenewalPending;
-----------------------------------------------------------------------------------


PROCEDURE isSecurityOverDue(inp_bank_id         IN    varchar2,
                            inp_asOnDate        IN DATE,
                            inp_acid            IN VARCHAR2,
                            inp_secu_type_ind    IN VARCHAR2,
                            out_sec_overdue_flg    OUT NUMBER) AS
BEGIN
    SELECT    1
    INTO    out_sec_overdue_flg
    FROM    dual
    WHERE    EXISTS(    SELECT    1
                    FROM    tbaadm.SDR
                    WHERE      SDR.BANK_ID = inp_bank_id   
                    AND        ACID = inp_acid
                    AND        secu_type_ind = inp_secu_type_ind
                    AND        item_due_date < inp_asOnDate
                    AND        del_flg != 'Y');
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    BEGIN
        out_sec_overdue_flg := 0;
    END;
END isSecurityOverDue;
-----------------------------------------------------------------------------------


PROCEDURE getAcctDrawingPower(inp_bank_id         IN    varchar2,
                              inp_asOnDate        IN DATE,
                              inp_acid            IN VARCHAR2,
                              out_drawing_power   OUT NUMBER) AS
BEGIN
    SELECT    NVL(DRWNG_POWER,0)
    INTO    out_drawing_power
    FROM    tbaadm.DHT
    WHERE      DHT.BANK_ID = inp_bank_id 
    AND        DHT.ACID = inp_acid
    AND        DHT.ENTITY_CRE_FLG = 'Y'
    AND        DHT.DEL_FLG != 'Y'
    AND        DHT.STATUS = 'A'
    AND        DHT.APPLICABLE_DATE <= inp_asOnDate
    AND        DHT.SERIAL_NUM = (    SELECT    MAX(ONE.SERIAL_NUM)
                                FROM    tbaadm.DHT ONE
                                WHERE      ONE.BANK_ID = inp_bank_id 
                                AND        ONE.ACID = DHT.ACID
                                AND        ONE.APPLICABLE_DATE <= inp_asOnDate
                                AND        ONE.DEL_FLG != 'Y'
                                AND        ONE.ENTITY_CRE_FLG = 'Y'
                                AND        ONE.STATUS = 'A');
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    BEGIN
        out_drawing_power := 0;
    END;
END getAcctDrawingPower;
-----------------------------------------------------------------------------------


-----------------------------------------------------------------------
-- FUNCTION getAcctSanctionLimitFunc by Sarvjeet
-- Gets the Sanction Limit
-----------------------------------------------------------------------

FUNCTION getAcctSanctionLimitFunc( inp_bank_id      IN varchar2,
                                   inp_asOnDate     IN DATE,
                                   inp_acid   IN VARCHAR2)RETURN NUMBER IS
out_sanction_lim        tbaadm.eab.tran_date_bal%type;

BEGIN
    BEGIN
        SELECT  NVL(SUM(SANCT_LIM),0)
        INTO    out_sanction_lim
        FROM    tbaadm.LHT, tbaadm.LHET
        WHERE   LHT.BANK_ID = inp_bank_id
        AND     LHT.BANK_ID = LHET.BANK_ID
        AND     LHT.ACID = inp_acid
        AND     LHT.ENTITY_CRE_FLG = 'Y'
        AND     LHT.ACID = LHET.ACID
        AND     LHT.SERIAL_NUM = LHET.SERIAL_NUM
        AND     LHT.APPLICABLE_DATE <= inp_asOnDate
        AND     LHET.LIM_INACTIVE_DATE > inp_asOnDate
        AND     LHET.LCHG_TIME = (      SELECT  MAX(ONE.LCHG_TIME)
                                                                FROM    tbaadm.LHET ONE
                                                                WHERE   ONE.bank_id = inp_bank_id 
                                                                AND     ONE.ACID = LHT.ACID
                                                                AND             ONE.SERIAL_NUM = LHT.SERIAL_NUM
);
EXCEPTION WHEN NO_DATA_FOUND THEN
            out_sanction_lim := 0.0;
END;
RETURN out_sanction_lim;
END getAcctSanctionLimitFunc;


-------------------------------------------------------------------------
-- PROCEDURE getFrequencyNextDate
-- Gets the Next Frequency Date for a loan installment
-----------------------------------------------------------------------
PROCEDURE getFrequencyNextDate(  inp_bank_id    IN    varchar2,
                                 freq_code        IN VARCHAR2,
                                 freq_week_num    IN char,
                                 freq_week_day    IN NUMBER,
                                 freq_start_dd    IN NUMBER,
                                 in_date            IN date,
                                 out_date        OUT date) AS

loc_temp_date            date;
loc_last_day             NUMBER;

begin
--{
    if (freq_code = 'D') then
        out_date :=in_date + 1;
        return;
    end if;

    if(freq_code = 'W') then
        out_date :=in_date + 7;
        return ;
    end if;

    if(freq_code = 'F') then
        out_date :=in_date + 14;
        return ;
    end if;


    if(freq_code = 'M') then
        loc_temp_date := add_months(in_date,1);
    elsif(freq_code = 'Q') then
        loc_temp_date := add_months(in_date,3);
    elsif(freq_code = 'H') then
        loc_temp_date := add_months(in_date,6);
    elsif(freq_code = 'Y') then
        loc_temp_date := add_months(in_date,6);
    end if;

    -- make sure that out_date does not go beyond last_day of the month in which loc_temp_date falls
    -- set loc_temp_date to be first of that month
    IF (freq_week_num = 'L') THEN

       -- e.g. get last wednesday....
       loc_last_day := TO_NUMBER(TO_CHAR(LAST_DAY(loc_temp_date),'D'));
       IF (freq_week_day > loc_last_day) THEN
            out_date := LAST_DAY(loc_temp_date) + freq_week_day - loc_last_day - 7;
       ELSE
            out_date := LAST_DAY(loc_temp_date) + freq_week_day - loc_last_day;
       END IF;

    ELSIF (freq_week_num = 'M') THEN

       -- e.g. get middle wednesday
       loc_last_day := TO_NUMBER(TO_CHAR(LAST_DAY(loc_temp_date),'D'));
       IF (freq_week_day > loc_last_day) THEN
            out_date := LAST_DAY(loc_temp_date) + freq_week_day - loc_last_day - 7;
       ELSE
            out_date := LAST_DAY(loc_temp_date) + freq_week_day - loc_last_day;
       END IF;
       out_date:= out_date - 14;

    ELSIF (TO_NUMBER(freq_week_num) > 0) THEN

       -- get 3rd wednesaday

       loc_temp_date := loc_temp_date - TO_NUMBER(TO_CHAR(loc_temp_date,'DD')) + 1;
       IF freq_week_day >= TO_NUMBER(TO_CHAR(loc_temp_date,'D')) THEN
            loc_temp_date := loc_temp_date + freq_week_day - TO_NUMBER(TO_CHAR(loc_temp_date,'D'));
       ELSE
            loc_temp_date := loc_temp_date - freq_week_day + TO_NUMBER(TO_CHAR(loc_temp_date,'D'));
       END IF;
       out_date := loc_temp_date + 7 * TO_NUMBER(freq_week_num);

    ELSE

       -- 20th day or 30th day of month
       loc_temp_date := loc_temp_date - TO_NUMBER(TO_CHAR(loc_temp_date,'DD')) + 1;
       out_date := loc_temp_date + freq_start_dd - 1;
       IF ( out_date > LAST_DAY(loc_temp_date) ) THEN
           out_date := LAST_DAY(loc_temp_date);
       END IF;
    END IF;
--}
END getFrequencyNextDate;

-----------------------------------------------------------------------
-- FUNCTION getSanctioningAuthority
-- Gets the latest Sanctioning authority of an account as on given date
-----------------------------------------------------------------------
FUNCTION getSanctioningAuthority(inp_bank_id    IN    varchar2,
                                 inp_asOnDate        IN    DATE,
                                 inp_acid        IN    VARCHAR2) RETURN VARCHAR2 IS
out_sanct_auth_code        tbaadm.lht.sanct_levl_code%type;
BEGIN
    BEGIN
        SELECT    NVL(sanct_auth_code,'NULL')
        INTO    out_sanct_auth_code
        FROM    tbaadm.LHT, tbaadm.LHET
        WHERE   LHT.BANK_ID = inp_bank_id
        AND     LHT.BANK_ID = LHET.BANK_ID
        AND     LHT.ACID = inp_acid
        AND     LHT.DEL_FLG !='Y'
        AND     LHT.ENTITY_CRE_FLG = 'Y'
        AND     LHT.ACID = LHET.ACID
        AND     LHT.SERIAL_NUM = LHET.SERIAL_NUM
        AND     LHT.APPLICABLE_DATE <= inp_asOnDate
        AND     LHET.LIM_INACTIVE_DATE > inp_asOnDate
        AND     LHET.LCHG_TIME = (    SELECT    MAX(ONE.LCHG_TIME)
                                    FROM    tbaadm.LHET ONE
                                    WHERE   ONE.BANK_ID = inp_bank_id  
                                    AND     ONE.ACID = LHT.ACID
                                    AND     ONE.SERIAL_NUM = LHT.SERIAL_NUM)
        AND     rownum < 2;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            out_sanct_auth_code := 'NULL';
    END;
    RETURN out_sanct_auth_code;
END getSanctioningAuthority;
-------------------------------------------------------------------------------

-----------------------------------------------------------------------
-- FUNCTION getSanctioningAuthLevel
-- Gets the latest Sanctioning authority Levl of an account as on given date
-----------------------------------------------------------------------
FUNCTION getSanctioningAuthLevel(inp_bank_id    IN    varchar2,
                                 inp_asOnDate        IN    DATE,
                                 inp_acid            IN    VARCHAR2) RETURN VARCHAR2 IS
out_sanct_levl_code        tbaadm.lht.sanct_levl_code%type;
BEGIN
    BEGIN
        SELECT    NVL(sanct_levl_code,'NULL')
        INTO    out_sanct_levl_code
        FROM    tbaadm.LHT, tbaadm.LHET
        WHERE   LHT.BANK_ID = inp_bank_id
        AND     LHT.BANK_ID = LHET.BANK_ID
        AND     LHT.ACID = inp_acid
        AND     LHT.DEL_FLG !='Y'
        AND     LHT.ENTITY_CRE_FLG = 'Y'
        AND     LHT.ACID = LHET.ACID
        AND     LHT.SERIAL_NUM = LHET.SERIAL_NUM
        AND     LHT.APPLICABLE_DATE <= inp_asOnDate
        AND     LHET.LIM_INACTIVE_DATE > inp_asOnDate
        AND     LHET.LCHG_TIME = (    SELECT    MAX(ONE.LCHG_TIME)
                                    FROM    tbaadm.LHET ONE
                                    WHERE ONE.BANK_ID = inp_bank_id
                                    AND   ONE.ACID = LHT.ACID
                                    AND   ONE.SERIAL_NUM = LHT.SERIAL_NUM)
        AND     rownum < 2;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            out_sanct_levl_code := 'NULL';
    END;
    RETURN out_sanct_levl_code;
END getSanctioningAuthLevel;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--PROCEDURE getAcctSanctionLimitForPeriod(    inp_bank_id     IN varchar2,
--                                              inp_fromDate    IN    DATE,
--                                            inp_toDate        IN    DATE,
--                                            inp_acid        IN     NUMBER,
--                                            out_sanction_lim    OUT    NUMBER) AS
--BEGIN
--    SELECT
-------------------------------------------------------------------------------

PROCEDURE getAcctSanctionLimitForPeriod(inp_bank_id     IN varchar2,
                                        inp_fromDate     IN DATE,
                                        inp_toDate        IN    DATE,
                                        inp_acid         IN VARCHAR2,
                                        out_sanction_lim OUT NUMBER) AS
BEGIN
    SELECT    NVL(SUM(SANCT_LIM),0)
    INTO    out_sanction_lim
    FROM    tbaadm.LHT, tbaadm.LHET
    WHERE   LHT.BANK_ID = inp_bank_id
    AND     LHT.BANK_ID = LHET.BANK_ID
    AND     LHT.ACID = inp_acid
    AND     LHT.DEL_FLG !='Y'
    AND     LHT.ENTITY_CRE_FLG = 'Y'
    AND     LHT.ACID = LHET.ACID
    AND     LHT.SERIAL_NUM = LHET.SERIAL_NUM
    AND     LHT.APPLICABLE_DATE >= inp_fromDate
    AND     LHT.APPLICABLE_DATE <= inp_toDate
    AND     LHET.LIM_INACTIVE_DATE > inp_toDate
    AND     LHET.LCHG_TIME = (    SELECT    MAX(ONE.LCHG_TIME)
                                   FROM    tbaadm.LHET ONE
                                   WHERE      ONE.bank_id = inp_bank_id
                                   AND        ONE.ACID = LHT.ACID
                                   AND        ONE.SERIAL_NUM = LHT.SERIAL_NUM);
END getAcctSanctionLimitForPeriod;
-----------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Procedure to get
-------------------------------------------------------------------------------

PROCEDURE getTOD_UnregularizedAmtForPer(inp_bank_id IN varchar2,
                                        inp_fromDate    IN     DATE,
                                        inp_toDate          IN  DATE,
                                        inp_acid             IN     VARCHAR2,
                                        out_availed_amt     OUT NUMBER) AS
BEGIN
    BEGIN
        SELECT     SUM(DAT.availed_amt)
        INTO    out_availed_amt
        FROM     tbaadm.DAT
        WHERE   DAT.BANK_ID = inp_bank_id 
        AND     DAT.discret_advn_reglr_ind = 'U'
        AND     DAT.acid = inp_acid
        AND     DAT.discret_advn_start_date BETWEEN inp_fromDate AND inp_toDate;

        EXCEPTION WHEN NO_DATA_FOUND THEN
                out_availed_amt := 'NULL';
    END;

END getTOD_UnregularizedAmtForPer;
-----------------------------------------------------------------------------------



FUNCTION getLastSanctionDate(   inp_bank_id IN varchar2,
                                inp_asOnDate        IN DATE,
                                inp_acid            IN VARCHAR2,
                                inp_acct_opn_date    IN DATE) RETURN DATE IS
loc_OpnDate         DATE ;
BEGIN
    SELECT NVL(MAX(lim_sanct_date),inp_acct_opn_date)
    INTO loc_OpnDate
    FROM tbaadm.LHT, tbaadm.LHET
    WHERE LHT.BANK_ID = inp_bank_id
    AND LHT.BANK_ID = LHET.BANK_ID
    AND LHT.ACID = inp_acid
    AND LHT.DEL_FLG !='Y'
    AND LHT.ENTITY_CRE_FLG = 'Y'
    AND LHT.ACID = LHET.ACID
    AND LHT.SERIAL_NUM = LHET.SERIAL_NUM
    AND LHT.APPLICABLE_DATE <= inp_asOnDate
    AND LHET.LIM_INACTIVE_DATE > inp_asOnDate
    AND LHET.LCHG_TIME = ( SELECT MAX(ONE.LCHG_TIME)
                           FROM tbaadm.LHET ONE
                           WHERE ONE.BANK_ID = inp_bank_id
                           AND   ONE.ACID = LHT.ACID
                           AND   ONE.SERIAL_NUM = LHT.SERIAL_NUM);
    RETURN loc_OpnDate;
END getLastSanctionDate;


-----------------------------------------------------------------------------------

FUNCTION getLastExpiryDate(  inp_bank_id IN varchar2,
                             inp_asOnDate        IN DATE,
                             inp_acid            IN VARCHAR2,
                             inp_acct_opn_date   IN DATE) RETURN DATE IS
loc_OpnDate      DATE ;
BEGIN
    SELECT NVL(MAX(lim_exp_date),inp_acct_opn_date)
    INTO loc_OpnDate
    FROM tbaadm.LHT, tbaadm.LHET
    WHERE LHT.BANK_ID = inp_bank_id
    AND LHT.BANK_ID = LHET.BANK_ID
    AND LHT.ACID = inp_acid
    AND LHT.DEL_FLG !='Y'
    AND LHT.ENTITY_CRE_FLG = 'Y'
    AND LHT.ACID = LHET.ACID
    AND LHT.SERIAL_NUM = LHET.SERIAL_NUM
    AND LHT.APPLICABLE_DATE <= inp_asOnDate
    AND LHET.LIM_INACTIVE_DATE > inp_asOnDate
    AND LHET.LCHG_TIME = ( SELECT MAX(ONE.LCHG_TIME)
                           FROM tbaadm.LHET ONE
                           WHERE ONE.BANK_ID = inp_bank_id
                           AND   ONE.ACID = LHT.ACID
                           AND   ONE.SERIAL_NUM = LHT.SERIAL_NUM);
    RETURN loc_OpnDate;
END getLastExpiryDate;

--------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------

FUNCTION getDocumentDate(  inp_bank_id IN varchar2,
                           inp_asOnDate        IN DATE,
                           inp_acid            IN VARCHAR2,
                           inp_acct_opn_date   IN DATE) RETURN DATE IS
loc_DocDate      DATE ;
BEGIN
    SELECT NVL(MAX(loan_paper_date),inp_acct_opn_date)
    INTO loc_DocDate
    FROM tbaadm.LHT, tbaadm.LHET
    WHERE LHT.BANK_ID = inp_bank_id
    AND LHT.BANK_ID = LHET.BANK_ID 
    AND LHT.ACID = inp_acid
    AND LHT.DEL_FLG !='Y'
    AND LHT.ENTITY_CRE_FLG = 'Y'
    AND LHT.ACID = LHET.ACID
    AND LHT.SERIAL_NUM = LHET.SERIAL_NUM
    AND LHT.APPLICABLE_DATE <= inp_asOnDate
    AND LHET.LIM_INACTIVE_DATE > inp_asOnDate
    AND LHET.LCHG_TIME = ( SELECT MAX(ONE.LCHG_TIME)
                           FROM tbaadm.LHET ONE
                           WHERE ONE.BANK_ID = inp_bank_id
                           AND   ONE.ACID = LHT.ACID
                           AND   ONE.SERIAL_NUM = LHT.SERIAL_NUM);
    RETURN loc_DocDate;
END getDocumentDate;

-------------------------------------------------------------------------------
FUNCTION getFirstSanctionDate(   inp_bank_id IN varchar2,
                                 inp_asOnDate  IN DATE,
                                 inp_acid  IN VARCHAR2,
                                 inp_acct_opn_date IN DATE) RETURN DATE IS loc_OpnDate DATE;
BEGIN
        SELECT NVL(MIN(lim_sanct_date),inp_acct_opn_date)
        INTO loc_OpnDate
        FROM tbaadm.LHT, tbaadm.LHET
        WHERE LHT.BANK_ID = inp_bank_id
        AND LHT.BANK_ID = LHET.BANK_ID
        AND LHT.ACID = inp_acid
        AND LHT.DEL_FLG !='Y'
        AND LHT.ENTITY_CRE_FLG = 'Y'
        AND LHT.ACID = LHET.ACID
        AND LHT.SERIAL_NUM = LHET.SERIAL_NUM
        AND LHT.APPLICABLE_DATE <= inp_asOnDate
        AND LHET.LIM_INACTIVE_DATE > inp_asOnDate
        AND LHET.LCHG_TIME = ( SELECT MAX(ONE.LCHG_TIME)
                                                   FROM tbaadm.LHET ONE
                                                   WHERE ONE.BANK_ID = inp_bank_id
                                                   AND   ONE.ACID = LHT.ACID
                                                   AND   ONE.SERIAL_NUM = LHT.SERIAL_NUM);
        RETURN loc_OpnDate;
END getFirstSanctionDate;

-------------------------------------------------------------------------------

FUNCTION getDisbursementAmountForPeriod(inp_bank_id IN varchar2,
                                inp_fromDate    IN DATE,
                                inp_toDate        IN Date,
                                inp_acid        IN VARCHAR2) RETURN NUMBER IS
out_disb_amt        tbaadm.GAM.clr_bal_amt%TYPE;
BEGIN
    SELECT  NVL(SUM(LTD.flow_amt),0)
    INTO    out_disb_amt
    FROM    tbaadm.LTD
    WHERE   LTD.BANK_ID = inp_bank_id
    AND     LTD.acid = inp_acid 
    AND     LTD.flow_id IN
                        (SELECT LFM.flow_id
                         FROM   tbaadm.LFM
                         WHERE  LFM.BANK_ID = inp_bank_id
                           AND  LFM.flow_nature = 'P')
    AND     LTD.tran_date between inp_fromDate AND inp_toDate
    AND     LTD.del_flg != 'Y'
    AND     LTD.entity_cre_flg = 'Y'
    AND     LTD.reversal_flg != 'Y'
    AND     LTD.reversed_flg != 'Y';

    RETURN(out_disb_amt);
END getDisbursementAmountForPeriod;

-------------------------------------------------------------------------------

FUNCTION getDisbursementAmount (inp_bank_id IN varchar2,
                                inp_asOnDate    IN DATE,
                                inp_acid        IN VARCHAR2) RETURN NUMBER IS
out_disb_amt        tbaadm.GAM.clr_bal_amt%TYPE;
BEGIN
    SELECT  NVL(SUM(LTD.flow_amt),0)
    INTO    out_disb_amt
    FROM    tbaadm.LTD
    WHERE   LTD.bank_id = inp_bank_id
    AND     LTD.acid = inp_acid
    AND     LTD.flow_id IN
                        (SELECT LFM.flow_id
                         FROM   tbaadm.LFM
                         WHERE  LFM.BANK_ID = inp_bank_id
                           AND  LFM.flow_nature = 'P')
    AND     LTD.tran_date <= inp_asOnDate
    AND     LTD.del_flg != 'Y'
    AND     LTD.entity_cre_flg = 'Y'
    AND     LTD.reversal_flg != 'Y'
    AND     LTD.reversed_flg != 'Y';

    RETURN(out_disb_amt);
END getDisbursementAmount;
-------------------------------------------------------------------------------


PROCEDURE getLimitIdSanctionLimit(inp_bank_id IN varchar2,
                                inp_asOnDate      IN DATE,
                                inp_limitId            IN VARCHAR2,
                                out_sanction_lim    OUT NUMBER,
                                out_crncy_code        OUT VARCHAR2) AS
BEGIN
    SELECT  NVL(sanct_lim,0), limit_crncy_code
    INTO    out_sanction_lim, out_crncy_code
    FROM    tbaadm.lnh
    WHERE   lnh.BANK_ID = inp_bank_id
    AND     limit_b2kid = inp_limitId
    AND     start_date <= inp_asOnDate
    AND     end_date >= inp_asOnDate;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    BEGIN
        out_sanction_lim := 0;
        out_crncy_code := 'AED';
        RETURN;
    END ;
END getLimitIdSanctionLimit;
---------------------------------------------------------------------------------------

PROCEDURE get_PlGlsubheadCode_AsonAmt ( inp_bank_id IN varchar2,
                                        ip_glsubheadcode    IN  varchar2,
                                        ip_sol_id           IN  varchar2,
                                        ip_crncy_code       IN  varchar2,
                                        ip_asOnDate         IN  date,
                                        out_ason_amount     OUT NUMBER) AS
asondate_finyrbeg_sep date;
temp_finyrbeg_sep_amt tbaadm.GST.tot_cr_bal%type:=0;
begin
--{
    asondate_finyrbeg_sep := CommonPackage.getCurFinYearBegin(inp_bank_id,ip_asOnDate);
    asondate_finyrbeg_sep := add_months( asondate_finyrbeg_sep, 6) - 1;
    out_ason_amount := CommonPackage.get_GlsubheadCode_AsonAmt(inp_bank_id, ip_glsubheadcode, ip_sol_id, ip_crncy_code, ip_asOnDate);
if( asondate_finyrbeg_sep > ip_asOnDate) then
        temp_finyrbeg_sep_amt := CommonPackage.get_GlsubheadCode_AsonAmt(inp_bank_id, ip_glsubheadcode, ip_sol_id, ip_crncy_code, asondate_finyrbeg_sep);
        out_ason_amount := out_ason_amount + temp_finyrbeg_sep_amt;
    end if;
--}
end get_PlGlsubheadCode_AsonAmt;
---------------------------------------------------------------------------------------

FUNCTION get_GlsubheadCode_AsonAmt (inp_bank_id IN varchar2,
                       ip_glsubheadcode  IN varchar2,
                       ip_sol_id            IN varchar2,
                       ip_crncy_code        IN varchar2,
                       asOnDate             IN date) RETURN NUMBER IS

out_ason_amount NUMBER:=0;
BEGIN
--{
    begin
        --{
            SELECT  abs(NVL(tot_cr_bal, 0)- NVL(tot_dr_bal, 0)) into out_ason_amount
            FROM    tbaadm.GST
            WHERE   GST.BANK_ID = inp_bank_id
            AND     GST.sol_id = ip_sol_id
            AND     GST.rcre_time IS NOT NULL
            and     GST.gl_sub_head_code = ip_glsubheadcode
            and     GST.crncy_code = ip_crncy_code
            AND     GST.tran_date <= asOnDate
            AND     GST.end_tran_date >= asOnDate;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BEGIN
            --{
                out_ason_amount := 0;
            --}
            END;
            if(ip_crncy_code != 'AED') then
                out_ason_amount := CommonPackage.getConvertedAmount(inp_bank_id,out_ason_amount,ip_crncy_code,'AED','MID', asOnDate);
            end if;
        --}
        end;
    RETURN out_ason_amount;
--}
END get_GlsubheadCode_AsonAmt;
---------------------------------------------------------------------------------------
--/*
FUNCTION eabBal(inp_bank_id  varchar2,v_acid  varchar2,v_as_on_date  DATE) RETURN NUMBER is
outstanding_amount  number;
cut_over_date varchar2(50);


BEGIN

        SELECT  parameter_value 
        INTO    cut_over_date		
        FROM    CUSTOM.C_CPVALUE
        WHERE   PARAMETER_ID = 'CUT_OVER_DATE'
        AND     DEL_FLG = 'N';
		
		IF (v_as_on_date < to_date(cut_over_date,'dd-mm-yyyy')) THEN
			BEGIN
				SELECT     nvl(tran_date_bal,0)
				INTO    outstanding_amount
				FROM    CUSTOM.C_EAB
				WHERE   C_EAB.BANK_ID = inp_bank_id
				AND     C_EAB.acid = v_acid
				AND     eod_date = v_as_on_date - 1
				AND     end_eod_date >= v_as_on_date;
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                outstanding_amount := 0;
			END;
            RETURN outstanding_amount;
		ELSE
			BEGIN
				SELECT     nvl(tran_date_bal,0)
				INTO    outstanding_amount
				FROM    tbaadm.EAB
				WHERE   EAB.BANK_ID = inp_bank_id
				AND     EAB.acid = v_acid
				AND     eod_date <= v_as_on_date
				AND     end_eod_date >= v_as_on_date;
				EXCEPTION
                WHEN NO_DATA_FOUND THEN
                outstanding_amount := 0;
			END;
            RETURN outstanding_amount;
		END IF;
        

END eabBal;
--/
/*
-----------------------------------------------------------------------
-- FUNCTION getlatestbalconfdate
-- Gets the Latest Balance Confirmation Date
-- Input    :Foracid
-- Output   :Date
-----------------------------------------------------------------------
PROCEDURE getlatestbalconfdate(inp_foracid IN VARCHAR2,conf_date OUT DATE) AS

BEGIN
--{
    SELECT     MAX(acc_rej_date)
    INTO    conf_date
     FROM     CUST_DBC
    WHERE     foracid =inp_foracid
    AND     acc_rej_ind !='NULL'
    AND     del_flg != 'Y';
--}
END getlatestbalconfdate;
*/
--------------------------------------------------------------------------------
-- FUNCTION eabBalexclintsusp
-- Gets the Account balance excluding interest in suspense,as on given date
-----------------------------------------------------------------------
FUNCTION eabBalexclintsusp(inp_bank_id varchar2,    v_acid  varchar2,
                            v_as_on_date   DATE) RETURN NUMBER is
outstanding_amount  number :=0;
ip_crncy_code        tbaadm.GAM.acct_crncy_code%TYPE;
iv_int_susp_amt        tbaadm.GAM.clr_bal_amt%TYPE := 0;
v_schm_code            tbaadm.GAM.schm_code%TYPE;
v_solId             tbaadm.GAM.sol_id%TYPE;

BEGIN
--{
    BEGIN
        SELECT     nvl(tran_date_bal,0),acct_crncy_code,schm_code,sol_id
        INTO    outstanding_amount,ip_crncy_code,v_schm_code,v_solId
        FROM    tbaadm.EAB,tbaadm.GAM
        WHERE   EAB.BANK_ID = inp_bank_id
        AND     EAB.BANK_ID = GAM.BANK_ID
        AND      GAM.acid = v_acid
        AND        GAM.acid = EAB.acid
        AND         eod_date <= v_as_on_date
        AND         end_eod_date >= v_as_on_date;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        outstanding_amount := 0;
    END;

    
	if(outstanding_amount = 0) THEN
    --{
    BEGIN
        SELECT  nvl(clr_bal_amt,0),acct_crncy_code,schm_code,sol_id
        INTO    outstanding_amount,ip_crncy_code,v_schm_code,v_solId
        FROM    tbaadm.GAM
        WHERE   GAM.BANK_ID = inp_bank_id
        AND     GAM.acid = v_acid
        AND     GAM.acct_opn_date <= v_as_on_date
        AND     NVL(acct_cls_date, to_date('31-12-2099')) >= v_as_on_date
        AND     GAM.del_flg != 'Y'
        AND     GAM.entity_cre_flg  = 'Y';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        outstanding_amount := 0;
    END;
    --}
    END IF;

    outstanding_amount := ABS(outstanding_amount);

    IF(ip_crncy_code != 'AED') THEN
        outstanding_amount := CommonPackage.getConvertedAmount(inp_bank_id,outstanding_amount,ip_crncy_code,'AED','MID',v_as_on_date);
    END IF;

-- Find the interest suspense bacid that is set in GSPM.
    iv_int_susp_amt := IntsuspAmt(inp_bank_id,v_acid,v_as_on_date);

--    Remove the interest suspense component from the outstanding balance to get the
--    final outstanding amount

    outstanding_amount    :=    outstanding_amount - iv_int_susp_amt;

    RETURN outstanding_amount;
END eabBalexclintsusp;


-------------------------------------------------------------------------------------
--FUNCTION IntsuspAmt
--Finds the Total Interest Suspense amount For a given Acid
------------------------------------------------------------------------------------
FUNCTION IntsuspAmt( inp_bank_id varchar2,
                     v_acid  varchar2,
                     v_as_on_date   DATE)RETURN NUMBER is

v_int_susp_bacid tbaadm.GAM.acid%TYPE;
v_int_susp_amt      tbaadm.GAM.clr_bal_amt%TYPE := 0;
v_int_susp_acid     tbaadm.GAM.acid%TYPE;
BEGIN
--{

    Begin
        Select  int_susp_bacid
        Into    v_int_susp_bacid
        from    tbaadm.AIP,tbaadm.ACH,tbaadm.GAM
        Where   AIP.bank_id = inp_bank_id
        AND     AIP.bank_id = ACH.BANK_id 
        AND     AIP.bank_id = GAM.bank_id
        AND     ach.b2k_id=v_acid
        AND     ach.b2k_id = GAM.acid
        And     aip.b2k_type='ACCNT'
        And     ach.b2k_type='ACCNT'
        And     aip.schm_code= GAM.schm_code
        And     ach.main_classification_user=aip.main_asset_class
        And     ach.sub_classification_user=aip.sub_asset_class
        And     srl_num = ( SELECT  MAX(srl_num)
                            FROM    tbaadm.ACH
                            WHERE   ACH.bank_id = inp_bank_id
                            AND     b2k_id=v_acid
                            And     b2k_type='ACCNT'
                            And     user_classification_date<=v_as_on_date);
    Exception when no_data_found then
        v_int_susp_bacid := '';
    End;

--Finding the acid corresponding to the Bacid
    Begin
        Select acid
        into  v_int_susp_acid
        from tbaadm.gam
        where bank_id = inp_bank_id
        and bacid = v_int_susp_bacid
        and acct_crncy_code = (select acct_crncy_code from tbaadm.gam where bank_id = inp_bank_id and  acid=v_acid)
        and sol_id =(select sol_id from tbaadm.gam where bank_id = inp_bank_id and acid=v_acid);
    Exception when no_data_found then
         v_int_susp_acid := '';
    End;


-- Given the interest suspense bacid, get the partition details and obtain the
-- amount in interest suspense from ACPART table as follows
 Begin
    SELECT  nvl(sum(decode(part_tran_type,'C' ,tran_amt,'D',-tran_amt)),0)
    INTO    v_int_susp_amt
    FROM    tbaadm.acpart
    WHERE   acpart.bank_id = inp_bank_id 
    AND     acpart.partitioned_acid= v_int_susp_acid
    AND     acpart.b2k_type='ACCNT'
    AND     acpart.b2k_id=v_acid
    AND     acpart.tran_date <=v_as_on_date
    AND     acpart.pstd_flg='Y';
Exception when no_data_found then
        v_int_susp_amt :='';
    End;

        RETURN v_int_susp_amt;

END IntsuspAmt;


-------------------------------------------------------------------------------------


--------------------------------------------------------------------------------

FUNCTION getGlBalLcy(   inp_bank_id  varchar2,
                        setId           varchar2,
                        glCode          varchar2,
                        glTransDate     date )  RETURN NUMBER IS
--------------------------------------------------------------------------------------

CURSOR GetGLSubHeads     (inp_bank_id    varchar2,
                        setId            tbaadm.SST.set_id%type,
                        glCode          tbaadm.GSH.GL_CODE%type,
                        glTransDate     tbaadm.GST.tran_date%type )  is

        SELECT    gl_sub_head_code,sst.sol_id
        FROM    tbaadm.GSH,tbaadm.SST
        WHERE   GSH.BANK_ID = inp_bank_id
        AND     GSH.BANK_ID = SST.BANK_ID 
        AND     gl_code = glCode
        AND     crncy_code = 'AED'
        AND        GSH.sol_id = SST.sol_id
        AND        SST.set_id = setId;

CURSOR GetAmt  ( inp_bank_id varchar2,
                 solId            tbaadm.SST.sol_id%type,
                glSubheadCode    tbaadm.GST.gl_sub_head_code%type,
                glTransDate        tbaadm.GST.tran_date%type    )  IS

    SELECT  NVL(tot_cr_bal,0) - NVL(tot_dr_bal,0)
    FROM    tbaadm.GST
    WHERE   GST.BANK_ID = inp_bank_id
    AND     gl_sub_head_code = glSubheadCode
    AND     crncy_code ='AED'
    AND         tran_date = glTransDate
    AND        sol_id = solId
    AND        del_flg != 'Y';

BEGIN--{

    IF NOT GetGLSubHeads%ISOPEN THEN --{
        OPEN GetGLSubHeads(inp_bank_id,setId,glCode,glTransDate );
    END IF;--}

LOOP--{

    FETCH    GetGLSubHeads
    INTO    glSubheadCode,
            solId;

    IF GetGLSubHeads%NOTFOUND THEN --{
        CLOSE GetGLSubHeads;
        EXIT;
    END IF;--}

    IF NOT GetAmt%ISOPEN THEN --{
        OPEN GetAmt( inp_bank_id,SolId , glSubheadCode , glTransDate);
    END IF;--}

    LOOP--{
        glAmt :=0;

        FETCH    GetAmt
        INTO    glAmt;

        IF GetAmt%NOTFOUND THEN --{
            CLOSE GetAmt;
            EXIT;
        END IF;--}

        totalGLBal:=totalGLBal + glAmt;

    END LOOP;--}
END LOOP;--}

    RETURN totalGLBal;
END getGlBalLcy;--}

--------------------------------------------------------------------------------------
FUNCTION getGlBalFcy(inp_bank_id  varchar2,
                     setId        varchar2,
                     glCode        varchar2,
                     glTransDate    date) RETURN NUMBER IS
--------------------------------------------------------------------------------------

    ratecode        tbaadm.GCT.report_rate_code%TYPE;

CURSOR GetGLSubHeads (inp_bank_id  varchar2,
                      setId        tbaadm.SST.set_id%type,
                      glCode        tbaadm.GSH.GL_CODE%type,
                      glTransDate    tbaadm.GST.tran_date%type )  IS

    SELECT    gl_sub_head_code,sst.sol_id,gsh.crncy_code
    FROM    tbaadm.GSH,tbaadm.SST
    WHERE   GSH.BANK_ID = inp_bank_id
    AND     GSH.BANK_ID = SST.BANK_ID 
    AND     gl_code = glCode
    AND     crncy_code != 'AED'
    AND        GSH.sol_id = SST.sol_id
    AND        SST.set_id = setId;

    CURSOR GetAmt  (inp_bank_id  varchar2,
                    solId            tbaadm.SST.sol_id%type,
                    glSubheadCode    tbaadm.GST.gl_sub_head_code%type,
                    glTransDate        tbaadm.GST.tran_date%type,
                    rate            tbaadm.RTL.VAR_CRNCY_UNITS%type)  IS

    SELECT  (NVL(tot_cr_bal,0) - NVL(tot_dr_bal,0)) * rate
    FROM    tbaadm.GST
    WHERE   GST.BANK_ID = inp_bank_id
    AND     gl_sub_head_code = glSubheadCode
    AND     crncy_code = crncyCode
    AND         tran_date = glTransDate
    AND        sol_id = solId
    AND        del_flg != 'Y';

BEGIN--{

        IF NOT GetGLSubHeads%ISOPEN THEN --{
            OPEN GetGLSubHeads(inp_bank_id,setId,glCode,glTransDate );
        END IF;--}

    LOOP--{

        FETCH    GetGLSubHeads
        INTO    glSubheadCode,
                solId,
                crncyCode;

        IF GetGLSubHeads%NOTFOUND THEN --{
            CLOSE GetGLSubHeads;
            EXIT;
        END IF;--}

        Begin

        Select report_rate_code INTO ratecode FROM tbaadm.GCT where bank_id = inp_bank_id;

        SELECT getConvRate(inp_bank_id,'AED',crncyCode,ratecode ,glTransDate)
        INTO rate
        FROM dual;

        Exception
        when no_data_found then
            rate := 1;
        End;

        IF NOT GetAmt%ISOPEN THEN --{
            OPEN GetAmt( inp_bank_id,SolId , glSubheadCode , glTransDate,rate);
        END IF;--}

        LOOP--{
            glAmt :=0;

            FETCH    GetAmt
            INTO    glAmt;

            IF GetAmt%NOTFOUND THEN --{
                CLOSE GetAmt;
                EXIT;
            END IF;--}

            totalGLBal:=totalGLBal + glAmt;

        END LOOP;--}
    END LOOP;--}

        RETURN(totalGLBal);
END getGlBalFcy;--}

------------------------------------------------------------------------------------------------------------------
--Procedure is used to  get the rate of conversion from a foreign currency to a local currency at a particular date
FUNCTION getConvRate(   inp_bank_id  varchar2,
                        fixedCrncyCode varchar2,
                        varCrncyCode varchar2,
                        Rate_Code varchar2,
                        inpAsOnDate date) return number is
---------------------------------------------------------------------------------------------------------------------

cursor c1 is
select (to_number(nvl(var_crncy_units,'0')))/(to_number(nvl(decode(fxd_crncy_units,'0','1',fxd_crncy_units),'1'))) finalrate
from tbaadm.rth r1
        where r1.bank_id = inp_bank_id
        and r1.fxd_crncy_code = fixedCrncyCode
        and r1.var_crncy_code = varCrncyCode
        and r1.ratecode = Rate_Code
        and r1.del_flg != 'Y'
        and r1.rtlist_date = (  select max(r2.rtlist_date)
                                from tbaadm.rth r2
                                where r2.bank_id = inp_bank_id
                                and r2.fxd_crncy_code = fixedCrncyCode
                                and r2.var_crncy_code = varCrncyCode
                                and r2.ratecode = Rate_Code
                                and r2.rtlist_date <= trunc(inpAsOnDate)
                                and r2.del_flg  != 'Y')
        order by r1.rcre_time desc ;

i  c1%rowtype;
cursor c2 is
select (to_number(nvl(fxd_crncy_units,'0')))/(to_number(nvl(decode(var_crncy_units,'0','1',var_crncy_units),'1'))) finalrate
from tbaadm.rth r1
        where r1.bank_id = inp_bank_id
        and r1.fxd_crncy_code = varCrncyCode
        and r1.var_crncy_code = fixedCrncyCode
        and r1.ratecode = Rate_Code
        and r1.del_flg != 'Y'
        and r1.rtlist_date = (  select max(r2.rtlist_date)
                                from tbaadm.rth r2
                                where r2.bank_id = inp_bank_id
                                and r2.fxd_crncy_code = varCrncyCode
                                and r2.var_crncy_code = fixedCrncyCode
                                and r2.ratecode = Rate_Code
                                and r2.rtlist_date <= trunc(inpAsOnDate)
                                and r2.del_flg  != 'Y')
        order by r1.rcre_time desc ;

j  c2%rowtype;

begin
    ExRate := 0;
    if varCrncyCode = fixedCrncyCode then
        ExRate := 1;
        return(ExRate);
    end if;

    for i in c1
    loop
        ExRate := i.finalrate;
        exit;
    end loop;

    if ExRate = 0 then
        begin
            for j in c2
            loop
                ExRate := j.finalrate;
                exit;
            end loop;
        end;
    end if;

    if ExRate = 0 then
        ExRate := 1;
    end if;

    return(ExRate);
end getConvRate;

--------------------------------------------------------------------------------------
--Function to convert foriegn currency amount into Home currency amount.
FUNCTION getConvertedAmount(    inp_bank_id  varchar2,
                                balance NUMBER,
                                fCrncyCode VARCHAR2,
                                iCrncyCode VARCHAR2,
                                inpRateCode    VARCHAR2,
                                inpAsOnDate DATE) RETURN NUMBER is
--------------------------------------------------------------------------------------

Rate            tbaadm.RTL.VAR_CRNCY_UNITS%type;
flag            number(1) :=0;
fixedCode        tbaadm.rtm.fxd_crncy_code%type;
variableCode    tbaadm.rtm.var_crncy_code%type;

BEGIN--{

    if (fCrncyCode = iCrncyCode) then
        return balance;
    end if;

    BEGIN
        select  fxd_crncy_code, var_crncy_code
        into    fixedCode, variableCode
        from    tbaadm.rtm
        where   rtm.BANK_ID = inp_bank_id
        and     fxd_crncy_code= fCrncyCode
        and     var_crncy_code= iCrncyCode
        and     del_flg !='Y'
        and     ratecode=inpRateCode;

        EXCEPTION
            when no_data_found then
            flag:=1;
    END;

    IF flag=1 THEN
        BEGIN
            select  fxd_crncy_code, var_crncy_code
            into    fixedCode, variableCode
            from    tbaadm.rtm
            where   rtm.BANK_ID = inp_bank_id
            and     fxd_crncy_code= iCrncyCode
            and     var_crncy_code= fCrncyCode
            and     del_flg !='Y'
            and     ratecode=inpRateCode;

            EXCEPTION
                when no_data_found then flag:=2;
        END;
    END IF;

    Rate := getConvRate(inp_bank_id,fCrncyCode,iCrncyCode,inpRateCode,inpAsOnDate);
    IF flag=1 THEN
        Rate := 1/Rate;
    END IF;
    ConvertAmount := balance * Rate;

    return(ConvertAmount);

END getConvertedAmount;--}



----------------------------------------------------------------------------------------
--Function is used to get the outstanding balance Between the given period

FUNCTION getTranAmtForPeriod(   inp_bank_id  varchar2,
                                StartDate    tbaadm.eab.eod_date%type,
                                EndDate     tbaadm.eab.eod_date%type,
                                AccountId   tbaadm.gam.acid%type)
RETURN NUMBER AS
---------------------------------------------------------------------------------------

    Amount1      tbaadm.eab.tran_date_bal%type;
    Amount2         tbaadm.eab.tran_date_bal%type;
    Amount         tbaadm.eab.tran_date_bal%type;

BEGIN --{
    BEGIN --{
       SELECT    tran_date_bal
           INTO    Amount1
        FROM    tbaadm.eab,tbaadm.gam
        WHERE      eab.bank_id = inp_bank_id
        AND        eab.bank_id = gam.bank_id
        AND        eab.acid = AccountId
        AND        eab.acid = gam.acid
        AND        eod_date <= to_date(StartDate,'dd-mm-yyyy') -1
        AND        end_eod_date >= to_date(StartDate,'dd-mm-yyyy') -1;
        EXCEPTION WHEN NO_DATA_FOUND THEN
        Amount1 := 0;
    END;

    BEGIN--{
        SELECT  tran_date_bal
        INTO    Amount2
        FROM    tbaadm.eab,tbaadm.gam
        WHERE   eab.bank_id = inp_bank_id
        AND     eab.bank_id = gam.bank_id
        AND     eab.acid = AccountId
        AND     eab.acid = gam.acid
        AND     eod_date <= EndDate
        AND     end_eod_date >= EndDate;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           Amount2 := 0;
    END;--}

        Amount := (Amount1 - Amount2);
        RETURN Amount;

END getTranAmtForPeriod;

------------------------------------------------------------------
--Function is used to get the outstanding balance for a particular glsubhead
----------------------------------------------------------------------------

FUNCTION getGlSubHeadBalLcy(inp_bank_id  varchar2, setId varchar2, glSubheadCode varchar2, glTransDate date)
RETURN NUMBER IS
----------------------------------------------------------------------------------------

    glSubheadBal        tbaadm.GST.tot_cr_bal%type:=0;
    totalGlSubheadBal    tbaadm.GST.tot_cr_bal%type:=0;


CURSOR    GetBalance(inp_bank_id  varchar2,setId tbaadm.SST.set_id%type,
                     glSubheadCode    tbaadm.GST.gl_sub_head_code%type, glTransDate tbaadm.GST.tran_date%type)IS
        SELECT  NVL(tot_cr_bal,0) - NVL(tot_dr_bal,0)
        FROM    tbaadm.GST,tbaadm.SST
        WHERE   GST.BANK_ID = inp_bank_id
        AND     GST.BANK_ID = SST.BANK_ID
        AND     gl_sub_head_code = glSubheadCode
        AND     GST.del_flg != 'Y'
        AND     crncy_code = 'AED'
        AND     GST.sol_id = SST.sol_id
        AND     SST.set_id = setId
        AND     tran_date <= glTransDate
        AND     end_tran_date >=  glTransDate;

BEGIN--{

    IF NOT GetBalance%ISOPEN THEN --{
        OPEN GetBalance(inp_bank_id, setId , glSubheadCode , glTransDate);
    END IF;--}


    LOOP--{

        glSubheadBal :=0;

        FETCH   GetBalance
        INTO    glSubheadBal;

        IF GetBalance%NOTFOUND THEN --{
            close GetBalance;
            exit;
        END IF;--}

        totalGlSubheadBal:=totalGlSubheadBal + glSubheadBal;

    END LOOP;--}
            RETURN totalGlSubheadBal;
--}
END getGlSubHeadBalLcy; --}

---------------------------------------------------------------------------------------------
FUNCTION getGlSubHeadBalFcy(inp_bank_id  varchar2,
                            iSetId varchar2,
                            glSubHeadCode varchar2,
                            inpAsOnDate date)     RETURN NUMBER Is
---------------------------------------------------------------------------------------------

glSubHead_amt           tbaadm.EAB.tran_date_bal%type;
glSubHead_amt_INR       tbaadm.EAB.tran_date_bal%type:=0.00;
crncy_code                tbaadm.GAM.crncy_code%type;

Cursor getGlBal(inp_bank_id  varchar2,iSetId varchar2,glSubHeadCode varchar2, inpAsOnDate date) IS
    SELECT  (NVL(tot_cr_bal,0) - NVL(tot_dr_bal,0)),crncy_code
    FROM    tbaadm.GST,tbaadm.SST
    WHERE   GST.BANK_ID = inp_bank_id
    AND     GST.BANK_ID = SST.BANK_ID
    AND     gl_sub_head_code = glSubHeadCode
    AND     GST.del_flg != 'Y'
    AND     crncy_code != 'AED'
    AND     GST.sol_id = SST.sol_id
    AND     SST.set_id = iSetId
    AND     tran_date <= inpAsOnDate
    AND  end_tran_date >=  inpAsOnDate;

BEGIN
--{

    IF NOT getGlBal%ISOPEN THEN --{
            OPEN getGlBal(inp_bank_id,iSetId,glSubHeadCode,inpAsOnDate);
    END IF;--}

    LOOP
    --{
        FETCH   getGlBal
        INTO    glSubHead_amt,crncy_code;

        IF getGlBal%NOTFOUND THEN --{
            close getGlBal;
            exit;
        END IF;--}

        glSubHead_amt_INR:= glSubHead_amt_INR + getConvertedAmount(inp_bank_id,glSubHead_amt,crncy_code,'AED','MID',inpAsOnDate);

    END LOOP;--}

        return(glSubHead_amt_INR);

    END getGlSubHeadBalFcy;
--}

-------------------------------------------------------------------------------------
--Function to get the asset classification code
FUNCTION selNpaOrNot(inp_bank_id  varchar2,inputdt DATE, acctid VARCHAR2) RETURN NUMBER IS
--------------------------------------------------------------------------------------

assetCode     varchar(15);
maxsrl         tbaadm.ach.srl_num%type;
npaFlag        number;

BEGIN
    --{
    BEGIN
        --{
            BEGIN
            --{
                SELECT     MAX(srl_num) INTO maxsrl FROM tbaadm.ACH
                WHERE   bank_id = inp_bank_id 
                AND     b2k_id=acctid
                AND     b2k_type='ACCNT'
                AND     user_classification_date <=inputdt;

            EXCEPTION WHEN NO_DATA_FOUND THEN
                maxsrl := 0;
            END;
            --}

                SELECT    NVL(sub_classification_user,'001')
                INTO     assetCode
                FROM     tbaadm.ACH
                WHERE   bank_id = inp_bank_id  
                AND     b2k_id=acctid
                AND     b2k_type='ACCNT'
                AND     srl_num=maxsrl;

            EXCEPTION WHEN NO_DATA_FOUND THEN
                assetCode :='001';
        END;
        --}

        IF (assetCode = '001') THEN
            npaFlag    :=    0;
        ELSE
            npaFlag    :=    1;
        END IF;

        RETURN npaFlag;
END selNpaOrNot;--}

-------------------------------------------------------------------------------------
--Procedure to get the main asset classification code, asset classfied date
PROCEDURE getAssetClassfnDetails(   inp_bank_id  varchar2,
                                    inputDate            IN DATE,
                                    accountId            IN VARCHAR2,
                                    assetClassfnSrlNum    OUT    VARCHAR2,
                                    userMainClassfnCode    OUT    VARCHAR2,
                                    userSubClassfnCode    OUT    VARCHAR2,
                                    userClassfnDate        OUT    VARCHAR2) AS
-- Reviewed by Praveena on 18th Feb
--------------------------------------------------------------------------------------

BEGIN
    BEGIN
        SELECT  srl_num,
                main_classification_user,
                sub_classification_user,
                user_classification_date
        INTO    assetClassfnSrlNum,
                userMainClassfnCode,
                userSubClassfnCode,
                userClassfnDate
        FROM    tbaadm.ach
        WHERE       bank_id = inp_bank_id 
        AND         b2k_type = 'ACCNT'
        AND         b2k_id = accountId
        AND         srl_num = ( SELECT  MAX(srl_num)
                            FROM    tbaadm.ach
                            WHERE       bank_id = inp_bank_id 
                            AND         b2k_id = accountId
                            AND         b2k_type = 'ACCNT'
                            AND         user_classification_date <= inputDate);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            userMainClassfnCode := NULL;
            userSubClassfnCode := NULL;
            userClassfnDate := inputDate;
    END;
END getAssetClassfnDetails;

----------------------------------------------------------------------------------------
--Procedure to get the asset classification as Standard/Substandard/Doubtful/Loss etc
-- Added by Rajeev on 14-3-2004

PROCEDURE getClassfnofAsset(inp_bank_id  varchar2,
                            inputDate           IN DATE,
                            accountId           IN VARCHAR2,
                            lv_stdregular       OUT NUMBER,
                            lv_stdirregular     OUT NUMBER,
                            lv_substandard      OUT NUMBER,
                            lv_doubtfulassets   OUT NUMBER,
                            lv_lossassets       OUT NUMBER) AS

lv_astClassfnSrlNum             NUMBER;
lv_userMainClassfnCode          tbaadm.ACH.main_classification_user%TYPE;
lv_userSubClassfnCode           tbaadm.ACH.sub_classification_user%TYPE;
lv_userClassfnDate              tbaadm.ACH.user_classification_date%TYPE;
Outstanding_amount         tbaadm.EAB.TRAN_DATE_BAL%TYPE:=0;

BEGIN

lv_stdregular      :=0;
lv_stdirregular   :=0;
lv_substandard    :=0;
lv_doubtfulassets :=0;
lv_lossassets     :=0;

    getAssetClassfnDetails(inp_bank_id,inputDate,accountId,lv_astClassfnSrlNum,lv_userMainClassfnCode,lv_userSubClassfnCode,lv_userClassfnDate);
    IF(lv_userMainClassfnCode = '001') THEN
    --{
         Outstanding_amount:= eabbal(inp_bank_id,accountId,inputDate);
         Outstanding_amount := ABS(Outstanding_amount);
         IF(lv_userSubClassfnCode = '001') THEN
         --{
             lv_stdregular := Outstanding_amount;
         --}
         ELSIF(lv_userSubClassfnCode = '002') THEN
         --{
            lv_stdirregular := Outstanding_amount;
         --}
         END IF;
    --}
    ELSIF(lv_userMainClassfnCode = '002') THEN
    --{
         Outstanding_amount:= eabBalexclintsusp(inp_bank_id,accountId,inputDate);
         Outstanding_amount := ABS(Outstanding_amount);
         IF(lv_userSubClassfnCode = '003') THEN
         --{
             lv_substandard := Outstanding_amount;
         --}
         ELSIF((lv_userSubClassfnCode='004') OR (lv_userSubClassfnCode='005') OR(lv_userSubClassfnCode='006')) THEN
         --{
            lv_doubtfulassets :=Outstanding_amount;
         --}
         ELSIF(lv_userSubClassfnCode='007')THEN
         --{
            lv_lossassets :=Outstanding_amount;
         --}
         END IF;
    --}
    END IF;

END getClassfnofAsset;

-------------------------------------------------------------------------------------
--Function to get the asset sub classification description
FUNCTION selAchCode(inp_bank_id  varchar2,inputDate DATE, accountId VARCHAR2) RETURN VARCHAR2 IS
--------------------------------------------------------------------------------------

userSubClassifnCode tbaadm.ach.sub_classification_user%type;
userSubClassifnDesc tbaadm.rct.ref_desc%type;
BEGIN
--{
    BEGIN
        SELECT  sub_classification_user
        INTO    userSubClassifnCode
        FROM    tbaadm.ach
        WHERE   bank_id = inp_bank_id 
        AND     b2k_type = 'ACCNT'
        AND     b2k_id = accountId
        AND     srl_num = ( SELECT  MAX(srl_num)
                            FROM    tbaadm.ach
                            WHERE   bank_id = inp_bank_id
                            AND     b2k_id = accountId
                            AND     b2k_type = 'ACCNT'
                            AND     user_classification_date <= inputDate);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            userSubClassifnCode := NULL;
    END;

    IF (userSubClassifnCode IS NULL) THEN
        userSubClassifnDesc := 'STANDARD';
    ELSE
        getRctDesc(inp_bank_id,'92',userSubClassifnCode,userSubClassifnDesc);
    null;
    END IF;

    RETURN userSubClassifnDesc;
END selAchCode;--}
---------------------------------------------------------------------------------------
FUNCTION calculateprovisionheldSchmCode(inp_bank_id  varchar2,
                                        schmCode   tbaadm.gam.schm_code%type,
                                        asOnDate   date) RETURN  NUMBER IS
---------------------------------------------------------------------------------------
        gamAcid             tbaadm.GAM.ACID%type;
        provisionAmt        number(25,4);
        totProvAmt          number(25,4);


    CURSOR GetAcctsCursor (schmCode   tbaadm.gam.schm_code%type, asOnDate  date)   IS
        SELECT          ACID
        FROM            tbaadm.GAM
        WHERE           BANK_ID = inp_bank_id
        AND             SCHM_CODE = schmCode
        AND             ACCT_OPN_DATE <= asOnDate
        AND             NVL(ACCT_CLS_DATE,to_date('31-12-2099'))  > asOnDate
        AND             DEL_FLG !='Y'
        AND             ENTITY_CRE_FLG ='Y';


BEGIN --{

    IF NOT GetAcctsCursor%ISOPEN THEN --{
        OPEN GetAcctsCursor (schmCode, asOnDate);
    END IF;--}

LOOP--{

    FETCH   GetAcctsCursor
    INTO    gamAcid ;

    IF (GetAcctsCursor%ISOPEN) AND (GetAcctsCursor%NOTFOUND) THEN --{
        CLOSE GetAcctsCursor;
        EXIT;
     ELSE
        --------------------------------------------------------------------
        -- Calling function for calculating Provision actually made
        -- Passing the parameters - acid and todate
        --------------------------------------------------------------------
         provisionAmt := CommonPackage.calculateProvisionheldYearly (inp_bank_id,gamAcid,
                                                                  asOnDate);

        totProvAmt := totProvAmt + provisionAmt;
    END IF; --}

END LOOP; --}

RETURN totProvAmt;

END calculateprovisionheldSchmCode; --}

---------------------------------------------------------------------------------------
FUNCTION calculateProvisionheldYearly(inp_bank_id  varchar2,    acctid   tbaadm.gam.acid%type,
                                         trandate tbaadm.gam.acct_cls_date%type) RETURN NUMBER IS
---------------------------------------------------------------------------------------

    provisionheld   tbaadm.acpart.tran_amt%type;
    startdate       tbaadm.gam.acct_cls_date%type;
    enddate         tbaadm.gam.acct_cls_date%type;
    bod_date        tbaadm.gct.db_stat_date%type;

BEGIN --{
    BEGIN --{

        IF trandate IS NULL THEN
            SELECT      db_stat_date
            INTO        enddate
            FROM        tbaadm.GCT
            where       bank_id = inp_bank_id;
        ELSE
            enddate := trandate;
        END IF;

        IF TO_NUMBER(substr(enddate,4,2)) > 3 THEN
            startdate :='01-04-'||substr(enddate,7,4);
        ELSE
            startdate := TO_DATE('01-04-'||(substr(enddate,7,4) -1));
        END IF;
        Select db_stat_date INTO bod_date from tbaadm.GCT
         where       bank_id = inp_bank_id;

        SELECT      sum(decode(part_tran_type,'C' ,tran_amt*getConvRate(inp_bank_id,tran_crncy_code,'AED','COR',bod_date),'D',-tran_amt*getConvRate(inp_bank_id,tran_crncy_code,'AED','COR',bod_date)))
        INTO        provisionheld
        FROM        tbaadm.alr,tbaadm.acpart
        WHERE       acpart.bank_id = inp_bank_id
        AND         acpart.bank_id = alr.bank_id
        AND         acpart.partitioned_acid=alr.acid
        AND         acpart.b2k_type='ACCNT'
        AND         acpart.b2k_id=acctid
        AND         acpart.tran_date >= startdate
        AND         acpart.tran_date <= enddate
        AND         acpart.pstd_flg='Y'
        AND         alr.del_flg!='Y'
        AND         alr.entity_cre_flg='Y'
        AND         alr.acct_label='PROVISION';
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            provisionheld := 0;
    END; --}

    RETURN  provisionheld;
END calculateProvisionheldYearly; --}

---------------------------------------------------------------------------------------------------
--     This Procedure gives the interest rate corresponding
--     to the PLR interest Table Code and returns  a  flag
--     indicating whether the Table Code is linked to the
--     PLR interest Table Code as Base

PROCEDURE linktblcode(  inp_bank_id  varchar2, inp_crncycode IN VARCHAR2,inp_bod_date IN DATE,inp_tblCode IN VARCHAR2,
                        out_flag OUT NUMBER,
                        out_interestRate OUT NUMBER) AS
---------------------------------------------------------------------------------------------------

    out_basePcnt  VARCHAR2(50);
BEGIN --{

     out_flag:=0;
     out_interestRate:=0;

        SELECT isLinkedtoBaseTblCode(inp_bank_id,inp_tblCode,'%PLR%',inp_crncyCode) into out_flag from dual;
        IF (out_flag=1) THEN
        --{
            getBaseRate(inp_bank_id,
            inp_tblCode,
            inp_bod_date,
            inp_crncyCode,
            out_flag,
            out_interestRate);
            --DBMS_OUTPUT.PUT_LINE(inp_tblCode||':'||inp_bod_date||':'||inp_crncyCode||':'||out_flag||':'||out_interestRate);
             --}
            END IF;
END linktblcode;--}

--------------------------------------------------------------------------------------
FUNCTION isLinkedtoBaseTblCode( inp_bank_id  varchar2,
                                intTableCode VARCHAR2,
                                baseTblCode VARCHAR2,
                                crncyCode VARCHAR2) RETURN integer IS
--------------------------------------------------------------------------------------
        foundFlg INTEGER;

BEGIN--{

    foundFlg := 0;
        SELECT 1
        INTO foundFlg
        FROM tbaadm.ICV
        WHERE bank_id = inp_bank_id
        AND INT_TBL_CODE = intTableCode
        AND CRNCY_CODE = crncyCode
        AND ENTITY_CRE_FLG = 'Y'
        AND DEL_FLG != 'Y'
        AND BASE_IND != 'Y'
        AND BASE_INT_TBL_CODE like baseTblCode
        AND INT_TBL_VER_NUM = (SELECT max(INT_TBL_VER_NUM)
                                FROM tbaadm.ICV
                                WHERE bank_id = inp_bank_id
                                AND INT_TBL_CODE = intTableCode
                                AND CRNCY_CODE = crncyCode
                                AND ENTITY_CRE_FLG = 'Y'
                                AND DEL_FLG != 'Y'
                                AND BASE_IND != 'Y'
                                AND BASE_INT_TBL_CODE like baseTblCode);
        RETURN(foundFlg);

EXCEPTION
        WHEN NO_DATA_FOUND THEN
        foundFlg := 0 ;
        RETURN(foundFlg);
END isLinkedtoBaseTblCode;--}

------------------------------------------------------------------------------------
--Procedure returns the base percentage for a particular currency code and a trandate

PROCEDURE getBaseRate(  inp_bank_id  varchar2,
                        intTableCode IN VARCHAR2,
                        asOnDate IN DATE,
                        crncyCode IN VARCHAR2,
                        foundFlg OUT INTEGER,
                        baseRate OUT NUMBER) IS
--------------------------------------------------------------------------------------

BEGIN--{

        SELECT TO_NUMBER(base_pcnt_dr)
        INTO baseRate
        FROM tbaadm.ICV
        WHERE bank_id = inp_bank_id
        AND del_flg       !=  'Y'
        AND entity_cre_flg  =   'Y'
        AND int_tbl_code    =   intTableCode
        AND start_date      <=  asOnDate
        AND end_date        >=  asOnDate
        AND base_ind        !=  'Y'
        AND crncy_code      =   crncyCode
        AND lchg_time = (   SELECT max(lchg_time)
                            FROM tbaadm.ICV B
                            WHERE B.bank_id = inp_bank_id
                            And B.del_flg         !=  'Y'
                            AND B.entity_cre_flg    =   'Y'
                            AND B.lchg_time         <=  to_date('31-12-2099 00:00:00','dd-mm-yyyy hh24:mi:ss')
                            AND B.int_tbl_code      = intTableCode
                            AND B.base_ind          !=  'Y'
                            AND B.crncy_code        = crncyCode
                            AND B.start_date        <= asOnDate
                            AND B.end_date          >= asOnDate)
                            AND ROWNUM = 1;

        foundFlg := 1 ;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
            foundFlg := 0 ;
            baseRate := 0;
END getBaseRate;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
FUNCTION GetEABValueBal(inp_bank_id  varchar2, v_foracid       varchar2,
                        v_as_on_date    date) RETURN NUMBER is
outstanding_amount  number;
--------------------------------------------------------------------------------

BEGIN
    BEGIN
        SELECT      nvl(value_date_bal,0)
            INTO    outstanding_amount
            FROM    tbaadm.EAB,tbaadm.GAM
            WHERE EAB.bank_id = inp_bank_id
            AND  EAB.bank_id = GAM.bank_id
            AND  EAB.acid = GAM.acid
            AND  GAM.foracid = v_foracid
            AND  eod_date <= v_as_on_date
            AND  end_eod_date >= v_as_on_date;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            outstanding_amount := 0;
        END;
        RETURN outstanding_amount;

END GetEABValueBal;


--------------------------------------------------------------------------------
FUNCTION eabBalForacid( inp_bank_id varchar2,   v_foracid        varchar2,
                        v_as_on_date       date) RETURN NUMBER is
outstanding_amount  number;
--------------------------------------------------------------------------------

BEGIN
--{
    BEGIN
        SELECT      nvl(tran_date_bal,0)
            INTO    outstanding_amount
            FROM    tbaadm.EAB,tbaadm.GAM
            WHERE   EAB.BANK_ID = inp_bank_id
            AND     EAB.BANK_ID = GAM.BANK_ID
            AND     EAB.acid = GAM.acid
            AND     GAM.foracid = v_foracid
            AND     eod_date <= v_as_on_date
            AND     end_eod_date >= v_as_on_date;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            outstanding_amount := 0;
        END;
        RETURN outstanding_amount;

END eabBalForacid;
---------------------------------------------------------------------------------------
FUNCTION eabBalInAED(inp_bank_id varchar2,inpacid  varchar2,
                    inpAsOnDate date) RETURN NUMBER IS
---------------------------------------------------------------------------------------

crncyCode        tbaadm.gam.acct_crncy_code%type;
EAB_amt            tbaadm.eab.tran_date_bal%type;

BEGIN--{
    BEGIN--{

        SELECT     NVL(tran_date_bal,0),acct_crncy_code
        INTO     EAB_amt,crncyCode
        FROM     tbaadm.EAB,tbaadm.GAM
        WHERE   EAB.BANK_ID = inp_bank_id
        AND     EAB.BANK_ID = GAM.BANK_ID
        AND     GAM.acid = inpacid
        and     GAM.acid = EAB.acid
        AND     eod_date         <= TO_DATE(inpAsOnDate)
        AND     end_eod_date      >= TO_DATE(inpAsOnDate);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            EAB_amt :=0.00;
    END;--}

    IF (crncyCode !='AED') then
        EAB_amt:=getConvertedAmount(inp_bank_id,EAB_amt,crncyCode,'AED','MID',inpAsOnDate);
    END IF;

    RETURN(EAB_amt);
END eabBalInAED;--}


---------------------------------------------------------------------------------------
FUNCTION getDemandAmount (  inp_bank_id     IN varchar2,
                            inp_asOnDate    IN DATE,
                            inp_acid        IN VARCHAR2) RETURN NUMBER IS
                            out_demand_amt  tbaadm.LDT.dmd_amt%TYPE;
---------------------------------------------------------------------------------------
BEGIN
    SELECT  NVL(SUM(LDT.dmd_amt),0)
    INTO    out_demand_amt
    FROM    tbaadm.LDT
    WHERE   LDT.bank_id = inp_bank_id
    AND     LDT.acid = inp_acid
    AND     LDT.dmd_eff_date <= inp_asOnDate
    AND     LDT.dmd_ovdu_date <= inp_asOnDate
    AND     LDT.del_flg !='Y';


    RETURN(out_demand_amt);
END getDemandAmount;

---------------------------------------------------------------------------------------
FUNCTION getDemandAmountForPeriod (     inp_bank_id  varchar2,
                                        inp_fromDate   IN DATE,
                                        inp_toDate     IN DATE,
                                        inp_acid       IN VARCHAR2)RETURN NUMBER IS
    out_demand_amt  tbaadm.LDT.dmd_amt%TYPE;
---------------------------------------------------------------------------------------
BEGIN
    SELECT  NVL(SUM(LDT.dmd_amt),0)
    INTO    out_demand_amt
    FROM    tbaadm.LDT
    WHERE   LDT.bank_id = inp_bank_id
    AND     LDT.acid = inp_acid
    AND     LDT.dmd_eff_date >= inp_fromDate
    AND     LDT.dmd_ovdu_date <= inp_toDate
    AND     LDT.del_flg !='Y';


    RETURN(out_demand_amt);
END getDemandAmountForPeriod;
---------------------------------------------------------------------------------------
FUNCTION getRecoveryAmount (    inp_bank_id     IN varchar2,
                                inp_asOnDate    IN DATE,
                                inp_acid        IN VARCHAR2) RETURN NUMBER IS
                                out_recovery_amt  tbaadm.LDT.tot_adj_amt%TYPE;
---------------------------------------------------------------------------------------
BEGIN
    SELECT  NVL(SUM(LDT.tot_adj_amt),0)
    INTO    out_recovery_amt
    FROM    tbaadm.LDT
    WHERE   LDT.bank_id = inp_bank_id 
    AND     LDT.acid = inp_acid
    AND     LDT.dmd_flow_id = 'PRNC'
    AND     LDT.dmd_eff_date <= inp_asOnDate
    AND     LDT.dmd_ovdu_date <= inp_asOnDate
    AND     LDT.del_flg !='Y';


    RETURN(out_recovery_amt);
END getRecoveryAmount;

---------------------------------------------------------------------------------------
FUNCTION getRecoveryAmountForPeriod (    inp_bank_id     IN varchar2,
                                         inp_fromDate   IN DATE,
                                         inp_toDate     IN DATE,
                                         inp_acid       IN VARCHAR2)RETURN NUMBER IS
    out_recovery_amt  tbaadm.LDT.tot_adj_amt%TYPE;
---------------------------------------------------------------------------------------
BEGIN
    SELECT  NVL(SUM(LDT.tot_adj_amt),0)
    INTO    out_recovery_amt
    FROM    tbaadm.LDT
    WHERE   LDT.bank_id = inp_bank_id
    AND     LDT.acid = inp_acid
    AND     LDT.dmd_flow_id = 'PRNC'
    AND     LDT.dmd_eff_date >= inp_fromDate
    AND     LDT.dmd_ovdu_date <= inp_toDate
    AND     LDT.del_flg !='Y';

    RETURN(out_recovery_amt);
END getRecoveryAmountForPeriod;
---------------------------------------------------------------------------------------

FUNCTION getOverdueAmount (     inp_bank_id    IN varchar2,
                                inp_asOnDate    IN DATE,
                                inp_acid        IN VARCHAR2) RETURN NUMBER IS
                                out_overdue_amt  tbaadm.LDT.tot_adj_amt%TYPE;

demand_amt      tbaadm.LDT.dmd_amt%TYPE;
recovery_amt    tbaadm.LDT.tot_adj_amt%TYPE;

BEGIN


    SELECT  NVL(SUM(LDT.dmd_amt),0)
    INTO    demand_amt
    FROM    tbaadm.LDT
    WHERE   LDT.bank_id = inp_bank_id
    AND     LDT.acid = inp_acid
    AND     LDT.dmd_eff_date <= inp_asOnDate
    AND     LDT.dmd_ovdu_date <= inp_asOnDate
    AND     LDT.del_flg !='Y';

    SELECT  NVL(SUM(LDT.tot_adj_amt),0)
    INTO    recovery_amt
    FROM    tbaadm.LDT
    WHERE   LDT.bank_id = inp_bank_id
    AND     LDT.acid = inp_acid
    AND     LDT.dmd_flow_id = 'PRNC'
    AND     LDT.dmd_eff_date <= inp_asOnDate
    AND     LDT.dmd_ovdu_date <= inp_asOnDate
    AND     LDT.del_flg !='Y';

-- IMP NOTE
--***********
-- Added by Roopa
-- Why 2 queries? Why can't this be done in one query???
-- Why dmd_flow_id = 'PRNC' considered while getting total adjust amount where as while calculating demand raised it is not considered??????
-- Please review this properly whoever reviews this.
    out_overdue_amt:= demand_amt - recovery_amt;

    IF (out_overdue_amt < 0) THEN
    out_overdue_amt := 0;
    END if;
    return(out_overdue_amt);

END getOverdueAmount;
--------------------------------------------------------------------------
--  FUNCTION To return the quarter begin date given ason date
--------------------------------------------------------------------------
FUNCTION getQrtrBegin(inp_bank_id    varchar2,asOnDate Date) RETURN DATE IS
--------------------------------------------------------------------------
--  Ariving at asOnDate Month and Year
---------------------------------------------------------------------------
lv_Cur_Year         VARCHAR2(4);
lv_Cur_Month    VARCHAR2(2);
lv_Qtr_Bgn_Date DATE;
lv_Qtr_Bgn_DDMM VARCHAR2(4);
BEGIN
    SELECT  to_char(asOnDate,'yyyy')
    INTO    lv_Cur_Year
    FROM    dual;

    SELECT to_char(asOnDate,'mm')
    INTO    lv_Cur_Month
    FROM    dual;
    --------------------------------------------------------------------------
    --  Ariving at Current Quarter Begin Date
    ---------------------------------------------------------------------------
    IF (lv_Cur_Month>=1) AND (lv_Cur_Month<=3) THEN --{
        lv_Qtr_Bgn_DDMM := '0101' ;
    ELSE
        IF (lv_Cur_Month>=4) AND (lv_Cur_Month<=6) THEN --{
            lv_Qtr_Bgn_DDMM := '0104' ;
        ELSE
            IF (lv_Cur_Month>=7) AND (lv_Cur_Month<=9) THEN --{
                lv_Qtr_Bgn_DDMM := '0107' ;
           ELSE
               IF (lv_Cur_Month>=10) AND (lv_Cur_Month<=12) THEN --{
                   lv_Qtr_Bgn_DDMM := '0110' ;
               END IF; --}
           END IF; --}
       END IF; --}
    END IF; --}
    lv_Qtr_Bgn_Date := to_date(lv_Qtr_Bgn_DDMM || lv_Cur_Year,'ddmmyyyy');
    RETURN lv_Qtr_Bgn_Date;
END getQrtrBegin;

--------------------------------------------------------------------------
-- FUNCTION getCurrHalfyearBegin
--------------------------------------------------------------------------
FUNCTION getCurrHalfyearBegin(inp_bank_id    varchar2,asOnDate Date) RETURN DATE IS
lv_month varchar2(2);
lv_year varchar2(4);
lv_month1 number(2);
lv_start_date_halfyear DATE;
BEGIN
    lv_month  := substr(asOnDate, 4, 2);
    lv_year   := substr(asOnDate, 7, 4);
    IF((lv_month >= 4) AND (lv_month <=9)) THEN
         lv_month1    :=4;
    ELSE
         lv_month1    :=10;
    END IF;
    lv_start_date_halfyear := to_date('01'||'-'||lv_month1||'-'||lv_year,'dd-mm-yyyy');
RETURN lv_start_date_halfyear;
END getCurrHalfyearBegin;
--------------------------------------------------------------------------
-- FUNCTION To return Month Begin date given ason date
--------------------------------------------------------------------------
FUNCTION getMonBegDate(inp_bank_id    varchar2,asOnDate Date) RETURN DATE IS
lv_month varchar2(2);
lv_year varchar2(4);
lv_curr_mon_beg DATE;
BEGIN
    lv_month        := substr(asOnDate, 4, 2);
    lv_year            := substr(asOnDate, 7, 4);
    lv_curr_mon_beg := to_date('01'||lv_month||lv_year,'ddmmyyyy');
 RETURN lv_curr_mon_beg;
END getMonBegDate;

--------------------------------------------------------------------------
--  FUNCTION To return the Financial year begin date given ason date
--------------------------------------------------------------------------
FUNCTION getCurFinYearBegin(inp_bank_id    varchar2,asOnDate Date) RETURN DATE IS
--------------------------------------------------------------------------
--  Ariving at asOnDate Month and Year
---------------------------------------------------------------------------
lv_fin_ddmm         VARCHAR2(4);
lv_Month        NUMBER(2);
lv_year         NUMBER(4);
lv_fin_begin_Date DATE;

BEGIN
    SELECT  fin_yr_ddmm
    INTO    lv_fin_ddmm
    FROM    tbaadm.GCT
    where   bank_id = inp_bank_id;

    SELECT     to_number(to_char(asOnDate,'mm')),to_number(to_char(asOnDate,'yyyy'))
    INTO    lv_Month,lv_year
    FROM    dual;

    --------------------------------------------------------------------------
    --  Ariving at Current Quarter Begin Date
    ---------------------------------------------------------------------------
    IF (lv_Month>=1) AND (lv_Month<=3) THEN --{
        lv_year := lv_year-1;
    END IF;

    lv_fin_begin_Date := to_date(lv_fin_ddmm || lv_year,'ddmmyyyy');
    RETURN lv_fin_begin_Date;
END getCurFinYearBegin;
--------------------------------------------------------------------------------
--  FUNCTION To return the Financial year end date for given ason date
--------------------------------------------------------------------------------
FUNCTION getCurFinYearEod(inp_bank_id    varchar2,asOnDate Date) RETURN DATE IS
lv_fin_ddmm         VARCHAR2(4);
lv_Month                NUMBER(2);
lv_year             NUMBER(4);
lv_fin_end_date        DATE;
BEGIN
    SELECT  fin_yr_ddmm
    INTO    lv_fin_ddmm
    FROM    tbaadm.GCT
    where  bank_id = inp_bank_id;

    SELECT  to_number(to_char(asOnDate,'mm')),to_number(to_char(asOnDate,'yyyy'))
    INTO    lv_Month,lv_year
    FROM    dual;

    --------------------------------------------------------------------------
    --  Ariving at Current Quarter Begin Date
    ---------------------------------------------------------------------------
    IF (lv_Month>=4) AND (lv_Month<=12) THEN --{
        lv_year := lv_year+1;
    END IF;

    lv_fin_end_date := to_date(lv_fin_ddmm || lv_year,'ddmmyyyy');
    SELECT lv_fin_end_date-1 INTO lv_fin_end_date FROM    dual;
    RETURN    lv_fin_end_date;
END getCurFinYearEod;

FUNCTION fnGetRctDesc(inp_bank_id    IN varchar2,
                      inp_rec_ref_type IN varchar2,
                      inp_ref_code IN varchar2) RETURN VARCHAR2 IS out_ref_desc VARCHAR2(15);

BEGIN

    BEGIN

        SELECT  NVL(ref_desc,'No Val')
        INTO    out_ref_desc
        FROM    tbaadm.RCT
        WHERE   RCT.bank_id = inp_bank_id
        AND     RCT.ref_rec_type = inp_rec_ref_type
        AND     RCT.ref_code = inp_ref_code;

        --DBMS_OUTPUT.PUT_LINE(inp_rec_ref_type||'|'||inp_ref_code||'|'||out_ref_desc);

--        RETURN out_ref_desc;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            out_ref_desc := 'No Val';
    END;

    --DBMS_OUTPUT.PUT_LINE('roopa'||inp_rec_ref_type||'|'||inp_ref_code||'|'||out_ref_desc);

    RETURN out_ref_desc;

END fnGetRctDesc;

----------------------------------------------------------------------------------------------
-- This procedure returns the credit or debit summation for a period for a given acid
----------------------------------------------------------------------------------------------
PROCEDURE creditOrdebitSumForPeriod(    inp_bank_id    IN varchar2,
                                        inp_fromdate IN Date,
                                        inp_todate IN Date,
                                        inp_acid IN tbaadm.GAM.acid%type,
                                        inp_db_cr_flag IN varchar2,
                                        out_amount OUT tbaadm.DTD.tran_amt%type    ) IS
BEGIN
    SELECT  nvl(sum(tran_amt),0)
    INTO    out_amount
    FROM    tbaadm.DCTD_ACLI
    WHERE bank_id = inp_bank_id 
    AND acid = inp_acid
    AND part_tran_type = inp_db_cr_flag
    AND tran_date >= inp_fromdate
    AND tran_date <= inp_todate
    AND    del_flg != 'Y'
    AND    pstd_flg = 'Y';
END creditOrdebitSumForPeriod;
------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
-- This procedure returns the credit or debit summation as on date for a given acid
----------------------------------------------------------------------------------------------
PROCEDURE creditOrdebitSumAsOnDate(     inp_bank_id    IN varchar2,
                                        inp_asOnDate IN Date,
                                        inp_acid IN tbaadm.GAM.acid%type,
                                        inp_db_cr_flag IN varchar2,
                                        out_amount OUT tbaadm.DTD.tran_amt%type    ) IS
BEGIN
    SELECT  nvl(sum(tran_amt),0)
    INTO    out_amount
    FROM    tbaadm.DCTD_ACLI
    WHERE   bank_id = inp_bank_id
    AND     acid = inp_acid
    AND     part_tran_type = inp_db_cr_flag
    AND     tran_date <= inp_asOnDate
    AND     del_flg != 'Y'
      AND     pstd_flg = 'Y';
END creditOrdebitSumAsOnDate;
------------------------------------------------------------------------------------------------
--Function to get the number of accounts from gam for a given emp_id
--------------------------------------------------------------------------

--------------------------------------------------------------------------
-- Function to Return Bod date
--------------------------------------------------------------------------
FUNCTION getBoddate(inp_bank_id    varchar2) RETURN DATE IS
lv_Bod_Date DATE;
BEGIN
    SELECT to_char(db_Stat_date,'dd-mm-yyyy') into lv_Bod_Date
    FROM tbaadm.GCT
    where bank_id = inp_bank_id;
RETURN lv_Bod_Date;
END getBoddate;


--------------------------------------------------------------------------
-- Function to Return date Of Last Friday Of Previous Month
--------------------------------------------------------------------------
FUNCTION getPrvMonthFridayDate (inp_bank_id varchar2, asOnDate Date) RETURN DATE IS
Last_Fri_Prv_Mon DATE;

BEGIN
        SELECT to_date(next_day(last_day(add_months(asOnDate,-1))-7,'FRIDAY'))
        INTO   Last_Fri_Prv_Mon
        FROM   dual;

RETURN Last_Fri_Prv_Mon;
END getPrvMonthFridayDate;

FUNCTION getSolDesc(inp_bank_id    varchar2, inp_SolId  VARCHAR2 ) RETURN varchar2 IS
SolDesc        tbaadm.sol.sol_desc%Type;
BEGIN
        SELECT    sol_desc
        INTO    SolDesc
        From    tbaadm.sol
        Where bank_id = inp_bank_id  
        and   sol.sol_id = inp_SolId;
RETURN    SolDesc;
END getSolDesc;
-----------------------------------------------------------------------------------------
FUNCTION getBudgetAmount (inp_bank_id    IN    varchar2,
                          inp_asOnDate    DATE,
                          inp_Solid      VARCHAR2,
                          inp_gl_subhead VARCHAR2)  RETURN NUMBER IS
lv_year         number :=0;
tot_count       number :=0;
BEGIN
--{

    SELECT  to_number(to_char(to_date(inp_asOnDate),'yyyy'))
    INTO    lv_year
    FROM    DUAL;


    SELECT  ('sub_head_budg_bal_'||to_char(inp_asOnDate,'mon'))
    INTO    tot_count
    FROM    tbaadm.SBT
    WHERE   SBT.BANK_ID = inp_bank_id
    AND     SBT.budg_cur_year = lv_year
    AND     SBT.sol_id  =  inp_Solid
    AND     SBT.sub_head_code = inp_gl_subhead;

RETURN tot_count;
--}
END getBudgetAmount;

--------------------------------------------------------------------------------------------------
FUNCTION getIntTableCode(inp_bank_id    IN    varchar2,
           inp_asOnDate        VARCHAR2,
            inp_changeUpToDate  VARCHAR2,
            inp_acid            VARCHAR2)RETURN VARCHAR2  IS

loc_intTblCode      VARCHAR2(5):=' ';
loc_asOnDate        DATE;
loc_changeUpToDate  DATE;
 -- {
 BEGIN
        loc_asOnDate        :=  inp_asOnDate ;
        loc_changeUpToDate  :=  TO_DATE (inp_changeUpToDate,'DD-MM-YYYY HH24:MI:SS');
        BEGIN
               SELECT int_tbl_code
            INTO loc_intTblCode
            FROM tbaadm.ITC a
            WHERE a.BANK_ID = inp_bank_id AND
                a.entity_id      = inp_acid AND
                a.entity_type    =   'ACCNT'   AND
                a.start_date     <=  loc_asOnDate AND
                a.end_date       >=  loc_asOnDate AND
                a.del_flg        !=  'Y' AND
                a.entity_cre_flg  =   'Y' AND
                a.lchg_time = (SELECT max(lchg_time) from tbaadm.ITC b
                        WHERE  b.BANK_ID = inp_bank_id AND
                               b.entity_id         =  inp_acid AND
                               b.entity_type       =   'ACCNT'   AND
                               b.del_flg           !=  'Y' AND
                               b.entity_cre_flg    =   'Y' AND
                               b.lchg_time         <=  loc_changeUpToDate AND
                               b.start_date        <=  loc_asOnDate AND
                               b.end_date          >=  loc_asOnDate )
                                AND ROWNUM = 1  ;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                BEGIN
                     loc_intTblCode := '';
                END ;
                WHEN OTHERS THEN
                BEGIN
                    loc_intTblCode := '';
                END;
    END;
    RETURN loc_intTblCode;
    END getIntTableCode;
-- }
-----------------------------------------------------------------------
-- PROCEDURE getMaturityPeriod
-- Gets the No of Days for Maturity from inp_asOnDate
-----------------------------------------------------------------------
PROCEDURE getMaturityPeriod(    inp_bank_id    IN varchar2,
                                inp_acid IN tbaadm.GAM.acid%TYPE,
                                inp_asOnDate IN DATE,
                                out_daysToMature OUT NUMBER) IS
BEGIN

    out_daysToMature := 50;

END getMaturityPeriod;

--------------------------------------------------------------------------------------

FUNCTION getOSAmtOfDCsInAED(    inp_bank_id    IN varchar2,
                                inp_dc_b2kid        IN  VARCHAR2,
                                inp_dc_crncy_code   IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER IS

outstanding_amt     tbaadm.FBH.event_amt%type:=0;
amount1             tbaadm.FBH.event_amt%type;
amount2             tbaadm.FBH.event_amt%type;

BEGIN
    SELECT  NVL(SUM(event_amt),0)
    INTO    amount1
    FROM    tbaadm.DCEM
    WHERE   bank_id = inp_bank_id
    AND     event_type in ('A','S','E')
    AND     event_date <= inp_asOnDate
    AND     dc_b2kid = inp_dc_b2kid
    AND     entity_cre_flg = 'Y';

    SELECT  NVL(SUM(event_amt),0)
    INTO    amount2
    FROM    tbaadm.DCEM
    WHERE   bank_id = inp_bank_id
    AND     event_type in ('Z','U','B')
    AND     event_date <= inp_asOnDate
    AND     dc_b2kid = inp_dc_b2kid
    AND     entity_cre_flg = 'Y';

    outstanding_amt := amount1 - amount2;
    IF(inp_dc_crncy_code != 'AED') THEN
        outstanding_amt := CommonPackage.getConvertedAmount(inp_bank_id,outstanding_amt,inp_dc_crncy_code,'AED','MID',inp_asOnDate);
    END IF;
    RETURN outstanding_amt;
END getOSAmtOfDCsInAED;

-------------------------------------------------------------------------------

FUNCTION getOSAmtOfBGsInAEDTradeFinance(    inp_bank_id    IN varchar2,
                                inp_bg_b2kid        IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER IS

outstanding_amt     tbaadm.FBH.event_amt%type:=0;
amount1             tbaadm.FBH.event_amt%type;
amount2             tbaadm.FBH.event_amt%type;

BEGIN
SELECT  NVL(SUM(DECODE(event_crncy,'AED',event_amt,CommonPackage.getConvertedAmount(inp_bank_id,event_amt,event_crncy,'AED',BGM.RATE_CODE,inp_asOnDate))),0)
    INTO    amount1
    FROM    tbaadm.BET,tbaadm.BGM
    WHERE   BET.bank_id = inp_bank_id
    AND     BET.bank_id = BGM.bank_id 
    AND     event_type in ('A','M')
    AND     event_date <= inp_asOnDate
    AND        BGM.bg_b2kid = BET.BG_b2kid
    AND     BGM.bg_b2kid = inp_bg_b2kid;

SELECT  NVL(SUM(DECODE(event_crncy,'AED',event_amt,CommonPackage.getConvertedAmount(inp_bank_id,event_amt,event_crncy,'AED',BGM.RATE_CODE,inp_asOnDate))),0)
    INTO    amount2
    FROM    tbaadm.BET,tbaadm.BGM
    WHERE   BET.bank_id = inp_bank_id
    AND     BET.bank_id = BGM.bank_id 
    AND     event_type in ('R','N')
    AND     event_date <= inp_asOnDate
    AND        BGM.bg_b2kid = BET.BG_b2kid
    AND     BGM.bg_b2kid = inp_bg_b2kid;

outstanding_amt := amount1 - amount2;
    RETURN outstanding_amt;
END getOSAmtOfBGsInAEDTradeFinance;

-------------------------------------------------------------------------------
FUNCTION getOSAmtOfBGsInAED(    inp_bank_id    IN varchar2,
                                inp_bg_b2kid        IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER IS

outstanding_amt     tbaadm.FBH.event_amt%type:=0;
amount1             tbaadm.FBH.event_amt%type;
amount2             tbaadm.FBH.event_amt%type;

BEGIN
SELECT  NVL(SUM(DECODE(event_crncy,'AED',event_amt,CommonPackage.getConvertedAmount(inp_bank_id,event_amt,event_crncy,'AED','MID',inp_asOnDate))),0)
    INTO    amount1
    FROM    tbaadm.BET
    WHERE   BET.bank_id = inp_bank_id
    AND     event_type in ('A','M')
    AND     event_date <= inp_asOnDate
    AND     bg_b2kid = inp_bg_b2kid;

SELECT  NVL(SUM(DECODE(event_crncy,'AED',event_amt,CommonPackage.getConvertedAmount(inp_bank_id,event_amt,event_crncy,'AED','MID',inp_asOnDate))),0)
    INTO    amount2
    FROM    tbaadm.BET
    WHERE   BET.bank_id = inp_bank_id 
    AND     event_type in ('R','N')
    AND     event_date <= inp_asOnDate
    AND     bg_b2kid = inp_bg_b2kid;

outstanding_amt := amount1 - amount2;
    RETURN outstanding_amt;
END getOSAmtOfBGsInAED;

-------------------------------------------------------------------------------
FUNCTION getOSAmtOfFCsInAED(    inp_bank_id    IN varchar2,
                                inp_frwrd_cntrct_num    IN  VARCHAR2,
                                inp_sol_id              IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER IS

outstanding_amt     tbaadm.FCH.cont_liab_amt%type:=0;
lv_action_date      tbaadm.FCH.action_date%type;

BEGIN
    BEGIN
    --{
        SELECT  MAX(action_date)
        INTO    lv_action_date
        FROM    tbaadm.FCH
        WHERE   bank_id = inp_bank_id
        AND     sol_id = inp_sol_id
        AND     frwrd_cntrct_num = inp_frwrd_cntrct_num
        AND     entity_cre_flg ='Y'
        AND     action_date <= inp_asOnDate;

        EXCEPTION WHEN NO_DATA_FOUND THEN
        lv_action_date := NULL;
    --}
    END;

 IF(lv_action_date IS NOT NULL) THEN
    --{
      SELECT  DECODE(cont_crncy,'AED',NVL(cont_liab_amt,0),CommonPackage.getConvertedAmount(inp_bank_id,nvl(cont_liab_amt,0),cont_crncy,'AED','MID',inp_asOnDate))
        INTO    outstanding_amt
        FROM    tbaadm.FCH
        WHERE   bank_id = inp_bank_id
        AND     sol_id = inp_sol_id
        AND     frwrd_cntrct_num = inp_frwrd_cntrct_num
        AND     entity_cre_flg ='Y'
        AND     action_date = lv_action_date
        AND     lchg_time = (SELECT MAX(lchg_time)
                            FROM    tbaadm.FCH
                            WHERE   bank_id = inp_bank_id
                            AND     sol_id = inp_sol_id
                            AND     frwrd_cntrct_num = inp_frwrd_cntrct_num
                            AND     entity_cre_flg ='Y'
                            AND     action_date = lv_action_date)
        AND  rownum < 2;
    --}
    END IF;

RETURN outstanding_amt;
END getOSAmtOfFCsInAED;

--------------------------------------------------------------------------------------

FUNCTION getOSAmtOfFcyBillsInAED(           inp_bank_id    IN varchar2,
                                            inp_bill_id         IN  VARCHAR2,
                                            inp_sol_id          IN  VARCHAR2,
                                            inp_bill_amt_aed    IN  NUMBER,
                                            inp_asOnDate        IN DATE) RETURN NUMBER IS

outstanding_amt     tbaadm.FBH.event_amt%type:=0;
lodged_amt          tbaadm.FBH.event_amt%type;
purchased_amt       tbaadm.FBH.event_amt%type;
realised_amt        tbaadm.FBH.event_amt%type;
delinked_amt        tbaadm.FBH.event_amt%type;
recovery_amt        tbaadm.FBH.event_amt%type;

BEGIN
    SELECT  NVL(SUM(event_amt*event_rate),0)
    INTO    lodged_amt
    FROM    tbaadm.FBH
    WHERE   bank_id = inp_bank_id 
    AND     sol_id = inp_sol_id
    AND     bill_id = inp_bill_id
    AND     vfd_bod_date <= inp_asOnDate
    AND     bill_func = 'G'
    AND     entity_cre_flg = 'Y'
    AND     del_flg != 'Y';

    SELECT  NVL(SUM(event_amt*event_rate),0)
    INTO    purchased_amt
    FROM    tbaadm.FBH
    WHERE   bank_id = inp_bank_id
    AND     sol_id = inp_sol_id
    AND     bill_id = inp_bill_id
    AND     vfd_bod_date <= inp_asOnDate
    AND     bill_func = 'P'
    AND     entity_cre_flg = 'Y'
    AND     del_flg != 'Y';

    SELECT  NVL(SUM(event_amt*event_rate),0)
    INTO    realised_amt
    FROM    tbaadm.FBH
    WHERE   bank_id = inp_bank_id
    AND     sol_id = inp_sol_id
    AND     bill_id = inp_bill_id
    AND     vfd_bod_date <= inp_asOnDate
    AND     bill_func = 'R'
    AND     entity_cre_flg = 'Y'
    AND     del_flg != 'Y';

    SELECT  NVL(SUM(event_amt),0)
    INTO    delinked_amt
    FROM    tbaadm.FBH
    WHERE   bank_id = inp_bank_id
    AND     sol_id = inp_sol_id
    AND     bill_id = inp_bill_id
    AND     vfd_bod_date <= inp_asOnDate
    AND     bill_func = 'K'
    AND     entity_cre_flg = 'Y'
    AND     del_flg != 'Y';

    SELECT  NVL(SUM(event_amt),0)
    INTO    recovery_amt
    FROM    tbaadm.FBH
    WHERE   bank_id = inp_bank_id
    AND     sol_id = inp_sol_id
    AND     bill_id = inp_bill_id
    AND     vfd_bod_date <= inp_asOnDate
    AND     bill_func = 'O'
    AND     entity_cre_flg = 'Y'
    AND     del_flg != 'Y';

    IF((lodged_amt > 0) AND (purchased_amt = 0) AND (realised_amt = 0) AND (delinked_amt = 0) AND (recovery_amt = 0)) THEN
        outstanding_amt := inp_bill_amt_aed;
    END IF;

    IF((lodged_amt > 0) AND (purchased_amt = 0) AND (realised_amt > 0)) THEN
        outstanding_amt := lodged_amt - realised_amt;
    END IF;

    IF((lodged_amt > 0) AND (purchased_amt > 0)) THEN
        outstanding_amt := purchased_amt - realised_amt;
    END IF;

    IF((lodged_amt > 0) AND (purchased_amt > 0) AND (realised_amt = 0) AND (delinked_amt > 0)) THEN
        outstanding_amt := delinked_amt - recovery_amt;
    END IF;

    RETURN outstanding_amt;
END getOSAmtOfFcyBillsInAED;

--------------------------------------------------------------------------------------

FUNCTION getOSAmtOfInlandBills( inp_bank_id    IN varchar2,
                                inp_bill_id         IN  VARCHAR2,
                                inp_sol_id          IN  VARCHAR2,
                                inp_reg_type        IN  VARCHAR2,
                                inp_asOnDate        IN DATE) RETURN NUMBER IS

outstanding_amt     tbaadm.FBH.event_amt%type:=0;
lodged_amt          tbaadm.FBH.event_amt%type;
realised_amt        tbaadm.FBH.event_amt%type;
bill_type           tbaadm.BRG.pur_flg%type;

BEGIN
    SELECT  pur_flg
    INTO    bill_type
    FROM    tbaadm.BRG
    WHERE   bank_id = inp_bank_id and reg_type = inp_reg_type;

    ------------------------
    -- Collection bills
    ------------------------
    IF(bill_type = 'N') THEN
    --{
        SELECT  NVL(SUM(event_amt),0)
        INTO    lodged_amt
        FROM    tbaadm.BEH
        WHERE   bank_id = inp_bank_id
        AND     sol_id = inp_sol_id
        AND     bill_id = inp_bill_id
        AND     vfd_bod_date <= inp_asOnDate
        AND     bill_func = 'G';

        SELECT  NVL(SUM(event_amt),0)
        INTO    realised_amt
        FROM    tbaadm.BEH
        WHERE   bank_id = inp_bank_id
        AND     sol_id = inp_sol_id
        AND     bill_id = inp_bill_id
        AND     vfd_bod_date <= inp_asOnDate
        AND     bill_func = 'R';

        outstanding_amt := lodged_amt - realised_amt;
    --}
    END IF;

    ------------------------
    -- Purchase bills
    ------------------------
    IF(bill_type = 'Y') THEN
    --{
        BEGIN
            --{
            SELECT  bill_liab
            INTO    outstanding_amt
            FROM    tbaadm.BEH
            WHERE   bank_id = inp_bank_id
            AND     bill_id = inp_bill_id
            AND     sol_id = inp_sol_id
            AND     lchg_time = (SELECT MAX(lchg_time)
                                FROM    tbaadm.BEH
                                WHERE   bank_id = inp_bank_id
                                AND     sol_id = inp_sol_id
                                AND     bill_id = inp_bill_id
                                AND     vfd_bod_date <= inp_asOnDate)
            AND     rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                    outstanding_amt :=0;
             --}
        END;
    --}
    END IF;

    RETURN outstanding_amt;
END getOSAmtOfInlandBills;
--------------------------------------------------------
--FUNCTION ProvisionAmt
--Finds the Total Provision amount For a given Acid
------------------------------------------------------------------------------------
FUNCTION ProvisionAmt( inp_bank_id varchar2,v_acid  varchar2,
                            v_as_on_date   DATE)RETURN NUMBER is

v_provision_cr_bacid tbaadm.GAM.acid%TYPE;
v_provision_amt      tbaadm.GAM.clr_bal_amt%TYPE := 0;
v_provision_acid     tbaadm.GAM.acid%TYPE;
BEGIN
--{

    Begin
        Select  prov_cr_bacid
        Into    v_provision_cr_bacid
        from    tbaadm.AIP,tbaadm.ACH,tbaadm.GAM
        Where   AIP.bank_id = inp_bank_id
        AND     AIP.bank_id = ACH.bank_id
        AND     AIP.bank_id = GAM.bank_id
        AND     ach.b2k_id=v_acid
        AND     ach.b2k_id = GAM.acid
        And     aip.b2k_type='ACCNT'
        And     ach.b2k_type='ACCNT'
        And     aip.schm_code= GAM.schm_code
        And     ach.main_classification_user=aip.main_asset_class
        And     ach.sub_classification_user=aip.sub_asset_class
        And     srl_num = ( SELECT  MAX(srl_num)
                            FROM    tbaadm.ACH
                            WHERE   bank_id = inp_bank_id
                            And     b2k_id=v_acid
                            And     b2k_type='ACCNT'
                            And     user_classification_date<=v_as_on_date);
    Exception when no_data_found then
        v_provision_cr_bacid := '';
    End;

--Finding the acid corresponding to the Bacid
    Begin
        Select acid
        into  v_provision_acid
        from tbaadm.gam
        where bank_id = inp_bank_id 
        and bacid = v_provision_cr_bacid
        and sol_id =(select sol_id from tbaadm.gam where bank_id = inp_bank_id and acid=v_acid);
    Exception when no_data_found then
         v_provision_acid := '';
    End;

-- Given the Provision bacid, get the partition details and obtain the
-- amount in Provison from ACPART table as follows
 Begin
    SELECT  nvl(sum(decode(part_tran_type,'C' ,tran_amt,'D',-tran_amt)),0)
    INTO    v_provision_amt
    FROM    tbaadm.acpart
    WHERE   acpart.bank_id = inp_bank_id
    AND     acpart.partitioned_acid= v_provision_acid
    AND     acpart.b2k_type='ACCNT'
    AND     acpart.b2k_id=v_acid
    AND     acpart.tran_date <=v_as_on_date
    AND     acpart.pstd_flg='Y';
Exception when no_data_found then
        v_provision_amt :='';
    End;
RETURN v_provision_amt;

END ProvisionAmt;

-------------------------------------------------------------------------------
--Function for getting Total credit and debit for a glsubhead for a period
-------------------------------------------------------------------------------

FUNCTION getTotCrDrGlSubheadForPeriod(              inp_bank_id    IN varchar2,
                                                    inp_glsubrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                                    inp_fromdate IN Date,
                                                    inp_todate IN Date) RETURN NUMBER IS

totamt        tbaadm.DTD.TRAN_AMT%TYPE;
BEGIN
--{
            SELECT  nvl(sum(tran_amt),0)
            INTO    totamt
            FROM    tbaadm.GAM,tbaadm.DCTD_ACLI,tbaadm.RKT
            WHERE   GAM.bank_id = inp_bank_id
            AND     GAM.bank_id = DCTD_ACLI.bank_id
            and     GAM.bank_id = RKT.bank_id
            AND     GAM.gl_sub_head_code   BETWEEN RKT.GPR_LOWER_CODE AND RKT.GPR_UPPER_CODE
            AND     GAM.acid = DCTD_ACLI.acid
            AND     RKT.GPR_RANGE_KEY = inp_glsubrangeAED
            AND     tran_date >= inp_fromdate
            AND     tran_date <= inp_todate
            AND     DCTD_ACLI.del_flg != 'Y'
            AND     DCTD_ACLI.pstd_flg = 'Y';
            RETURN totamt;
--}
END getTotCrDrGlSubheadForPeriod;

-------------------------------------------------------------------------------
--Function for getting Total credit and debit for a placeholder for a period
-------------------------------------------------------------------------------

FUNCTION getTotCrDrPlaceHolderForPeriod(  inp_bank_id    IN varchar2,
                                          inp_plrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                          inp_fromdate IN Date,
                                          inp_todate IN Date) RETURN NUMBER IS

totamt        tbaadm.DTD.TRAN_AMT%TYPE;
BEGIN
--{
            SELECT  nvl(sum(tran_amt),0)
            INTO    totamt
            FROM    tbaadm.GAM,tbaadm.RKT,tbaadm.DCTD_ACLI
            WHERE   GAM.bank_id = inp_bank_id
            AND     GAM.bank_id = DCTD_ACLI.bank_id
            and     GAM.bank_id = RKT.bank_id 
            AND     GAM.bacid   BETWEEN RKT.GPR_LOWER_CODE AND RKT.GPR_UPPER_CODE
            AND     GAM.acid = DCTD_ACLI.acid
            AND     RKT.GPR_RANGE_KEY = inp_plrangeAED
            AND     tran_date >= inp_fromdate
            AND     tran_date <= inp_todate
            AND     DCTD_ACLI.del_flg != 'Y'
            AND     DCTD_ACLI.pstd_flg = 'Y';
            RETURN totamt;
--}
END getTotCrDrPlaceHolderForPeriod;

-------------------------------------------------------------------------------
--Function for getting Total credit and debit for an account for a period
-------------------------------------------------------------------------------

FUNCTION getTotCrDrAccountsForPeriod(               inp_bank_id    IN varchar2,
                                                    inp_acrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                                    inp_fromdate IN Date,
                                                    inp_todate IN Date) RETURN NUMBER IS

totamt        tbaadm.DTD.TRAN_AMT%TYPE;
BEGIN
--{
            SELECT  nvl(sum(tran_amt),0)
            INTO    totamt
            FROM    tbaadm.GAM,tbaadm.RKT,tbaadm.DCTD_ACLI
            WHERE   GAM.bank_id = inp_bank_id
            AND     GAM.bank_id = DCTD_ACLI.bank_id
            and     GAM.bank_id = RKT.bank_id 
            AND     GAM.foracid   BETWEEN RKT.GPR_LOWER_CODE AND RKT.GPR_UPPER_CODE
            AND     GAM.acid = DCTD_ACLI.acid
            AND     RKT.GPR_RANGE_KEY = inp_acrangeAED
            AND     tran_date >= inp_fromdate
            AND     tran_date <= inp_todate
            AND     DCTD_ACLI.del_flg != 'Y'
            AND     DCTD_ACLI.pstd_flg = 'Y';
            RETURN totamt;
--}
END getTotCrDrAccountsForPeriod;
-------------------------------------------------------------------------------
--Function for getting Total credit for a glsubhead for a period
-------------------------------------------------------------------------------

FUNCTION getTotCrGlSubheadForPeriod(                inp_bank_id    IN varchar2,
                                                    inp_glsubrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                                    inp_fromdate IN Date,
                                                    inp_todate IN Date) RETURN NUMBER IS

totamt        tbaadm.DTD.TRAN_AMT%TYPE;
BEGIN
--{
            SELECT  nvl(sum(tran_amt),0)
            INTO    totamt
            FROM    tbaadm.GAM,tbaadm.DCTD_ACLI,tbaadm.RKT
            WHERE   GAM.bank_id = inp_bank_id
            AND     GAM.bank_id = DCTD_ACLI.bank_id
            and     GAM.bank_id = RKT.bank_id  
            AND     GAM.gl_sub_head_code   BETWEEN RKT.GPR_LOWER_CODE AND RKT.GPR_UPPER_CODE
            AND     GAM.acid = DCTD_ACLI.acid
            AND     RKT.GPR_RANGE_KEY = inp_glsubrangeAED
            AND     tran_date >= inp_fromdate
            AND     tran_date <= inp_todate
            AND     part_tran_type = 'C'
            AND     DCTD_ACLI.del_flg != 'Y'
            AND     DCTD_ACLI.pstd_flg = 'Y';
            RETURN totamt;
--}
END getTotCrGlSubheadForPeriod;

-------------------------------------------------------------------------------
--Function for getting Total credit for a placeholder for a period
-------------------------------------------------------------------------------

FUNCTION getTotCrPlaceHolderForPeriod(              inp_bank_id    IN varchar2,
                                                    inp_plrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                                    inp_fromdate IN Date,
                                                    inp_todate IN Date) RETURN NUMBER IS

totamt        tbaadm.DTD.TRAN_AMT%TYPE;
BEGIN
--{
            SELECT  nvl(sum(tran_amt),0)
            INTO    totamt
            FROM    tbaadm.GAM,tbaadm.RKT,tbaadm.DCTD_ACLI
            WHERE   GAM.bank_id = inp_bank_id
            AND     GAM.bank_id = DCTD_ACLI.bank_id
            and     GAM.bank_id = RKT.bank_id
            AND     GAM.bacid   BETWEEN RKT.GPR_LOWER_CODE AND RKT.GPR_UPPER_CODE
            AND     GAM.acid = DCTD_ACLI.acid
            AND     RKT.GPR_RANGE_KEY = inp_plrangeAED
            AND     tran_date >= inp_fromdate
            AND     tran_date <= inp_todate
            AND     part_tran_type = 'C'
            AND     DCTD_ACLI.del_flg != 'Y'
            AND     DCTD_ACLI.pstd_flg = 'Y';
            RETURN totamt;
--}
END getTotCrPlaceHolderForPeriod;

-------------------------------------------------------------------------------
--Function for getting Total credit for an account for a period
-------------------------------------------------------------------------------

FUNCTION getTotCrAccountsForPeriod(                 inp_bank_id    IN varchar2,
                                                    inp_acrangeAED IN tbaadm.RKT.GPR_RANGE_KEY%TYPE,
                                                    inp_fromdate IN Date,
                                                    inp_todate IN Date) RETURN NUMBER IS

totamt        tbaadm.DTD.TRAN_AMT%TYPE;
BEGIN
--{
            SELECT  nvl(sum(tran_amt),0)
            INTO    totamt
            FROM    tbaadm.GAM,tbaadm.RKT,tbaadm.DCTD_ACLI
            WHERE   GAM.bank_id = inp_bank_id
            AND     GAM.bank_id = DCTD_ACLI.bank_id
            and     GAM.bank_id = RKT.bank_id 
            AND     GAM.foracid   BETWEEN RKT.GPR_LOWER_CODE AND RKT.GPR_UPPER_CODE
            AND     GAM.acid = DCTD_ACLI.acid
            AND     RKT.GPR_RANGE_KEY = inp_acrangeAED
            AND     tran_date >= inp_fromdate
            AND     tran_date <= inp_todate
            AND     part_tran_type = 'C'
            AND     DCTD_ACLI.del_flg != 'Y'
            AND     DCTD_ACLI.pstd_flg = 'Y';
            RETURN totamt;
--}
END getTotCrAccountsForPeriod;

    -----------------------------------------------------------------------------------------------------------------
    --    Function                :    getDPDCounter
    --  Description             :    Getting the dpd counter as of the given date
    -----------------------------------------------------------------------------------------------------------------
    FUNCTION getDPDCounter(         inp_bank_id    varchar2,
                                    inp_acid    VARCHAR2,
                                    inp_date    DATE
                                )    RETURN        NUMBER    IS
    loc_dmdDate    DATE;
    loc_date    DATE;
    loc_dpd        NUMBER;
    BEGIN
    --{
        loc_date    :=    TO_DATE(inp_date,'dd-mm-yyyy');
        SELECT    MIN(DMD_EFF_DATE)
        INTO    loc_dmdDate
        FROM    tbaadm.LDT A,tbaadm.LAM LA
        WHERE    A.Bank_id = inp_bank_id
        AND      A.bank_id = LA.Bank_id
        AND        A.ACID          =    inp_acid
        AND        DMD_AMT            >    (
                                        SELECT    SUM(ADJ_AMT)
                                        FROM    tbaadm.LDA
                                        WHERE      LDA.BANK_ID = inp_bank_id
                                        AND        DMD_SRL_NUM        = A.DMD_SRL_NUM
                                        AND        LDA.ACID        = A.ACID
                                        AND        LDA.SHDL_NUM    = LA.REP_SHDL_NUM
                                        AND        ADJ_DATE        < loc_date
                                    )
        AND        A.ACID            =    LA.ACID
        AND        A.SHDL_NUM        =    LA.REP_SHDL_NUM
        AND        A.DMD_EFF_DATE    < loc_date;

        loc_dpd    := loc_date - loc_dmdDate;
        RETURN    loc_dpd;
    --}
    END getDPDCounter;


--------------------------------------------------------------
-- Function getAvgBal
-- Gets Average of EOD balance for given date range.
-----------------------------------------------------------------------
FUNCTION getAvgBal( inp_bank_id  varchar2,
                    acctAcid VARCHAR2,
                    fromDate DATE,
                    toDate DATE) RETURN NUMBER is

Total       tbaadm.EAB.tran_date_bal%type;
Average     tbaadm.EAB.tran_date_bal%type;
noOfDays    NUMBER;

CURSOR C1 IS
    SELECT  TRAN_DATE_BAL   BAL,
            EOD_DATE        EDate,
            END_EOD_DATE    EEDate
    FROM    tbaadm.EAB
    WHERE   BANK_ID = inp_bank_id
    AND    (EOD_DATE <= toDate
    AND     END_EOD_DATE >= fromDate)
    AND     EAB.ACID  = acctAcid
    order by eod_date;

BEGIN
--{
    Total       := 0;
    Average     := 0;
    noOfDays    := 0;

    FOR I IN C1
    LOOP
        IF ((i.EDate < fromDate) AND (i.EEDate > toDate)) THEN
            noOfDays := noOfDays + toDate - fromDate + 1;
        ELSE
            IF (i.EDate < fromDate) THEN
                noOfDays := noOfDays + i.EEDate - fromDate + 1;
            ELSIF (i.EEDate > toDate) THEN
                noOfDays := noOfDays + toDate - i.EDate + 1;
            ELSE
                noOfDays := noOfDays + i.EEDate - i.EDate + 1;
            END IF;
        END IF;

        Total := Total + i.Bal*(noOfDays);

    END LOOP;

    noOfDays := toDate - fromDate + 1;

        IF (noOfDays > 0) THEN
            Average := Total/noOfDays;
        ELSE
            Average := 0;
        END IF;
        

    RETURN (Average);
--}
END getAvgBal;


-- -----------------------------------------------------------------
-- Procedure to Calculate the Maximun,Minimum and Average Amount
-- For a given Date Range of any account.
-- -----------------------------------------------------------------

PROCEDURE getAcctAvgBal (inp_bank_id IN    varchar2,
                         in_acid     IN  tbaadm.EAB.acid          %TYPE,
                         in_fromDate IN  tbaadm.EAB.eod_date      %TYPE,
                         in_toDate   IN  tbaadm.EAB.eod_date      %TYPE,
                         in_balType  IN  CHAR,
                         out_maxAmt  OUT tbaadm.EAB.tran_date_bal %TYPE,
                         out_minAmt  OUT tbaadm.EAB.tran_date_bal %TYPE,
                         out_avgAmt  OUT tbaadm.EAB.tran_date_bal %TYPE) AS

-- -----------------------------------------------------------------------
-- Declare the Cursor to get the Account Balance, Start Date and End Date
-- -----------------------------------------------------------------------
    CURSOR GetAmount(ci_acid     tbaadm.EAB.acid      %TYPE,
                     ci_balType  CHAR,
                     ci_fromDate tbaadm.EAB.eod_date  %TYPE,
                     ci_toDate   tbaadm.EAB.eod_date  %TYPE) IS
        SELECT DECODE(ci_balType,
                      'T', tran_date_bal,
                      'V', value_date_bal, 0) AS eod_bal,
               eod_date,
               end_eod_date
        FROM   tbaadm.EAB
        WHERE  bank_id = inp_bank_id
        AND    eod_date     <= ci_toDate
        AND    end_eod_date >= ci_fromDate
        AND    acid          = ci_acid;

-- --------------------------------------------------------
-- Declare Local Variables
-- --------------------------------------------------------
    GetAmountVal      GetAmount         %ROWTYPE;

    lv_maxAmount      tbaadm.EAB.tran_date_bal   %TYPE;
    lv_minAmount      tbaadm.EAB.tran_date_bal   %TYPE;
    lv_totAmount      tbaadm.EAB.tran_date_bal   %TYPE;
    lv_avgAmount      tbaadm.EAB.tran_date_bal   %TYPE;

    lv_noOfDays       NUMBER(5);

BEGIN
--{
    -- -------------------------------------
    -- Initialize the Local Variables
    -- -------------------------------------
    lv_maxAmount := NULL;
    lv_minAmount := NULL;
    lv_totAmount := 0;
    lv_avgAmount := 0;
    lv_noOfDays  := 0;

    -- ------------------------------------------
    -- Fetch the Data from the Cursor
    -- ------------------------------------------
    FOR GetAmountVal IN GetAmount (in_acid,
                                   in_balType,
                                   in_fromDate,
                                   in_toDate)
    LOOP
    --{
        -- ---------------------------------
        -- Calculate the Maximum Balance
        -- ---------------------------------
        IF (lv_maxAmount < GetAmountVal.eod_bal) OR
           (lv_maxAmount IS NULL)                THEN
            lv_maxAmount := GetAmountVal.eod_bal;
        END IF;

        -- ---------------------------------
        -- Calculate the Minimum Balance
        -- ---------------------------------
        IF (lv_minAmount > GetAmountVal.eod_bal) OR
           (lv_minAmount IS NULL)                THEN
            lv_minAmount := GetAmountVal.eod_bal;
        END IF;

        -- -----------------------------------------------------
        -- Calculate the Total Balance for the Given Date Range
        -- -----------------------------------------------------
        lv_noOfDays := LEAST   (GetAmountVal.end_eod_date,  in_toDate)   -
                       GREATEST(GetAmountVal.eod_date,      in_fromDate) + 1;

        lv_totAmount := lv_totAmount + (GetAmountVal.eod_bal * lv_noOfDays);
    --}
    END LOOP;

    -- ------------------------------------------------------
    -- Calculate the Average Balance for the Account
    -- ------------------------------------------------------
    lv_noOfDays  := in_toDate - in_fromDate + 1;

    lv_avgAmount := lv_totAmount / lv_noOfDays;

    -- ------------------------------------------------------
    -- Send calculated data to output
    -- ------------------------------------------------------
    out_maxAmt := lv_maxAmount;
    out_minAmt := lv_minAmount;
    out_avgAmt := lv_avgAmount;
--}
END getAcctAvgBal;


PROCEDURE getNextPrevWorkDay( inp_bank_id IN  varchar2,
                              inpEntityId        IN    VARCHAR2,                         
                                inpEntityType    IN    VARCHAR2,                                              
                                inpDate            IN    DATE,                                                      
                                nextOrPrevFlg    IN VARCHAR2,                                              
                                nextPrevWorkingDate    OUT DATE) AS                                        
curMnthHldyStr            tbaadm.HOL.HLDY_STR%TYPE;                                             
prevDaysStatus            VARCHAR2(1);                                                   
getDayDate                NUMBER;                                                           
dayComp                    VARCHAR2(2);                                                        
getCurMnth                VARCHAR2(2);                                                      

getCurYear                VARCHAR2(4);                                                      
charDate                VARCHAR2(10);                                                       
solOutputDate            DATE;                                                           
getTodaysDate            date;                                                           
monthYear                VARCHAR2(6);                                                       
prevDayDate                NUMBER;                                                          
prevMnth                VARCHAR2(2);                                                        
prvYear                    VARCHAR2(4);                                                        
                                                                                
BEGIN                                                                           
-- {                                                                            

    ------------------------------------------------------------------------------ 
    -- Getting one day previous date ,month and year from the date passed as input 
    ------------------------------------------------------------------------------ 
    IF (nextOrPrevFlg = 'P') THEN                                                  
        getTodaysDate    :=    inpDate - 1;                                                 
    ELSE                                                                           
        getTodaysDate    :=    inpDate + 1;                                                 
    END IF;                                                                        
                                                                                
    getDayDate        :=    TO_NUMBER(SUBSTR(to_char(getTodaysDate, 'DD-MM-YYYY'),1,2));    
    getCurMnth        :=    SUBSTR(to_char(getTodaysDate,'DD-MM-YYYY'),4,2);                

    getCurYear        :=    SUBSTR(to_char(getTodaysDate,'DD-MM-YYYY'),7,4);                
    monthYear        :=    getCurMnth||getCurYear;                                          
                                                                                
    prevDayDate    := getDayDate;                                                     
    prevMnth    := getCurMnth;                                                        
    prvYear    := getCuryear;                                                         
                                                                                
    BEGIN                                                                          
        SELECT                                                                        
            HLDY_STR                                                                     
        INTO                                                                          

            curMnthHldyStr                                                               
        FROM                                                                          
            tbaadm. HOL                                                                          
        WHERE   bank_id = inp_bank_id and                                                                      
            CAL_B2K_ID         =    inpEntityId             AND                                            
            CAL_B2K_TYPE     =     inpEntityType              AND                                       
            MMYYYY             =    monthYear;                                                       
                                                                                
        EXCEPTION                                                                     
            WHEN NO_DATA_FOUND THEN                                                      
                curMnthHldyStr := '';                                                       

    END;                                                                           
                                                                                
    prevDaysStatus:= SUBSTR(curMnthHldyStr,getDayDate,1);                          
                                                                                
    -----------------------------------------------------------------------------  
    -- While previous days status doesn't becomes null go on subtracting one day   
    -- getting that days status                                                    
    -----------------------------------------------------------------------------  
                                                                                
    WHILE (prevDaysStatus != ' ')                                                  
    LOOP                                                                           

    --{                                                                            
        IF (nextOrPrevFlg = 'P') THEN                                                 
            getTodaysDate    :=    getTodaysDate - 1;                                          
        ELSE                                                                          
            getTodaysDate    :=    getTodaysDate + 1;                                          
        END IF;                                                                       
                                                                                
        getDayDate        :=    TO_NUMBER(SUBSTR(to_char(getTodaysDate, 'DD-MM-YYYY'),1,2));   
        getCurMnth        :=    SUBSTR(to_char(getTodaysDate,'DD-MM-YYYY'),4,2);               
        getCurYear        :=    SUBSTR(to_char(getTodaysDate,'DD-MM-YYYY'),7,4);               
        monthYear        :=    getCurMnth||getCurYear;                                         

                                                                                
        IF (getCurMnth != prevMnth) THEN                                              
        --{                                                                           
            BEGIN                                                                        
                SELECT                                                                      
                    HLDY_STR                                                                   
                INTO                                                                        
                    curMnthHldyStr                                                             
                FROM                                                                        
                    tbaadm. HOL                                                                        
                WHERE                                                                       
                                        bank_id = inp_bank_id and
                    CAL_B2K_ID     =inpEntityId     AND                                          
                    CAL_B2K_TYPE     =inpEntityType          AND 
                    MMYYYY         =monthYear;                                                     
                EXCEPTION                                                                   
                    WHEN NO_DATA_FOUND THEN                                                    
                        curMnthHldyStr := '';                                                     
            END;                                                                         
        --}                                                                           
        END IF;                                                                       
                                                                                
        prevDaysStatus    :=    SUBSTR(curMnthHldyStr,getDayDate,1);                        

        prevDayDate    := getDayDate;                                                    
        prevMnth    := getCurMnth;                                                       
        prvYear    := getCuryear;                                                        
    --}                                                                            
    END LOOP;                                                                      
                                                                                
    ------------------------------------------------------------------             
    -- Getting output previous working date in DD-MM-YYYY Format                   
    ------------------------------------------------------------------             
    IF (getDayDate < 10)                                                           
    THEN                                                                           

        dayComp    :=    '0'||TO_CHAR(getDayDate);                                          
    ELSE                                                                           
        dayComp    :=    to_char(getDayDate);                                               
    END IF;                                                                        
                                                                                
    solOutputDate    :=    TO_DATE((dayComp||'-'||getCurMnth||'-'||getCurYear),'DD-MM-YYYY');                                                                            
                                                                                
    nextPrevWorkingDate    :=    solOutputDate;                                          
--}                                                                             
END getNextPrevWorkDay;
   
--Function to get Previous working date

FUNCTION get_last_working_date (inp_bank_id IN  varchar2,p_from_date IN DATE := SYSDATE)
        RETURN DATE
As
d_return_date   DATE;
BEGIN
        SELECT calendar
                INTO d_return_date
        FROM (SELECT TRUNC (p_from_date) - ROWNUM calendar
                 FROM DUAL
           CONNECT BY ROWNUM < 11)
        WHERE TRIM (TO_CHAR (calendar, 'D')) NOT IN (1, 7) AND ROWNUM = 1;
        -- DAY 1 is SUNDAY and DAY 7 is SATURDAY
        RETURN d_return_date;
END get_last_working_date;


---------------------------------------------------------------------------
--Function for Getting the Previous BOD Date
--Returns the Previous BOD Date
---------------------------------------------------------------------------
FUNCTION getpreviousboddate (inp_bank_id  varchar2, cal_type VARCHAR2,cal_id VARCHAR2,
         p_date DATE) RETURN VARCHAR2
IS
   v_dd              VARCHAR2 (2);
   v_mm              VARCHAR2 (2);
   v_yyyy            VARCHAR2 (4);
   v_dd_conv         VARCHAR2 (10) := 0;
   v_mmyyyy          VARCHAR2 (6);
   v_dd_num          NUMBER;
   tmp_name          VARCHAR2 (31);
   tmp_hldy          VARCHAR2 (5);
   iflag             NUMBER        := 0;
   icount            NUMBER        := 0;
   v_pre_date        VARCHAR2 (10);
   v_prev_date       DATE;
   last_date         DATE;
   last_date_num     NUMBER        := 0;
   curr_date         DATE;
   curr_dt_num       NUMBER        := 0;
   e_hldy_str_null   EXCEPTION;
   firstitetration   BOOLEAN       := FALSE;
BEGIN
   v_dd := TO_CHAR (p_date, 'DD');
   v_mm := TO_CHAR (p_date, 'MM');
   v_yyyy := TO_CHAR (p_date, 'YYYY');
   v_mmyyyy := TO_CHAR (p_date, 'MMYYYY');
 
   SELECT p_date
     INTO curr_date
     FROM DUAL;
 
 --  DBMS_OUTPUT.put_line (curr_date);
   curr_dt_num := TO_CHAR (curr_date, 'DD');
  -- DBMS_OUTPUT.put_line (curr_dt_num);
 
   LOOP
      SELECT RPAD (NVL (hldy_str, 'N'), 31, 'N')
        INTO tmp_name
        FROM hol
       WHERE bank_id = inp_bank_id
         and cal_b2k_id = cal_id
         AND mmyyyy = v_mmyyyy
         AND cal_b2k_type = cal_type;
 
      FOR i IN REVERSE 1 .. curr_dt_num
      LOOP
         IF (firstitetration = TRUE)
         THEN
            firstitetration := FALSE;
            icount := i;
         ELSE
            icount := i - 1;
         END IF;
 
         tmp_hldy := SUBSTR (tmp_name, icount, 1);
--         DBMS_OUTPUT.put_line (tmp_hldy);
 
         -- INCASE IF THE PASSED DATE IS THE FIRST OF THE MONTH, THEN DIRECTLY CHECK PREV MONTH
         IF icount = 0 AND curr_dt_num = 1
         THEN
            tmp_hldy := 'S';
         END IF;
 
         IF (   (tmp_hldy <> 'Y' AND tmp_hldy <> 'C' AND tmp_hldy <> 'S')
             OR tmp_hldy IS NULL
            )
         THEN
            v_dd_conv := icount;
            iflag := 1;
            EXIT;
         ELSE
            v_dd := v_dd - 1;
            v_dd_conv := v_dd;
         END IF;
 
         --DBMS_OUTPUT.put_line (v_dd_conv);
      END LOOP;
 
      IF (iflag = 0 AND v_mm <= 10 AND v_mm > 1)
      THEN
         v_mm := v_mm - 1;
 
         SELECT '0' || v_mm || v_yyyy
           INTO v_mmyyyy
           FROM DUAL;
      ELSIF (iflag = 0 AND v_mm <= 12 AND v_mm > 1)
      THEN
         v_mm := v_mm - 1;
 
         SELECT v_mm || v_yyyy
           INTO v_mmyyyy
           FROM DUAL;
      ELSIF (iflag = 0 AND v_mm = 1)
      THEN
         v_mm := '12';
         v_yyyy := v_yyyy - 1;
 
         SELECT v_mm || v_yyyy
           INTO v_mmyyyy
           FROM DUAL;
      END IF;
 
      IF (iflag = 0)
      THEN
         v_dd := '31';
         v_dd_num := '31';
 
         SELECT SUBSTR (TO_CHAR (LAST_DAY (TO_DATE (   '01-'
                                                    || v_mm
                                                    || '-'
                                                    || v_yyyy
                                                   ,
                                           'DD-MM-YYYY'
                                          )),
                                 'DD-MM-YYYY'
                                ),
                        1,
                        2
                       )
           INTO curr_dt_num
           FROM DUAL;
 
         firstitetration := TRUE;
      END IF;
 
      EXIT WHEN (iflag <> 0);
   END LOOP;
 
   IF (v_dd_conv < 10)
   THEN
      SELECT '0' || v_dd_conv || v_mmyyyy
        INTO v_pre_date
        FROM DUAL;
   ELSE
      SELECT v_dd_conv || v_mmyyyy
        INTO v_pre_date
        FROM DUAL;
   END IF;
 
   v_prev_date := TO_DATE (v_pre_date, 'DD-MM-YYYY');
   RETURN v_prev_date;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN 'Calendar not maitained for this/prev month';
   WHEN OTHERS
   THEN
      RETURN SQLCODE;
 
END getpreviousboddate;

-----------------------------------------------------------------------
-- FUNCTION GetAvailBalForAcct
-- Gets the Effective Balance for an account
-----------------------------------------------------------------------
FUNCTION GetAvailBalForAcct(inp_bank_id IN  varchar2,
                            inp_acid    IN      VARCHAR2,
                            inp_date    IN      DATE)
                            RETURN NUMBER AS

--=========================
-- Local variable Section.
--=========================
lv_inp_acid            gam.acid%type;
lv_schm_type                   gam.schm_type%type;
lv_lam_crncy_code              lam.lam_crncy_code%type;
lv_single_tran_flg             gam.single_tran_flg%type;
lv_crncy_code                  gam.crncy_code%type;    -- crncy_code is different from acct_crncy_code in GAM.
lv_fx_clr_bal_amt              gam.fx_clr_bal_amt%type                := 0;
lv_dis_amt                        lam.dis_amt%type                    := 0;
lv_sanct_lim                      gam.sanct_lim%type            := 0;
lv_adhoc_lim                      gam.adhoc_lim%type                     := 0;
lv_emer_advn                      gam.emer_advn%type                     := 0;
lv_single_tran_lim             gam.single_tran_lim%type               := 0;
lv_used_single_tran_lim        gam.used_single_tran_lim%type          := 0;
lv_clean_adhoc_lim             gam.clean_adhoc_lim%type            := 0;
lv_clean_emer_advn             gam.clean_emer_advn%type            := 0;
lv_clean_single_tran_lim       gam.clean_single_tran_lim%type      := 0;
lv_used_occlnsingletran_lim    gam.used_oc_cln_single_tran_lim%type    := 0;
lv_used_clean_single_tran_lim  gam.used_clean_single_tran_lim%type     := 0;
lv_drwng_power                 gam.drwng_power%type                 := 0;
lv_eff_drawing_power           gam.drwng_power%type                    := 0;
lv_system_gen_lim                 gam.system_gen_lim%type                 := 0;
lv_clr_bal_amt                 gam.clr_bal_amt%type                    := 0;
lv_dacc_lim                       gam.dacc_lim%type                    := 0;
lv_lien_amt                    gam.lien_amt%type                       := 0;
lv_system_reserved_amt         gam.system_reserved_amt%type            := 0;
lv_tot_secd_lim                gam.drwng_power%type                    := 0;
lv_tot_clean_lim               gam.drwng_power%type                    := 0;
lv_eff_avail_bal               gam.drwng_power%type                    := 0;
lv_crAgnstSingleTranUtilAmt    gam.drwng_power%type                    := 0;
lv_utilised_amt                gam.drwng_power%type                    := 0;
lv_acct_limit                  gam.drwng_power%type                    := 0;
lv_inpAsOnDate                 date;
--=========================
-- Start of Function.
--=========================
BEGIN
--{
        lv_inp_acid     := TRIM(inp_acid);
        lv_inpAsOnDate  := inp_date;
    --=============================================
    -- Fetch details for input acid from GAM.
    --=============================================
    BEGIN
    --{
        SELECT    schm_type,
                fx_clr_bal_amt,
                single_tran_flg,
                utilised_amt,
               -- sanct_lim,
                adhoc_lim,
                emer_advn,
                single_tran_lim,
 used_single_tran_lim,
                clean_adhoc_lim,
                clean_emer_advn,
                clean_single_tran_lim,
                used_oc_cln_single_tran_lim,
                used_clean_single_tran_lim,
                system_gen_lim,
                clr_bal_amt,
                dacc_lim,
                lien_amt,
                system_reserved_amt,
                drwng_power
        INTO
                lv_schm_type,
                lv_fx_clr_bal_amt,
                lv_single_tran_flg,
                lv_utilised_amt,
              --  lv_sanct_lim,
                lv_adhoc_lim,
                lv_emer_advn,
                lv_single_tran_lim,
                lv_used_single_tran_lim,
                lv_clean_adhoc_lim,
                lv_clean_emer_advn,
                lv_clean_single_tran_lim,
                lv_used_occlnsingletran_lim,
                lv_used_clean_single_tran_lim,
                lv_system_gen_lim,
                lv_clr_bal_amt,
                lv_dacc_lim,
                lv_lien_amt,
                lv_system_reserved_amt,
                lv_drwng_power
        FROM GAM
        WHERE     bank_id = inp_bank_id
        AND       acid             = lv_inp_acid
        AND       entity_cre_flg     = 'Y'
        AND       del_flg            != 'Y';

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
 lv_eff_avail_bal := 0;
                GOTO  End_Func;
        WHEN OTHERS THEN
                lv_eff_avail_bal := 0;
                GOTO  End_Func;
    --}
    END;

    -- For getting sanction Limit
    getAcctSanctionLimit(inp_bank_id,lv_inpAsOnDate,lv_inp_acid,lv_sanct_lim);

    lv_tot_secd_lim    := lv_sanct_lim + lv_adhoc_lim + lv_emer_advn + lv_single_tran_lim + lv_used_single_tran_lim;
    lv_tot_clean_lim    := lv_clean_adhoc_lim + lv_clean_emer_advn + lv_clean_single_tran_lim
                            + lv_used_occlnsingletran_lim + lv_used_clean_single_tran_lim;

    IF(lv_tot_secd_lim > lv_drwng_power) THEN
    --{
        lv_eff_drawing_power := lv_drwng_power;
    --}
    ELSE
    --{
        lv_eff_drawing_power := lv_tot_secd_lim;
    --}
    END IF;

    IF(lv_schm_type != 'LAA' AND lv_schm_type != 'CLA') THEN
    --{
        --    Other than LA Accounts  ---

        --===============================================================
        -- Available amount in account = Min. of Total Secured Lim and
        -- Drawing Power + Total Clean Limit + Clear Account Balance
        -- + Shadow Balance - Reserved amounts */
        --===============================================================

        lv_eff_avail_bal     :=lv_eff_drawing_power     +
                                lv_tot_clean_lim        +
                                lv_system_gen_lim        +
                                lv_clr_bal_amt            +
                                lv_dacc_lim            -
lv_lien_amt            -
                                lv_system_reserved_amt;

        --===============================================================
        -- If the GAM_crncy_code is not null instead of clr_bal_amt
        -- (home crncy) the fx_clr_bal_amt is to be added and shadow_balance
        -- i.e. (dacc_lim in GAM) is not to considered.
        --===============================================================

        IF(lv_crncy_code IS NOT NULL) THEN
        --{
            lv_eff_avail_bal    := lv_eff_avail_bal     -
                                    lv_clr_bal_amt        +
                                    lv_fx_clr_bal_amt    -
                                    lv_dacc_lim;
        --}
        END IF;
    --}
    ELSE
    --{
        -- LA Accounts ---
        BEGIN
        --{
            SELECT     dis_amt,
                    lam_crncy_code
            INTO    lv_dis_amt,
                    lv_lam_crncy_code
            FROM     LAM
            WHERE    bank_id = inp_bank_id  and  acid = lv_inp_acid;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lv_dis_amt := 0;
                GOTO End_Func;

            WHEN OTHERS THEN
                lv_dis_amt := 0;
                GOTO End_Func;
        --}
        END;
--===============================================================
        -- Here check for FCNR not required, since tmpDisAmt is in FCNR
        -- currency. Also all the other amounts are in the FCNR currency.
        --===============================================================

        lv_eff_avail_bal     :=     lv_eff_drawing_power     +
                                lv_tot_clean_lim        +
                                lv_system_gen_lim        -
                                lv_dis_amt                +
                                lv_dacc_lim            -
                                lv_lien_amt            -
                                lv_system_reserved_amt;
    --}
    END IF;


    --===============================================================
    -- For Packing Credits single_tran_flg in GAM represents
    -- whether money is to be given as single transaction.
    -- utilised_amt in GAM : Amount of Sanction Limit Utilised for
    -- Accounts with Single Tran Flag as 'Y' (Packing Credits).
    --===============================================================

    IF((lv_schm_type != 'LAA' AND lv_schm_type != 'CLA') AND (lv_single_tran_flg = 'Y')) THEN
    --{
        IF(lv_sanct_lim > lv_drwng_power) THEN
        --{
            lv_acct_limit    :=    lv_drwng_power;
        --}
        ELSE
        --{
            lv_acct_limit  :=  lv_sanct_lim;
        --}
        END IF;

        IF(lv_crncy_code IS NULL) THEN
        --{
            --===============================================================
-- Compute the full available amount for single tran home crncy
            -- account.
            --===============================================================

            IF(lv_clr_bal_amt < 0) THEN
            --{
                --========================================================================
                -- Adding clr_bal_amt since it is negative. lv_crAgnstSingleTranUtilAmt
                -- indicates the credit that has come in to square off the debits against
                -- the limit.
                --========================================================================

                lv_crAgnstSingleTranUtilAmt     := lv_utilised_amt + lv_clr_bal_amt;

                IF(lv_crAgnstSingleTranUtilAmt > 0) THEN
                --{
                    lv_eff_avail_bal     := lv_eff_avail_bal - lv_crAgnstSingleTranUtilAmt;
                --}
                END IF;
            --}
            ELSE
            --{
                --===============================================================
                -- Reduce the utilised portion of the account limit from the
                -- available amount.
                --===============================================================

                lv_eff_avail_bal   := lv_eff_avail_bal - lv_utilised_amt;
            --}
            END IF;
        --}
        ELSE
        --{
            --===============================================================
            -- Compute the full available amount for single tran FCNR account.
            --===============================================================

            IF(lv_fx_clr_bal_amt < 0) THEN
            --{
                --========================================================================
 -- Adding fx_clr_bal_amt since it is negative.lv_crAgnstSingleTranUtilAmt
                -- indicates the credit that has come in to square off the debits against
                --   the limit.
                --========================================================================

                lv_crAgnstSingleTranUtilAmt    := lv_utilised_amt + lv_fx_clr_bal_amt;

                IF(lv_crAgnstSingleTranUtilAmt >= 0) THEN
                --{
                    lv_eff_avail_bal     := lv_eff_avail_bal - lv_crAgnstSingleTranUtilAmt;
                --}
                END IF;
            --}
            ELSE
            --{
                --===============================================================
                -- Reduce the utilised portion of the account limit from the
                -- available amount.
                --===============================================================
                lv_eff_avail_bal   := lv_eff_avail_bal - lv_utilised_amt;
            --}
            END IF;
        --}
        END IF;
    --}
    END IF;

<<End_Func>>

    RETURN (nvl(lv_eff_avail_bal,0));


EXCEPTION
    WHEN VALUE_ERROR THEN
    lv_eff_avail_bal := 0;
    RETURN (nvl(lv_eff_avail_bal,0));
--}
END GetAvailBalForAcct;


--------------------------------------------------------------------------------
-- Function : getBranchNameBySolId(lv_sol_id  varchar2,lv_bank_id in varchar2)
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getBranchNameBySolId(lv_sol_id  varchar2,lv_bank_id in varchar2) RETURN varchar2 is
out_branch_name  varchar2(50);
--cur_br_code        varchar2(6);
BEGIN
--{
    Begin
        Select  tbaadm.bct.BR_NAME
        Into out_branch_name
        From tbaadm.sol,tbaadm.bct
        Where tbaadm.sol.BR_CODE = tbaadm.bct.BR_CODE
        And tbaadm.sol.BANK_CODE=tbaadm.bct.BANK_CODE
        And tbaadm.sol.SOL_ID = lv_sol_id
        And tbaadm.sol.BANK_ID =lv_bank_id
      And  tbaadm.bct.BANK_ID = tbaadm.sol.BANK_ID ;
    EXCEPTION WHEN
    no_data_found THEN
    out_branch_name:='';
    END;

    RETURN out_branch_name;
--}
END getBranchNameBySolId;


-----------------------------------------------------------------------------------------------------------
--- Function : getEMI()
--- Desc     : Returns the Installment Amount for the given Acid
-----------------------------------------------------------------------------------------------------------

    FUNCTION    getEMI(lv_acid   tbaadm.GAM.acid%type,lv_asondate DATE,bankId varchar2)
                                RETURN  NUMBER    AS

    lv_emiamt    NUMBER;


    BEGIN
    --{

        BEGIN
        --{

                SELECT flow_amt into lv_emiamt
                  FROM (SELECT flow_amt, shdl_num
                          FROM  tbaadm.lrs
                         WHERE acid = lv_acid
                           AND flow_start_date =
                                  (SELECT MAX (flow_start_date)
                                     FROM  tbaadm.lrs
                                    WHERE acid = lv_acid
                                      AND flow_start_date <= lv_asondate
                                      --AND lr_freq_type = 'M'
                                      AND del_flg = 'N'
                                      AND entity_cre_flg = 'Y')
                           --AND lr_freq_type = 'M'
                           AND del_flg = 'N'
                           AND bank_id = bankId
                           AND entity_cre_flg = 'Y'
                           AND flow_id in ('EIDEM','PRDEM')
                        UNION
                        SELECT flow_amt, shdl_num
                          FROM  tbaadm.lrsh
                         WHERE acid = lv_acid
                           AND flow_start_date =
                                  (SELECT MAX (flow_start_date)
                                     FROM  tbaadm.lrsh
                                    WHERE acid = lv_acid
                                      AND flow_start_date <= lv_asondate
                                      --AND lr_freq_type = 'M'
                                      AND del_flg = 'N'
                                      AND entity_cre_flg = 'Y')
                           --AND lr_freq_type = 'M'
                           AND del_flg = 'N'
                           AND bank_id = bankId
                           AND flow_id in ('EIDEM','PRDEM')
                           AND entity_cre_flg = 'Y')
                 WHERE shdl_num =
                          (SELECT MAX (shdl_num)
                             FROM (SELECT flow_amt, shdl_num
                                     FROM  tbaadm.lrs
                                    WHERE acid = lv_acid
                                      AND flow_start_date =
                                             (SELECT MAX (flow_start_date)
                                                FROM  tbaadm.lrs
                                               WHERE acid = lv_acid
                                                 AND flow_start_date <= lv_asondate
                                                 --AND lr_freq_type = 'M'
                                                 AND del_flg = 'N'
                                                 AND entity_cre_flg = 'Y')
                                      --AND lr_freq_type = 'M'
                                      AND del_flg = 'N'
                                         AND bank_id = bankId
                                      AND entity_cre_flg = 'Y'
                                      AND flow_id in ('EIDEM','PRDEM')
                                   UNION
                                   SELECT flow_amt, shdl_num
                                     FROM  tbaadm.lrsh
                                    WHERE acid = lv_acid
                                      AND flow_start_date =
                                             (SELECT MAX (flow_start_date)
                                                FROM  tbaadm.lrsh
                                               WHERE acid = lv_acid
                                                 AND flow_start_date <= lv_asondate
                                                 --AND lr_freq_type = 'M'
                                                 AND del_flg = 'N'
                                                 AND entity_cre_flg = 'Y')
                                      --AND lr_freq_type = 'M'
                                      AND del_flg = 'N'
                                         AND bank_id = bankId
                                      AND flow_id in ('EIDEM','PRDEM')
                                      AND entity_cre_flg = 'Y'));

        EXCEPTION   WHEN NO_DATA_FOUND THEN

            lv_emiamt   := 0;
        --}
        END;

        RETURN  lv_emiamt;

    --}
    END getEMI;


--------------------------------------------------------------------------------
-- Function : getIntRateForLa()
-- Desc     : Returns the interest rate of a loan account
--------------------------------------------------------------------------------
FUNCTION getIntRateForLa(lv_acid VARCHAR2,asondate date,bankId varchar2) RETURN NUMBER AS
    begin_amt   tbaadm.lavs.begin_slab_amount%type;
    end_amt     tbaadm.lavs.end_slab_amount%type;
    rate        tbaadm.lavs.nrml_int_pcnt%type :=0;
    bal         tbaadm.gam.sanct_lim%type;
    intcode     tbaadm.icv.int_tbl_code%type;
    pegged      tbaadm.itc.pegged_flg%type;
    intversion  tbaadm.itc.int_version%type;
    inttblvernum    tbaadm.itc.int_tbl_ver_num%type;
    lv_clrbal     tbaadm.gam.clr_bal_amt%type;
    lv_startdate  DATE;
    srno        tbaadm.itc.INT_TBL_CODE_SRL_NUM%type;
    loan_mths   number:=0;
    acct_mths   number:=0;
    BODDate     date;
    lv_maxsrl      tbaadm.itc.int_tbl_ver_num%type;
    lv_crncy     tbaadm.gam.acct_Crncy_code%type;

    type loan is ref cursor;
    loan_int loan;


BEGIN
--{
    BEGIN

        select max(INT_TBL_CODE_SRL_NUM) into lv_maxsrl
                                    from  tbaadm.itc
                                    where entity_id= lv_acid
                                    and bank_id = bankId
                                    and asondate between start_date and end_date
                                    and del_flg!='Y'
                                    and entity_cre_flg='Y';

       select int_tbl_code,pegged_flg,int_version,int_tbl_ver_num into intcode,pegged,intversion,inttblvernum
       from  tbaadm.itc
       where entity_id= lv_acid
       and del_flg != 'Y'
       and bank_id = bankId
       and asondate between start_date and end_date
       and entity_cre_flg='Y'
       and tbaadm.itc.INT_TBL_CODE_SRL_NUM = lv_maxsrl ;


        SELECT REP_SHDL_DATE
                        into lv_startdate
                        from  tbaadm.lam
                        where acid = lv_acid and bank_id = bankId;

        --SELECT ABS(commonPackage.eabbal(acid,asondate,bank_id)),acct_crncy_code
		SELECT ABS(commonPackage.eabbal(bank_id,acid,asondate)),acct_crncy_code
                        INTO lv_clrbal,lv_crncy
                        FROM  tbaadm.gam
                       WHERE acid = lv_acid and bank_id = bankId;

    IF(NVL(pegged,'N') != 'Y') THEN
    --{

        select max(icv.int_tbl_ver_num ) into inttblvernum
        from  tbaadm.icv
        where tbaadm.icv.int_tbl_code=intcode
        and tbaadm.icv.bank_id = bankId
        and tbaadm.icv.entity_Cre_flg = 'Y'
        and tbaadm.icv.del_flg = 'N'
        and tbaadm.icv.start_Date <= asondate
        and tbaadm.icv.end_date >= asondate
        and tbaadm.icv.crncy_code = lv_crncy;

            select max(tbaadm.lavs.INT_TBL_VER_NUM) into intversion
                                 from    tbaadm.icv, tbaadm.lavs
                                 where  tbaadm.icv.int_tbl_code=tbaadm.lavs.int_tbl_code
                                 and    tbaadm.icv.int_version=tbaadm.lavs.Int_tbl_ver_num
                                 and    tbaadm.icv.int_tbl_ver_num=inttblvernum
                                 and    tbaadm.icv.del_flg!='Y' and tbaadm.icv.entity_cre_flg='Y'
                                 and    tbaadm.lavs.del_flg!='Y' and tbaadm.lavs.entity_cre_flg='Y'
                                 and    tbaadm.lavs.bank_id = bankId
                                 and    tbaadm.icv.bank_id = bankId
                                 and    tbaadm.icv.int_tbl_code=intcode
                  and    tbaadm.icv.crncy_code = lv_crncy
                 and    tbaadm.lavs.crncy_code = lv_crncy;

    --}
    END IF;

    SELECT   NVL((SELECT base_pcnt_dr
                            FROM  tbaadm.icv
                           WHERE int_tbl_code    = intcode
                             AND int_tbl_ver_num = inttblvernum
                 AND crncy_code = lv_crncy
                 AND bank_id = BankId ),0)
                       + NVL(id_dr_pref_pcnt,0)
                       + NVL((SELECT nrml_int_pcnt
                            FROM  tbaadm.lavs
                           WHERE int_tbl_code = intcode
                             AND int_tbl_ver_num = intversion
                 AND crncy_code = lv_crncy
                             AND bank_id = BankId
                             AND lv_clrbal BETWEEN tbaadm.lavs.begin_slab_amount
                                                 AND tbaadm.lavs.end_slab_amount
                             AND  MONTHS_BETWEEN (asondate, lv_startdate) <= loan_tenor_mths
                             AND loan_tenor_mths =
                                    (SELECT MIN (loan_tenor_mths)
                                       FROM  tbaadm.lavs
                                      WHERE int_tbl_code = intcode
                                            AND int_tbl_ver_num = intversion
                        AND crncy_code = lv_crncy
                        AND bank_id = BankId
                                            AND lv_clrbal  BETWEEN tbaadm.lavs.begin_slab_amount
                                                            AND tbaadm.lavs.end_slab_amount
                                        AND MONTHS_BETWEEN (asondate, lv_startdate) <= loan_tenor_mths)),0)
                  INTO rate
                  FROM  tbaadm.itc
                 WHERE entity_id = lv_acid
           AND bank_id = BankId
                   AND NVL (entity_cre_flg, 'Y') = 'Y'
                   AND NVL (del_flg, 'N') = 'N'
                   AND int_tbl_code_srl_num = lv_maxsrl ;
    EXCEPTION
        WHEN OTHERS THEN
            rate:=0;
    END;

RETURN NVL(rate,0);

--}
END GetIntRateForLa;


-----------------------------------------------------------------------
-- FUNCTION getLoanTenor
-- Gets the tenor for the loan account (acid)
-----------------------------------------------------------------------
FUNCTION getLoanTenor(inp_acid IN VARCHAR2,bankId varchar2) RETURN VARCHAR2 AS
    out_mths VARCHAR2(10) := 'NULL';
    cur_mths number;
    out_days VARCHAR2(10) := 'NULL';
    cur_days number;
    out_tenor VARCHAR2(10) := 'NULL';
BEGIN
--{
    BEGIN
        SELECT    REP_PERD_MTHS, REP_PERD_DAYS
        INTO    cur_mths,cur_days
        FROM     tbaadm.LAM
        WHERE   acid =inp_acid
        AND     bank_id = bankId;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            cur_mths := 0;
            cur_days := 0;
        WHEN OTHERS THEN
            cur_mths:= 0;
            cur_days:= 0;
    END;
    IF (cur_mths = 0) THEN
    --{
        out_mths:=' ';
    --}
    ELSE
    --{
        out_mths:= to_char(cur_mths);
    --}
    END IF;
    IF (cur_days = 0) THEN
    --{
        out_days:=' ';
    --}
    ELSE
    --{
        out_days:= to_char(cur_days);
    --}
    END IF;
    out_tenor:=out_mths||'/'||out_days;

    RETURN out_tenor;
--}
END getLoanTenor;


---------------------------------------------------------------------------
--- getOutStanding(lv_acid,lv_asondate,lv_type)
--- To get the O/S as of today
--------------------------------------------------------------------------


FUNCTION    getOutStanding(lv_acid   tbaadm.GAM.acid%type,lv_asondate date,lv_type varchar2,bankId varchar2)
                                    RETURN  NUMBER    IS

    lv_amount     NUMBER;
    lv_amount1     NUMBER;
    lv_amount2     NUMBER;

   BEGIN
   --{
        BEGIN
        --{
            IF(lv_type = 'PRN' )THEN
            --{
                BEGIN
                    select clr_bal_amt + (decode(int_route_flg,'L',INT_DMD_OS,0)+decode(chrg_route_flg,'L',BCHG_DMD_OS+OCHG_DMD_OS,0))
                    into lv_amount
                    from  tbaadm.gam, tbaadm.lam where tbaadm.gam.acid = lv_acid and tbaadm.gam.acid = tbaadm.lam.acid and tbaadm.gam.bank_id = bankId
                    and tbaadm.lam.bank_id = bankId ;
                EXCEPTION
                    WHEN OTHERS THEN
                        lv_amount := 0 ;
                END;
            --}
            END IF;


            IF(lv_type = 'INT' )THEN
            --{
                BEGIN
                    select int_dmd_os into lv_amount
                    from  tbaadm.lam
                    where tbaadm.lam.acid = lv_acid
                    and tbaadm.lam.bank_id = bankId ;
                EXCEPTION
                    WHEN OTHERS THEN
                        lv_amount := 0 ;
                END;
            --}
            END IF;

            IF(lv_type = 'CHG' )THEN
            --{
                BEGIN
                    select bchg_dmd_os + ochg_dmd_os into lv_amount
                    from  tbaadm.lam
                    where tbaadm.lam.acid = lv_acid
                    and tbaadm.lam.bank_id = bankId ;
                EXCEPTION
                    WHEN OTHERS THEN
                        lv_amount := 0 ;
                END;
            --}
            END IF;

        EXCEPTION
        WHEN OTHERS THEN
             lv_amount := 0 ;

        --}
        END;

    RETURN  lv_amount;
--}
END getOutStanding;


------------------------------------------------------------------------------
-- Function : getChangeInBaseIntRate()
-- Desc     :
--------------------------------------------------------------------------------
function getChangeInBaseIntRate(var_acid in varchar2, var_crncy_code in varchar2,lv_asondate in date,lv_bank_id in varchar2) return number as
lv_int_code           varchar2(50 char);
lv_base_int_code      varchar2(50 char);
lv_chng_in_base_rate  number;

begin
SELECT INT_TBL_CODE
INTO lv_int_code
FROM  tbaadm.ITC
WHERE ENTITY_ID = var_acid
AND BANK_ID=lv_bank_id
AND lv_asondate BETWEEN START_DATE AND END_DATE
AND INT_TBL_CODE_SRL_NUM =( SELECT MAX(INT_TBL_CODE_SRL_NUM)
                            FROM tbaadm.ITC
                            WHERE ENTITY_ID =var_acid
                            AND BANK_ID=lv_bank_id
                                      AND lv_asondate BETWEEN START_DATE AND END_DATE);

SELECT BASE_INT_TBL_CODE
INTO lv_base_int_code
FROM  tbaadm.ICV
WHERE INT_TBL_CODE = lv_int_code
AND BANK_ID=lv_bank_id
AND CRNCY_CODE = var_crncy_code
AND lv_asondate BETWEEN START_DATE AND END_DATE
AND INT_TBL_VER_NUM = ( SELECT MAX(INT_TBL_VER_NUM)
                        FROM  tbaadm.ICV
                        WHERE INT_TBL_CODE = lv_int_code
                        AND CRNCY_CODE = var_crncy_code
                        AND BANK_ID=lv_bank_id
                        AND lv_asondate BETWEEN START_DATE AND END_DATE  );


SELECT
    ((SELECT BASE_PCNT_DR
    FROM  tbaadm.ICV
    WHERE INT_TBL_CODE = lv_base_int_code
    AND CRNCY_CODE = var_crncy_code
    AND BANK_ID=lv_bank_id
    AND lv_asondate BETWEEN START_DATE AND END_DATE
    AND INT_TBL_VER_NUM=(  SELECT MAX(INT_TBL_VER_NUM)
                            FROM  tbaadm.ICV
                            WHERE INT_TBL_CODE = lv_base_int_code
                            AND CRNCY_CODE = var_crncy_code
                AND BANK_ID=lv_bank_id
                            AND lv_asondate BETWEEN START_DATE AND END_DATE))-
    (SELECT BASE_PCNT_DR
    FROM  tbaadm.ICV
    WHERE INT_TBL_CODE = lv_base_int_code
    AND CRNCY_CODE = var_crncy_code
    AND BANK_ID=lv_bank_id
    AND lv_asondate BETWEEN START_DATE AND END_DATE
    AND INT_TBL_VER_NUM=(  SELECT MAX(INT_TBL_VER_NUM)
                            FROM tbaadm.ICV
                            WHERE INT_TBL_VER_NUM < (  SELECT MAX(INT_TBL_VER_NUM)
                                                        FROM tbaadm.ICV
                                                        WHERE INT_TBL_CODE = lv_base_int_code
                                                        AND CRNCY_CODE = var_crncy_code
                                                        AND BANK_ID=lv_bank_id
                                                        AND lv_asondate BETWEEN START_DATE AND END_DATE  )
                            AND INT_TBL_CODE = lv_base_int_code
                            AND CRNCY_CODE = var_crncy_code
                            AND BANK_ID=lv_bank_id
                            AND lv_asondate BETWEEN START_DATE AND END_DATE )
    )) into lv_chng_in_base_rate FROM DUAL;


if (lv_chng_in_base_rate is null) then
lv_chng_in_base_rate:=0;
end if;
return lv_chng_in_base_rate;

end getChangeInBaseIntRate;

------------------------------------------------------------------
-- Section added for deposts module by Parikshith
-- Section START
------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------
-- For Loan accounts below code is added.
--------------------------------------------
   PROCEDURE custom_getlaintversionslaball (
      inp_crncycode          IN       VARCHAR2,
      inp_inttblcode         IN       VARCHAR2,
      inp_inttblversion      IN       VARCHAR2,
      inp_slabdrcrflg        IN       CHAR,
      inp_slabamt            IN       VARCHAR2,
      inp_loan_period_mths   IN       VARCHAR2,
      inp_loan_period_days   IN       VARCHAR2,
      out_normalrate         OUT      VARCHAR2,
      out_penalrate          OUT      VARCHAR2,
      out_indtype            OUT      VARCHAR2,
      out_beginslabamt       OUT      VARCHAR2,
      out_foundflg           OUT      NUMBER,
      inp_bankId	     IN       VARCHAR2
   )
   IS
      loc_slabamtabs   gam.clr_bal_amt%TYPE;
   BEGIN
      loc_slabamtabs := ABS (inp_slabamt);

--     -- dbms_output.put_line ('Entering Procedure CUSTOM_getLaIntVersionSlabAll') ;
--     -- dbms_output.put_line ('Balance is ' || loc_slabAmtAbs) ;
--     -- dbms_output.put_line ('inp_intTblVersion ' || inp_intTblVersion) ;
--     -- dbms_output.put_line ('inp_slabDrCrFlg ' || inp_slabDrCrFlg) ;
--
--     -- dbms_output.put_line ('inp_loan_period_mths ' || inp_loan_period_mths) ;
--     -- dbms_output.put_line ('inp_loan_period_days ' || inp_loan_period_days) ;
--
      ------------------------------------------------
      -- This query is for loan accounts.It will
      -- return the normal interest rate and penal
      -- interest rate for the loan account.
      -- Based on interest table code, interest
      -- table version, currency code, slab amount.
      -- And comparing the loan tenor month and loan
      -- tenor days set up at LAVS set up with
      -- account rephasement month and days.
      ------------------------------------------------
      SELECT TO_CHAR (nrml_int_pcnt), TO_CHAR (penal_int_pcnt),
             formatamount (begin_slab_amount, crncy_code, '01'),
             nrml_portion_ind
        INTO out_normalrate, out_penalrate,
             out_beginslabamt,
             out_indtype
        FROM lavs
       WHERE int_tbl_code = inp_inttblcode
         AND int_tbl_ver_num = inp_inttblversion
         AND int_slab_dr_cr_flg = inp_slabdrcrflg
		  AND bank_id = inp_bankId
         AND (nrml_portion_ind = 'D' OR penal_portion_ind = 'D')
         AND begin_slab_amount <= TO_NUMBER (loc_slabamtabs)
         AND TO_NUMBER (loc_slabamtabs) <= end_slab_amount
         AND (   (    loan_tenor_mths != 0
                  AND (  31 * loan_tenor_mths
                       + DECODE (loan_tenor_days, 999, 30, loan_tenor_days)
                      ) >= (31 * inp_loan_period_mths + inp_loan_period_days)
                 )
              OR (    loan_tenor_mths = 0
                  AND loan_tenor_days >=
                           (31 * inp_loan_period_mths + inp_loan_period_days
                           )
                 )
             )
         AND del_flg != 'Y'
         AND crncy_code = inp_crncycode
         AND entity_cre_flg = 'Y'
         AND ROWNUM = 1;

--     -- dbms_output.put_line ('LAVS record Found ') ;
--     -- dbms_output.put_line ('out_normalRate '||out_normalRate) ;
--     -- dbms_output.put_line ('out_penalRate '||out_penalRate) ;
      out_foundflg := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
--       -- dbms_output.put_line ('No LAVS record found ') ;
         out_foundflg := 1403;
         out_beginslabamt := 0;
   END custom_getlaintversionslaball;

--------------------------------------------------------------------------------
--------------------------------------------
-- For Loan accounts below code is added.
--------------------------------------------
   PROCEDURE custom_getlaintversionslab (
      inp_crncycode          IN       VARCHAR2,
      inp_inttblcode         IN       VARCHAR2,
      inp_inttblversion      IN       VARCHAR2,
      inp_slabdrcrflg        IN       CHAR,
      inp_slabamt            IN       VARCHAR2,
      inp_ratetype           IN       CHAR,
      inp_loan_period_mths   IN       VARCHAR2,
      inp_loan_period_days   IN       VARCHAR2,
      out_intrate            OUT      VARCHAR2,
      out_indtype            OUT      VARCHAR2,
      out_beginslabamt       OUT      VARCHAR2,
      out_foundflg           OUT      NUMBER,
      inp_bankId	     IN       VARCHAR2
   )
   IS
      loc_normalrate     VARCHAR2 (50);
      loc_penalrate      VARCHAR2 (50);
      loc_indtype        VARCHAR2 (1);
      loc_beginslabamt   VARCHAR2 (50);
      loc_foundflg       NUMBER;
   BEGIN
      custom_getlaintversionslaball (inp_crncycode,
                                     inp_inttblcode,
                                     inp_inttblversion,
                                     inp_slabdrcrflg,
                                     inp_slabamt,
                                     inp_loan_period_mths,
                                     inp_loan_period_days,
                                     loc_normalrate,
                                     loc_penalrate,
                                     loc_indtype,
                                     loc_beginslabamt,
                                     loc_foundflg,
				     inp_bankId
                                    );
      out_foundflg := loc_foundflg;

      IF (loc_foundflg != 0)
      THEN
         RETURN;
      END IF;

      out_beginslabamt := loc_beginslabamt;
      out_indtype := loc_indtype;

      IF inp_ratetype = 'N'
      THEN
         out_intrate := loc_normalrate;
      ELSIF inp_ratetype = 'P'
      THEN
         out_intrate := loc_penalrate;
      END IF;
--     -- dbms_output.put_line ('out_normalRate in Slab '||loc_normalRate) ;
--     -- dbms_output.put_line ('out_penalRate in Slab  '||loc_penalRate) ;
   END custom_getlaintversionslab;



--   *********************************************************** --
   PROCEDURE custom_getintversionslaball (
      inp_crncycode       IN       VARCHAR2,
      inp_inttblcode      IN       VARCHAR2,
      inp_inttblversion   IN       VARCHAR2,
      inp_slabdrcrflg     IN       CHAR,
      inp_slabamt         IN       VARCHAR2,
      out_normalrate      OUT      VARCHAR2,
      out_normalrateind   OUT      VARCHAR2,
      out_penalrate       OUT      VARCHAR2,
      out_penalrateind    OUT      VARCHAR2,
      out_cleanrate       OUT      VARCHAR2,
      out_cleanrateind    OUT      VARCHAR2,
      out_chorerate       OUT      VARCHAR2,
      out_chorerateind    OUT      VARCHAR2,
      out_qisrate         OUT      VARCHAR2,
      out_qisrateind      OUT      VARCHAR2,
      out_beginslabamt    OUT      VARCHAR2,
      out_foundflg        OUT      NUMBER
   )
   IS
      loc_inpslabamt   NUMBER (20, 4);
   BEGIN
      loc_inpslabamt := TO_NUMBER (inp_slabamt);

      IF (loc_inpslabamt < 0)
      THEN
         loc_inpslabamt := -loc_inpslabamt;
      END IF;

      SELECT nrml_portion_ind, TO_CHAR (nrml_int_pcnt), penal_portion_ind,
             TO_CHAR (penal_int_pcnt), clean_portion_ind,
             TO_CHAR (clean_int_pcnt), chore_portion_ind,
             TO_CHAR (chore_int_pcnt), qis_portion_ind,
             TO_CHAR (qis_int_pcnt),
             formatamount (begin_slab_amt, crncy_code, '01')
        INTO out_normalrateind, out_normalrate, out_penalrateind,
             out_penalrate, out_cleanrateind,
             out_cleanrate, out_chorerateind,
             out_chorerate, out_qisrateind,
             out_qisrate,
             out_beginslabamt
        FROM ivs
       WHERE int_tbl_code = inp_inttblcode
         AND int_tbl_ver_num = inp_inttblversion
         AND int_slab_dr_cr_flg = inp_slabdrcrflg
         AND del_flg != 'Y'
         AND entity_cre_flg = 'Y'
         AND crncy_code = inp_crncycode
         AND begin_slab_amt <= loc_inpslabamt
         AND loc_inpslabamt <= end_slab_amt;

      out_foundflg := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         BEGIN
            -- dbms_output.put_line ('No IVS record found ');
            out_foundflg := 1403;
            out_beginslabamt := 0;
         END;
   END custom_getintversionslaball;

--------------------------------------------------------------------------------
   PROCEDURE custom_getintversionslab (
      inp_crncycode       IN       VARCHAR2,
      inp_inttblcode      IN       VARCHAR2,
      inp_inttblversion   IN       VARCHAR2,
      inp_slabdrcrflg     IN       CHAR,
      inp_slabamt         IN       VARCHAR2,
      inp_ratetype        IN       CHAR,
      out_intrate         OUT      VARCHAR2,
      out_indtype         OUT      VARCHAR2,
      out_beginslabamt    OUT      VARCHAR2,
      out_foundflg        OUT      NUMBER,
      inp_bankId	  IN       VARCHAR2
   )
   IS
--------------------------------------------------------------
-- Output variables are set according to value of inp_rateType
--
--  Valid Values for inp_rateType are
--       'N'      for Normal rate
--       'P'      for Penal rate
--       'C'      for Clean rate
--       'H'      for Chore rate
--       'Q'      for Qis rate
-------------------------------------------------------------
      loc_normalrate      VARCHAR2 (50);
      loc_normalrateind   VARCHAR2 (1);
      loc_penalrate       VARCHAR2 (50);
      loc_penalrateind    VARCHAR2 (1);
      loc_cleanrate       VARCHAR2 (50);
      loc_cleanrateind    VARCHAR2 (1);
      loc_chorerate       VARCHAR2 (50);
      loc_chorerateind    VARCHAR2 (1);
      loc_qisrate         VARCHAR2 (50);
      loc_qisrateind      VARCHAR2 (1);
      loc_beginslabamt    VARCHAR2 (50);
      loc_foundflg        NUMBER;
   BEGIN
      custom_getintversionslaball (inp_crncycode,
                                   inp_inttblcode,
                                   inp_inttblversion,
                                   inp_slabdrcrflg,
                                   inp_slabamt,
                                   loc_normalrate,
                                   loc_normalrateind,
                                   loc_penalrate,
                                   loc_penalrateind,
                                   loc_cleanrate,
                                   loc_cleanrateind,
                                   loc_chorerate,
                                   loc_chorerateind,
                                   loc_qisrate,
                                   loc_qisrateind,
                                   loc_beginslabamt,
                                   loc_foundflg
                                  );
      out_foundflg := loc_foundflg;

      IF (loc_foundflg != 0)
      THEN
         RETURN;
      END IF;

      out_beginslabamt := loc_beginslabamt;

      -- dbms_output.put_line ('inp_rateType ' || inp_ratetype);
      -- dbms_output.put_line ('loc_normalRate ' || loc_normalrate);
      -- dbms_output.put_line ('loc_penalRate ' || loc_penalrate);
      -- dbms_output.put_line ('loc_penalRateInd ' || loc_penalrateind);
      IF inp_ratetype = 'N'
      THEN
         out_intrate := loc_normalrate;
         out_indtype := loc_normalrateind;
      ELSIF inp_ratetype = 'P'
      THEN
         out_intrate := loc_penalrate;
         out_indtype := loc_penalrateind;
      ELSIF inp_ratetype = 'C'
      THEN
         out_intrate := loc_cleanrate;
         out_indtype := loc_cleanrateind;
      ELSIF inp_ratetype = 'H'
      THEN
         out_intrate := loc_chorerate;
         out_indtype := loc_chorerateind;
      ELSIF inp_ratetype = 'Q'
      THEN
         out_intrate := loc_qisrate;
         out_indtype := loc_qisrateind;
      END IF;
   END custom_getintversionslab;

--   *********************************************************** --
   PROCEDURE custom_getinttblversion (
      inp_crncycode             IN       VARCHAR2,
      inp_asondate              IN       date,
      inp_changeuptodate        IN       VARCHAR2,
      inp_itc_int_tbl_ver_num   IN       VARCHAR2,
      inp_inttblcode            IN       VARCHAR2,
      out_inttblversion         OUT      VARCHAR2,
      out_basepcntcr            OUT      VARCHAR2,
      out_basepcntdr            OUT      VARCHAR2,
      out_foundflg              OUT      NUMBER,
      inp_bankId        IN    VARCHAR2
   )
   IS
      loc_asondate         DATE;
      loc_changeuptodate   DATE;
      loc_inttblversion    VARCHAR2 (5);
      loc_base_pcnt_cr     VARCHAR2 (50);
      loc_base_pcnt_dr     VARCHAR2 (50);
      CURSOR icvcur_1
      IS
         SELECT   int_version, TO_CHAR (base_pcnt_cr),
                  TO_CHAR (base_pcnt_dr)
             FROM icv
            WHERE del_flg != 'Y'
             AND entity_cre_flg = 'Y'
              AND int_tbl_code = inp_inttblcode
              AND start_date <= loc_asondate
              AND bank_id = inp_bankId
              AND end_date >= loc_asondate
              AND (base_ind != 'Y' OR base_ind IS NULL)
              AND crncy_code = inp_crncycode
         ORDER BY lchg_time DESC, start_date DESC;

      CURSOR icvcur_2
      IS
         SELECT   int_version, TO_CHAR (base_pcnt_cr), TO_CHAR (base_pcnt_dr)
             FROM icv
            WHERE del_flg != 'Y'
            AND entity_cre_flg = 'Y'
              AND int_tbl_code = inp_inttblcode
              AND NVL (int_tbl_ver_num, 'X') =
                                            NVL (inp_itc_int_tbl_ver_num, 'X')
              AND start_date <= loc_asondate
              AND end_date >= loc_asondate
              AND bank_id = inp_bankId
              AND (base_ind != 'Y' OR base_ind IS NULL)
              AND crncy_code = inp_crncycode
         ORDER BY lchg_time DESC, start_date DESC;
   BEGIN
    dbms_output.put_line('inp_asondate:'||inp_asondate);
    dbms_output.put_line('2');
--      loc_asondate := TO_DATE (inp_asondate, 'DD-MON-YY HH24:MI:SS');
      loc_asondate := inp_asondate;
        dbms_output.put_line('3 +');
     loc_changeuptodate := TO_DATE (inp_changeuptodate, 'DD-MM-YYYY HH24:MI:SS');
--      loc_changeuptodate := inp_changeuptodate;
    dbms_output.put_line('4');
    dbms_output.put_line('inp_itc_int_tbl_ver_num:' || inp_itc_int_tbl_ver_num);
    dbms_output.put_line('inp_inttblcode in custom_getinttblversion ' || inp_inttblcode);
    dbms_output.put_line('loc_asondate ' || loc_asondate);

      IF inp_itc_int_tbl_ver_num IS NOT NULL
      THEN
         dbms_output.put_line('open cursor 2' );
         dbms_output.put_line('loc_asondate in cursor 2 '||loc_asondate  );

         BEGIN
            OPEN icvcur_2;
        
              dbms_output.put_line('inp_itc_int_tbl_ver_num' ||inp_itc_int_tbl_ver_num );
            FETCH icvcur_2
             INTO loc_inttblversion, loc_base_pcnt_cr, loc_base_pcnt_dr;
         dbms_output.put_line('in cursor 2  loc_base_pcnt_dr ' ||  loc_base_pcnt_dr );
         dbms_output.put_line('in cursor 2 loc_inttblversion ' ||loc_inttblversion );
         dbms_output.put_line('in cursor 2 loc_base_pcnt_cr' || loc_base_pcnt_cr );
         dbms_output.put_line('in cursor 2 inp_crncycode' || inp_crncycode );


            CLOSE icvcur_2;
         END;
      ELSE
         BEGIN
            OPEN icvcur_1;

            FETCH icvcur_1
             INTO loc_inttblversion, loc_base_pcnt_cr, loc_base_pcnt_dr;
                 dbms_output.put_line('in cursor 1' );

            CLOSE icvcur_1;
         END;
      END IF;

-- More than one row should not be getting selected; but to be safe
      out_foundflg := 0;
      out_inttblversion := loc_inttblversion;
      out_basepcntcr := loc_base_pcnt_cr;
      out_basepcntdr := loc_base_pcnt_dr;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         -- dbms_output.put_line ('No ICV record found ');
         out_foundflg := 1403;
         out_inttblversion := '';
   END custom_getinttblversion;

-- ***********************************************************
   PROCEDURE custom_getinttblcode (
      inp_asondate          IN OUT   date,
      inp_changeuptodate    IN       date,
      inp_acid              IN       VARCHAR2,
      out_inttblcode        OUT      VARCHAR2,
      out_custcrprefpcnt    OUT      VARCHAR2,
      out_custdrprefpcnt    OUT      VARCHAR2,
      out_idcrprefpcnt      OUT      VARCHAR2,
      out_iddrprefpcnt      OUT      VARCHAR2,
      out_foundflg          OUT      NUMBER,
--***************************************
      out_min_int_pcnt_cr   OUT      VARCHAR2,
      out_min_int_pcnt_dr   OUT      VARCHAR2,
      out_max_int_pcnt_cr   OUT      VARCHAR2,
      out_max_int_pcnt_dr   OUT      VARCHAR2,
      out_pegged_flg        OUT      CHAR,
      out_itc_int_ver       OUT      VARCHAR2,
      inp_bankId        IN    VARCHAR2,
      inp_crncy            IN    VARCHAR2
--***************************************
   )
   IS
      loc_asondate            DATE;
      loc_start_date         VARCHAR2(50);
      loc_pegged_flg          CHAR (1);
      loc_inttblcode          VARCHAR2 (5);
      loc_changeuptodate      DATE;
      loc_cust_cr_pref_pcnt   VARCHAR2 (50);
      loc_cust_dr_pref_pcnt   VARCHAR2 (50);
      loc_id_cr_pref_pcnt     VARCHAR2 (50);
      loc_id_dr_pref_pcnt     VARCHAR2 (50);
--***************************************
      loc_min_int_pcnt_cr     VARCHAR2 (50);
      loc_min_int_pcnt_dr     VARCHAR2 (50);
      loc_max_int_pcnt_cr     VARCHAR2 (50);
      loc_max_int_pcnt_dr     VARCHAR2 (50);
      loc_itc_int_ver         VARCHAR2 (50);
--***************************************
   BEGIN
    DBMS_OUTPUT.put_line ( 'inside');
   --   loc_asondate := TO_DATE (inp_asondate, 'DD-MON-YY HH24:MI:SS');
     loc_asondate := inp_asondate;
      DBMS_OUTPUT.put_line ( 'dere');
      loc_changeuptodate :=  TO_DATE (inp_changeuptodate, 'DD-MON-YY HH24:MI:SS');
   --   loc_changeuptodate := inp_changeuptodate;
      DBMS_OUTPUT.put_line (   'inp_asOnDate: '
                            || loc_asondate
                            || ' inp_changeUpToDate: '
                            || loc_changeuptodate
                            || ' inp_acid: '
                            || inp_acid
                           );

      SELECT int_tbl_code, 
      --to_char(to_date(start_date,'DD-MM-YYYY'),'DD-MON-YYYY'),
        to_char(start_date,'DD-MON-YYYY'),
             pegged_flg, TO_CHAR (cust_cr_pref_pcnt),
             TO_CHAR (cust_dr_pref_pcnt), TO_CHAR (id_cr_pref_pcnt),
             TO_CHAR (id_dr_pref_pcnt), TO_CHAR (min_int_pcnt_cr),
             TO_CHAR (min_int_pcnt_dr), TO_CHAR (max_int_pcnt_cr),
             TO_CHAR (max_int_pcnt_dr), int_tbl_ver_num
        INTO loc_inttblcode, loc_start_date,
             loc_pegged_flg, loc_cust_cr_pref_pcnt,
             loc_cust_dr_pref_pcnt, loc_id_cr_pref_pcnt,
             loc_id_dr_pref_pcnt, loc_min_int_pcnt_cr,
             loc_min_int_pcnt_dr, loc_max_int_pcnt_cr,
             loc_max_int_pcnt_dr, loc_itc_int_ver
        FROM itc a
       WHERE a.entity_id = inp_acid
         AND a.entity_type = 'ACCNT'
--         AND a.start_date <= loc_asondate
--        AND a.end_date >= loc_asondate
--         AND a.del_flg != 'Y'
--         AND a.entity_cre_flg = 'Y'
--         AND a.bank_id = inp_bankId
--         AND a.lchg_time =
--                (SELECT MAX (lchg_time)
--                   FROM itc b
--                  WHERE b.entity_id = inp_acid
--                    AND b.entity_type = 'ACCNT'
--                    AND b.del_flg != 'Y'
--                    AND b.entity_cre_flg = 'Y'
--                    AND b.lchg_time <= loc_changeuptodate
--                    AND b.bank_id =inp_bankId
--                    AND b.start_date <= loc_asondate
--                    AND b.end_date >= loc_asondate)
         AND ROWNUM = 1;

-- More than one row should not be getting selected; but to be safe
 dbms_output.put_line('1 '||loc_inttblcode );
      out_foundflg := 0;
      out_inttblcode := loc_inttblcode;
      out_custcrprefpcnt := loc_cust_cr_pref_pcnt;
      out_custdrprefpcnt := loc_cust_dr_pref_pcnt;
      out_idcrprefpcnt := loc_id_cr_pref_pcnt;
      out_iddrprefpcnt := loc_id_dr_pref_pcnt;
      dbms_output.put_line('loc_inttblcode '||loc_inttblcode );
    SELECT INT_VERSION into loc_itc_int_ver FROM ICV 
    WHERE ICV.BANK_ID=inp_bankId  AND  INT_TBL_CODE = loc_inttblcode 
    AND CRNCY_CODE =  inp_crncy AND START_DATE <= inp_asondate
    AND END_DATE >= TO_DATE( '31-JAN-2099','DD-MM-YYYY HH24:MI:SS')  AND DEL_FLG = 'N' AND ENTITY_CRE_FLG = 'Y' and rownum<2
    ORDER BY LCHG_TIME DESC;
      out_itc_int_ver := loc_itc_int_ver;
      dbms_output.put_line('out_itc_int_ver**' || out_itc_int_ver);
--********************************************
      out_min_int_pcnt_cr := loc_min_int_pcnt_cr;
      out_min_int_pcnt_dr := loc_min_int_pcnt_dr;
      out_max_int_pcnt_cr := loc_max_int_pcnt_cr;
      out_max_int_pcnt_dr := loc_max_int_pcnt_dr;
      out_pegged_flg := loc_pegged_flg;

--********************************************
-- For pegged accounts int version should be of peg start date
     dbms_output.put_line('sd');
        dbms_output.put_line('loc_pegged_flg '||loc_pegged_flg);
      IF (loc_pegged_flg = 'Y')
      THEN
         DBMS_OUTPUT.put_line ('here1 ' || out_inttblcode);
         DBMS_OUTPUT.put_line ('loc_start_date ' || loc_start_date);
         inp_asondate := to_date(loc_start_date,'DD-MON-YYYY');
     
       DBMS_OUTPUT.put_line (' inp_asondate ' ||  inp_asondate);
     DBMS_OUTPUT.put_line ('here ' || out_inttblcode);
      END IF;

   
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         BEGIN
            out_foundflg := 1403;
            out_inttblcode := '';
         END;
        DBMS_OUTPUT.put_line ('out_intTblCode: ' || out_inttblcode);
   END custom_getinttblcode;

--------------------------------------------------------------------------------
   PROCEDURE custom_gettdintversionslaball (
      inp_crncycode                 IN       VARCHAR2,
      inp_inttblcode                IN       VARCHAR2,
      inp_inttblversion             IN       VARCHAR2,
      inp_slabdrcrflg               IN       CHAR,
      inp_slabamt                   IN       VARCHAR2,
      inp_deposit_period_mths       IN       VARCHAR2,
      inp_deposit_period_days       IN       VARCHAR2,
      inp_contract_startdate        IN       VARCHAR2,
      inp_contract_enddate          IN       VARCHAR2,
      inp_dep_period_in_days_only   IN       VARCHAR2,
      out_normalrate                OUT      VARCHAR2,
      out_penalrate                 OUT      VARCHAR2,
      out_extnrate                  OUT      VARCHAR2,
      out_indtype                   OUT      VARCHAR2,
      out_beginslabamt              OUT      VARCHAR2,
      out_foundflg                  OUT      NUMBER
   )
   IS
      lv_contract_startdate   VARCHAR2 (10);
      lv_contract_enddate     VARCHAR2 (10);
   BEGIN
-- dbms_output.put_line('inp_intTblCode ' || inp_intTblCode || ' inp_intTblVersion ' || inp_intTblVersion || ' inp_slabDrCrFlg ' || inp_slabDrCrFlg);
-- dbms_output.put_line('inp_slabAmt ' || inp_slabAmt || ' inp_deposit_period_mths ' || inp_deposit_period_mths || ' inp_deposit_period_days ' || inp_deposit_period_days);

      -- SELECT TO_CHAR (nrml_int_pcnt), TO_CHAR (penal_pcnt),
--             TO_CHAR (extn_pcnt),
--             formatamount (begin_slab_amount, crncy_code, '01'),
--             slab_amount_ind
--        INTO out_normalrate, out_penalrate,
--             out_extnrate,
--             out_beginslabamt,
--             out_indtype
--        FROM tvs
--       WHERE int_tbl_code = inp_inttblcode
--         AND int_tbl_ver_num = inp_inttblversion
--         AND int_slab_dr_cr_flg = inp_slabdrcrflg
--         AND begin_slab_amount <= TO_NUMBER (inp_slabamt)
--         AND TO_NUMBER (inp_slabamt) <= max_slab_amount
--         AND (   (    max_contracted_mths != 0
--                  AND (  31 * max_contracted_mths
--                       + DECODE (max_contracted_days,
--                                 999, 30,
--                                 max_contracted_days
--                                )
--                      ) >=
--                         (  31 * inp_deposit_period_mths
--                          + inp_deposit_period_days
--                         )
--                  AND (  31 * max_period_run_mths
--                       + DECODE (max_period_run_days,
--                                 999, 30,
--                                 max_period_run_days
--                                )
--                      ) >=
--                         (  31 * inp_deposit_period_mths
--                          + inp_deposit_period_days
--                         )
--                 )
--              OR (    max_contracted_mths = 0
--                  -- AND inp_deposit_period_mths = 0
--                  -- Fixed by Dev for ALM
--                  AND max_contracted_days >= inp_dep_period_in_days_only
--                  AND (31 * max_period_run_mths + max_period_run_days) >=
--                         (  31 * inp_deposit_period_mths
--                          + inp_deposit_period_days
--                         )
--                 )
--             )
--         AND del_flg != 'Y'
--         AND crncy_code = inp_crncycode
--         AND entity_cre_flg = 'Y'
--         AND ROWNUM = 1;
      lv_contract_startdate := SUBSTR (inp_contract_startdate, 1, 10);
      lv_contract_enddate := SUBSTR (inp_contract_enddate, 1, 10);

      SELECT TO_CHAR (nrml_int_pcnt), TO_CHAR (penal_pcnt),
             TO_CHAR (extn_pcnt),
             formatamount (begin_slab_amount, crncy_code, '01'),
             slab_amount_ind
        INTO out_normalrate, out_penalrate,
             out_extnrate,
             out_beginslabamt,
             out_indtype
        FROM (SELECT   nrml_int_pcnt, penal_pcnt, extn_pcnt,
                       begin_slab_amount, crncy_code, slab_amount_ind,
                       CASE
                          WHEN max_contracted_days = 999
                             THEN (  ADD_MONTHS
                                            (TO_DATE (lv_contract_startdate,
                                                      'dd-mm-yyyy'
                                                     ),
                                             (NVL (max_contracted_mths, 0) + 1
                                             )
                                            )
                                   - 1
                                  )
                          ELSE (  ADD_MONTHS
                                            (TO_DATE (lv_contract_startdate,
                                                      'dd-mm-yyyy'
                                                     ),
                                             (NVL (max_contracted_mths, 0)
                                             )
                                            )
                                + NVL (max_contracted_days, 0)
                               )
                       END mat_date
                  FROM tbaadm.tvs
                 WHERE int_tbl_code = inp_inttblcode
                   AND int_tbl_ver_num = inp_inttblversion
                   AND int_slab_dr_cr_flg = inp_slabdrcrflg
                   AND begin_slab_amount <= inp_slabamt
                   AND inp_slabamt <= max_slab_amount
                   AND del_flg != 'Y'
                   AND crncy_code = inp_crncycode
                 --  AND entity_cre_flg = 'Y'
                   AND period_run_ind = 'F'
              ORDER BY (  31 * max_contracted_mths
                        + DECODE (max_contracted_days,
                                  999, 30,
                                  max_contracted_days
                                 )
                       ),
                       (  31 * max_period_run_mths
                        + DECODE (max_period_run_days,
                                  999, 30,
                                  max_period_run_days
                                 )
                       ))
       WHERE 1 = 1
         AND TO_DATE (lv_contract_enddate, 'dd-mm-yyyy') <= mat_date - 1
         AND ROWNUM = 1;

      out_foundflg := 0;
-- dbms_output.put_line('out_normalRate ' || out_normalRate);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         out_foundflg := 1403;
         out_beginslabamt := 0;
   END custom_gettdintversionslaball;
   
   
   
   



--------------------------------------------------------------------------------
   PROCEDURE custom_gettdintversionslab (
      inp_crncycode                 IN       VARCHAR2,
      inp_inttblcode                IN       VARCHAR2,
      inp_inttblversion             IN       VARCHAR2,
      inp_slabdrcrflg               IN       CHAR,
      inp_slabamt                   IN       VARCHAR2,
      inp_ratetype                  IN       CHAR,
      inp_deposit_period_mths       IN       VARCHAR2,
      inp_deposit_period_days       IN       VARCHAR2,
      inp_dep_period_in_days_only   IN       VARCHAR2,
      inp_contract_startdate        IN       VARCHAR2,
      inp_contract_enddate          IN       VARCHAR2,
      out_intrate                   OUT      VARCHAR2,
      out_indtype                   OUT      VARCHAR2,
      out_beginslabamt              OUT      VARCHAR2,
      out_foundflg                  OUT      NUMBER,
      inp_bankId            IN       VARCHAR2
   )
   IS
      loc_normalrate     VARCHAR2 (50);
      loc_penalrate      VARCHAR2 (50);
      loc_extnrate       VARCHAR2 (50);
      loc_indtype        VARCHAR2 (1);
      loc_beginslabamt   VARCHAR2 (50);
      loc_foundflg       NUMBER;
   BEGIN
-- dbms_output.put_line('inp_crncyCode: ' || inp_crncyCode || ' inp_intTblCode: ' || inp_intTblCode || ' inp_intTblVersion: ' || inp_intTblVersion);
-- dbms_output.put_line('inp_slabDrCrflg: ' || inp_slabDrCrflg || ' inp_slabAmt: ' || inp_slabAmt || ' inp_deposit_period_mths: ' || inp_deposit_period_mths);
-- dbms_output.put_line('inp_deposit_period_days ' || inp_deposit_period_days || ' inp_dep_period_in_days_only ' || inp_dep_period_in_days_only);
      custom_gettdintversionslaball (inp_crncycode,
                                     inp_inttblcode,
                                     inp_inttblversion,
                                     inp_slabdrcrflg,
                                     inp_slabamt,
                                     inp_deposit_period_mths,
                                     inp_deposit_period_days,
                                     inp_contract_startdate,
                                     inp_contract_enddate,
                                     inp_dep_period_in_days_only,
                                     loc_normalrate,
                                     loc_penalrate,
                                     loc_extnrate,
                                     loc_indtype,
                                     loc_beginslabamt,
                                     loc_foundflg
                                    );
      out_foundflg := loc_foundflg;

-- dbms_output.put_line('loc_normalRate: ' || loc_normalRate || ' loc_penalRate ' || loc_penalRate || ' loc_extnRate ' || loc_extnRate);
      IF (loc_foundflg != 0)
      THEN
         RETURN;
      END IF;

      out_beginslabamt := loc_beginslabamt;
      out_indtype := loc_indtype;

      IF inp_ratetype = 'N'
      THEN
         out_intrate := loc_normalrate;
      ELSIF inp_ratetype = 'P'
      THEN
         out_intrate := loc_penalrate;
      ELSIF inp_ratetype = 'C'
      THEN
         out_intrate := loc_extnrate;
      END IF;
   END custom_gettdintversionslab;

--------------------------------------------------------------------------------





   --------------------------------------------------------------------------------
   PROCEDURE custom_geteffectiveroi (
      inp_ratetype          IN       CHAR,
      inp_slabdrcrflg       IN       CHAR,
      inp_schemetype        IN       VARCHAR2,
      inp_custcrprefpcnt    IN       VARCHAR2,
      inp_custdrprefpcnt    IN       VARCHAR2,
      inp_idcrprefpcnt      IN       VARCHAR2,
      inp_iddrprefpcnt      IN       VARCHAR2,
      inp_basepcntcr        IN       VARCHAR2,
      inp_basepcntdr        IN       VARCHAR2,
      inp_diffintrate       IN       VARCHAR2,
--*****************************************************
      inp_min_int_pcnt_cr   IN       VARCHAR2,
      inp_min_int_pcnt_dr   IN       VARCHAR2,
      inp_max_int_pcnt_cr   IN       VARCHAR2,
      inp_max_int_pcnt_dr   IN       VARCHAR2,
      inp_pegged_flg        IN       CHAR,
--*****************************************************
      out_intrate           OUT      VARCHAR2,
      inp_bankId        IN       VARCHAR2
   )
   IS
   BEGIN
      -- For TD accounts, for all the three types NORMAL, PENAL and
      -- EXTENSION, preferentials will be considered.
      IF (inp_schemetype = 'TDA' OR inp_schemetype = 'TUA')
      THEN
         out_intrate :=
            TO_CHAR (  TO_NUMBER (inp_basepcntcr)
                     + TO_NUMBER (inp_diffintrate)
                     + TO_NUMBER (inp_custcrprefpcnt)
                     + TO_NUMBER (inp_idcrprefpcnt)
                    );

--*************************************************
         --IF (inp_pegged_flg = 'N' AND inp_ratetype = 'N')
         --THEN
        IF (inp_ratetype = 'N') 
        THEN
            IF (    (TO_NUMBER (inp_max_int_pcnt_cr) != 0)
                AND (TO_NUMBER (out_intrate) > TO_NUMBER (inp_max_int_pcnt_cr)
                    )
               )
            THEN
               out_intrate := inp_max_int_pcnt_cr;
            ELSIF (    (TO_NUMBER (inp_min_int_pcnt_cr) != 0)
                   AND (TO_NUMBER (out_intrate) <
                                               TO_NUMBER (inp_min_int_pcnt_cr)
                       )
                  )
            THEN
               out_intrate := inp_min_int_pcnt_cr;
            END IF;
        END IF;
--*************************************************
      ELSE
         IF (inp_ratetype = 'N')
         THEN
            IF (inp_slabdrcrflg = 'C')
            THEN
               out_intrate :=
                  TO_CHAR (  TO_NUMBER (inp_basepcntcr)
                           + TO_NUMBER (inp_diffintrate)
                           + TO_NUMBER (inp_custcrprefpcnt)
                           + TO_NUMBER (inp_idcrprefpcnt)
                          );

--*************************************************
               -- dbms_output.put_line (   'Inside ROI inp_max_int_pcnt_cr'
               --                      || inp_max_int_pcnt_cr
               --                     );
               -- dbms_output.put_line ('Inside ROI out_intRate ' || out_intrate);
               --IF (inp_pegged_flg = 'N')
               --THEN
                  -- dbms_output.put_line ('NOT A TDA');
                  -- dbms_output.put_line (   'inp_max_int_pcnt_cr'
                  --                      || inp_max_int_pcnt_cr
                  --                     );
                  -- dbms_output.put_line ('out_intRate' || out_intrate);
                  IF (    (TO_NUMBER (inp_max_int_pcnt_cr) != 0)
                      AND (TO_NUMBER (out_intrate) >
                                               TO_NUMBER (inp_max_int_pcnt_cr)
                          )
                     )
                  THEN
                     out_intrate := inp_max_int_pcnt_cr;
                  ELSIF (    (TO_NUMBER (inp_min_int_pcnt_cr) != 0)
                         AND (TO_NUMBER (out_intrate) <
                                               TO_NUMBER (inp_min_int_pcnt_cr)
                             )
                        )
                  THEN
                     out_intrate := inp_min_int_pcnt_cr;
                  END IF;
               --END IF;
               -- dbms_output.put_line ('AFTER');
               -- dbms_output.put_line (   'inp_max_int_pcnt_cr'
               --                      || inp_max_int_pcnt_cr
               --                     );
               -- dbms_output.put_line ('out_intRate' || out_intrate);
--************************************************
            ELSIF (inp_slabdrcrflg = 'D')
            THEN
               -- dbms_output.put_line ('inp_basePcntDr' || inp_basepcntdr);
               -- dbms_output.put_line ('inp_diffIntRate' || inp_diffintrate);
               -- dbms_output.put_line ('inp_custDrPrefPcnt'
               --                      || inp_custdrprefpcnt
               --                     );
               -- dbms_output.put_line ('inp_idDrPrefPcnt' || inp_iddrprefpcnt);
               out_intrate :=
                  TO_CHAR (  TO_NUMBER (NVL (inp_basepcntdr, 0))
                           + TO_NUMBER (NVL (inp_diffintrate, 0))
                           + TO_NUMBER (NVL (inp_custdrprefpcnt, 0))
                           + TO_NUMBER (NVL (inp_iddrprefpcnt, 0))
                          );

--************************************************
               -- dbms_output.put_line ('Before');
               -- dbms_output.put_line (   'inp_max_int_pcnt_cr'
               --                      || inp_max_int_pcnt_cr
               --                     );
               -- dbms_output.put_line ('out_intRate' || out_intrate);
               --IF (inp_pegged_flg = 'N')
               --THEN
                  IF (    (TO_NUMBER (inp_max_int_pcnt_dr) != 0)
                      AND (TO_NUMBER (out_intrate) >
                                               TO_NUMBER (inp_max_int_pcnt_dr)
                          )
                     )
                  THEN
                     out_intrate := inp_max_int_pcnt_dr;
                  ELSIF (    (TO_NUMBER (inp_min_int_pcnt_dr) != 0)
                         AND (TO_NUMBER (out_intrate) <
                                               TO_NUMBER (inp_min_int_pcnt_dr)
                             )
                        )
                  THEN
                     out_intrate := inp_min_int_pcnt_dr;
                  END IF;
               --END IF;
--************************************************
               -- dbms_output.put_line ('AFTER');
               -- dbms_output.put_line (   'inp_max_int_pcnt_cr'
               --                      || inp_max_int_pcnt_cr
               --                     );
               -- dbms_output.put_line ('out_intRate' || out_intrate);
            END IF;
         ELSE
            IF (inp_slabdrcrflg = 'C')
            THEN
               out_intrate :=
                  TO_CHAR (  TO_NUMBER (inp_basepcntcr)
                           + TO_NUMBER (inp_diffintrate)
                          );
            ELSIF (inp_slabdrcrflg = 'D')
            THEN
               -- dbms_output.put_line ('inp_diffIntRate ' || inp_diffintrate);
               out_intrate :=
                  TO_CHAR (  TO_NUMBER (inp_basepcntdr)
                           + TO_NUMBER (inp_diffintrate)
                          );
            END IF;
         END IF;
      END IF;
   END custom_geteffectiveroi;

PROCEDURE custom_getintrate_TD (
      inp_asondate       IN       DATE,
      inp_acid           IN       VARCHAR2,
      inp_slabamt        IN       VARCHAR2,
      inp_slabdrcrflg    IN       CHAR,
      inp_ratetype       IN       CHAR,
      inp_bankId    IN    VARCHAR2,
      out_intrate        OUT      VARCHAR2,
      out_indtype        OUT      VARCHAR2,
      out_beginslabamt   OUT      VARCHAR2,
      out_foundflg       OUT      NUMBER
   )
   IS
      loc_asondate                  VARCHAR2 (50);
      loc_inttblcode                VARCHAR2 (5);
      loc_inttblversion             VARCHAR2 (5);
      loc_schmtype                  VARCHAR2 (3);
      loc_opendate                  VARCHAR2 (19);
      loc_maturity_date             VARCHAR2 (50);
      loc_foundflg                  NUMBER;
      loc_dummy                     NUMBER;
      loc_beginslabamt              VARCHAR2 (50);
      loc_deposit_period_mths       VARCHAR2 (50);
      loc_deposit_period_days       VARCHAR2 (50);
      loc_dep_period_in_days_only   VARCHAR2 (50);
      loc_cust_cr_pref_pcnt         VARCHAR2 (50);
      loc_cust_dr_pref_pcnt         VARCHAR2 (50);
      loc_id_cr_pref_pcnt           VARCHAR2 (50);
      loc_id_dr_pref_pcnt           VARCHAR2 (50);
      loc_base_pcnt_cr              VARCHAR2 (50);
      loc_base_pcnt_dr              VARCHAR2 (50);
      loc_int_rate                  VARCHAR2 (50);
      loc_crncycode                 VARCHAR2 (3);
--********************************************
      loc_min_int_pcnt_cr           VARCHAR2 (50);
      loc_min_int_pcnt_dr           VARCHAR2 (50);
      loc_max_int_pcnt_cr           VARCHAR2 (50);
      loc_max_int_pcnt_dr           VARCHAR2 (50);
      loc_pegged_flg                CHAR (1);
--********************************************
      loc_loan_period_mths          VARCHAR2 (50);
      loc_loan_period_days          VARCHAR2 (50);
      loc_itc_int_ver               tbaadm.itc.int_tbl_ver_num%TYPE;
      actualintrate                    VARCHAR2 (50);
--********************************************
   BEGIN
      loc_asondate := inp_asondate;
    dbms_output.put_line('here1');
    dbms_output.put_line('inp_bankId' ||inp_bankId);
    dbms_output.put_line('inp_acid' ||inp_acid);
      BEGIN
         SELECT gsp.schm_type
           INTO loc_schmtype
           FROM gsp, gam
          WHERE gam.acid = inp_acid
            AND gsp.schm_code = gam.schm_code
            AND gam.del_flg != 'Y'
            AND gsp.bank_id = inp_bankId;
--            AND gam.entity_cre_flg = 'Y';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            loc_dummy := 0;
         WHEN OTHERS
         THEN
            loc_dummy := 0;
      END;                                                                -- }

      DBMS_OUTPUT.put_line ('schm_type: ' || loc_schmtype);

      IF (loc_schmtype = 'TDA' OR loc_schmtype = 'TUA')
      THEN
         BEGIN
            dbms_output.put_line('here2');
            SELECT tam.deposit_period_mths, tam.deposit_period_days,
                   (  TO_DATE (tam.maturity_date)
                    - TO_DATE (tam.open_effective_date)
                   ),
                   TO_CHAR (tam.open_effective_date, 'DD-MM-YYYY HH24:MI:SS'),
                   TO_CHAR (maturity_date, 'DD-MM-YYYY HH24:MI:SS')
              INTO loc_deposit_period_mths, loc_deposit_period_days,
                   loc_dep_period_in_days_only,
                   loc_asondate,
                   loc_maturity_date
              FROM tam, gam
             WHERE tam.acid = inp_acid
               AND gam.acid = tam.acid
  --             AND gam.entity_cre_flg = 'Y'
               AND gam.del_flg != 'Y';
            DBMS_OUTPUT.put_line ('asondate: ' || loc_asondate);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               loc_dummy := 0;
            WHEN OTHERS
            THEN
               DBMS_OUTPUT.put_line ('Error '|| SQLERRM);
               loc_dummy := 0;
         END;

         BEGIN
            dbms_output.put_line('here3');
            SELECT     id_cr_pref_pcnt + nrml_pcnt_cr
            INTO     actualintrate
            FROM     tbaadm.itc
            WHERE     entity_id         = inp_acid
            AND     entity_type     = 'ACCNT'
            AND     start_date         <= to_date(loc_asondate,'DD-MM-YYYY HH24:MI:SS')
            AND     NRML_PCNT_CR     is not null
            AND     PEGGED_FLG         = 'Y'
            AND     int_tbl_code_srl_num = (SELECT     MAX (int_tbl_code_srl_num)
                                            FROM     tbaadm.itc
                                            WHERE     entity_id    = inp_acid
                                            AND     entity_type     = 'ACCNT'
                                            AND     start_date     <= to_date(loc_asondate,'DD-MM-YYYY HH24:MI:SS')
                                            AND     end_date     >= to_date(loc_asondate,'DD-MM-YYYY HH24:MI:SS')
                                            AND     NRML_PCNT_CR     is not null)
                                            AND     PEGGED_FLG         = 'Y'
            AND     end_date >= to_date(loc_asondate,'DD-MM-YYYY HH24:MI:SS');

             if (actualintrate is not null ) then
             --{
                out_intrate         := actualintrate;
                out_indtype         := 'F';
                out_beginslabamt     := inp_slabamt;
                out_foundflg         := 0;
                RETURN;
             --}
             end if;
            dbms_output.put_line('intrate from itc: '||actualintrate);

        EXCEPTION
            WHEN OTHERS THEN
            dbms_output.put_line ( ' NEW LOGIC ' || sqlerrm);
            BEGIN
                SELECT FULL_RATE
                into actualintrate
                FROM tbaadm.idt
                WHERE entity_id = inp_acid
                AND INTEREST_TYPE = inp_ratetype
                AND SERIAL_NUM = (select max(SERIAL_NUM)
                                  from tbaadm.idt
                                  where entity_id = inp_acid
                                  and interest_type = inp_ratetype);
            EXCEPTION
                WHEN OTHERS THEN
                    dbms_output.put_line ( 'Error 3 :  ' || sqlerrm);
                    actualintrate := null;
            END;
        END;
        dbms_output.put_line ( ' Interest -  ' || actualintrate);
        if (actualintrate is not null ) then
        --{
            out_intrate         := actualintrate;
            out_indtype         := 'F';
            out_beginslabamt     := inp_slabamt;
            out_foundflg         := 0;
               RETURN;
        --}
        end if;

      END IF;                                                           --   }

--------------------------------------------
-- For Loan accounts below code is added.
--------------------------------------------
      IF (loc_schmtype = 'LAA' OR loc_schmtype = 'CLA')
      THEN
         BEGIN
            SELECT lam.rep_perd_mths, lam.rep_perd_days
              INTO loc_loan_period_mths, loc_loan_period_days
              FROM lam, gam
             WHERE lam.acid = inp_acid
               AND gam.acid = lam.acid
            AND gam.bank_id = inp_bankId
               AND gam.entity_cre_flg = 'Y'
               AND gam.del_flg != 'Y';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               loc_dummy := 0;
            WHEN OTHERS
            THEN
               loc_dummy := 0;
         END;
      END IF;                                                       --   }

    dbms_output.put_line('loc_loan_period_mths:'||loc_loan_period_mths || ' loc_loan_period_days:' || loc_loan_period_days);

      -- This is added to get the currency code of the account
      -- so that, interest versions and corresponding slabs of
      -- the same currency can be selected.
      BEGIN
         SELECT acct_crncy_code
           INTO loc_crncycode
           FROM gam
          WHERE gam.acid = inp_acid
            AND gam.del_flg != 'Y'
        AND gam.bank_id = inp_bankId;
        --    AND gam.entity_cre_flg = 'Y';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            loc_dummy := 0;
         WHEN OTHERS
         THEN
            loc_dummy := 0;
      END;

      loc_opendate := to_date(loc_asondate,'DD-MM-YYYY HH24:MI:SS');
      CommonPackage.custom_getinttblcode(loc_opendate,
                                                '31-DEC-2099',
                                                inp_acid,
                                                loc_inttblcode,
                                                loc_cust_cr_pref_pcnt,
                                                loc_cust_dr_pref_pcnt,
                                                loc_id_cr_pref_pcnt,
                                                loc_id_dr_pref_pcnt,
                                                loc_foundflg,
--**************************************
                                                loc_min_int_pcnt_cr,
                                                loc_min_int_pcnt_dr,
                                                loc_max_int_pcnt_cr,
                                                loc_max_int_pcnt_dr,
                                                loc_pegged_flg,
                                                loc_itc_int_ver,
                        inp_bankId,
                        loc_crncycode
                                               );

--**************************************
      IF (loc_foundflg != 0)
      THEN
         out_foundflg := loc_foundflg;
         -- dbms_output.put_line ('out_foundFlg: ' || out_foundflg);
         RETURN;
      END IF;

      DBMS_OUTPUT.put_line ('int tbl code : ' || loc_inttblcode);
      dbms_output.put_line(' in custom_getinttblversion loc_inttblcode'|| loc_inttblcode);
      dbms_output.put_line(' before custom_getinttblversion loc_crncycode'|| loc_crncycode);

      CommonPackage.custom_getinttblversion (loc_crncycode,
                                                   to_date(loc_asondate,'DD-MM-YYYY HH24:MI:SS'),
                                                   '31-12-2099',
                                                   loc_itc_int_ver,
                                                   loc_inttblcode,
                                                   loc_inttblversion,
                                                   loc_base_pcnt_cr,
                                                   loc_base_pcnt_dr,
                                                   loc_foundflg,
                           inp_bankId
                                                  );
      -- dbms_output.put_line ('aftre call int tbl code : ' || loc_inttblcode);
      -- dbms_output.put_line (   'aftre call loc_base_pcnt_cr : '
      --                      || loc_base_pcnt_cr
      --                    );
      DBMS_OUTPUT.put_line (   'aftre call loc_base_pcnt_dr : '
                            || loc_base_pcnt_dr
                           );

      IF (loc_foundflg != 0)
      THEN
         out_foundflg := loc_foundflg;
         RETURN;
      END IF;

      DBMS_OUTPUT.put_line ('loc_intTblVersion: ' || loc_inttblversion);

      IF (loc_schmtype = 'TDA' OR loc_schmtype = 'TUA')
      THEN
         DBMS_OUTPUT.put_line ('inside TDA conditions');
         --  For Scheme type TDA
         --  Getting interest rates from TVS
         CommonPackage.custom_gettdintversionslab
                                                (loc_crncycode,
                                                 loc_inttblcode,
                                                 loc_inttblversion,
                                                 inp_slabdrcrflg,
                                                 inp_slabamt,
                                                 inp_ratetype,
                                                 loc_deposit_period_mths,
                                                 loc_deposit_period_days,
                                                 loc_dep_period_in_days_only,
                                                 loc_asondate,
                                                 loc_maturity_date,
                                                 loc_int_rate,
                                                 out_indtype,
                                                 out_beginslabamt,
                                                 out_foundflg,
                         inp_bankId
                                                );
         DBMS_OUTPUT.put_line ('loc_int_rate: ' || loc_int_rate);
      ELSIF (loc_schmtype = 'LAA' OR loc_schmtype = 'CLA')
      THEN
--  For Scheme type LAA
--  Getting interest rates from LAVS
--------------------------------------------
-- For Loan accounts below code is added.
--------------------------------------------
         CommonPackage.custom_getlaintversionslab
                                                       (loc_crncycode,
                                                        loc_inttblcode,
                                                        loc_inttblversion,
                                                        inp_slabdrcrflg,
                                                        inp_slabamt,
                                                        inp_ratetype,
                                                        loc_loan_period_mths,
                                                        loc_loan_period_days,
                                                        loc_int_rate,
                                                        out_indtype,
                                                        out_beginslabamt,
                                                        out_foundflg,
                            inp_bankId
                                                       );
      ELSE
         --  For all other scheme types than TDA and LAA
         --  Getting interest rates from IVS
         CommonPackage.custom_getintversionslab (loc_crncycode,
                                                       loc_inttblcode,
                                                       loc_inttblversion,
                                                       inp_slabdrcrflg,
                                                       inp_slabamt,
                                                       inp_ratetype,
                                                       loc_int_rate,
                                                       out_indtype,
                                                       out_beginslabamt,
                                                       out_foundflg,
                               inp_bankId
                                                      );
      END IF;                                                         --   } }

      DBMS_OUTPUT.put_line ('------------------------------');
      DBMS_OUTPUT.put_line ('loc_intTblCode: ' || loc_inttblcode);
      DBMS_OUTPUT.put_line ('loc_intTblVersion: ' || loc_inttblversion);
      DBMS_OUTPUT.put_line ('inp_slabDrCrFlg: ' || inp_slabdrcrflg);
      DBMS_OUTPUT.put_line ('inp_slabAmt: ' || inp_slabamt);
      DBMS_OUTPUT.put_line ('loc_int_rate: ' || loc_int_rate);
      -- To get the effective ROI for different rate types and
      -- different Dr Cr flag.
      CommonPackage.custom_geteffectiveroi (inp_ratetype,
                                                  inp_slabdrcrflg,
                                                  loc_schmtype,
                                                  loc_cust_cr_pref_pcnt,
                                                  loc_cust_dr_pref_pcnt,
                                                  loc_id_cr_pref_pcnt,
                                                  loc_id_dr_pref_pcnt,
                                                  loc_base_pcnt_cr,
                                                  loc_base_pcnt_dr,
                                                  loc_int_rate,
--*****************************************************
                                                  loc_min_int_pcnt_cr,
                                                  loc_min_int_pcnt_dr,
                                                  loc_max_int_pcnt_cr,
                                                  loc_max_int_pcnt_dr,
                                                  loc_pegged_flg,
--*****************************************************
                                                  out_intrate,
                          inp_bankId
                                                 );
      DBMS_OUTPUT.put_line ('loc_int_rate x : ' || loc_int_rate);
      DBMS_OUTPUT.put_line ('loc_base_pcnt_dr x : ' || loc_base_pcnt_dr);
      RETURN;
   END custom_getintrate_TD;
   

FUNCTION getCrIntRate_unverified(v_acid  varchar2,
                v_balance NUMBER,
                v_as_on_date    DATE,
                v_bankId varchar2) RETURN NUMBER is
 outstanding_amount  number;

    lv_intrate          NUMBER;
    v_bal               NUMBER;
        lv_indType          VARCHAR2(20);
        lv_beginSlabAmt     VARCHAR2(20);
        lv_foundFlg         VARCHAR2(20);

BEGIN
--{
--  SELECT getEabBalanceFunc(v_acid,'NG',v_as_on_date)
--  into v_bal
--  from dual;
    v_bal := v_balance;

    dbms_output.put_line('balance:' || v_bal);
    /*custom_packInterest_unverified.custom_getIntRate(v_as_on_date,
                                v_acid,
                                v_bal,
                                'C',
                                'N',
                                v_bankId,
                                lv_intrate,
                                lv_indType,
                                lv_beginSlabAmt,
                                lv_foundFlg );
    */
    outstanding_amount := lv_intrate;
    RETURN outstanding_amount;
--}
END getCrIntRate_unverified;

--------------------------------------------------------
-- SECTION ENDS
----------------------------------------------------

--------------------------------------------------------------------------------
-- Function : getCountOfChar()
-- Desc     : Returns the no of times a character exists in a string(string, char)
--------------------------------------------------------------------------------

FUNCTION getCountOfChar(lv_string VARCHAR2,lv_char CHAR)
    RETURN NUMBER AS
lv_input_length        NUMBER;
lv_index        NUMBER := 1;
lv_count_of_char    NUMBER := 0;

BEGIN
    BEGIN
        lv_input_length := LENGTH(lv_string);
        WHILE lv_index <= lv_input_length
        LOOP
            IF(SUBSTR(lv_string, lv_index, 1) = 'U') THEN
            --{
                lv_count_of_char := lv_count_of_char +1 ;
            --}
            END IF;
            lv_index := lv_index + 1;
        END LOOP;
    END;
    RETURN lv_count_of_char;
END getCountOfChar;


--------------------------------------
--FUNCTION format_str
--return the ### ### # format string, for example,input '131301013002', output '13 130 101 300 2'
--------------------------------------

FUNCTION format_str
                         (str in varchar2) return varchar2
                         as
                            str_1      varchar2(100);
                            str_length number;
begin
                    str_length := length(str);
                    while (str_length >= 4) loop
                      str_length := str_length - 3;
                      str_1      := substr(str, str_length, 3) || ' ' || str_1;
                    end loop;
                    if ((str_length - 1) = 0) then
                      str_1 := str_1 || substr(str, length(str), 1);
                    else
                      str_1 := substr(str, 1, str_length - 1) || ' ' || str_1 ||
                               substr(str, length(str), 1);
                    end if;
                     return str_1;
end format_str;


--------------------------------------------------------------------------------
-- Function : getOldIntRate()
-- Desc     :
--------------------------------------------------------------------------------
function getOldIntRate(lv_acid in varchar2, lv_asondate in DATE,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2,lv_crncy_code IN VARCHAR2) return number AS

lv_old_int_rate       number;

BEGIN
BEGIN
--{
   lv_old_int_rate:=0;
    End;
    Return lv_old_int_rate;
--}
END getOldIntRate;

--------------------------------------------------------------------------------
-- Function : getNewIntRate()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getNewIntRate(lv_acid in varchar2, lv_asondate in DATE,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2,lv_crncy_code IN VARCHAR2) return number AS

lv_new_int_rate       number;

BEGIN
BEGIN
--{

    lv_new_int_rate:=0;
    --}
    End;
    Return lv_new_int_rate;
--}
END getNewIntRate;


--------------------------------------------------------------------------------
-- Function : getOldlimit()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getOldlimit(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2) return number is

    lv_limit     tbaadm.lht.sanct_lim%TYPE;

    BEGIN

  BEGIN

         select sanct_lim  into lv_limit from tbaadm.lht
       where acid = lv_acid
       and bank_id =lv_bank_id
       and serial_num = ( select max(serial_num) from tbaadm.lht
                    where acid =lv_acid
                    and bank_id=lv_bank_id
                    and applicable_date <= lv_fromdate
                    and entity_cre_flg ='Y'
                    and del_flg ='N'
                   )
                    and entity_cre_flg ='Y'
                    and del_flg ='N';
         EXCEPTION
                WHEN no_data_found THEN
                lv_limit:=0;
                END;

     RETURN lv_limit;
END getOldlimit     ;


--------------------------------------------------------------------------------
-- Function : getNewlimit()
-- Desc     :
--------------------------------------------------------------------------------
FUNCTION getNewlimit(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2) return number is

    lv_limit     tbaadm.lht.sanct_lim%type:=0;

    BEGIN
  BEGIN

       select sanct_lim  into lv_limit from tbaadm.lht
       where acid = lv_acid
       and bank_id =lv_bank_id
       and serial_num = ( select max(serial_num) from tbaadm.lht
                    where acid =lv_acid
                    and bank_id=lv_bank_id
                    and applicable_date <= lv_todate
                    and entity_cre_flg ='Y'
                    and del_flg ='N'
                   )
and entity_cre_flg ='Y'
and del_flg ='N';
EXCEPTION
                WHEN no_data_found THEN
                lv_limit:=0;
                END;
     RETURN lv_limit;
   --}
END getNewlimit    ;


--------------------------------------------------------------------------------
-- Function : getExpDateOfOldIntRate()
-- Desc     :
--------------------------------------------------------------------------------

FUNCTION getexpdateofoldintrate(lv_acid       IN VARCHAR2,
                                lv_asondate   IN DATE,
                                lv_fromdate   IN DATE,
                                lv_todate     IN DATE,
                                lv_bank_id    IN VARCHAR2,
                                lv_crncy_code IN VARCHAR2) RETURN DATE AS

    lv_expdateofrate DATE;
    lv_int_code      tbaadm.itc.int_tbl_code%TYPE;
    --{
BEGIN

    BEGIN
        SELECT int_tbl_code
        INTO lv_int_code
        FROM tbaadm.itc
        WHERE entity_id = lv_acid
              AND entity_type = 'ACCNT'
              AND bank_id = lv_bank_id
              AND start_date <= lv_fromdate
              AND end_date >= lv_fromdate
              AND int_tbl_code_srl_num = (SELECT MAX(int_tbl_code_srl_num)
                                          FROM tbaadm.itc
                                          WHERE entity_id = lv_acid
                                                AND entity_type = 'ACCNT'
                                                AND bank_id = lv_bank_id
                                                AND start_date <= lv_fromdate
                                                AND end_date >= lv_fromdate);
    EXCEPTION
        WHEN no_data_found THEN
            lv_int_code := '';
    END;

    BEGIN

    SELECT end_date
    INTO lv_expdateofrate
    FROM tbaadm.icv
    WHERE tbaadm.icv.bank_id = lv_bank_id
          AND nvl(del_flg,
                  'N') != 'Y'
          AND entity_cre_flg = 'Y'
          AND int_tbl_code = lv_int_code
          AND start_date <= lv_fromdate
          AND end_date >= lv_fromdate
          AND crncy_code = lv_crncy_code
          AND int_tbl_ver_num = (SELECT MAX(int_tbl_ver_num)
                                 FROM tbaadm.icv
                                 WHERE int_tbl_code = lv_int_code
                                       AND nvl(del_flg,
                                               'N') != 'Y'
                                       AND entity_cre_flg = 'Y'
                                       AND int_tbl_code = lv_int_code
                                       AND start_date <= lv_fromdate
                                       AND end_date >= lv_fromdate
                                       AND crncy_code = lv_crncy_code);
EXCEPTION
    WHEN no_data_found THEN
        lv_expdateofrate := to_date('01-01-2099',
                                    'DD-MM-YYYY');
     END;

        RETURN lv_expdateofrate;
        --}
END getexpdateofoldintrate;

--------------------------------------------------------------------------------
-- Function : getExpDateOfNewIntRate
-- Desc     :
--------------------------------------------------------------------------------

FUNCTION getExpDateOfNewIntRate(lv_acid in varchar2, lv_asondate in date,lv_fromdate in date, lv_todate in date,lv_bank_id in varchar2,lv_crncy_code in varchar2) RETURN DATE AS

    lv_expdateofrate DATE;
    lv_int_code      tbaadm.itc.int_tbl_code%TYPE;
    --{
BEGIN

    BEGIN
        SELECT int_tbl_code
        INTO lv_int_code
        FROM tbaadm.itc
        WHERE entity_id = lv_acid
              AND entity_type = 'ACCNT'
              AND bank_id = lv_bank_id
              AND start_date <= lv_todate
              AND end_date >= lv_todate
              AND int_tbl_code_srl_num = (SELECT MAX(int_tbl_code_srl_num)
                                          FROM tbaadm.itc
                                          WHERE entity_id = lv_acid
                                                AND entity_type = 'ACCNT'
                                                AND bank_id = lv_bank_id
                                                AND start_date <= lv_todate
                                                AND end_date >= lv_todate);
    EXCEPTION
        WHEN no_data_found THEN
            lv_int_code := '';
    END;


    BEGIN
    SELECT end_date
    INTO lv_expdateofrate
    FROM tbaadm.icv
    WHERE tbaadm.icv.bank_id = lv_bank_id
          AND nvl(del_flg,
                  'N') != 'Y'
          AND entity_cre_flg = 'Y'
          AND int_tbl_code = lv_int_code
          AND start_date <= lv_todate
          AND end_date >= lv_todate
          AND crncy_code = lv_crncy_code
          AND int_tbl_ver_num = (SELECT MAX(int_tbl_ver_num)
                                 FROM tbaadm.icv
                                 WHERE int_tbl_code = lv_int_code
                                       AND nvl(del_flg,
                                               'N') != 'Y'
                                       AND entity_cre_flg = 'Y'
                                       AND int_tbl_code = lv_int_code
                                       AND start_date <= lv_todate
                                       AND end_date >= lv_todate
                                       AND crncy_code = lv_crncy_code);
EXCEPTION
    WHEN no_data_found THEN
        lv_expdateofrate := to_date('01-01-2099',
                                    'DD-MM-YYYY');

     END;

        RETURN lv_expdateofrate;
 --}
 END getExpDateOfNewIntRate;


 -----------------------------------------------------------------------------------------------------
--FUNCTION getprovisionamountBetDatesDr
-----------------------------------------------------------------------------------------------------
FUNCTION getprovisionamountBetDatesDr(
         inp_cursor_acid IN tbaadm.gam.acid%type,
         inp_schm_code  IN tbaadm.gam.schm_code%type,
         startdate             IN date,
         enddate               IN date,
         inp_bank_id in varchar2) return number AS

lv_provision_amt tbaadm.gam.clr_bal_amt%TYPE;
lv_prov_cr_bacid tbaadm.AIP.PROV_CR_BACID%type;
lv_prov_cr_acid  tbaadm.gam.acid%TYPE;

Begin
-- Find the provision credit bacid that is set in GSPM.
    Begin
    Select  PROV_CR_BACID
    Into        lv_prov_cr_bacid
    from      tbaadm.AIP,tbaadm.ach
    Where  tbaadm.ach.b2k_id=inp_cursor_acid
        And tbaadm.AIP.b2k_type='ACCNT'
        And tbaadm.ach.b2k_type='ACCNT'
        And tbaadm.AIP.schm_code=inp_schm_code
--  Added the below 2 lines in the where clause--  by Praveena on Mar 2nd
        And tbaadm.ach.main_classification_user=tbaadm.AIP.main_asset_class
        And tbaadm.ach.sub_classification_user=tbaadm.AIP.sub_asset_class
        AND tbaadm.AIP.bank_id = inp_bank_id
        And srl_num = ( SELECT  MAX(srl_num)
                        FROM   tbaadm.ach
                        WHERE b2k_id=inp_cursor_acid
                            And  b2k_type='ACCNT'
                            AND bank_id = inp_bank_id
                            And  NVL(user_classification_date,system_classification_date) between startdate and enddate);
    Exception when no_data_found then
    lv_provision_amt:= 0;
    return lv_provision_amt;
    End;


    BEGIN
    SELECT  acid
    into    lv_prov_cr_acid
    from    tbaadm.gam
    where   bacid  = lv_prov_cr_bacid
    and     sol_id = (select sol_id from tbaadm.gam where acid = inp_cursor_acid AND bank_id = inp_bank_id)
    and     acct_crncy_code = (select acct_crncy_code from tbaadm.gam where acid = inp_cursor_acid AND bank_id = inp_bank_id)
    AND bank_id = inp_bank_id;
    Exception when no_data_found then
    lv_prov_cr_acid := '';
    END;

-- The sum od tran amounts of all credit part trans pertaining to provision
-- credit bacid.
    SELECT  nvl(sum(decode(part_tran_type,'D' ,tran_amt,'D',-tran_amt)),0)
    INTO      lv_provision_amt
    FROM   tbaadm.acpart
    WHERE b2k_type='ACCNT'
    AND                       b2k_id=inp_cursor_acid
    AND                       partitioned_acid= lv_prov_cr_acid
    AND                       part_tran_type='D'
    AND                       tran_date between startdate and enddate
    AND bank_id = inp_bank_id;

    Return lv_provision_amt;

End getprovisionamountBetDatesDr;


-----------------------------------------------------------------------------------------------------
--FUNCTION getprovisionamountBetDatesCr
-----------------------------------------------------------------------------------------------------
FUNCTION getprovisionamountBetDatesCr(
         inp_cursor_acid IN tbaadm.gam.acid%type,
         inp_schm_code  IN tbaadm.gam.schm_code%type,
         startdate             IN date,
         enddate               IN date,
         inp_bank_id in varchar2) return number as

lv_provision_amt tbaadm.gam.clr_bal_amt%TYPE;
lv_prov_cr_bacid tbaadm.AIP.PROV_CR_BACID%type;
lv_prov_cr_acid  tbaadm.gam.acid%TYPE;

Begin
-- Find the provision credit bacid that is set in GSPM.
    Begin
    Select  PROV_CR_BACID
    Into        lv_prov_cr_bacid
    from      tbaadm.AIP,tbaadm.ach
    Where  tbaadm.ach.b2k_id=inp_cursor_acid
        And tbaadm.AIP.b2k_type='ACCNT'
        And tbaadm.ach.b2k_type='ACCNT'
        And tbaadm.AIP.schm_code=inp_schm_code
--  Added the below 2 lines in the where clause--  by Praveena on Mar 2nd
        And tbaadm.ach.main_classification_user=tbaadm.AIP.main_asset_class
        And tbaadm.ach.sub_classification_user=tbaadm.AIP.sub_asset_class
        AND tbaadm.AIP.bank_id = inp_bank_id
        And srl_num = ( SELECT  MAX(srl_num)
                        FROM   tbaadm.ach
                        WHERE b2k_id=inp_cursor_acid
                            And  b2k_type='ACCNT'
                            AND bank_id = inp_bank_id
                            And  NVL(user_classification_date,system_classification_date) between startdate and enddate);
    Exception when no_data_found then
    lv_provision_amt:= 0;
    return lv_provision_amt;
    End;


    BEGIN
    SELECT  acid
    into    lv_prov_cr_acid
    from    tbaadm.gam
    where   bacid  = lv_prov_cr_bacid
    and     sol_id = (select sol_id from tbaadm.gam where acid = inp_cursor_acid AND bank_id = inp_bank_id)
    and     acct_crncy_code = (select acct_crncy_code from tbaadm.gam where acid = inp_cursor_acid AND bank_id = inp_bank_id)
    AND bank_id = inp_bank_id;
    Exception when no_data_found then
    lv_prov_cr_acid := '';
    END;

-- The sum od tran amounts of all credit part trans pertaining to provision
-- credit bacid.
    SELECT  nvl(sum(decode(part_tran_type,'C' ,tran_amt,'C',-tran_amt)),0)
    INTO      lv_provision_amt
    FROM   tbaadm.acpart
    WHERE b2k_type='ACCNT'
    AND                       b2k_id=inp_cursor_acid
    AND                       partitioned_acid= lv_prov_cr_acid
    AND                       part_tran_type='C'
    AND                       tran_date between startdate and enddate
    AND bank_id = inp_bank_id;



    Return lv_provision_amt;

End getprovisionamountBetDatesCr;

-----------------------------------------------------------------------------------------------------
--FUNCTION isNumeric
-----------------------------------------------------------------------------------------------------

FUNCTION isNumeric  (inp_string IN VARCHAR2) RETURN VARCHAR2 IS
  l_nv_err EXCEPTION;
  l_number NUMBER;
  l_result VARCHAR2(1) := 'N';
  PRAGMA EXCEPTION_INIT(l_nv_err, -6502);
BEGIN
  BEGIN
    l_number := TO_NUMBER(inp_string);
    l_result := 'Y';
  EXCEPTION
    WHEN invalid_number THEN
      l_result := 'N';
    WHEN l_nv_err THEN
      l_result := 'N';
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error in is_numeric: '||SQLERRM);
  END;
  --
  RETURN(l_result);
END isNumeric;

-----------------------------------------------------------------------------------------------------
--FUNCTION getDrIntRate_unverified
-----------------------------------------------------------------------------------------------------

FUNCTION getDrIntRate_unverified(v_acid  varchar2,
                v_balance NUMBER,
                v_as_on_date    DATE,
                v_bankId varchar2) RETURN NUMBER is
 outstanding_amount  number;

    lv_intrate          NUMBER;
    v_bal               NUMBER;
        lv_indType          VARCHAR2(20);
        lv_beginSlabAmt     VARCHAR2(20);
        lv_foundFlg         VARCHAR2(20);

BEGIN
--{
--  SELECT getEabBalanceFunc(v_acid,'NG',v_as_on_date)
--  into v_bal
--  from dual;
    v_bal := v_balance;

    dbms_output.put_line('balance:' || v_bal);
    /*CUSTOM_PACKINTEREST_UNVERIFIED.custom_getIntRate(v_as_on_date,
                                v_acid,
                                v_bal,
                                'D',
                                'N',
                                v_bankId,
                                lv_intrate,
                                lv_indType,
                                lv_beginSlabAmt,
                                lv_foundFlg );*/
    outstanding_amount := lv_intrate;
    RETURN outstanding_amount;
--}
END getDrIntRate_unverified;

-----------------------------------------------------------------------------------------------------
--FUNCTION loanschminterest
-----------------------------------------------------------------------------------------------------
FUNCTION loanschminterest(inp_inttblcode varchar2, inp_inttblversion varchar2,inp_slabdrcrflg varchar2, inp_bankId varchar2, loc_slabamtabs varchar2, inp_loan_period_mths varchar2, inp_loan_period_days varchar2, inp_crncycode varchar2)
return varchar2 is
    out_normalrate varchar2(10):=null;
begin
    begin
        SELECT TO_CHAR(nrml_int_pcnt)
        INTO out_normalrate
        FROM tbaadm.lavs
        WHERE int_tbl_code = inp_inttblcode
        AND int_tbl_ver_num = inp_inttblversion
        AND int_slab_dr_cr_flg = inp_slabdrcrflg
        AND bank_id = inp_bankId
        AND begin_slab_amount <= TO_NUMBER (loc_slabamtabs)
        AND TO_NUMBER (loc_slabamtabs) <= end_slab_amount
        AND (   (loan_tenor_mths != 0 AND (31 * loan_tenor_mths    + DECODE (loan_tenor_days, 999, 30, loan_tenor_days)) >= (31 * nvl(inp_loan_period_mths,0) + nvl(inp_loan_period_days,0)))
            OR (loan_tenor_mths = 0 AND loan_tenor_days >= ( 31 * nvl(inp_loan_period_mths,0) + nvl(inp_loan_period_days,0) ))
            )
        AND del_flg != 'Y'
        AND crncy_code = inp_crncycode
        AND entity_cre_flg = 'Y'
        --AND (nrml_portion_ind = 'D' OR penal_portion_ind = 'D')
        AND ROWNUM = 1;
        exception when no_data_found then
        out_normalrate :=  null;
    end;
RETURN out_normalrate;
end;

--------------------------------------------------------
--End of the Package
----------------------------------------------------
END CommonPackage;
/
show error
/

CREATE OR REPLACE SYNONYM custom.CommonPackage  for tbaadm.CommonPackage;
/
CREATE OR REPLACE SYNONYM TBAGEN.CommonPackage  for tbaadm.CommonPackage;
/
CREATE OR REPLACE SYNONYM TBAUTIL.CommonPackage  for tbaadm.CommonPackage;
/
GRANT EXECUTE,DEBUG ON tbaadm.CommonPackage  to TBAGEN,TBAUTIL,TBAADM,custom;
/

/**************************************************************************
 *                                                                        *
 * This file is generated from database please do not modify it manually. *
 *                                                                        *
 **************************************************************************/

rClickNameDS = new Array;
rClickURLDS = new Array;

function defTabs(){


}


function populateRClickViewDS(){

        rClickURLDS = new Array()


}


var myMenu = new Menu();
/****************************************Access Specific RCLOptions changes START*******************************************/
function loadRCLOptions(){	
var i=0;



 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('View'),"","","View",0,501);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Customer%20Profile'),"","showAccountDetails(decodeURIComponent('Customer%20Profile'),'../servlet/com.infy.cis.ui.wizards.SRMWizardWrapper?menuItemId=508&ScreenID=RCL9508&TabName=General Information&FormTitle=General Information&FormBaseURL=../servlet/com.infy.cis.ui.cif.RetCustBasicProfile')","AccountDetails",501,508);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Contacts'),"","showContacts(decodeURIComponent('Contacts'))","AccountContact",501,509);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Customer%20History'),"","activityHistory(decodeURIComponent('Customer%20History'),'../servlet/com.infy.cis.ui.common.ActivityHistory?menuItemId=513&ScreenID=RCL9513')","AccountHistory",501,513);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Applications'),"","showApplications(decodeURIComponent('Applications'),'ApplicationsForCustomer','RCL9711','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=711&Param2=null')","Applications",501,711);
myMenu.addSubMenuItem(i,"",decodeURIComponent('360%20Degree%20Summary'),"","showCustomerSummary(decodeURIComponent('360%20Degree%20Summary'),'../servlet/com.infy.cis.ui.admin.CustomerSummary?menuItemId=712&ScreenID=RCL9712&accountId=')","360DegreeSummary",501,712);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Campaigns'),"","showUrl(decodeURIComponent('Campaigns'),'CampaignsForCustomer','RCL9728','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=728')","Campaigns",501,728);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Basel%20Profiling'),"","showBaselProfiling(decodeURIComponent('Basel%20Profiling'),'../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=702292&ScreenID=RCL1011496&IsReadOnly=Y&isPopup=Yes&isBasel=Yes&boType=Main')","Basel Profiling",501,702292);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Audit%20Trail'),"","showAuditTrail(decodeURIComponent('Audit%20Trail'),'../servlet/com.infy.cis.ui.common.AuditTrailForm?menuItemId=898&ScreenID=RCL9898')","Audit Trail",501,898);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Related%20Entities'),"","relatedEntities(decodeURIComponent('Related%20Entities'))","Related Entities",501,560317);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Collateral%20Details'),"","ViewCustomerDocs(decodeURIComponent('Collateral%20Details'),'../servlet/com.infy.cis.ui.common.IntermediateLauncher?menuItemId=702275')","CollateralDetails",501,702275);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Document%20List'),"","ViewCustomerDocs(decodeURIComponent('Document%20List'),'../servlet/com.infy.cis.ui.common.IntermediateLauncher?menuItemId=702237')","DocumentList",501,702237);


// i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Customer%20Investment%20Accounts'),"","","CustomerInvestmentAccounts",0,7008480);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Mutual%20Funds'),"","showAccounts(decodeURIComponent('Mutual%20Funds'),'MutualfundsForCustomer','7','RCL9692','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=692&Param3=null')","MutualFunds",7008480,692);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Insurance'),"","showAccounts(decodeURIComponent('Insurance'),'InsuranceAccountsForCustomer','9','RCL9694','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=694&Param3=null')","Insurance",7008480,694);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Demat'),"","showAccounts(decodeURIComponent('Demat'),'DematsForCustomer','10','RCL9695','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=695&Param3=null')","Demat",7008480,695);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Investment%20Portfolios'),"","showAccounts(decodeURIComponent('Investment%20Portfolios'),'InvestmentPortfoliosForCustomer','11','RCL9570019','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=570019&Param3=null')","Investment Portfolios",7008480,570019);


 i=i+myMenu.addSeparator(i,"Separator",0,0);


 i=i+myMenu.addSeparator(i,"Separator",0,0);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Customer%20Accounts'),"","","CustomerAccounts",0,685);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Savings'),"","showAccounts(decodeURIComponent('Savings'),'SavingsAccountsForCustomer','1','RCL9686','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=686&Param3=null')","Savings",685,686);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Deposits'),"","showAccounts(decodeURIComponent('Deposits'),'DepositAccountsForCustomer','2','RCL9689','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=689&Param3=null')","Deposits",685,689);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Current'),"","showAccounts(decodeURIComponent('Current'),'CurrentAccountsForCustomer','3','RCL9688','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=688&Param3=null')","Current",685,688);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Credit%20Cards'),"","showAccounts(decodeURIComponent('Credit%20Cards'),'CreditcardsForCustomer','4','RCL9690','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=690&Param3=null')","Creditcards",685,690);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Loans'),"","showAccounts(decodeURIComponent('Loans'),'LoansForCustomer','6','RCL9691','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=691&Param3=null')","Loans",685,691);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Mutual%20Funds'),"","showAccounts(decodeURIComponent('Mutual%20Funds'),'MutualfundsForCustomer','7','RCL9692','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=692&Param3=null')","MutualFunds",685,692);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Others'),"","showAccounts(decodeURIComponent('Others'),'OtherInvestmentsForCustomer','8','RCL9693','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=693&Param3=null')","Others",685,693);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Insurance'),"","showAccounts(decodeURIComponent('Insurance'),'InsuranceAccountsForCustomer','9','RCL9694','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=694&Param3=null')","Insurance",685,694);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Demat'),"","showAccounts(decodeURIComponent('Demat'),'DematsForCustomer','10','RCL9695','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=695&Param3=null')","Demat",685,695);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Home%20Loans'),"","showAccounts(decodeURIComponent('Home%20Loans'),'HomeloansForCustomer','5','RCL91019','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=1019&Param3=null')","Home Loans",685,1019);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Investment%20Portfolios'),"","showAccounts(decodeURIComponent('Investment%20Portfolios'),'InvestmentPortfoliosForCustomer','11','RCL9570019','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=570019&Param3=null')","Investment Portfolios",685,570019);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Relationship%20Summary'),"","","RelationshipSummary",0,683);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Accounts%20Summary'),"","showAccountSumm(decodeURIComponent('Accounts%20Summary'),'../servlet/com.infy.cis.ui.admin.CustomerAccountsRelationship?menuItemId=684&ScreenID=RCL9684&IsReadOnly=Y&accountId=')","AccountsSummary",683,684);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Account%20Services'),"","showAccountServices(decodeURIComponent('Account%20Services'),'AcctServicesForCustomer','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=713&ScreenID=9713&Param2=null')","AccountServices",683,713);
myMenu.addSubMenuItem(i,"",decodeURIComponent('List%20of%20bill%20payments'),"","showBillPaymentList(decodeURIComponent('List%20of%20bill%20payments'),'../servlet/com.infy.cis.custom.OnlineListOfBillPayment?menuItemId=830&ScreenID=RCL9830&accountId=')","Listofbillpayments",683,830);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Back-end%20system%20IDs'),"","showAccountDet(decodeURIComponent('Back-End%20System%20Ids'),'../servlet/com.infy.cis.ui.admin.BackEndSystemIDs?menuItemId=717&ScreenID=RCL9717&IsReadOnly=Y&accountId=')","Back-EndSystemIds",683,717);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Reward%20Points'),"","showRewardPoints(decodeURIComponent('Reward%20Points'),'RewardPointsOfCustomer','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=729&ScreenID=RCL9729&Param2=RewardPoints&Param3=null')","RewardPoints",683,729);


 i=i+myMenu.addSeparator(i,"Separator",0,0);

//customization for disabling send email option starts
/*  i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Send%20Email'),"","","Send Email",0,1501);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Send%20Text%20Email'),"","composeTextEmail( '../servlet/com.infy.cis.ui.common.ComposeEmailForCIF?menuItemId=1502')","Send Text Email",1501,1502);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Send%20Html%20Email'),"","composeHTMLEmail_360( '../servlet/com.infy.cis.ui.common.ComposeEmailForCIF?menuItemId=1503')","Send Html Email",1501,1503); */
//customization for disabling send email option ends

 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Send%20Fax'),"","","Send Fax",0,1613);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Send%20Text%20Fax'),"","ComposeFax(decodeURIComponent('Send%20Text%20Fax'),'../servlet/com.infy.cis.ui.common.ComposeFax?menuItemId=1614')","Send Text Fax",1613,1614);

/* Changes by Elango to remove Micro edit option */
// i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Micro%20Edit'),"","","QuickEdit",0,570126);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Edit%20Address'),"","EditAddress(decodeURIComponent('Edit%20Address'),'../servlet/com.infy.cis.ui.cif.AddressDetWizard?menuItemId=570127&ScreenID=RCL9570127&isPopup=Yes&isDemo=Yes&boName=AccountBO&boType=Main&entityId=')","Address",570126,570127);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Edit%20Phone'),"","EditPhoneEmail(decodeURIComponent('Edit%20Phone'),'../servlet/com.infy.cis.ui.cif.PhoneEmailDetWizard?menuItemId=570128&ScreenID=RCL9570128&isPopup=Yes&isPsyco=Yes&boName=AccountBO&boType=Main&entityId=')","PhoneEmail",570126,570128);


document.onload = BuildPopupMenu();
document.oncontextmenu = doContextMenu;
}
updateAccessRCL(9);
/****************************************Access Specific RCLOptions changes END*********************************************/

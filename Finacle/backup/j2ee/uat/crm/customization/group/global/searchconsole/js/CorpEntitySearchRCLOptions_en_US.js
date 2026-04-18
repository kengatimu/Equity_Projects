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


        rClickNameDS[rClickNameDS.length] = decodeURIComponent('CampaignTarget');
        populate_showAccounts('SavingsAccountsForCorporate','1','RCL129560313','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560313&Param3=null');
        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Savings');
        populate_showAccounts('SavingsAccountsForCorporate','1','RCL129560313','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560313&Param3=null');

        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Home%20Loans');
        populate_showAccounts('HomeLoansForCorporate','5','RCL129560314','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560314&Param3=null');

        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Credit%20Cards');
        populate_showAccounts('CreditcardsForCorporate','4','RCL129560315','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560315&Param3=null');

}


var myMenu = new Menu();
/****************************************Access Specific RCLOptions changes START*******************************************/
function loadRCLOptions(){	
var i=0;



 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('View'),"","","View",0,560157);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Customer%20Profile'),"","entityProfile(decodeURIComponent('Customer%20Profile'),'../servlet/com.infy.cis.ui.wizards.SRMWizardWrapper?menuItemId=560159&ScreenID=RCL129560159&FormTitle=General Information&FormBaseURL=../servlet/com.infy.cis.ui.corpcif.CorpCustBasicProfile')","CustomerProfile",560157,560159);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Customer%20History'),"","activityHistory(decodeURIComponent('Customer%20History'),'../servlet/com.infy.cis.ui.common.ActivityHistory?menuItemId=560161&ScreenID=RCL129560161')","CustomerHistory",560157,560161);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Audit%20Trail'),"","showAuditTrail(decodeURIComponent('Audit%20Trail'),'../servlet/com.infy.cis.ui.common.AuditTrailForm?menuItemId=560163&ScreenID=RCL129560163')","Audit Trail",560157,560163);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Document%20List'),"","ViewCustomerDocs(decodeURIComponent('Document%20List'),'../servlet/com.infy.cis.ui.common.IntermediateLauncher?menuItemId=702234')","DocumentList",560157,702234);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Basel%20Profiling'),"","ViewBaselProfile(decodeURIComponent('Basel%20Profiling'),'../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=702295&IsReadOnly=Y&ScreenID=RCL1011496&isPopup=Yes&isBasel=Yes&loadTab=BaselProfiling&operationType=Copy')","Basel Profiling",560157,702295);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Related%20Entities'),"","relatedEntities(decodeURIComponent('Related%20Entities'),'../servlet/com.infy.cis.ui.corpcif.EntityRelation?menuItemId=560316','RCL9686')","Related Entities",560157,560316);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Send%20Fax'),"","","Send Fax",0,702227);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Send%20Text%20Fax'),"","ComposeFax(decodeURIComponent('Send%20Text%20Fax'),'../servlet/com.infy.cis.ui.common.ComposeFax?menuItemId=702229')","Send Text Fax",702227,702229);


 i=i+myMenu.addSeparator(i,"Separator",0,0);


 //i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Customer%20Investment%20Accounts'),"","","CustomerInvestmentAccounts",0,7008479);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Mutual%20Funds'),"","showAccounts(decodeURIComponent('Mutual%20Funds'),'MutualfundsForCorporate','7','RCL129560170','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560170&Param3=null')","MutualFunds",7008479,560170);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Insurance'),"","showAccounts(decodeURIComponent('Insurance'),'InsuranceAccountsForCorporate','9','RCL129560172','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560172&Param3=null')","Insurance",7008479,560172);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Demat'),"","showAccounts(decodeURIComponent('Demat'),'DematsForCorporate','10','RCL129560173','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560173&Param3=null')","Demat",7008479,560173);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Investment%20Portfolios'),"","showAccounts(decodeURIComponent('Investment%20Portfolios'),'InvestmentPortfoliosForCorporate','11','RCL129570020','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=570020&Param3=null')","Investment Portfolios",7008479,570020);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Customer%20Accounts'),"","","CustomerAccounts",0,560166);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Deposits'),"","showAccounts(decodeURIComponent('Deposits'),'DepositAccountsForCorporate','2','RCL129560167','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560167&Param3=null')","Deposits",560166,560167);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Loans'),"","showAccounts(decodeURIComponent('Loans'),'LoansForCorporate','6','RCL129560169','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560169&Param3=null')","Loans",560166,560169);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Mutual%20Funds'),"","showAccounts(decodeURIComponent('Mutual%20Funds'),'MutualfundsForCorporate','7','RCL129560170','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560170&Param3=null')","MutualFunds",560166,560170);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Others'),"","showAccounts(decodeURIComponent('Others'),'OtherInvestmentsForCorporate','8','RCL129560171','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560171&Param3=null')","Others",560166,560171);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Insurance'),"","showAccounts(decodeURIComponent('Insurance'),'InsuranceAccountsForCorporate','9','RCL129560172','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560172&Param3=null')","Insurance",560166,560172);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Demat'),"","showAccounts(decodeURIComponent('Demat'),'DematsForCorporate','10','RCL129560173','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560173&Param3=null')","Demat",560166,560173);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Investment%20Portfolios'),"","showAccounts(decodeURIComponent('Investment%20Portfolios'),'InvestmentPortfoliosForCorporate','11','RCL129570020','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=570020&Param3=null')","Investment Portfolios",560166,570020);
myMenu.addSubMenuItem(i,"",decodeURIComponent('CampaignTarget'),"","showAccounts(decodeURIComponent('CampaignTarget'),'SavingsAccountsForCorporate','1','RCL129560313','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560313&Param3=null')","Savings",560166,560313);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Savings'),"","showAccounts(decodeURIComponent('Savings'),'SavingsAccountsForCorporate','1','RCL129560313','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560313&Param3=null')","Savings",560166,560313);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Home%20Loans'),"","showAccounts(decodeURIComponent('Home%20Loans'),'HomeLoansForCorporate','5','RCL129560314','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560314&Param3=null')","Home Loans",560166,560314);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Credit%20Cards'),"","showAccounts(decodeURIComponent('Credit%20Cards'),'CreditcardsForCorporate','4','RCL129560315','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560315&Param3=null')","Credit Cards",560166,560315);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Relationship%20Summary'),"","","RelationshipSummary",0,560174);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Accounts%20Summary'),"","showAccountDet(decodeURIComponent('Accounts%20Summary'),'../servlet/com.infy.cis.ui.corpcif.CorpAccountsRelationship?menuItemId=560175&ScreenID=RCL129560175&IsReadOnly=Y&corpKey=')","AccountsSummary",560174,560175);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Back-end%20system%20IDs'),"","showAccountDetails(decodeURIComponent('Back-End%20System%20Ids'),'../servlet/com.infy.cis.ui.admin.BackEndSystemIDs?menuItemId=560177&ScreenID=RCL129560177&IsReadOnly=Y&accountId=')","Back-EndSystemIds",560174,560177);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Reward%20Points'),"","showRewardPoints(decodeURIComponent('Reward%20Points'),'RewardPointsOfCustomer','../servlet/com.infy.cis.ui.common.SRMCommonListServlet?menuItemId=560178&ScreenID=RCL129560178&Param2=RewardPoints&Param3=null')","RewardPoints",560174,560178);

/* Changes by Elango to remove Micro edit option */

 //i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Micro%20Edit'),"","","MicroEdit",0,570117);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Edit%20Address'),"","EditAddress(decodeURIComponent('Edit%20Address'),'../servlet/com.infy.cis.ui.corpcif.CorpAddressDetWizard?menuItemId=570118&ScreenID=RCL129570118&isPopup=Yes&isDemo=Yes')","Edit Address",570117,570118);
//myMenu.addSubMenuItem(i,"",decodeURIComponent('Edit%20Phone'),"","EditPhone(decodeURIComponent('Edit%20Phone'),'../servlet/com.infy.cis.ui.corpcif.CorpPhoneEmailDetWizard?menuItemId=570119&ScreenID=RCL129570119&isPopup=Yes')","Edit Phone",570117,570119);


document.onload = BuildPopupMenu();
document.oncontextmenu = doContextMenu;
}
updateAccessRCL(129);
/****************************************Access Specific RCLOptions changes END*********************************************/

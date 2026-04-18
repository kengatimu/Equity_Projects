/**************************************************************************
 *                                                                        *
 * This file is generated from database please do not modify it manually. *
 *                                                                        *
 **************************************************************************/

rClickNameDS = new Array;
rClickURLDS = new Array;

function defTabs(){

        def_showEntityInfo(decodeURIComponent('Entity%20Information%20Summary'),'../servlet/com.infy.cis.ui.common.allViews?menuItemId=1557&viewname=','ScreenID=RCL1191557');
        def_showProcessRelatedInfo(decodeURIComponent('Current%20Process%20Step'),'../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1558&tabName=Current Process Step');

}


function populateRClickViewDS(){

        rClickURLDS = new Array()


        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Entity%20Information%20Summary');
        populate_showEntityInfo('../servlet/com.infy.cis.ui.common.allViews?menuItemId=1557&viewname=','ScreenID=RCL1191557');

        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Current%20Process%20Step');
        populate_showProcessRelatedInfo('../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1558&tabName=Current Process Step');

}


var myMenu = new Menu();
/****************************************Access Specific RCLOptions changes START*******************************************/
function loadRCLOptions(){	
var i=0;



 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('View'),"","","View",0,1552);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Corporate%20Details'),"","copyRec( '../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=1556&ScreenID=RCL1191556&IsReadOnly=Y')","Corporate Information",1552,1556);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Entity%20Information%20Summary'),"","showEntityInfo(decodeURIComponent('Entity%20Information%20Summary'),'../servlet/com.infy.cis.ui.common.allViews?menuItemId=1557&viewname=','ScreenID=RCL1191557')","Entity Info",1552,1557);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Current%20Process%20Step'),"","showProcessRelatedInfo(decodeURIComponent('Current%20Process%20Step'),'../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1558&tabName=Current Process Step')","Current Process Step",1552,1558);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Activity%20History'),"","activityHistory(decodeURIComponent('Activity%20History'),'../servlet/com.infy.cis.ui.common.ActivityHistory?menuItemId=1559&ScreenID=RCL1191559')","Activity History",1552,1559);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Audit%20Trail'),"","showAuditTrail(decodeURIComponent('Audit%20Trail'),'../servlet/com.infy.cis.ui.common.AuditTrailForm?menuItemId=1560&ScreenID=RCL1191560')","Audit Trail",1552,1560);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Process%20Steps'),"","showProcessSteps(decodeURIComponent('Process%20Steps'),'../servlet/com.infy.cis.ui.common.ViewProcessSteps?menuItemId=1561')","Process Steps",1552,1561);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Escalation%20Log'),"","showEscalationLogs(decodeURIComponent('Escalation%20Log'),'../servlet/com.infy.cis.ui.common.EscalationLogWizard?menuItemId=570029&ScreenID=RCL119570029')","Escalation Log",1552,570029);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Basel%20Profiling'),"","copyRec( '../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=702285&IsReadOnly=Y&ScreenID=RCL1011496&isPopup=Yes&isBasel=Yes&loadTab=BaselProfiling&operationType=Queue')","Basel Profiling",1552,702285);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Edit'),"","","Edit",0,1553);
myMenu.addSubMenuItem(i,"",decodeURIComponent('General%20Details'),"","editDetails(decodeURIComponent('General%20Details'),'../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=1566&ScreenID=RCL1191566&loadTab=General&operationType=Queue')","General Details",1553,1566);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Preferences%20Details'),"","editDetails(decodeURIComponent('Preferences%20Details'),'../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=1568&ScreenID=RCL1191568&loadTab=Preferences&operationType=Queue')","Preferences Details",1553,1568);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Financial%20Details'),"","editDetails(decodeURIComponent('Financial%20Details'),'../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=1569&ScreenID=RCL1191569&loadTab=Financial&operationType=Queue')","Financial Details",1553,1569);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Trade%20Finance%20Details'),"","editDetails(decodeURIComponent('Trade%20Finance%20Details'),'../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=1571&ScreenID=RCL1191571&loadTab=TradeFinance&operationType=Queue')","Trade Finance Details",1553,1571);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Relationship%20Details'),"","editDetails(decodeURIComponent('Relationship%20Details'),'../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=560327&ScreenID=RCL119560327&loadTab=Relationship&operationType=Queue')","Relationship Details",1553,560327);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Last%20Edited%20Screen'),"","editLastEditedPage()","Last Edited Screen",1553,560345);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Basel%20Profiling'),"","editDetails(decodeURIComponent('Basel%20Profiling'),'../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?menuItemId=702286&ScreenID=RCL1221518&loadTab=BaselProfiling&operationType=Queue')","Basel Profiling",1553,702286);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('New'),"","","New",0,1554);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Process%20Error%20Activity'),"","createActivity(decodeURIComponent('Process%20Error%20Activity'),'../servlet/com.infy.cis.ui.sales.ActivityFormWizard?menuItemId=1565')","Process Error Activity",1554,1565);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Entity'),"","","Entity",0,1555);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Assign'),"","assignEntity(decodeURIComponent('Assign'),'../servlet/com.infy.cis.ui.corpcif.AssignModCorpDetWizard?menuItemId=1563&ScreenID=RCL1191563')","Assign Entity",1555,1563);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Transfer'),"","transferEntity(decodeURIComponent('Transfer'),'../servlet/com.infy.cis.ui.corpcif.TransferModCorpDetWizard?menuItemId=1564&ScreenID=RCL1191564')","Transfer Entity",1555,1564);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Delete'),"","deleteEntity(decodeURIComponent('Delete'),'../servlet/com.infy.cis.ui.common.DeleteModEntity?menuItemId=560332&EntityType=&entityId=')","Delete Entity",1555,560332);
myMenu.addSubMenuItem(i,"None",decodeURIComponent('Recall'),"","Recal('Recal To Self Tray', '/FinacleCRM/servlet/com.infy.cis.custom.EquityCorpBackToSelfTray?menuItemId=1552&ScreenID=RCL1011552')","Recall",1555,1552);


document.onload = BuildPopupMenu();
document.oncontextmenu = doContextMenu;
}
updateAccessRCL(119);
/****************************************Access Specific RCLOptions changes END*********************************************/

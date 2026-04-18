/**************************************************************************
 *                                                                        *
 * This file is generated from database please do not modify it manually. *
 *                                                                        *
 **************************************************************************/

rClickNameDS = new Array;
rClickURLDS = new Array;

function defTabs(){

        def_showEntityInfo(decodeURIComponent('Entity%20Information%20Summary'),'../servlet/com.infy.cis.ui.common.allViews?menuItemId=1205&viewname=','ScreenID=RCL1011205');
        def_showProcessRelatedInfo(decodeURIComponent('Current%20Process%20Step'),'../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1206&ScreenID=RCL1011206&tabName=Current Process Step&accountId=');

}


function populateRClickViewDS(){

        rClickURLDS = new Array()


        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Entity%20Information%20Summary');
        populate_showEntityInfo('../servlet/com.infy.cis.ui.common.allViews?menuItemId=1205&viewname=','ScreenID=RCL1011205');

        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Current%20Process%20Step');
        populate_showProcessRelatedInfo('../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1206&ScreenID=RCL1011206&tabName=Current Process Step&accountId=');

        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Activity%20History');
        populate_activityHistory('../servlet/com.infy.cis.ui.common.ActivityHistory?menuItemId=1207&ScreenID=RCL1011207');

}


var myMenu = new Menu();
/****************************************Access Specific RCLOptions changes START*******************************************/
function loadRCLOptions(){	
var i=0;



 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('View'),"","","View",0,1201);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Customer%20Details'),"","ViewEntity( 'Entity Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1204&ScreenID=RCL1011204&IsReadOnly=Y&boType=Mod&accountId=')","Entity Details",1201,1204);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Entity%20Information%20Summary'),"","showEntityInfo(decodeURIComponent('Entity%20Information%20Summary'),'../servlet/com.infy.cis.ui.common.allViews?menuItemId=1205&viewname=','ScreenID=RCL1011205')","Entity Info",1201,1205);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Current%20Process%20Step'),"","showProcessRelatedInfo(decodeURIComponent('Current%20Process%20Step'),'../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1206&ScreenID=RCL1011206&tabName=Current Process Step&accountId=')","Current Process Step",1201,1206);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Activity%20History'),"","activityHistory(decodeURIComponent('Activity%20History'),'../servlet/com.infy.cis.ui.common.ActivityHistory?menuItemId=1207&ScreenID=RCL1011207')","Activity History",1201,1207);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Audit%20Trail'),"","ShowAuditTrail( 'Audit Trail','../servlet/com.infy.cis.ui.common.AuditTrailForm?menuItemId=1208&ScreenID=RCL1011208')","Audit Trail",1201,1208);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Process%20Steps'),"","showProcessStepsRelatedInfo(decodeURIComponent('Process%20Steps'),'../servlet/com.infy.cis.ui.common.ViewProcessSteps?menuItemId=1209&ScreenID=RCL1011209&accountId=')","Process Steps",1201,1209);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Escalation%20Log'),"","showEscalationLogs(decodeURIComponent('Escalation%20Log'),'../servlet/com.infy.cis.ui.common.EscalationLogWizard?menuItemId=570021&ScreenID=RCL101570021')","Escalation Log",1201,570021);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Basel%20Profiling'),"","ViewEntity( 'Basel Profiling','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=702289&ScreenID=RCL1011496&isPopup=Yes&isBasel=Yes&boType=Mod&operationType=Queue&accountId=')","Basel Profiling",1201,702289);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Edit'),"","","Edit",0,1202);
myMenu.addSubMenuItem(i,"",decodeURIComponent('General%20Details'),"","EditAccount( 'General Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1210&ScreenID=RCL1011210&isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&accountId=')","General Details",1202,1210);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Demographic%20Details'),"","EditAccount( 'Demographic Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1211&ScreenID=RCL1011211&isPopup=Yes&isDemo=Yes&boType=Mod&operationType=Queue&accountId=')","Demographic Details",1202,1211);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Psychographic%20Details'),"","EditAccount( 'Psychographic Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1212&ScreenID=RCL1011212&isPopup=Yes&isPsyco=Yes&boType=Mod&operationType=Queue&accountId=')","Psychographic Details",1202,1212);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Other%20Bank%20Details'),"","EditAccount( 'Other Bank Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1213&ScreenID=RCL1011213&isPopup=Yes&isBank=Yes&boType=Mod&operationType=Queue&accountId=')","Other Bank Details",1202,1213);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Trade%20Finance%20Details'),"","EditAccount( 'Trade Finance Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1496&ScreenID=RCL1011496&isPopup=Yes&isTF=Yes&boType=Mod&operationType=Queue&accountId=')","Trade Finance Details",1202,1496);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Basel%20Profiling'),"","EditAccount( 'Basel Profiling','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=702290&ScreenID=RCL1011496&isPopup=Yes&isBasel=Yes&boType=Mod&operationType=Queue&accountId=')","Basel Profiling",1202,702290);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Last%20Edited%20Screen'),"","LastEditedPage()","Last Edited Screen",1202,560341);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Entity'),"","","Entity",0,1203);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Assign%20Entity'),"","assignEntity( 'Assign Entity','../servlet/com.infy.cis.ui.cif.AssignModEntityDetWizard?menuItemId=1476&ScreenID=RCL1011476')","Assign Entity",1203,1476);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Assign%20To%20Process%20Group'),"","assignEntityToGroup( 'Assign To Process Group','/FinacleCRM/servlet/com.infy.cis.ui.cif.BulkForwardEntityToGroup?menuItemId=1475&ScreenID=RCL1011475')","Assign To Process Group",1203,1475);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Transfer'),"","transferEntity( 'Transfer Entity','../servlet/com.infy.cis.ui.cif.AssignModEntityDetWizard?menuItemId=1477&ScreenID=RCL1011477')","Transfer Entity",1203,1477);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Delete'),"","deleteEntity(decodeURIComponent('Delete'),'../servlet/com.infy.cis.ui.common.DeleteModEntity?menuItemId=560328&ScreenID=RCL101560328&EntityType=Customer&accountId=')","Delete Entity",1203,560328);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Recall'),"","Recal('Recal To Self Tray', '/FinacleCRM/servlet/com.infy.cis.custom.EquityBackToSelfTray?menuItemId=1201&ScreenID=RCL1011201')","Recall",1203,1201);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('New'),"","","New",0,700500);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Process%20Error%20Activity'),"","createActivity(decodeURIComponent('Process%20Error%20Activity'),'../servlet/com.infy.cis.ui.cif.CIFActivityFormWizard?menuItemId=700501')","Process Error Activity",700500,700501);


document.onload = BuildPopupMenu();
document.oncontextmenu = doContextMenu;
}
updateAccessRCL(101);
/****************************************Access Specific RCLOptions changes END*********************************************/

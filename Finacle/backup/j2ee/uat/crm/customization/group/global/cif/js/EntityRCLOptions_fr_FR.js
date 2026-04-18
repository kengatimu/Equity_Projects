/**************************************************************************
 *                                                                        *
 * This file is generated from database please do not modify it manually. *
 *                                                                        *
 **************************************************************************/

rClickNameDS = new Array;
rClickURLDS = new Array;

function defTabs(){

        def_showEntityInfo(decodeURIComponent('R%C3%A9sum%C3%A9%20des%20Informations%20de%20l%27Entit%C3%A9'),'../servlet/com.infy.cis.ui.common.allViews?menuItemId=1205&viewname=','ScreenID=RCL1011205');
        def_showProcessRelatedInfo(decodeURIComponent('Etape%20Courante%20du%20Processus'),'../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1206&ScreenID=RCL1011206&tabName=Current Process Step&accountId=');

}


function populateRClickViewDS(){

        rClickURLDS = new Array()


        rClickNameDS[rClickNameDS.length] = decodeURIComponent('R%C3%A9sum%C3%A9%20des%20Informations%20de%20l%27Entit%C3%A9');
        populate_showEntityInfo('../servlet/com.infy.cis.ui.common.allViews?menuItemId=1205&viewname=','ScreenID=RCL1011205');

        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Etape%20Courante%20du%20Processus');
        populate_showProcessRelatedInfo('../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1206&ScreenID=RCL1011206&tabName=Current Process Step&accountId=');

        rClickNameDS[rClickNameDS.length] = decodeURIComponent('Historique%20de%20l%27Activit%C3%A9');
        populate_activityHistory('../servlet/com.infy.cis.ui.common.ActivityHistory?menuItemId=1207&ScreenID=RCL1011207');

}


var myMenu = new Menu();
/****************************************Access Specific RCLOptions changes START*******************************************/
function loadRCLOptions(){	
var i=0;



 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Afficher'),"","","View",0,1201);
myMenu.addSubMenuItem(i,"",decodeURIComponent('D%C3%A9tails%20du%20Client'),"","ViewEntity( 'Entity Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1204&ScreenID=RCL1011204&IsReadOnly=Y&boType=Mod&accountId=')","Entity Details",1201,1204);
myMenu.addSubMenuItem(i,"",decodeURIComponent('R%C3%A9sum%C3%A9%20des%20Informations%20de%20l%27Entit%C3%A9'),"","showEntityInfo(decodeURIComponent('R%C3%A9sum%C3%A9%20des%20Informations%20de%20l%27Entit%C3%A9'),'../servlet/com.infy.cis.ui.common.allViews?menuItemId=1205&viewname=','ScreenID=RCL1011205')","Entity Info",1201,1205);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Etape%20Courante%20du%20Processus'),"","showProcessRelatedInfo(decodeURIComponent('Etape%20Courante%20du%20Processus'),'../servlet/com.infy.cis.ui.common.ProcessSteps?menuItemId=1206&ScreenID=RCL1011206&tabName=Current Process Step&accountId=')","Current Process Step",1201,1206);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Historique%20de%20l%27Activit%C3%A9'),"","activityHistory(decodeURIComponent('Historique%20de%20l%27Activit%C3%A9'),'../servlet/com.infy.cis.ui.common.ActivityHistory?menuItemId=1207&ScreenID=RCL1011207')","Activity History",1201,1207);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Relev%C3%A9%20des%20Acc%C3%A8s'),"","ShowAuditTrail( 'Audit Trail','../servlet/com.infy.cis.ui.common.AuditTrailForm?menuItemId=1208&ScreenID=RCL1011208')","Audit Trail",1201,1208);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Etapes%20du%20Processus'),"","showProcessStepsRelatedInfo(decodeURIComponent('Etapes%20du%20Processus'),'../servlet/com.infy.cis.ui.common.ViewProcessSteps?menuItemId=1209&ScreenID=RCL1011209&accountId=')","Process Steps",1201,1209);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Log%20d%27Escalade'),"","showEscalationLogs(decodeURIComponent('Log%20d%27Escalade'),'../servlet/com.infy.cis.ui.common.EscalationLogWizard?menuItemId=570021&ScreenID=RCL101570021')","Escalation Log",1201,570021);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Profilage%20B%C3%A2le'),"","ViewEntity( 'Basel Profiling','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=702289&ScreenID=RCL1011496&isPopup=Yes&isBasel=Yes&boType=Mod&operationType=Queue&accountId=')","Basel Profiling",1201,702289);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('%C3%89diter'),"","","Edit",0,1202);
myMenu.addSubMenuItem(i,"",decodeURIComponent('D%C3%A9tails%20G%C3%A9n%C3%A9raux'),"","EditAccount( 'General Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1210&ScreenID=RCL1011210&isPopup=Yes&isGeneral=Yes&boType=Mod&operationType=Queue&accountId=')","General Details",1202,1210);
myMenu.addSubMenuItem(i,"",decodeURIComponent('D%C3%A9tails%20D%C3%A9mographiques'),"","EditAccount( 'Demographic Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1211&ScreenID=RCL1011211&isPopup=Yes&isDemo=Yes&boType=Mod&operationType=Queue&accountId=')","Demographic Details",1202,1211);
myMenu.addSubMenuItem(i,"",decodeURIComponent('D%C3%A9tails%20Psychographiques'),"","EditAccount( 'Psychographic Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1212&ScreenID=RCL1011212&isPopup=Yes&isPsyco=Yes&boType=Mod&operationType=Queue&accountId=')","Psychographic Details",1202,1212);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Autres%20D%C3%A9tails%20Bancaires'),"","EditAccount( 'Other Bank Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1213&ScreenID=RCL1011213&isPopup=Yes&isBank=Yes&boType=Mod&operationType=Queue&accountId=')","Other Bank Details",1202,1213);
myMenu.addSubMenuItem(i,"",decodeURIComponent('D%C3%A9tails%20du%20Trade%20Finance'),"","EditAccount( 'Trade Finance Details','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=1496&ScreenID=RCL1011496&isPopup=Yes&isTF=Yes&boType=Mod&operationType=Queue&accountId=')","Trade Finance Details",1202,1496);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Profilage%20B%C3%A2le'),"","EditAccount( 'Basel Profiling','../servlet/com.infy.cis.ui.cif.AccountDetWizard?menuItemId=702290&ScreenID=RCL1011496&isPopup=Yes&isBasel=Yes&boType=Mod&operationType=Queue&accountId=')","Basel Profiling",1202,702290);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Dernier%20%C3%89cran%20%C3%89dit%C3%A9'),"","LastEditedPage()","Last Edited Screen",1202,560341);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Entit%C3%A9'),"","","Entity",0,1203);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Affecter%20l%27Entit%C3%A9'),"","assignEntity( 'Assign Entity','../servlet/com.infy.cis.ui.cif.AssignModEntityDetWizard?menuItemId=1476&ScreenID=RCL1011476')","Assign Entity",1203,1476);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Transf%C3%A9rer'),"","transferEntity( 'Transfer Entity','../servlet/com.infy.cis.ui.cif.AssignModEntityDetWizard?menuItemId=1477&ScreenID=RCL1011477')","Transfer Entity",1203,1477);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Supprimer'),"","deleteEntity(decodeURIComponent('Supprimer'),'../servlet/com.infy.cis.ui.common.DeleteModEntity?menuItemId=560328&ScreenID=RCL101560328&EntityType=Customer&accountId=')","Delete Entity",1203,560328);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Recall'),"","Recal('Recal To Self Tray', '/FinacleCRM/servlet/com.infy.cis.custom.EquityBackToSelfTray?menuItemId=1201&ScreenID=RCL1011201')","Recall",1203,1201);


 i=i+myMenu.addMenuItem(i,"None",decodeURIComponent('Nouveau'),"","","New",0,700500);
myMenu.addSubMenuItem(i,"",decodeURIComponent('Traiter%20l%27Erreur%20de%20l%27Activit%C3%A9'),"","createActivity(decodeURIComponent('Traiter%20l%27Erreur%20de%20l%27Activit%C3%A9'),'../servlet/com.infy.cis.ui.cif.CIFActivityFormWizard?menuItemId=700501')","Process Error Activity",700500,700501);


document.onload = BuildPopupMenu();
document.oncontextmenu = doContextMenu;
}
updateAccessRCL(101);
/****************************************Access Specific RCLOptions changes END*********************************************/

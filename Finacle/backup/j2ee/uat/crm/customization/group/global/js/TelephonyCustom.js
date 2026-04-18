
function fnCustomReadUUI(applicationData) {
	return null;
	
	//If the Base product defined UUI is used, it should return null.
	//If it is customized, it should return an array according to below.
 	//strUUICCID = xmlarr[0]
	//strAFlag = xmlarr[1]
	//strObjType1 = xmlarr[2]
	//strObjID1 = xmlarr[3]
	//strCallID = xmlarr[4]
	//strPP = xmlarr[5]
	//strCallType = xmlarr[6]
	//strNotes = xmlarr[7]
	//strMenuHistory = xmlarr[8]
	//strObjType2 = xmlarr[9]
	//strObjID2 = xmlarr[10]
 
}  

function fnSetUUICallDataCustom(applicationData, CCID, ObjType,ObjID, PP, CRMCallID, AFlag, IntxnID, CallType, MenuHistory) {

	return null;
	
	//If the baseproduct uui is used, this function should return null. otherwise it should set the application data specific to the bank and return it. 


}

function fnAuthenticateCustom(EntityType, EntityID) {
	return false;
	//if the base product functionality of authentication is used, the function should return false, else any other value.
}

function fnCustomIVRTrailXSLPath(){
	return null;
	// will return the customised xsl file path
}

function fnCustomConvertMenuHistoryToXML(strMenuHist,strCustID,strCallID)
{
  return null;
  /*This function will convert the menuhistory to xml
    This will return an array eg . Menu
    Menu[0] = The XML to be returned
    Menu[1] = The Last Menu  Accessed
  */
}

function fnCustomConvertObjTypeUUIToCRM(ObjType)
{
  return null;
  // will return the obj type in CRM like '2' is 'AKY' etc.
}

function fnCustomConvertCallTypeUUIToCRM (callType) 
{
  return null;	
  //will return the Call type in CRM like '3' is 'BTX' etc.
}

/*This function return value will decide if customer screen-pop will 
be shown for object type AKY and account number, coming authenticated from IVR*/
function fnCallCustomerScreenPopForAccounts()
{
	return false;	//show the cutomer screen - pop for accounts
}
// this function should list the aux mode display text and correponding codes should be written in fnReturnAuxModeCustom
function aux(){

var auxmenu = new Array();;
//auxmenu[0] = "AUX 01";
//auxmenu[1] =  "Tea Break";

return auxmenu;
}

//this function if customised will return the aux modes
function fnReturnAuxModeCustom(strState){
 if (strState == "Lunch") return 1002;
 else if (strState == "Tea Break") return 1003;
 else
 return null	;


}
//function will return the new Value of strState if customised
function fnCustomSetAgentState(strState){
	return strState;
}

//function will decide if ScreenPop should be closed after hang-up
function fnIsScreenPopClosedAfterHangUp(){
	return false;
}

/*Tracker #73122 Begin Of Changes */
function fnDefaultTabForNotesScreen(){
	return null;
	//return values : Notes
	//				  IVRTrail
	//return("IVRTrail");

}
/*Tracker #73122 End Of Changes */

//function to confirm screenpop when eventdata has no UUI
function fnCustomIsScreenPopNeeded(){
	return null;
	//var name=confirm("Do You Need PopUp");

	//return name;
}



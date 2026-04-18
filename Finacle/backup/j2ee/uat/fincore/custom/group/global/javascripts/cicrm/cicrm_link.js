/* ErrObject defined in common function */
var err = new ErrObject();
var objForm = null;
var OPERATIVE_ACCT = "OPR"; 
function fnOnLoad(){
    objForm = document.forms[0];
    objForm.mode.focus();
	fnPopulateControlValues();
	if (menuType == INQUIRY){
        objForm.mode.value = INQUIRY;
        objForm.foracid.focus();
        document.title = finbranchResArr.get("FAT000896");
    	disableFields('mode');
	}
}
function fnOnFormSubmit(sAction){
    convertToCaps();        //convert to ucase
    disableButtons();
    disableHyperLnks(2);
    objForm.submitform.value = sAction;
    objForm.submit();
    return true;
}
function fnOnButtonClick(btnObj){
	enableFields('mode');
    if (btnObj.id == "Accept"){
          if (!validateTypes(objForm)) {
		   return false;
		  }
	  if(fnValidateMandatoryFields()){
          fnOnFormSubmit("Accept")
        }
    } 
        else if (btnObj.id == "Clear") {
		formReset(objForm);
    	fnOnFormSubmit("Clear")
	}
    return true;
}
function showSignature(){
    if (fnIsNull(objForm.foracid.value))     {
        alert(finbranchResArr.get("FAT000200"));
        document.forms[0].foracid.focus();
        return;
    }
    if (isFabAvbl == 'Y'){
        displaySignatureWindow(sGroupName,document.forms[0].foracid.value);
    }else{
        alert(finbranchResArr.get("FAT000248"));
        return;
    }
}
//ADDED FOR SVS INTEGRATION 
 function showFinacleSignature(){
  if(SVS_Flag != undefined  && SVS_Flag == "Y" ){
    showSVSSignature();
   }else{
    showSignature();
   }
}
 function showSVSSignature(){
        if (fnIsNull(objForm.foracid.value)) {
        alert(finbranchResArr.get("FAT000200"));
        objForm.foracid.focus();
        return;
        }
        var data = '?sAcctId='+escape(objForm.foracid.value)+'&sSolId='+escape(objForm.solId.value)+'&sActiveDate='+escape(bodDate)+'&fromAppId='+escape(fromAppId)+'&toMenu=hacm&contextSwitch=Y';
         displaySVSWindow(data);
}
function callbackSVS(data,menu)
{
// for SSO Context Switching
}
//modifications for svs integration ends
function fnAccountIDList(funcCode){
   if(funcCode.value  == "V" || funcCode.value  == "X"){
      var funcCode = funcCode.value;
	  showVerfyPendList("GAM",funcCode,"M",OPERATIVE_ACCT,"M","F",document.forms[0].foracid,"",""); 
   }else{
    	showAccountIdList(document.forms[0].foracid,document.forms[0].solId,document.forms[0].acctDesc,'F',document.forms[0].crncyCode);
    }
}
 function displaySignatureWindow(sGrpName,sAcctId) {
       window.open("../arjspmorph/"+applangcode+"/signature.jsp?acctId="+sAcctId,USERID+"_Signature","width=600, height=520,left=20,top=80,resizable=1,status=0,toolbar=0,scrollbars=1");
 }
function fetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType){
	var funcCode=document.forms[0].mode.value;
	if(funcCode == ""){
		alert(finbranchResArr.get("FAT002640"));
		fnSetFocusOnFirstField(objForm.mode);
		return false;
	}else{
		if(funcCode=="I"){
			if ((retVal = fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALACCTIDWITHCLSDFLG")) == false) {
				fnSetFocusOnFirstField(objForm.Cancel);
				return false;
			}
		} else {
			if ((retVal = fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID")) == false) {
				fnSetFocusOnFirstField(objForm.Cancel);
				return false;
			}
		}
	}
}

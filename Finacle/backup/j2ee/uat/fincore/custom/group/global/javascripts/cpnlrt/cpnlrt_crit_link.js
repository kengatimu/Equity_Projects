<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
    if (!fnCheckMandatoryFields()) {
        return false;
    }
    return true;
}

function fnCheckMandatoryFields(){
	var ObjForm = document.forms[0];
	var funcCode = ObjForm.funcCode.value;
	var levelType = ObjForm.levelType.value;
	var levelId = ObjForm.levelId.value;
	ObjForm.levelId.value = levelId.replace(/\s/g,'');
	
	if(funcCode==""){
		alert("Select the Function.");
		ObjForm.funcCode.focus();
		return false;
	}
	if(levelType==""){
		alert("Select the Level.");
		ObjForm.levelType.focus();
		return false;
	}
	if(ObjForm.levelId.value==""){
		alert("Enter the field Value.");
		ObjForm.levelId.focus();
		return false;
	}
	var retVal = fnValidateLevelId();
	if(!((retVal == undefined) ? true : false)){
		return false;
	}
	return true;
}

 function customClearFields(){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.selectedIndex = 0;
	ObjForm.levelType.selectedIndex = 0;
	ObjForm.levelId.value = "";
	fnShowLevelId();
} 

function fnShowLevelId() {
	hideImage("sLnk3");
    var ObjForm = document.forms[0];
    ObjForm.levelId.value = "";
    var levelType = ObjForm.levelType.value;
    if (levelType == "") {
        hideImage("levelIdCol1");
        hideImage("levelIdCol2");
    } 
	else 
	{
		switch (levelType){
			case 'A':
				var colName = "Account Id:";
				showImage("sLnk3");
				break;
			case 'C':
				var colName = "CIF Id:";
				break;
			case 'S':
				var colName = "Scheme Code:";
				break;
			default:
				var colName = "Level Id:";
		}
		showImage("levelIdCol1");
		document.getElementById('levelIdCol1').innerHTML = colName;
		showImage("levelIdCol2");
    }
}

function getLevelIdList(){
	var ObjForm = document.forms[0];
	var levelType = ObjForm.levelType.value;
	if(levelType == ""){
		alert("Select the Level");
		ObjForm.levelType.focus();
		return false;
	}
	if(levelType == "A"){
		showAccountIdList(ObjForm.levelId,null,null,'F');
	}
	if(levelType == "C"){
		var sUrl = "";
        var preceedence = 'B';
        var url = "../../finbranch/arjspmorph/";
		var cifObj = "ObjForm.levelId";
		sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+cifObj+"&wReturnDesc=NULL&preceedence="+preceedence;

		var retVal = popModalWindow(sUrl,"CifId");
		if ("Microsoft Internet Explorer" == browser_name)
		{
			if (retVal != null && retVal != undefined )
			{
				var liarrBufArray = retVal.split("|");
				ObjForm.levelId.value = liarrBufArray[0];
			}
		}
	}
	if(levelType == "S"){
		var id = '';
        var schm = "";
        var glSubHead="";
        var DummySchmType = "ODA";
        var DummyCrncy = "";
		var sol = "";
        var sUrl = "";
        var preceedence = 'B';
        var other = "NULL";
		var listWanted = "schmcode";
		sUrl = "../../finbranch/arjspmorph/"+applangcode+"/search_scheme.jsp?wReturn="+id+"&wReturnDesc=NULL&solId="+sol+"&listreqd="+listWanted+"&schmCode=&glSubHead=&other="+other+"&preceedence="+preceedence+"&schemeType="+DummySchmType+"&crncy="+DummyCrncy;
		
        var retVal = popModalWindow(sUrl,"SchemeCodes");
        if ("Microsoft Internet Explorer" == browser_name)
        {
            if (retVal != null && retVal != undefined)
			{
				var liarrBufArray = retVal.split("|");
				if (listWanted == "schmcode")
				{
					if(ObjForm.levelId != null) ObjForm.levelId.value = liarrBufArray[0];
				}
			}
        }
	}
}

function showAcctDetails() {
	var ObjForm = document.forms[0];
	if (fnIsNull(ObjForm.levelId.value)) {
		alert("Enter the Account Number");
		ObjForm.levelId.focus();
		return;
	}
	var sUrl = "../arjspmorph/"+applangcode+"/acctdtls.jsp?acctId="+ObjForm.levelId.value;
	popModalWindow(sUrl,"Acct Details");
}

function fnValidateLevelId(){
	var ObjForm = document.forms[0];
	var levelId = ObjForm.levelId.value;
	var fieldValue = levelId.replace(/\s/g,'');
	ObjForm.levelId.value=fieldValue.replace(",","");
	if (fnIsNull(ObjForm.levelId.value)){
		return;
	}
	var funcCode = ObjForm.funcCode.value;
	var levelType = ObjForm.levelType.value;
	if(levelType == ""){
		return;
	}
	var inputNameValues = "funcCode|"+funcCode+"|levelType|"+levelType+"|levelId|"+levelId;
	var outputNameValues = "errFlg|errMSg";
	var scriptName = "pnlValidateLevelId.scr";
	
	var retVal = appFnExecuteScript(inputNameValues, outputNameValues, scriptName, false);
	var result      = retVal.split("|");
	var errorFlg = result[1];
	var errorMsg = result[3];
	
	if(errorFlg=="Y"){
		alert(errorMsg);
		ObjForm.levelId.value="";
		ObjForm.levelId.focus();
		return false;
	}  
}

<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}




<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }


<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];

	return true;

}

function cacli_crit_onclick()
{
alert("click");


}

function fnShowAccNum()
{
 	var ObjForm = document.forms[0];
	var targetEntity = ObjForm.targetEntity.value;
	if(fnIsNull(targetEntity)){
		alert("Enter A/c. Entity ID to search other entity accounts");
		ObjForm.targetEntity.focus();
	}else{
		cust_showAccountIdList(document.forms[0].acctID,null,null,'F');
	}
       if(!fnIsNull(document.forms[0].acctID.value))
       	{
       		fnFetchAcctDtls();
	}
}

function cust_showAccountIdList(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId,searchLang,targetBankId,dispBankIDFldFlg){
/* Function modified to add input parameters to default in Account Id Criteria.
If these are not supplied, the list would continue working as before.
Note that the arguments.length <5 should be modified with care. */

        var sUrl = "";
        var preceedence = 'B';
        var strCrncyCode = "";
        var strSchemeCode = "";
        var strSchemeType = "";
        var strSolId = "";
        var strCifId = "";
        var strsearchLang = "";
        var strGLSubHead = "";
        var strOwnership = "";
        var strShortName = "";
        var strAcctLbl = "";
        var strPartn = "";
        var strSubmit = "";
        var strTargetBankId = "";
        var acctIdVal = "";

/* Assigning default if passed */
        if(acctObj.value != ""){acctIdVal = acctObj.value;}
        //if(targetBankId  == undefined){ strTargetBankId  = "";} else {strTargetBankId  = targetBankId.value;}
	strTargetBankId = document.forms[0].targetEntity.value;
    if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
    if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
    if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
    if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
    if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
    if(searchLang     == undefined){ strsearchLang = "";} else { strsearchLang = searchLang;}
    if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
    if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
//    if(defShortName  != undefined){ strShortName  = defShortName;}
    if(defAcctLbl    == undefined){ strAcctLbl  = "";} else { strAcctLbl  = defAcctLbl;}
    if(defPartn      == undefined){ strPartn = "";} else { strPartn = defPartn;}
        if(defMasterAcctId  == undefined){ strMasterAcctId  = "";} else { strMasterAcctId  = defMasterAcctId;}
        if(doAutoSubmit  == undefined){ strSubmit = "";} else { strSubmit = doAutoSubmit;}

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }
        if (arguments.length < 5)
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }else
        {
                sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+escape(strAcctLbl)+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }

                if ("Microsoft Internet Explorer" == browser_name)
                {
                     var retVal = popModalWindow(sUrl,"");
                if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");

                if(acctObj!=null) acctObj.value = liarrBufArray[0];
                        if(currDesc!=null) currDesc.value = liarrBufArray[1];
                        if(solId!=null) solId.value = liarrBufArray[2];
                        if(acctName!=null) acctName.value = liarrBufArray[3];
                }
                }else{
                            popModalWindowMozillaFrame(sUrl,"");
                }

}

function fnFetchAcctDtls(){
	var ObjForm = document.forms[0];
	var acctID = ObjForm.acctID.value;
	var inputNameValues = "acctID|"+acctID;
	var outputNames = "errorFlg|errorMsg|acctNumSolId|acctNumCcy|acctName|acctID|bankId|bankDesc";
	var scriptName = "caclidp001.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
	if(token != undefined){
		var errorFlg = token[1];
		var errorMsg = token[3];
		var acctNumSolId = token[5];
		var acctNumCcy = token[7];
		var acctName = token[9];
		var acctID = token[11];
		var bankId = token[13];
		var bankDesc = token[15];

		if(errorFlg == "Y"){
			alert(errorMsg);
			clearDescField('acctID','acctName','solId','crncyCode');
			setFieldFocus(ObjForm.acctID);
			return false;
			
		}else{
			ObjForm.crncyCode.value = acctNumCcy;
			ObjForm.solId.value = acctNumSolId;
			ObjForm.acctName.value = acctName;
			ObjForm.targetEntity.value = bankId;
			ObjForm.targetEntityDesc.value = bankDesc;

		}
	}
	return true;
}

function cacli_crit_pre_ONLOAD(obj)
{
	document.forms[0].targetEntityDesc.disabled = "true";
	return true;
}

function showEntityList(){
        var inputNameValues = "targetEntity| "
        var outputNameValues = "targetEntity|targetEntityDesc|targetEntityHomeCcy";
        var scriptName = "cietxndp019.scr";
        var listHeading = "Entity List";
        var colHeader = "Entity ID|Entity Description|Home Currency Code";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
        var ObjForm = document.forms[0];
        var targetEntity = ObjForm.targetEntity.value;

}

function showEntityDesc()
{

	var ObjForm = document.forms[0];
    var targetEntity = ObjForm.targetEntity.value;
	if(fnIsNull(targetEntity))
	{
		ObjForm.targetEntityDesc.value = "";
	}
	else
	{
        var inputNameValues = "targetEntity|"+targetEntity;
		var outputNames = "errorFlg|errorMsg|targetEntity|targetEntityDesc";
		var scriptName = "cietxndp018.scr"
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		var token = retVal.split("|");
		if(token != undefined)
		{
			var errorFlg = token[1];
			var errorMsg = token[3];
			var targetEntity = token[5];
			var targetEntityDesc = token[7];

			if(errorFlg == "Y"){
				alert(errorMsg);
				clearDescField('targetEntity');
				setFieldFocus(ObjForm.targetEntity);

				return false;
             }else{
                ObjForm.targetEntity.value = targetEntity;
				ObjForm.targetEntityDesc.value = targetEntityDesc;
              }
        }
	}
	return true;
}
function fnDefaultPopulation()
{
	document.forms[0].fromDate.value = BODDate;
	document.forms[0].toDate.value = BODDate;
	//document.forms[0].targetEntity.value = "54";
	//document.forms[0].targetEntityDesc.value = "EQUITY BANK LIMITED";
}


function cacli_crit_pre_ONCLICK(obj)

{
	if(obj.id == "Accept")
	{
		if(fnIsNull(document.forms[0].acctID.value))
		{
			alert(finbranchResArr.get("FAT000924"));
			document.forms[0].acctID.focus();
			return false;
		}
		if(document.forms[0].fromInstrumentNo.value > document.forms[0].toInstrumentNo.value)
		{ 
			alert("The from value cannot be greater than the to value");
			document.forms[0].toInstrumentNo.focus();
			return false;
		}
	
		if(document.forms[0].fromAmt.value != "")
		{ 
		var fromAmt = document.forms[0].fromAmt.value;
		fromAmt = fromAmt.replace(new RegExp(',','g'),"");
		document.forms[0].fromAmt.value = parseFloat(fromAmt,2);
		}

		if(document.forms[0].toAmt.value != "")
		{ 
		var toAmt = document.forms[0].toAmt.value;
		toAmt = toAmt.replace(new RegExp(',','g'),"");
		document.forms[0].toAmt.value = parseFloat(toAmt,2);
		}
	}
}

function fnvalidate_toAmt()
{
	
	if(document.forms[0].toAmt.value !="")
	{
		validateAmt(document.forms[0].toAmt);
		newformatAmt('MILLION',document.forms[0].toAmt,'','N');
	}
}
function fnvalidate_fromAmt()
{
	if(document.forms[0].fromAmt.value !="")
	{
		validateAmt(document.forms[0].fromAmt);
		newformatAmt('MILLION',document.forms[0].fromAmt,'','N');
	}
}

function validateAmt(obj)
{
	if((isNaN(obj.value)) || ((obj.value) < 0))
	{
		alert("Enter a numeric value or a valid amount.");
		obj.value="";
		obj.focus();
		return false;
	}	
}

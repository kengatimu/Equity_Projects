/**************************************************************************************
Function Name   :   post_ONLOAD()
Description     :   This Function is called on load of the page
**************************************************************************************/

function post_ONLOAD()
{
	if(document.forms[0].customData.value != "")
	{
		getFieldsFromCustomData("interEntityFlg","targetEntity","targetEntityAcctId");
	}

	if(document.forms[0].interEntityFlg.value=="Y")
	{
		document.forms[0].interEntity[0].checked = true;
	}
	else
	{
		document.forms[0].interEntity[1].checked = true;
	}

	if(document.forms[0].interEntity[0].checked == true)
        {
		document.forms[0].targetEntityAcctId.disabled = false;
                showImage("targetEntityAcctIdImg");
        }
        else
        {
		document.forms[0].targetEntityAcctId.disabled = true;
		hideImage("targetEntityAcctIdImg");
        }

	if(funcCode == "I" || funcCode == "V" || funcCode == "X")
        {
                document.forms[0].targetEntityAcctId.disabled = true;
                hideImage("targetEntityAcctIdImg");
        }

	document.forms[0].targetEntity.disabled = true;
	document.forms[0].targetAcctIdName.disabled = true;
	document.forms[0].targetAcctIdSolId.disabled = true;
	document.forms[0].targetAcctIdCcy.disabled = true;
	
	fnGetAcctDetails();

	return true;
}

/**************************************************************************************
Function Name   :   fnCheck()
Description     :   This Function is called to disable custom fields 
**************************************************************************************/

function fnCheck(obj)
{
	var ObjForm = document.forms[0];
	if(ObjForm.interEntity[0].checked == true)
	{
		ObjForm.targetEntityAcctId.disabled = false;
		ObjForm.interEntityFlg.value = "Y";
                showImage("targetEntityAcctIdImg");
	}
	else
	{
		ObjForm.targetEntityAcctId.disabled = true;
		ObjForm.interEntityFlg.value = "N";
                hideImage("targetEntityAcctIdImg");
		ObjForm.targetEntity.value = "";
		ObjForm.targetEntityDesc.value = "";
		ObjForm.targetEntityAcctId.value = "";
		ObjForm.targetAcctIdName.value = "";
		ObjForm.targetAcctIdSolId.value = "";
		ObjForm.targetAcctIdCcy.value = "";
		

	}
}

function issimdtl_pre_ONCLICK(obj)
{
	if(obj.id == "Submit" || obj.id == "Validate")
	{
		if(document.forms[0].interEntityFlg.value == "Y")
		{	
			var retVal = ""
			if ((retVal =  checkMandatoryFields()) == false) {
				return false;
			}

			if((retVal = fnValidateTargetEntity()) == false) {
				return false;
			}
			
			if((retVal = fnGetAcctDetails()) == false) {
				return false;
			}
			 
		}
	}
	setFieldsToCustomData("interEntityFlg","targetEntity","targetEntityAcctId");
	return true;
}

function issimdtl_post_ONCLICK(obj)
{
      setFieldsToCustomData("interEntityFlg","targetEntity","targetEntityAcctId");
      return true;
}

function issimdtl_pre_TAB_SWITCH()
{
	if(document.forms[0].interEntityFlg.value == "Y")
        {
                var retVal = ""
                if ((retVal =  checkMandatoryFields()) == false) {
                            return false;
                }

         	if((retVal = fnValidateTargetEntity()) == false) {
                            return false;
                }

                if((retVal = fnGetAcctDetails()) == false) {
                            return false;
                }

        }

        setFieldsToCustomData("interEntityFlg","targetEntity","targetEntityAcctId");
        return true;
}
	
/**************************************************************************************
Function Name   :   fnCheckMandatoryFields()
Description     :   This function is called to check mandatory fields
**************************************************************************************/
function checkMandatoryFields()
{
	var ObjForm = document.forms[0];
	if(fnIsNull(ObjForm.targetEntityAcctId.value))
        {
	        alert("Enter the Target Entity A/c ID");
		ObjForm.targetEntityAcctId.focus();
		return false;	
        }
return true;
}

function showEntityList(){
        var inputNameValues = "targetEntity| ";
        var outputNameValues = "targetEntity|targetEntityDesc|targetEntityHomeCcy";
        var scriptName = "siInterEntitydp001.scr";
        var listHeading = "Entity List";
        var colHeader = "Entity ID|Entity Description|Home Currency Code";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
        var ObjForm = document.forms[0];
        var targetEntity = ObjForm.targetEntity.value;
        if(!fnIsNull(targetEntity)){
                ObjForm.targetEntityAcctId.focus();
        }
}

function getAcctIdList() {
        var ObjForm = document.forms[0];
        var targetEntity = ObjForm.targetEntity.value;
	cust_showAccountIdList(ObjForm.targetEntityAcctId,null,null,'F');
        var targetEntityAcctId = ObjForm.targetEntityAcctId.value;
	if(!fnIsNull(targetEntityAcctId)){
		fnGetAcctDetails();
	}
}

function fnGetAcctDetails(){
        var ObjForm = document.forms[0];
        var targetEntityAcctId = ObjForm.targetEntityAcctId.value;
	if(fnIsNull(targetEntityAcctId)){
		ObjForm.targetEntity.value = "";
                ObjForm.targetEntityDesc.value = "";
                ObjForm.targetEntityAcctId.value = "";
		ObjForm.targetAcctIdSolId.value = "";
                ObjForm.targetAcctIdCcy.value = "";
                ObjForm.targetAcctIdName.value = "";
		return;
	}
        var inputNameValues = "acctNum|"+targetEntityAcctId;
        var outputNames = "errorFlg|errorMsg|acctNumEntityId|acctNum";
        var scriptName = "siInterEntitydp002.scr";
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var targetEntity = token[5];
		var targetEntityDesc = token[7];
                var targetAcctIdSolId = token[9];
                var targetAcctIdCcy = token[11];
                var targetAcctIdName = token[13];
                var targetEntityAcctId = token[15];

                if(errorFlg == "Y"){
                        alert(errorMsg);
                        setFieldFocus(ObjForm.targetEntityAcctId);
			return false;
		}
		ObjForm.targetEntity.value = targetEntity;
		ObjForm.targetEntityDesc.value = targetEntityDesc;
		ObjForm.targetEntityAcctId.value = targetEntityAcctId;
		ObjForm.targetAcctIdName.value = targetAcctIdName;
		ObjForm.targetAcctIdSolId.value = targetAcctIdSolId;
		ObjForm.targetAcctIdCcy.value = targetAcctIdCcy;
        }
        return true;
}

function fnValidateTargetEntity(obj)
{
	var retVal = "";
        var ObjForm = document.forms[0];
        var targetEntity = ObjForm.targetEntity.value;

                var inputNameValues = "targetEntity|"+targetEntity;
                var outputNames = "errorFlg|errorMsg";
                var scriptName = "siInterEntitydp010.scr"
                var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
                var token = retVal.split("|");
                if(token != undefined){
                        var errorFlg = token[1];
                        var errorMsg = token[3];
                        if(errorFlg == "Y"){
                                alert(errorMsg);
                                setFieldFocus(ObjForm.targetEntity);
                                return false;
                        }
                }
        return true;
}

//Show Account Id list js function

function cust_showAccountIdList(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,
defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId,searchLang,targetBankId,dispBankIDFldFlg){
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
	dispBankIDFldFlg = "Y";
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
 sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId= &defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
        }else
	        {
	 sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+
acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+
"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+
"&defShortName="+escape(strShortName)+"&defAcctLbl="+escape(strAcctLbl)+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
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

function fnValidateForm(sArg){
    var bIsPageEmpty = fnIsIssmiDetEmpty();
    if(funcCode == "A" || funcCode == "M" || funcCode == "C"){
        if(bIsPageEmpty && (sNewRecord == "true")){
            if (sArg != window[multiRecName].nextAction && sArg != window[multiRecName].addNewAction && sArg != 'Submit' && sArg != 'Validate'){
                return true;
            }
            if(templateMode != 'Y' && !fnValidateMandatoryFields(objForm) ) return false;
        }
        if(bIsPageEmpty && (sNewRecord == "false") ){
            showConfirmDialog(groupName);
            return true;
        }
        if (getAmtInFloat(objForm.mAmount.value) < 0) {
            alert(finbranchResArr.get("FAT000223"));
            objForm.mAmount.focus();
            return false;
        }
        if (getAmtInFloat(objForm.mVarAcctBal.value) < 0) {
            alert(finbranchResArr.get("FAT000223"));
            objForm.mVarAcctBal.focus();
            return false;
        }
        //Start - Change done for FC templates
        if((templateMode == "Y") && (templateFuncCode != "T")){
            if(!fnValidateForTemplateMode()){
                return false;
            }
            else{
                objForm.IsPageEmpty.value = bIsPageEmpty;
                return true;
            }
        }
        //End - Change done for FC templates
        if(objForm.mAmtType.value == 'S' && fnIsNull(objForm.mScriptName.value)){
            err.setErr(objForm.mAmount,finbranchResArr.get("FAT000200"));
            err.displayErr();
            objForm.mScriptName.focus();
            return false;
        }
        if(!fnIsNull(objForm.mAcctID.value) || !fnIsNull(objForm.mAmtType.value) || !fnIsNull(objForm.mRefCrncy.value)){
            if(fnIsNull(objForm.mAcctID.value) || fnIsNull(objForm.mAmtType.value) || fnIsNull(objForm.mRefCrncy.value)){
                err.setErr(objForm.mAcctID,finbranchResArr.get("FAT000400"));
                err.displayErr();
                return false;
            }
        }
        if(objForm.mAmtType.value == 'F' && fnIsNull(objForm.mAmount.value)){
            err.setErr(objForm.mAmount,finbranchResArr.get("FAT000200"));
            err.displayErr();
            return false;
        }
        if(objForm.mAmtType.value == 'T' && fnIsNull(objForm.mTblCode.value)){
            err.setErr(objForm.mTblCode,finbranchResArr.get("FAT000200"));
            err.displayErr();
            return false;
        }
        if(objForm.mAmtType.value == 'V'){
            if (fnIsNull(objForm.mVarAcctNum.value)) {
                err.setErr(objForm.mVarAcctNum,finbranchResArr.get("FAT000200"));
                err.displayErr();
                return false;
            }
            else if (fnIsNull(objForm.mVarAcctCrncy.value)) {
                err.setErr(objForm.mVarAcctNum,finbranchResArr.get("FAT000139"));
                err.displayErr();
                return false;
            }
        }
        if(objForm.mAmtType.value == 'T' && fnIsNull(objForm.mAmount.value) && fnIsNull(objForm.mTblCode.value)){
            err.setErr(objForm.mAmount,finbranchResArr.get("FAT000395"));
            err.displayErr();
            return false;
        }
        if((getAmtInFloat(objForm.mVarRndOffPcnt.value) > 0) && fnIsNull(objForm.mVarRndOffInd.value)){
            err.setErr(objForm.mVarRndOffInd,finbranchResArr.get("FAT000200"));
            err.displayErr();
            return false;
        }
        if (!fnIsNull(objForm.mAcctCrncy.value) && !fnIsNull(objForm.mRefCrncy.value)){
            if (objForm.mAcctCrncy.value.toUpperCase() != objForm.mRefCrncy.value.toUpperCase() && fnIsNull(objForm.mRateCode.value)) {
                err.setErr(objForm.mRateCode,finbranchResArr.get("FAT000200"));
                err.displayErr();
                return false;
            }
        }
        if (!validateTypes(objForm)) {
            return false;
        }
        var prec = getPrec(objForm.mRefCrncy.value);
        if (!fnValidateAmount(objForm.mAmount.value,prec)) {
            objForm.mAmount.focus();
            return false;
        }
        if(objForm.mAmtType.value == 'V'){
            prec = getPrec(objForm.mVarAcctCrncy.value);
            if (!fnValidateAmount(objForm.mVarAcctBal.value,prec)) {
                objForm.mVarAcctBal.focus();
                return false;
            }
            if (!fnValidateAmount(objForm.mVarRndOffPcnt.value,prec)) {
                objForm.mVarRndOffPcnt.focus();
                return false;
            }
        }
	
	setFieldsToCustomData("interEntityFlg","targetEntity","targetEntityAcctId");
    }
    disableHyperLnks(7);
    return true;
}



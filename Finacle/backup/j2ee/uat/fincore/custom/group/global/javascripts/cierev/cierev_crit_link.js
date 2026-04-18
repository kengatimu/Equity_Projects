function cierev_crit_post_ONLOAD(){
	var ObjForm = document.forms[0];
	ObjForm.funcCode.focus();
	return true;
}

function fnValidateData(){
	var ObjForm = document.forms[0];
	var funcCode= ObjForm.funcCode.value;
	var ieTxnRefNo = ObjForm.ieTxnRefNo.value;
	var tranDate = ObjForm.tranDate.value;

        if(ObjForm.funcCode.value == "")
        {
                alert("Select the Mandatory Field");
                ObjForm.funcCode.focus();
                return false;
        }

	if((funcCode == "I") || (funcCode == "R")){
		if(fnIsNull(ieTxnRefNo))
                {
                        alert("Enter the Transaction Ref No.");
                        ObjForm.ieTxnRefNo.focus();
                        return false;
                }

		if(fnIsNull(tranDate))
                {
                        alert("Enter the Transaction Date");
                        ObjForm.tranDate_ui.focus();
                        return false;
                }
        }

	if (funcCode == "R"){
		var inputNameValues = "ieTxnRefNo|"+ObjForm.ieTxnRefNo.value+"|tranDate|"+ObjForm.tranDate.value;
		var outputNames = "errorFlg|errorMsg";
		var scriptName = "cierevdp014.scr";
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");	
		if(token[1] == "Y"){
				alert(token[3]);
				ObjForm.ieTxnRefNo.focus();
				return false;
		}
	}

	if (!fnCheckMandatoryFields())
	{
		return false;
	}

	return true;
}

function fnOnChangeFuncCode(){

	var ObjForm = document.forms[0];
	var funcCode= ObjForm.funcCode.value;

	return;
}

function showInterEntityTranIdList(){
        var ObjForm = document.forms[0];
        var tranId = ObjForm.tranId.value;
        var tranDate = ObjForm.tranDate.value;
        var inputNameValues = "tranId|"+tranId+"|tranDate|"+tranDate;
        var outputNameValues = "tranId|tranDate|initEntity|chargeTransaction|targetEntity|targetEntityTransaction";
        var scriptName = "cietxndp030.scr";
        var listHeading = "Inter Entity Transaction ID List";
        var colHeader = "Tran ID|Tran Date|Init Entity ID|Charge Transaction|Target Entity ID|Target Entity Transaction";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
        ObjForm.tranDate_ui.value = ObjForm.tranDate.value;
        var tmp = ObjForm.tranDate_ui.value;
        if(!fnIsNull(tmp)){
                setFieldFocus(ObjForm.tranDate_ui);
        }
}

function showInterEntityTxnRefNoList(){
        var ObjForm = document.forms[0];
        var ieTxnRefNo = ObjForm.ieTxnRefNo.value;
        var tranDate = ObjForm.tranDate.value;
        var inputNameValues = "ieTxnRefNo|"+ieTxnRefNo+"|tranDate|"+tranDate;
        var outputNameValues = "ieTxnRefNo|tranDate|initEntity|targetEntity|txnType|txnTypeDesc";
        var scriptName = "cietxndp034.scr";
        var listHeading = "Inter Entity Transaction ID List";
        var colHeader = "Transaction Ref No.|Tran Date|Init Entity ID|Target Entity ID|Transaction Type|Description";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
        ObjForm.tranDate_ui.value = ObjForm.tranDate.value;
        var tmp = ObjForm.tranDate_ui.value;
        if(!fnIsNull(tmp)){
                setFieldFocus(ObjForm.tranDate_ui);
        }
}


/***************************************************
* This function is used to clear all the controls
* at the browser level.
****************************************************/
function fnClearFields(){
	var obj=document.forms[0];
	var len=obj.length;
	for(i=0;i<len;i++){
		if(obj[i].type == "text" || obj[i].type == "textarea"){
			var txtStr = obj[i].value;
			obj[i].value = "";
		}
		else if(obj[i].type == "select-one"){
			obj[i].options[0].selected ="true";
		}
		else if(obj[i].type == "radio"){
			obj[i].checked ="false";
		}
	}
	obj.actionCode.value = "Clear"; 
	obj.submit();
}

/*************************************************************
 * Function which validates blank entries and submits the form
 * if it is success.
 *************************************************************/
function fnValAndSubmit(btnObj){
	var ObjForm = document.forms[0];
	if(fnValidateData()){
		doSubmit(btnObj.id);
		return;
	}
}

/*********************************************************
 * 
 *
 ***********************************************************/


// Added for Testing Onload event
function postEventCall(pageName,currObj,event){

    var funcName="";

    //This is to call the application level customization functions.
    //which will be defined in finbranch/custom/javascripts/app_custom.js

    funcName="this.app_post_"+event;

        if(eval(funcName)!=undefined)
        if(!eval(funcName).call(this,currObj))  return false;

    //End of application level customization hook

    funcName="this.post_usrhk_"+event;
    if(eval(funcName)!=undefined)
        if(!eval(funcName).call(this,currObj))  return false;

    funcName="this." + pageName + "_post_"+event;

        if(eval(funcName)!=undefined){

//------------------------------------------------
        //Following Code is altered
//------------------------------------------------

        if(this.WF_IN_PROGRESS == "Y" || this.WF_IN_PROGRESS == "PEAS"){
            if(!eval(funcName).call(this,currObj))  {
                fnSetFocusOnFirstField_postonload();
                return true;
            }
        }

        else{

                if(!eval(funcName).call(this,currObj)) {
                        return false;
                }
                else{
                        fnSetFocusOnFirstField_postonload();
                }

                return true;
        }

     }
}

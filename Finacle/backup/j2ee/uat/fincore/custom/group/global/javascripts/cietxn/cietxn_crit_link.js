function cietxn_crit_post_ONLOAD(){
	var ObjForm = document.forms[0];
	if((funcCode == "A") || (funcCode == "")){
		hideImage("tranIdRow");
		hideImage("ieTxnRefNoRow");
		hideImage("tranDateRow");
	}

	if(funcCode == "I"){
		//ObjForm.txnType.value = "";
		//ObjForm.txnType.disabled = true;
	}
	ObjForm.funcCode.focus();
	return true;
}

function fnValidateData(){
	var ObjForm = document.forms[0];
	var funcCode= ObjForm.funcCode.value;
	var txnType = ObjForm.txnType.value;
	var ieTxnRefNo = ObjForm.ieTxnRefNo.value;
	var tranDate = ObjForm.tranDate.value;

        if(ObjForm.funcCode.value == "")
        {
                alert("Select the Function Code");
                ObjForm.funcCode.focus();
                return false;
        }

	if(funcCode == "A"){
		if(fnIsNull(txnType))
        	{
			alert("Select the Transaction Type");
			ObjForm.txnType.focus();
			return false;
        	}
	}

	if(funcCode == "I"){

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

	if (!fnCheckMandatoryFields())
	{
		return false;
	}

	return true;
}

function fnOnChangeFuncCode(){

	var ObjForm = document.forms[0];
	var funcCode= ObjForm.funcCode.value;

	if(funcCode == "A"){
		hideImage("ieTxnRefNoRow");
	        hideImage("tranDateRow");
		ObjForm.ieTxnRefNo.value = "";
		ObjForm.tranDate.value = "";
		ObjForm.tranDate_ui.value = "";
		ObjForm.txnType.disabled = false;
		ObjForm.txnType.focus();
	}

	if(funcCode == "I"){
		showImage("ieTxnRefNoRow");
                showImage("tranDateRow");
		//ObjForm.txnType.value = "";
		//ObjForm.txnType.disabled = true;
        }

	return;
}

function fnOnBlurIeTxnRefNo(){
	var ObjForm = document.forms[0];
	var ieTxnRefNo = ObjForm.ieTxnRefNo.value;

	if(fnIsNull(ieTxnRefNo)){
		return;
	}

	showInterEntityTxnRefNoList();

	var txnType = ObjForm.txnType.value;

	if(fnIsNull(txnType)){
		ObjForm.ieTxnRefNo.focus();
	}
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

/*************************************************************
 * Function which validates blank entries and submits the form
 * if it is success.
 *************************************************************/
function fnValAndSubmit(btnObj){
	var ObjForm = document.forms[0];
	var txnType = ObjForm.txnType.value;
	var funcCode = ObjForm.funcCode.value;
	if(fnValidateData()){
	    if(funcCode == "A"){

		if(txnType == "CD"){
			ObjForm.nextPage.value = "cietxn_det1.jsp";
			doSubmit(btnObj.id);
			return;
		}
		
		if(txnType == "CW"){
                        ObjForm.nextPage.value = "cietxn_det2.jsp";
                        doSubmit(btnObj.id);
                        return;
                }

		if(txnType == "TF"){
                        ObjForm.nextPage.value = "cietxn_det3.jsp";
                        doSubmit(btnObj.id);
                        return;
                }

		if(txnType == "RF"){
                        ObjForm.nextPage.value = "cietxn_det7.jsp";
                        doSubmit(btnObj.id);
                        return;
                }

		if(txnType == "PA"){
                        ObjForm.nextPage.value = "cietxn_det4.jsp";
                        doSubmit(btnObj.id);
                        return;
                }
	    }

	    if(funcCode == "I"){
		if(txnType != "PA"){
			ObjForm.nextPage.value = "cietxn_det5.jsp";
                        doSubmit(btnObj.id);
                        return;	
		}else{
			ObjForm.nextPage.value = "cietxn_det6.jsp";
                        doSubmit(btnObj.id);
                        return;
		}

	    }

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

function fnClearAllFields(){
	fnClearDateFields(tranDate);
	fnClearOtherFields();
	return true;
}

function fnClearOtherFields(){
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

function fnClearDateFields(dateObj){

    //clear the hidden field value
    dateObj.value = "";
    fnAssignUIDate(dateObj);    //Assign hidden field value to ui field.

}

function cietxn_crit_ONCHANGE1()
{
  		if(document.forms[0].txnType.value == "PA")
		{
			var ObjForm = document.forms[0];
  			var ieTxnRefNo = ObjForm.ieTxnRefNo.value;
			var inputNameValues = "ieTxnRefNo|"+ieTxnRefNo;
  			var outputNames = "errorFlg|errorMsg|ieTxnRefNo";
  			var scriptName = "cietxndp071.scr"
  			var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
  			var token = retVal.split("|");
  			if(token != undefined)
			{
          			var errorFlg = token[1];
          			var errorMsg = token[3];
          			var ieTxnRefNo = token[5];

          			if(errorFlg == "Y")
		  		{
                  			alert(errorMsg);
                  			setFieldFocus(ObjForm.ieTxnRefNo);
                  			return false;
          			}
		  		else
		  		{
                  			ObjForm.ieTxnRefNo.value = ieTxnRefNo;
					return true;
          			}
			}	
		}
}

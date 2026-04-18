function cieclg_crit_post_ONLOAD(){
	var ObjForm = document.forms[0];
	if((funcCode == "A") || (funcCode == "")){
		ObjForm.zoneCode.value = "";
		ObjForm.zoneDate_ui.value = "";
		ObjForm.zoneDate.value = "";
		ObjForm.setNum.value = "";
		ObjForm.setNum.disabled = true;
		hideImage("setNumImg");
		
		
		//--Start--Added for UBP
		checkRadio(document.forms[0].billPayYes,'N');
		document.forms[0].billerId.disabled = true;
		hideImage("billerIdSerch");
		document.forms[0].typOfServ.disabled = true;
		hideImage("typOfServiceSerchr");
				
		//--End--Added for UBP
	}

	ObjForm.funcCode.focus();
	ObjForm.zoneDate_ui.value = BODDate;
	ObjForm.zoneDate.value = BODDate;
	return true;
}

function fnValidateData(){
	var ObjForm = document.forms[0];
	var funcCode= ObjForm.funcCode.value;
	var zoneCode = ObjForm.zoneCode.value;
	var zoneDate = ObjForm.zoneDate.value;
	var setNum = ObjForm.setNum.value;

        if(ObjForm.funcCode.value == "")
        {
                alert("Select the Mandatory Field");
                ObjForm.funcCode.focus();
                return false;
        }

	if(funcCode == "A"){
		if(fnIsNull(zoneCode)){
                        alert("Enter the Zone Code");
			ObjForm.zoneCode.focus();
                        return false;
                }

                if(fnIsNull(zoneDate)){
                        alert("Enter the Zone Date");
			ObjForm.zoneDate_ui.focus();
                        return false;
                }
                //Added UBP change-start
                
                if(document.forms[0].billPayYes[0].checked==true)
		{
			if(document.forms[0].billerId.value == "")
			{
				alert("Enter Biller ID.");
				document.forms[0].billerId.focus();
				return false;
			}
					
			if((document.forms[0].valType.value == "R")||(document.forms[0].valType.value == "LR"))
			{
				if(document.forms[0].typOfServ.value == "")
				{
					alert("Enter Type of Service from searcher.");
					//document.forms[0].typOfServiceSerchr.focus();
					return false;
				}
			}
			if((funcCode == "A")&&(getRadioValue(document.forms[0].billPayYes)=="Y"))
			{
				if(document.forms[0].billerId.value=="KRA")
				{
							
					fnKraOutboundCallGoButton();
				}
			}
					//ubp end
		}
		//Added for UBP--END
                
        }

	if((funcCode == "M")||(funcCode == "V")||(funcCode == "D")||(funcCode == "R")||(funcCode == "I")||(funcCode == "O")){

		if(fnIsNull(zoneCode)){
                        alert("Enter the Zone Code");
			ObjForm.zoneCode.focus();
                        return false;
                }
	
		if(fnIsNull(zoneDate)){
                        alert("Enter the Zone Date");
			ObjForm.zoneDate_ui.focus();
                        return false;
                }

		if(fnIsNull(setNum)){
			alert("Set number is mandatory for this option.");
			ObjForm.setNum.focus();
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
	var funcCode = ObjForm.funcCode.value;

	if((funcCode == "A")||(funcCode == "")){
		ObjForm.setNum.value = "";
		ObjForm.setNum.disabled = true;
		hideImage("setNumImg");
		//--Start--Added for UBP
		document.forms[0].billerId.value="";
		document.forms[0].billerId.disabled = true;
		hideImage("billerIdSerch");
		document.forms[0].typOfServ.value="";
		document.forms[0].typOfServ.disabled = true;
		hideImage("typOfServiceSerchr");
		document.forms[0].critCrAcctNum.value="";
		document.forms[0].critCrAcctBnkId.value="";

		document.forms[0].billPayYes[0].disabled=false;
		document.forms[0].billPayYes[1].disabled=false;
		checkRadio(document.forms[0].billPayYes,'N');
						
		//--End--Added for UBP
	}

	if((funcCode == "M")||(funcCode == "V")||(funcCode == "D")||(funcCode == "R")||(funcCode == "I")||(funcCode == "O")){
		ObjForm.setNum.disabled = false;
		showImage("setNumImg");
		//--Start--Added for UBP
		document.forms[0].billerId.value="";
		document.forms[0].billerId.disabled = true;
		hideImage("billerIdSerch");
		document.forms[0].typOfServ.value="";
		document.forms[0].typOfServ.disabled = true;
		hideImage("typOfServiceSerchr");
		document.forms[0].critCrAcctNum.value="";
		document.forms[0].critCrAcctBnkId.value="";
		document.forms[0].billPayYes[0].disabled=true;
		document.forms[0].billPayYes[1].disabled=true;
		checkRadio(document.forms[0].billPayYes,'N');
				
		//--End--Added for UBP
        }

	return;
}

function fnShowZoneCode(obj1,obj2,sol) {
        showZoneCode(obj1,obj2,sol,"F");
}

function fnShowSetNumList(){
	var ObjForm = document.forms[0];
        var funcCode = ObjForm.funcCode.value;
        var zoneCode = ObjForm.zoneCode.value;
	var zoneDate = ObjForm.zoneDate.value;
        var setNum = ObjForm.setNum.value;

        var callScript = "N";

        if(fnIsNull(funcCode)){
                alert("Select the Function Code");
                ObjForm.funcCode.focus();
        }
        

        if(funcCode == "M"){
                if(fnIsNull(zoneCode)){
                        alert("Enter the Zone Code");
                        ObjForm.zoneCode.focus();
                }else if(fnIsNull(zoneDate)){
                        alert("Enter the Zone Date");
                        ObjForm.zoneDate_ui.focus();
                }else {
                        callScript = "Y";
                }
        }

        if(funcCode == "V"){
		if(fnIsNull(zoneDate)){
                        alert("Enter the Zone Date");
                        ObjForm.zoneDate_ui.focus();
                }else{
			callScript = "Y";
		}
        }

        if(funcCode == "R"){
                callScript = "Y";
        }

	if(funcCode == "I"){
                if(fnIsNull(zoneCode)){
                        alert("Enter the Zone Code");
                        ObjForm.zoneCode.focus();
                }else if(fnIsNull(zoneDate)){
                        alert("Enter the Zone Date");
                        ObjForm.zoneDate_ui.focus();
                }else {
                        callScript = "Y";
                }
        }

	if(funcCode == "D"){
                if(fnIsNull(zoneCode)){
                        alert("Enter the Zone Code");
                        ObjForm.zoneCode.focus();
                }else if(fnIsNull(zoneDate)){
                        alert("Enter the Zone Date");
                        ObjForm.zoneDate_ui.focus();
                }else {
                        callScript = "Y";
                }
        }

	if(funcCode == "O"){
                if(fnIsNull(zoneCode)){
                        alert("Enter the Zone Code");
                        ObjForm.zoneCode.focus();
                }else if(fnIsNull(zoneDate)){
                        alert("Enter the Zone Date");
                        ObjForm.zoneDate_ui.focus();
                }else {
                        callScript = "Y";
                }
        }

	if(callScript == "Y"){
                var inputNameValues = "funcCode|"+funcCode+"|zoneCode|"+zoneCode+"|zoneDate|"+zoneDate+"|setNum|"+setNum;
                var outputNameValues = "setNum|zoneCode|zoneDate|status";
                var scriptName = "cieclgdp006.scr";
                var listHeading = "Inter Entity Clearing List";
                var colHeader = "Set No.|Zone Code|Zone Date|Status";
                var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
                //ubp add-start
                
		fnOnChangeSetNum();
        	//ubp add-end
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
	var funcCode = ObjForm.funcCode.value;
	if(fnValidateData()){
		if((funcCode == "A")||(funcCode == "M")||(funcCode == "V")||(funcCode == "D")||(funcCode == "R")||(funcCode == "I")||(funcCode == "O")){
                        ObjForm.nextPage.value = "cieclg_det1.jsp";
                        doSubmit(btnObj.id);
                        return;
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


//Added for UBP customization-start
function fnOnClickBillPay()
{
	var ObjForm = document.forms[0];
	var billPayYes1=ObjForm.billPayYes[0].checked;
	var billPayYes2=ObjForm.billPayYes[1].checked;
	var billPayYesClick;
	if(billPayYes1== true)
	{
		billPayYesClick="Y";
		document.forms[0].billerId.disabled = false;
		showImage("billerIdSerch");
		document.forms[0].typOfServ.disabled = true;
		showImage("typOfServiceSerchr");
		
		
	}
	else
	{
		billPayYesClick="N";
		document.forms[0].billerId.disabled = true;
		hideImage("billerIdSerch");
		document.forms[0].typOfServ.disabled = true;
		hideImage("typOfServiceSerchr");
		document.forms[0].billerId.value="";
		document.forms[0].typOfServ.value="";
		
		
	}
}

function fnOnblurBillerId()
{
	var ObjForm = document.forms[0];
	var billerId=ObjForm.billerId.value;
	ObjForm.typOfServ.value="";
	
	if(!fnIsNull(billerId))
	{
		var inputNameValues = "billerId|"+billerId;
		//var outputNames = "errorFlg|errorMsg|billAcctId|billerCode|valType";
		var outputNames = "errorFlg|errorMsg|critCrAcctNum|critCrAcctBnkId|valType";
		var scriptName = "ubpdp068.scr";
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		//alert(retVal);
		if(retVal != undefined)
		{
			var token = retVal.split("|");
			var errorFlg = token[1];
			var errorMsg = token[3];
			//alert(ObjForm.billAcctId.value);
  
			if(errorFlg == "Y")
			{
				alert(errorMsg);
				ObjForm.billerId.focus();
				return false;
      
			}
			else
			{
				
				ObjForm.critCrAcctNum.value=token[5];
				//ObjForm.critCrAcctNum.disabled=true;
				ObjForm.critCrAcctBnkId.value=token[7];
				ObjForm.valType.value=token[9];
				
				
			}
		}
	}
	else
	{
		//ObjForm.critCrAcctNum.value="";
		ObjForm.typOfServ.value="";
		//ObjForm.critCrAcctNum.disabled=false;
	}
}

//biller Id field searcher
function fnBillerId()
{
	var inputNameValues = "";
	var outputNameValues = "billerId|critCrAcctNum|critCrAcctBnkId|valType";
	var scriptName = "ubpdp067.scr";
	var listHeading = "Biller ID";
	var colHeader = "BILLER ID|A/c ID|Bank ID|Validation Type";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
	
	var ObjForm = document.forms[0];
	ObjForm.typOfServ.value="";
	
}

function fnTypOfServ()
{
		
		var ObjForm = document.forms[0];
		
		var billerId=ObjForm.billerId.value;
		var valType=ObjForm.valType.value;
		//alert("valType"+valType);
		//if(fnIsNull(billerId))
		if(billerId=="")
		{
			alert("Please enter Biller ID");
			ObjForm.billerId.focus();
			//return false;
		}
		
		if(billerId!="")
		{
			if(valType=="L")
			{
				alert("For Local Validation Type of Service will not be selected.");
				ObjForm.billerId.focus();
				//return false;
			}
			else
			{
				var inputNameValues = "billerId|"+billerId+"|valType|"+valType;
				var outputNameValues = "typOfServ";
				var scriptName = "ubpdp058.scr";
				var listHeading = "Types Of Service linked to Biller";
				var colHeader = "Type of Service";
				var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true);
				
			}
		}
}


function fnKraOutboundCallGoButton()
{
	var ObjForm = document.forms[0];
	var billerId=ObjForm.billerId.value;
	var inputNameValues = "billerId|"+billerId;
	var outputNames = "errorFlg|errorMsg|billAcctId|billerCode|valType";
	var scriptName = "ubpdp025.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	//alert(retVal);
	if(retVal != undefined)
	{
		var token = retVal.split("|");
		var errorFlg = token[1];
		var errorMsg = token[3];
		//alert(ObjForm.billAcctId.value);
    
		if(errorFlg == "Y")
		{
			alert(errorMsg);
			ObjForm.billerId.focus();
			return false;
        
		}
		else
		{
			//alert(ObjForm.billAcctId.value);
			//ObjForm.billAcctId.value=token[5];
			
			ObjForm.billerCode.value=token[7];
			//ObjForm.valType.value=token[9];
		}
	}
}

function fnOnChangeSetNum()
{
	

	var ObjForm = document.forms[0];
	document.forms[0].billerId.value="";
	document.forms[0].typOfServ.value="";
	document.forms[0].critCrAcctNum.value="";
	document.forms[0].critCrAcctBnkId.value="";
	if(fnIsNull(document.forms[0].zoneCode.value))
	{
	        alert("Enter the Zone Code");
	        document.forms[0].setNum.value="";
	        ObjForm.zoneCode.focus();
	 }
	 else
	 {
	var inputNameValues = "zoneCode|"+ document.forms[0].zoneCode.value + "|setNum|"+ document.forms[0].setNum.value+ "|zoneDate|"+ document.forms[0].zoneDate.value;
	var outputNames = "errorFlg|errorMsg|billPayYes|billAcctId|billerCode|valType|critCrAcctNum|critCrAcctBnkId";
	var scriptName = "ubpdp070.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
	//alert(retVal);
	if(retVal != undefined)
	{
		var token = retVal.split("|");
		var errorFlg = token[1];
		var errorMsg = token[3];
		if(errorFlg == "Y")
		{
			alert(errorMsg);
			ObjForm.billerId.focus();
			return false;

		}
		else
		{
			//alert(ObjForm.billAcctId.value);
			var billPayYes=token[5];
			if(billPayYes=="Y")
			{
				checkRadio(document.forms[0].billPayYes,'Y');
				document.forms[0].billPayYes[0].disabled = true;
				document.forms[0].billPayYes[1].disabled = true;
				document.forms[0].billerId.value=token[7];
				document.forms[0].typOfServ.value=token[9];
				document.forms[0].valType.value=token[11];
				document.forms[0].critCrAcctNum.value=token[13];
				document.forms[0].critCrAcctBnkId.value=token[15];
				document.forms[0].billerId.disabled=true;
				hideImage("billerIdSerch");
				document.forms[0].typOfServ.disabled = true;
				hideImage("typOfServiceSerchr");
			
			}
			else
			{
			
				checkRadio(document.forms[0].billPayYes,'N');
				document.forms[0].billPayYes[0].disabled = true;
				document.forms[0].billPayYes[1].disabled = true;
				document.forms[0].billerId.value="";
				document.forms[0].typOfServ.value="";
				document.forms[0].valType.value="";
				document.forms[0].critCrAcctNum.value="";
				document.forms[0].critCrAcctBnkId.value="";
				document.forms[0].billerId.disabled=true;
				hideImage("billerIdSerch");
				document.forms[0].typOfServ.disabled = true;
				hideImage("typOfServiceSerchr");
			
			}
			
		}
	}
    }//added
}
//Added for UBP customization-end

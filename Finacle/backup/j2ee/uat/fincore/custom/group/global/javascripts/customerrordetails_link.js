function printBlock()
{
	writeCustomHeader("customerrordetails");
	with (document){
	write('<tr>');
	write('<td>');
	write('<table class="table" border="0" cellspacing="0" cellpadding="0" width="100%">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="errortableborder">');
	write('<tr>');
	write('<td class="alert" colspan="3">Error Details</td>');
	write('</tr>');
	write('' + sbErrBuffer + '');
	write('</table>');
	write('</td></tr></table>');
	write('</td></tr></table>');
	write('</td></tr></table>');
	write('</td></tr></table>');
	if(sPopUpExceptionWindow=="true"){
	write('<table class="buttonPanel" width="100%" border="0" align="center">');
	write('<tr>');
	write('<td align="center">');
	write('<input type="button" class="button" maxlength="10" name="Submit" value="Submit" id="Submit" onClick=\'javascript:return customerrordetails_ONCLICK1(this,this);\' hotKeyId="Submit">&nbsp;');
	write('</td>');
	write('</tr>');
	write('</table>');
	} //End with()	
 } //End function
}
function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('customerrordetails',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('customerrordetails',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

}

function customerrordetails_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('customerrordetails',obj,"ONCLICK") == false) { 
		return false;
	}
	if ((retVal = fnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCall('customerrordetails',obj,"ONCLICK") == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnButtonClick(objBtn)
{
	var ObjForm = document.forms[0];
	disableButtons();	
	ObjForm.actionCode.value=objBtn.id;
	ObjForm.submit();
}

function onErrClick(sTabName){
	if(sTabName!='')
	{
		for (var i=0; i<ancCount; i++) 
		{
  	  hideAnc("anc" + (i+1));
  	}		
		
		document.forms[0].actionCode.value="GotoTab";
		document.forms[0].tabName.value=sTabName;
		fnEnableFormDataControls(document.forms[0]);
		document.forms[0].submit();
	}
}

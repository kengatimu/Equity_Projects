function printBlock()
{
	writeCustomHeader("calert_det");
	with (document){
	write('<input type="hidden" id="RecVerifyType" name="' + subGroupName + '.RecVerifyType">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	//write('<td class="page-heading">' + jspResArr.get("FLT031877") + '</td>');
	write('<td class="page-heading">'+menuTitle+'</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	funcCodeDesc = "";
	if(funcCode == "R")
	{
		funcCodeDesc = "Register";
	}
	if(funcCode == "M")
	{
		funcCodeDesc = "Modify";
	}
	if(funcCode == "I")
	{
		funcCodeDesc = "Inquire";
	}
	if(funcCode == "X")
	{
		funcCodeDesc = "Cancel";
	}
	if(funcCode == "V")
	{
		funcCodeDesc = "Verify";
	}
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCodeDesc + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfielddisplaylabel"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031874") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + cifId + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031859") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + accNo + '</label>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<br />');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="3" class="subhdr">' + jspResArr.get("FLT031878") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031874") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custId" id="custId" readonly fdt="String" ' + calertProps.get("custId_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT147999") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custName" id="custName" readonly fdt="String" ' + calertProps.get("custName_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031879") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custBranch" id="custBranch" readonly fdt="String" ' + calertProps.get("custBranch_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT003837") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custConst" id="custConst" readonly fdt="String" ' + calertProps.get("custConst_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="3" class="subhdr">' + jspResArr.get("FLT031880") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031859") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accNum" id="accNum" readonly fdt="String" ' + calertProps.get("accNum_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031881") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accCrncy" id="accCrncy" readonly fdt="String" ' + calertProps.get("accCrncy_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT030541") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accName" id="accName" readonly fdt="String" ' + calertProps.get("accName_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031882") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accBranch" id="accBranch" readonly fdt="String" ' + calertProps.get("accBranch_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031883") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accScheme" id="accScheme" readonly fdt="String" ' + calertProps.get("accScheme_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT041910") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.accStatus" id="accStatus" readonly fdt="String" ' + calertProps.get("accStatus_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031884") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.modeOfOper" id="modeOfOper" readonly fdt="String" ' + calertProps.get("modeOfOper_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield"></td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="3" class="subhdr">' + jspResArr.get("FLT031942") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031943") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search1" type="text" disabled class="textfieldfont" name="' + subGroupName + '.chrgAcc" id="chrgAcc" fdt="String" ' + calertProps.get("chrgAcc_ENABLED") + '>');
	write('&nbsp;<a id="sLnk2" href="javascript:accountSearcher();">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031944") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" disabled class="textfieldfont" name="' + subGroupName + '.chrgAccCrncy" id="chrgAccCrncy" fdt="String" ' + calertProps.get("chrgAccCrncy_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031945") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.drAlerts" id="drAlerts" style="width: 218px" fdt="String" ' + calertProps.get("drAlerts_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
	write('<option value="Y">' + jspResArr.get("FLT012405") + '</option>');
	write('<option value="N">' + jspResArr.get("FLT013286") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031946") + '</td>');
	write('<td class="textfield">');
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.minDrAmt" id="minDrAmt" onBlur="javascript:return calert_det_ONBLUR6(this,\'MILLION\',this,\'\',\'N\');" style="TEXT-ALIGN:right" fdt="String" ' + calertProps.get("minDrAmt_ENABLED") + '>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.minDrAmt" id="minDrAmt" onBlur="javascript:return calert_det_ONBLUR6(this,this);" style="TEXT-ALIGN:right" fdt="String" ' + calertProps.get("minDrAmt_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031947") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.crAlerts" id="crAlerts" style="width: 218px" fdt="String" ' + calertProps.get("crAlerts_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
	write('<option value="Y">' + jspResArr.get("FLT012405") + '</option>');
	write('<option value="N">' + jspResArr.get("FLT013286") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031948") + '</td>');
	write('<td class="textfield">');
	//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.minCrAmt" id="minCrAmt" onBlur="javascript:return calert_det_ONBLUR6(this,\'MILLION\',this,\'\',\'N\');" style="TEXT-ALIGN:right" fdt="String" ' + calertProps.get("minCrAmt_ENABLED") + '>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.minCrAmt" id="minCrAmt" onBlur="javascript:return calert_det_ONBLUR7(this,this);" style="TEXT-ALIGN:right" fdt="String" ' + calertProps.get("minCrAmt_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031949") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.phNum" id="phNum" fdt="String" ' + calertProps.get("phNum_ENABLED") + '>');
	write('&nbsp;<a id="sLnk3" href="javascript:phoneSearcher();">');
	write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031875") + '</td>');
	write('<td class="textfield">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.email" id="email" fdt="String" ' + calertProps.get("email_ENABLED") + '>');
	write('&nbsp;<a id="sLnk4" href="javascript:emailSearcher();">');
        write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031950") + '</td>');
	write('<td class="textfield">');
	write('<select name="' + subGroupName + '.activateFlag" id="activateFlag"   value="N" style="width: 218px" fdt="String" ' + calertProps.get("activateFlag_ENABLED") + '>');
	write('<option value="">' + jspResArr.get("FLT031311") + '</option>');
	write('<option value="Y">' + jspResArr.get("FLT012405") + '</option>');
	write('<option value="N">' + jspResArr.get("FLT013286") + '</option>');
	write('</select>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield"></td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-END -->');
	write('</td>');
	write('</tr>');
	write('</table>');
	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return calert_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return calert_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return calert_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	if((funcCode == "X") || (funcCode == "V"))
	{
		hideImage("sLnk2");
		hideImage("sLnk3");
		hideImage("sLnk4");
	}

	initFocusHandler();

	pre_ONLOAD('calert_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	document.forms[0].chrgAcc.focus();

	post_ONLOAD('calert_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.custId.value = custId;
	ObjForm.custName.value = custName;
	ObjForm.custBranch.value = custBranch;
	ObjForm.custConst.value = custConst;
	ObjForm.accNum.value = accNum;
	ObjForm.accCrncy.value = accCrncy;
	ObjForm.accName.value = accName;
	ObjForm.accBranch.value = accBranch;
	ObjForm.accScheme.value = accScheme;
	ObjForm.accStatus.value = accStatus;
	ObjForm.modeOfOper.value = modeOfOper;
	ObjForm.chrgAcc.value = chrgAcc;
	ObjForm.chrgAccCrncy.value = chrgAccCrncy;
	ObjForm.drAlerts.value = drAlerts;
	ObjForm.minDrAmt.value = minDrAmt;
	ObjForm.crAlerts.value = crAlerts;
	ObjForm.minCrAmt.value = minCrAmt;
	ObjForm.phNum.value = phNum;
	ObjForm.email.value = email;
	ObjForm.activateFlag.value = activateFlag;
	ObjForm.RecVerifyType.value = RecVerifyType;
}


function calert_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('calert_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('calert_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function calert_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('calert_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('calert_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function calert_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('calert_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('calert_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

/*function calert_det_ONBLUR6(e,f,d,b,a)
{
        var c="";
        if(preEventCall("calert_det",e,"ONBLUR")==false)
        {
                return false
        }
        if(preEventCallForLocale("calert_det",e,"ONBLUR")==false)
        {
                return false
        }
        if((c=newformatAmt(f,d,b,a))==false)
        {
                return false
        }
        if(postEventCallForLocale("calert_det",e,"ONBLUR")==false)
        {
                return false
        }
        if(postEventCall("calert_det",e,"ONBLUR")==false)
        {
                return false
        }
        return(c==undefined)?true:c
}*/


function calert_det_ONBLUR6(obj)
{
	var obj = obj.value;
	if(document.forms[0].minDrAmt.value != "")
	{
		if ( fnValidateNumbers(document.forms[0].minDrAmt.value) == false )
		{
			alert("Please Enter Min Debit Amount in Numeric!!");
			document.forms[0].minDrAmt.focus();
			return false;
		}

		 obj += '';
		 var x = obj.split('.');
		 var x1 = x[0];
		 var x2 = x.length > 1 ? '.' + x[1] : '';
		 var rgx = /(\d+)(\d{3})/;
		 while (rgx.test(x1)) 
		 {
			  x1 = x1.replace(rgx, '$1' + ',' + '$2' );
		 }
			  x1 = x1 + '.00';
		document.forms[0].minDrAmt.value = x1;
	 	return x1 + x2;
	}
}

function calert_det_ONBLUR7(obj)
{
        var obj = obj.value;
	if(document.forms[0].minCrAmt.value != "")
	{
		if ( fnValidateNumbers(document.forms[0].minCrAmt.value) == false ) 
		{
			alert("Please Enter Min Credit Amount in Numeric!!");
			document.forms[0].minCrAmt.focus();
			return false;
		}	
		 obj += '';
		 var x = obj.split('.');
		 var x1 = x[0];
		 var x2 = x.length > 1 ? '.' + x[1] : '';
		 var rgx = /(\d+)(\d{3})/;
		 while (rgx.test(x1))
		 {
			  x1 = x1.replace(rgx, '$1' + ',' + '$2');
		 }
		  x1 = x1 + '.00';
                 document.forms[0].minCrAmt.value = x1;
        	 return x1 + x2;
	}

}


function fnValidateNumbers(obj)
{
        var iChars = ".,-0123456789";
        for (var i = 0; i < objectField.length; i++) 
	{
		if (iChars.indexOf(objectField.charAt(i)) == -1) 
		{
			return false;
		}
        }
        return true;
}


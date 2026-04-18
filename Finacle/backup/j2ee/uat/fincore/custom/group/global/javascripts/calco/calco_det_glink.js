function printBlock()
{
	writeCustomHeader("calco_det");
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
	write('<label id="compField">' + CrncyCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031859") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + AplliDate + '</label>');
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
//R1
 	write("<tr>");
        write('<td class="textlabel" style="width: 59px">' + jspResArr.get("FLT014902") + '</td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLim1" id="LowLim1"  disabled size=20 maxlength=20 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLim1" id="HighLim1" disabled size=20 maxlength=20 fdt="fpzint" ></td>');
        write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT131874") + ' </td>');
        write('<td class="textfield">');
	write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLimR1" id="LowLimR1" size=10 maxlength=10 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLimR1" id="HighLimR1" size=10 maxlength=10 fdt="fpzint" ></td>');
        write('</td>');
        write("</tr>");
//R2
        write("<tr>");
        write('<td class="textlabel" style="width: 59px">' + jspResArr.get("FLT014912") + '</td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLim2" id="LowLim2"  disabled size=20 maxlength=20 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLim2" id="HighLim2" disabled size=20 maxlength=20 fdt="fpzint" ></td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT131875") + ' </td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLimR2" id="LowLimR2" size=10 maxlength=10 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLimR2" id="HighLimR2" size=10 maxlength=10 fdt="fpzint" ></td>');
        write('</td>');
        write("</tr>");
//R3
        write("<tr>");
        write('<td class="textlabel" style="width: 59px">' + jspResArr.get("FLT014913") + '</td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLim3" id="LowLim3"  disabled size=20 maxlength=20 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLim3" id="HighLim3"  disabled size=20 maxlength=20 fdt="fpzint" ></td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT131876") + ' </td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLimR3" id="LowLimR3" size=10 maxlength=10 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLimR3" id="HighLimR3" size=10 maxlength=10 fdt="fpzint" ></td>');
        write('</td>');
        write("</tr>");
//R4
        write("<tr>");
        write('<td class="textlabel" style="width: 59px">' + jspResArr.get("FLT014914") + '</td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLim4" id="LowLim4" disabled size=20 maxlength=20 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLim4" id="HighLim4"  disabled size=20 maxlength=20 fdt="fpzint" ></td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT131877") + ' </td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLimR4" id="LowLimR4" size=10 maxlength=10 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLimR4" id="HighLimR4" size=10 maxlength=10 fdt="fpzint" ></td>');
        write('</td>');
        write("</tr>");
//R5
        write("<tr>");
        write('<td class="textlabel" style="width: 59px">' + jspResArr.get("FLT014915") + '</td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLim5" id="LowLim5"  disabled size=20 maxlength=20 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLim5" id="HighLim5"  disabled size=20 maxlength=20 fdt="fpzint" ></td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT131878") + ' </td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLimR5" id="LowLimR5" size=10 maxlength=10 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLimR5" id="HighLimR5" size=10 maxlength=10 fdt="fpzint" ></td>');
        write('</td>');
        write("</tr>");
//R6
        write("<tr>");
        write('<td class="textlabel" style="width: 59px">' + jspResArr.get("FLT014916") + '</td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLim6" id="LowLim6" disabled size=20 maxlength=20 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLim6" id="HighLim6" disabled size=20 maxlength=20 fdt="fpzint" ></td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT131879") + ' </td>');
        write('<td class="textfield">');
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.LowLimR6" id="LowLimR6" size=10 maxlength=10 fdt="fpzint" >');
        write("&nbsp;");
        write('<input class="twotextfieldnoicon" name="' + subGroupName + '.HighLimR6" id="HighLimR6" size=10 maxlength=10 fdt="fpzint" ></td>');
        write('</td>');
        write("</tr>");


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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return calco_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return calco_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return calco_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

	if((funcCode == "X") || (funcCode == "V")|| (funcCode == "I"))
	{
		ObjForm.LowLimR1.disabled = true;
		ObjForm.HighLimR1.disabled = true;
		ObjForm.LowLimR2.disabled = true;
		ObjForm.HighLimR2.disabled = true;
		ObjForm.LowLimR3.disabled = true;
		ObjForm.HighLimR3.disabled = true;
		ObjForm.LowLimR4.disabled = true;
		ObjForm.HighLimR4.disabled = true;
		ObjForm.LowLimR5.disabled = true;
		ObjForm.HighLimR5.disabled = true;
		ObjForm.LowLimR6.disabled = true;
		ObjForm.HighLimR6.disabled = true;
	}
	initFocusHandler();

	pre_ONLOAD('calco_det',this);

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

	//document.forms[0].chrgAcc.focus();

	post_ONLOAD('calco_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	
	ObjForm.LowLim1.value = LowLim1;
	ObjForm.HighLim1.value = HighLim1;
	ObjForm.LowLim2.value = LowLim2;
	ObjForm.HighLim2.value = HighLim2;
	ObjForm.LowLim3.value = LowLim3;
	ObjForm.HighLim3.value = HighLim3;
	ObjForm.LowLim4.value = LowLim4;
	ObjForm.HighLim4.value = HighLim4;
	ObjForm.LowLim5.value = LowLim5;
	ObjForm.HighLim5.value = HighLim5;
	ObjForm.LowLim6.value = LowLim6;
	ObjForm.HighLim6.value = HighLim6;
	ObjForm.LowLimR1.value = LowLimR1;
	ObjForm.HighLimR1.value = HighLimR1;
	ObjForm.LowLimR2.value = LowLimR2;
	ObjForm.HighLimR2.value = HighLimR2;
	ObjForm.LowLimR3.value = LowLimR3;
	ObjForm.HighLimR3.value = HighLimR3;
	ObjForm.LowLimR4.value = LowLimR4;
	ObjForm.HighLimR4.value = HighLimR4;
	ObjForm.LowLimR5.value = LowLimR5;
	ObjForm.HighLimR5.value = HighLimR5;
	ObjForm.LowLimR6.value = LowLimR6;
	ObjForm.HighLimR6.value = HighLimR6;
	ObjForm.RecVerifyType.value = RecVerifyType;
}


function calco_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('calco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('calco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function calco_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('calco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('calco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function calco_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('calco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('calco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

/*function calco_det_ONBLUR6(e,f,d,b,a)
{
        var c="";
        if(preEventCall("calco_det",e,"ONBLUR")==false)
        {
                return false
        }
        if(preEventCallForLocale("calco_det",e,"ONBLUR")==false)
        {
                return false
        }
        if((c=newformatAmt(f,d,b,a))==false)
        {
                return false
        }
        if(postEventCallForLocale("calco_det",e,"ONBLUR")==false)
        {
                return false
        }
        if(postEventCall("calco_det",e,"ONBLUR")==false)
        {
                return false
        }
        return(c==undefined)?true:c
}*/


function calco_det_ONBLUR6(obj)
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

function calco_det_ONBLUR7(obj)
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


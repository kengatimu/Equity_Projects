function printBlock()
{
	writeCustomHeader("cichqm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">In House cheque Maintenance</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">Function :</td>');
        if(funcCode=='U'){
                requestId1='N/A'
                funcDesc="Issue"
        }
	if(funcCode=='A'){funcDesc="Add"; }
	if(funcCode=='D'){funcDesc='Delete'; }
	if(funcCode=='V'){funcDesc='Verify'; }
	if(funcCode=='I'){funcDesc='Inquire'; }
	write('<td class="textfielddisplaylabel">'+funcCode+" - " +funcDesc+ '</td>');
	if(funcCode != 'A'){
		write('<td class="textlabel">Request Id :</td>');
    		write('<td class="textfielddisplaylabel">'+requestId1+'</td>');
	}
	write('</tr>')
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="activetab3" width="100%"></td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop">');
	write('<tr>');
	write('<a href="javascript:showHelpFile(\'cichqm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000228") + '</td>');
	write('<td><input name="' + subGroupName + '.acctNo" id="acctNo" ' + cichqmProps.get("acctNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	document.forms[0].acctNo.disabled = true;
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000028") + '<font color="red" size="2"> *</font></td>'); 
	write('<td><input name="' + subGroupName + '.noOfChqs" id="noOfChqs" ' + cichqmProps.get("noOfChqs_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000039")+ '<font color="red" size="2"> *</font></td>'); 
	write('<td><input name="' + subGroupName + '.leaves" id="leaves" ' + cichqmProps.get("leaves_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT019668") + '<font color="red" size="2"> *</font></td>'); 
	write('<td><input name="' + subGroupName + '.startChqNo" id="startChqNo" ' + cichqmProps.get("startChqNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000129") + '</td>');
	write('<td><input name="' + subGroupName + '.reqStat" id="reqStat" ' + cichqmProps.get("reqStat_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000029") + '</td>');
	write('<td><input name="' + subGroupName + '.endChqNo" id="endChqNo" ' + cichqmProps.get("endChqNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');

	write('<tr>');
    write('<td class="textlabel">' + jspResArr.get("FLT11000130") + '</td>');
    write('<td><input name="' + subGroupName + '.instType" id="instType" ' + cichqmProps.get("instType_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:getInstrTypeList(document.forms[0].instType,document.forms[0].acctNo.value,\'ctrl\',\'F\')">');
	write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search3"></IMG></a>');
	write('</tr>');

	write('<tr>');
	//write('<td> Press <Submit> to download the Cheque Book Request for the day </td>');
	write('</tr>');
	write('</table></td>');
	write('</tr>');
	write('</table></td>');
	write('</tr>');
	write('</table></td>');
	write('</tr>');
	write('</table></td>');
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
	write('<input type="button" class="Button" id="Submit" value="SUBMIT" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="CANCEL" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cichqm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cichqm_det_ONCLICK2(this);" id="Clear" value="Cancel">');
	}else{
	write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('cichqm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
		document.getElementById('sLnk3').style.visibility="hidden";
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
ObjForm.acctNo.value=acctNo;
        if(funcCode =='A')
        {
        	ObjForm.startChqNo.value = "";
        	ObjForm.endChqNo.value = "";
        	ObjForm.startChqNo.disabled= true ;
        	ObjForm.endChqNo.disabled= true ;
        	ObjForm.reqStat.disabled= true ;
		ObjForm.instType.disabled=false;
        }
	if(funcCode=='U'){
                ObjForm.endChqNo.disabled=true;
		ObjForm.startChqNo.disabled= true ;
                ObjForm.reqStat.disabled=true;
		ObjForm.instType.disabled=false;
		ObjForm.reqStat.value='N';
        }
        fnPopUpExceptionWindow(ObjForm.actionCode);
        if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
                checkCustErrExecNextStep(Message);
        }
	post_ONLOAD('cichqm_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.acctNo.value=acctNo;
	ObjForm.noOfChqs.value=noOfChqs;
	ObjForm.leaves.value=leaves;
	ObjForm.startChqNo.value=startChqNo;
	ObjForm.endChqNo.value=endChqNo;
	if(funcCode == 'A'){
		ObjForm.reqStat.value = 'E';
	}
	else{
	ObjForm.reqStat.value=reqStat;
	}
	ObjForm.instType.value=instType;
	return true;
}


function cichqm_det_ONCLICK1(obj,p1)
{
	        var ObjForm = document.forms[0];

        if(ObjForm.noOfChqs.value==""){
                alert("Please enter the No Of chqbooks");
                ObjForm.noOfChqs.focus();
                return false;
        }
	if(isNaN(document.forms[0].noOfChqs.value) )
          {
             alert("Please Enter  valid No of Chq Book");
             document.forms[0].noOfChqs.focus();
             return false;
          }
	
        if(ObjForm.leaves.value==""){
                alert("Please enter the Leaves(25/50/100)");
                ObjForm.leaves.focus();
                return false;
        }
	 if(isNaN(document.forms[0].leaves.value) )
          {
             alert("Please Enter  valid No of Leaves");
             document.forms[0].leaves.focus();
             return false;
          }

if(funcCode=='U'){
/*
        if(ObjForm.startChqNo.value==""){
                alert("Please enter the ChqStart SerialNo");
                ObjForm.startChqNo.focus();
                return false;
        }
*/
	if(isNaN(document.forms[0].noOfChqs.value) )
          {
             alert("Please Enter a Valid No Of Cheque Book");
             document.forms[0].noOfChqs.focus();
             return false;
          }
        if(isNaN(document.forms[0].leaves.value) )
          {
             alert("Please Enter a Valid No Of Leaves");
             document.forms[0].leaves.focus();
             return false;
          }


	if(isNaN(document.forms[0].startChqNo.value) )
          {
             alert("Please Enter a valid Start Chq Number");
             document.forms[0].startChqNo.focus();
             return false;
          }

}

	var retVal = "";
	if (pre_ONCLICK('cichqm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cichqm_det',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cichqm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cichqm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cichqm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){

        showAccountIdList(obj,null,null,'F');
}


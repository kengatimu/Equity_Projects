function printBlock()
{
	writeCustomHeader("ctaraco_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT033494") + '</td>');
	write('</tr>');
	write('</table>');
	write('<br />');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td height="25" colspan="5" align="right" style="width: 900px;">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	/* write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>'); */
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033544") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield" style="width: 260px;">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.drAcctNum" id="drAcctNum"  fdt="String" ' + ctaracoProps.get("drAcctNum_ENABLED") + ' onChange="javascript:  ctaraco_det_ONCHANGE2(this);"  style="width: 166px;">');
	write('  <a id="sLnk4" href="javascript:getAcctIdList();">');
	write('  <img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('&nbsp;&nbsp;<a id="sLnk5" href="javascript:showAcctDetails()">');
    	write('<img src="../Renderer/images/' + applangcode + '/explode.gif" alt="Balance Details" width="16" height="16" border="0" explodeId="explode1"></a>');
	write('</td>');
	write('<td class="textlabel" style="width: 150px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.acctEntityId" id="acctEntityId"  fdt="String" ' + ctaracoProps.get("acctEntityId_ENABLED") + ' disabled style="width: 57px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.acctSolId" id="acctSolId"  fdt="String" ' + ctaracoProps.get("acctSolId_ENABLED") + ' disabled style="width: 53px;">');
	write('</td>');
	write('<td class="textfield" style="width: 300px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.acctCrncy" id="acctCrncy"  fdt="String" ' + ctaracoProps.get("acctCrncy_ENABLED") + ' disabled style="width: 45px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.acctName" id="acctName"  fdt="String" ' + ctaracoProps.get("acctName_ENABLED") + ' disabled style="width: 150px;">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Interest Amount<script>setMandatory("Y");</script></td>');
	write('<td class="textfield" style="width: 260px;">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.IntrstAmt" id="IntrstAmt"  fdt="String" ' + ctaracoProps.get("IntrstAmt_ENABLED") + ' onChange="javascript:  ctaraco_det_ONCHANGE3(this);" style="width: 166px;">');
	write('</td>'); 
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel"> </td>');
        write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT033545") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield" style="width: 260px;">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.opAcctNum" id="opAcctNum"  fdt="String" ' + ctaracoProps.get("opAcctNum_ENABLED") + ' onChange="javascript:  ctaraco_det_ONCHANGE4(this);" style="width: 166px;">');
	write('  <a id="sLnk6" href="javascript:getAcctIdList();">');
	write('  <img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('&nbsp;&nbsp;<a id="sLnk7" href="javascript:showAcctDetails()">');
    	write('<img src="../Renderer/images/' + applangcode + '/explode.gif" alt="Balance Details" width="16" height="16" border="0" explodeId="explode1"></a>');
	write('</td>');
	write('<td class="textlabel" style="width: 150px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.opAcctEntityId" id="opAcctEntityId"  fdt="String" ' + ctaracoProps.get("opAcctEntityId_ENABLED") + ' disabled style="width: 57px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.opAcctSolId" id="opAcctSolId"  fdt="String" ' + ctaracoProps.get("opAcctSolId_ENABLED") + ' disabled style="width: 53px;">');
	write('</td>');
	write('<td class="textfield" style="width: 300px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.opAcctCrncy" id="opAcctCrncy"  fdt="String" ' + ctaracoProps.get("opAcctCrncy_ENABLED") + ' disabled style="width: 45px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.opAcctName" id="opAcctName"  fdt="String" ' + ctaracoProps.get("opAcctName_ENABLED") + ' disabled style="width: 150px;">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT026527") + ' <script>setMandatory("Y");</script></td>');
	write('<td class="textfield" style="width: 260px;">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" name="' + subGroupName + '.PLAcctNum" id="PLAcctNum"  fdt="String" ' + ctaracoProps.get("PLAcctNum_ENABLED") + ' readonly="readonly" style="width: 166px;">');
	write('</td>');
	write('<td class="textlabel" style="width: 150px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.PLAcctEntityId" id="PLAcctEntityId"  fdt="String" ' + ctaracoProps.get("PLAcctEntityId_ENABLED") + ' disabled style="width: 57px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.PLAcctSolId" id="PLAcctSolId"  fdt="String" ' + ctaracoProps.get("PLAcctSolId_ENABLED") + ' disabled style="width: 53px;">');
	write('</td>');
	write('<td class="textfield" style="width: 300px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.PLAcctCrncy" id="PLAcctCrncy"  fdt="String" ' + ctaracoProps.get("PLAcctCrncy_ENABLED") + ' disabled style="width: 45px;">');
	write('<input type="text" class="label" name="' + subGroupName + '.PLAcctName" id="PLAcctName"  fdt="String" ' + ctaracoProps.get("PLAcctName_ENABLED") + ' disabled style="width: 150px;">');
	write('</td>');
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
	//if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return ctaraco_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return ctaraco_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return ctaraco_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
/*	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}*/
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	//initFocusHandler();

	pre_ONLOAD('ctaraco_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	//if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='R' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
	//	fnDisableFormDataControls('V',ObjForm,0);
	//}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('ctaraco_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.drAcctNum.value = drAcctNum;
	ObjForm.acctEntityId.value = acctEntityId;
	ObjForm.acctSolId.value = acctSolId;
	ObjForm.acctCrncy.value = acctCrncy;
	ObjForm.acctName.value = acctName;
	ObjForm.opAcctNum.value = opAcctNum;
	ObjForm.opAcctEntityId.value = opAcctEntityId;
	ObjForm.opAcctSolId.value = opAcctSolId;
	ObjForm.opAcctCrncy.value = opAcctCrncy;
	ObjForm.opAcctName.value = opAcctName;
	
	ObjForm.PLAcctNum.value = PLAcctNum;
	ObjForm.PLAcctEntityId.value = PLAcctEntityId;
	ObjForm.PLAcctSolId.value = PLAcctSolId;
	ObjForm.PLAcctCrncy.value = PLAcctCrncy;
	ObjForm.PLAcctName.value = PLAcctName;
	
	fnEnableRateFields();
	
}

function ctaraco_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('ctaraco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ctaraco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctaraco_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('ctaraco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ctaraco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctaraco_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('ctaraco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('ctaraco_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ctaraco_det_ONCHANGE2(obj)
{
	var retVal = "";

        if (preEventCall('ctaraco_det',obj,'ONCHANGE') == false) 
	{
                return false;
        }

	if ((retVal = fnGetAccountDetails()) == false) 
	{
                return false;
        }

        if (postEventCall('ctaraco_det',obj,'ONCHANGE') == false) 
	{
                return false;
        }
        return (retVal == undefined) ? true : retVal;
	
}

function ctaraco_det_ONCHANGE3(obj)
{
        var retVal = "";

        if (preEventCall('ctaraco_det',obj,'ONCHANGE') == false)
        {
                return false;
        }

        if ((retVal = fnvalIntrstAmt(obj)) == false)
        {
                return false;
        }

        if (postEventCall('ctaraco_det',obj,'ONCHANGE') == false)
        {
                return false;
        }
        return (retVal == undefined) ? true : retVal;

}

function ctaraco_det_ONCHANGE4(obj)
{
        var retVal = "";

        if (preEventCall('ctaraco_det',obj,'ONCHANGE') == false)
        {
                return false;
        }

        if ((retVal = fnGetAccountDetails(obj)) == false)
        {
                return false;
        }

        if (postEventCall('ctaraco_det',obj,'ONCHANGE') == false)
        {
                return false;
        }
        return (retVal == undefined) ? true : retVal;

}


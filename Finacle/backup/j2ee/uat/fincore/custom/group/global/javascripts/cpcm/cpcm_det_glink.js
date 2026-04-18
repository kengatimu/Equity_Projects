function printBlock()
{
	writeCustomHeader("cpcm_det");
	with (document){
	write('<input type="hidden" id="date" fdt="fdate" mneb1="N" vFldId="startDate_ui" name="' + subGroupName + '.startDate">');
        write('<input type="hidden" id="date" fdt="fdate" mneb1="N" vFldId="endDate_ui" name="' + subGroupName + '.endDate">');
	write('<input type="hidden" id="tmpCrncyCode" fdt="String" mneb1="N" name="' + subGroupName + '.tmpCrncyCode" value="'+ tmpCrncyCode +'">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT200000") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT200001") + '</td>');
	write('<td class="textfielddisplaylabel">');
	if(funcCode == "A")
        {
                write('<label id="compField">' + jspResArr.get("FLT000003") + '</label>');
        }
        if(funcCode == "M")
        {
                write('<label id="compField">' + jspResArr.get("FLT000004") + '</label>');
        }
        if(funcCode == "V")
        {
                write('<label id="compField">' + jspResArr.get("FLT000005") + '</label>');
        }
        if(funcCode == "X")
        {
                write('<label id="compField">' + jspResArr.get("FLT000006") + '</label>');
        }
	if(funcCode == "I")
        {
                write('<label id="compField">' + jspResArr.get("FLT000007") + '</label>');
        }
	write('</td>');
	write('</tr>');
/*
	write('<td class="columnwidth">&nbsp; </td>');

	write('<td class="textlabel">' + jspResArr.get("FLT000011") + '</td>');
        write('<td class="textfielddisplaylabel">');
        if(funcCode == "A")
        {
                write('<label id="compField">' + jspResArr.get("FLT000013") + '</label>');
        }
        if(funcCode == "C")
        {
                write('<label id="compField">' + jspResArr.get("FLT000014") + '</label>');
        }
        if(funcCode == "AG")
        {
                write('<label id="compField">' + jspResArr.get("FLT000015") + '</label>');
        }
        if(funcCode == "S")
        {
                write('<label id="compField">' + jspResArr.get("FLT000016") + '</label>');
        }
        if(funcCode == "CO")
        {
                write('<label id="compField">' + jspResArr.get("FLT000017") + '</label>');
        }
        write('</td>');
	write('</tr>');
*/
	if(preferentialLevel == "A")
	{
		write('<tr>');
		write('<td class="textlabel">' + jspResArr.get("FLT000008") + '</td>');
		write('<td class="textfielddisplaylabel">');
		write('<label id="compField">' + acctId +' - '+ acctName +'</label>');
		write('</td>');
		write('<td class="columnwidth">&nbsp; </td>');
	}
	
	if(preferentialLevel == "C")
	{
		write('<td class="textlabel">' + jspResArr.get("FLT000009") + '</td>');
		write('<td class="textfielddisplaylabel">');
		write('<label id="compField">' + custId +' - '+ custName +'</label>');
		write('</td>');
		write('</tr>');
	}
	
	if(preferentialLevel == "AG")
	{
		write('<tr>');
		write('<td class="textlabel">' + jspResArr.get("FLT000010") + '</td>');
		write('<td class="textfielddisplaylabel">');
		write('<label id="compField">' + empId +' - '+ empName +'</label>');
		write('</td>');
		write('<td class="columnwidth">&nbsp; </td>');
	}
	
	if(preferentialLevel == "S")
        {
		write('<td class="textlabel">' + jspResArr.get("FLT100017") + '</td>');
		write('<td class="textfielddisplaylabel">');
		write('<label id="compField">' + segmentationLevel +'</label>');
		write('</td>');
		write('</tr>');
	}
	
	if(preferentialLevel == "B")
        {	
		write('<tr>');
		write('<td class="textlabel">' + jspResArr.get("FLT000017") + '</td>');
		write('<td class="textfielddisplaylabel">');
		write('<label id="compField">' + customerType +'</label>');
		write('</td>');
		write('</tr>');
	}
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT200117") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compField">' + evtType +' - '+ evtTypeDesc +'</label>');
        write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');

	write('<td class="textlabel">' + jspResArr.get("FLT200118") + '</td>');
        write('<td class="textfielddisplaylabel">');
        write('<label id="compField">' + evtId +'</label>');
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
	write('<a href="javascript:showHelpFile(\'cpcm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');


	//Event Type
/*	write('<td class="textlabel">' + jspResArr.get("FLT200117") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.evtType" id="evtType" type="text" fdt="String" class="textfieldfont" hotKeyId="search2"  size="21" maxlength="5">');
        write('&nbsp; <a id="sLnk2" href="javascript:fnShowEventType()">');
        write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');*/

/*	
	write('<tr>');
	write('<td class="textlabel">'+jspResArr.get("FLT200117")+'<script>setMandatory("Y");<\/script></td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'cpcmcrit\',this);" type="text" class="textfieldfont" fmnd="Y" fmb="Y" fdt="string" fblk="fblk1" fds="N" name="'+subGroupName+'.evtType" id="evtType" size="7" maxlength="5" '+cpcmProps.get("evtType_ENABLED")+' onChange="javascript:return cpcmcrit_ONCHANGE5(this,\'evtTypeDesc\');" hotKeyId="search1">');
	write('&nbsp;<a target="_self" id="sLnk2" href="javascript:fnShowEventType()">');
	write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
       	write('<input class="label" id="evtTypeDesc" name="' + subGroupName + '.evtTypeDesc" size="30" border="0" maxlength=30 fds="Y" disabled></td>');
	write('</td>');
        write('<td class="columnwidth">&nbsp;</td>');
*/

	//Event ID
/*	write('<td class="textlabel">' + jspResArr.get("FLT200118") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.evtType" id="evtType" type="text" fdt="String" class="textfieldfont" hotKeyId="search2"  size="21" maxlength="5">');
        write('&nbsp; <a id="sLnk2" href="javascript:evtTypeSearcher()">');
        write('<img border="0" height="17" id="packageCode" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</td>');
	write('</tr>');*/

/*	write('<td class="textlabel">'+jspResArr.get("FLT200118")+'<script>setMandatory("Y");<\/script></td>');
	write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'cpcmcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'cpcmcrit\',this);" type="text" class="textfieldfont" fmnd="Y" name="'+subGroupName+'.evtId" id="evtId" size="27" maxlength="25" '+cpcmProps.get("evtId_ENABLED")+' hotKeyId="search2">');
	write('&nbsp;<a target="_self" id="sLnk6" href="Javascript:fnShowEvtIDList(document.forms[0].funcCode)">');
	write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</td>');
	write('</tr>');*/

/*
	write('<td class="textlabel">'+jspResArr.get("FLT200118")+'<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'cpcmcrit\',this);" onBlur="javascript:return custom_ONBLUR(\'cpcmcrit\',this);" type="text" class="textfieldfont" fmnd="Y" name="'+subGroupName+'.evtId" id="evtId" size="27" maxlength="25" '+cpcmProps.get("evtId_ENABLED")+' hotKeyId="search2">');
        write('&nbsp;<a target="_self" id="sLnk6" href="Javascript:fnShowEvtIDList()">');
        write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</td>');
        write('</tr>');
*/
	//Start Date
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200119")+ '<script>setMandatory("Y");</script>' + '</td>');
        write('<td class="textfield">');
        write('<input  hotKeyId="calender1"  type="text" class="textfieldfont"  fdt="uidate" maxlength="10" mnebl="false" onBlur="javascript:return cpcm_det_ONBLUR1(this,this,this);" name="' + subGroupName + '.startDate_ui" id="startDate_ui" >');
        write('<a  href="javascript:openDate(document.forms[0].startDate_ui,BODDate)"   id="sLnk5"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
//	write('<td class="columnwidth">&nbsp;</td>');

	//End Date
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200120") + '<script>setMandatory("Y");</script>' + '</td>');
        write('<td class="textfield">');
        write('<input  hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate" maxlength="10" mnebl="false" onBlur="javascript:return cpcm_det_ONBLUR1(this,this,this);" name="' + subGroupName + '.endDate_ui" id="endDate_ui" >');
        write('<a  href="javascript:openDate(document.forms[0].endDate_ui,BODDate)"   id="sLnk3"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender2" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
	write('</td>');
        write('</tr>');

//


	//Percent/Amount
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200121") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.percent" id="percent"  fdt="String"  onChange="javascript:return functioncode(this);"' + cpcmProps.get("persent_ENABLED") + ' class="listboxfont" >');
        write('<option value="">' + jspResArr.get("FLT200123") + '</option>');
        write('<option value="P">' + jspResArr.get("FLT200124") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT200125") + '</option>');
        write('</select>');
        write('</td>');
	write('</tr>');
	
	//Value
	write('<tr id="X">');	
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200122") + '<script>setMandatory("Y");</script>'+ '</td>');
        write('<td class="textfield">');
        write('<input  type="text" class="textfieldfont" fdt="amount" mnebl="false" onchange="javascript:return cpcmDet_ONCHANGE1(this,\'' + "MILLION" + "',this,'" + tmpCrncyCode + '\',\'N\');" onblur="javascript:return cpcmDet_ONBLUR1(this,\'' + "MILLION" + "',this,'" + tmpCrncyCode + '\',\'N\');" name="' + subGroupName + '.value1" id="value1" size="24" maxlength="17" style="TEXT-ALIGN:right">');
        write('</td>');
	write('</tr>');

	//Value
	write('<tr id="Z">');
       	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200126") + '<script>setMandatory("Y");</script>' +'</td>');
        write('<td class="textfield">');
        write('<input type="text" id="value2" name="' + subGroupName + '.value2" size="12" maxlength="10" class="textfieldfont" fdt="fpcnt" onchange="javascript:return cpcmDet_ONCHANGE3(this,document.forms[0].percentAmount);" style="TEXT-ALIGN:right"></td>'); 
	write('</td>');
	write('</tr>');	
	write('<td class="textlabel"></td>');
        write('<td class="textfield"><td>');
	write('</tr>');



	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield"> </td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');

        write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200128") + '<script>setMandatory("Y");</script>'+ '</td>');
        write('<td class="textfield">');
        write('<input  type="text" class="textfieldfont" fdt="amount" mnebl="false" onchange="javascript:return cpcmDet_ONCHANGE1(this,\'' + "MILLION" + "',this,'" + tmpCrncyCode + '\',\'N\');" onblur="javascript:return cpcmDet_ONBLUR1(this,\'' + "MILLION" + "',this,'" + tmpCrncyCode + '\',\'N\');" name="' + subGroupName + '.minamt" id="minamt" size="24" maxlength="17" style="TEXT-ALIGN:right">');
        write('</td>');

	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT200129") + '<script>setMandatory("Y");</script>'+ '</td>');
        write('<td class="textfield">');
        write('<input  type="text" class="textfieldfont" fdt="amount" mnebl="false" onchange="javascript:return cpcmDet_ONCHANGE1(this,\'' + "MILLION" + "',this,'" + tmpCrncyCode + '\',\'N\');" onblur="javascript:return cpcmDet_ONBLUR1(this,\'' + "MILLION" + "',this,'" + tmpCrncyCode + '\',\'N\');" name="' + subGroupName + '.maxamt" id="maxamt" size="24" maxlength="17" style="TEXT-ALIGN:right">');
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
        if(funcCode !='I'){
        write('<div class="ctable">');
        write('<input id="Submit" name="Submit" type="button" class="button"    onClick="javascript:return cpcm_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
        write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '" onClick="javascript:return cpcm_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

	initFocusHandler();

	pre_ONLOAD('cpcm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
	fnAssignDateOnLoad(ObjForm);
	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
		if(ObjForm.Cancel)
		{
			ObjForm.Cancel.disabled = false;
		}
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cpcm_det',this);
}

function fnCheckMandatoryFields()
{
	var objForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var objForm = document.forms[0];
/*
	objForm.evtType.value 	= evtType;
	objForm.evtTypeDesc.value = evtTypeDesc;
	objForm.evtId.value 		= evtId;
*/
	objForm.startDate_ui.value 	= startDate;
	cpcm_det_ONBLUR1(objForm.startDate_ui,objForm.startDate_ui,objForm.startDate_ui);
	objForm.endDate_ui.value 	= endDate;
	cpcm_det_ONBLUR1(objForm.endDate_ui,objForm.endDate_ui,objForm.endDate_ui);
	objForm.percent.value 		= percent;
	objForm.value1.value 		= value1;
	objForm.value2.value            = value2;
	objForm.minamt.value 		= minamt;
	objForm.maxamt.value            = maxamt;


	// Formatting the amount
	newformatAmt('MILLION', objForm.value1, tmpCrncyCode, "N");
	newformatAmt('MILLION', objForm.minamt, tmpCrncyCode, "N");
	newformatAmt('MILLION', objForm.maxamt, tmpCrncyCode, "N");
}


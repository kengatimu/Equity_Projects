function printBlock()
{
	writeCustomHeader("cagtm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT648026") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT648034") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + agentcode + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT648035") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + crncyCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"></td>');
	write('<td></td>');
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
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right" rowSpam="1" colSpan="1">');
	//write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'cagtm_det_help.htm\');" id="sLnk1" shape="">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002671") + ' <script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search4" type="text" class="textfieldfont" name="' + subGroupName + '.agenttitlecode" id="agenttitlecode"  fdt="String" ' + cagtmProps.get("agenttitlecode_ENABLED") + ' maxlength="5" style="width: 60px;">');
	write('<a id="sLnk4" href="javascript:showRefCode(document.forms[0].agenttitlecode,\'45\',\'N\',\'F\')">');
        write('<img border="0" height="17" hotKeyId="search4" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="15">');
        write('</a>');
        write('  <input type="text" class="textfieldfont" name="' + subGroupName + '.agentname" id="agentname"  fdt="String" ' + cagtmProps.get("agentname_ENABLED") + ' maxlength="40" style="width: 137px;">');
        write('</td>');

        write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002672") + ' <script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.agentshortname" id="agentshortname"  fdt="String" ' + cagtmProps.get("agentshortname_ENABLED") + ' maxlength="10" style="width: 218px;">');
		write('<a id="solIdImg" href="javascript:showSetList(document.forms[0].agentshortname,\'ctrl\',\'F\',\'\');">');
		write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16">');
        write('</td>');
        write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002673") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.agentphonenum" id="agentphonenum"   maxlength="12" fdt="String" ' + cagtmProps.get("agentphonenum_ENABLED") + ' style="width: 218px;">');
        write('</td>');
	write('</tr>');
	//---------------------------------------
	//write('<tr>');
	//write('<td class="textlabel">' + jspResArr.get("FLT002672") + '<script>setMandatory("Y");</script></td>');
	//write('<td class="textfield">');
	//write('<input name="' + subGroupName + '.agentshortname" id="agentshortname" ' + cbvclProps.get("parameterId_ENABLED") + ' hotKeyId="search2" type="text" class="textfieldfont" size="30" maxlength="30" >&nbsp;');
	//write('<a id="solIdImg" href="javascript:showSetList(document.forms[0].agentshortname,\'ctrl\',\'F\',\'\');">');
	//write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16">');
	//write('</a>');
	//write('</td>');
	//write('</tr>');
	//---------------------------------------
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT002674") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.agentaddr1" id="agentaddr1"  fdt="String" ' + cagtmProps.get("agentaddr1_ENABLED") + ' maxlength="45" style="width: 218px;">');
	write('</td>');
	write('<td class="columnwidth"> </td>');
        write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002675") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.agentaddr2" id="agentaddr2"  fdt="String" ' + cagtmProps.get("agentaddr2_ENABLED") + '  maxlength="45" style="width: 218px;">');
        write('</td>');
	write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT002676") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.agentaddr3" id="agentaddr3"  fdt="String" ' + cagtmProps.get("agentaddr3_ENABLED") + '  maxlength="45" style="width: 218px;">');
        write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002677") + ' <script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search5" type="text" class="textfieldfont" name="' + subGroupName + '.agentcitycode" id="agentcitycode"  fdt="String" ' + cagtmProps.get("agentcitycode_ENABLED") + '  maxlength="5" style="width: 218px;">');
	write('&nbsp');
        write('&nbsp');
	write('<a  id="sLnk5" href="javascript:showRefCode(document.forms[0].agentcitycode,\'01\',\'N\',\'F\')">');
        write('<img border="0" height="17" hotKeyId="search5" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="14">');
        write('</a>');
        write('</td>');
        write('</tr>');

        write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT002678") + '</td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search6" type="text" class="textfieldfont" name="' + subGroupName + '.agentstatecode" id="agentstatecode"  fdt="String" ' + cagtmProps.get("agentstatecode_ENABLED") + ' maxlength="5" style="width: 218px;">');
	write('&nbsp');
        write('&nbsp');
	write('<a id="sLnk6" href="javascript:showRefCode(document.forms[0].agentstatecode,\'02\',\'N\',\'F\')">');
        write('<img border="0" height="17" hotKeyId="search6" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="14">');
        write('</a>');
        write('</td>');
	write('<td class="columnwidth"> </td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002679") + '</td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search7" type="text" class="textfieldfont" name="' + subGroupName + '.agentcntrycode" id="agentcntrycode"  fdt="String" ' + cagtmProps.get("agentcntrycode_ENABLED") + ' maxlength="5" style="width: 218px;">');
	write('&nbsp');
        write('&nbsp');
	write('<a id="sLnk7" href="javascript:showRefCode(document.forms[0].agentcntrycode,\'03\',\'N\',\'F\')">');
        write('<img border="0" height="17" hotKeyId="search7" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="14">');
        write('</a>');
        write('</td>');
	write('</tr>');

        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT002680") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.agentpin" id="agentpin"  fdt="String" ' + cagtmProps.get("agentpin_ENABLED") + ' maxlength="10" style="width: 218px;">');
        write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT648039") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.crncycode" id="crncycode"  fdt="String" ' + cagtmProps.get("crncycode_ENABLED") + ' maxlength="3" style="width: 218px;">');
        write('</td>');
        write('</tr>');


	write('<tr>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002681") + ' <script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" hotKeyId="search8" id="operacctnum" name="' + subGroupName + '.operacctnum" onchange="javascript:return cfnPopAccountDet();"  size="21" fdt="String" maxlength="16" style="width: 218px;">');
	write('&nbsp');
        write('&nbsp');
	write('<a id="sLnk8" href="javascript:operacctnumSearcher();">');
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search8"></a>');
        write('<br>');
        write('<input class="label" id="csolId" name="' + subGroupName + '.csolId" fds="Y" size="10" maxlength="5" disabled>');
        write('<input name="' + subGroupName + '.cacctName" align="left" id="cacctName"  type="text" disabled="true" class="label" size="40" maxlength="100" fdt="default" fblk="defaultFblk1" fds="Y">');
	write('<input class="label" id="cacctCrncyCode" name="' + subGroupName + '.cacctCrncyCode" fds="Y" size="4" maxlength="3" disabled>');
        write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield"></td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002682") + ' <script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" hotKeyId="search8" id="inoperacctnum" name="' + subGroupName + '.inoperacctnum" onchange="javascript:return fnPopAccountDet();" size="21" fdt="String" maxlength="16" style="width: 218px;">');	
	write('&nbsp');
        write('&nbsp');
	write('<a id="sLnk9" href="javascript:inoperacctnumsearcher();">');
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search9"></a>');
        write('<br>');
	write('<input class="label" id="acctCrncyCode" name="' + subGroupName + '.acctCrncyCode" fds="Y" size="4" maxlength="3" disabled>');
        write('<input class="label" id="solId" name="' + subGroupName + '.solId" fds="Y" size="10" maxlength="8" disabled>');
        write('<input name="' + subGroupName + '.acctName" align="left" id="acctName"  type="text" disabled="true" class="label" size="40" maxlength="100" fdt="default" fblk="defaultFblk1" fds="Y">');
        write('</td>');
	write('<td class="columnwidth"> </td>');
        write('<td class="textlabel"></td>');
        write('<td class="textfield"></td>');
	write('</tr>');

	write('<tr>');
        write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002683") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.itaxpcnt" id="itaxpcnt"  maxLength=10 fdt="String" ' + cagtmProps.get("itaxpcnt_ENABLED") + ' style="width: 218px;">');
        write('</td>');
        write('<td class="columnwidth"> </td>');
	write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002684") + '</td>');
        write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.dummyintamtceiling" id="dummyintamtceiling" onBlur="javascript:return cagtm_det_ONBLUR6(this,this);" style="TEXT-ALIGN:right" size="23" maxlength="17" fdt="String" ' + cagtmProps.get("dummyintamtceiling_ENABLED") + '>');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002685") + '</td>');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.dummysecurityamt" id="dummysecurityamt" onBlur="javascript:return cagtm_det_ONBLUR7(this,this);" style="TEXT-ALIGN:right" maxLength=17 fdt="String" ' + cagtmProps.get("dummysecurityamt_ENABLED") + '>');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002686") + '</td>');
        write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.dummyexceptedcollection" id="dummyexceptedcollection" onBlur="javascript:return cagtm_det_ONBLUR8(this,this);" style="TEXT-ALIGN:right" maxLength=17 fdt="String" ' + cagtmProps.get("dummyexceptedcollection_ENABLED") + '>');
        write('</td>');
        write('</tr>');

	write('<tr>');
        write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT002687") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.noofacctopened" id="noofacctopened"  maxLength=4 fdt="String" ' + cagtmProps.get("noofacctopened_ENABLED") + ' style="width: 218px;">');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002688") + '</td>');
        write('<td class="textfield">');
        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext" id="freetext"  maxLength=58 fdt="String" ' + cagtmProps.get("freetext_ENABLED") + ' style="width: 218px;">');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cagtm_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cagtm_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

        pre_ONLOAD('cagtm_det',this);

        var funcName = "this."+"locfnOnLoad";
        if(eval(funcName) != undefined){
                eval(funcName).call(this);
        }

        fnPopulateControlValues();
        fnAssignDateOnLoad(ObjForm);
        if(funcCode =='I' || funcCode =='D' || funcCode =='U' ||  sReferralMode =='I' || sReferralMode =='S'){
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

        post_ONLOAD('cagtm_det',this);
}


function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.agenttitlecode.value = agenttitlecode;
	ObjForm.agentname.value = agentname;
	ObjForm.agentshortname.value = agentshortname;
	ObjForm.agentphonenum.value = agentphonenum;
	ObjForm.agentaddr1.value = agentaddr1;
	ObjForm.agentaddr2.value = agentaddr2;
	ObjForm.agentaddr3.value = agentaddr3;
	ObjForm.agentcitycode.value = agentcitycode;
	ObjForm.agentstatecode.value = agentstatecode;
	ObjForm.agentcntrycode.value = agentcntrycode;
	ObjForm.agentpin.value = agentpin;
	ObjForm.crncycode.value = crncycode;
	if(ObjForm.crncycode.value =="")
	{
		ObjForm.crncycode.value = crncyCode;
		ObjForm.crncycode.readOnly.value = true;
	}
	ObjForm.operacctnum.value = operacctnum;
	ObjForm.cacctCrncyCode.value = cacctCrncyCode;
        ObjForm.csolId.value         = csolId;
        ObjForm.cacctName.value      = cacctName;
	ObjForm.inoperacctnum.value = inoperacctnum;
	ObjForm.acctCrncyCode.value = acctCrncyCode;
        ObjForm.solId.value         = solId;
        ObjForm.acctName.value      = acctName;
	ObjForm.itaxpcnt.value = itaxpcnt;
	ObjForm.dummyintamtceiling.value = dummyintamtceiling;
	ObjForm.dummysecurityamt.value = dummysecurityamt;
	ObjForm.dummyexceptedcollection.value = dummyexceptedcollection;
	ObjForm.noofacctopened.value = noofacctopened;
	ObjForm.freetext.value = freetext;

}


function cagtm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	
	if(funcCode == "M")
	{
		if (!fnValidateCrncy1())
		{
        return false; 
		}
	
		if (!fnValidateCrncy2())
		{
			return false; 
		}
	}
	
	if (preEventCall('cagtm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cagtm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	
	return (retVal == undefined) ? true : retVal;
	
}

function cagtm_det_ONCHANGE(obj)
{
        var retVal = "";
        if (preEventCall('cagtm_det',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = fnFetchAcctDtls()) == false) {
                return false;
        }
        if (postEventCall('cagtm_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}


function cagtm_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cagtm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cagtm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cagtm_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cagtm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cagtm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cagtm_det_ONBLUR6(obj)
{
        var obj = obj.value;
        if(document.forms[0].dummyintamtceiling.value != "")
        {
                if(fnValidateNumbers(document.forms[0].dummyintamtceiling.value) == false )
                {
                        alert("Please Enter Amount in Numeric!!");
                        document.forms[0].dummyintamtceiling.focus();
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
                document.forms[0].dummyintamtceiling.value = x1;
                return x1 + x2;
        }
}
function cagtm_det_ONBLUR7(obj)
{
        var obj = obj.value;
        if(document.forms[0].dummysecurityamt.value != "")
        {
                if(fnValidateNumbers(document.forms[0].dummysecurityamt.value) == false )
                {
                        alert("Please Enter Amount in Numeric!!");
                        document.forms[0].dummysecurityamt.focus();
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
                document.forms[0].dummysecurityamt.value = x1;
                return x1 + x2;
        }
}

function cagtm_det_ONBLUR8(obj)
{
        var obj = obj.value;
        if(document.forms[0].dummyexceptedcollection.value != "")
        {
                if ( fnValidateNumbers(document.forms[0].dummyexceptedcollection.value) == false )
                {
                        alert("Please Enter Min Debit Amount in Numeric!!");
                        document.forms[0].dummyexceptedcollection.focus();
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
                document.forms[0].dummyexceptedcollection.value = x1;
                return x1 + x2;
        }
}

function fnValidateCrncy1()
{
	
	var operacctnum = document.forms[0].operacctnum.value;
	if(operacctnum != "")
	{
		var cacctCrncyCode = document.forms[0].cacctCrncyCode.value.toUpperCase();
		var crncy_val = document.forms[0].crncycode.value.toUpperCase();
		
		if(cacctCrncyCode != crncy_val)
		{
			alert("Currency code mismatch between agent currency and account currency!");
			document.forms[0].operacctnum.focus();
			return false;
		}
		return true;
		
	}
}

function fnValidateCrncy2()
{	
	var inoperacctnumval = document.forms[0].inoperacctnum.value;
	if(inoperacctnumval != "")
	{
		var inOperCreditCrncyCode = document.forms[0].acctCrncyCode.value.toUpperCase();
		var crncy_val1 = document.forms[0].crncycode.value.toUpperCase();

		if(inOperCreditCrncyCode != crncy_val1)
		{
			alert("Currency code mismatch between agent currency and account currency!");
			document.forms[0].inoperacctnum.focus();
			return false;
		}
		return true;
		
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


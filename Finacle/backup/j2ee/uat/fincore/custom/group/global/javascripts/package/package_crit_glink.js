function printBlock()
{
        writeCustomHeader("package_crit");
        with (document){
        write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">' + jspResArr.get("FLT648012") + '</td>');
        write('</tr>');
        write('</table>');
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
        write('<td align="right">');
        write('<a href="javascript:showHelpFile(\'package_crit_help.htm\');" id="sLnk1">');
        write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
        write('</a>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');


	//FUNCTION CODE
	write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006657") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String"  onChange="javascript:return functioncode();"' + packageProps.get("funcCode_ENABLED") + ' class="listboxfont" >');
        write('<option value="">' + jspResArr.get("FLT648230") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT648014") + '</option>');
	write('<option value="V">' + jspResArr.get("FLT648181") + '</option>');
        write('<option value="M">' + jspResArr.get("FLT648017") + '</option>');
        write('<option value="I">' + jspResArr.get("FLT648183") + '</option>');
        write('<option value="X">' + jspResArr.get("FLT648182") + '</option>');
    	write('</select>');
        write('</td>');
        write('</tr>');
	
	//Package Code
	write('<td class="textlabel">' + jspResArr.get("FLT000620") + '<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input name="' + subGroupName + '.packageCode" id="packageCode" type="text" fdt="String" class="textfieldfont" hotKeyId="search2" onChange="javascript:return packagecode();" size="21" maxlength="5">');
	write('&nbsp; <a id="sLnk2" href="javascript:packageCodSearcher()">');
	write('<img border="0" height="17" id="packageCode" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</td>');
	write('</tr>');	

	
	write('<tr>');
        write('<td class="textlabel" style="height: 15px"> </td>');
        write('<td class="textfield"> </td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel"> </td>');
        write('<td class="textfield"> </td>');
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
        write('<div class="ctable">');
        write('<input id="Accept" name="Go" type="button" class="button"        onClick="javascript:return package_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
        write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"   onClick="javascript:return package_crit_ONCLICK2(this);"">');
        writeFooter();
        write('</div>');
        }
        } //End with()
}//End function


function fnOnLoad()
{
        var ObjForm = document.forms[0];

        initFocusHandler();

        pre_ONLOAD('package_crit',this);

        var funcName = "this."+"locfnOnLoad";
        if(eval(funcName) != undefined){
                eval(funcName).call(this);
        }

        fnPopulateControlValues();

        fnPopUpExceptionWindow(ObjForm.actionCode);
        if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
                checkCustErrExecNextStep(Message);
        }
	post_ONLOAD('package_crit',this);
}


	
function fnCheckMandatoryFields()
{
        var ObjForm = document.forms[0];
        return true;
}

function fnPopulateControlValues()
{
        var ObjForm = document.forms[0];

        ObjForm.funcCode.value = funcCode;
	ObjForm.packageCode.value = packageCode;
}


function package_crit_ONCLICK1(obj,p1)
{
        var retVal = "";
        if (preEventCall('package_crit',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnValAndSubmit(p1)) == false) {
                return false;
        }
        if (postEventCall('package_crit',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function package_crit_ONCLICK2(obj)
{
        var retVal = "";
        if (preEventCall('package_crit',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnClearFields()) == false) {
                return false;
        }
        if (postEventCall('package_crit',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function package_crit_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('package_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('package_det',obj,'ONBLUR') == false) {
                return false;
         }
	 return (retVal == undefined) ? true : retVal;

}

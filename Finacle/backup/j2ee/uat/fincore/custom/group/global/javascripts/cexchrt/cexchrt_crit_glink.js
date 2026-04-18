function printBlock()
{
        writeCustomHeader("cexchrt_crit");
        with (document){
        write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
        write('<tr>');
        write('<td>');
        write('<table border="0" cellspacing="0" cellpadding="0">');
        write('<tr>');
        write('<td class="page-heading">' + jspResArr.get("FLT031826") + '</td>');
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
        write('<a href="javascript:showHelpFile(\'crit_help.htm\');" id="sLnk1">');
        write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
        write('</a>');
        write('</td>');
        write('</tr>');
        write('</table>');
        write('</td>');
        write('</tr>');
        write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT006657") + '</td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.funcCode" id="funcCode"  fdt="String" ' + cexchrtProps.get("funcCode_ENABLED") + '   style="width: 178px;">');
        write('<option value="">' + jspResArr.get("FLT031698") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT031827") + '</option>');
        write('<option value="M">' + jspResArr.get("FLT031828") + '</option>');
        write('<option value="V">' + jspResArr.get("FLT031829") + '</option>');
        write('<option value="X">' + jspResArr.get("FLT031830") + '</option>');
        write('<option value="I">' + jspResArr.get("FLT031831") + '</option>');
        write('<option value="D">' + jspResArr.get("FLT031832") + '</option>');
        write('</select>');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001088") + '</td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.roleId" id="roleId"  fdt="String" ' + cexchrtProps.get("roleId_ENABLED") + ' style="width: 179px;" onChange="javascript:fnGetRoleVal();">');
        write('<a target=_self id="sLnk2" href="Javascript:showRoleList(document.forms[0].roleId,document.forms[0].roleDesc,\'N\',\'ctrl\',\'F\');" >');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.roleDesc" id="roleDesc" ' + cexchrtProps.get("roleDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('</tr>');
        write('<tr>');
        write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT004203") + '</td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.frmccyCode" id="frmccyCode"  fdt="String" ' + cexchrtProps.get("frmccyCode_ENABLED") + ' style="width: 179px;" onChange="javascript:fnGetccyVal();">');
        write('<a id="sLnk3" href="javascript:showCurrency(document.forms[0].frmccyCode,\'ctrl\',\'F\',document.forms[0].ccyDesc)" target=_self >');
        write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
        write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.ccyDesc" id="ccyDesc" ' + cexchrtProps.get("ccyDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('<td class="textlabel" style="height: 15px">To Currecny</td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.toccyCode" id="toccyCode"  fdt="String" ' + cexchrtProps.get("toccyCode_ENABLED") + ' style="width: 179px;"  onChange="javascript:fnGetccyVal1();">');
        write('<a id="sLnk3" href="javascript:showCurrency(document.forms[0].toccyCode,\'ctrl\',\'F\',document.forms[0].toccyDesc)" target=_self >');
        write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>');
        write('</td>');
	write('<td class="textlabel">');
        write('<input name="' + subGroupName + '.toccyDesc" id="toccyDesc" ' + cexchrtProps.get("toccyDesc_ENABLED") + ' hotKeyId="search1" type="text" class="label" size="50" maxlength="50" >&nbsp;');
        write('</td>');
        write('</tr>');
        //write('<td class="columnwidth"> </td>');
/*        write('<td class="textlabel">' + jspResArr.get("FLT025288") + '</td>');
        write('<td class="textfield">');
        write('<select name="' + subGroupName + '.txnType" id="txnType"  fdt="String" ' + cexchrtProps.get("txnType_ENABLED") + '   style="width: 179px;">');
        write('<option value="">' + jspResArr.get("FLT031698") + '</option>');
        write('<option value="T">' + jspResArr.get("FLT017004") + '</option>');
        write('<option value="C">' + jspResArr.get("FLT034217") + '</option>');
        write('</select>');
        write('</td>');
        write('<td class="columnwidth"> </td>');
        write('<td class="columnwidth"> </td>');
*/
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
        write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit">');
        }
        writeRefFooter();
        write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
        write('</div>');
        }else{
        write('<div class="ctable">');
        write('<input id="Accept" name="Go" type="button" class="button"        onClick="javascript:return cexchrt_crit_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT004977") + '" hotKeyId="Go">');
        write('<input id="Clear" name="Clear" type="button" class="button" value="' + jspResArr.get("FLT001439") + '"   onClick="javascript:return cexchrt_crit_ONCLICK2(this);"">');
        writeFooter();
        write('</div>');
        }
        } //End with()
}//End function

function fnOnLoad()
{
        var ObjForm = document.forms[0];

        initFocusHandler();

        pre_ONLOAD('cexchrt_crit',this);

        var funcName = "this."+"locfnOnLoad";
        if(eval(funcName) != undefined){
                eval(funcName).call(this);
        }

        fnPopulateControlValues();

        fnPopUpExceptionWindow(ObjForm.actionCode);
        if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
                checkCustErrExecNextStep(Message);
        }

        post_ONLOAD('cexchrt_crit',this);
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
        ObjForm.roleId.value = roleId;
        ObjForm.frmccyCode.value = frmccyCode;
        ObjForm.toccyCode.value = toccyCode;
//        ObjForm.txnType.value = txnType;
}


function cexchrt_crit_ONCLICK1(obj,p1)
{
        var retVal = "";
        if (preEventCall('cexchrt_crit',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnValAndSubmit(p1)) == false) {
                return false;
        }
        if (postEventCall('cexchrt_crit',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function cexchrt_crit_ONCLICK2(obj)
{
        var retVal = "";
        if (preEventCall('cexchrt_crit',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal =  fnClearFields()) == false) {
                return false;
        }
        if (postEventCall('cexchrt_crit',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}




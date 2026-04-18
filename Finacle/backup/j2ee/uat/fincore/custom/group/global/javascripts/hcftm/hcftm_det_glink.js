function printBlock()
{
	writeCustomHeader("hcftm_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<td>');
        write('<h1 class="page-heading">'+menuTitle+'</h1>');
        write('</td>');
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
	write('<a href="javascript:showHelpFile(\'hcftm_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") +'<font color=red size=2>*</font></td>');
	write('<td class="textfield"><select name="' + subGroupName + '.funcCode" id="funcCode" class="listboxfont" onChange="javascript:return hcftm_crit_ONCHANGE1(this);">');
	write('<option value="" selected>' + jspResArr.get("FLT026341") + '</option>');
        write('<option value="A">' + jspResArr.get("FLT026342") + '</option>');
	write('<option value="I">' + jspResArr.get("FLT026343") + '</option>');
	write('<option value="D">' + jspResArr.get("FLT026344") + '</option>');
    write('</select>');
    write('</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
    write('<td>&nbsp;</td>');
	write('</tr>');

        write('<tr>');
/*
        write('<td class="textlabel">' + jspResArr.get("FLT026333") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input hotKeyId="search1" type="text" class="textfieldfont" name="' + subGroupName + '.accNum" id="accNum"  fmnd="' + hcftmProps.get("accNum_MANDATORY") + '" ' + hcftmProps.get("accNum_ENABLED") + ' size="16" maxlength="16" onchange="javascript:return hcftm_ONCHANGE1(this,this,\'acctName\',\'acctSolId\',\'acctCrncy\',true,\'VALCUSTACCTID\');">&nbsp;');
        write('<a href="javascript:fnShowAccNum()" id="sLnk2">');
        write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" />');
        write('</a>');
        write('<input type="text" name="acctCrncy" id="acctCrncy" size="3" maxlength="3"  class="label" readonly="readonly" disabled>');
        write('<input type="text" name="acctSolId" id="acctSolId" size="8" maxlength="8"  class="label" readonly="readonly" disabled>');
        write('<input type="text" name="acctName" id="acctName"  size="25" maxlength="25" class="label" readonly="readonly" disabled>');
        write('<br>');
        write('</td>');
*/

	//write('<td class="columnwidth" style="height: 42px;" width="25%" colspan="1"> </td>');
	//write('<td class="textlabel" style="height: 42px;" width="25%" colspan="2">' + jspResArr.get("FLT026334") + '</td>');
	//write('<td class="textfield" style="height: 42px;" width="25%">');
        write('<td class="textlabel">' + jspResArr.get("FLT026334") + '<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
	write('<input  class="textfieldfont" type="text" name="' + subGroupName + '.CIFId" id="CIFId" ' + hcftmProps.get("CIFId_ENABLED") + ' maxlength="16" size="25" onchange="javascript:return hcftm_ONCHANGE2(this);">');
	write('&nbsp; <a target="_self" href="javascript:fnShowCifIDList()" id="sLnk3">');
   	write('<img hotKeyId="search1" src="../Renderer/images/INFENG/search_icon.gif" border="0" name="ImgCustId">');
    	write('</a>');
	write('</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('</tr>');
 	write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing"><spacer type="block" height="1" width="10"></spacer></td>');
    	write('</tr>');
        write('<tr class="subhdrbg">');
        write('<td colspan="10" class="subhdr">Customer Facility Details</td>');
        write('</tr>');
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing"><spacer type="block" height="1" width="10"></spacer></td>');
        write('</tr>');

	write('<tr>');
	write('<td class="columnwidth">&nbsp;</td>');
        write('</tr>');
        write('<tr>');
	write('<td class="textlabel">1.WhiteList AutoLien on Inward Remittance</td>');
	write('<td class="textfield">');
        write('<input type="radio" id="LnIrm" name="' + subGroupName + '.LnIrm" value="Y" title="Yes" fmnd="Y" fmb="Y" fdt="default" fblk="fblk1" onclick="javascript:return hcftm_det_ONCLICK28(this);">'); 
        write('' + jspResArr.get("FLT026335") + '');
        write('<input type="radio" id="LnIrm" name="' + subGroupName + '.LnIrm" value="N" checked title="No" fmnd="Y" fmb="Y" fdt="default" fblk="fblk1" onclick="javascript:return hcftm_det_ONCLICK29(this);">'); 
        write('' + jspResArr.get("FLT026336") + '');
        write('</td>');
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
	//if(funcCode =='A'){
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return hcftm_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return hcftm_det_ONCLICK2(this);" id="Clear" value="Clear">');
	//}else{
	//write('&nbsp;<input class="button" type="button" id="Back" value="OK" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	//}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	pre_ONLOAD('hcftm_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode !='A' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormControls(ObjForm);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
//	fnPostOnLoad()
	post_ONLOAD('hcftm_det',this);
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.funcCode.value = funcCode;
	//ObjForm.foracid.value = foracid;
	ObjForm.CIFId.value = CIFId;
}
function hcftm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (pre_ONCLICK('hcftm_det',obj) == false) { 
		return false;
	}
	if(fnIsNull(document.forms[0].CIFId.value)) {
                alert("Enter CifId");
                document.forms[0].CIFId.focus();
                return false;
    }
      var objForm = document.forms[0];
        if(objForm.funcCode.value=="A"){
        if(getRadioValue(objForm.LnIrm) == "N"){
          //if(!confirm("Customer Not Whitelisted?")){
                alert("Select Y");
                document.forms[0].LnIrm.focus();
                return false;
        //}
        }
        }


	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (post_ONCLICK('hcftm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcftm_det_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('hcftm_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('hcftm_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function hcftm_ONCHANGE1(obj,p1,p2,p3,p4,p5,p6){
       if ((retVal = fetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false){
                return false;
        }
}
function fetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType){
        if((retVal=fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID"))==false)
        {
                return false;
        }
}
function fnShowAccNum(){
        var objForm = document.forms[0];
        showAccountIdList(objForm.accNum,objForm.acctSolId,objForm.acctName,'F',objForm.acctCrncy,'','','');
}
function fnShowCifIDList(funcCode){
   var url = "../arjspmorph/"+applangcode+"/get_cust_id.jsp?wReturn="+document.forms[0].CIFId.id+"&wReturnDesc=NULL&preceedence=F&selVerifiedFlg=N";

        if ("Microsoft Internet Explorer" == browser_name)
        {
            var retVal = popModalWindowVar(url,"CifId",55,35,55,32);
            if (retVal != null && retVal != undefined )
            {
                var liarrBufArray = retVal.split("|");
                document.forms[0].CIFId.value = liarrBufArray[0];
            }
        }
        else{
            popModalWindowMozillaFrame(url,"CifId");
        }
}
function ShowVal(){
	alert("check");
}
function hcftm_det_ONCLICK28(obj){
        var retVal = "";
        if (preEventCall('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (preEventCallForLocale('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal = fnOnChangeGdprYn()) == false) {
                return false;
        }
        if (postEventCallForLocale('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (postEventCall('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function hcftm_det_ONCLICK29(obj){
        var retVal = "";
        if (preEventCall('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (preEventCallForLocale('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        if ((retVal = fnOnChangeGdprYn()) == false) {
                return false;
        }
        if (postEventCallForLocale('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        if (postEventCall('hcftm_det',obj,'ONCLICK') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function fnOnChangeGdprYn(){
        var objForm = document.forms[0];
        if(getRadioValue(objForm.LnIrm) == "Y"){
                alert("AutoLien WhiteListed");
        } else {
                alert("Not WhiteListed");
        }
        return true;
}
function hcftm_crit_ONCHANGE1(){
       var ObjForm = document.forms[0];
        if(document.forms[0].funcCode=="I"){
		document.forms[0].LnIrm[0].disabled = true;
		document.forms[0].LnIrm[1].disabled = true;
        }
       if(document.forms[0].CIFId.value != "") {
                //alert(document.forms[0].CIFId.value);
                var inputNameValues    = "CIFId|"+document.forms[0].CIFId.value;
                var outputNames     = "gacO";
                var scrName         = "ebhfctm002.scr";
                var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                var ret = retVal.split("|");
                //alert(ret[1]);
                if( ret[1] == "Y" ) {
                        alert("Customer Whitelisted from AutoLien");
                        document.forms[0].CIFId.focus();
                        radiobtn = document.getElementById("LnIrm");
                        radiobtn.checked = true;
                        return false;
		}else if( ret[1] == "D"){
                        alert("Customer Deleted from Whitelisting");
                        radiobtn = document.getElementById("LnIrm");
                        radiobtn.checked = false;
                        return true;
                }else{
                        alert("Customer Not Whitelisted");
                        radiobtn = document.getElementById("LnIrm");
                        radiobtn.checked = false;
                        return true;
                }
        }
        return true;
}
function hcftm_ONCHANGE2(){
		hcftm_crit_ONCHANGE1();
}

function printBlock()
{
	writeCustomHeader("cngentrn_det");
	with (document){
	
	//write('<input type="hidden" id="RecVerifyType" name="' + subGroupName + '.RecVerifyType">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">'+menuTitle+'</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	funcCodeDesc = "";
	
	if(funcCode == "A")
	{
		funcCodeDesc = "Add NewGen Transaction Limit";
		effectiveDate = BODDate
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
	write('<td class="textlabel">' + jspResArr.get("FLT031860") + '</td>');
	
	write('<td class="textfielddisplaylabel">');
	
	write('<label id="compField">' + effectiveDate + '</label>');
	write('</td>');
	
	write('</tr>');
	write('<tr>');
	
	write('<td class="textlabel">' + jspResArr.get("FLT031859") + '</td>');
	
	write('<td class="textfielddisplaylabel">');
	
	write('<label id="compField">' + drAccount + '</label>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031875") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + crAccount + '</label>');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
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
    write('<a id="sLnk1" href="javascript:showHelpFile(\'ormgendtl_help.htm\');">');
    write('<img src="../Renderer/images/' + applangcode + '/help.gif" width="47" height="21" vspace="1" border="0" hotKeyId="finHelp"></a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	
//header 1
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="3" class="subhdr">' + jspResArr.get("FLT031878") + '</td>');
	write('<td colspan="3" align="right" valign="middle">&nbsp;&nbsp;</td>');
	write('</tr>');
	


 //New limit details
    write('<tr id="tempMaxApproverLmtAmtrowId">');
    write('<td class="textlabel">' + jspResArr.get("FLT031949") + '</td>');
    write('<td width="29%" class="textfieldfont"><input id="tempMaxApproverLmtAmt" name="' + subGroupName + '.tempMaxApproverLmtAmt"  ' + cngentrnProps.get("tempMaxApproverLmtAmt_ENABLED") + ' type="text" enabled  size="25" maxlength="20">');
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
	 
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cngentrn_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cngentrn_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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
	alert(funcCode);
	if(funcCode=='I'){
		var ObjForm = document.forms[0];

	}
	var ObjForm = document.forms[0];
	if(funcCode=='P' || funcCode =='I' || funcCode =='X' ||funcCode =='i'){
		
		
		
	}
	else{
		
	}
	///alert("onload");
	
	initFocusHandler();

	pre_ONLOAD('cngentrn_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();
		//ObjForm.Submit.disabled = true;
		
		
	if(funcCode=='P' || funcCode =='I' || funcCode =='X' ||funcCode =='i'){
		//alert(funcCode);
		
	}
	if(funcCode =='I' || funcCode =='P' || funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('P',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cngentrn_det',this);
}

function fnCheckMandatoryFields(){
	var ObjForm = document.forms[0];
	return true;
}
function fnPopulateControlValues(){
	
	alert("Why !!!")
	alert(crAccount);
	alert(tempMaxApproverLmtAmt);
	var ObjForm = document.forms[0];

ObjForm.tempMaxApproverLmtAmt.value = tempMaxApproverLmtAmt;

return true;
	
}
function cngentrn_det_ONCLICK1(obj,p1){
	var retVal = "";
	if (preEventCall('cngentrn_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cngentrn_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cngentrn_det_ONCLICK2(obj,p1){
	var retVal = "";
	if (preEventCall('cngentrn_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cngentrn_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cngentrn_det_ONCLICK4(obj,p1){
	var retVal = "";
	var ObjForm = document.forms[0];

	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	
    
		
	ObjForm.Submit.disabled = false;
	ObjForm.Getquote.disabled = true;
	//return false;
	if (preEventCall('cngentrn_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function cngentrn_det_ONCLICK3(obj,p1){
	var retVal = "";
	if (preEventCall('cngentrn_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cngentrn_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}


function cngentrn_det_ONBLUR7(obj){
        var retVal = "";
        if (preEventCall('cngentrn_det',obj,'ONCHANGE') == false) {
                return false;
        }
        
        if (postEventCall('cngentrn_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}








function cngentrn_det_ONCHANGE10(obj){
	var retVal = "";
        if (pre_ONCHANGE('cngentrn_det',obj) == false) {
                return false;
        }    
        if ((retVal = fnFetchDraweeBranchDetails()) == false) {
                return false;
        }                   
	if (post_ONCHANGE('cngentrn_det',obj) == false) {
                return false;
        }
	return (retVal == undefined) ? true : retVal;
}

function fnDisableFormDataControls(b, f, d) {
    ADD = "A";
    POST = "P";
    COPY = "C";
    MODIFY = "M";
    VERIFY = "V";
    INQUIRY = "I";
    DELETE = "D";
    UNDELETE = "U";
    CANCEL = "X";
    REVERSAL = "E";
    CLOSE = "O";
    if (b == VERIFY || b == INQUIRY || b == DELETE || b == UNDELETE || b == CANCEL || b == REVERSAL || b == CLOSE || b == POST) {
        alert(b);
        var c = f.elements;
        var a = c.length;
        var e = arguments.length;
        if (Number(d) > 0) {
            disableHyperLnks(Number(d))
        } else {
            if (Number(d) == 0) {
                hideAnchors()
            }
        }
        for (i = 0; i < a; i++) {
            if ((c[i].type == "text") || (c[i].type == "textarea")) {
                c[i].readOnly = true;
                if (c[i].getAttribute("hotKeyId") == "LowLimit") {
                    c[i].readOnly = false
                }
            } else {
                if (c[i].type == "select-one") {
                    c[i].disabled = true
                } else {
                    if (c[i].type == "checkbox") {
                        c[i].disabled = true;
                        c[i].setAttribute("fds", "Y")
                    } else {
                        if (c[i].type == "radio") {
                            c[i].disabled = true
                        }
                    }
                }
            }
            if (f.menuName != null && f.menuName != undefined) {
                f.menuName.readOnly = false
            }
        }
        if ((f.Validate != undefined) && (f.Validate != null)) {
            f.Validate.disabled = true
        }
        if ((f.Cancel != undefined) && (f.Cancel != null)) {
            f.Cancel.disabled = true
        }
    }
    if (b != ADD && b != MODIFY && b != COPY) {
        if ((f.AddNew != undefined) && (f.AddNew != null)) {
            f.AddNew.disabled = true
        }
        if ((f.AddNewPage != undefined) && (f.AddNewPage != null)) {
            f.AddNewPage.disabled = true
        }
    }
}
function cngentrn_det_ONCHANGE1(obj){
	//alert("in");
        var retVal = "";
        if (preEventCall('cngentrn_det',obj,'ONCHANGE') == false) {
                return false;
        }
      
        if (postEventCall('cngentrn_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
function cngentrn_ONCHANGE7(obj){
        //alert("in");
        var retVal = "";
        if (preEventCall('cngentrn_det',obj,'ONCHANGE') == false) {
                return false;
        }
        
        if (postEventCall('cngentrn_det',obj,'ONCHANGE') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}

function showEventId(){
	
	
	var ObjForm = document.forms[0];
	//var FuncCode = ObjForm.funcCode.value;
    var inputNameValues = "funcCode|"+funcCode+"|drAccount|"+drAccount+"|crAccount|"+crAccount;
    var outputNames  = "maxApproverLmtAmt";
    var pageTitle    = "Event ID List for Approver Limit";
    var literalNames = "Event Id|Current Limit";
	var isPopulationReq = "true";
    var scrName      = "ebcngentrnPopulateEventId.scr";
    var hyperLnkCols = "1";
    var retVal       = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,true);
	
}







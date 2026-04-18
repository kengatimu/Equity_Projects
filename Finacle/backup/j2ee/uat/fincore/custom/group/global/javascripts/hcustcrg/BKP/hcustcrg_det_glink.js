function printBlock()
{
	writeCustomHeader("hcustcrg_det");
	with (document){
	write('<input type="hidden" id="endDate" fdt="fdate" mneb1="N" vFldId="endDate_ui" name="' + subGroupName + '.endDate">');
	write('<input type="hidden" id="startDate" fdt="fdate" mneb1="N" vFldId="startDate_ui" name="' + subGroupName + '.startDate">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031836") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT027516") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT007514") + '</td>');
	write('<td class="textfielddisplaylabel">');
        if(Level == "C")
        {
		write('<label id="compField">Cif Id</label>');
        }
        if(Level == "A")
        {
                write('<label id="compField">Account No</label>');
        }
        if(Level == "AG")
        {
                write('<label id="compField">Agreement</label>');
        }

	write('</td>');
	write('</tr>');
	write('<tr>');
	if(Level == "C")
	{
		write('<td class="textlabel">' + jspResArr.get("FLT031946") + '</td>');
		write('<td class="textfielddisplaylabel">');
		write('<label id="compField">' + cifId + '</label>');
		write('</td>');
	}
	if(Level == "A")
        {
                write('<td class="textlabel">' + jspResArr.get("FLT031945") + '</td>');
                write('<td class="textfielddisplaylabel">');
                write('<label id="compField">' + acctNum + '</label>');
                write('</td>');
        }
	if(Level == "AG")
        {
                write('<td class="textlabel">' + jspResArr.get("FLT031947") + '</td>');
                write('<td class="textfielddisplaylabel">');
                write('<label id="compField">' + EmpId  + '</label>');
                write('</td>');
        }
	
	
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
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	
	
	//write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
//	write('<tr>');
//	write('<td>');
	//----------------------------
        //--START DATE
        //----------------------------

        write('<td class="textlabel" style="height: 25px">' + jspResArr.get("FLT031861") + '');
        write('<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfield">');
        write('<input type="text"  hotKeyId="calender1" class="textfieldfont" fdt="uidate" mnebl="false" name="' + subGroupName + '.startDate_ui" onBlur="javascript: return  hcustcrg_det_ONBLUR1(this,this,this);" id="startDate_ui" fmnd="Y"  ' + hcustcrgProps.get("startDate_ui_ENABLED") + '>');
        write('<a  href="javascript:openDate(document.forms[0].startDate_ui,BODDate)"   id="sLnk15"><img alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');

	//----------------------------
        //--END DATE
        //----------------------------

         write('<td class="columnwidth">&nbsp;</td>');	
       // write('<td class="columnwidth"></td>');
        write('<td class="textlabel">' + jspResArr.get("FLT031862") + '</td>');
        write('<td class="textfield">');
        write('<input type="text"  hotKeyId="calender1" maxlength="15" fdt="uidate" class="textfieldfont" name="' + subGroupName + '.endDate_ui"  onBlur="javascript: return  hcustcrg_det_ONBLUR1(this,this,this);" id="endDate_ui"  fdt="String" ' + hcustcrgProps.get("endDate_ui_ENABLED") + '>');
        write('<a  href="javascript:openDate(document.forms[0].endDate_ui,BODDate)"   id="sLnk16"><img alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');
        write('</td>');
	write('</tr>');

	//----------------------------
	//--CHARGE ACCT NO
	//----------------------------

	write('<td class="textlabel">' + jspResArr.get("FLT031838") + '');
	write('<script>setMandatory("Y");<\/script></td>');
	write('<td class="textfield">');
write('<input type="text"  maxlength="16" class="textfieldfont" fmnd="Y" name="' + subGroupName + '.chrgAcctId" id="chrgAcctId"  fdt="String" ' + hcustcrgProps.get("chrgAcctId_ENABLED") + ' onchange="javascript:return hcustcrg_det_ONCHANGE1(this,this,\'sacctDesc\',\'ssolId\',\'sCrncyCode\',true,\'VALACCTID\');">');
	write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:showDrAcct()">');
	write('<IMG src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" height="17" border=0 hotKeyId="search1"></img></a>&nbsp;');
	write('<input class="label" id="sCrncyCode" name="'+subGroupName+'.sCrncyCode" fds="Y" size="4" maxlength="3" disabled>');
	write('<input class="label" id="ssolId" name="'+subGroupName+'.ssolId" fds="Y" size="5" maxlength="4" disabled>');
	write('<input class="label" id="sacctDesc" name="'+subGroupName+'.sacctDesc" size="50" border="0" maxlength=30 fds="Y" disabled>');
	write('</td>');

	//----------------------------
        //--EVENT TYPE 
        //----------------------------


	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">'+jspResArr.get("FLT200117")+'<script>setMandatory("Y");<\/script></td>');
	write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'hcustcrg_dethcustcrg_det\',this);" type="text" class="textfieldfont" fmnd="Y" fmb="Y" fdt="string" fblk="fblk1" fds="N" name="'+subGroupName+'.evtType" id="evtType" size="7" maxlength="5"  onChange="javascript:return hcustcrg_dethcustcrg_det_ONCHANGE5(this,\'evtTypeDesc\');" hotKeyId="search1">');
	write('&nbsp;<a target="_self" id="sLnk2" href="javascript:fnShowEventType()">');
	write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
       	write('<input class="label" id="evtTypeDesc" name="' + subGroupName + '.evtTypeDesc" size="30" border="0" maxlength=30 fds="Y" disabled></td>');
	write('</td>');
	write('</tr>');

	//----------------------------
        //--EVENT ID 
        //----------------------------

	write('<td class="textlabel">'+jspResArr.get("FLT200118")+'<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return fnchangeevntid;"  type="text" class="textfieldfont" fmnd="Y" name="'+subGroupName+'.evtId" id="evtId" size="27" maxlength="25" hotKeyId="search2">');
        write('&nbsp;<a target="_self" id="sLnk6" href="Javascript:fnShowEvtIDList()">');
        write('<img border="0" height="17" id="evtType" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</td>');
        write('</tr>');
        write('<tr>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('</tr>');
	write('</tr>');
	write("</table>");
	write("</td>");
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return hcustcrg_det_ONCLICK2(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	//write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return hcustcrg_det_ONCLICK3(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return hcustcrg_det_ONCLICK4(this,this.id);"" hotKeyId="Cancel">');
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
	//document.getElementById("id_actDtls_subtab").style.display = 'none';
	initFocusHandler();

	pre_ONLOAD('hcustcrg_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	fnPopulateControlValues();

	fnAssignDateOnLoad(ObjForm);

	if(funcCode =='V' || funcCode =='I' || funcCode =='C' || funcCode =='X' ||  funcCode =='S' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	if (funcCode =='A' || funcCode =='M' ){
		fnMntnFormDataControls();
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	

	post_ONLOAD('hcustcrg_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	//ObjForm.endDate.value = endDate;
	ObjForm.startDate_ui.value= startDate;
	ObjForm.startDate.value= startDate;
	ObjForm.endDate.value= endDate;
	ObjForm.endDate_ui.value= endDate;
	ObjForm.evtType.value = evtType;
        ObjForm.evtId.value = evtId;
        ObjForm.chrgAcctId.value = chrgAcctId;

}
function hcustcrg_det_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('hcustcrg_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('hcustcrg_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}



function hcustcrg_det_ONBLUR1(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('hcustcrg_det',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = onBlurFormatDate(p1)) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnEnter(p2)) == false) {
		return false;
	}
	if (postEventCall('hcustcrg_det',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('hcustcrg_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hcustcrg_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('hcustcrg_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hcustcrg_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_det_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('hcustcrg_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('hcustcrg_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}


function hcustcrg_det_ONCHANGE1(g,h,f,d,c,b,a)
{
	var retVal = "";
	if(preEventCall("hcustcrg_det",g,"ONCHANGE")==false){
		return false;
	}
	if((retVal=fnCommonFetchAcctDtls(h,f,d,c,b,a))==false){
		return false;
	}
	document.forms[0].tranCrncyCode.value=document.forms[0].sCrncyCode.value;
	if(postEventCall("hcustcrg_det",g,"ONCHANGE")==false){
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}



function hcustcrg_det_ONCHANGE2(g,h,f,d,c,b,a)
{
	var retVal = "";
	if(preEventCall("hcustcrg_det",g,"ONCHANGE")==false){
		return false;
	}
	if((retVal=fnCommonFetchAcctDtls(h,f,d,c,b,a))==false){
		return false;
	}
	if(postEventCall("hcustcrg_det",g,"ONCHANGE")==false){
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_det_ONCHANGE4(g)
{
	var retVal = "";
	if(preEventCall("hcustcrg_det",g,"ONCHANGE")==false){
		return false;
	}
	/*if((retVal=fnOnChangeCCY(g))==false){
		return false;
	}*/
	if (g.value!=""){
		document.forms[0].chqDate_ui.fmnd='Y';	
	}else{
		document.forms[0].chqDate_ui.fmnd='N';	
	}	
	if(postEventCall("hcustcrg_det",g,"ONCHANGE")==false){
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_det_ONCHANGE7(obj)
{
	var retVal = "";
	if(preEventCall("hcustcrg_det",obj,"ONCHANGE")==false){
		return false;
	}
	document.forms[0].tranCrncyCode.value ='KES';
	if (document.forms[0].payType.value == 'TransferFromBankToCustomer'){
		document.forms[0].receiverPartyIdType.value='1';
		document.forms[0].rPhnNum.fmnd='Y';
		document.forms[0].receiverPartyId.fmnd='N';
		document.forms[0].rPhnNum.focus();
		document.forms[0].receiverPartyId.value='';
		document.forms[0].receiverPartyAcctRef.value='';
	}
	
	if (document.forms[0].payType.value == 'FSItoPayBill'){
		document.forms[0].receiverPartyIdType.value='4';
		document.forms[0].receiverPartyId.fmnd='Y';
		document.forms[0].rPhnNum.fmnd='N';
		document.forms[0].receiverPartyId.focus();
		document.forms[0].rPhnNum.value='';
		
		
	}

	if (document.forms[0].payType.value == 'FSItoMerchant'){
		document.forms[0].receiverPartyIdType.value='2';
		document.forms[0].receiverPartyId.fmnd='Y';
		document.forms[0].rPhnNum.fmnd='N';
		document.forms[0].receiverPartyId.focus();
		document.forms[0].rPhnNum.value='';
		
	}
	if(postEventCall("hcustcrg_det",obj,"ONCHANGE")==false){
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_det_ONCHANGE6(obj)
{
	var retVal = "";
	if(preEventCall("hcustcrg_det",obj,"ONCHANGE")==false){
		return false;
	}
	document.forms[0].tranCrncyCode.value ='KES';
	if (document.forms[0].payTo.value == 'ACCOUNT'){
		document.forms[0].rPhnNum.value='';
		document.forms[0].rPhnNum.fmnd='N';
		document.forms[0].recAcctNo.fmnd='Y';
		document.forms[0].recAcctNo.focus();
		document.forms[0].rPhnNum.disabled = "disabled";
		document.forms[0].cardNumber.fmnd='N';
		document.forms[0].cardNumber.value='';
		document.forms[0].cardAcctNum.value='';
		document.forms[0].cardProductCode.value='';
	}
	
	if (document.forms[0].payTo.value == 'PHONE'){
		document.forms[0].rPhnNum.fmnd='Y';
		document.forms[0].rPhnNum.focus();
		document.forms[0].recAcctNo.fmnd='N';
		document.forms[0].recAcctNo.disabled = "disabled";
		document.forms[0].recAcctNo.value='';
		document.forms[0].rPhnNum.fmnd='N';
		document.forms[0].cardNumber.fmnd='N';
		document.forms[0].cardNumber.value='';
		document.forms[0].cardAcctNum.value='';
		document.forms[0].cardProductCode.value='';
		
	}

	if (document.forms[0].payTo.value == 'CARD'){
		document.forms[0].rPhnNum.fmnd='N';
		document.forms[0].rPhnNum.value='';
		document.forms[0].recAcctNo.fmnd='N';
		document.forms[0].recAcctNo.value='';
		document.forms[0].recAcctNo.disabled = "disabled";
		document.forms[0].rPhnNum.disabled = "disabled";
		document.forms[0].cardNumber.focus();
		document.forms[0].cardNumber.fmnd='Y';
		
	}
	if(postEventCall("hcustcrg_det",obj,"ONCHANGE")==false){
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function hcustcrg_det_ONBLUR5(b,c){
	var a="";
	if(preEventCall("hcustcrg_det",b,"ONBLUR")==false){
		return false;
	}
	
	if((a=newformatAmt("Million",b,"KES","N"))==false){
		return false;
	}
		
	if(postEventCall("hcustcrg_det",b,"ONBLUR")==false){
		return false;
	}
	return(a==undefined)?true:a;
}

function hcustcrg_det_ONBLUR7(obj)
{
		var retVal = "";
		if (preEventCall('hcustcrg_det',"ONBLUR") == false) {
				return false;
		}
		if (preEventCall('hcustcrg_det',"ONBLUR") == false) {
				return false;
		}
		return (retVal == undefined) ? true : retVal;
}



function hcustcrg_ONCLICK41(b,c)
{
	var a="";
	if(preEventCall("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	if(preEventCallForLocale("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	if((a=fnToggleTextDisplay(c))==false)
	{
		return false
	}
	if(postEventCallForLocale("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	if(postEventCall("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	return(a==undefined)?true:a
}

function hcustcrg_ONCLICK42(b,c)
{
	var a="";
	if(preEventCall("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	if(preEventCallForLocale("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	if((a=fnToggleTextDisplay(c))==false)
	{
		return false
	}
	if(postEventCallForLocale("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	if(postEventCall("hcustcrg",b,"ONCLICK")==false)
	{
		return false
	}
	return(a==undefined)?true:a
}

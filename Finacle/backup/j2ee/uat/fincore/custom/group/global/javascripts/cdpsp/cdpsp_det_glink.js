function printBlock()
{
	writeCustomHeader("cdpsp_det");
	document.write('<input type="hidden" id="frmDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="frmdate_ui" name="' + subGroupName + '.frmDate">');
    document.write('<input type="hidden" id="toDate" fdt="fdate" fmnd="Y"  mneb1="N" vFldId="todate_ui" name="' + subGroupName + '.toDate">');
    document.write('<input type="hidden" id="hidchrg" name="' + subGroupName + '.hidchrg">');
    document.write('<input type="hidden" id="noOfPages" name="' + subGroupName + '.noOfPages">');
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Pass Sheet Printing</td>');
	write('</tr>');
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
	write('<a href="javascript:showHelpFile(\'cdpsp_det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;');
	write('</td>');
	write('</tr>');


	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026332") + '&nbsp;<font color="red">*</font></td>');
	write('<td> <input class="textfieldfont"  mnebl="false" " name="' + subGroupName + '.acctNum" id="acctNum" type="text" class="textfieldfont" maxlength="16" value="" onchange="javascript:fnOnchange()">');
	write('<a href="javascript:fnshowAccountIdList(document.forms[0].acctNum);" id="sLnk2" >');
	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img></a>');
	write('<div style="position:absolute;"></div>');
        write('&nbsp;&nbsp;<a id="sLnk5" href="javascript:showAcctDetails()">');
        write('<img src="../Renderer/images/' + applangcode + '/explode.gif" width="16" height="16" border="0" explodeId="explode1"></a>');

	write('&nbsp;&nbsp;<a id="sLnk4" href="javascript:showFinacleSignature();">');
        write('<img class="img" title="' + jspRes.FLT026332 + '" src="../Renderer/images/' + applangcode + '/sig_new1.gif" width="16" height="18" border="0"></img></a></td>');
       write('<td><input class="label" id="solId" name="' + sGroupName + '.solId" fds="Y" size="6" maxlength="8" disabled>');      
       write('<input class="label" id="acctName" name="' + sGroupName + '.acctName" fds="Y" size="6" maxlength="8" disabled></td>');      
       write('<td><input class="label" id="acctEffBal" name="' + sGroupName + '.acctEffBal" fds="Y" size="10" maxlength="8" disabled></td>');
      // write('<td><input class="label" id="todate_ui" name="' + sGroupName + '.todate_ui" fds="Y" size="10" maxlength="10" disabled></td>');

	//write('<input class="label" id="acctDesc" name="' + sGroupName + '.acctDesc" size="50" border="0" maxlength=30 fds="Y" disabled></td>');
	write('</tr>');
	write('<tr>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT026336") + '<font color="red" size="2"> *</font></td>');
	write('<td><input type="text" class="textfieldfont" id="frmdate_ui"" name="' + subGroupName + '.frmdate_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1" onBlur = "javascript:validateDateOnBlur1(this,this,this);">');
	write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].frmdate_ui,BODDate)">');
	write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('<div style="position:absolute;"></div>');
	write('</td>');
	
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '<font color="red" size="2"> *</font></td>');
	write('<td><input type="text" class="textfieldfont" id="todate_ui"" name="' + subGroupName + '.todate_ui" fdt="uidate" mnebl="false" fmnd="Y"  fblk="defaultFblk1" hotKeyId="calender1" onBlur = "javascript:validateDateOnBlur(this,this,this);">');
	write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].todate_ui,BODDate)">');
	write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
	write('<div style="position:absolute;"></div>');
	write('</td>');
	/*
	write('<td class="textlabel">' + jspResArr.get("FLT026337") + '&nbsp;<font color="red">*</font></td>');
	write('<td><input type="text" class="textfieldfont" id="todate_ui"" name="' + subGroupName + '.todate_ui" fdt="todate_ui" mnebl="false" fmnd="Y" fblk="defaultFblk1" hotKeyId="calender1">');
        write('<a id="frmDateImg" href="javascript:openDate(document.forms[0].todate_ui,BODDate)">');
        write('<img width="24" height="19" src="../images/INFENG/calender.gif" align="absmiddle" border="0" alt="Date picker" style="cursor:hand"></a>');
        write('<div style="position:absolute;"></div>');
	write('</td>');
       */
       
       ////////////////
        write('<tr>');
        write('<td class="textlabel">' + jspResArr.get("FLT002784") + '</td>');
        write('<td class="textfield">');
        write('<input type="checkbox" name="' + subGroupName + '.chkfrom_last_print" id="chkfrom_last_print"  onClick="javascript:fnOnchangeLastPrint();">From Last Printed Date');
        write('<td class="textlabel">' + jspResArr.get("FLT001824") + '</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.print_no_tran" id="print_no_tran"  fmnd="N" value="Y">Yes');
	write('<input type="radio" name="' + subGroupName + '.print_no_tran" id="print_no_tran"  fmnd="N" value="N">No');
	write('</td>');
	
	write('</tr>');

       ////////////
	write('</tr>');	
	write('<tr>');
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
	write('<div class="ctable">');
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cdpsp_det_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	//write('<input name="Clear" type="reset" class="button"  id="Clear" value="Clear">');
	write('<input type="button" name="Clear" value="Clear" class="button" id="Clear" onClick="javascript:return cdpsp_det_ONCLICK3(this);">');
	writeFooter();
	write('</div>');
	} 
}
	function pre_ONLOAD(){
	document.forms[0].todate_ui.value = BODDate;
	document.forms[0].acctNum.value = acctNum;
	document.forms[0].frmdate_ui.value = frmdate_ui;
	}
	
function fnOnchangeLastPrint()
{	
	if(document.forms[0].chkfrom_last_print.checked == true)
	{
		document.forms[0].chkfrom_last_print.value = "Y";
		if(document.forms[0].acctNum.value != "")
		{
			var input = "acctID|"+document.forms[0].acctNum.value;
			var scrName = "cdpspdp004.scr";
			var output = "";
			var arrRetVal = appFnExecuteScript(input,"output",scrName,false);
			var arrAcctDet = new Array();
			arrAcctDet  = arrRetVal.split("|");
			document.forms[0].frmdate_ui.value = arrAcctDet[1];
			document.forms[0].frmdate_ui.disabled = true;
		
		}
		else
		{
		      alert("Please Enter Account Number");
		}

	}
	else
	{
		document.forms[0].chkfrom_last_print.value = "N";
		document.forms[0].frmdate_ui.value = "";
		document.forms[0].frmdate_ui.disabled = false;
	}
	
}

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	pre_ONLOAD('cdpsp_det',this);
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}
	fnPostOnLoad()
	post_ONLOAD('cdpsp_det',this);
	fnPopulateControlValues();
	
	
}

function fnOnchange() 
{
	var foracid 			= document.forms[0].acctNum.value.toUpperCase();
	if(foracid != "") 
    {
    if (profileId=="11")
    {
	// Document Expiration Check --- Anderson
	if (document.forms[0].acctNum.value != "") {
		var inputNameValues = "foracid|" + document.forms[0].acctNum.value;
		var outputNames = "msgFlg";
		var scrName = "checkDocExpDate.scr";
		retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		retVal = retVal.split("|");
		if (retVal[1]) {
			alert(retVal[1]);
		}
	}
	// End Document Expiration Check --- Anderson
  }

	var inputNameValues		= "acctNum|"+foracid 
	var outputNames		    = ""
	var scrName			    = "cdpspdp002.scr";
	var retVal			    = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret				    = retVal.split("|");
       if(ret[0] == "Error" && ret[1]!="dummy")
        {
			alert(ret[1]);	
			document.forms[0].acctNum.value = "";
			document.forms[0].acctEffBal.value = "";
			document.forms[0].solId.value = "";
			document.forms[0].acctName.value = "";
			return false;
        }
		else 
		{
			if( ret[2] == "amount" && ret[3] != "dummy" )
			{
				document.forms[0].acctEffBal.value = ret[3];
				newformatAmt("Million",document.forms[0].acctEffBal,ret[9],'N');
			}

			if( ret[4] == "solId" && ret[5] != "dummy" )
			{
				document.forms[0].solId.value = ret[5];
			}

			if( ret[6] == "acctName" && ret[7] != "dummy" )
			{
				//document.forms[0].acctName.value = ret[7];
				  document.forms[0].acctName.value = ret[7].replace(/[&\/\\#,+()$~%.'":*?<>{}]/g, '');
			}		
		}
	}
	else 
	{
		document.forms[0].acctEffBal.value = "";
		document.forms[0].solId.value = "";
		document.forms[0].acctName.value = "";
	}
}

function fnValidateData()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];
	ObjForm.acctNum.value = acctNum;
	ObjForm.frmdate_ui.value = frmdate_ui;
	ObjForm.todate.value = todate;
	ObjForm.todate.print_no_tran = print_no_tran;
	//ObjForm.noOfPages.value = noOfPages;
	return true;
}

function fnOnLoad()
{
	var ObjForm = document.forms[0];
	pre_ONLOAD('cdpsp_det',this);
	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}
	checkRadio(objForm.print_no_tran,"N");
	document.forms[0].chkfrom_last_print.value = "N";
}

function cdpsp_det_ONCLICK1(obj,p1)
{
       
	if(document.forms[0].acctNum.value == ""){
		alert("Account Number is mandatory");
		document.forms[0].acctNum.focus();
		return false;
	}
	if(document.forms[0].frmdate_ui.value == ""){
		alert("From Date is mandatory");
		document.forms[0].frmdate_ui.focus();
		return false;
	}	
	if(document.forms[0].todate_ui.value == ""){
		alert("To Date is mandatory");
		document.forms[0].todate_ui.focus();
		return false;
	}
	


     
	if ( document.forms[0].frmdate_ui.value !="")
        {
              var cmpdate=fnCompareDates(document.forms[0].frmdate_ui.value,BODDate);
		if(cmpdate == false)
                {
                        alert("From Date should be less than or equal to BOD date");
                        document.forms[0].frmdate_ui.focus();
                        return false;
                }

          }
	if ( document.forms[0].todate_ui.value !="")
        {
              var cmpdate=fnCompareDates(document.forms[0].todate_ui.value,BODDate);
		if(cmpdate == false)
                {
                        alert("To Date should be less than or equal to BOD date");
                        document.forms[0].todate_ui.focus();
                        return false;
                }

          }
	if ( document.forms[0].frmdate_ui.value !="" && document.forms[0].todate_ui.value !="")
        {
              var cmpdate=fnCompareDates(document.forms[0].frmdate_ui.value,document.forms[0].todate_ui.value);
		if(cmpdate == false)
                {
                        alert("From Date should be less than or equal to To Date");
                        document.forms[0].frmdate_ui.focus();
                        return false;
                }
          }

	
	if((document.forms[0].acctNum.value != "") && (document.forms[0].frmdate_ui.value != "") && (document.forms[0].todate_ui.value != "")){
		var foracid = document.forms[0].acctNum.value.toUpperCase();
		var frmdate_ui = document.forms[0].frmdate_ui.value;
		var todate_ui  = document.forms[0].todate_ui.value;
		var print_no_tran = getRadioValue(document.forms[0].print_no_tran);
		var inputNameValues		= "acctNum|"+foracid +"|frmdate_ui|"+frmdate_ui +"|todate_ui|"+todate_ui+"|print_no_tran|"+print_no_tran;
		var outputNames = "";
		var scrName     = "cdpspdp001.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");

		if(ret[0] == "ErrOcc") {
			alert(ret[1]);
			return false;
		}
		else if(ret[0]=="NoOfPg"){
			noofpg = ret[1];
			chrgAmt = ret[3];
			chargeamt =  ret[5];
			chrgAvl = ret[7];
			surl = "../custom/jsp/cdpspdp001.jsp"
			surl = surl + "?"
			surl = surl + "noofpg="+noofpg
			surl = surl + "&chrgAmt="+chrgAmt 
			surl = surl + "&chargeamt="+chargeamt 
           		 surl = surl + "&chrgAvl="+chrgAvl 
			argsVariable = ""
			var returnV = window.showModalDialog(surl,argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
			if(returnV != undefined){
				if(returnV.status == 'F'){
				return false;
				}
			}
			else {
				return false;
			}
			if(chrgAvl == "N") {
        		var collect = window.confirm("Account is not having sufficient balance for charge collection.Do you want to proceed");
				if(collect == false) {
					return false;
				}
			}
			document.forms[0].hidchrg.value=chargeamt;
			document.forms[0].noOfPages.value=noofpg;
			//alert(chargeamt);
			retVal = ""
			if ((retVal = fnValAndSubmit(p1)) == false) {                   
                     return false;
        	}
			return (retVal == undefined) ? true : retVal;
		}
	}
 
}


function fnshowAccountIdList(obj){
	showAccountIdList(obj,null,null,'F');
	fnOnchange();
}

function openDate(obj,inpDate)
{
        var date = "";
        if(inpDate == null)
        inpDate = '';
        /* Date selector enhancement:Start */
        var objName = String(obj.name);
        var hidObj = document.getElementsByName(objName);

        var i = (obj.fmult == "Y")?obj.recNum:0;
        var hidVal = hidObj[i].value;

        if((calbase == "01")&&(hidVal != null)&&(hidVal != "")&&(hidVal != "undefined"))
        {
            if(!chkHijriMapping(hidVal))
            {
                    alert(finbranchResArr.get("FAT002843"));
                    return;
            }
        }
        hidVal = (!fnIsValidContextDate(hidObj[i]))?inpDate:hidVal;

        date = popCalendarModalWindowVar("../arjspmorph/"+applangcode+"/date.jsp?txtDate="+obj.id+"&date="+inpDate+"&dateVal="+hidVal+"&calbase="+calbase,"Calendar",225
,160,15,12);
        /* Date selector enhancement:End  */

        if(date != null)
        {
            //set the value to ui and hidden fields.
        obj.value = fnConvertToUIDate(date);
        fnAssignDateOnEnter(obj);

                /*changes for the ticket 246672*/
            fnSetFocusForDate(obj);
        }

}
//This function validates date, when the focus goes out of the date field
function validateDateOnBlur1(obj,p1,p2)
{
	//alert(obj.id);
	//alert(p1.id);
	//alert(p2.id);
    var retVal = "";

    if ((retVal = onBlurFormatDate(p1)) == false) {
        return false;
    }
    if ((retVal = fnAssignDateOnEnter(p2)) == false) {
        return false;
    }

    return (retVal == undefined) ? true : retVal;
}

objForm = document.forms[0];

//ADDED FOR SVS INTEGRATION
 function showFinacleSignature(){
  if(SVS_Flag != undefined  && SVS_Flag == "Y" ){
    showSVSSignature();
  }else{
   showSignature();
  }
}
 function showSVSSignature(){
        if (fnIsNull(objForm.acctNum.value)) {
	alert("Please enter the account number");
        objForm.acctNum.focus();
        return;
        }
        var data = '?sAcctId='+escape(objForm.acctNum.value)+'&sSolId='+escape(objForm.solId.value)+'&sActiveDate='+escape(BODDate)+'&fromAppId='+escape("CoreServer")+'&to enu=hacm&contextSwitch=Y';
         displaySVSWindow(data);
}

function showSignature(){
        if (fnIsNull(objForm.acctNum.value)) {
	alert("Please enter the account number");
        objForm.acctNum.focus();
        return;
    }
    if (isFabAvbl == 'Y'){
        displaySignatureWindow(sGroupName,document.forms[0].acctNum.value);
    }else{
        alert(finbranchResArr.get("FAT000248"));
        return;
    }
}
function cdpsp_det_ONCLICK3(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cdpsp_det',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cdpsp_det',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function callbackSVS(data,menu) {
//SVS 
}

function showAcctDetails() {
	var frm = document.forms[0];
        if (fnIsNull(frm.acctNum.value)) {
                alert(finbranchResArr.get("FAT000200"));
                frm.acctNum.focus();
                return;
        }
        var sUrl = "../arjspmorph/"+applangcode+"/acctdtls.jsp?acctId="+escape(frm.acctNum.value);
        popModalWindow(sUrl,"Acct Details");
}

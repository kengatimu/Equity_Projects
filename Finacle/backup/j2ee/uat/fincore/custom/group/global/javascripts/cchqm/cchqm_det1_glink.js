function printBlock()
{
	writeCustomHeader("cchqm_det1");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Cheque Book Maintenance</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">Function :</td>');
	if(funcCode=='U'){
		requestId='N/A' 
		funcDesc="Issue"
	}
	if(funcCode=='A'){funcDesc="Add"; }
        if(funcCode=='B'){funcDesc='Sent TO Destination Branch'; }
        if(funcCode=='K'){funcDesc='Aknowledgement At Destination Branch'; }
        if(funcCode=='I'){funcDesc='Inquire'; }
        if(funcCode=='D'){funcDesc='Delete'; }
        if(funcCode=='V'){funcDesc='Verify'; }
	write('<td class="textfielddisplaylabel">'+funcCode+ " - " +funcDesc+'</td>');
	if(funcCode != 'A'){
		write('<td class="textlabel">Request Id :</td>');
 		write('<td class="textfielddisplaylabel">'+requestId+'</td>');
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
	write('<a href="javascript:showHelpFile(\'cchqm_det1_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="47" height="21"  vspace="1" border="0" align="right"></a>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000228") + '</td>');
	write('<td><input name="' + subGroupName + '.acctNo" id="acctNo" ' + cchqmProps.get("acctNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:fnOnchangeM(this)" >');
//363819
write('&nbsp;<input name="' + subGroupName + '.acctname" id="acctname" ' + cchqmProps.get("acctname_ENABLED") + ' type="text" disabled="true" class="label onChange="javascript:fnname(acctNo);">');
//363819
//	write('<a href="javascript:fnshowAccountIdList(document.forms[0].acctNo);" id="sLnk2" >');
//	write('<img hotKeyId="search1" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0"></img>');
	document.forms[0].acctNo.disabled = true;
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000028")  + '<font color="red" size="2"> *</font></td>'); 
	write('<td><input name="' + subGroupName + '.noOfChqs" id="noOfChqs" ' + cchqmProps.get("noOfChqs_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:fnOnchangeNoChqs(this)" >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000039")  + '<font color="red" size="2"> *</font></td>'); 
	write('<td><input name="' + subGroupName + '.leaves" id="leaves" ' + cchqmProps.get("leaves_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onchange="javascript:fnOnchangeLeaves(this)" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT019668")  + '<font color="red" size="2"> *</font></td>'); 
	write('<td><input name="' + subGroupName + '.startChqNo" id="startChqNo" ' + cchqmProps.get("startChqNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
	
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000129") + '</td>');
	write('<td><input name="' + subGroupName + '.reqStat" id="reqStat" ' + cchqmProps.get("reqStat_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT11000029") + '</td>');
	write('<td><input name="' + subGroupName + '.endChqNo" id="endChqNo" ' + cchqmProps.get("endChqNo_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
	write('</td>');
	write('</tr>');
        if (profileId == "43")
        {
		write('<tr>');
		//write('<td class="textlabel">Destination Branch<script>setMandatory("Y");</script></td>');
		write('<td class="textlabel">' + jspResArr.get("FLT11000131") + '<script>setMandatory("Y");</script></td>');
		write('<td><input name="' + subGroupName + '.destbranch" id="destbranch" ' + cchqmProps.get("destbranch_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange="javascript:fnbrnch();">');
        	write('<a target=_self id="sLnk4" href="javascript:showSolId(document.forms[0].destbranch,\'ctrl\',\'F\',document.forms[0].destbranchdesc)">');
        	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        	write('</a>');
		//write('<input name"' + subGroupName + '.destbranchdesc" id="destbranchdesc" type="text" class="textfieldfont" onChange="javascript:fnbrnch();" size="25" maxlength="16" readonly disabled>');
		write('<input name"' + subGroupName + '.destbranchdesc" id="destbranchdesc" type="text" class="label" size="25" maxlength="16" readonly disabled>');
		write('</td>');
        	//write('<td class="columnwidth"> </td>');
		write('<td class="textlabel">Charg Amount</td>');
		write('<td><input name="' + subGroupName + '.chrgCrncy" id="chrgCrncy" ' + cchqmProps.get("chrgCrncy_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="16" width="45px" readonly disabled >');
		write('<input name="' + subGroupName + '.chrgAmt" id="chrgAmt" ' + cchqmProps.get("chrgAmt_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="16" width="45px" >');
		write('</td>');
		write('</tr>');
                write('<tr>');
                write('<td class="columnwidth"> </td>');
                write('<td class="columnwidth"> </td>');
                write('<td class="textlabel">VAT Amount</td>');
                write('<td><input name="' + subGroupName + '.vatCrncy" id="vatCrncy" ' + cchqmProps.get("vatCrncy_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="16" width="45px" readonly disabled >');
                write('<input name="' + subGroupName + '.vatAmt" id="vatAmt" ' + cchqmProps.get("vatAmt_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="16" width="45px" >');
                write('</td>');
                write('</tr>');

	} 
	if (profileId == "56")
	{
		write('<tr>');
	    //write('<td class="textlabel">' + jspResArr.get("FLT11000130") + '</td>');
		write('<td class="textlabel">Collection Branch<script>setMandatory("Y");</script></td>');
	    write('<td><input name="' + subGroupName + '.instType" id="instType" ' + cchqmProps.get("instType_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" >');
		//write('&nbsp;<a target="_self" id="sLnk3" href="JavaScript:getInstrTypeList(document.forms[0].instType,document.forms[0].acctNo.value,\'ctrl\',\'F\')">');
		//write('<IMG src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border=0 hotKeyId="search3"></IMG></a>');
		write('</tr>');
	}
	if (profileId == "50")
	{
		write('<tr>');
                //write('<td class="textlabel">Destination Branch<script>setMandatory("Y");</script></td>');
		write('<td class="textlabel">' + jspResArr.get("FLT11000131") + '<script>setMandatory("Y");</script></td>');
                write('<td><input name="' + subGroupName + '.destbranch" id="destbranch" ' + cchqmProps.get("destbranch_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="16" onChange="javascript:fnbrnch();">');
                write('<a target=_self id="sLnk4" href="javascript:showSolId(document.forms[0].destbranch,\'ctrl\',\'F\',document.forms[0].destbranchdesc)">');
                write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
                write('</a>');
                write('<input name"' + subGroupName + '.destbranchdesc" id="destbranchdesc" type="text" class="label" size="25" maxlength="16" readonly disabled>');
                write('</td>');
                write('<td class="columnwidth"> </td>');
                write('<td class="textlabel"> </td>');
                write('<td class="textfield"> </td>');
                write('</tr>');
	}
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
	write('<input name="Submit" type="button" class="button" onClick="javascript:return cchqm_det1_ONCLICK1(this,this);" id="Submit" value="Submit" hotKeyId="Submit">');
	write('<input name="Clear" type="button" class="button" onClick="javascript:return cchqm_det1_ONCLICK2(this);" id="Clear" value="Cancel">');
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
	pre_ONLOAD('cchqm_det1',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	if(funcCode =='V' || funcCode =='I' || funcCode =='P' || funcCode =='R' || funcCode =='B' || funcCode =='K' || funcCode =='D')
	{
        var inputNameValues = "requestId|"+requestId;
        var outputNames     = "acctnum";
        var scrName         = "chqbkdp002.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        var output = ret1[1];
	acctNo=output;	
		
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='X' || sReferralMode =='I' || sReferralMode =='S' || funcCode =='P' || funcCode =='R' || funcCode =='B' || funcCode =='K'){
		//fnDisableFormControls(ObjForm);
		ObjForm.acctNo.disabled= true ;
		ObjForm.noOfChqs.disabled= true ;
		ObjForm.leaves.disabled= true ;
		ObjForm.startChqNo.disabled= true ;
		ObjForm.endChqNo.disabled= true ;
		ObjForm.reqStat.disabled= true ;
        	if (profileId == "43")
        	{
			ObjForm.destbranch.disabled= true ;
			ObjForm.chrgCrncy.disabled= true ;
			ObjForm.chrgAmt.disabled= true ;
			ObjForm.vatCrncy.disabled= true ;
			ObjForm.vatAmt.disabled= true ;
			hideImage("sLnk4");
		}
	}
ObjForm.acctNo.value=acctNo;
ObjForm.acctname.value=acctname;

	if (profileId == "43")
	{
		if(funcCode =='A')
		{
			ObjForm.startChqNo.value = "";
			ObjForm.endChqNo.value = "";
			ObjForm.startChqNo.disabled= true ;
			ObjForm.endChqNo.disabled= true ;
			ObjForm.reqStat.disabled= true ;
			ObjForm.chrgAmt.disabled= true ;
			ObjForm.vatAmt.disabled= true ;

		}
	}
	if(funcCode=='U'){
		ObjForm.endChqNo.disabled=true;
                ObjForm.reqStat.disabled=true;
		ObjForm.reqStat.value='N';
	}	
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cchqm_det1',this);
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
        if (profileId == "43")
        {
		ObjForm.destbranch.value=destbranch;
		ObjForm.chrgCrncy.value=chrgCrncy;
		ObjForm.chrgAmt.value=chrgAmt;
		ObjForm.vatCrncy.value=vatCrncy;
		ObjForm.vatAmt.value=vatAmt;
	}
	if (profileId == "50")
	{
		ObjForm.destbranch.value=destbranch;
	}

	if(funcCode == 'A'){
		ObjForm.reqStat.value = 'E';
	}
	else{
	ObjForm.reqStat.value=reqStat;
	}
//	ObjForm.instType.value=instType;
	return true;
}


function IsNumeric(sText)
{
        var ValidChars = "0123456789", IsNumber=true, Char;
        for (i = 0;i < sText.length && IsNumber == true;i++)
        {
                Char = sText.charAt(i);
                if(ValidChars.indexOf(Char) == -1)
                IsNumber = false;
        }
        return IsNumber;
}

function cchqm_det1_ONCLICK1(obj,p1)
{
	var ObjForm = document.forms[0];
	if(ObjForm.noOfChqs.value==""){
		alert("Please enter the No Of chqbooks");
		ObjForm.noOfChqs.focus();
		return false;
	}
	 
        if(ObjForm.leaves.value==""){
                alert("Please enter the Leaves(25/50/100)");
                ObjForm.leaves.focus();
                return false;
        }

	if(isNaN(document.forms[0].noOfChqs.value) )
          {
             alert("Please Enter a Valid No Of Cheque Book");
             document.forms[0].noOfChqs.focus();
             return false;
          }

        /*if(ObjForm.leaves.value==""){
                alert("Please enter the Leaves(25/50/100)");
		ObjForm.leaves.focus();
                return false;
        }*/
	 if(isNaN(document.forms[0].leaves.value) )
          {
             alert("Please Enter a Valid No Of Leaves");
             document.forms[0].leaves.focus();
             return false;
          }

	if(funcCode=='A'){
			if(!IsNumeric(document.forms[0].noOfChqs.value) )
			{
				alert("No of Chqbooks field  should contain only Numeric values");
				document.forms[0].noOfChqs.focus();
				return false;
			}
	}	
if(funcCode=='U'){
        if(ObjForm.startChqNo.value==""){
                alert("Please enter the ChqStart SerialNo");
                ObjForm.startChqNo.focus();
                return false;
        }	
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
if(profileId == "43")
{
        if(funcCode =='A')
        {
        	if(ObjForm.destbranch.value=="")
		{
        	        alert("Please enter the Destination Branch");
               		ObjForm.destbranch.focus();
                	return false;
        	}
	}
}

/*
if (profileId == "43")
{
	if(funcCode =='V')
	{
		var isDummy = "Y";
		var inputNameValues ="isDummy|"+isDummy+"|funcCode|" + funcCode + "|requestId|" + requestId+"|acctNo|" + acctNo+"|noOfChqs|" + noOfChqs+"|reqStat|" + reqStat+ "|leaves|" + leaves;

		var outputNames = "errFlg|message";

 		var scrName = "cchqmvat.scr";
 		retval = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
 		var ret = retval.split("errFlg")[1].split("|");
		if (ret[1] == "Y") 
		{
 			alert(ret[3]);
 			return false;
		}
		else
		{
			var resMsg = confirm(ret[3]);
  			if (resMsg == 0) 
			{
  				return false;
 			}
    		}
	}
}
*/
	var retVal = "";
	if (pre_ONCLICK('cchqm_det1',obj) == false) { 
		return false;
	}
	if ((retVal = fnValAndSubmit(p1)) == false) {
		return false;
	}

	if (post_ONCLICK('cchqm_det1',obj) == false) { 
	return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cchqm_det1_ONCLICK2(obj)
{
	var retVal = "";
	if (pre_ONCLICK('cchqm_det1',obj) == false) { 
		return false;
	}
	if ((retVal = fnClearFields()) == false) {
		return false;
	}
	if (post_ONCLICK('cchqm_det1',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnshowAccountIdList(obj){
        showAccountIdList(obj,null,null,'F');
	var inputNameValues = "acctNum|"+obj.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
		fnname();
}

function fnOnchangeM(obj){
	var inputNameValues = "acctNum|"+obj.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
		fnname();
}

function fnOnchangeNoChqs(obj){
	if (funcCode == "U")
	{
  	if (document.forms[0].leaves.value != "")
	{  
        var inputNameValues = "funcCode|"+funcCode+"|acctNo|"+document.forms[0].acctNo.value+"|noOfChqs|"+document.forms[0].noOfChqs.value+"|leaves|"+document.forms[0].leaves.value;
        var outputNames     = "startSrlNo|endSrlNo";
        var scrName         = "chqbkdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
	var output = ret1[0];
	document.forms[0].startChqNo.value = ret1[1];
	document.forms[0].endChqNo.value = ret1[3];	
	}
	}
	fnchrgandvatcal(obj);
}

function fnOnchangeLeaves(obj){
       	if (funcCode == "U")
	{ 
	if (document.forms[0].noOfChqs.value != "")
        {
        var inputNameValues = "funcCode|"+funcCode+"|acctNo|"+document.forms[0].acctNo.value+"|noOfChqs|"+document.forms[0].noOfChqs.value+"|leaves|"+document.forms[0].leaves.value;
        var outputNames     = "startSrlNo|endSrlNo";
        var scrName         = "chqbkdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        var output = ret1[0];
        document.forms[0].startChqNo.value = ret1[1];
        document.forms[0].endChqNo.value = ret1[3];
        }
	}

	fnchrgandvatcal(obj);
}
//363819 start
function fnbrnch()
{
	var brnch=document.forms[0].destbranch.value;
	var input      = "brnch|"+brnch;
	var outputNames    = "";
	var scrName     =   "branch_val.scr";
	var retVal = appFnExecuteScript(input,outputNames,scrName,false);
	var retBuff = retVal.split("|");
	var errFlg = retBuff[1];
	var errMsg = retBuff[3];
	var brnch = retBuff[5];
	if(errFlg == "Y")
	{
		alert(errMsg);
		return false;
	}
	else
	{
		document.forms[0].destbranch.value=brnch;
		return true;
	}

}
//363819 end
function fnchrgandvatcal(obj)
{
if (profileId == "43")
{
        if(((obj.id == "noOfChqs") || (obj.id == "leaves")) &&(funcCode == "A"))
        {
                var isDummy = "Y";
                var acctNo = document.forms[0].acctNo.value;
                var noOfChqs = document.forms[0].noOfChqs.value;
                var reqStat = document.forms[0].reqStat.value;
                var leaves = document.forms[0].leaves.value;

                var inputNameValues ="isDummy|"+isDummy+"|funcCode|" + funcCode + "|requestId|" + requestId+"|acctNo|" + acctNo+"|noOfChqs|" + noOfChqs+"|reqStat|" + reqStat+ "|leaves|" + leaves;

                var outputNames = "errFlg|message";

                var scrName = "cchqmvat.scr";
                retval = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                //var ret = retval.split("errFlg")[1].split("|");
                var ret = retval.split("|");
                if (ret[1] == "Y")
                {
                        alert(ret[3]);
                        return false;
                }
                else
                {
                       // var resMsg = confirm(ret[3]);
                        //if (resMsg == 0)
                        //{
			document.forms[0].chrgCrncy.value=ret[5];
			document.forms[0].chrgAmt.value=ret[7];
			document.forms[0].vatCrncy.value=ret[9];
			document.forms[0].vatAmt.value=ret[11];
			document.forms[0].startChqNo.value=ret[13];
			document.forms[0].endChqNo.value=ret[15];
                                return true;
                        //}
                }
        }
}
return true;
}

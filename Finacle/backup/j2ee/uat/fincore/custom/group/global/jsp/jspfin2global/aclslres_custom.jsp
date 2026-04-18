<%@ page import="applcommon.ParseValue" %>
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<SCRIPT language="javascript" src="../custom/javascripts/custom_functions.js" ></SCRIPT>
<SCRIPT language="javascript" src="../javascripts/cust_post_evt.js" ></SCRIPT>
<SCRIPT language="javascript" src="../javascripts/cust_pre_evt.js" ></SCRIPT>

<SCRIPT language="javascript" >
with (document){
			write('<table class="ctable" border="0" cellpadding="0" cellspacing="0" width="100%" id ="chrgTxnDet">');
			write('<tr>');
			write('<td valign="top">');
			write('<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
			write('<tr>');
			write('<td>');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
			write('<tr>');
			write('<td>');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
			write('<tr>');
			write('<td>');
			write('</td>');
			write('</tr>');
			write('<tr class="innertabletop1">');
			write('<td colspan="6" align="right">');
			write('<table border="0" cellspacing="0" cellpadding="0">');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
			write('<tr class="subhdrbg">');
			write('<td colspan="6">');
			write('<h2 class="subhdr">Charge Details:</h2>');
			write('</td>');
			write('</tr>');
			write('<tr>');
			write('<td class="textlabel" size="500">Charge Percentage</td>');
			write('<td><input type="text" name="chrgPcnt" style="width: 45px" class="textfieldfont" id="chrgPcnt" maxlength="3" OnChange="javascript:return sanChrgPcntVal()" > &nbsp;&nbsp;</td>');
			write('<td>&nbsp</td>');
			write('<td>&nbsp</td>');
			write('<td>&nbsp</td>');
			write('</tr>');
			write('<tr>');
			write('<td class="textlabel" size="500">Charge CCY/Amt.</td>');
			write('<td><input type="text" name="chrgCrncy" style="width: 45px" class="textfieldfont" id="chrgCrncy" maxlength="3" > &nbsp;&nbsp;');
			write('<input type="number" name="chrgAmt" style="width: 170px" class="textfieldfont" id="chrgAmt" maxlength="23"  ></td>');
			write('<td class="textlabel" size="500">VAT CCY/Amt.</td>');
			write('<td><input type="text" name="vatCrncy" style="width: 45px" class="textfieldfont" id="vatCrncy" maxlength="3" > &nbsp;&nbsp;');
			write('<input type="number" name="vatAmt" style="width: 170px" class="textfieldfont" id="vatAmt" maxlength="23" ></td>');
			write('</tr>');
			write('</table>');
			write('<tr class="rowspacing">');
			write('<td colspan="2">');
			write('<spacer type="block" height="1" width="1"></spacer>');
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
			write('</td>');
			write('</tr>');
			write('</table>');
}

function aclslres_post_ONLOAD(obj)
{
        if (mopId=="HACLHM")
        {
                if(vFuncCode != "I")
                {
                        //alert("isha kuwa");
                        //document.forms[0].limLvlIntFlg.value="Y";
                        document.forms[0].limLvlIntFlg.value="N";
                }
                var remksLenght = (document.forms[0].notes.value).length;
                var custData = (document.forms[0].customData.value).length;

                if ( (vFuncCode == "M") && (remksLenght==0) && (custData==0))
                {
                        document.forms[0].notes.value="1";
                        document.forms[0].customData.value="~aclslres|";
                }

               var inputNameValues = "acctNum|"+acctId;
               var outputNameValues = "";
               var scrName = "sanLimitschmval.scr";
               var retVal = appFnExecuteScript(inputNameValues,outputNameValues,scrName,false);
               var result      = retVal.split("|");
               var sanLimitFlg   = result[1];
               if(sanLimitFlg != "Y")
               {
			hideImage("chrgTxnDet");
                        return true;
               }


                if(vFuncCode != "M")
		{
                	var newsanctLim = document.forms[0].sanctLim.value;
                	newsanctLim = amtvalformat(newsanctLim);
                	var newLimExpDate = document.forms[0].expDate_ui.value;
                	var chrgPcnt = document.forms[0].chrgPcnt.value;

                	//var inputValues =       "acctNum|"+acctId+"|newsanctLim|"+newsanctLim+"|newLimExpDate|"+newLimExpDate+"|chrgPcnt|"+chrgPcnt;
                	var inputValues =       "acctNum|"+acctId;
                	var outputValues=       "";
                	var scrName     =       "sanctionLmt_ChrgFetch.scr";
                	var result      =       appFnExecuteScript(inputValues,outputValues,scrName,false);
                	var resmsg      =       result.split("|");
                	var errFlg      =       resmsg[1];
                	var errMsg      =       resmsg[3];
                	var chrgCrncy   =       resmsg[5];
                	var chrgAmt     =       resmsg[7];
                	var vatAmt      =       resmsg[9];
                	var chrgPcnt    =       resmsg[11];
                	if (errFlg == "Y")
                	{
                        	//alert(errMsg);
                        	document.forms[0].chrgCrncy.value = "";
                        	document.forms[0].chrgAmt.value="0";
                        	document.forms[0].vatCrncy.value = "";
                        	document.forms[0].vatAmt.value="0";
                        	document.forms[0].chrgPcnt.value="0";
                        	return false;
                	}
                	else
                	{
                        	document.forms[0].chrgCrncy.value = chrgCrncy;
                        	document.forms[0].chrgAmt.value=chrgAmt.replace(/\./g,',');
                        	document.forms[0].vatCrncy.value = chrgCrncy;
                        	document.forms[0].vatAmt.value=vatAmt.replace(/\./g,',');
                        	document.forms[0].chrgPcnt.value=chrgPcnt;
			}
                }

        }
}

function aclslres_post_ONCHANGE(obj)
{
        if(((obj.id == "sanctLim") || (obj.id == "expDate_ui")) && (mopId == "HACLHM"))
        {
               var inputNameValues = "acctNum|"+acctId;
               var outputNameValues = "";
               var scrName = "sanLimitschmval.scr";
               var retVal = appFnExecuteScript(inputNameValues,outputNameValues,scrName,false);
               var result      = retVal.split("|");
               var sanLimitFlg   = result[1];
               if(sanLimitFlg != "Y")
               {
                        return;
               }

                var newsanctLim = document.forms[0].sanctLim.value;
		newsanctLim = amtvalformat(newsanctLim);
                var newLimExpDate = document.forms[0].expDate_ui.value;
                var chrgPcnt = document.forms[0].chrgPcnt.value;

                var inputValues =       "acctNum|"+acctId+"|newsanctLim|"+newsanctLim+"|newLimExpDate|"+newLimExpDate+"|chrgPcnt|"+chrgPcnt;
                var outputValues=       "";
                var scrName     =       "sanctionLmt_Chrg.scr";
                var result      =       appFnExecuteScript(inputValues,outputValues,scrName,false);
                var resmsg      =       result.split("|");
                var errFlg      =       resmsg[1];
                var errMsg      =       resmsg[3];
                var chrgCrncy   =       resmsg[5];
                var chrgAmt     =       resmsg[7];
                var vatAmt      =       resmsg[9];
                if (errFlg == "Y")
                {
                        alert(errMsg);
                        document.forms[0].chrgCrncy.value = "";
                        document.forms[0].chrgAmt.value="";
                        document.forms[0].vatCrncy.value = "";
                        document.forms[0].vatAmt.value="";
                        return false;
                }
                else
                {
                        document.forms[0].chrgCrncy.value = chrgCrncy;
                        document.forms[0].chrgAmt.value=chrgAmt.replace(/\./g,',');
                        document.forms[0].vatCrncy.value = chrgCrncy;
                        document.forms[0].vatAmt.value=vatAmt.replace(/\./g,',');
                }
        }

return true;
}

function fnEventFormatDate(a) {
        if((a.id == "expDate_ui") && (mopId == "HACLHM"))
        {
               var inputNameValues = "acctNum|"+acctId;
               var outputNameValues = "";
               var scrName = "sanLimitschmval.scr";
               var retVal = appFnExecuteScript(inputNameValues,outputNameValues,scrName,false);
               var result      = retVal.split("|");
               var sanLimitFlg   = result[1];
               if(sanLimitFlg == "Y")
               {
                	var newsanctLim = document.forms[0].sanctLim.value;
			newsanctLim = amtvalformat(newsanctLim);
                	var newLimExpDate = document.forms[0].expDate_ui.value;
                	var chrgPcnt = document.forms[0].chrgPcnt.value;

                	var inputValues =       "acctNum|"+acctId+"|newsanctLim|"+newsanctLim+"|newLimExpDate|"+newLimExpDate+"|chrgPcnt|"+chrgPcnt;
                	var outputValues=       "";
                	var scrName     =       "sanctionLmt_Chrg.scr";
                	var result      =       appFnExecuteScript(inputValues,outputValues,scrName,false);
                	var resmsg      =       result.split("|");
                	var errFlg      =       resmsg[1];
                	var errMsg      =       resmsg[3];
                	var chrgCrncy   =       resmsg[5];
                	var chrgAmt     =       resmsg[7];
                	var vatAmt      =       resmsg[9];
                	if (errFlg == "Y")
                	{
                        	alert(errMsg);
                        	document.forms[0].chrgCrncy.value = "";
                        	document.forms[0].chrgAmt.value="";
                        	document.forms[0].vatCrncy.value = "";
                        	document.forms[0].vatAmt.value="";
                        	//return false;
                	}
                	else
                	{
                        	document.forms[0].chrgCrncy.value = chrgCrncy;
                        	document.forms[0].chrgAmt.value=chrgAmt.replace(/\./g,',');
                        	document.forms[0].vatCrncy.value = chrgCrncy;
                        	document.forms[0].vatAmt.value=vatAmt.replace(/\./g,',');
                	}
		}
        }

    var b = "";
    if ((b = onBlurFormatDate(a)) == false) {
        return false
    }
    if ((b = fnAssignDateOnEnter(a)) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function aclslres_pre_ONCLICK(obj)
{

	if(obj.id == "Submit" || obj.id == "Validate")
        {
               var inputNameValues = "acctNum|"+acctId;
               var outputNameValues = "";
               var scrName = "sanLimitschmval.scr";
               var retVal = appFnExecuteScript(inputNameValues,outputNameValues,scrName,false);
               var result      = retVal.split("|");
               var sanLimitFlg   = result[1];
                if(sanLimitFlg != "Y")
                {
			return true;
                }

		if(document.forms[0].chrgPcnt.value == "")
		{
			alert("Enter Sanction Limit charge percentage details");
			document.forms[0].chrgPcnt.focus();
			return false;
		}
	}	

	if(obj.id == "Submit")
	{
		//if(vFuncCode == "M" || vFuncCode == "X")
		if(vFuncCode == "V" || vFuncCode == "X" || vFuncCode == "M")
		{
                	var chrgCrncy = document.forms[0].chrgCrncy.value;
                	var chrgAmt = document.forms[0].chrgAmt.value;
			chrgAmt = amtvalformat(chrgAmt);
                	var vatCrncy = document.forms[0].vatCrncy.value;
                	var vatAmt = document.forms[0].vatAmt.value;
			vatAmt = amtvalformat(vatAmt);
                	var chrgPcnt = document.forms[0].chrgPcnt.value;
                	var newsanctLim = document.forms[0].sanctLim.value;
			newsanctLim = amtvalformat(newsanctLim);

                	var inputValues =       "acctNum|"+acctId+"|ChrgCrncy|"+chrgCrncy+"|ChrgAmt|"+chrgAmt+"|vatCrncy|"+vatCrncy+"|vatAmt|"+vatAmt+"|chrgPcnt|"+chrgPcnt+"|vFuncCode|"+vFuncCode +"|newsanctLim|"+newsanctLim;
                	var outputValues=       "";
                	var scrName     =       "sanlimCheck.scr";
                	var result      =       appFnExecuteScript(inputValues,outputValues,scrName,false);
                	var resmsg      =       result.split("|");
                	var errFlg      =       resmsg[1];
                	var errMsg      =       resmsg[3];
                	if (errFlg == "Y")
                	{
                        	alert(errMsg);
                        	return false;
                	}
		}		

		if(vFuncCode == "V")
		{
                	var newsanctLim = document.forms[0].sanctLim.value;
			newsanctLim = amtvalformat(newsanctLim);
                	var newLimExpDate = document.forms[0].expDate_ui.value;
                	var chrgPcnt = document.forms[0].chrgPcnt.value;

                	var inputValues =       "acctNum|"+acctId+"|newsanctLim|"+newsanctLim+"|newLimExpDate|"+newLimExpDate+"|chrgPcnt|"+chrgPcnt;
                	var outputValues=       "";
                	var scrName     =       "sancChrg_Coll.scr";
                	var result      =       appFnExecuteScript(inputValues,outputValues,scrName,false);
                	var resmsg      =       result.split("|");
                	var errFlg      =       resmsg[1];
                	var errMsg      =       resmsg[3];
                	if (errFlg == "Y")
                	{
                        	alert(errMsg);
				return false;
			}
		}
	}
}

function amtvalformat(amt)
{
if(amt.indexOf(',') > -1)
{
     var amt1 = amt.split(",");
     var amt2 = amt1[0];
     var amt3 = amt1[1];
}
else
{
     var amt2 = amt;
     var amt3 = "00";
}
     var amt4 = amt2.replace(/\./g,'') + "." + amt3;
return amt4;
}

function sanChrgPcntVal()
{
        if(document.forms[0].chrgPcnt.value != "")
        {
                var ObjForm = document.forms[0];
                var prcnt = ObjForm.chrgPcnt.value;

                var fieldValue=prcnt.toUpperCase();
                fieldValue=fieldValue.replace(/\s/g,'');
                fieldValue=fieldValue.replace(",","");
                ObjForm.chrgPcnt.value = fieldValue;

                if (isNaN(fieldValue))
                {
                        alert("Enter a Valid Number");
                        ObjForm.chrgPcnt.value = "";
                        ObjForm.chrgPcnt.focus();
                        return false;
                }
                if(fieldValue=="")
                {
                        alert("Enter the Sanction Limit Charge Percentage");
                        ObjForm.chrgPcnt.value = "";
                        ObjForm.chrgPcnt.focus();
                        return false;
                }

                var inputValues =       "chrgPcnt|"+ObjForm.chrgPcnt.value+"|acctNum|"+acctId;
                var outputValues=       "";
                var scrName     =       "sanLimitChrgVal.scr";
                var result      =       appFnExecuteScript(inputValues,outputValues,scrName,false);
                var resmsg      =       result.split("|");
                if (resmsg[1] == "Y")
                {
                        alert(resmsg[3]);
                        document.forms[0].chrgPcnt.value = "";
                        document.forms[0].chrgPcnt.focus();
                        return false;
                }

                if(fieldValue>100 || fieldValue < 0)
                {

                        alert("Percentage value should be between 0 and 100");
                        ObjForm.chrgPcnt.value = "";
                        ObjForm.chrgPcnt.focus();
                        return false;
                }
                        var newsanctLim = document.forms[0].sanctLim.value;
                        newsanctLim = amtvalformat(newsanctLim);
                        var newLimExpDate = document.forms[0].expDate_ui.value;
                        var chrgPcnt = document.forms[0].chrgPcnt.value;

                        var inputValues =       "acctNum|"+acctId+"|newsanctLim|"+newsanctLim+"|newLimExpDate|"+newLimExpDate+"|chrgPcnt|"+chrgPcnt;
                        var outputValues=       "";
                        var scrName     =       "sanctionLmt_Chrg.scr";
                        var result      =       appFnExecuteScript(inputValues,outputValues,scrName,false);
                        var resmsg      =       result.split("|");
                        var errFlg      =       resmsg[1];
                        var errMsg      =       resmsg[3];
                        var chrgCrncy   =       resmsg[5];
                        var chrgAmt     =       resmsg[7];
                        var vatAmt      =       resmsg[9];
                        if (errFlg == "Y")
                        {
                                alert(errMsg);
                                document.forms[0].chrgCrncy.value = "";
                                document.forms[0].chrgAmt.value="";
                                document.forms[0].vatCrncy.value = "";
                                document.forms[0].vatAmt.value="";
                                return false;
                        }
                        else
                        {
                                document.forms[0].chrgCrncy.value = chrgCrncy;
                        	document.forms[0].chrgAmt.value=chrgAmt.replace(/\./g,',');
                        	document.forms[0].vatCrncy.value = chrgCrncy;
                        	document.forms[0].vatAmt.value=vatAmt.replace(/\./g,',');
			}
        }
}

</script>

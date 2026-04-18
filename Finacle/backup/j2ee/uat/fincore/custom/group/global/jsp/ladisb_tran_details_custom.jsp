<!--description		: This is used to set Payoff Old Loan A/c Drop down box and call scripts.
<!--Date			: 13-06-2013
<!--Author			: Prashanth 
<!--Called By			: None    
<!--Calling  Jsp		: 
<!--Menu Option		: HLADISB
<!--Modification History:
<!--    Version No.       Date             Author             Description
<!--    -------         ----------         -----------        ------------------
<!--	0.1            13-06-2013          Prashanth		Original version
<!--	0.2		 26-06-2013					Prashanth		Made some logical changes				
<!--	0.3		 22-07-2013					Bharath			Menu option validation added
<!--	0.4		 26-09-2013					Kalvin			MODIFIED FOR TO 344729
<!---------------------------------------------------------------------------------------------------------------->
<%@ include file="../commonInclude.jsp" %>
<%
        ContextManager CustomARJspCurr =(ContextManager)session.getAttribute("CustomARJspCurr");
        String sGroupName = CustomARJspCurr.getCurrentGroup();
        String tranTypeVal = (String)CustomARJspCurr.getInput(sGroupName+".tranType", "");
		String grossNetDisbVal = (String)CustomARJspCurr.getInput(sGroupName+".grossNetDisb", "");
		String acctNumVal = (String)CustomARJspCurr.getInput(sGroupName+".acctNum", "");
%>

<input type="hidden" id = "tranTypeVal" name = "tranTypeVal" value = "<%=tranTypeVal%>">
<input type="hidden" id = "grossNetDisbVal" name = "grossNetDisbVal" value = "<%=grossNetDisbVal%>">
<input type="hidden" id = "acctNumVal" name = "acctNumVal" value = "<%=acctNumVal%>">

<input type="hidden" id = "acctIdRes" name = "acctIdRes" >
<input type="hidden" id = "acctNameRes" name = "acctNameRes" >
<input type="hidden" id = "tranPartRes" name = "tranPartRes" >
<input type="hidden" id = "ccyRes" name = "ccyRes" >
<input type="hidden" id = "tranAmtRes" name = "tranAmtRes" >
<input type="hidden" id = "crDrRes" name = "crDrRes" >
<!-------------------------END OF MODIFIED FOR TO 344729---------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>
<script type="text/javascript">
with (document)
{
	if (mopId == "HLADISB" )
	{ 
		//---------------------------MODIFIED FOR TO 344729--------------------------------------------------------
		var tr = document.forms[0].tranTypeVal.value
		var gn = document.forms[0].grossNetDisbVal.value
		if((funcCode == "D") ||(funcCode == "V") )
		{
				if ((tr == "T" ) && (gn == "G")){
						write('<table>');
						write('<tr>');
						
						write('<td class="page-heading">  </td>');
						write('<td class="page-heading">Charge Transaction Details</td>');
						write('</tr>');
						write('</table>');
						 write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
						write('<tr>');
						write('</tr>');
						write('<tr>');
						write('<td>');
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
						write('<td align="right"><table border="0" cellspacing="0" cellpadding="0">');
						write('<tr>');
						write('<td> </td>');
						write('</tr>');
						write('</table>');
						write('</td>');
						write('</tr>');
						write('<tr class="rowspacing1">');
						write('<td><spacer type=block width=1 height=1></spacer></td>');
						write('</tr>');
						write('<tr class="subhdrbg">');
						write('<td class="subhdr">&nbsp;</td>');
						write('</tr>');
						write('<table width="100%" border="0" cellspacing="0" cellpadding="0">');
						write('<tr>');
						write('<td ALIGN="left" class="searcheaderleft">' + jspResArr.get("FLT000265") + '</td>');
						write('<td ALIGN="left" class="searcheader">' + jspResArr.get("FLT000012") + '</td>');
					   write('<td ALIGN="left" class="searcheader">' + jspResArr.get("FLT001608") + '</td>');
					   write('<td ALIGN="left" class="searcheader">' + jspResArr.get("FLT000006") + '</td>');
						write('<td ALIGN="right" class="amountheader">' + jspResArr.get("FLT003360") + '</td>');
					   write('<td ALIGN="left" class="searcheader">' + jspResArr.get("FLT001604") + '</td>');	   
						write('</tr>');
						fnDispData();
						 write('</table>');
						 write('</table>');
						 write('</table>');
						 write('</table>');
						  write('</table>');
				}
		}
			
//---------------------------MODIFIED FOR TO 344729--------------------------------------------------------
		if(funcCode == "D")
	   	{
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable" >');
			write('<tr>');
			write('<td>');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >');
			write('<tr>');
			write('<td>');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable" >');
			write('<tr>');
			write('<td>');
			write('<table width="100%" border="0" cellpadding="4" cellspacing="5" class="innertabletop1">');
			write('<tr>');
			write('<td class="textlabel">Payoff Old Loan A/c<font color=red size=2>*</font></td>');
			write('<td>');
			write('<select id="pyoflac"  name="pyoflac" class="listboxfont" onchange="javascript:fnonchng(this)">');
			write('<option value="" selected>Select</option>');
			write('<option value="Y">YES</option>');
			write('<option value="N">NO</option>');
			write('</select>');	
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
	}
	getFieldsFromCustomData("pyoflac");
}
function post_ONLOAD()
{
	if (mopId == "HLADISB" )
	{ 
		if (funcCode == "D" )
		{
			pyoflacFieldVisible();
		}
	}
} 
function pyoflacFieldVisible()
{
	getFieldsFromCustomData("pyoflac");
	var remitValue = document.forms[0].customData.value;
	var fet = remitValue.split("|");
	var funccode = fet[1];
	var foracid = fet[2];
	var disbdAmt = fet[3];
	var disbamt = fet[4];
	var inputNameValues    = "funccode|" + funccode +  "|foracid|"+ foracid + "|disbdAmt|"+ disbdAmt + "|disbamt|"+ disbamt;
	var outputNames        = "";
	var scrName            = "ast0057dp001.scr";
	var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");

	if(ret[0]=="Error" && ret[1] != "dummy" )
	{
		document.forms[0].pyoflac.disabled=true;
		return false;
	}
	else
	{
		if(ret[2]=="count" && ret[3] != "" )
		{
				if(ret[2]=="count" && ret[3] >= "1")
				{
					if(disbdAmt == 0.00)
					{
						document.forms[0].pyoflac.disabled=false;
					}
					else
					{
						document.forms[0].pyoflac.disabled=true;
					} 
				}
				else
				{
					document.forms[0].pyoflac.disabled=true;
				}
		}
	}
}
function fnonchng()
{
	if (mopId == "HLADISB" )
	{ 
		if (funcCode == "D" )
		{
			var value2 = document.getElementById("pyoflac").selectedIndex;
			if(document.forms[0].pyoflac.value == "Y")
			{
				setFieldsToCustomData("pyoflac");
				var remitValue = document.forms[0].customData.value;
				var fet = remitValue.split("|");
				var funccode = fet[1];
				var foracid = fet[2];
				var disbdAmt = fet[3];
				var disbamt = fet[4];
				var disbamount1 = fet[6];
				var inputNameValues = "foracid|"+ foracid + "|disbdAmt|"+ disbdAmt + "|disbamt|" +  disbamt+ "|disbamount1|"+ disbamount1;
				var outputNames        = ""
				var scrName            = "ast0057dp002.scr";
				var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				if(ret[0] == "Error" && ret[1] != "dummy")
				{
					return false;
				}	 
				else
				{
					if(ret[2] == "flagg" && ret[3] == "N")
					{
					}
					else	
					{
						var remitValue = document.forms[0].customData.value;
						var fet = remitValue.split("|");
						var funccode = fet[1];
						var foracid = fet[2];
						var disbdAmt = fet[3];
						var disbamt = fet[4];
						var disbamount1 = fet[6];
						var creditacctnum = fet[7];
						var pyFlg = document.forms[0].pyoflac.value;
						delSValue("LaAcctNum");
						setSValue("LaAcctNum|"+foracid);
						var inputNameValues    = "funccode|" + funccode +  "|foracid|"+ foracid + "|disbdAmt|"+ disbdAmt + "|disbamt|"+ disbamt+ "|disbamount1|" + disbamount1 + "|creditacctnum|" + creditacctnum + "|pyFlg|" + pyFlg;
						var outputNames        = "slno|acctno1|acctno1Crncy|crdr1|amount1|acctno2|acctno2Crncy|crdr2|amount2";
						var scrName            = "ast0057dp003.scr";
						var title  = "List of Disbursed Loan A/c Details";
						var literalNames = "SNO|Op Acct|Op Acct CCY|DR/CR Ind|Amt|Old Acct|Old Acct CCY|DR/CR Ind|Amt";
						var hyperLnks   = "1";
						var retVal = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks, true);
						var retVal = "";
					}
				} 
			}
			else
			{
				setFieldsToCustomData("pyoflac");
			}		
		}
	}
}
function ladisb_tran_details_pre_ONCLICK(obj)
{
	if (mopId == "HLADISB" )
	{ 
		if (funcCode == "D" )
		{
			pyoflacFieldVisible();
			if(document.forms[0].pyoflac.disabled == false)
			{
				setFieldsToCustomData("pyoflac");
				var idx = document.getElementById("pyoflac").selectedIndex;
				if(idx == "0")
				{	
					alert("Please select 'Yes' or 'No' in Payoff Old Loan A/c Field");
					document.forms[0].pyoflac.focus();
					return false;
				}
			}
		}
	}
}

//---------------------------MODIFIED FOR TO 344729--------------------------------------------------------
function fnDispData(){
		
	var loanAct = document.forms[0].acctNumVal.value;
	var inputNameValues = "loanAct|"+ loanAct;
	var outputNames        = "acctIdRes|acctNameRes|tranPartRes|ccyRes|tranAmtRes|crDrRes";
	var scrName            = "ladisbchrgdp002.scr";
	var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, true);
	if(!fnIsNull(document.forms[0].acctIdRes.value)){

		var acctIdRes = document.forms[0].acctIdRes.value.split("!");
		var acctNameRes = document.forms[0].acctNameRes.value.split("!");
		var tranPartRes = document.forms[0].tranPartRes.value.split("!");
		var ccyRes = document.forms[0].ccyRes.value.split("!");
		var tranAmtRes = document.forms[0].tranAmtRes.value.split("!");
		var crDrRes = document.forms[0].crDrRes.value.split("!");
		showLoanTranArgCust(acctIdRes, acctNameRes, tranPartRes, ccyRes, tranAmtRes, crDrRes);
	}
}

function showLoanTranArgCust(acctIdRes, acctNameRes, tranPartRes, ccyRes, tranAmtRes, crDrRes)
{
        var len = acctIdRes.length;
        if ((acctIdRes.length == 1) && (acctIdRes[0] == 0))
        {
            document.write('<TR class="searclist1a">');
            document.write('<TD COLSPAN = "8" ALIGN="center">No records were fetched.');
            document.write('</TD>');
            document.write('</TR>');
            return;
    }

        for(index = 0; index < len; index++)
    {
                if((index%2)==0) {
                        document.write('<TR class="searclist1a">');
                }
                else
                {
                        document.write('<TR class="searclist2a">');
                }
                document.write('<TD class="ctext_small" ALIGN="left">' + jsUtil.encodeChar(acctIdRes[index]) + '</TD>');
                document.write('<TD class="ctext_small" ALIGN="left">' + jsUtil.encodeChar(acctNameRes[index]) + '</TD>');
                document.write('<TD class="ctext_small" ALIGN="left">' + jsUtil.encodeChar(tranPartRes[index]) + '</TD>');
                document.write('<TD class="ctext_small" ALIGN="left">' + jsUtil.encodeChar(ccyRes[index]) + '</TD>');
                document.write('<TD class="ctext_small" ALIGN="right">');
                newformatAmt(format,tranAmtRes[index] ,ccyRes[index],"Y");
                document.write('</TD>');
                document.write('<TD class="ctext_small" ALIGN="left">' + jsUtil.encodeChar(crDrRes[index]) + '</TD>');
                document.write('</TR>');
    }
}//end of function

//--------------------------ENDOF CHANGE-MODIFIED FOR TO 344729--------------------------------------------------------
</script>



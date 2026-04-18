function printBlock()
{
	writeCustomHeader("cshapu_res");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT014548") + '</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table class="ctable1" width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr class="rowspacing">');
	write('<td colspan="5">&nbsp;</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr class="textfielddisplaylabel1" valign="middle">');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="resultpage">');
	write('<tr>');
	write('<td width="3%">');
	write('<img class="img" src="../Renderer/images/info.gif" width="29" height="29" align="right" border="0">');
	write('</img></td>');
	if(Message != "NULL"){
	write('<td width="97%" > ' + Message + '</td>');
	}
	else if(Message == ""){
	write('<td>Set the value for the variable RESULT_MSG using the userhook SetOrbOut in script.</td>');
	}
	else{
	write('<td>&nbsp;&nbsp;&nbsp;</td>');
	}
	write('</tr>');
	write('</table>');
	write('</td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table>');
	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	write('<div class="ctable">');
	write('<input id="Ok" name="Ok" type="button" class="button" value="' + jspResArr.get("FLT031295") + '"	onClick="javascript:return cshapu_res_ONCLICK1(this);"" hotKeyId="Go">');
	//write('<input id="print" name="print" type="button" class="button" value="' + jspResArr.get("FLT031296") + '"	onClick="javascript:return cshapu_res_ONCLICK2(this);"" hotKeyId="Go">');
	writeFooter();
	write('</div>');
	}
}//End function



function cshapu_res_ONCLICK1(obj)
{
	var retVal = "";
	if (preEventCall('cshapu_res',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	if (postEventCall('cshapu_res',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cshapu_res_ONCLICK2(obj)
{
	//alert("To print order details");

	var retVal = "";
	if (preEventCall('cshapu_res',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = showOrderDetails()) == false) {
		return false;
	}
	if (postEventCall('cshapu_res',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function showOrderDetails()
{

	var sUrl 	= "";
	var urlData 	= "";
	inputNameValues="tranid|2";
	var outputNames = "employee_id|cdscnumber|accountnumber|bankname|branchname|totalamount|"; 


	outputNames=outputNames+"rec1SecCode|rec1SecurityName|rec1Quantity|rec1AskingPrice|rec1IsDeleted|";
	outputNames=outputNames+"rec2SecCode|rec2SecurityName|rec2Quantity|rec2AskingPrice|rec2IsDeleted|";
	outputNames=outputNames+"rec3SecCode|rec3SecurityName|rec3Quantity|rec3AskingPrice|rec3IsDeleted|";
	outputNames=outputNames+"rec4SecCode|rec4SecurityName|rec4Quantity|rec4AskingPrice|rec4IsDeleted|";
	outputNames=outputNames+"rec5SecCode|rec5SecurityName|rec5Quantity|rec5AskingPrice|rec5IsDeleted|";
	outputNames=outputNames+"rec6SecCode|rec6SecurityName|rec6Quantity|rec6AskingPrice|rec6IsDeleted|";
	outputNames=outputNames+"rec7SecCode|rec7SecurityName|rec7Quantity|rec7AskingPrice|rec7IsDeleted|";
	outputNames=outputNames+"rec8SecCode|rec8SecurityName|rec8Quantity|rec8AskingPrice|rec8IsDeleted|";
	outputNames=outputNames+"rec9SecCode|rec9SecurityName|rec9Quantity|rec9AskingPrice|rec9IsDeleted|";
	outputNames=outputNames+"rec10SecCode|rec10SecurityName|rec10Quantity|rec10AskingPrice|rec10IsDeleted|";


	


	var scriptName = "trading008.scr";
	var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
    
	alert(retVal);

    var sUrl = "../custom/jsp/cshapu_resPrint.jsp?param1="+retVal;
	//sUrl+= urlData;	
	var xMax = screen.width, yMax = screen.height;
	var xOffset = (xMax - 120), yOffset = (yMax - 150);	
	var params = "dialogWidth=800px;dialogHeight=50px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
	params += ";status=yes;toolbar=yes;menubar=yes;resizable=yes;help=yes;center=no";
	 var retVal = "";
		if("Netscape" == browser_name)
		{
			window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");

		}
		else
		{
			retVal = window.popModalWindow(sUrl,"",params);

		}
		if (retVal == null || retVal == undefined)
		{
			return retVal;
	}

}

function printBlock()
{
	writeCustomHeader("cieclg_res");
	with (document){
	write('<input type="hidden" name="nextPage" id="nextPage">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="page-heading">Inter Entity Clearing Maintenance</td>');
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
	write('<td width="97%" style="color:black"> ' + Message + '</td>');
	}
	else if(Message == ""){
	write('<td style="color:red">Set the value for the variable RESULT_MSG using the userhook SetOrbOut in script.</td>');
	}
	else{
	write('<td style="color:red">&nbsp;&nbsp;&nbsp;</td>');
	}
	write('</tr>');
	fnDisplayTranDetails();
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
	write('<input id="Ok" name="Ok" type="button" class="button" value="Ok"	onClick="javascript:return cieclg_res_ONCLICK1(this);"" hotKeyId="Go">');
	writeFooter();
	write('</div>');
	}
}//End function



function cieclg_res_ONCLICK1(obj)
{
	var retVal = "";
	if (preEventCall('cieclg_res',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnLastButtonClick()) == false) {
		return false;
	}
	if (postEventCall('cieclg_res',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function fnDisplayTranDetails(){
	with (document){
        write('<!-- DETAILSBLOCK-BEGIN -->');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');

	if((funcCode == "A") || (funcCode == "M") || (funcCode == "D")){
		write('<tr class="subhdrbg">');
		write('<td colspan="5">');
		write('<h2 class="subhdr">Init Entity Details</h2>');
		write('</td>');
	        write('</tr>');

		write('<tr>');
		write('<td class="textlabel">Zone Code</td>');
		write('<td align="left" class="textfielddisplaylabel">'+zoneCode+'</td>');
		write('<td class="textlabel">Zone Date</td>');
		write('<td align="left" class="textfielddisplaylabel">'+zoneDate+'</td>');
		write('</tr>');

		write('<tr>');
		write('<td class="textlabel">Sol ID</td>');
		write('<td align="left" class="textfielddisplaylabel">'+solId+'</td>');
		write('<td class="textlabel">Set No.</td>');
		write('<td align="left" class="textfielddisplaylabel">'+setNum+'</td>');
		write('</tr>');
	}

	if((funcCode == "V") || (funcCode == "R")){
		write('<tr class="subhdrbg">');
		write('<td colspan="5">');
		write('<h2 class="subhdr">Init Entity Details</h2>');
		write('</td>');
		write('</tr>');

		write('<tr>');
		write('<td class="textlabel">Zone Code</td>');
		write('<td align="left" class="textfielddisplaylabel">'+zoneCode+'</td>');
		write('<td class="textlabel">Zone Date</td>');
		write('<td align="left" class="textfielddisplaylabel">'+zoneDate+'</td>');
		write('</tr>');

		write('<tr>');
		write('<td class="textlabel">Sol ID</td>');
		write('<td align="left" class="textfielddisplaylabel">'+solId+'</td>');
		write('<td class="textlabel">Set No.</td>');
		write('<td align="left" class="textfielddisplaylabel">'+setNum+'</td>');
		write('</tr>');

		if(funcCode == "V"){
                write('<tr>');
                write('<td class="textlabel">Charge Transaction ID</td>');
                write('<td align="left" class="textfielddisplaylabel">'+chargeTranId+'</td>');
                write('<td class="textlabel">Charge Transaction Date</td>');
                write('<td align="left" class="textfielddisplaylabel">'+chargeTranDate+'</td>');
                write('</tr>');
                }

		if(funcCode == "R"){
		write('<tr>');
                write('<td class="textlabel">Transaction ID</td>');
                write('<td align="left" class="textfielddisplaylabel">'+entity1TranId+'</td>');
                write('<td class="textlabel">Transaction Date</td>');
                write('<td align="left" class="textfielddisplaylabel">'+entity1TranDate+'</td>');
                write('</tr>');
		}

		if(targetSetNum != ""){

		write('<tr class="subhdrbg">');
		write('<td colspan="5">');
		write('<h2 class="subhdr">Target Entity Details</h2>');
		write('</td>');
		write('</tr>');

		write('<tr>');
		write('<td class="textlabel">Zone Code</td>');
		write('<td align="left" class="textfielddisplaylabel">'+targetZoneCode+'</td>');
		write('<td class="textlabel">Zone Date</td>');
		write('<td align="left" class="textfielddisplaylabel">'+targetZoneDate+'</td>');
		write('</tr>');

		write('<tr>');
		write('<td class="textlabel">Sol ID</td>');
		write('<td align="left" class="textfielddisplaylabel">'+targetSolId+'</td>');
		write('<td class="textlabel">Set No.</td>');
		write('<td align="left" class="textfielddisplaylabel">'+targetSetNum+'</td>');
		write('</tr>');

		if(funcCode == "R"){
                write('<tr>');
                write('<td class="textlabel">Transaction ID</td>');
                write('<td align="left" class="textfielddisplaylabel">'+entity2TranId+'</td>');
                write('<td class="textlabel">Transaction Date</td>');
                write('<td align="left" class="textfielddisplaylabel">'+entity2TranDate+'</td>');
                write('</tr>');
                }
		
		}
        }
	

        write('</table>');
        write('<!-- DETAILSBLOCK-END -->');
	} //End with()
}

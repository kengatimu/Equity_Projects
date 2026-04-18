/*=================================================================*
# Source Name           : package_res_glink.js
# Title                 : Package Maintenance Menu
# Menu Option           : PACKAGE
# Author                : Manikanta D M
# Date                  : 19-11-2020
# Description           : 
# Calling jsp's         : NA
# Calling scr's         : NA
#==================================================================*/
function printBlock()
{
	writeCustomHeader("package_res");
	with (document){
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">');
	write('Package Maintenance Menu');
	write('</td>');
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
		write('<td width="97%"> ' + Message + '</td>');
	}
	else if(Message == ""){
		write('<td style="color:red">Set the value for the variable RESULT_MSG using the userhook SetOrbOut in script.</td>');
	}
	else{
		write('<td style="color:red">&nbsp;&nbsp;&nbsp;</td>');
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
		write('<div class="ctable" align="left">');
		write('<input type="button" class="button" id="ok" value="Ok" onClick="javascript:return package_res_ONCLICK1(this);" hotKeyId="Go">');
		writeFooter();
		write('</div>');
	}
}//End function
function package_res_ONCLICK1(obj)
{
	var retVal = "";
	if (preEventCall('package_res',obj) == false) 
	{
		return false;
	}
	if ((retVal = fnLastButtonClick()) == false)
		{
			return false;
		}
	if (postEventCall('package_res',obj) == false) 
		{
			return false;
		}
			return (retVal == undefined) ? true : retVal;
	
var retVal = "";
        if ((retVal = fnLastButtonClick()) == false)
        {
                return false;
        }
        return (retVal == undefined) ? true : retVal;

}

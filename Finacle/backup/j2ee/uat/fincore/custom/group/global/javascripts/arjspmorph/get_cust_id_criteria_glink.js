// Generated from spec file 

function printBlock()
{
	with (document) {
	write('<input type="hidden" name="FormSubmit" value="True">');
	write('<CENTER>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" >');
	write('<tr>');
	write('<td class="popuptab">' + jspResArr.get("FLT000449") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td valign="top">');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%" class="innertabletop">');
	if(dualFlg == "Y"){
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT021235") + '</TD>');
	write('<TD>');
	write('<input type="radio" id="searchLang" name="searchLang" VALUE="P" checked>' + jspResArr.get("FLT006064") + '&nbsp;&nbsp;&nbsp;');
	write('<input type="radio" id="searchLang" name="searchLang" VALUE="T">' + jspResArr.get("FLT021137") + '');
	write('</TD>');
	write('</TR>');
	}
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000449") + ' <script>setMandatory("' + arjspmorphProps.get("CustCifId_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="31" class="textfieldfont" fdt="cifid" maxlength="32" type="text" id="CustCifId" name="CustCifId" ' + arjspmorphProps.get("CustCifId_ENABLED") + ' fmnd = "' + arjspmorphProps.get("CustCifId_MANDATORY") + '" ></TD>');
	write('<td  class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000434") + ' <script>setMandatory("' + arjspmorphProps.get("CustCustomerName_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="20" class="textfieldfont" maxlength="80" type="text"  fmb="Y" id="CustCustomerName"  name="CustCustomerName" ' + arjspmorphProps.get("CustCustomerName_ENABLED") + ' fmnd = "' + arjspmorphProps.get("CustCustomerName_MANDATORY") + '" ></TD>');
	write('</TR>');
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000435") + ' <script>setMandatory("' + arjspmorphProps.get("CustShortName_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="20" id="CustShortName"  class="textfieldfont" maxlength="10" type="text" fmb="Y" name="CustShortName" ' + arjspmorphProps.get("CustShortName_ENABLED") + ' fmnd = "' + arjspmorphProps.get("CustShortName_MANDATORY") + '" ></TD>');
	if(srchCrit == 'S'){
	  document.forms[0].CustShortName.value = cif;
	}
	write('<td  class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel">' + jspResArr.get("FLT019505") + ' <script>setMandatory("' + arjspmorphProps.get("CustFirstName_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="20" id="CustFirstName" class="textfieldfont" maxlength="80" type="text" fmb="Y" name="CustFirstName" ' + arjspmorphProps.get("CustFirstName_ENABLED") + ' fmnd = "' + arjspmorphProps.get("CustFirstName_MANDATORY") + '" ></TD>');
	write('</TR>');
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT019506") + ' <script>setMandatory("' + arjspmorphProps.get("CustMiddleName_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="20" id="CustMiddleName" class="textfieldfont" maxlength="80" type="text" fmb="Y" name="CustMiddleName" ' + arjspmorphProps.get("CustMiddleName_ENABLED") + ' fmnd = "' + arjspmorphProps.get("CustMiddleName_MANDATORY") + '" ></TD>');
	write('<td  class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel">' + jspResArr.get("FLT019507") + ' <script>setMandatory("' + arjspmorphProps.get("CustLastName_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="20" id="CustLastName" class="textfieldfont" maxlength="80" type="text" fmb="Y" name="CustLastName" ' + arjspmorphProps.get("CustLastName_ENABLED") + ' fmnd = "' + arjspmorphProps.get("CustLastName_MANDATORY") + '" ></TD>');
	write('</TR>');
	if(fabAvbl !='Y'){
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT003344") + '&nbsp;</td>');
	write('<td class="textfield"><INPUT  id="docType" class="textfieldfont" size="20" maxlength="20" hotKeyId ="search2" name="docType"');
	write('id="docType" fmnd="' + arjspmorphProps.get("docType_ENABLED") + '" >&nbsp;');
	write('<a id="sLnk3" target=_self href="Javascript:showDynSearcher(\'HDOCTYPE\',\'docType=:doc_type\',\':docType=doc_type\'');
	write(')">');
	write('<img class="img" src="../Renderer/images/search_icon.gif" width="16" height="17" border="0" hotKeyId ="search2');
	write('"></img>');
	write('</a>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT021792") + ' <script>setMandatory("' + arjspmorphProps.get("docNo_MANDATORY") + '")</script></t');
	write('d>');
	write('<td class="textfield"><INPUT size="100" id="docNo" class="textfieldfont" maxlength="100" type="text" fmb="Y" name="docNo" ' + arjspmorphProps.get("docNo_ENABLED") + ' fmnd = "' + arjspmorphProps.get("docNo_MANDATORY") + '" ></td>');
	write('</tr>');
	}
	write('<TR>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000004") + ' <script>setMandatory("' + arjspmorphProps.get("setId_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="8" maxlength="8" hotKeyId ="search1" id="setId" class="textfieldfont"  type="text" value = "ALL"  name="setId" ' + arjspmorphProps.get("setId_ENABLED") + ' fmnd="' + arjspmorphProps.get("setId_MANDATORY") + '" >&nbsp;');
	write('<a id="sLnk2" target=_self href="Javascript:showSetList(document.forms[0].setId,\'morph\',\'F\')">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId ="search1"></img>');
	write('</a>');
	write('</TD>');
	write('<td  class="columnwidth">&nbsp;</td>');
	write('<TD class="textlabel">' + jspResArr.get("FLT000212") + ' <script>setMandatory("' + arjspmorphProps.get("CustPhoneNo_MANDATORY") + '")</script></TD>');
	write('<TD class="textfield"><INPUT size="20" id="CustPhoneNo" class="textfieldfont"  maxlength="15" type="text" name="CustPhoneNo" ' + arjspmorphProps.get("CustPhoneNo_ENABLED") + ' fmnd = "' + arjspmorphProps.get("CustPhoneNo_MANDATORY") + '" ></TD>');
	write('<TD class="textlabel">&nbsp;</TD>');
	write('<TD class="textfield">&nbsp;</TD>');
	write('</TR>');
	write('<TR>');
	PRINTDATEFLD("CustBirthDate","N","1",jspResArr.get("FLT021207"),"","N","N","","","","N","Y","N");
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000218") + '&nbsp;</td>');
	write('<td class="textfield"><select class="listboxfont" name="bsnOperation" id="bsnOperation" fmnd="" ' + arjspmorphProps.get("bsnOperation_ENABLED") + '>');
	writeComboFunction("writeBSNOperation");
	write('</select>');
	write('</td>');
	write('</TR>');
	if(fabAvbl !='Y'){
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT021243") + '</td>');
	write('<td class="textfield">');
	write('<input type="radio" id = "retOrCorp" name="retOrCorp" onClick="onRadioButtonChange();" value=\'Retail\' CHECKED >' + jspResArr.get("FLT021333") + '');
	write('<input type="radio" id = "retOrCorp" name="retOrCorp" onClick="onRadioButtonChange();" value=\'Corporate\'>' + jspResArr.get("FLT004692") + '');
	write('<input type="radio" id = "retOrCorp" name="retOrCorp" onClick="onRadioButtonChange();" value=\'NonCustomer\'>' + jspResArr.get("FLT016495") + '');
	write('</td>');
	write('</tr>');
	}
	write('</table>');
	write('</td></tr></table>');
	write('</td></tr></table>');
	write('<table width="100%" border="0" cellpadding="4" cellspacing="0">');
	write('<tr>');
	write('<td >');
	write('<input class="button" type="button" id="Ok" name="Ok" value="' + jspResArr.get("FLT000193") + '" onClick= "javascript:onButtonClick()"   hotKeyId="Submit"   >');
	write('<input class="button" type="button" id="Cancel" name="Cancel" value="' + jspResArr.get("FLT003328") + '" onclick=\'parent.window.close()\' 	 hotKeyId="Cancel"   >');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</CENTER>');
	write('<input type="Hidden" name="wReturn" value="' + wReturn + '">');
	write('<input type="Hidden" name="wReturnDesc" value="' + rtnDesc + '">');
	write('<input type="Hidden" name="delFlg" value="' + delFlg + '">');
	write('<input type="Hidden" name="cif" value="' + cif + '">');
	write('<input type="Hidden" name="srchCrit" value="' + srchCrit + '">');

	} 
} //End function
function writeBSNOperation(){
with(document) {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="Blacklist">'+jspResArr.get("FLT027809")+'</OPTION>');
write('<OPTION VALUE="Suspend">'+jspResArr.get("FLT013020")+'</OPTION>');
write('<OPTION VALUE="Negate">'+jspResArr.get("FLT027810")+'</OPTION>');
write('<OPTION VALUE="All">'+jspResArr.get("FLT011937")+'</OPTION>');
}
}



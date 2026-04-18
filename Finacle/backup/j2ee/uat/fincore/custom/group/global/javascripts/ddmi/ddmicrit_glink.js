// Generated from spec file 

function printBlock()
{
	writeHeader("ddmicrit");
	with (document) {
	write('<table class="ctable" width="100%" border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT002038") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table class="ctable" border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('</td></tr></table>');
	write('<table class="tableborder" border="0" cellspacing="0" cellpadding="0" width="100%">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td > <table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
	write('<td align="right"><table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right"><a target=_self href="javascript:showHelpFile(\'ddmicrit_help.htm\');"><IMG src="../Renderer/images/' + applangcode + '/help.gif" border="0" hotKeyId="finHelp"></img><a></td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000204") + '<script>setMandatory("Y")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<select class="listboxfont" id="funcCode" name="' + groupName + '.funcCode" fmnd=\'Y\' ' + ddmiProps.get("funcCode_ENABLED") + ' onChange="javascript:return ddmicrit_ONCHANGE4(this);">');
	writeComboFunction("writeDDMIFuncCodes");
	write('</select>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT000634") + '<script>setMandatory("' + ddmiProps.get("tranId_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="tranId" name="' + groupName + '.tranId" fmnd="' + ddmiProps.get("tranId_MANDATORY") + '" size="25" maxlength=9 ' + ddmiProps.get("tranId_ENABLED") + ' hotKeyId="search1">');
	write('&nbsp;<a target=_self id="sLnk13" href="Javascript:showDdIdList(objForm.tranId,objForm.funcCode,\'I\')"><img alt="Search" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></img></a>');
	write('<span class="display"> </span>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	PRINTDATEFLD("issDate","Y","2",jspResArr.get("FLT000457"),"Y","N","N","","","");
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000002") + '<script>setMandatory("' + ddmiProps.get("refNum_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="refNum" name="' + groupName + '.refNum" fmnd="' + ddmiProps.get("refNum_MANDATORY") + '" size="25" maxlength=20 ' + ddmiProps.get("refNum_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	PRINTDATEFLD("valueDate","Y","16",jspResArr.get("FLT000591"),"N","N","N","","","","","","Y");
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT001447") + '<script>setMandatory("' + ddmiProps.get("ddTemplateId_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="ddTemplateId" name="' + groupName + '.ddTemplateId" fmnd="' + ddmiProps.get("ddTemplateId_MANDATORY") + '" hotKeyId="search21" onChange="javascript:return ddmicrit_ONCHANGE5(this);" maxlength=25 ' + ddmiProps.get("ddTemplateId_ENABLED") + '>');
	write('&nbsp;<a href="Javascript:showGtmplSearcher()" id="sLnk21">');
	write('<img hotKeyId="search21" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0"></a><br>');
	write('<input class="label" name="' + groupName + '.templateType" id="templateType" fds="Y" size=8 disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT001981") + '<script>setMandatory("' + ddmiProps.get("printInd_MANDATORY") + '")</script>');
	write('</td>');
	write('<td>');
	write('<input type="radio" id="printInd" name="' + groupName + '.printInd" value=\'I\' ' + ddmiProps.get("printInd_ENABLED") + ' >' + jspResArr.get("FLT002040") + '');
	write('<input type="radio" id="printInd" name="' + groupName + '.printInd" value=\'L\' checked ' + ddmiProps.get("printInd_ENABLED") + ' >' + jspResArr.get("FLT002041") + '');
	write('<input type="radio" id="printInd" name="' + groupName + '.printInd" value=\'B\' ' + ddmiProps.get("printInd_ENABLED") + ' >' + jspResArr.get("FLT002042") + '');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield"><span class="display"> </span></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT001726") + '<script>setMandatory("' + ddmiProps.get("ddAcctId_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield" colspan="4" >');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="ddAcctId" name="' + groupName + '.ddAcctId" fmnd="Y" onChange="javascript:return ddmicrit_ONCHANGE6(this,this,\'ddAcctName\',\'ddSolId\',\'ddAcctCrncy\',true,\'VALACCTID\');" size="25" maxlength=16 ' + ddmiProps.get("ddAcctId_ENABLED") + ' fdt="accountid" hotKeyId="search2">');
	write('&nbsp;<a target=_self id="sLnk12" href="Javascript:showAccountIdList(objForm.ddAcctId,objForm.ddSolId,objForm.ddAcctName,\'F\',objForm.ddAcctCrncy,\'\',\'\',\'DDA\')"><img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" </img hotKeyId="search2"></a>');
	write('&nbsp;<a  href="Javascript:fnExplodeAcct(objForm.ddAcctId)" id="sLnk7">');
	write('<img explodeId="explode1" src="../Renderer/images/' + applangcode + '/explode.gif" width="16" height="16" border="0"></a>&nbsp;');
	write('<input class="label" name="' + groupName + '.ddAcctCrncy" id="ddAcctCrncy" fds="Y" size=3 disabled>');
	write('<input class="label" name="' + groupName + '.ddSolId" id="ddSolId" fds="Y" size=8 disabled>');
	write('<input class="label" name="' + groupName + '.ddAcctName" id="ddAcctName" fds="Y" size=15 disabled>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" >' + jspResArr.get("FLT002039") + '<script>setMandatory("' + ddmiProps.get("ddRptCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="ddRptCode" name="' + groupName + '.ddRptCode" fmnd="' + ddmiProps.get("ddRptCode_MANDATORY") + '" size="25" maxlength=5 ' + ddmiProps.get("ddRptCode_ENABLED") + ' hotKeyId="search3">');
	write('&nbsp;<a target=_self id="sLnk3" href="Javascript:showRefCode(objForm.ddRptCode,\'10\',\'N\',\'F\',objForm.ddRptCodeDesc)"><img alt="Search" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0"</img hotKeyId="search3"></a><br>');
	write('<input class="label" name="' + groupName + '.ddRptCodeDesc" id="ddRptCodeDesc" fds="Y" size=20 disabled>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr class="subhdrbg">');
	write('<td class="subhdr" colspan="5">');
	write('' + jspResArr.get("FLT002043") + '');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000704") + '<script>setMandatory("' + ddmiProps.get("purType_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="radio" id="purType" name="' + groupName + '.purType" value=\'C\' checked ' + ddmiProps.get("purType_ENABLED") + ' onClick="javascript:return ddmicrit_ONCLICK7(this);">');
	write('' + jspResArr.get("FLT001033") + '<br>');
	write('<input type="radio" id="purType" name="' + groupName + '.purType" value=\'TBI\' ' + ddmiProps.get("purType_ENABLED") + ' onClick="javascript:return ddmicrit_ONCLICK8(this);">');
	write('' + jspResArr.get("FLT002044") + '<br>');
	write('<input type="radio" id="purType" name="' + groupName + '.purType" value=\'TCI\' ' + ddmiProps.get("purType_ENABLED") + ' onClick="javascript:return ddmicrit_ONCLICK9(this);">');
	write('' + jspResArr.get("FLT002045") + '');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield"><span class="display"></span></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT002047") + '<script>setMandatory("' + ddmiProps.get("purAcctId_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield" >');
	write('<input type="text" class="textfieldfont" id="purAcctId" fmnd="' + ddmiProps.get("purAcctId_MANDATORY") + '" name="' + groupName + '.purAcctId" onChange="javascript:return ddmicrit_ONCHANGE11(this,this,\'pAcctName\',\'pSolId\',\'pAcctCrncy\',true,\'VALACCTID\',\'PUR\');" onBlur="javascript:return ddmicrit_ONBLUR10(this);" size="25" maxlength=16 ' + ddmiProps.get("purAcctId_ENABLED") + ' fdt="accountid" hotKeyId="search4">');
	write('&nbsp;<a target=_self id="sLnk4" href="Javascript:fnSrchrFetchAcctDtls()"><img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" </img hotKeyId="search4"></a>');
	write('&nbsp;<a  href="Javascript:fnExplodeAcct(objForm.purAcctId)" id="sLnk27">');
	write('<img explodeId="explode1" src="../Renderer/images/' + applangcode + '/explode.gif" width="16" height="16" border="0"></a>&nbsp;');
	write('<a id="sLnk14" href="javascript:showSignature();">');
	write('<img class="img" title="' + jspResArr.get("FLT001020") + '" src="../Renderer/images/' + applangcode + '/sig_new1.gif" width="16" height="16"></img></a>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td colspan="2" >');
	write('<input class="label" name="' + groupName + '.pAcctCrncy" id="pAcctCrncy" fds="Y" size=4 disabled>');
	write('<input class="label" name="' + groupName + '.pSolId" id="pSolId" fds="Y" size=10 disabled>');
	write('<input class="label" name="' + groupName + '.pAcctName" id="pAcctName" fds="Y" size=40 disabled>');
	// add by morning start
	write('<input class="label" name="' + groupName + '.purAcctBalance" id="purAcctBalance" fds="Y" size=15 disabled>');
	// add by morning end
	write('</td>');
	write('</tr>');
	if(CRDRD_Pflg){
	write('<tr>');
	write('<td></td>');
	write('<td>');
	write('<input type="button" class="button" id="FetchPurCard" value="' + jspResArr.get("FLT000041") + '" onClick="javascript:return ddmicrit_ONCLICK12(this,this,CRDRD_DeviceId[0]);">');
	write('</td>');
	write('</tr>');
	}
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000006") + '<script>setMandatory("' + ddmiProps.get("purCrncyCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="purCrncyCode" fmnd="' + ddmiProps.get("purCrncyCode_MANDATORY") + '" name="' + groupName + '.purCrncyCode" size="25" maxlength=3 ' + ddmiProps.get("purCrncyCode_ENABLED") + ' hotKeyId="search5">');
	write('&nbsp;<a target=_self id="sLnk5" href="Javascript:showCurrencyList(objForm.purCrncyCode)"><img alt="Search" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0"</img hotKeyId="search5"></a>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT001701") + '<script>setMandatory("' + ddmiProps.get("purName_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="purName" fmnd="' + ddmiProps.get("purName_MANDATORY") + '" name="' + groupName + '.purName" fmb="Y" size="25" maxlength=80 ' + ddmiProps.get("purName_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT014293") + '<script>setMandatory("' + ddmiProps.get("purAddrLine1_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purAddrLine1" id="purAddrLine1" fmb=\'Y\' fmnd="' + ddmiProps.get("purAddrLine1_MANDATORY") + '" size=35 maxlength=45>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT014294") + '<script>setMandatory("' + ddmiProps.get("purAddrLine2_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purAddrLine2" id="purAddrLine2" fmb="Y" size=35 maxlength=45><br>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT014295") + '<script>setMandatory("' + ddmiProps.get("purAddrLine3_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purAddrLine3" id="purAddrLine3" fmb="Y" size=35 maxlength=45><br>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000089") + '</td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purCityCode" id="purCityCode"size=8 maxlength=5 onChange=\'javascript:return ddmicrit_ONCHANGE13(this,"purcityName");\'' + ddmiProps.get("purCityCode_ENABLED") + ' hotKeyId="search14">&nbsp;');
	write('<a id="sLnk19" href="Javascript:showRefCode(objForm.purCityCode,\'01\',\'N\',\'F\',objForm.purcityName)"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search14"></img></a>');
	write('<br>');
	write('<input class="label"  name="' + sGroupName + '.purcityName" id="purcityName" size=10 maxlength=10 fds="Y" disabled >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000090") + '<script>setMandatory("' + ddmiProps.get("purStateCode_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purStateCode" id="purStateCode" fmnd="' + ddmiProps.get("purStateCode_MANDATORY") + '" size=8 maxlength=5 onChange=\'javascript:return ddmicrit_ONCHANGE14(this,"purstateName");\' ' + ddmiProps.get("purStateCode_ENABLED") + ' hotKeyId="search15">&nbsp;');
	write('<a id="sLnk10" href="Javascript:showRefCode(objForm.purStateCode,\'02\',\'N\',\'F\',objForm.purstateName)"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search15"></img></a>');
	write('<br>');
	write('<input class="label"  name="' + sGroupName + '.purstateName" id="purstateName" size=10 maxlength=10 fds="Y" disabled >');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000092") + ' <script>setMandatory("' + ddmiProps.get("purCntryCode_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purCntryCode" id="purCntryCode" fmnd="' + ddmiProps.get("purCntryCode_MANDATORY") + '" size=8 maxlength=5 onChange=\'javascript:return ddmicrit_ONCHANGE15(this,"purcntryName");\' ' + ddmiProps.get("purCntryCode_ENABLED") + ' hotKeyId="search16">&nbsp;');
	write('<a id="sLnk20" href="Javascript:showRefCode(objForm.purCntryCode,\'03\',\'N\',\'F\',objForm.purcntryName)"><img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search16"></img></a>');
	write('<br>');
	write('<input class="label"  name="' + sGroupName + '.purcntryName" id="purcntryName" size=10 maxlength=10fds="Y" disabled >');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000091") + '<script>setMandatory("' + ddmiProps.get("purPostalCode_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purPostalCode" id="purPostalCode" fmnd="' + ddmiProps.get("purPostalCode_MANDATORY") + '" size=15 maxlength=10></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000164") + '<script>setMandatory("' + ddmiProps.get("purPhNum_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purPhNum" id="purPhNum" fmnd="' + ddmiProps.get("purPhNum_MANDATORY") + '" size=15 maxlength=15 ' + ddmiProps.get("purPhNum_ENABLED") + '></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000165") + '<script>setMandatory("' + ddmiProps.get("purTelexNum_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purTelexNum" id="purTelexNum" fmnd="' + ddmiProps.get("purTelexNum_MANDATORY") + '" size=15 maxlength=15 ' + ddmiProps.get("purTelexNum_ENABLED") + '></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	//write('<td class="textlabel">' + jspResArr.get("FLT000166") + '<script>setMandatory("' + ddmiProps.get("purFaxNum_MANDATORY") + '")</script></td>');
	write('<td class="textlabel">ID Number<script>setMandatory("' + ddmiProps.get("purFaxNum_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.purFaxNum" id="purFaxNum" fmnd="' + ddmiProps.get("purFaxNum_MANDATORY") + '" size=15 maxlength=15 ' + ddmiProps.get("purFaxNum_ENABLED") + '></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000167") + '<script>setMandatory("' + ddmiProps.get("purEmailId_MANDATORY") + '")</script></td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="normal textfieldfont" fdt="lcase"  name="' + sGroupName + '.purEmailId" id="purEmailId" fmb="Y" fmnd="' + ddmiProps.get("purEmailId_MANDATORY") + '" size=35 maxlength=50 ' + ddmiProps.get("purEmailId_ENABLED") + '></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT002048") + '<script>setMandatory("' + ddmiProps.get("purChqAlpha_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="twotextfieldnoicon" id="purChqAlpha" fmnd="' + ddmiProps.get("purChqAlpha_MANDATORY") + '" name="' + groupName + '.purChqAlpha" size="25" maxlength=6 title="' + jspResArr.get("FHP000445") + '" ' + ddmiProps.get("purChqAlpha_ENABLED") + '>&nbsp;');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="twotextfieldnoicon" id="purChqNum" fdt="fpint" fmnd="' + ddmiProps.get("purChqNum_MANDATORY") + '" name="' + groupName + '.purChqNum" size=18 maxlength=16 title="' + jspResArr.get("FHP000686") + '" ' + ddmiProps.get("purChqNum_ENABLED") + '><br>');
	PRINTDATEFLD("purChqDate","Y","6","","N","N","N","","","","Y","N","N");
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT002039") + '<script>setMandatory("' + ddmiProps.get("purRptCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="purRptCode" fmnd="' + ddmiProps.get("purRptCode_MANDATORY") + '" name="' + groupName + '.purRptCode" size="25" maxlength=5 ' + ddmiProps.get("purRptCode_ENABLED") + ' hotKeyId="search6">');
	write('&nbsp;<a target=_self id="sLnk25" href="Javascript:showRefCode(objForm.purRptCode,\'10\',\'N\',\'F\',objForm.purRptCodeDesc)"><img alt="Search" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" </img hotKeyId="search6"></a><br>');
	write('<input class="label" name="' + groupName + '.purRptCodeDesc" id="purRptCodeDesc" fds="Y" size=20 disabled></td>');
	write('</tr>');
	write('<tr>');
	if(CHQRD_Pflg){
	write('<tr>');
	write('<td></td>');
	write('<td>');
	write('<input type="button" class="button" id="FetchPurCheque" value="' + jspResArr.get("FLT000041") + '" onClick="javascript:return ddmicrit_ONCLICK16(this,this,CHQRD_DeviceId[0]);">');
	write('</td>');
	write('</tr>');
	}
	write('<td class="textlabel">' + jspResArr.get("FLT004194") + '<script>setMandatory("' + ddmiProps.get("purPstInd_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="purPstInd" name="' + groupName + '.purPstInd" fmnd="' + ddmiProps.get("purPstInd_MANDATORY") + '" size="25" maxlength=2 ' + ddmiProps.get("purPstInd_ENABLED") + ' hotKeyId="search7">');
	write('&nbsp;<a id="sLnk22" target=_self href="Javascript:showRefCode(objForm.purPstInd,\'BK\',\'N\',\'B\')"><img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search7"></img></a>');
	write('</td>');
	write('<td class="columnwidth1">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr class="subhdrbg">');
	write('<td colspan="5" class="subhdr">');
	write('' + jspResArr.get("FLT002046") + '');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000704") + '<script>setMandatory("' + ddmiProps.get("commType_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="radio" id="commType" name="' + groupName + '.commType" checked value=\'C\' ' + ddmiProps.get("commType_ENABLED") + ' onClick="javascript:return ddmicrit_ONCLICK17(this);">');
	write('' + jspResArr.get("FLT001033") + '<br>');
	write('<input type="radio" id="commType" name="' + groupName + '.commType" value=\'TBI\' ' + ddmiProps.get("commType_ENABLED") + ' onClick="javascript:return ddmicrit_ONCLICK18(this);">');
	write('' + jspResArr.get("FLT002044") + '<br>');
	write('<input type="radio" id="commType" name="' + groupName + '.commType" value=\'TCI\' ' + ddmiProps.get("commType_ENABLED") + ' onClick="javascript:return ddmicrit_ONCLICK19(this);">');
	write('' + jspResArr.get("FLT002045") + '');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield"><span class="display"></span></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT002049") + '<script>setMandatory("' + ddmiProps.get("commAcctId_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield" colspan="4">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="commAcctId" name="' + groupName + '.commAcctId" fmnd="' + ddmiProps.get("commAcctId_MANDATORY") + '" onChange="javascript:return ddmicrit_ONCHANGE20(this,this,\'commAcctName\',\'commSolId\',\'commAcctCrncy\',true,\'VALACCTID\',\'COMM\');" size="25" maxlength=16 ' + ddmiProps.get("commAcctId_ENABLED") + ' fdt="accountid" hotKeyId="search8">');
	write('&nbsp;<a target=_self id="sLnk8" href="Javascript:fnShowAccountIdList(objForm.commAcctId,objForm.commSolId,objForm.commAcctName,\'F\',objForm.commAcctCrncy,\'COMM\')"><img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" </img hotKeyId="search8"></a>');
	write('&nbsp;<a  href="Javascript:fnExplodeAcct(objForm.commAcctId)" id="sLnk26">');
	write('<img explodeId="explode1" src="../Renderer/images/' + applangcode + '/explode.gif" width="16" height="16" border="0"></a>&nbsp;');
	write('<a id="sLnk15" href="javascript:showSignatureComm();">');
	write('<img class="img" title="' + jspResArr.get("FLT001020") + '" src="../Renderer/images/' + applangcode + '/sig_new1.gif" width="16" height="16"></img></a>');
	write('<input class="label" name="' + groupName + '.commAcctCrncy" id="commAcctCrncy" fds="Y" size=3 disabled>');
	write('<input class="label" name="' + groupName + '.commSolId" id="commSolId" fds="Y" size=8 disabled>');
	write('<input class="label" name="' + groupName + '.commAcctName" id="commAcctName" fds="Y" size=15 disabled>');
	write('</td>');
	write('</tr>');
	if(CRDRD_Pflg){
	write('<tr>');
	write('<td></td>');
	write('<td>');
	write('<input type="button" class="button" id="FetchCommCard" value="' + jspResArr.get("FLT000041") + '" onClick="javascript:return ddmicrit_ONCLICK21(this,this,CRDRD_DeviceId[0]);">');
	write('</td>');
	write('</tr>');
	}
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT000006") + '<script>setMandatory("' + ddmiProps.get("commCrncyCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="commCrncyCode" name="' + groupName + '.commCrncyCode" fmnd="' + ddmiProps.get("commCrncyCode_MANDATORY") + '" size="25" maxlength=3 ' + ddmiProps.get("commCrncyCode_ENABLED") + ' hotKeyId="search9">');
	write('&nbsp;<a target=_self id="sLnk9" href="Javascript:showCurrencyList(objForm.commCrncyCode)"><img alt="Search" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0"</img hotKeyId="search9"></a>');
	write('</td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel" >' + jspResArr.get("FLT002048") + '<script>setMandatory("' + ddmiProps.get("commChqAlpha_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="twotextfieldnoicon" id="commChqAlpha" fmnd="' + ddmiProps.get("commChqAlpha_MANDATORY") + '" name="' + groupName + '.commChqAlpha" size="25" maxlength=6 ' + ddmiProps.get("commChqAlpha_ENABLED") + '>&nbsp;');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="twotextfieldnoicon" id="commChqNum" fdt="fpint" name="' + groupName + '.commChqNum" fmnd="' + ddmiProps.get("commChqNum_MANDATORY") + '" size="25" maxlength=16 ' + ddmiProps.get("commChqNum_ENABLED") + '><br>');
	PRINTDATEFLD("commChqDate","Y","18","","N","N","N","","","","Y","N","N");
	write('</td>');
	write('</tr>');
	if(CHQRD_Pflg){
	write('<tr>');
	write('<td></td>');
	write('<td></td>');
	write('<td></td>');
	write('<td></td>');
	write('<td>');
	write('<input type="button" class="button" id="FetchCommCheque" value="' + jspResArr.get("FLT000041") + '" onClick="javascript:return ddmicrit_ONCLICK22(this,this,CHQRD_DeviceId[0]);">');
	write('</td>');
	write('</tr>');
	}
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT002039") + '<script>setMandatory("' + ddmiProps.get("commRptCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield">');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="commRptCode" name="' + groupName + '.commRptCode" fmnd="' + ddmiProps.get("commRptCode_MANDATORY") + '" size="25" maxlength=5 ' + ddmiProps.get("commRptCode_ENABLED") + ' hotKeyId="search10">');
	write('&nbsp;<a target=_self id="sLnk11" href="Javascript:showRefCode(objForm.commRptCode,\'10\',\'N\',\'F\',objForm.commRptCodeDesc)"><img alt="Search" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0"</img hotKeyId="search10"></a><br>');
	write('<input class="label" name="' + groupName + '.commRptCodeDesc" id="commRptCodeDesc" fds="Y" size=20 disabled></td>');
	write('<td class="columnwidth">&nbsp;</td>');
	write('<td class="textlabel">&nbsp;</td>');
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	if (firstTimeAdd=='N') {
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr class="subhdrbg">');
	write('<td colspan="5" class="subhdr">' + jspResArr.get("FLT002825") + '</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT001630") + '<script>setMandatory("' + ddmiProps.get("purRateCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield" colspan="4">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + groupName + '.purRateCode" fmnd="Y" id="purRateCode" size="6" maxlength="5" value="' + purRateCode + '" title="' + jspResArr.get("FHP000327") + '" onChange="javascript:return ddmicrit_ONCHANGE23(this);" ' + ddmiProps.get("purRateCode_ENABLED") + ' hotKeyId="search11">');
	write('&nbsp;<a target="_self" id="sLnk23" href="JavaScript:showRefCode(objForm.purRateCode,\'67\',\'N\',\'F\')">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search11"></a>');
	write('<br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" fdt="frate" id="purRate" fmnd="Y" name="' + groupName + '.purRate" size="25" maxlength=12 ' + ddmiProps.get("purRate_ENABLED") + ' value="' + purRate + '" title="' + jspResArr.get("FHP000230") + '"><br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" fdt="frate" id="purTreaRate" name="' + groupName + '.purTreaRate" fmnd="' + ddmiProps.get("purTreaRate_MANDATORY") + '" size="25" maxlength=12 ' + ddmiProps.get("purTreaRate_ENABLED") + ' value="' + purTreaRate + '" title="' + jspResArr.get("FHP000231") + '"><br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="purTreaRefNum" name="' + groupName + '.purTreaRefNum" fmnd="' + ddmiProps.get("purTreaRefNum_MANDATORY") + '" size="25" maxlength=16 ' + ddmiProps.get("purTreaRefNum_ENABLED") + ' value="' + purTreaRefNum + '" title="' + jspResArr.get("FHP000681") + '">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT001631") + '<script>setMandatory("' + ddmiProps.get("commRateCode_MANDATORY") + '")</script>');
	write('</td>');
	write('<td class="textfield" colspan="4">');
	write('<input onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" name="' + groupName + '.commRateCode" fmnd="Y" id="commRateCode" size="6" maxlength="5" value="' + commRateCode + '" title="' + jspResArr.get("FHP000327") + '" onChange="javascript:return ddmicrit_ONCHANGE24(this);" ' + ddmiProps.get("commRateCode_ENABLED") + ' hotKeyId="search12">');
	write('&nbsp;<a target="_self" id="sLnk17" href="JavaScript:showRefCode(objForm.commRateCode,\'67\',\'N\',\'F\')">');
	write('<img class="img" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search12"></a>');
	write('<br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" fdt="frate" fmnd="Y" id="commRate" name="' + groupName + '.commRate" size="25" maxlength=12 ' + ddmiProps.get("commRate_ENABLED") + ' value="' + commRate + '" title="' + jspResArr.get("FHP000230") + '"><br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" fdt="frate" fmnd="' + ddmiProps.get("commTreaRate_MANDATORY") + '" id="commTreaRate" name="' + groupName + '.commTreaRate" size="25" maxlength=12 ' + ddmiProps.get("commTreaRate_ENABLED") + ' value="' + commTreaRate + '" title="' + jspResArr.get("FHP000231") + '"><br>');
	write('<input onChange="javascript:return custom_ONCHANGE(\'ddmicrit\',this);" onBlur="javascript:return custom_ONBLUR(\'ddmicrit\',this);" type="text" class="textfieldfont" id="commTreaRefNum" name="' + groupName + '.commTreaRefNum" fmnd="' + ddmiProps.get("commTreaRefNum_MANDATORY") + '" size="25" maxlength=16 ' + ddmiProps.get("commTreaRefNum_ENABLED") + ' value="' + commTreaRefNum + '" title="' + jspResArr.get("FHP000681") + '">');
	write('</td>');
	write('</tr>');
	}
	write('<tr>');
	write('<td colspan="5" class="rowspacingbottom"></td>');
	write('</tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table></td></tr>');
	write('</table>');
	write('</span>');
	write('<input type="hidden" name="submitform">');
	write('<input type="hidden" name="pagename" value="ddmi">');
	write('<input type="hidden" id="purTranType" name="' + groupName + '.purTranType">');
	write('<input type="hidden" id="purTranSubType" name="' + groupName + '.purTranSubType">');
	write('<input type="hidden" id="commTranType" name="' + groupName + '.commTranType">');
	write('<input type="hidden" id="commTranSubType" name="' + groupName + '.commTranSubType">');
	} 
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return doRefSubmit(this);"	hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	write('<div class="ctable">');
	if (firstTimeAdd=='N') {
	write('<input class="button" type="button" id="Accept" value=' + jspResArr.get("FLT000191") + ' onclick="javascript:return ddmicrit_ONCLICK25(this,objForm.Accept);" hotKeyId="Go" >');
	write('<input class="button" type="button" id="Cancel" value=' + jspResArr.get("FLT000192") + ' onclick="javascript:return ddmicrit_ONCLICK26(this,objForm.Cancel);" hotKeyId="Cancel" >');
	} else {
	write('<input class="button" type="button" id="Go" value=' + jspResArr.get("FLT004977") + ' onclick="javascript:return ddmicrit_ONCLICK27(this,objForm.Go);" hotKeyId="Go" >');
	write('<input class="button" type="button" id="Clear" value=' + jspResArr.get("FLT001439") + ' onclick="javascript:return ddmicrit_ONCLICK28(this,objForm.Clear);">');
	write('<input class="button" type="button" id="GetValueDate" value="' + jspResArr.get("FLT009483") + '" onclick="javascript:return ddmicrit_ONCLICK29(this,objForm.GetValueDate);">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
} //End function

function fnPopulateControlValues()
{
	var frm = document.forms[0];

	 // add by morning start
	getFieldsFromCustomData("purAcctBalance");
	// add by morning end
	frm.funcCode.value = funcCode;
	frm.ddTemplateId.value = ddTemplateId;
	frm.templateType.value = templateType;
	frm.tranId.value = tranId;
	frm.issDate.value = issDate;
	frm.refNum.value = refNum;
	frm.printInd.value = printInd;
	frm.ddAcctId.value = ddAcctId;
	frm.ddRptCode.value = ddRptCode;
	frm.purType.value = purType;
	frm.purTranType.value = purTranType;
	frm.purTranSubType.value = purTranSubType;
	frm.purAcctId.value = purAcctId;
	frm.pAcctCrncy.value = pAcctCrncy;
	frm.pSolId.value = pSolId;
	frm.pAcctName.value = pAcctName;
	frm.purCrncyCode.value = purCrncyCode;
	frm.purName.value = purName;
	frm.purChqAlpha.value = purChqAlpha;
	frm.purChqNum.value = purChqNum;
	frm.purChqDate.value = purChqDate;
	frm.purRptCode.value = purRptCode;
	frm.commType.value = commType;
	frm.commTranType.value = commTranType;
	frm.commTranSubType.value = commTranSubType;
	frm.commAcctId.value = commAcctId;
	frm.commCrncyCode.value = commCrncyCode;
	frm.commChqAlpha.value = commChqAlpha;
	frm.commChqNum.value = commChqNum;
	frm.commChqDate.value = commChqDate;
	frm.commRptCode.value = commRptCode;
	frm.ddAcctCrncy.value = ddAcctCrncy;
	frm.ddSolId.value = ddSolId;
	frm.ddAcctName.value = ddAcctName;
	frm.commAcctCrncy.value = commAcctCrncy;
	frm.commSolId.value = commSolId;
	frm.commAcctName.value = commAcctName;
	frm.purPstInd.value = purPstInd;
	frm.valueDate.value = valueDate;
	frm.purAddrLine1.value = purAddrLine1;
	frm.purCityCode.value = purCityCode;
	frm.purcityName.value = purcityName;
	frm.purAddrLine2.value = purAddrLine2;
	frm.purAddrLine3.value = purAddrLine3;
	frm.purStateCode.value = purStateCode;
	frm.purstateName.value = purstateName;
	frm.purPostalCode.value = purPostalCode;
	frm.purCntryCode.value = purCntryCode;
	frm.purcntryName.value = purcntryName;
	frm.purPhNum.value = purPhNum;
	frm.purTelexNum.value = purTelexNum;
	frm.purFaxNum.value = purFaxNum;
	frm.purEmailId.value = purEmailId;
	if ((sReferralMode == 'I') || (sReferralMode == 'S')){
		fnDisableFormDataControls('V',frm,0);
	}
}


function ddmicrit_ONKEYDOWN1(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if ((retVal = fnKeyDownProcessor(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONKEYDOWN') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONKEYUP2(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	if ((retVal = fnKeyUpProcessor(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONKEYUP') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONLOAD3(obj,p1)
{
	var retVal = "";
	var frmObj = document.forms[0];
	if (pre_ONLOAD('ddmicrit',obj) == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONLOAD') == false) { 
		return false;
	}
	if ((retVal = fnOnLoad()) == false) {
		return false;
	}
	if ((retVal = fnAssignDateOnLoad(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONLOAD') == false) { 
		return false;
	}
	fnPopUpExceptionWindow(frmObj.actionCode);
	if (post_ONLOAD('ddmicrit',obj) == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE4(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = manageFuncCode()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE5(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fetchTemplateDtls()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE6(obj,p1,p2,p3,p4,p5,p6)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnCommonFetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK7(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = managePurType()) == false) {
		return false;
	}
	if ((retVal = updateCommType()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK8(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = managePurType()) == false) {
		return false;
	}
	if ((retVal = updateCommType()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK9(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = managePurType()) == false) {
		return false;
	}
	if ((retVal = updateCommType()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONBLUR10(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONBLUR') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONBLUR') == false) { 
		return false;
	}
	if ((retVal = setCommDetails()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONBLUR') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONBLUR') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE11(obj,p1,p2,p3,p4,p5,p6,p7)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnFetchAcctDtls(p1,p2,p3,p4,p5,p6,p7)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK12(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnInvokeDevice(p1,p2)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE13(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE14(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE15(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = clearDescField(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK16(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnInvokeDevice(p1,p2)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK17(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = manageCommType()) == false) {
		return false;
	}
	if ((retVal = setCommDetails()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK18(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = manageCommType()) == false) {
		return false;
	}
	if ((retVal = setCommDetails()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK19(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = manageCommType()) == false) {
		return false;
	}
	if ((retVal = setCommDetails()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE20(obj,p1,p2,p3,p4,p5,p6,p7)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnFetchAcctDtls(p1,p2,p3,p4,p5,p6,p7)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK21(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnInvokeDevice(p1,p2)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK22(obj,p1,p2)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnInvokeDevice(p1,p2)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE23(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = callRateDtls()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCHANGE24(obj)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = callChrgRateDtls()) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK25(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK26(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK27(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK28(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function ddmicrit_ONCLICK29(obj,p1)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
		return false;
	}
	if (postEventCallForLocale('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function writeDDMIFuncCodes()
{
with(document) {
    var workclass=USER_MENU_ID.substring(9, 12);
    if ((workclass=="150")||(workclass=="200")||(workclass=="116"))
	{
	write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
	write('<OPTION VALUE="I">'+jspResArr.get("FLT012161")+'</OPTION>');
	write('<OPTION VALUE="M">'+jspResArr.get("FLT012350")+'</OPTION>');
	write('<OPTION VALUE="D">'+jspResArr.get("FLT013215")+'</OPTION>');
	write('<OPTION VALUE="P">'+jspResArr.get("FLT013332")+'</OPTION>');
        }
   else
      {
write('<OPTION VALUE="">'+jspResArr.get("FLT012410")+'</OPTION>');
write('<OPTION VALUE="A">'+jspResArr.get("FLT011931")+'</OPTION>');
write('<OPTION VALUE="D">'+jspResArr.get("FLT013215")+'</OPTION>');
write('<OPTION VALUE="I">'+jspResArr.get("FLT012161")+'</OPTION>');
write('<OPTION VALUE="M">'+jspResArr.get("FLT012350")+'</OPTION>');
write('<OPTION VALUE="P">'+jspResArr.get("FLT013332")+'</OPTION>');
write('<OPTION VALUE="R">'+jspResArr.get("FLT012894")+'</OPTION>');
write('<OPTION VALUE="T">'+jspResArr.get("FLT020990")+'</OPTION>');
     }

}
}


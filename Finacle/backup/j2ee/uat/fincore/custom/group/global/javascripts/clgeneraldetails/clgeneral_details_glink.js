function printBlock() {
    writeHeader("clgeneral_details");
    with(document) {
        write('<input type="hidden" name="submitform">');
        write('<input type="hidden" name="pagename" value="clgeneraldetails">');
        write('<input type="hidden" id="collectCharges" name="' + sGroupName + '.collectCharges">');
        write('<input type="hidden" id="turoverDtls" name="' + sGroupName + '.turoverDtls">');
        write('<input type="hidden" id="localCalendar" name="' + sGroupName + '.localCalendar" value="N">');
        if (sMode == "A") {
            write('<input type="hidden" id="collectionOfficer" name="' + sGroupName + '.collectionOfficer" value="">');
            write('<input type="hidden" id="collectionOfficerName" name="' + sGroupName + '.collectionOfficerName" value="">')
        }
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write("<tr>");
        write("<td>");
        write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
        write("<tr>");
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td class=""><spacer type="block" height=1 width=1></spacer></td>');
        write('<td colspan="3"><spacer type="block" width="1" height="1"></spacer>');
        write('<td align="right"><table border="0" cellspacing="0" cellpadding="0">');
        write("<tr><td> </td>");
        write('<td align="right"><a target=_self href="javascript:showHelpFile(\'clgeneraldetails_help.htm\')" id="sLnk11"><img src="../Renderer/images/' + applangcode + '/help.gif" border="0" hotKeyId="finHelp"></img></a></td>');
        write("</tr>");
        write("</table>");
        write("</td></tr>");
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing1"><spacer type="block" height=1 width=1></spacer></td>');
        write("</tr>");
        write('<tr valign="middle" class="subhdrbg">');
        write('<td colspan="2" class="subhdr">' + jspResArr.get("FLT001486") + "</td>");
        write('<td colspan="3"><spacer type="block" width="1" height="1"></spacer>');
        write('<td colspan="3" align="right">');
        write('<div id="dispText0"><img id="expand0" align="right" border="0" src="../Renderer/images/' + applangcode + '/expand.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return clgeneral_details_ONCLICK4(this,"1","C");\'></img></div>');
        write('<div id="hideText0" style="display: none"><img id="collapse0" align="right" border="0" src="../Renderer/images/' + applangcode + '/collapse.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return clgeneral_details_ONCLICK5(this,"2","C");\'></img></div>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write("<td colspan=5>");
        write('<table id="sT1" style="display: none" cellspacing="0" width="100%" cellpadding="0">');
        write('<tr class="innertabletop1">');
        write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000440") + "</td>");
        write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(custConst) + "</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >' + jspResArr.get("FLT000435") + "</td>");
        write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(custShortName) + "</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel" >' + jspResArr.get("FLT004406") + "</td>");
        write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(panGirNum) + "</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >' + jspResArr.get("FLT001430") + "</td>");
        write('<td class="textfielddisplaylabel" >' + jsUtil.encodeChar(custGroup) + "</td>");
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write('<tr valign="middle" class="subhdrbg">');
        write('<td colspan="2" class="subhdr">' + jspResArr.get("FLT000011") + "</td>");
        write('<td colspan="3"><spacer type="block" width="1" height="1"></spacer>');
        write('<td colspan="3" align="right" valign="middle">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel" >' + jspResArr.get("FLT000012") + '<script>setMandatory("Y")<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.acctName" fmnd="Y" id="acctName" fmb="Y" fdt="lcase" style="TEXT-TRANSFORM:none" size=35 maxlength=80 ' + clgeneraldetailsProps.get("acctName_ENABLED") + "></td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >' + jspResArr.get("FLT000013") + '<script>setMandatory("Y")<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.acctShortName" id="acctShortName" fmnd="Y" fmb="Y" size=18 maxlength=10 ' + clgeneraldetailsProps.get("acctShortName_ENABLED") + "></td>");
        write("</tr>");
        write("<tr>");
        PRINTDATEFLD("acctOpenDate", "Y", "1", jspResArr.get("FLT000014"), "N", "N", "", "", "", "");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT000015") + '	<script>setMandatory("' + clgeneraldetailsProps.get("chargeLvlCode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.chargeLvlCode" id="chargeLvlCode" fmnd="' + clgeneraldetailsProps.get("chargeLvlCode_MANDATORY") + '" ' + clgeneraldetailsProps.get("chargeLvlCode_ENABLED") + ' size=9 maxlength=5 onchange="javascript:return clgeneral_details_ONCHANGE6(this,\'chargeLvlDesc\');" hotKeyId="search1">&nbsp;');
        write("<a id=\"sLnk2\" target=_self href=\"javascript:showRefCode(objForm.chargeLvlCode,'BH','N','F',objForm.chargeLvlDesc)\"><img src=\"../Renderer/images/" + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"> </img></a><br>');
        write('<input class="label" name="' + sGroupName + '.chargeLvlDesc" id="chargeLvlDesc" size=20 fds="Y" disabled></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel" >' + jspResArr.get("FLT000016") + '<script>setMandatory("' + clgeneraldetailsProps.get("locationCode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"name="' + sGroupName + '.locationCode" id="locationCode" fmnd="' + clgeneraldetailsProps.get("locationCode_MANDATORY") + '" ' + clgeneraldetailsProps.get("locationCode_ENABLED") + ' size=9 maxlength=5 onchange="javascript:return clgeneral_details_ONCHANGE7(this,\'locationDesc\');" hotKeyId="search2">&nbsp;');
        write("<a id=\"sLnk3\" target=_self href=\"javascript:showRefCode(objForm.locationCode,19,'N','F',objForm.locationDesc)\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></img></a><br>');
        write('<input class="label" name="' + sGroupName + '.locationDesc" id="locationDesc" size=20 fds="Y" disabled></td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >&nbsp;</td>');
        write('<td class="textfield">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT010374") + '<script>setMandatory("' + clgeneraldetailsProps.get("acctManager_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"name="' + sGroupName + '.acctManager" id="acctManager" fmnd="' + clgeneraldetailsProps.get("acctManager_MANDATORY") + '" ' + clgeneraldetailsProps.get("acctManager_ENABLED") + ' size=9 maxlength=5 onchange="javascript:return clgeneral_details_ONCHANGE8(this,\'acctMgrName\');" hotKeyId="search3">&nbsp;');
        write('<a id="sLnk4" target=_self href=\'javascript:showUserIdList(objForm.acctManager,null,"F",objForm.acctMgrName)\'>');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></img></a><br>');
        write('<input class="label" name="' + sGroupName + '.acctMgrName" id="acctMgrName" size=15 fds="Y" disabled ></td>');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >' + jspResArr.get("FLT000017") + '<script>setMandatory("' + clgeneraldetailsProps.get("acctMgrAtAcct_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.acctMgrAtAcct" id="acctMgrAtAcct" size=9 maxlength=15 onchange="javascript:return clgeneral_details_ONCHANGE9(this,\'acctMgrAtAcctName\');" hotKeyId="search4">');
        write("&nbsp;");
        write("<a id=\"sLnk13\" target=_self href=\"javascript:javascript: showModuleList()\">");
        //write("<a id=\"sLnk13\" target=_self href=\"javascript:showDynSearcher('HSRRM','login_id=:acctMgrAtAcct',':acctMgrAtAcct=login_id')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></img></a>');
        write("<br>");
        write('<input class="label" name="' + sGroupName + '.acctMgrAtAcctName" id="acctMgrAtAcctName" size=15 maxlength=15 fds="Y" disabled >');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT004405") + '<script>setMandatory("' + clgeneraldetailsProps.get("parentCifId_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield" colspan="4" ><input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.parentCifId" id="parentCifId" fdt="cifid" fmnd="' + clgeneraldetailsProps.get("parentCifId_MANDATORY") + '" size="31" maxlength="32" ' + clgeneraldetailsProps.get("parentCifId_ENABLED") + ' onchange="javascript:return clgeneral_details_ONCHANGE10(this,\'parentCustName\');" hotKeyId="search5">&nbsp;');
        write("<a target=_self id=\"sLnk5\" href=\"javascript:showCifId(objForm.parentCifId,'ctrl','F',objForm.parentCustName)\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search5"></img></a>');
        write('<input class="label" name="' + sGroupName + '.parentCustName" id="parentCustName" size=20 maxlength=50 disabled>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000022") + '<script>setMandatory("' + clgeneraldetailsProps.get("acctRptCode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"name="' + sGroupName + '.acctRptCode" id="acctRptCode" fmnd="' + clgeneraldetailsProps.get("acctRptCode_MANDATORY") + '" size="9" maxlength=6 ' + clgeneraldetailsProps.get("acctRptCode_ENABLED") + "></td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >' + jspResArr.get("FLT000030") + '<script>setMandatory("Y")<\/script></td>');
        write('<td class="textfield">');
        write('<select class="listboxfont" name="' + sGroupName + '.pbPsFlg" id="pbPsFlg" fmnd="Y" onChange="javascript:return clgeneral_details_ONCHANGE11(this);" >');
        writePbPsFlg();
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel" >' + jspResArr.get("FLT000031") + '<script>setMandatory("' + clgeneraldetailsProps.get("pbPsFreqType_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" class="textfieldfrequency" name="' + sGroupName + '.pbPsFreqType" id="pbPsFreqType">');
        write('<script type="text/javascript">');
        write("writeFrequencyType();");
        write("<\/script>");
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" class="textfieldfrequency" name="' + sGroupName + '.pbPsFreqWeek" id="pbPsFreqWeek">');
        write('<script type="text/javascript">');
        write("writeWeekNumber();");
        write("<\/script>");
        write("</select><br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" class="textfieldbyday" name="' + sGroupName + '.pbPsFreqDay" id="pbPsFreqDay">');
        write('<script type="text/javascript">');
        write("writeWeekDay();");
        write("<\/script>");
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" id="pbPsFreqStartDD" name="' + sGroupName + '.pbPsFreqStartDD" class="textfieldfreqstaticdate">');
        write('<script type="text/javascript">');
        write("writeFreDates();");
        write("<\/script>");
        write("</select>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" class="textfieldfrequency" name="' + sGroupName + '.pbPsFreqHldyStat" id="pbPsFreqHldyStat">');
        write('<script type="text/javascript">');
        write("writeActionHoliday();");
        write("<\/script>");
        write("</select>");
        write("<br>");
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" class="listboxfont" name="' + sGroupName + '.pbPsFreqCalBase" id="pbPsFreqCalBase">');
        write('<script type="text/javascript">');
        write("writeFrequencyCalendarBase();");
        write("<\/script>");
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT020028") + "</td>");
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" class="listboxfont" name="' + sGroupName + '.prefCalBase" id="prefCalBase">');
        write('<script type="text/javascript">');
        write("writeprefCalendarBase();");
        write("<\/script>");
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT019576") + " </td>");
        write('<td class="textfield">');
        write('<input type="radio" name="' + sGroupName + '.addtnlCalBase" id="addtnlCalBase" ' + clgeneraldetailsProps.get("addtnlCalBase_ENABLED") + ' value="01">' + jspResArr.get("FLT019276") + "");
        write('<input type="radio" name="' + sGroupName + '.addtnlCalBase" id="addtnlCalBase" ' + clgeneraldetailsProps.get("addtnlCalBase_ENABLED") + ' value="00" checked > ' + jspResArr.get("FLT002803") + " </td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >' + jspResArr.get("FLT000033") + '<script>setMandatory("' + clgeneraldetailsProps.get("despatchMode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" class="listboxfont" name="' + sGroupName + '.despatchMode" id="despatchMode">');
        write('<script type="text/javascript">');
        write("writeDespatchMode();");
        write("<\/script>");
        write("</select>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000034") + '<script>setMandatory("' + clgeneraldetailsProps.get("modeOfOperCode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"name="' + sGroupName + '.modeOfOperCode" id="modeOfOperCode" fmnd="' + clgeneraldetailsProps.get("modeOfOperCode_MANDATORY") + '" size=9 maxlength=5 ' + clgeneraldetailsProps.get("modeOfOperCode_ENABLED") + ' onchange="javascript:return clgeneral_details_ONCHANGE12(this,\'modeOfOperDesc\');" hotKeyId="search6">&nbsp;');
        write("<a target=_self id=\"sLnk7\" href=\"javascript:showRefCode(objForm.modeOfOperCode,'27','N','F',objForm.modeOfOperDesc)\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search6"></img></a><br>');
        write('<input class="label" name="' + sGroupName + '.modeOfOperDesc" id="modeOfOperDesc" size=9 fds="Y" disabled >');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        PRINTDATEFLD("nextPrntDate", "Y", "8", jspResArr.get("FLT000035"), "N", "N", "", "", "", "");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel" >' + jspResArr.get("FLT014818") + "</td>");
        write('<td class="textfield" >');
        write('<input type="radio" name="' + sGroupName + '.psAtRelPartyFlg" id="psAtRelPartyFlg" value="Y" ' + clgeneraldetailsProps.get("psAtRelPartyFlg_ENABLED") + " >" + jspResArr.get("FLT001389") + "");
        write('<input type="radio" name="' + sGroupName + '.psAtRelPartyFlg" id="psAtRelPartyFlg" value="N" CHECKED ' + clgeneraldetailsProps.get("psAtRelPartyFlg_ENABLED") + " >" + jspResArr.get("FLT001941") + "");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000036") + '<script>setMandatory("' + clgeneraldetailsProps.get("contactPhNum_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"id="contactPhNum" name="' + sGroupName + '.contactPhNum" fmnd="' + clgeneraldetailsProps.get("contactPhNum_MANDATORY") + '" size="15" maxlength="15" ' + clgeneraldetailsProps.get("contactPhNum_ENABLED") + " ></td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001461") + "</td>");
        write('<td class="textfield" >');
        write('<input type="checkbox" id="chkcollectCharges" class="check" onClick="javascript:return clgeneral_details_ONCLICK13(this,this);" ' + clgeneraldetailsProps.get("collectCharges_ENABLED") + ">&nbsp;" + jspResArr.get("FLT000024") + "<br>");
        write('<input type="checkbox" id="chkturoverDtls" class="check" onClick="javascript:return clgeneral_details_ONCLICK14(this,this);"' + clgeneraldetailsProps.get("turoverDtls_ENABLED") + ">&nbsp;" + jspResArr.get("FLT000025") + "");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000026") + "</td>");
        write('<td class="textfield" ><textarea name="' + sGroupName + '.remarks" id="remarks" class="textfieldfont" fmb="Y" cols=23 rows="2" wrap="virtual" onBlur="javascript:return clgeneral_details_ONBLUR15(this,this,240);" onKeyDown="javascript:return clgeneral_details_ONKEYDOWN16(this,event);"></textarea></td>');
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel" >' + jspResArr.get("FLT004391") + '<script>setMandatory("' + clgeneraldetailsProps.get("applicationRefId_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.applicationRefId" id="applicationRefId" size=20 maxlength=50></td>');
        write("</tr>");
        if (sMode != "A") {
            write("<tr>");
            write('<td class="textlabel" valign="top">' + jspResArr.get("FLT010377") + "</td>");
            write('<td valign="top" class="textfield" ><input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.collectionOfficer" id="collectionOfficer" fmnd="' + clgeneraldetailsProps.get("collectionOfficer_MANDATORY") + '" size=9 maxlength=15 onchange="javascript:return clgeneral_details_ONCHANGE17(this,\'collectionOfficerName\');" hotKeyId="search7">');
            write("&nbsp;");
            write("<a target=_self id=\"sLnk12\" href=\"Javascript:showDynSearcher('HACLIST','agency_nature=C',':collectionOfficer=agency_code|:collectionOfficerName=agency_name')\">");
            write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search7"></img></a>');
            write("<br>");
            write('<input class="label" name="' + sGroupName + '.collectionOfficerName" id="collectionOfficerName" size=15 maxlength=15 fds="Y" disabled >');
            write("</td>");
            write('<td class="columnwidth">&nbsp;</td>');
            write('<td class="textlabel">&nbsp;</td>');
            write('<td class="textfield">&nbsp;</td>');
            write("<tr>")
        }
        write('<tr class="rowspacing">');
        write('<td colspan="5">&nbsp;</td>');
        write("</tr>");
        write('<tr valign="middle" class="subhdrbg">');
        write('<td colspan="2" class="subhdr">' + jspResArr.get("FLT000038") + "</td>");
        write('<td colspan="3"><spacer type="block" width="1" height="1"></spacer>');
        write('<td colspan="3" align="right">');
        write('<div id="dispText1"><img id="expand1" align="right" border="0" src="../Renderer/images/' + applangcode + '/expand.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return clgeneral_details_ONCLICK18(this,"1","N");\'></img></div>');
        write('<div id="hideText1" style="display: none"><img id="collapse1" align="right" border="0" src="../Renderer/images/' + applangcode + '/collapse.gif" onMouseOver=\'displayHand(this)\' onClick=\'javascript:return clgeneral_details_ONCLICK19(this,"2","N");\'></img></div>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write("<td colspan=5>");
        write('<table id="sT2" style="display: none" class="ctable" cellspacing="0" cellpadding="0">');
        write("<tr>");
        write("<tr>");
        write('<td colspan="5" class="rowspacing"><spacer type=block height=1 width=1></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000039") + '<script>setMandatory("' + clgeneraldetailsProps.get("natLangCode_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"name="' + sGroupName + '.natLangCode" id="natLangCode" fmnd="' + clgeneraldetailsProps.get("natLangCode_MANDATORY") + '" size=18 ' + clgeneraldetailsProps.get("natLangCode_ENABLED") + ' maxlength=10 onchange="javascript:return clgeneral_details_ONCHANGE20(this,\'natLangDesc\');" hotKeyId="search8">&nbsp;');
        write('<a target=_self id="sLnk9" href="javascript:showGCTLangCodes(objForm.natLangCode,\'F\',objForm.natLangDesc)">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search8"></img></a><br>');
        write('<input class="label" name="' + sGroupName + '.natLangDesc" id="natLangDesc" size=20 fds="Y" disabled></td>');
        write('<td class="columnwidth" width="30"><spacer type="block" width="1" height="1"></td>');
        write('<td valign="top" class="textlabel">' + jspResArr.get("FLT000040") + '<script>setMandatory("' + clgeneraldetailsProps.get("natLangTitle_MANDATORY") + '")<\/script></td>');
        write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"name="' + sGroupName + '.natLangTitle" fmnd="' + clgeneraldetailsProps.get("natLangTitle_MANDATORY") + '" id="natLangTitle" fmb="Y" size=9 maxlength=5 ' + clgeneraldetailsProps.get("natLangCode_ENABLED") + ' hotKeyId="search9">&nbsp;');
        write("<a id=\"sLnk10\" target=_self href=\"javascript:showRefCode(objForm.natLangTitle,45,'N','F')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search9"></img></a><br>');
        write('<input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont"name="' + sGroupName + '.natLangName" fmnd="' + clgeneraldetailsProps.get("natLangName_MANDATORY") + '" id="natLangName" fmb="Y" size=70 maxlength=80 ' + clgeneraldetailsProps.get("natLangName_ENABLED") + ">");
        write("</td>");
        write("</tr>");
        write("</table>");
        if (dualFlg == "Y") {
            write('<tr valign="middle" class="subhdrbg">');
            write('<td colspan="2" class="subhdr">' + jspResArr.get("FLT021047") + "</td>");
            write('<td colspan="3"><spacer type="block" width="1" height="1"></spacer>');
            write('<td colspan="3" align="right" valign="middle">&nbsp;</td>');
            write("</tr>");
            write("<tr>");
            write('<td colspan="5" class="rowspacing"><spacer type="block" height=1 width=1></spacer></td>');
            write("</tr>");
            write("<tr>");
            write('<td class="textlabel" >' + jspResArr.get("FLT000012") + '<script>setMandatory("' + clgeneraldetailsProps.get("alt1_acctName_MANDATORY") + '")<\/script></td>');
            write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.alt1_acctName" fmnd="' + clgeneraldetailsProps.get("alt1_acctName_MANDATORY") + '" id="alt1_acctName" fmb="Y" fdt="lcase" style="TEXT-TRANSFORM:none" size=35 maxlength=80 ' + clgeneraldetailsProps.get("alt1_acctName_ENABLED") + "></td>");
            write('<td class="columnwidth">&nbsp;</td>');
            write('<td class="textlabel" >' + jspResArr.get("FLT000013") + '<script>setMandatory("' + clgeneraldetailsProps.get("alt1_acctShortName_MANDATORY") + '")<\/script></td>');
            write('<td class="textfield"><input onChange="javascript:return custom_ONCHANGE(\'clgeneral_details\',this);" onBlur="javascript:return custom_ONBLUR(\'clgeneral_details\',this);" type="text" class="textfieldfont" name="' + sGroupName + '.alt1_acctShortName" id="alt1_acctShortName" fmnd="' + clgeneraldetailsProps.get("alt1_acctShortName_MANDATORY") + '" fmb="Y" size=18 maxlength=10 ' + clgeneraldetailsProps.get("alt1_acctShortName_ENABLED") + "></td>");
            write("</tr>")
        }
        write("<tr>");
        write('<td colspan="5" class="rowspacingbottom"></td>');
        write("</tr>");
        write("</td></tr></table>");
        write("</td></tr></table>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</div>");
        write("</span>")
    }
}

function printFooterBlock() {
    with(document) {
        if ((sReferralMode == "I") || (sReferralMode == "S")) {
            write('<div class="ctable">');
            if (sReferralMode == "S") {
                write('<input type="button" class="Button" id="Submit" value="' + jspResArr.get("FLT000193") + '" onClick="javascript:return doRefSubmit(this);"	hotKeyId="Submit" >')
            }
            writeRefFooter();
            write('<input type="button" class="Button" id="_BackRef_" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
            write("</div>")
        } else {
            write('<div class="ctable">');
            if (sMode != "I") {
                write('<input type="button" class="button" id="Submit" name="Submit" value="' + jspResArr.get("FLT000193") + '" onclick=\'javascript:return clgeneral_details_ONCLICK21(this,"Submit");\' / hotKeyId="Submit" >&nbsp;');
                write('<input type="button" class="button" id="Validate" name="Validate" value="' + jspResArr.get("FLT000194") + '" onclick=\'javascript:return clgeneral_details_ONCLICK22(this,"Validate");\' / hotKeyId="Validate" >&nbsp;');
                write('<input type="button" class="button" name="Back" id="back" value="' + jspResArr.get("FLT000192") + '" onclick=\'javascript:return clgeneral_details_ONCLICK23(this);\' / hotKeyId="Cancel" >&nbsp;')
            } else {
                write('<input type="button" class="button" name="Back" id="back" value="' + jspResArr.get("FLT001166") + '" onClick=\'javascript:return clgeneral_details_ONCLICK24(this);\'  hotKeyId="Go" >')
            }
            writeFooter();
            write("</div>")
        }
    }
}

function fnPopulateControlValues() {
    var a = document.forms[0];
    a.parentCifId.value = parentCifId;
    a.parentCustName.value = parentCustName;
    a.acctName.value = acctName;
    a.acctShortName.value = acctShortName;
    a.acctOpenDate.value = acctOpenDate;
    a.chargeLvlCode.value = chargeLvlCode;
    a.chargeLvlDesc.value = chargeLvlDesc;
    a.locationCode.value = locationCode;
    a.locationDesc.value = locationDesc;
    a.acctManager.value = acctManager;
    a.acctMgrName.value = acctMgrName;
    a.acctRptCode.value = acctRptCode;
    a.remarks.value = remarks;
    a.applicationRefId.value = applicationRefId;
    a.pbPsFlg.value = pbPsFlg;
    a.pbPsFreqType.value = pbPsFreqType;
    a.pbPsFreqWeek.value = pbPsFreqWeek;
    a.pbPsFreqDay.value = pbPsFreqDay;
    a.pbPsFreqStartDD.value = pbPsFreqStartDD;
    a.pbPsFreqHldyStat.value = pbPsFreqHldyStat;
    a.despatchMode.value = despatchMode;
    a.psAtRelPartyFlg.value = psAtRelPartyFlg;
    a.modeOfOperCode.value = modeOfOperCode;
    a.modeOfOperDesc.value = modeOfOperDesc;
    a.nextPrntDate.value = nextPrntDate;
    a.contactPhNum.value = contactPhNum;
    a.natLangCode.value = natLangCode;
    a.natLangDesc.value = natLangDesc;
    a.natLangTitle.value = natLangTitle;
    a.natLangName.value = natLangName;
    a.collectCharges.value = collectCharges;
    a.turoverDtls.value = turoverDtls;
    a.localCalendar.value = localCalendar;
    a.acctMgrAtAcct.value = acctMgrAtAcct;
    a.collectionOfficer.value = collectionOfficer;
    a.acctMgrAtAcctName.value = acctMgrAtAcctName;
    a.collectionOfficerName.value = collectionOfficerName;
    a.prefCalBase.value = prefCalBase;
    a.addtnlCalBase.value = addtnlCalBase;
    a.pbPsFreqCalBase.value = pbPsFreqCalBase;
    if ((sReferralMode == "I") || (sReferralMode == "S")) {
        fnDisableFormDataControls("V", a, 0)
    }
}

function clgeneral_details_ONKEYDOWN1(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = fnKeyDownProcessor(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONKEYUP2(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONKEYUP") == false) {
        return false
    }
    if ((a = fnKeyUpProcessor(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONKEYUP") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONLOAD3(c) {
    var b = "";
    var a = document.forms[0];
    if (pre_ONLOAD("clgeneral_details", c) == false) {
        return false
    }
    if ((b = fnOnLoad()) == false) {
        return false
    }
    fnPopUpExceptionWindow(a.actionCode);
    if (post_ONLOAD("clgeneral_details", c) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function clgeneral_details_ONCLICK4(c, d, b) {
    var a = "";
    if (preEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    if ((a = fnToggleTextDisplay(d, b)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK5(c, d, b) {
    var a = "";
    if (preEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    if ((a = fnToggleTextDisplay(d, b)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE6(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE7(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE8(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE9(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE10(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE11(b) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnChangeStmtFreqBasedOnAcctStmt()) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE12(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK13(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnSetCheckboxFld(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK14(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnSetCheckboxFld(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONBLUR15(c, d, b) {
    var a = "";
    if (preEventCall("clgeneral_details", c, "ONBLUR") == false) {
        return false
    }
    if ((a = fnValidateTextArea(d, b)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", c, "ONBLUR") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONKEYDOWN16(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = suppressEnterKey(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE17(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK18(c, d, b) {
    var a = "";
    if (preEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    if ((a = fnToggleTextDisplay(d, b)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK19(c, d, b) {
    var a = "";
    if (preEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    if ((a = fnToggleTextDisplay(d, b)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", c, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCHANGE20(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK21(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    if ((a = validateGenDetForm(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK22(b, c) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    if ((a = validateGenDetForm(c)) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK23(b) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnBack()) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function clgeneral_details_ONCLICK24(b) {
    var a = "";
    if (preEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnBack()) == false) {
        return false
    }
    if (postEventCall("clgeneral_details", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function writePbPsFlg() {
    with(document) {
        write('<OPTION VALUE="" selected >' + jspResArr.get("FLT012410") + "</option>");
        write('<OPTION VALUE="B">' + jspResArr.get("FLT012018") + "</option>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT013288") + "</option>");
        write('<OPTION VALUE="P">' + jspResArr.get("FLT013344") + "</option>");
        write('<OPTION VALUE="S">' + jspResArr.get("FLT002801") + "</option>")
    }
}

function writeFrequencyType() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="D">' + jspResArr.get("FLT012545") + "</OPTION>");
        write('<OPTION VALUE="F">' + jspResArr.get("FLT012652") + "</OPTION>");
        write('<OPTION VALUE="H">' + jspResArr.get("FLT012691") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012353") + "</OPTION>");
        write('<OPTION VALUE="Q">' + jspResArr.get("FLT012856") + "</OPTION>");
        write('<OPTION VALUE="W">' + jspResArr.get("FLT013183") + "</OPTION>");
        write('<OPTION VALUE="Y">' + jspResArr.get("FLT012404") + "</OPTION>")
    }
}

function writeWeekNumber() {
    with(document) {
        write('<OPTION selected VALUE="">' + jspResArr.get("FLT013174") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011775") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011794") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011812") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011829") + "</OPTION>");
        write('<OPTION VALUE="L">' + jspResArr.get("FLT012233") + "</OPTION>");
        write('<OPTION VALUE="M">' + jspResArr.get("FLT012345") + "</OPTION>")
    }
}

function writeWeekDay() {
    with(document) {
        write('<OPTION selected VALUE="">' + jspResArr.get("FLT012488") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011782") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011798") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011817") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011832") + "</OPTION>");
        write('<OPTION VALUE="5">' + jspResArr.get("FLT011845") + "</OPTION>");
        write('<OPTION VALUE="6">' + jspResArr.get("FLT011858") + "</OPTION>");
        write('<OPTION VALUE="7">' + jspResArr.get("FLT011870") + "</OPTION>")
    }
}

function writeFreDates() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT000205") + "</OPTION>");
        write('<OPTION VALUE="1">' + jspResArr.get("FLT011753") + "</OPTION>");
        write('<OPTION VALUE="2">' + jspResArr.get("FLT011754") + "</OPTION>");
        write('<OPTION VALUE="3">' + jspResArr.get("FLT011756") + "</OPTION>");
        write('<OPTION VALUE="4">' + jspResArr.get("FLT011757") + "</OPTION>");
        write('<OPTION VALUE="5">' + jspResArr.get("FLT011758") + "</OPTION>");
        write('<OPTION VALUE="6">' + jspResArr.get("FLT011759") + "</OPTION>");
        write('<OPTION VALUE="7">' + jspResArr.get("FLT011760") + "</OPTION>");
        write('<OPTION VALUE="8">' + jspResArr.get("FLT011761") + "</OPTION>");
        write('<OPTION VALUE="9">' + jspResArr.get("FLT011762") + "</OPTION>");
        write('<OPTION VALUE="10">' + jspResArr.get("FLT009410") + "</OPTION>");
        write('<OPTION VALUE="11">' + jspResArr.get("FLT009411") + "</OPTION>");
        write('<OPTION VALUE="12">' + jspResArr.get("FLT009412") + "</OPTION>");
        write('<OPTION VALUE="13">' + jspResArr.get("FLT009413") + "</OPTION>");
        write('<OPTION VALUE="14">' + jspResArr.get("FLT009414") + "</OPTION>");
        write('<OPTION VALUE="15">' + jspResArr.get("FLT009415") + "</OPTION>");
        write('<OPTION VALUE="16">' + jspResArr.get("FLT009709") + "</OPTION>");
        write('<OPTION VALUE="17">' + jspResArr.get("FLT009710") + "</OPTION>");
        write('<OPTION VALUE="18">' + jspResArr.get("FLT009711") + "</OPTION>");
        write('<OPTION VALUE="19">' + jspResArr.get("FLT009712") + "</OPTION>");
        write('<OPTION VALUE="20">' + jspResArr.get("FLT004108") + "</OPTION>");
        write('<OPTION VALUE="21">' + jspResArr.get("FLT004114") + "</OPTION>");
        write('<OPTION VALUE="22">' + jspResArr.get("FLT009713") + "</OPTION>");
        write('<OPTION VALUE="23">' + jspResArr.get("FLT009714") + "</OPTION>");
        write('<OPTION VALUE="24">' + jspResArr.get("FLT009715") + "</OPTION>");
        write('<OPTION VALUE="25">' + jspResArr.get("FLT009716") + "</OPTION>");
        write('<OPTION VALUE="26">' + jspResArr.get("FLT009717") + "</OPTION>");
        write('<OPTION VALUE="27">' + jspResArr.get("FLT009718") + "</OPTION>");
        write('<OPTION VALUE="28">' + jspResArr.get("FLT009719") + "</OPTION>");
        write('<OPTION VALUE="29">' + jspResArr.get("FLT009720") + "</OPTION>");
        write('<OPTION VALUE="30">' + jspResArr.get("FLT004115") + "</OPTION>");
        write('<OPTION VALUE="31">' + jspResArr.get("FLT009721") + "</OPTION>")
    }
}

function writeActionHoliday() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012689") + "</OPTION>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT012721") + "</OPTION>");
        write('<OPTION VALUE="P">' + jspResArr.get("FLT012845") + "</OPTION>");
        write('<OPTION VALUE="S">' + jspResArr.get("FLT013007") + "</OPTION>")
    }
}

function writeFrequencyCalendarBase() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="00">' + jspResArr.get("FLT019695") + "</OPTION>");
        write('<OPTION VALUE="01">' + jspResArr.get("FLT019696") + "</OPTION>")
    }
}

function writeprefCalendarBase() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="00">' + jspResArr.get("FLT019695") + "</OPTION>");
        write('<OPTION VALUE="01">' + jspResArr.get("FLT019696") + "</OPTION>");
        write('<OPTION VALUE="02">' + jspResArr.get("FLT020077") + "</OPTION>")
    }
}

function writeDespatchMode() {
    with(document) {
        write('<OPTION selected VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="A">' + jspResArr.get("FLT011966") + "</OPTION>");
        write('<OPTION VALUE="B">' + jspResArr.get("FLT012035") + "</OPTION>");
        write('<OPTION VALUE="C">' + jspResArr.get("FLT013189") + "</OPTION>");
        write('<OPTION VALUE="D">' + jspResArr.get("FLT012544") + "</OPTION>");
        write('<OPTION VALUE="E">' + jspResArr.get("FLT012600") + "</OPTION>");
        write('<OPTION VALUE="N">' + jspResArr.get("FLT012726") + "</OPTION>");
        write('<OPTION VALUE="P">' + jspResArr.get("FLT013332") + "</OPTION>");
        write('<OPTION VALUE="Q">' + jspResArr.get("FLT012855") + "</OPTION>");
        write('<OPTION VALUE="S">' + jspResArr.get("FLT013009") + "</OPTION>")
    }
};
//ebl 359020 start

function showModuleList(){
	var ObjForm = document.forms[0];
	var inputNameValues = "acctMgrAtAcct|"+ObjForm.acctMgrAtAcct.value;
    var outputNameValues = "acctMgrAtAcct|name|solid";
	var scriptName = "b_acctmngrlst.scr";
	var listHeading = "Account Manager";
    var colHeader = "Login id|Name|Branch";
    var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",true)
}




//ebl 359020 end
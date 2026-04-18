function printBlock1() {
    writeHeader("fbmbilldet1");
    with(document) {
        write('<input type="hidden" id="policyDate" fmnd="' + fbmbillProps.get("policyDate_MANDATORY") + '" fdt="fdate" mneb1="N" vFldId="policyDate_ui" name="' + groupName + '.policyDate">');
        write('<input type="hidden" name="' + groupName + '.shpmtTerms" id="shpmtTerms" >');
        write('<input type="hidden" name="pgNum" id="pgNum" value="1" >');
        write('<input type="hidden" name="submitform" id="submitform" >');
        write('<input type="hidden" name="FocusField" id="FocusField" >');
        write('<input type="hidden" name="pagename" id="pagename" value="fbmbilldet1" >');
        write('<input type="hidden" name="validObj" id="validObj" >');
        write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
        write("<tr>");
        write('<td valign="top">	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
        write("<tr>");
        write('<td>	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        write("<tr>");
        write('<td>	<table width="100%" border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        write('<td colspan="5" align="right">	<table border="0" cellspacing="0" cellpadding="0">');
        write("<tr>");
        write('<td align="right">');
        write('<a id="sLnk0" href="javascript:showHelpFile(\'fbmbill_help.htm\');">');
        write('<img src="../Renderer/images/' + applangcode + '/help.gif" width="47" height="21" vspace="1" border="0" hotKeyId="finHelp"></a>');
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="2" class="subhdr">&nbsp;</td>');
        write('<td colspan="3" align="right">	<table border="0" cellpadding="0" cellspacing="0">');
        write("<tr>");
        write('<td align="right">	<img src="../images/' + applangcode + '/arrowgraypre.gif" width="7" height="14" border="0">&nbsp;&nbsp;</td>');
        write("<td>Page&nbsp;&nbsp;1&nbsp;&nbsp;" + jspResArr.get("FLT002052") + "&nbsp;&nbsp;2&nbsp;&nbsp;</td>");
        write("<td>");
        write('<a id="sLnk2">');
        write('<img id="NextPage" type="image" src="../images/' + applangcode + '/arrownext.gif" width="7" height="14" border="0" align="absmiddle" onClick="javascript:return fbmbilldet1_ONCLICK5(this,this);" onMouseOver="displayHand(this)" hotKeyId="Next"></a>');
        write("&nbsp;&nbsp;&nbsp;&nbsp;</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write('<tr class="rowspacing">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="2">	<h2 class="subhdr">');
        write("" + jspResArr.get("FLT003259") + "");
        write('<script>setMandatory("' + fbmbillProps.get("shpmtDtls_MANDATORY") + '");<\/script>	</h2>');
        write("</td>");
        write('<td colspan="3" align="right">&nbsp;</td>');
        write("</tr>");
        write('<tr class="rowspacing">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003255") + "</td>");
        write('<td class="textfielddisplaylabel">	<label id="cmpfld0">');
        write("" + jsUtil.encodeChar(sOnBoardDate) + "	</label>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT003254") + "");
        write('<script>setMandatory("' + fbmbillProps.get("carrierCode_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="carrierCode" name="' + groupName + '.carrierCode" hotKeyId="search1" ' + fbmbillProps.get("carrierCode_ENABLED") + ' type="text" class="textfieldfont" maxlength="8" fmnd="' + fbmbillProps.get("carrierCode_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE6(this,\'carrierCodeDesc\');">');
        write("&nbsp;");
        write("<a id=\"sLnk4\" href=\"javascript:showDynSearcher('CCTID','carrier_code=:carrierCode|del_flg=N',':carrierCode=carrier_code|:carrierCodeDesc=carrier_name')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search1"></a>');
        write("<br>");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="carrierCodeDesc" name="' + groupName + '.carrierCodeDesc" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="DEFBLK" fds="Y">');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT021962") + "");
        write('<script>setMandatory("' + fbmbillProps.get("goodsOrigin_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="goodsOrigin" name="' + groupName + '.goodsOrigin" hotKeyId="search2" ' + fbmbillProps.get("goodsOrigin_ENABLED") + ' type="text" class="textfieldfont" maxlength="5" fmnd="' + fbmbillProps.get("goodsOrigin_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE7(this,\'goodsOriginDesc\');">');
        write("&nbsp;");
        write("<a id=\"sLnk3\" href=\"javascript:showRefCode(document.forms[0].goodsOrigin,'03','N','F',document.forms[0].goodsOriginDesc)\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></a>');
        write("<br>");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="goodsOriginDesc" name="' + groupName + '.goodsOriginDesc" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="DEFBLK" fds="Y">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT046222") + "");
        write('<script>setMandatory("' + fbmbillProps.get("goodsOriginDet_MANDATORY") + '");<\/script></td>');
        write('<td class="textfielddisplaylabel">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="goodsOriginDet" name="' + groupName + '.goodsOriginDet" ' + fbmbillProps.get("goodsOriginDet_ENABLED") + ' type="text" class="textfieldfont" maxlength="25" fmnd="' + fbmbillProps.get("goodsOriginDet_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003257") + "");
        write('<script>setMandatory("' + fbmbillProps.get("goodsDstn_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="goodsDstn" name="' + groupName + '.goodsDstn" hotKeyId="search3" ' + fbmbillProps.get("goodsDstn_ENABLED") + ' type="text" class="textfieldfont" maxlength="5" fmnd="' + fbmbillProps.get("goodsDstn_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE8(this,\'goodsDstnDesc\');">');
        write("&nbsp;");
        write("<a id=\"sLnk5\" href=\"javascript:showRefCode(document.forms[0].goodsDstn,'88','N','F',document.forms[0].goodsDstnDesc)\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search3"></a>');
        write("<br>");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="goodsDstnDesc" name="' + groupName + '.goodsDstnDesc" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="DEFBLK" fds="Y">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT046223") + "");
        write('<script>setMandatory("' + fbmbillProps.get("goodsDstnDet_MANDATORY") + '");<\/script></td>');
        write('<td class="textfielddisplaylabel">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="goodsDstnDet" name="' + groupName + '.goodsDstnDet" ' + fbmbillProps.get("goodsDstnDet_ENABLED") + ' type="text" class="textfieldfont" maxlength="25" fmnd="' + fbmbillProps.get("goodsDstnDet_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT022849") + "");
        write('<script>setMandatory("' + fbmbillProps.get("consigneeCntry_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="consigneeCntry" name="' + groupName + '.consigneeCntry" hotKeyId="search4" ' + fbmbillProps.get("consigneeCntry_ENABLED") + ' type="text" class="textfieldfont" maxlength="5" fmnd="' + fbmbillProps.get("consigneeCntry_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE9(this,\'consigneeCntryDesc\');">');
        write("&nbsp;");
        write("<a id=\"sLnk6\" href=\"javascript:showRefCode(document.forms[0].consigneeCntry,'03','N','F',document.forms[0].consigneeCntryDesc)\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search4"></a>');
        write("<br>");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="consigneeCntryDesc" name="' + groupName + '.consigneeCntryDesc" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="DEFBLK" fds="Y">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT003258") + "");
        write('<script>setMandatory("' + fbmbillProps.get("consigneeDtls_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<textarea id="consigneeDtls" name="' + groupName + '.consigneeDtls" ' + fbmbillProps.get("consigneeDtls_ENABLED") + ' class="textfieldfont" fmnd="' + fbmbillProps.get("consigneeDtls_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onBlur="javascript:return fbmbilldet1_ONBLUR10(this,this,40);" onKeyDown="javascript:return fbmbilldet1_ONKEYDOWN11(this,event);">');
        write("</textarea>");
        write("&nbsp;   <a id=\"sLnk26\" href=\"javascript:fnShowConsigneeArea()\">");
        write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003250") + "");
        write('<script>setMandatory("' + fbmbillProps.get("shpmtTerm_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="shpmtTerm" name="' + groupName + '.shpmtTerm" hotKeyId="search5" ' + fbmbillProps.get("shpmtTerm_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="5" fmnd="' + fbmbillProps.get("shpmtTerm_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE12(this,\'shpmtDesc\');">');
        write("&nbsp;");
        write("<a id=\"sLnk11\" href=\"javascript:showDynSearcher('HSHPMNT','',':shpmtTerm=shpmnt_type|:shpmtDesc=shpmnt_desc|:shpmtTerms=shpmnt_term')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search5"></a>');
        write("<br>");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="shpmtDesc" name="' + groupName + '.shpmtDesc" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="defaultFblk1" fds="Y">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT003259") + "</td>");
        write('<td class="textfield">');
        write('<textarea id="shpmtDtls" name="' + groupName + '.shpmtDtls" ' + fbmbillProps.get("shpmtDtls_ENABLED") + ' class="textfieldfont" fmnd="' + fbmbillProps.get("shpmtDtls_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onBlur="javascript:return fbmbilldet1_ONBLUR13(this,this,120);" onKeyDown="javascript:return fbmbilldet1_ONKEYDOWN14(this,event);">');
        write("</textarea>");
        write("&nbsp;   <a id=\"sLnk16\" href=\"javascript:fnShowShpmtArea()\">");
        write('<img src="../images/' + applangcode + '/misc_popup.gif" width="16" height="16" border="0"></a>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003260") + "");
        write('<script>setMandatory("' + fbmbillProps.get("freightCrncy_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="freightCrncy" name="' + groupName + '.freightCrncy" hotKeyId="search6" ' + fbmbillProps.get("freightCrncy_ENABLED") + ' type="text" class="textfieldcode" size="2" maxlength="3" fmnd="' + fbmbillProps.get("freightCrncy_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE15(this);">');
        write("&nbsp;");
        write("<a id=\"sLnk26\" href=\"javascript:showCurrency(document.forms[0].freightCrncy,'ctrl','F')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search6"></a>');
        write("&nbsp;");
        write('<input id="freightAmt" name="' + groupName + '.freightAmt" ' + fbmbillProps.get("freightAmt_ENABLED") + ' type="text" class="textfieldamount" maxlength="23" fmnd="' + fbmbillProps.get("freightAmt_MANDATORY") + '" fmb="Y" fdt="amount" fblk="DEFBLK" onBlur="javascript:return fbmbilldet1_ONBLUR16(this,\'' + format + "',document.forms[0].freightAmt,'" + freightCrncy + "','N');\" onChange=\"javascript:return fbmbilldet1_ONCHANGE17(this,this);\">");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT003261") + "");
        write('<script>setMandatory("' + fbmbillProps.get("freightConvRateCode_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="freightConvRateCode" name="' + groupName + '.freightConvRateCode" hotKeyId="search7" ' + fbmbillProps.get("freightConvRateCode_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="5" fmnd="' + fbmbillProps.get("freightConvRateCode_MANDATORY") + '" fmb="Y" fdt="refCode" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE18(this);">');
        write("&nbsp;");
        write("<a id=\"sLnk7\" href=\"javascript:showRefCodefreight(document.forms[0].freightConvRateCode,'67','N','F')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search7"></a>');
        write("&nbsp;");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="freightConvRate" name="' + groupName + '.freightConvRate" ' + fbmbillProps.get("freightConvRate_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="8" fmnd="' + fbmbillProps.get("freightConvRate_MANDATORY") + '" fmb="Y" fdt="frate" fblk="DEFBLK">');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT003262") + "");
        write('<script>setMandatory("' + fbmbillProps.get("fobConvRateCode_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="fobConvRateCode" name="' + groupName + '.fobConvRateCode" hotKeyId="search8" ' + fbmbillProps.get("fobConvRateCode_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="5" fmnd="' + fbmbillProps.get("fobConvRateCode_MANDATORY") + '" fmb="Y" fdt="refCode" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE19(this);">');
        write("&nbsp;");
        write("<a id=\"sLnk8\" href=\"javascript:showRefCodefob(document.forms[0].fobConvRateCode,'67','N','F')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search8"></a>');
        write("&nbsp;");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="fobConvRate" name="' + groupName + '.fobConvRate" ' + fbmbillProps.get("fobConvRate_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="8" fmnd="' + fbmbillProps.get("fobConvRate_MANDATORY") + '" fmb="Y" fdt="frate" fblk="DEFBLK">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT046955") + "");
        write('<script>setMandatory("Y");<\/script></td>');
        write('<td class="textfielddisplaylabel">');
        write('<input id="capitalGoodsTrans" name="' + groupName + '.capitalGoodsTrans" ' + fbmbillProps.get("capitalGoodsTrans_ENABLED") + ' type="radio" value="Y" title="' + jspResArr.get("FHP006061") + '" fmnd="Y" fdt="default" fblk="DEFBLK">');
        write("" + jspResArr.get("FLT002964") + "");
        write('<input id="capitalGoodsTrans" name="' + groupName + '.capitalGoodsTrans" ' + fbmbillProps.get("capitalGoodsTrans_ENABLED") + ' type="radio" value="N" checked title="' + jspResArr.get("FHP006062") + '" fmnd="Y" fdt="default" fblk="DEFBLK">');
        write("" + jspResArr.get("FLT002965") + "</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT047743") + "</td>");
        write('<td class="textfielddisplaylabel">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="vesselName" name="' + groupName + '.vesselName" ' + fbmbillProps.get("vesselName_ENABLED") + ' type="text" class="textfieldfont" maxlength="25" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT001384") + "");
        write('<script>setMandatory("' + fbmbillProps.get("shpmtrmks_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<textarea id="shpmtrmks" name="' + groupName + '.shpmtrmks" ' + fbmbillProps.get("shpmtrmks_ENABLED") + ' class="textfieldfont" fmnd="' + fbmbillProps.get("shpmtrmks_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onBlur="javascript:return fbmbilldet1_ONBLUR20(this,this,40);" onKeyDown="javascript:return fbmbilldet1_ONKEYDOWN21(this,event);">');
        write("</textarea>");
        write("</td>");
        write("</tr>");
        write('<tr class="rowspacing">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="2">	<h2 class="subhdr">');
        write("" + jspResArr.get("FLT022069") + "	</h2>");
        write("</td>");
        write('<td colspan="3" align="right">&nbsp;</td>');
        write("</tr>");
        write('<tr class="rowspacing">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT000412") + "");
        write('<script>setMandatory("' + fbmbillProps.get("cmmdtyCode_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="cmmdtyCode" name="' + groupName + '.cmmdtyCode" hotKeyId="search9" ' + fbmbillProps.get("cmmdtyCode_ENABLED") + ' type="text" class="textfieldfont" maxlength="10" fmnd="' + fbmbillProps.get("cmmdtyCode_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE22(this,\'cmmdtyCodeDesc\');">');
        write("&nbsp;");
        write("<a id=\"sLnk9\" href=\"javascript:showDynSearcher('HSRCMDTY','commodity_code=:cmmdtyCode',':cmmdtyCode=commodity_code|:cmmdtyCodeDesc=commodity_desc')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search9"></a>');
        write("<br>");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="cmmdtyCodeDesc" name="' + groupName + '.cmmdtyCodeDesc" type="text" disabled="true" class="label" size="25" maxlength="25" fdt="default" fblk="DEFBLK" fds="Y">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT002771") + "");
        write('<script>setMandatory("' + fbmbillProps.get("cmmdtydesc_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<textarea id="cmmdtydesc" name="' + groupName + '.cmmdtydesc" ' + fbmbillProps.get("cmmdtydesc_ENABLED") + ' class="textfieldfont" fmnd="' + fbmbillProps.get("cmmdtydesc_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK" onBlur="javascript:return fbmbilldet1_ONBLUR23(this,this,50);" onKeyDown="javascript:return fbmbilldet1_ONKEYDOWN24(this,event);">');
        write("</textarea>");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT021930") + "</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="purchaseOrderRef" name="' + groupName + '.purchaseOrderRef" explodeId="explode1" ' + fbmbillProps.get("purchaseOrderRef_ENABLED") + ' type="text" class="textfieldfont" size="25" maxlength="25" fmnd="' + fbmbillProps.get("purchaseOrderRef_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT045407") + "</td>");
        write('<td class="textfielddisplaylabel">');
        write('<a id="sLnk32" href="javascript:fnExplodePurOrdDtls()">');
        write('<img src="../Renderer/images/' + applangcode + '/explode.gif" width="16" height="16" border="0" explodeId="explode1"></a>');
        write("</td>");
        write("</tr>");
        write('<tr class="rowspacing">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write('<tr class="subhdrbg">');
        write('<td colspan="2">	<h2 class="subhdr">');
        write("" + jspResArr.get("FLT006434") + "	</h2>");
        write("</td>");
        write('<td colspan="3" align="right"></td>');
        write("</tr>");
        write('<tr class="rowspacing">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT021966") + "");
        write('<script>setMandatory("' + fbmbillProps.get("insurPcnt_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="insurPcnt" name="' + groupName + '.insurPcnt" ' + fbmbillProps.get("insurPcnt_ENABLED") + ' type="text" class="textfieldfont" maxlength="10" fmnd="' + fbmbillProps.get("insurPcnt_MANDATORY") + '" fmb="Y" fdt="fgpcnt" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE25(this);">');
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT021967") + "");
        write('<script>setMandatory("' + fbmbillProps.get("insurCrncy_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="insurCrncy" name="' + groupName + '.insurCrncy" hotKeyId="search10" ' + fbmbillProps.get("insurCrncy_ENABLED") + ' type="text" class="textfieldcode" size="2" maxlength="3" fmnd="' + fbmbillProps.get("insurCrncy_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("&nbsp;");
        write("<a id=\"sLnk12\" href=\"javascript:showCurrency(document.forms[0].insurCrncy,'ctrl','F')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search10"></a>');
        write("&nbsp;");
        write('<input id="insurAmt" name="' + groupName + '.insurAmt" ' + fbmbillProps.get("insurAmt_ENABLED") + ' type="text" class="textfieldamount" maxlength="23" fmnd="' + fbmbillProps.get("insurAmt_MANDATORY") + '" fmb="Y" fdt="amount" fblk="DEFBLK" onBlur="javascript:return fbmbilldet1_ONBLUR26(this,\'' + format + "',document.forms[0].insurAmt,'" + insurCrncy + "','N');\" onChange=\"javascript:return fbmbilldet1_ONCHANGE27(this,this);\">");
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">Insured By</td>');
        write('<td class="textfield">');
        write('<select onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" id="insuredBy" name="' + groupName + '.insuredBy" ' + fbmbillProps.get("insuredBy_ENABLED") + ' class="listboxfont" fmnd="' + fbmbillProps.get("insuredBy_MANDATORY") + '" fdt="default" fblk="DEFBLK" >');
        writeComboFunction("writeInsuredBy");
        write("</select>");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT021968") + "</td>");
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="policyNo" name="' + groupName + '.policyNo" ' + fbmbillProps.get("policyNo_ENABLED") + ' type="text" class="twotextfieldnoicon" maxlength="30" fmnd="' + fbmbillProps.get("policyNo_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("&nbsp;");
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="policyDate_ui" name="' + groupName + '.policyDate_ui" hotKeyId="calender1" ' + fbmbillProps.get("policyDate_ENABLED") + ' type="text" class="twotextfieldnoicon" maxlength="10" fmnd="' + fbmbillProps.get("policyDate_MANDATORY") + '" mnebl="false" fmb="N" fdt="uidate" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE28(this,this,this);">');
        write('<a id="sLnk13" href="javascript:openDate(document.forms[0].policyDate_ui,BODDate)">');
        write('<img width="24" height="19" src="../images/' + applangcode + '/calender.gif" align="absmiddle" border="0" hotKeyId="calender1"></a>');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT022052") + "");
        write('<script>setMandatory("' + fbmbillProps.get("insurCompany_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="insurCompany" name="' + groupName + '.insurCompany" ' + fbmbillProps.get("insurCompany_ENABLED") + ' type="text" class="textfieldfont" maxlength="5" fmnd="' + fbmbillProps.get("insurCompany_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("&nbsp;</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">' + jspResArr.get("FLT022846") + "");
        write('<script>setMandatory("' + fbmbillProps.get("payableAt_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="payableAt" name="' + groupName + '.payableAt" ' + fbmbillProps.get("payableAt_ENABLED") + ' type="text" class="textfieldfont" maxlength="25" fmnd="' + fbmbillProps.get("payableAt_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("</td>");
        write("</tr>");
        write("<tr>");
        write('<td class="textlabel">' + jspResArr.get("FLT010468") + "");
        write('<script>setMandatory("' + fbmbillProps.get("premiumCrncy_MANDATORY") + '");<\/script></td>');
        write('<td class="textfield">');
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="premiumCrncy" name="' + groupName + '.premiumCrncy" hotKeyId="search11" ' + fbmbillProps.get("premiumCrncy_ENABLED") + ' type="text" class="textfieldcode" size="2" maxlength="3" fmnd="' + fbmbillProps.get("premiumCrncy_MANDATORY") + '" fmb="Y" fdt="default" fblk="DEFBLK">');
        write("&nbsp;");
        write("<a id=\"sLnk14\" href=\"javascript:showCurrency(document.forms[0].premiumCrncy,'ctrl','F')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search11"></a>');
        write("&nbsp;");
        write('<input id="premiumAmt" name="' + groupName + '.premiumAmt" ' + fbmbillProps.get("premiumAmt_ENABLED") + ' type="text" class="textfieldamount" maxlength="23" fmnd="' + fbmbillProps.get("premiumAmt_MANDATORY") + '" fmb="Y" fdt="amount" fblk="DEFBLK" onBlur="javascript:return fbmbilldet1_ONBLUR29(this,\'' + format + "',document.forms[0].premiumAmt,'" + premiumCrncy + "','N');\" onChange=\"javascript:return fbmbilldet1_ONCHANGE30(this,this);\">");
        write("</td>");
        write('<td class="columnwidth">&nbsp;</td>');
        write('<td class="textlabel">Insurance Conversion rate</td>');
        write('<td class="textfield">');
        write('<input onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="insurConvRateCode" name="' + groupName + '.insurConvRateCode" hotKeyId="search12" ' + fbmbillProps.get("insurConvRateCode_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="5" fmnd="' + fbmbillProps.get("insurConvRateCode_MANDATORY") + '" fmb="Y" fdt="refCode" fblk="DEFBLK" onChange="javascript:return fbmbilldet1_ONCHANGE31(this);">');
        write("&nbsp;");
        write("<a id=\"sLnk15\" href=\"javascript:showRefCodeinsur(document.forms[0].insurConvRateCode,'67','N','F')\">");
        write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search12"></a>');
        write("&nbsp;");
        write('<input onChange="javascript:return custom_ONCHANGE(\'fbmbilldet1\',this);" onBlur="javascript:return custom_ONBLUR(\'fbmbilldet1\',this);" id="insurConvRate" name="' + groupName + '.insurConvRate" ' + fbmbillProps.get("insurConvRate_ENABLED") + ' type="text" class="twotextfieldsearchicon" maxlength="8" fmnd="' + fbmbillProps.get("insurConvRate_MANDATORY") + '" fmb="Y" fdt="frate" fblk="DEFBLK">');
        write("</td>");
        write("</tr>");
        write('<tr class="rowspacing">');
        write('<td colspan="5"><spacer type="block" height="1" width="1"></spacer></td>');
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</td>");
        write("</tr>");
        write("</table>");
        write("</div>")
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
            if (funcCode == FbmConst.INQUIRE_MODE) {
                write('<input id="Back" name="Back" type="button" class="button" onClick="javascript:return fbmbilldet1_ONCLICK32(this,this);" value="' + jspResArr.get("FLT001166") + '" hotKeyId="Go">')
            } else {
                write('<input id="Submit" name="Submit" type="button" onClick="javascript:return fbmbilldet1_ONCLICK33(this,this);" value="' + jspResArr.get("FLT000193") + '" class="button" hotKeyId="Submit">');
                write('<input id="Validate" name="Validate" type="button" class="button" onClick="javascript:return fbmbilldet1_ONCLICK34(this,this);" value="' + jspResArr.get("FLT000194") + '" hotKeyId="Validate">');
                write('<input id="Cancel" name="Cancel" type="button" class="button" onClick="javascript:return fbmbilldet1_ONCLICK35(this,this);" value="' + jspResArr.get("FLT001721") + '" hotKeyId="Cancel">')
            }
            writeFooter();
            write("</div>")
        }
    }
}

function fnPopulateControlValues() {
    var a = document.forms[0];
    a.carrierCode.value = carrierCode;
    a.carrierCodeDesc.value = carrierCodeDesc;
    a.goodsOrigin.value = goodsOrigin;
    a.goodsOriginDet.value = goodsOriginDet;
    a.goodsOriginDesc.value = goodsOriginDesc;
    a.goodsDstn.value = goodsDstn;
    a.goodsDstnDet.value = goodsDstnDet;
    a.goodsDstnDesc.value = goodsDstnDesc;
    a.consigneeCntry.value = consigneeCntry;
    a.consigneeCntryDesc.value = consigneeCntryDesc;
    a.consigneeDtls.value = consigneeDtls;
    a.shpmtTerm.value = shpmtTerm;
    a.shpmtDesc.value = shpmtDesc;
    a.shpmtDtls.value = shpmtDtls;
    a.freightCrncy.value = freightCrncy;
    a.freightAmt.value = freightAmt;
    a.freightConvRateCode.value = freightConvRateCode;
    a.freightConvRate.value = freightConvRate;
    a.fobConvRateCode.value = fobConvRateCode;
    a.fobConvRate.value = fobConvRate;
    a.vesselName.value = vesselName;
    a.shpmtrmks.value = shpmtrmks;
    a.cmmdtyCode.value = cmmdtyCode;
    a.cmmdtyCodeDesc.value = cmmdtyCodeDesc;
    a.cmmdtydesc.value = cmmdtydesc;
    a.purchaseOrderRef.value = purchaseOrderRef;
    a.insurPcnt.value = insurPcnt;
    a.insurCrncy.value = insurCrncy;
    a.insurAmt.value = insurAmt;
    a.insuredBy.value = insuredBy;
    a.policyNo.value = policyNo;
    a.policyDate.value = policyDate;
    a.insurCompany.value = insurCompany;
    a.payableAt.value = payableAt;
    a.premiumCrncy.value = premiumCrncy;
    a.premiumAmt.value = premiumAmt;
    a.insurConvRateCode.value = insurConvRateCode;
    a.insurConvRate.value = insurConvRate;
    a.capitalGoodsTrans.value = capitalGoodsTrans;
    if ((sReferralMode == "I") || (sReferralMode == "S")) {
        fnDisableFormDataControls("V", a, 0)
    }
}

function fbmbilldet1_ONKEYDOWN1(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = fnKeyDownProcessor(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONKEYUP2(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONKEYUP") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONKEYUP") == false) {
        return false
    }
    if ((a = fnKeyUpProcessor(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONKEYUP") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONKEYUP") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONLOAD3(c) {
    var b = "";
    var a = document.forms[0];
    if (pre_ONLOAD("fbmbilldet1", c) == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", c, "ONLOAD") == false) {
        return false
    }
    if ((b = fnOnLoad()) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", c, "ONLOAD") == false) {
        return false
    }
    fnPopUpExceptionWindow(a.actionCode);
    if (post_ONLOAD("fbmbilldet1", c) == false) {
        return false
    }
    return (b == undefined) ? true : b
}

function fbmbilldet1_ONSUBMIT4(b) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONSUBMIT") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONSUBMIT") == false) {
        return false
    }
    if ((a = false)) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONSUBMIT") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONSUBMIT") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCLICK5(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE6(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE7(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE8(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE9(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONBLUR10(c, d, b) {
    var a = "";
    if (preEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if ((a = fnValidateTextArea(d, b)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONKEYDOWN11(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = suppressEnterKey(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE12(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONBLUR13(c, d, b) {
    var a = "";
    if (preEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if ((a = fnValidateTextArea(d, b)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONKEYDOWN14(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = suppressEnterKey(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE15(b) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnValidateFrieghtCrncy()) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONBLUR16(e, f, d, b, a) {
    var c = "";
    if (preEventCall("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if ((c = newformatAmt(f, d, b, a)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    return (c == undefined) ? true : c
}

function fbmbilldet1_ONCHANGE17(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnCheckNegativeAmt(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE18(b) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnChangefreightRateCode()) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE19(b) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnChangefobRateCode()) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONBLUR20(c, d, b) {
    var a = "";
    if (preEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if ((a = fnValidateTextArea(d, b)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONKEYDOWN21(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = suppressEnterKey(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE22(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = clearDescField(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONBLUR23(c, d, b) {
    var a = "";
    if (preEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if ((a = fnValidateTextArea(d, b)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", c, "ONBLUR") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONKEYDOWN24(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if ((a = suppressEnterKey(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONKEYDOWN") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE25(b) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = onChangeInsAmt()) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONBLUR26(e, f, d, b, a) {
    var c = "";
    if (preEventCall("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if ((c = newformatAmt(f, d, b, a)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    return (c == undefined) ? true : c
}

function fbmbilldet1_ONCHANGE27(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnCheckNegativeAmt(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE28(c, d, b) {
    var a = "";
    if (preEventCall("fbmbilldet1", c, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", c, "ONCHANGE") == false) {
        return false
    }
    if ((a = onBlurFormatDate(d)) == false) {
        return false
    }
    if ((a = fnAssignDateOnEnter(b)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", c, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", c, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONBLUR29(e, f, d, b, a) {
    var c = "";
    if (preEventCall("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if ((c = newformatAmt(f, d, b, a)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", e, "ONBLUR") == false) {
        return false
    }
    return (c == undefined) ? true : c
}

function fbmbilldet1_ONCHANGE30(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnCheckNegativeAmt(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCHANGE31(b) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if ((a = fnChangeinsurRateCode()) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCHANGE") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCLICK32(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCLICK33(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCLICK34(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function fbmbilldet1_ONCLICK35(b, c) {
    var a = "";
    if (preEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (preEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if ((a = fnOnButtonClick(c)) == false) {
        return false
    }
    if (postEventCallForLocale("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    if (postEventCall("fbmbilldet1", b, "ONCLICK") == false) {
        return false
    }
    return (a == undefined) ? true : a
}

function writeInsuredBy() {
    with(document) {
        write('<OPTION VALUE="">' + jspResArr.get("FLT012410") + "</OPTION>");
        write('<OPTION VALUE="A">' + jspResArr.get("FLT016993") + "</OPTION>");
        write('<OPTION VALUE="B">' + jspResArr.get("FLT016994") + "</OPTION>");
        write('<OPTION VALUE="O">' + jspResArr.get("FLT013305") + "</OPTION>")
    }
};
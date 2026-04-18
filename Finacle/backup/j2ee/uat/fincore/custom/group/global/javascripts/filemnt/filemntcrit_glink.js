function printBlock1() {
	writeHeader("filemntcrit");
	with(document) {
		write('<input type="hidden" name="submitform" value="">');
		write('<input type="hidden" id="dFuncCode" name="' + groupName + '.funcCode" value="">');
		write('<input type="hidden" name="pagename" value="filemntcrit">');
		write('<input type=hidden name="calledMenu" id="calledMenu">');
		write('<table class="ctable" border="0" cellspacing="0" cellpadding="0">');
		write("<tr>");
		if (menuType == INQUIRY) {
			title = menuTitle;
			write('<td class="page-heading">' + jsUtil.encodeChar(menuTitle) + "&nbsp;</td>")
		} else {
			title = getLiteralName(displayProperties.getScreenTitle());
			write('<td class="page-heading">' + jsUtil.encodeChar(getLiteralName(displayProperties.getScreenTitle())) + "&nbsp;</td>")
		}
		write("</tr>");
		write("</table>")
	}
}

function printBlock2() {
	with(document) {
		write('<table class="ctable" border="0" cellpadding="0" cellspacing="0" >');
		write("<tr>");
		write("<td>");
		write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
		write("<tr>");
		write('<td valign="top">');
		write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
		write("<tr>");
		write("<td>");
		write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
		write("<tr>");
		write("<td>");
		write('<table width="100%" border="0" cellspacing="0" cellpadding="0" class="innertabletop1">');
		write("<tr>");
		write('<td align="right">');
		write('<table border="0" cellspacing="0" cellpadding="0">');
		write("<tr>");
		write("<td> </td>");
		write('<td align="right">');
		write('<a id="sLnk2" href="javascript:showHelpFile(\'' + screenName + "_help.htm');\">");
		write('<img class="img" src="../Renderer/images/' + applangcode + '/help.gif" border="0" alt="' + jspResArr.get("FHP000723") + '" hotKeyId="finHelp">');
		write("</img>");
		write("</a>");
		write("</td>");
		write("</tr>");
		write("</table>");
		write("</td>");
		write("</tr>");
		write("<tr>");
		write('<table width="100%" class="innertabletop1" cellspacing="0" cellpadding="0">');
		write("<tr>");

		var row = arrCriteria[0].getDisplayRow();
		var isJoin = "N";
		var fldCount = arrCriteria.length;
		var sepCount = 0;
		var colArray = displayProperties.getColumnPattern().split(",");
		if (arrSeparatorRow != null) {
			sepCount = arrSeparatorRow.length
		}
		for (var i = 0; i < colArray.length; i++) {
			write('<td width="' + colArray[i] + '%"></td>')
		}
		write("</tr><tr>");
		if (row != 1) {
			separatorControl(arrSeparatorRow, 0, row)
		}
		for (var j = 0; j < fldCount; j++) {
			var nxtRow = arrCriteria[j].getDisplayRow();
			if (nxtRow != row) {
				write("</tr><tr>");
				separatorControl(arrSeparatorRow, row, nxtRow);
				row = nxtRow
			}
			if ("funcCode" == arrCriteria[j].getFieldName()) {
				arrCriteria[j].setIsGrpNameReqd("Y")
			}
			if ((arrCriteria[j].getIsCopyFld() == "Y" && fnCode == "C") || arrCriteria[j].getIsCopyFld() != "Y") {
				printControl(arrCriteria[j], isJoin);
				isJoin = arrCriteria[j].getDisplayIsJoin()
			}
		}
		if (sepCount > 0) {
			nxtRow = parseInt(arrSeparatorRow[sepCount - 1].getSeparatorRow())
		}
		if (row < nxtRow) {
			write("</tr><tr>");
			separatorControl(arrSeparatorRow, row, nxtRow + 1)
		}
		write("</tr>");
		write("</table>");
		write("</tr>");
		write("</td>");
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
		write("</table>")
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
			write('<input type="button" class="button" id="Accept" name="GO" value="' + jspResArr.get("FLT004977") + '" onClick="javascript:return filemntcrit_ONCLICK6(this,this);" hotKeyId="Go">');
			// Verification button
			// write('<input type="button" class="button" id="Verify" name="Verify" value="' + jspResArr.get("FLT001578") + '" onClick="javascript:return filemntcrit_ONCLICK6(this,this);" hotKeyId="Verify">');
			if (bEnableVal) {
				write('<input type="button" class="button" id="Validate" name="Validate" value="' + jspResArr.get("FLT000194") + '" onClick="javascript:return filemntcrit_ONCLICK7(this,this);" hotKeyId="Validate">')
			}
			if (fnCode != "C") {
				if (!isCalledMenu) {
					write('<input type="button" class="button" id="Clear" name="Clear" value="' + jspResArr.get("FLT001439") + '" onClick="javascript:return filemntcrit_ONCLICK8(this,this);">')
				} else {
					if (eval(isCalledMenu) != undefined && isCalledMenu) {
						write('<input type="button" class="button" id="BackToParent" name="Cancel" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return filemntcrit_ONCLICK9(this,this);" hotKeyId="Cancel">')
					}
				}
			}
			if (fnCode == "C") {
				write('<input type="button" class="button" id="Cancel" name="Cancel" value="' + jspResArr.get("FLT000192") + '" onClick="javascript:return filemntcrit_ONCLICK10(this,this);" hotKeyId="Cancel">')
			}
			writeFooter();
			write("</div>")
		}
	}
}

function filemntcrit_ONKEYDOWN1(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONKEYDOWN") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONKEYDOWN") == false) {
		return false
	}
	if ((a = body_ONKEYDOWN(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONKEYDOWN") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONKEYDOWN") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONKEYPRESS2(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONKEYPRESS") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONKEYPRESS") == false) {
		return false
	}
	if ((a = body_ONKEYPRESS(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONKEYPRESS") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONKEYPRESS") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONKEYUP3(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONKEYUP") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONKEYUP") == false) {
		return false
	}
	if ((a = body_ONKEYUP(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONKEYUP") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONKEYUP") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONLOAD4(c) {
	var b = "";
	var a = document.forms[0];
	if (pre_ONLOAD("filemntcrit", c) == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", c, "ONLOAD") == false) {
		return false
	}
	if ((b = body_ONLOAD()) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", c, "ONLOAD") == false) {
		return false
	}
	fnPopUpExceptionWindow(a.actionCode);
	if (post_ONLOAD("filemntcrit", c) == false) {
		return false
	}
	return (b == undefined) ? true : b
}

function filemntcrit_ONSUBMIT5(b) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONSUBMIT") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONSUBMIT") == false) {
		return false
	}
	if ((a = false)) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONSUBMIT") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONSUBMIT") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONCLICK6(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if ((a = form_ONCLICK(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONCLICK7(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if ((a = form_ONCLICK(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONCLICK8(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if ((a = form_ONCLICK(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONCLICK9(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if ((a = form_ONCLICK(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	return (a == undefined) ? true : a
}

function filemntcrit_ONCLICK10(b, c) {
	var a = "";
	if (preEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (preEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if ((a = form_ONCLICK(c)) == false) {
		return false
	}
	if (postEventCallForLocale("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	if (postEventCall("filemntcrit", b, "ONCLICK") == false) {
		return false
	}
	return (a == undefined) ? true : a
};
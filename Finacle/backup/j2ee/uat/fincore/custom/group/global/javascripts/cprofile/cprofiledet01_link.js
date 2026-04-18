<!--	This gets executed on click of Go/Submit/Validate button -->
function fnValidateData() {
	var ObjForm = document.forms[0];
	if (!fnCheckMandatoryFields())
	{
		return false;
	}
    if (!validateTypes(ObjForm)) return false;
    if(!fnCustomValidateForm()) return false;
	return true;
}

function cprofiledet01_addCustomDetRow1(arrObj){
	
	var iRecNum = arrObj[0]; // Record Number
	var bIsCurrRec = arrObj[1]; //
	var locStyle = "";
	
	if( bIsCurrRec == 'Y')
	{
	locStyle = 'class="searclist1arow"';
	}
	else
	{
		if(iRecNum % 2 == 0)
		{
			locStyle = 'class="searclist1a"';
		}
		else
		{
			locStyle = 'class="searclist2a"';
		}
	}
	with(document)
	{
		write('<tr ' + locStyle + 'class="ctext">');

		write('<td class="leftscroll">&nbsp;</td>');
		write('</tr>');
	}
}

function viewEditAddnlDetails(){
    var ObjForm = document.forms[0];
    var recordNumber = document.getElementById("cprofile.cprofiledet01custMRH1serialNo").value;
    var sUrl = "../custom/cprofile/cprofiledet01Explode.jsp?menuId=HCUTOFF&appLangCode="+appLangCode+ "&subGroupName="+subGroupName+ "&calbase="+calbase+ "&rtId=" +rtId+"&funcCode="+funcCode+"&recordNumber="+recordNumber;
    var retVal = window.showModalDialog(sUrl,"Additional Details","dialogWidth:65;dialogHeight:35;status=no;toolbar=no;menubar=no;resizable=yes");
    if(retVal != undefined){
        document.getElementById("chTabDtl").value = retVal;
        doSubmit("Validate");
    }
}

function fnValidateForm(obj){
	objForm = document.forms[0];
	if((obj == window[sMultiRecName1].addNewAction)||(obj == window[sMultiRecName1].selectAction)||(obj == window[sMultiRecName1].nextAction)||(obj == window[sMultiRecName1].prevAction))
	{
		if (!fnValidateData())
		{
			return false;
		}
	}		
    if(!fnCustomValidateForm()) return false;
	return true;
}




/*
function cprofiledet01_post_ONLOAD(obj){
	var ObjForm = document.forms[0];


	 Confirmation Pop Up Display Start
	if(fnIsNull(ObjForm.cmmSubmitCallMode.value)){
		ObjForm.cmmSubmitCallMode.value = "E";
	}
	if(ObjForm.cmmSubmitCallMode.value == "E"){
		if(!fnIsNull(cmmErrorDetails)){
			var errorLL = cmmErrorDetails.split("~");	
			var confMsgExists = "N";
			if(errorLL != undefined){
				for(var m=0; m < errorLL.length; m++){
					var errorDetails = errorLL[m].split("#");
					if(errorDetails != undefined){
						var errorType = errorDetails[0];
						var errorMsg = errorDetails[1];
						if(errorType == "C"){
							confMsgExists = "Y";
							break;
						}
					}			
				}
			}
			if(confMsgExists == "Y"){
				ObjForm.Submit.disabled = true;
				var sUrl = "../custom/jsp/displayCmmErrorDetails.jsp?&appLangCode="+appLangCode+ "&subGroupName="+subGroupName+ "&calbase="+calbase+ "&rtId=" +rtId+"&funcCode="+funcCode;
				var retVal = window.showModalDialog(sUrl,"Preview","dialogWidth:35;dialogHeight:15;status=no;toolbar=no;menubar=no;resizable=yes");
				if(retVal != undefined){
					if(retVal == "Accept"){
						ObjForm.cmmSubmitCallMode.value = "N";
						ObjForm.Submit.disabled = false;
						ObjForm.Submit.click();
					}else{
						ObjForm.Submit.disabled = false;
					}
				}else{
					ObjForm.Submit.disabled = false;
				}
			}
		}
	}else{
		ObjForm.cmmSubmitCallMode.value = "E";
	}
	 Confirmation Pop Up Display End

    return true;
}
*/
function fnCustomValidateForm(){
	var ObjForm = document.forms[0];

    return true;
}

function fnFrontEndEvents_ONBLUR(obj){
	var ObjForm = document.forms[0];


    return true;
}

function fnFrontEndEvents_ONCHANGE(obj){
	var ObjForm = document.forms[0];


    return true;
}

function fnFrontEndEvents_ONCLICK(obj){
	var ObjForm = document.forms[0];


    return true;
}
















function showDetailsPageForDynCritSearcher(c, d, b, a, e) {
	showSearcher(c, d, b, a, e, "SUBMIT", "DTLSPG")
}

function showDynCritSearcher(c, d, b, a, e) {
	showSearcher(c, d, b, a, e, "INIT", "CRITERIA")
}

function showDynSearcher(c, d, b, a, e) {
	showSearcher(c, d, b, a, e, "SUBMIT", "DETAILS")
}

function showSearcher(d, e, c, a, g, b, f) {
	callBackSearchInd = "1";
	opFieldsArr = [];
	opFieldsArr[0] = c;
	var h = getSearcherData(d, e, a, g, b, f, c);
	if (window.showModalDialog) {
		parseDynSearcherRtnData(c, h)
	}
}

function showDynSearcherWithRetValue(c, d, b, a, e) {
	callBackSearchInd = "2";
	opFieldsArr = [];
	opFieldsArr[0] = b;
	var f = getSearcherData(c, d, a, e, "SUBMIT", "DETAILS");
	if (window.showModalDialog) {
		parseDynSearcherRtnData(b, f);
		if (isEmptyObjValue(f)) {
			return false
		} else {
			return true
		}
	}
}

function getSearcherData(h, r, g, s, q, e, f, k, p, b) {
	var d = "";
	var l = "";
	var a = "";
	var c = h;
	if (undefined == k || null == k || fnTrim(k).length == 0) {
		k = 0
	}
	if (undefined == p || null == p || fnTrim(p).length == 0) {
		p = 0
	}
	if (undefined == b || null == b || fnTrim(b).length == 0) {
		b = "S"
	}
	if (undefined == g || null == g) {
		g = 54
	}
	if (undefined == s || null == s) {
		s = 27.25
	}
	if (undefined == h || null == h || fnTrim(h).length == 0) {
		return false
	}
	d = "../inquiry/inquiry_ctrl.jsp?sid=" + h + "&actionCode=" + q + "&displayMode=" + e + "&outputFields=" + f + "&";
	l = formDynSearcherURL(r, h);
	d += l;
	var o = getBaseUrl();
	if (o.indexOf("prodLocalize") != -1) {
		var n = o + finContextPath + "/locale/" + localeCode.toLowerCase() + "/" + CURR_GROUP_NAME + "/" + CURR_GROUP_NAME + "_ctrl.jsp";
		d = "../../" + d
	} else {
		var n = o + finContextPath + "/" + CURR_GROUP_NAME + "/" + CURR_GROUP_NAME + "_ctrl.jsp"
	}
	if (localeCode != "DF" && localeCode != "") {
		var m = h.split("_")[0];
		if (m == localeCode) {
			c = h + "&PLOC=Y"
		}
	}
	a = "?actionCode=SEARCHER&displayMode=" + e + "&dynURL=" + escape(d) + "&sid=" + c + "&mRowsSel=" + k + "&mDataLen=" + p + "&sType=" + b;
	url = n + a;
	if (window.showModalDialog) {
		retVal = popModalWindowVar(url, h, g, s, g, s);
		sendDataForRewind(o + finContextPath + "/inquiry/inquiry_ctrl.jsp?actionCode=CLOSE")
	} else {
		retVal = popModalWindow(url, h)
	}
	return retVal
}

function formDynSearcherURL(k, e) {
	if (undefined == k || null == k || fnTrim(k).length == 0 || "" == k) {
		return ""
	}
	var d = k.split("|");
	var n = null;
	var c = null;
	var l = null;
	var o = -1;
	var h = "";
	var q = false;
	var p = "";
	var b = null;
	var a = null;
	var m = null;
	if (!isEmptyObjValue(e)) {
		a = e.toLowerCase()
	}
	for (var g = 0; g < d.length; g++) {
		m = "";
		p = "";
		l = d[g];
		if (l.indexOf(":") != -1) {
			n = l.split("=");
			for (var f = 0; f < n.length; f++) {
				c = n[f];
				if ((o = c.indexOf(":")) != -1) {
					b = c.substring(o + 1, c.length);
					p += getObjValueInCase(b)
				} else {
					if (!isEmptyObjValue(a)) {
						m += a + "."
					}
					m += n[f];
					p += m
				}
				if (f != (n.length - 1)) {
					p += "="
				}
			}
		} else {
			if (!isEmptyObjValue(a)) {
				m += a + "."
			}
			m += l;
			p += m
		}
		if (q == true) {
			p = "&" + p
		}
		h += p;
		q = true
	}
	return h
}

function parseDynSearcherRtnData(outputFields, rtnData) {
	if (isEmptyObjValue(outputFields) || isEmptyObjValue(rtnData)) {
		return
	}
	var opFlds = outputFields.split("|");
	var rtnFlds = rtnData.split("|");
	var opFld = null;
	var rtnFld = null;
	var opFldInd = -1;
	var retFldInd = -1;
	var objFld = null;
	var fldName = null;
	for (var i = 0; i < opFlds.length; i++) {
		sptStr = "";
		opFld = opFlds[i].split("=");
		for (var j = 0; j < rtnFlds.length; j++) {
			rtnFld = rtnFlds[j].split("=");
			if (rtnFld.length > 2) {
				retFldInd = rtnFlds[j].indexOf("=");
				if (retFldInd != -1) {
					rtnFld = new Array(2);
					rtnFld[0] = rtnFlds[j].substring(0, retFldInd);
					rtnFld[1] = rtnFlds[j].substring(retFldInd + 1)
				}
			}
			opFldInd = opFld[0].indexOf(":");
			if (rtnFld.length == 2 && opFld.length == 2 && rtnFld[0] == opFld[1] && opFldInd != -1) {
				fldName = opFld[0].substring(opFldInd + 1);
				if (fldName.indexOf("document.forms[0].") == -1) {
					objFld = eval("document.forms[0]." + fldName)
				} else {
					objFld = eval(fldName)
				}
				if (objFld != undefined && objFld != null) {
					setFieldValue(fldName, rtnFld[1], "Y")
				} else {
					alert(fldName + finbranchResArr.get("FAT000874"));
					break
				}
				retFldInd = -1;
				opFldInd = -1;
				break
			}
		}
	}
}

function showDynSearcherWithChkBox(d, f, c, b, e, a, g) {
	showSearcherWithChkBox(d, f, c, a, g, "SUBMIT", "DETAILS", b, e)
}

function showDynCritSearcherWithChkBox(d, f, c, b, e, a, g) {
	showSearcherWithChkBox(d, f, c, a, g, "INIT", "CRITERIA", b, e)
}

function showSearcherWithChkBox(e, k, c, d, l, h, b, f, g) {
	callBackSearchInd = "3";
	opFieldsArr = [];
	opFieldsArr[0] = c;
	var a = getSearcherData(e, k, d, l, h, b, c, f, g, "M");
	if (window.showModalDialog) {
		parseDynSearcherRtnDataWithChkBox(c, a)
	}
}

function parseDynSearcherRtnDataWithChkBox(outputFields, rtnData) {
	if (isEmptyObjValue(outputFields) || isEmptyObjValue(rtnData)) {
		return
	}
	var opFlds = outputFields.split("|");
	var rtnFlds = rtnData;
	var opFld = null;
	var rtnFld = null;
	var opFldInd = -1;
	var objFld = null;
	for (i = 0; i < opFlds.length; i++) {
		sptStr = "";
		opFld = opFlds[i].split("=");
		opFldInd = opFld[0].indexOf(":");
		if (opFld[0].indexOf("document.forms[0].") == -1) {
			objFld = eval("document.forms[0]." + opFld[0].substring(opFldInd + 1))
		} else {
			objFld = eval(opFld[0].substring(opFldInd + 1))
		}
		objFld.value = rtnFlds
	}
}

function showDynSearcherForApnd(g, l, c, k, n, a, f, m) {
	callBackSearchInd = "4";
	opFieldsArr = [];
	opFieldsArr[0] = c;
	opFieldsArr[1] = k;
	opFieldsArr[2] = n;
	opFieldsArr[3] = a;
	var d = getSearcherData(g, l, f, m, "SUBMIT", "DETAILS");
	if (window.showModalDialog) {
		if (isEmptyObjValue(d)) {
			return
		}
		var e = d.split("|");
		if (e.length == 0) {
			return
		}
		var b = new Array(e.length);
		var h = null;
		for (i = 0; i < e.length; i++) {
			h = e[i].split("=");
			if (h.length == 2) {
				b[h[0]] = h[1]
			}
		}
		d = parseDynSearcherRtnDataForApnd(c, b, n, a, true);
		if (d != false) {
			parseDynSearcherRtnDataForApnd(k, b, n, a, false)
		}
	}
}

function parseDynSearcherRtnDataForApnd(outputFields, kvRtnData, fldSep, dupAlwd, isApndReq) {
	if (isEmptyObjValue(outputFields)) {
		return
	}
	var opFlds = null;
	var opFld = null;
	var opFldInd = -1;
	var objFld = null;
	var SEPARATOR = " ";
	if (!isEmptyObjValue(fldSep)) {
		SEPARATOR = fldSep
	}
	if (isEmptyObjValue(dupAlwd)) {
		dupAlwd = "Y"
	}
	opFlds = outputFields.split("|");
	for (i = 0; i < opFlds.length; i++) {
		opFld = opFlds[i].split("=");
		opFldInd = opFld[0].indexOf(":");
		if (opFld.length == 2 && opFldInd != -1 && (!isEmptyObjValue(kvRtnData[opFld[1]]))) {
			if (opFld[0].indexOf("document.forms[0].") == -1) {
				objFld = eval("document.forms[0]." + opFld[0].substring(opFldInd + 1))
			} else {
				objFld = eval(opFld[0].substring(opFldInd + 1))
			}
			if (undefined != objFld && null != objFld) {
				if (isEmptyObjValue(objFld.value) || isApndReq != true) {
					objFld.value = kvRtnData[opFld[1]]
				} else {
					if (dupAlwd == "Y" || i != 0) {
						objFld.value = fnTrim(objFld.value + SEPARATOR + kvRtnData[opFld[1]])
					} else {
						var apFldVals = (objFld.value).split(SEPARATOR);
						for (j = 0; j < apFldVals.length; j++) {
							if (kvRtnData[opFld[1]] == apFldVals[j]) {
								alert(finbranchResArr.get("FAT000373"));
								return false
							}
						}
						objFld.value = fnTrim(objFld.value + SEPARATOR + kvRtnData[opFld[1]])
					}
				}
			} else {
				alert((opFld[0].substring(opFldInd + 1)) + " : " + finbranchResArr.get("FAT000874"));
				break
			}
		}
	}
	return
}

function showDynSearcherForCommaApnd(g, l, c, k, a, f, m) {
	callBackSearchInd = "5";
	opFieldsArr = [];
	opFieldsArr[0] = c;
	opFieldsArr[1] = k;
	opFieldsArr[2] = a;
	var d = getSearcherData(g, l, f, m, "SUBMIT", "DETAILS");
	if (window.showModalDialog) {
		if (isEmptyObjValue(d)) {
			return
		}
		var e = d.split("|");
		if (e.length == 0) {
			return
		}
		var b = new Array(e.length);
		var h = null;
		for (i = 0; i < e.length; i++) {
			h = e[i].split("=");
			if (h.length == 2) {
				b[h[0]] = h[1]
			}
		}
		d = parseDynSearcherRtnDataForCommaApnd(c, b, a, true);
		if (d != false) {
			parseDynSearcherRtnDataForCommaApnd(k, b, a, false)
		}
	}
}

function parseDynSearcherRtnDataForCommaApnd(outputFields, kvRtnData, dupAlwd, isApndReq) {
	if (isEmptyObjValue(outputFields)) {
		return
	}
	var opFlds = null;
	var opFld = null;
	var opFldInd = -1;
	var objFld = null;
	var SEPARATOR = ",";
	if (isEmptyObjValue(dupAlwd)) {
		dupAlwd = "Y"
	}
	opFlds = outputFields.split("|");
	for (i = 0; i < opFlds.length; i++) {
		opFld = opFlds[i].split("=");
		opFldInd = opFld[0].indexOf(":");
		if (opFld.length == 2 && opFldInd != -1 && (!isEmptyObjValue(kvRtnData[opFld[1]]))) {
			if (opFld[0].indexOf("document.forms[0].") == -1) {
				objFld = eval("document.forms[0]." + opFld[0].substring(opFldInd + 1))
			} else {
				objFld = eval(opFld[0].substring(opFldInd + 1))
			}
			if (undefined != objFld && null != objFld) {
				if (isEmptyObjValue(objFld.value) || isApndReq != true) {
					objFld.value = kvRtnData[opFld[1]]
				} else {
					if (dupAlwd == "Y" || i != 0) {
						objFld.value = fnTrim(objFld.value + SEPARATOR + kvRtnData[opFld[1]])
					} else {
						var apFldVals = (objFld.value).split(SEPARATOR);
						for (j = 0; j < apFldVals.length; j++) {
							if (kvRtnData[opFld[1]] == apFldVals[j]) {
								alert(finbranchResArr.get("FAT000373"));
								return false
							}
						}
						objFld.value = fnTrim(objFld.value + SEPARATOR + kvRtnData[opFld[1]])
					}
				}
			} else {
				alert((opFld[0].substring(opFldInd + 1)) + " : " + finbranchResArr.get("FAT000874"));
				break
			}
		}
	}
	return
}

function popModalWindowRES(rValue) {
	var bUrl = getBaseUrl();
	var rstatus;
	sendDataForRewind(bUrl + finContextPath + "/inquiry/inquiry_ctrl.jsp?actionCode=CLOSE");
	if (callBackSearchInd == "1") {
		parseDynSearcherRtnData(opFieldsArr[0], rValue)
	} else {
		if (callBackSearchInd == "2") {
			parseDynSearcherRtnData(opFieldsArr[0], rValue);
			if (isEmptyObjValue(rValue)) {
				rstatus = 1
			} else {
				rstatus = 0
			}
			if (callBackFn) {
				eval(callBackFn + "('" + rstatus + "')");
				callBackFn = ""
			}
		} else {
			if (callBackSearchInd == "3") {
				parseDynSearcherRtnDataWithChkBox(opFieldsArr[0], rValue)
			} else {
				if (callBackSearchInd == "4") {
					showDynSearcherForApndForNonIE(rValue)
				} else {
					if (callBackSearchInd == "5") {
						showDynSearcherForCommaApndForNonIE(rValue)
					}
				}
			}
		}
	}
	callBackSearchInd = ""
}

function showDynSearcherForCommaApndForNonIE(a) {
	if (isEmptyObjValue(a)) {
		return
	}
	var c = a.split("|");
	if (c.length == 0) {
		return
	}
	var d = new Array(c.length);
	var b = null;
	for (i = 0; i < c.length; i++) {
		b = c[i].split("=");
		if (b.length == 2) {
			d[b[0]] = b[1]
		}
	}
	var e = parseDynSearcherRtnDataForCommaApnd(opFieldsArr[0], d, opFieldsArr[2], true);
	if (e != false) {
		parseDynSearcherRtnDataForCommaApnd(opFieldsArr[1], d, opFieldsArr[2], false)
	}
}

function showDynSearcherForApndForNonIE(a) {
	if (isEmptyObjValue(a)) {
		return
	}
	var c = a.split("|");
	if (c.length == 0) {
		return
	}
	var d = new Array(c.length);
	var b = null;
	for (i = 0; i < c.length; i++) {
		b = c[i].split("=");
		if (b.length == 2) {
			d[b[0]] = b[1]
		}
	}
	var e = parseDynSearcherRtnDataForApnd(opFieldsArr[0], d, opFieldsArr[2], opFieldsArr[3], true);
	if (e != false) {
		parseDynSearcherRtnDataForApnd(opFieldsArr[1], d, opFieldsArr[2], opFieldsArr[3], false)
	}
};


function showCustomerRiskProfile() {
	alert("hello")
	var ObjForm = document.forms[0];
	var acctname=ObjForm.acctname.value;
	
    	var inputNameValues = "acctname| "+acctname +"|funCode|" +funCode;
	if(funCode == "M"){
   	 var outputNameValues = "acctname|funCode";
	}
	else{
	var outputNameValues = "acctname";
	}
	
    var scriptName = "cprofile_frontEndValidation.scr";

    var RetVal = fnExecuteScript(inputNameValues, outputNameValues, scriptName, listHeading, colHeader, "1", true);
var ObjForm = document.forms[0];

if (CUST.HCUTOFF.recordCount <= 0){
		alert("Please Enter Valid Time Zone")
	} 
}

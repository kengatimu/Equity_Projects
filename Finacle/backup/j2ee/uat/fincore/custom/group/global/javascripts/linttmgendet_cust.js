function linttmgendet_post_ONLOAD() {
	getFieldsFromCustomData("acctNum");
	var csdata = document.forms[0].customData.value;
	var csdataTemp = csdata.split("|");
	var acctNum = csdataTemp[1];
	var exists = csdataTemp[2];
	if (exists == "") {
		if (mopId == "HLINTTM") {
			if (funcCode == "M") {
				var inputname = "acctNum|" + acctNum;
				var outputname = ""
				var scriptName = "popValuesForPegFlg.scr"
				var retVal = appFnExecuteScript(inputname, outputname, scriptName, false);
				var values = retVal.split("|");
				if (values[1] == "V") {
					document.forms[0].peggedFlg[1].checked = true;
				}
			}
		}
	}
}

//Function for assigning custom field values during on click
function linttmgendet_pre_ONCLICK(obj) {
	linttmgendet_setFields();
}

function pre_ONLOAD(linttmgendet, obj) {
	linttmgendet_getFields();
}

//Function for getting custom field values 
function linttmgendet_getFields() {
	if (mopId == "HLINTTM") {
		getFieldsFromCustomData("peggedFlg");
	}
}


//Function for setting custom field values 
function linttmgendet_setFields() {
	if (mopId == "HLINTTM") {
		setFieldsToCustomData("peggedFlg");
		return true;
	}
}

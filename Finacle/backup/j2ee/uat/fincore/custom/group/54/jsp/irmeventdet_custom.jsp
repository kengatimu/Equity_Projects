<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : irmeventdet_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This script used to make the field protected and populated.
<!--Date                : 13-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            13-03-2013           Shilpa           Original version
<!--     0.2            6-06-2013           Shilpa           getting data from crit page
<!--     0.3		18-09-2013	   Suhasini 		changes done as part of porting-2
<!---------------------------------------------------------------------------------------------------------------->
<%
	String scheck = ((request.getParameter("custom.customchk")!= null)?request.getParameter("custom.csutomchk"):"N");
%>
<script language="javascript" src= "../../custom/javascripts/custom_functions.js"></script>
<script type ="text/javascript">
function post_ONLOAD() {

	var inputNameValues = "";
	var outputNames = "val1";
	var scrName = "rmdfltpopmn001.scr";
	var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret = retVal.split("|");
	var chargeeventid5 = ret[13];
	var subtype3 = ret[19];
	var chargeeventid4 = ret[11];
	var ratecode2 = ret[15];
	var chargeeventid6 = ret[21];
	var chkremitType = ret[25];
	var chkcur = ret[27];

	var custData = document.forms[0].customData.value;
	var custSplit = custData.split('|')
	var length = custSplit.length;
	var myString = custData;
	var remitTypeLen = myString.search("~irmcrit");
	var newremitType = myString.substring(remitTypeLen, myString.length);
	var custPayDataSplit = newremitType.split('|');
	var remitType = custPayDataSplit[1].toUpperCase();
	var crncy = custPayDataSplit[2].toUpperCase();
	var funcCode = custPayDataSplit[3].toUpperCase();
	var radioButtons = document.getElementsByName('consolidateFlg');
	radioButtons[1].checked = true;
	radioButtons[0].checked = false;
	document.forms[0].notConvRate.disabled = true;
	fnChangeRateCode();

	var n = remitType.indexOf(subtype3);

	if (n > 0 && (funcCode == "G" || funcCode == "M")) {
		if (document.forms[0].rateCode.value == "") {
			document.forms[0].rateCode.value = ratecode2;
			fnChangeEventRateCode();
		}
		return true;
	}
	else if (funcCode == "G" || funcCode == "M") {
		if (document.forms[0].rateCode.value == "") {
			document.forms[0].rateCode.value = ratecode2;
			fnChangeEventRateCode();
		}
		return true;
	}

	else if (funcCode == "R") {
		if (document.forms[0].rateCode.value == "") {
			document.forms[0].rateCode.value = ratecode2;
			fnChangeEventRateCode();
		}

		return true;
	}

	/*if (funcCode == "W") {
		if ((myString.search("~irmeventdet")) > 0) {
			var eventLen = myString.search("~irmeventdet");
			var newVal = myString.substring(eventLen, myString.length);
			var custDataSplit = newVal.split('|');
			var chkFlag = custDataSplit[1].toUpperCase();
		}
		else {
			var chkFlag = "N"
		}
		if (chkFlag != "Y") {
			if ((remitType == chkremitType) && (crncy == chkcur)) {
				document.forms[0].chrgEvntId.value = "";
			}
		}
	}*/
}

function irmeventdet_pre_ONCLICK(obj) {
	if ((funcCode == 'G' || funcCode == 'M') && (obj.id == "Submit" || obj.id == "Validate")) {
		var rate = document.forms[0].rate.value;
		var base = document.forms[0].notConvRate.value;
		var inputNameValues = "rate" + "|" + rate + "|" + "base" + "|" + base;
		var outputNames = "status1";
		var scrName = "rmdfltpopmn002.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		var base1 = ret[5];
		if (base1 == "Y") {
			alert("CONVERTION RATE OUT OF RANGE.....CANNOT PROCEED!");
			document.forms[0].rate.focus();
			return false;
		}
	}
}

/*function irmeventdet_ONCHANGE(obj) {

	if (funcCode == "W") {
		if (obj.id == "chrgEvntId") {
			document.forms[0].customchk.value = "Y";
			setFieldsToCustomData("customchk");
		}
	}

}*/
</script>

<INPUT type="hidden" name="custom.customchk" id="customchk" value="<%=scheck%>">

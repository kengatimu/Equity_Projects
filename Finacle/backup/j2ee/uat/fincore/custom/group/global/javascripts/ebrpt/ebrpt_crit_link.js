<!--	This is getting executing on click of submit and validate button -->
function fnValidateData(){
	    if (!fnCheckMandatoryFields()){
		    return false;
	    }
            if(document.forms[0].rptModule.value == ""){
	        alert("Select Report Module");
	        document.forms[0].rptModule.focus();
	        return false;
            }
            if(document.forms[0].rptDiv.value == ""){
                alert("Select Report Division");
                document.forms[0].rptDiv.focus();
	        return false;
            }
            if(document.forms[0].rptName.value == ""){
                alert("Select Report");
                document.forms[0].rptName.focus();
	        return false;
            }
	    return true;
}
function fnReportList(){
	var RptModule       = document.forms[0].rptName.value;
	var inputNameValues = "RptModule|" + document.forms[0].rptModule.value + "|rptDiv|"+document.forms[0].rptDiv.value; 
	var outputNames     = "idreportcode|idreportdesc|idinputfile";
	var title           = "List of Reports" ;
	var literalNames    = "Report Code|Report Discription|RFP Number ";	
	var scrName         = "ebrptmnzo.scr";
	var hyperLnks       = "2";
	var retVal          = fnExecuteScriptForList(inputNameValues, outputNames, scrName, title, literalNames, hyperLnks,false);

	if (retVal != null){
		var token = retVal.split("|");
		var rptName = token[0];
		document.forms[0].rptName.value = rptName;
		var rptDesc = token[1];
		document.forms[0].reportDesc.value = rptDesc; 	
	}
}
function ebrpt_crit_ONCHANGE3(obj){
	if(document.forms[0].rptName.value != ""){
	var inputNameValues = "rptCode|"+document.forms[0].rptName.value + "|rptMod|" + document.forms[0].rptModule.value + "|rptDiv|"+document.forms[0].rptDiv.value;
		var outputNames     = "";
		var scrName         = "ebrptmnzt.scr";
		var retVal          = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
		var valueFromScript = retVal.split("|");
		var errFlg			= valueFromScript[0];
		var repDesc			= valueFromScript[1];

		if(errFlg == "N"){
			document.forms[0].reportDesc.value = repDesc;
		} else {
			document.forms[0].reportDesc.value =  "";
			document.forms[0].rptName.value = "";	
		}	
	}
}
function fnPopulateDivision(){
        fnClearDivisionFunctions();
        var x = document.getElementById("rptDiv");
        if(document.forms[0].rptModule.value=="L"){
		//alert(document.forms[0].rptModule.value);
		var option = document.createElement("option");
		option.text = "CS    -  Customer Statements";
		option.value = "CS";
		x.add(option);
        }
	if(document.forms[0].rptModule.value=="T"){
		//alert(document.forms[0].rptModule.value);
		var option = document.createElement("option");
		option.text = "ED    -  Excise Duty";
		option.value = "ED";
		x.add(option);
	}

}
function fnClearDivisionFunctions(){
        document.getElementById("rptDiv").options.length = 0;
}
function ebrpt_crit_pre_ONCLICK(obj){
        if(obj.id == 'Accept')
	{
            return fNextPage();
	}
}
function fNextPage(){
	if(document.forms[0].rptModule.value != ""){
		if(document.forms[0].rptDiv.value != ""){
			if(document.forms[0].rptName.value != ""){
	var inputNameValues = "rptCode|"+document.forms[0].rptName.value + "|rptMod|" + document.forms[0].rptModule.value + "|rptDiv|"+document.forms[0].rptDiv.value;
				var outputNames     = "";
				var scrName         = "ebrptmnztr.scr";
				var retVal          = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
				var valueFromScript = retVal.split("|");
				var errFlg			= valueFromScript[0];
				var callingJsp		= valueFromScript[1];
				if(errFlg == "N"){
					document.forms[0].nextPage.value = callingJsp;
				}else{
					document.forms[0].nextPage.value = "";	
				}	
			}
		}
	}
 	return true;
}



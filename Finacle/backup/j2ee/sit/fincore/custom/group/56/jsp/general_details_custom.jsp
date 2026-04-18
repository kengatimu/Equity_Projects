<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : general_details_custom.jsp
<!--Description         : This is used to set localCalendar to no and it is protect.
<!--Date                : 13-03-2013 
<!--Author              : Manoj
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOAACSB,HOAACCC,HOAACCA,HOAACOD,HOAACLA
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            13-03-2013                       Manoj          	Original version
<!--	 0.2		17-07-2013			 Priyanka T		Updated changes for HOAACLA
<!---------------------------------------------------------------------------------------------------------------->
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="generaldetails" isEntryPoint="false" />

<%
	String glSub   = (String)ARJspCurr.getInputWithGroup("glSubHeadCode", null);
	String schmCde   = (String)ARJspCurr.getInputWithGroup("schmCode", null);
%>


<script type="text/javascript">
function post_ONLOAD(){

	var glSubCode = "<%=glSub%>"
	
	var bioStatus = getSValue("bioStatus");
	if((bioStatus != "") && (bioStatus != "null"))
	{
		document.getElementById('natLangName').value = "BIOVALSTATUS=" + bioStatus;
		document.forms[0].natLangName.disabled = true;
	}
	
	if(mopId == "HOAACSB" || mopId == "HOAACCC" ||  mopId == "HOAACCA" ||  mopId == "HOAACOD"){
		var radioButtons = document.getElementsByName('localCalendar');
		radioButtons[0].checked = false;
		radioButtons[1].checked = true;
		radioButtons[0].disabled = true;
		radioButtons[1].disabled = true;

		var radioButtons1 = document.getElementsByName('collectCharges');
		radioButtons1[0].checked = true;
		radioButtons1[1].checked = false;
		radioButtons1[0].disabled = true;
		radioButtons1[1].disabled = true;
		
		
		//var schmCode = document.getElementsById('acctRptCode');
		var schmCode = document.forms[0].acctRptCode.value;
		//alert(schmCode);
		
		if(schmCode == "SB190"){
			
			var radioButtons_staff = document.getElementsByName('relativeToStaff');
			radioButtons_staff[0].checked = true;
			radioButtons_staff[1].checked = false;
			radioButtons_staff[0].disabled = true;
			radioButtons_staff[1].disabled = true;

        }
	}


	if(mopId == "HOAACLA"){
		if(document.getElementById('pbPsFlg').value == ""){
			document.getElementById('pbPsFlg').value = 'N';
		}
	}


	var pbval = document.getElementById('pbPsFlg').value;	
	
	if(pbval != "S" && pbval != "P" && pbval != "B"){
		var modeopcode = document.forms[0].modeOfOperCode.value;
		var inputNameValues =  "modeOfOperCode" + "|" + modeopcode + "|" + "glSub" + "|" + glSubCode;
		var outputNames = "paramV1|paramV2";
		var scrName = "acctopnvalmn002.scr";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		if(ret[0] == "Error"){
			alert(ret[1]);
			return false;
		}

		if(ret[3] == "Y") {
			document.getElementById('pbPsFlg').value = 'P';
		}
	}
}


document.getElementById('pbPsFlg').onchange = function(){
	var radioButtons = document.getElementsByName('localCalendar');
	radioButtons[0].checked = false;
	radioButtons[1].checked = true;
	radioButtons[0].disabled = true;
	radioButtons[1].disabled = true;
}


/**************************************************************************************
Function Name   :   fnCheckMandatoryFields()
Description     :   This function is called to check mandatory fields
**************************************************************************************/

function checkMandatoryFields()
{
	var ObjForm = document.forms[0];
	if(fnIsNull(ObjForm.acctMgrAtAcct.value))
	{
		alert("Enter the A/c. Manager ID");
		ObjForm.acctMgrAtAcct.focus();
		return false;
	}
	return true;
}

function general_details_pre_TAB_SWITCH(){
	if(mopId == "HOAACLA"){
		var retVal = ""
		if ((retVal =  checkMandatoryFields()) == false) {
				return false;
		}
	}
	return true;
}


function general_details_pre_ONCLICK(btn){
	if(mopId == "HOAACLA"){
		if((btn.id == "Submit") || (btn.id == "Validate")){
			var retVal = ""
			if ((retVal =  checkMandatoryFields()) == false) {
					return false;
			}
		}
	}

	var glSubCode = "<%=glSub%>"
	var modeopcode = document.forms[0].modeOfOperCode.value
	if(modeopcode == ""){
		if((btn.id != "Back" ) && (btn.id != 'collapse2') &&(btn.id != 'expand2')){
			var modeopcode = document.forms[0].modeOfOperCode.value;
			var inputNameValues =  "modeOfOperCode" + "|" + modeopcode + "|" + "glSub" + "|" + glSubCode;
			var outputNames = "paramV1|paramV2";
			var scrName = "acctopnvalmn002.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			
			if(ret[0] == "Error") {
				alert(ret[1]);
				return false;
			}

			if(ret[1] == "X"){
				alert("Enter mode of operation code");
				document.forms[0].modeOfOperCode.focus();
				return false;	
			}
			else{
				return true;
			}
		}
	}
}


function general_details_pre_TAB_SWITCH(obj)
{
	if(mopId != "HOAACLA" && mopId != "HOAACMLA" &&  mopId != "HOAACVLA" &&  mopId != "HACMLA" && mopId != "HOAACCL" && mopId != "HOAACMCL" && mopId != "HOAACVCL" &&  mopId != "HACMCL" && mopId != "OAACPS"  && mopId != "OAACMPS" && 
	mopId != "OAACVPS" &&  mopId != "HOAACBP" && mopId != "HOAACMBP" && mopId != "HOAACVBP" ){

	if (document.forms[0].modeOfOperCode.value=="")
	{
		alert("Enter mode of operation code");
		document.forms[0].modeOfOperCode.focus();
		return false;
	  } 
	}
}
</script>












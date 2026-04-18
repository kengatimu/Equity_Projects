<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ogmgendtl_custom.jsp
<!--Description       : This jsp During add, 
<!--					If Bg type is BBG and bg currency is not homeCurency, then bg 
<!--					amount is multiplied with rate to get amoutn in home 
<!--					currency and according to the output amt alerts are displayed.
<!--					If the greater or equal to 1000000 50% cash cover and 50% other acceptance securities.
<!--Date              : 17-01-2013
<!--Author            : Shishira
<!--Called By         : bankgrntValmn001.scr  
<!--Calling jsp       : None
<!--Menu Option       : OGM/IGM.
<!--Modification History:
<!--    Version No.      Date           Author                     Description
<!--    ---------        ----------     ---------------            --------------------
<!--     0.1             17-01-2013     Shishira                   Original version
<!--	0.2				24-07-2013		Priya K					Modified for TO-355718
<!---------------------------------------------------------------------------------------------------------------->
<%@ include file="../../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ogmgen" isEntryPoint="false" />
<%
	String sBgType      =   (String)ARJspCurr.getInputWithGroup("bgType", null);
	String sBgAmtCrncy  =   (String)ARJspCurr.getInputWithGroup("bgCrncyCode", null);
%>

<script type ="text/javascript">
function ogmgendtl_pre_ONCLICK(btnId) {
//Modification for TO-355718
	    setFieldsToCustomData("paysysId");
//Modification ends
	if(btnId.id!= "Cancel" && funcCode == "A"){
		
		var functType = funcCode;
		var bgCcy = "<%=sBgAmtCrncy%>"
		var bgTyp = "<%=sBgType%>"

		var bgAmt = document.forms[0].bgAmt.value
		var bgRate = document.forms[0].rate.value;
		
		bgAmt = bgAmt.replace(new RegExp(',','g'),"");
		var bgAmt= parseFloat(bgAmt,2);
		
		if(bgAmt != "" || bgAmt != 0){
			var inputNameValues = "bgAmt" + "|" + bgAmt +"|" +"bgCcy" + "|" + bgCcy +"|" +"bgTyp" + "|" + bgTyp + "|" + "bgRate" + "|" + bgRate ;
			var outputNames = "";
			var scrName = "bankgrntValmn07.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var alrtMsg = ret[1];
			if(ret[0] == "MSG"){	
				alert(alrtMsg);
			}
		}
	}
	return true;
}

function ogmgendtl_pre_ONCHANGE(btnId) {

	if(btnId.id!= "Cancel" && funcCode == "A"){
		var functType = funcCode;
		var bgCcy = "<%=sBgAmtCrncy%>"
		var bgTyp = "<%=sBgType%>"

		var bgAmt = document.forms[0].bgAmt.value
		var bgRate = document.forms[0].rate.value;
		
		bgAmt = bgAmt.replace(new RegExp(',','g'),"");
		var bgAmt= parseFloat(bgAmt,2);
		
		if(bgAmt != "" || bgAmt != 0){
			var inputNameValues = "bgAmt" + "|" + bgAmt +"|" +"bgCcy" + "|" + bgCcy +"|" +"bgTyp" + "|" + bgTyp + "|" + "bgRate" + "|" + bgRate ;
			var outputNames = "";
			var scrName = "bankgrntValmn07.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var alrtMsg = ret[1];
			if(ret[0] == "MSG"){	
				alert(alrtMsg);
			}
		}
	}
	return true;
}

function ogmgendtl_pre_ONBLUR(btnId) {

	if(btnId.id!= "Cancel" && funcCode == "A"){
		var functType = funcCode;
		var bgCcy = "<%=sBgAmtCrncy%>"
		var bgTyp = "<%=sBgType%>"

		var bgAmt = document.forms[0].bgAmt.value
		var bgRate = document.forms[0].rate.value;
		
		bgAmt = bgAmt.replace(new RegExp(',','g'),"");
		var bgAmt= parseFloat(bgAmt,2);
		
		if(bgAmt != "" || bgAmt != 0){
			var inputNameValues = "bgAmt" + "|" + bgAmt +"|" +"bgCcy" + "|" + bgCcy +"|" +"bgTyp" + "|" + bgTyp + "|" + "bgRate" + "|" + bgRate ;
			var outputNames = "";
			var scrName = "bankgrntValmn07.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var alrtMsg = ret[1];
			if(ret[0] == "MSG"){	
				alert(alrtMsg);
			}
		}
	}
	return true;
}
//ebl customization 355390

function ogmgendtl_post_ONLOAD(obj)
	{
		//alert("hey");
document.forms[0].rateCode.disabled=true;
document.forms[0].rate.disabled=true;
if(funcCode == "R")
{
        var radioButtons = document.getElementsByName('bgCloseOnReverse');
        radioButtons[0].checked = true;
}
	}
	//ebl customization 355390
//Modification for TO-355718
function ogmgendtl_pre_TAB_SWITCH()
{
	    setFieldsToCustomData("paysysId");
}
//Modification ends here

</script>

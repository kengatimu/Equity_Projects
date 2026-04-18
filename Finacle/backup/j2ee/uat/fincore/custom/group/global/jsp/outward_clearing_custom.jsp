<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : outward_clearing_custom.jsp 
<!--Description         :
<!--Date                : 19-06-2021
<!--Author              : Vino Palani
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOCTM 
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            19-06-2021                       Vino Palani          Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="outwardclearing" isEntryPoint="false" />
<script language="javascript">
function outward_clearing_pre_ONCLICK(obj){
	//alert(profileId);
	if(profileId ==54){
	var funcCode = document.forms[0].funcCode.value;	
	var zoneCode = document.forms[0].zoneCode.value;	
	if(((funcCode == "A") || (funcCode == "D") || (funcCode == "M") || (funcCode == "R")) && (zoneCode=="CTSINHSE")){
		alert("Function & Operation Not allowed");
		//return false;
	}
	}
}
function outward_clearing_post_ONLOAD(){
	

	//alert(document.forms[0].ptranAccountNum.value);
	if (document.forms[0].ptranAccountNum.value!="")
	{
		//alert("Anderson");
		var acctNumber = document.forms[0].ptranAccountNum.value;
        if (profileId=="11")
	{
	// Checking Document Expiry date --- Anderson
        	var inputNameValues = "foracid|"+acctNumber;
        	var outputNames     = "msgFlg";
        	var scrName         = "checkDocExpDate.scr";
       		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        	var ret1 = retVal.split("|");
        	alert(ret1[1]);

	// End of Document Expiry date checker --- Anderson
	}


	}


}




</script>

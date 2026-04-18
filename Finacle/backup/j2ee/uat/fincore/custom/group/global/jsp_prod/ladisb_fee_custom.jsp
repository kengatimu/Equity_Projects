<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : LADISB_FEE_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 16-07-2013
<!--Author            : George
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLADISB
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		16-07-2013	GEORGE		Original version  358748
<!--	0.2		26-09-2013	KALVIN		Modified for TO :344729
<!---------------------------------------------------------------------------------------------------------------->

<!---------------------------------------Modified for TO :344729----------------------------->
<%@ include file="../commonInclude.jsp" %>
<%
        ContextManager CustomARJspCurr =(ContextManager)session.getAttribute("CustomARJspCurr");
        String sGroupName = CustomARJspCurr.getCurrentGroup();
        String tranTypeVal = (String)CustomARJspCurr.getInput(sGroupName+".tranType", "");
		String grossNetDisbVal = (String)CustomARJspCurr.getInput(sGroupName+".grossNetDisb", "");
		String acctNumVal = (String)CustomARJspCurr.getInput(sGroupName+".acctNum", "");
		String disbAmtVal = (String)CustomARJspCurr.getInput(sGroupName+".disbAmt", "");
		
%>

<input type="hidden" id = "tranTypeVal" name = "tranTypeVal" value = "<%=tranTypeVal%>">
<input type="hidden" id = "grossNetDisbVal" name = "grossNetDisbVal" value = "<%=grossNetDisbVal%>">
<input type="hidden" id = "acctNumVal" name = "acctNumVal" value = "<%=acctNumVal%>">
<input type="hidden" id = "disbAmtVal" name = "disbAmtVal" value = "<%=disbAmtVal%>">



<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<!--------------------------------------ENDOF-Modified for TO :344729----------------------------->

<script>

function ladisb_fee_post_ONLOAD(obj)
{
	if (funcCode == "D" )
	{
		var checkbox = document.getElementsByName('chkbox');
		checkbox[0].checked = true;
		checkbox[1].checked = true;
		checkbox[2].checked = true;
		checkbox[3].checked = true;	
	}

	}
//---------------------------------------Modified for TO :344729-----------------------------
function ladisb_fee_pre_ONCLICK(obj){
var test ="";
var trantype = document.forms[0].tranTypeVal.value;
var disbType = document.forms[0].grossNetDisbVal.value;



if (( trantype == "T" ) && (disbType =="G")){

	if(obj.id== 'accept')
	{
		if ((retVal = fnInsertDISRTTab()) == false) 
			{
                return false;
			}
		
	}
}



	return true;

}


function fnInsertDISRTTab(){
	var chrgEvntIdVal = "";
	var usrEntAmt = "";
	var chrgEventTypeVal ="";
	var crncyVal ="";
//Modified for TO:379480
	var loanAct = document.forms[0].acctNumVal.value;		 
	var input = "loanAct|" +loanAct;	
	var scrName  = "ladisbchrgdp003.scr";
	var output   = "";
	var retVal = appFnExecuteScript(input,output,scrName,false);
	
//Modification ends here
	for(i=0;i<chargeType.length;i++){
		
		if(document.getElementsByName('chkbox')[i]){
			if(document.getElementsByName('chkbox')[i].checked){
				chrgEvntIdVal = chrgEvntIdVal + "!" + chargeEventId[i];
				chrgEventTypeVal = chrgEventTypeVal + "!" + chrgEventType[i];
				crncyVal = crncyVal + "!" + crncy[i];
				usrEntAmt = usrEntAmt + "!" + document.getElementsByName('entAmt')[i].value;
			}			
		}
	}
	
		
		if(fnIsNull(chrgEvntIdVal)) return;
		var loanAct = document.forms[0].acctNumVal.value;
		var disbAmt = document.forms[0].disbAmtVal.value;
		usrEntAmt = usrEntAmt.replace(new RegExp(',','g'),"");
		 var input = "chrgEvntIdVal|" + chrgEvntIdVal + "|usrEntAmt|" + usrEntAmt + "|chrgEventTypeVal|" +chrgEventTypeVal + "|crncyVal|" +crncyVal + "|loanAct|" +loanAct + "|disbAmt|" +disbAmt ;
	
		var scrName  = "ladisbchrgmn002.scr";
		var output   = "";
		var retVal = appFnExecuteScript(input,output,scrName,false);
		var ret = retVal.split("|")
			if (ret[0] =="Error") {
			alert(ret[1]);
			 return false;

	}
}


//---------------------------------------END OF Modified for TO :344729-----------------------------

</script>

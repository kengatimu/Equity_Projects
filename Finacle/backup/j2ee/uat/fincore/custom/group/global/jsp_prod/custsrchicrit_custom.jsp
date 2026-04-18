<!------------------------------------------------------------------------------------------------->
<!--Name                : custsrchicrit_custom.jsp
<!--Description         : This is used to set localCalendar to no and it is protect for TOL - 356357
<!--Date						 : 11-07-2013 
<!--Author					  :  Vijaya V
<!--Called By			  : None
<!--Calling jsp				 : None
<!--Menu Option         : HCRV
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------				  ----------                 -----------        ------------------
<!--     0.1				  11-07-2013				Vijaya V			Original version
<!--     0.2				  17-07-2013				Bharath 			Added product function
<!--------------------------------------------------------------------------------------------------->
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>

<%
	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	if(null == securityInfo)
	{
		securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	}
	String homeSol  = (String)((securityInfo.homeSolId));
%>

<script type="text/javascript">
function showCifId(obj,ctrlOrMorph,inPreceedence,objDesc,delFlg,srchCrit,targetBankId)
{
        if (arguments.length >6 && targetBankId != null && targetBankId != "")
        {
                /* !!!! WARNING!!!!!!
                Control will come inside this if block only for calls from a/c id searcher
                criteria hence hardcoding the icfg's output value into "AcctCifId"
                which is the page variable on a/c id searcher criteria page */

                showDynCritSearcher("CIF","cif_id=:AcctCifId|targetBankId=:targetBankId",":AcctCifId=cif_id");
        }else
        {
                var cifObj = "";
                var sUrl = "";
                var preceedence = 'B';
                var url = "../arjspmorph/";
        		var cif = obj.value;
        if(arguments.length > 1)
        {
		if(ctrlOrMorph == 'morph')
		url = "../";
        }

        if(browser_name != "Microsoft Internet Explorer")
        {
                url = "../arjspmorph/";
        }
        if(arguments.length > 2)
        {
                preceedence = inPreceedence;
        }

        if(obj != null) cifObj = obj.id;

	if (arguments.length < 4)
	{
		sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+cifObj+"&wReturnDesc=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+cifObj+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence+"&delFlg="+delFlg+"&cif="+escape(cif)+"&srchCrit="+srchCrit;
	}

	// var retVal = popModalWindow(sUrl,"CifId");
	if ("Microsoft Internet Explorer" == browser_name)
	{
		var retVal = popModalWindowVar(sUrl,"CifId",55,35,55,32);
	if (retVal != null && retVal != undefined )
	{
		//Array for taking the values after splitting the value with "|".
		var liarrBufArray = retVal.split("|");

		obj.value = liarrBufArray[0];
		if(objDesc != null) objDesc.value = liarrBufArray[1];
	}
        }else{
		popModalWindowMozillaFrame(sUrl,"CifId");
             }
        }
	validateCif();
}

function post_ONLOAD(obj)
{
	validateCif();
}

function custsrchicrit_pre_ONCHANGE(obj)
{
	if(obj.id == "cifId")
	{
		validateCif();
	}
}

function validateCif()
{
	var cif = document.forms[0].cifId.value;
	var radioButtons = document.getElementsByName('cifType');
	if(cif != "" )
	{
		var inputNameValues = "cif" + "|" +cif ;
		var scrName = "crvCifmn001.scr";
		var outputNames = "paramV1,paramV2";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");

		if(ret[0] == "err")
		{
			document.forms[0].cifId.focus();
			return false;
		}

		if(ret[1] == "R")
		{
			radioButtons[0].checked = true;
			radioButtons[1].checked = false;
		}				

		if(ret[1] == "C")
		{
			radioButtons[0].checked = false;
			radioButtons[1].checked = true;
		}

		radioButtons[0].disabled = true;
		radioButtons[1].disabled = true;
		document.forms[0].solId.value = "";
	}
	else
	{
		document.forms[0].solId.value = "<%=homeSol%>";
		radioButtons[0].checked = true;
		radioButtons[1].checked = false;
		radioButtons[0].disabled = false;
		radioButtons[1].disabled = false;
	}
}
</script>

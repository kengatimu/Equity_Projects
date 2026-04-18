<%@ page import="applcommon.ParseValue" %>
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<SCRIPT language="javascript" src="../custom/javascripts/custom_functions.js" ></SCRIPT>
<SCRIPT language="javascript" src="../javascripts/cust_post_evt.js" ></SCRIPT>
<SCRIPT language="javascript" src="../javascripts/cust_pre_evt.js" ></SCRIPT>
<script language="javascript">


function custom_ONBLUR(obj,obj)
{
	//alert("Hello");
	//if(obj.id === "acctId")
	//{
		//memoPad();
	//}
}
function lagendetails_post_ONCHANGE(obj)
{
	//alert("Hello1");
	//memoPad();
	if(obj.id === "acctId")
		{
			memoPad();
		}


}
function memoPad(){
	        var acctNumber = document.forms[0].acctId.value ;
	        var inputNameValues = "acctNum|"+acctNumber;
	        var outputNames     = "";
	        var scrName         = "formatacctdp001.scr";
	        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	        var ret1 = retVal.split("|");
	        if(ret1[0] == "MSG" ){
			                alert(ret1[1]);
			        }
}

</script>
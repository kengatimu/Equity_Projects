<%@ page import="applcommon.ParseValue" %>
<%@ page import="com.infy.bbu.jsputil.*"%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<script language="javascript" src="../../javascripts/session.js"></script>
<SCRIPT language="javascript" src="../custom/javascripts/custom_functions.js" ></SCRIPT>
<SCRIPT language="javascript" src="../javascripts/cust_fetch_list.js" ></SCRIPT>
<SCRIPT language="javascript" src="../javascripts/cust_post_evt.js" ></SCRIPT>
<SCRIPT language="javascript" src="../javascripts/cust_pre_evt.js" ></SCRIPT>

<script language="javascript">
     		function acmlacrit_ONLOAD(obj){
	                alert("Here1");
	        }
	        function acmlacrit_post_ONCHANGE(obj)
	        {
	                alert("1");

	                        if(document.forms[0].acctNo.value != "")
	                        {
	                                alert(here3);
	                                memoPad();
	                         }

	        }

	       function memoPad(){
		var acctNumber = document.forms[0].acctNo.value ;
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







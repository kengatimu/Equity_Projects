<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : upmcrit_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 18-01-2013
<!--Author              : Prakash 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HUPM
<!--Modification History:
<!--	Version No.	      Date		         Author 	       	Description
<!--	-------        	----------         -----------        ------------------
<!--     0.1	    	18-01-2013	         Prakash           Original version
<!--     0.2            20-08-2013           Nithya            Changes made as per TO - 366250
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function upmcrit_pre_ONCLICK(obj) 
{		
	if(obj.id == "Accept" && (document.forms[0].funcCode.value == "A" || document.forms[0].funcCode.value == "C")) {
		var inputNameValues = "";
		var outputNames     = "";
		var scrName         = "upmWorkclassvaldp002.scr";
		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");		
		if(ret[0] == "Error") {
			alert(ret[1]);
			return false;
		}
	}
	return true;
}
function upmcrit_pre_ONCLICK(obj)
{
        setFieldsToCustomData("usrId");
        return true;
}
</script>

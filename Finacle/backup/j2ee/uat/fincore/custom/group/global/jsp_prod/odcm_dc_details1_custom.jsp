<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : odcm_dc_details1_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 03-06-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : ODCM
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		03-06-2013	jane		Original version
<!--	0.2		29-07-2013	Priyanka T	Mandates Place of Expiry field in DC Details tab - TO 362602
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script type ="text/javascript">

function odcm_dc_details1_post_ONLOAD(obj)
{
	document.forms[0].applicableRules.value="UCP";
	
//geo start
	document.forms[0].chkrevocable.disabled = true;
 
 //geo end

}

function pre_TAB_SWITCH()
{
	if(mopId == "ODCM")
	{
		if(funcCode == "S" || funcCode == "M")
		{
			if(document.forms[0].plExpDate.value == "")
                	{
                        	alert("Place of Expiry is mandatory");
				document.forms[0].plExpDate.focus();
                        	return false;
                	}
		}
	}

}

function odcm_dc_details1_pre_ONCLICK(btnId)
{
	if(mopId == "ODCM")
        {
		if(funcCode == "S" || funcCode == "M")
		{
			if(btnId.id == "Submit" || btnId.id == "Validate" || btnId.id == "NextPage")
			{
				if(document.forms[0].plExpDate.value == "")
                		{
                        		alert("Place of Expiry is mandatory");
                        		document.forms[0].plExpDate.focus();
                        		return false;
                		}
			}
		}
	}
	
	if(btnId.id == "Cancel")
	{
		return true;
	}
}

</script>




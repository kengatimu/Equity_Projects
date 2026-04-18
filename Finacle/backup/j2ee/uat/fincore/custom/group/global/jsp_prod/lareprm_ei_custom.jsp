<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : laparm_ei_custom.jsp 
<!--Description         : This jsp is used to populate default values in case of Add Mode
<!--Date                : 13-06-2017	
<!--Author              : Kango 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HALA
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--     0.1	    		13-06-2017	        Kango	Original version
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="../commonInclude.jsp" %>

<script type="text/javascript">

function post_ONLOAD() {
	//alert(mopId);
	if (mopId == "HLARA") {
		//alert(profileId);
		if (profileId == "50") {
			//alert("TESTE");
			document.forms[0].chkdelinRshdlFlg.checked = true;
			document.forms[0].chkdelinRshdlFlg.disabled = true;
		}

		if (funcCode == "R") {
			var intFlgVal = document.forms[0].hldyPerdIntFlg.value;
			var hldyPerdMths = document.forms[0].hldyPerdMths.value;
			if (intFlgVal != "N") {
				if (hldyPerdMths != "0") {
					document.forms[0].hldyPerdMths.value = "0";
				}

			}

		}
	}
}

function lareprm_ei_post_ONCLICK(obj) {
	var form = document.forms[0];
	var reschValue = sessionStorage.getItem("rescheduleMethod");
	if (obj.id == "chkcapitalizeInt") {
		if (mopId == "HLARA") {
			if (funcCode == "R") {
				if (reschValue == "P" ) {	
					if(obj.checked){
						form.applyIntUptoDate[0].checked=true;
						form.applyIntUptoDate.value ="Y";
					}
				}
			}
		}
	}	
		return true;	
}

function lareprm_ei_post_ONCHANGE(obj) {
	if (obj.id == "hldyPerdIntFlg") {
		var intFlgVal = obj.value;
		if (mopId == "HLARA") {
			if (funcCode == "R") {
				if ((intFlgVal == "N") || intFlgVal == "") {
					document.forms[0].hldyPerdMths.value = "0";
				}

			}
		}
	}
}
	
</script>

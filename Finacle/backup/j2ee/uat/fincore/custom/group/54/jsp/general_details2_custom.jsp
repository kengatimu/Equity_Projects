<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : general_details2_custom.jsp
<!--Description         : This is used to set localCalendar to no and it is protect.
<!--Date                : 13-03-2013 
<!--Author              : Manoj
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOAACSB
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            13-03-2013                       Manoj          Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function post_ONLOAD(){
	if(mopId == "HOAACSB" ||  mopId == "HOAACCA"){
		var radioButtons = document.getElementsByName('wtaxAmtScopeFlg');
		if(radioButtons[0].checked != true && radioButtons[1].checked != true && radioButtons[2].checked != true){
			radioButtons[0].checked = false;
			radioButtons[1].checked = false;
			radioButtons[2].checked = true;
		}
	}
	if(mopId == "HOAACCC" ||  mopId == "HOAACOD"){
       	var radioButtons = document.getElementsByName('wtaxAmtScopeFlg');
		if(radioButtons[1].checked != true){
			radioButtons[0].checked = false;
           	radioButtons[1].checked = false;
           	radioButtons[2].checked = true;
        }
	}		

	if(mopId == "HOAACSB" || mopId == "HOAACCC" ||  mopId == "HOAACCA"){
		document.getElementById('custPrefIntCr').disabled=true;	
		document.getElementById('custPrefIntDr').disabled=true;	
	}
	
	if(mopId == "HOAACSB" ||  mopId == "HOAACCA" ||mopId == "HOAACCC" ||  mopId == "HOAACOD"){	
		var radioButtons1 = document.getElementsByName('collectIntFlg');
		radioButtons1[0].checked = true;
		radioButtons1[1].checked = false;
		radioButtons1[0].disabled = true;
		radioButtons1[1].disabled = true;
	}
}
</script>

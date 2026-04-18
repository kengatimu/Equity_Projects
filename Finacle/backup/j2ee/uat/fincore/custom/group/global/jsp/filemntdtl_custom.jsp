<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : filemntdtl_custom.jsp 
<!--Description         : This jsp is used to populate default values in case of Add Mode
<!--Date                : 08-02-2013
<!--Author              : Sateesh 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HBDTM
<!--Modification History:
<!--	Version No.	      Date		         Author 	       	Description
<!--	-------        	----------        		 -----------        ------------------
<!--     0.1	    	08-02-2013	        	 Saurabh	        Original version
<!--     0.2	    	30-03-2013	        	 Saurabh	        condition for other entity added
<!--     0.3	    	29-08-2013	        	 Priyansh	        Modification TO: 357556
<!--     0.4	    	09-09-2013	        	 jane				 Modification TO: 370221
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
//Edwin AGTM rename

function filemntdtl_pre_ONLOAD(obj)
{
	if (mopId == "HAGTM")
	{
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Short Name','SolId/Branch Code')
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Address Line 1','Outlet Code')
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Address Line 2','TIN Number')
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Address Line 3','Email Address')
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Operative Credit A/c. ID','Transacting Account')
		document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Nonoperative A/c. ID','Commision Account')			
	}
}
//Edwin AGTM rename
function post_ONLOAD() {
	if (mopId == "HBDTM") {
		if (fnCode == "A") {
			var inputNameValues = "";
			var outputNames = ""
			var scrName = "bwydnlddp001.scr";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			if (ret[0] == "Error") {
				alert(ret[1]);
				return false;
			}
			document.forms[0].facility_start_date_ui.value = ret[1];
			document.forms[0].facility_start_date.value = ret[1];
			document.forms[0].facility_end_date_ui.value = ret[3];
			document.forms[0].facility_end_date.value = ret[3];
			document.forms[0].group_seq_id.value = BODDate.substring(0, 2);
			var cntryCode = ret[5];
			if (cntryCode == "55") {
				document.forms[0].group_seq_id.value = ret[7];
			}
		}
	}
	if (mopId == "HPYRG") {
		fnEnableDisableRadioButtons(document.forms[0].chrg_waiver_flg, 'D');
		setRadioValue('document.forms[0].chrg_waiver_flg', "N");
	}
}
function filemntdtl_pre_ONLOAD(obj)
{
		if ((mopId == "HAGTM") && (profileId == "43"))
        {
			document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Short Name','Sol Id');
			document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Address Line 1','Outlet Code');
			document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Address Line 3','Transaction account');
			document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Postal Code','Channel Id 1');
			document.forms[0].innerHTML=document.forms[0].innerHTML.replace('Remarks','Channel Id 2');
			
			// Create new field next to agent_short_name
			var newFieldHTML = '<a id="solIdImg" href="javascript:showSetList(document.forms[0].agent_short_name,\'ctrl\',\'F\',\'\');">' +
							   '<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16"></a>';
			
			// Find the existing field with ID 'agent_short_name' and insert the new field
			var agentField = document.getElementById('agent_short_name');
			if (agentField) {
				agentField.insertAdjacentHTML('afterend', newFieldHTML);
			}
		}
		
        if ((mopId == "HAGTM") && ((profileId == "54") || (profileId == "43")))
        {
                if(fnCode == "A")
                {
                        getFieldsFromCustomData("CrncyCode");
                        var csdata = document.forms[0].customData.value;
                        var csdataTemp = csdata.split("|");
                        var CrncyCode = csdataTemp[1];
                        if (document.forms[0].crncy_code.value == "") {
                                document.forms[0].crncy_code.value = CrncyCode ;
                                document.forms[0].crncy_code.readOnly = true;
                                hideImage("sLnk_crncy_code");
                                return true;
                        }
                }
        }
}


function filemntdtl_pre_ONCLICK(obj) 
{	
	if(profileId == "43")
	{
		if((obj.id == "Submit") && (mopId == "HAGTM"))
		{	
			var operAcctNum = document.forms[0].oper_acct_num.value;
			if(operAcctNum != "")
			{
				var operCreditCrncyCode = document.forms[0].oper_credit_crncy_code.value.toUpperCase();
				var crncy_val = document.forms[0].crncy_code.value.toUpperCase();;
				
				if(operCreditCrncyCode != crncy_val)
				{
					alert("Currency code mismatch between agent currency and account currency!");
					document.forms[0].inoper_acct_num.focus();
					return false;
				}
				else
				{
					return true;
				}
			}
			
			var inoperAcctNum = document.forms[0].inoper_acct_num.value;
			if(inoperAcctNum != "")
			{
				var inOperCreditCrncyCode = document.forms[0].inoper_credit_crncy_code.value.toUpperCase();
				var crncy_val = document.forms[0].crncy_code.value.toUpperCase();;
				
				if(inOperCreditCrncyCode != crncy_val)
				{
					alert("Currency code mismatch between agent currency and account currency!");
					document.forms[0].inoper_acct_num.focus();
					return false;
				}
				else
				{
					return true;
				}
			}
		}
	}
	
	if (mopId == "HEFM") {
		getFieldsFromCustomData("funcCode");
		var csdata = document.forms[0].customData.value;
		var csdataTemp = csdata.split("|");
		var fnCode = csdataTemp[1];
		if (obj.id == "Submit") {
			//alert(fnCode);
			if ((fnCode == "A") || (fnCode == "M")) {
				if (document.forms[0].emp_email_id.value == "") {
					alert("Enter Email ID");
					document.forms[0].emp_email_id.focus();
					return false;
				}

				if (document.forms[0].emp_desig.value == "") {
					alert("Enter Designation");
					document.forms[0].emp_desig.focus();
					return false;
				}

			}
		}
	}
	if ((mopId == "HAGTM") && ((profileId == "54") || (profileId == "43"))) {
		//alert("am in");
		if (obj.id == "Submit") {
			if (document.forms[0].agent_addr2.value == "") {
				alert("Enter Agents KRA pin");
				document.forms[0].agent_addr2.focus();
				return false;
			}
			if (!isValid(document.forms[0].agent_addr2.value)) {
				alert("Enter Valid Agents KRA pin..");
				document.forms[0].agent_addr2.focus();
				return false;
			}
			if (document.forms[0].agent_addr3.value == "") {
				alert("Enter Valid Agent Email Address");
				document.forms[0].agent_addr3.focus();
				return false;
			}
			var dco = document.forms[0].agent_short_name.value;
			var input = "dco|" + dco;
			var outputNames = "output|outVal";
			var scrName = "b_solidcheck.scr";
			var retVal = appFnExecuteScript(input, outputNames, scrName, false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var c = value;
			//alert(c);
			if (c <= 0) {
				alert("Enter the correct SOL ID")
				document.forms[0].agent_short_name.focus();
				return false;
			} else {
				//call ("b_solidcheck_update.scr")
				/*
				var dco=document.forms[0].agent_short_name.value;
				var input      = "dco|"+dco;
				var outputNames    = "output|outVal";
				var scrName     =   "b_solidcheck_update.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var d = value;
				//alert(d);
				*/
			}
			if((document.forms[0].oper_acct_num.value != "") && (document.forms[0].inoper_acct_num.value !=""))
			{
				var dco = document.forms[0].oper_acct_num.value;
				var input = "dco|" + dco;
				var outputNames = "output|outVal";
				var scrName = "b_acctcifid.scr";
				var retVal = appFnExecuteScript(input, outputNames, scrName, false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var a = value;
				//alert(a);
				//var dco = document.forms[0].agent_addr3.value;
				var dco = document.forms[0].inoper_acct_num.value;
				var input = "dco|" + dco;
				var outputNames = "output|outVal";
				var scrName = "b_acctcifid.scr";
				var retVal = appFnExecuteScript(input, outputNames, scrName, false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var b = value;
				//alert(b);
				if (a != b) 
				{
					alert("Commission Account does not belong to Agent..")
					return false;
				}
			}
		}
	}
}
function isValid(str) {
	for (i = 0; i < str.length; i++) {
		var validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";
		if ((validChars.indexOf(str.charAt(i)) == -1)) {
			return false;
		}
	}
	if (str.length != 11) {
		return false;
	}
	return true;
}
	
</script>

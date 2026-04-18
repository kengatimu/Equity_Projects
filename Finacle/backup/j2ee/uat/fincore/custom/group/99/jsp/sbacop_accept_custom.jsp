<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : sbacop_accept_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 11-03-2013
<!--Author              : Chandrasekhar
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HOAACVSB
<!--Modification History:
<!--    Version No.          Date                Author             Description
<!--    ---------          ----------           ---------          -----------------
<!--     0.1               18-05-2013            Chandrasekhar            Original version
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" >
function sbacop_accept_pre_ONCLICK()
{
	if(mopId == "HOAACVSB"){	
	setCustomFieldValue("tempForacid","verifyCancel");
	}
}

function sbacop_accept_pre_ONCLICK(obj)
{
	
	if(mopId == "HOAACOD")
	{
		if(obj.id == "Accept")
		{
			setCustomFieldValue("cifId");
			var cifId  = document.forms[0].cifId.value;
			//var inputNameValues = "";
			var inputNameValues ="cifId|" + cifId;
        		var outputNames = "";
        		 var scrName = "ODASME_Restrict_Accounts.scr";
       			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        		var ret1 = retVal.split("|");

			if(ret1[1]=="Error")
			{
				alert(ret1[0]);
        			return false;
       			 } 
			
		}
	}


	if ((mopId == "HOAACSB") || (mopId == "HOAACCA"))
	{
		if (obj.id == 'Accept') 
		{
			//alert(document.forms[0].cifId.value);
			if  (document.forms[0].cifId.value =="")
			 {
				alert ("Please Enter CIF ID ");
			 return false;
			 }

			 //alert(document.forms[0].schmCode.value);
			if  (document.forms[0].schmCode.value =="")
			 {
				alert ("Please Enter Scheme Code ");
			 return false;
			 }
			
				if  (document.forms[0].schmCode.value =="SB190")
				 {
					var dcco=document.forms[0].cifId.value;
					var input      = "dcco|"+dcco;
					var outputNames    = "output|outVal";
					var outputNames    = "output2|outVal";
					var scrName     =   "b_sbacheck.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					var retBuff = retVal.split("|");
					var output = retBuff[2];
					var value = retBuff[3];
					var b = value;
					//alert(a);
					//alert(b);
					if (a>0)
					{
						alert("Account Exist With This Scheme Code");
						document.forms[0].schmCode.focus();
						return false;
					}
				}
				if  (document.forms[0].cifId.value !="")
				 {
					var dcco=document.forms[0].cifId.value;
					var input      = "dcco|"+dcco;
					var outputNames    = "output|outVal";
					var outputNames    = "output2|outVal";
					var scrName     =   "bio_check_opn.scr";
					var retVal = appFnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					var retBuff = retVal.split("|");
					var output = retBuff[2];
					var value = retBuff[3];
					var b = value;
					//alert(a);
					if (a!=1)
					{
						alert("PLEASE ENROLL CUSTOMER FOR BIO");
						document.forms[0].cifId.focus();
						return false;
					}
				 }
		}
	}
}
</script>

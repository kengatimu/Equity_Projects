<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}

		if(fnIsNull(document.forms[0].chrgAcc.value))
		{
			alert("Enter Charge Account Number")
			document.forms[0].chrgAcc.focus();
			return false;
		}

		if(fnIsNull(document.forms[0].drAlerts.value))
		{
			alert("Enter Debit Alert Flag");
			document.forms[0].drAlerts.focus();
			return false; 
		}
		
		if(document.forms[0].drAlerts.value == "Y")
		{
			if(fnIsNull(document.forms[0].minDrAmt.value))
			{
				alert("Enter Minimum Debit Amount for Debit Alerts");
				document.forms[0].minDrAmt.focus();
				return false;
			}
			if((document.forms[0].minDrAmt.value == 0) || (document.forms[0].minDrAmt.value == "0.00"))
			{
				alert("Debit Amount Cannot be Zero");
				document.forms[0].minDrAmt.focus();
				return false;
			}
			//if(fnValidateNumbers(document.forms[0].minDrAmt.value) == false)
			if(document.forms[0].minDrAmt.value < 0)
			{
				alert("Min Debit Amount cannot be negative!!");
				document.forms[0].minDrAmt.focus();
				return false;
			}
		}
		else
		{
			if((document.forms[0].minDrAmt.value != "") && (document.forms[0].minDrAmt.value != "0") && (document.forms[0].minDrAmt.value != "0.00"))
			{
				alert("Minimum Debit Amount Not Expected");
				document.forms[0].minDrAmt.focus();
                                return false;
                        }
		}
 
		if(fnIsNull(document.forms[0].crAlerts.value))
                {
                        alert("Enter Credit Alert Flag");
                        document.forms[0].crAlerts.focus();
			return false;
		}
			
		if(document.forms[0].crAlerts.value == "Y")
		{	
			if(fnIsNull(document.forms[0].minCrAmt.value))
                        {
                                alert("Enter Minimum Credit Amount for Credit Alerts");
                                document.forms[0].minCrAmt.focus();
                                return false;
                        }
                        if((document.forms[0].minCrAmt.value == 0) || (document.forms[0].minCrAmt.value == "0.00"))
                        {
                                alert("Credit Amount Cannot be Zero");
                                document.forms[0].minCrAmt.focus();
                                return false;
                        }
                        //if(fnValidateNumbers(document.forms[0].minCrAmt.value) == false)
                        if(document.forms[0].minCrAmt.value < 0)
                        {
                                //alert("Please Enter Min Credit Amount in Numeric!!");
                                alert("Min Credit Amount cannot be negative!!");
                                document.forms[0].minCrAmt.focus();
                                return false;
                        }
		}
		else
		{
			if((document.forms[0].minCrAmt.value != "") && (document.forms[0].minCrAmt.value != "0") && (document.forms[0].minCrAmt.value != "0.00"))
                        {
                                alert("Minimum Credit Amount Not Expected");
                                document.forms[0].minCrAmt.focus();
                                return false;
                        }
                }

		if((document.forms[0].crAlerts.value == "N") && (document.forms[0].drAlerts.value == "N"))
		{
			alert("Both Debit and Credit Alerts Required flag is set to NO");
			document.forms[0].drAlerts.focus();
		//	return false;
		}

		if(fnIsNull(document.forms[0].phNum.value))
		{
			alert("Enter Mobile Number");
			document.forms[0].phNum.focus();
			return false;
		}
		if(fnIsNull(document.forms[0].email.value))
		{
			//if (!fnValidateEmailID(document.forms[0].email.value))	
			//{
				//Remove email validation for DRC
				if(profileId != 43)
				{
					alert("Enter Valid MailId ");
					document.forms[0].email.focus();
					return false;
				}
			//}
		}
		if(fnIsNull(document.forms[0].activateFlag.value))
		{
			//alert("Select Activation/Deactivation Flag");
			//document.forms[0].activateFlag.focus();
			//return false;
		}

		return true;
}


function fnValidateNumbers(objectField)
{
	var iChars = ".,-0123456789";
	for (var i = 0; i < objectField.length; i++) 
	{
		if (iChars.indexOf(objectField.charAt(i)) == -1) 
		{		
			return false;
		}
	}
	return true;
}

function fnValidateEmailID(emailid) 
{
	if (emailid.value !== "") 
	{
		//var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	alert(re.test(String(emailid.value).toLowerCase()));
		if (!filter.test(emailid.value)) 
		{
			alert('Invalid Email Address');
			return false;
		} 
		else 
		{
			return true;
		}
	} 
	else 
	{ 
		return true; 
	}
}


function fnValidatePhoneNos(pno) 
{
	if (pno.value !== "") 
	{
		//var phoneno = /^([2]{1})([5]{1})([4]{1})([7]{1})([0-9]{8})$/;

		var countrycode = "";
		countrycode = pno.value.substring(0, 3);
		var phoneno = "";

		if ( countrycode === "254" ) 
		{
			phoneno = /^([2]{1})([5]{1})([4]{1})([7]{1})([0-9]{8})$/;
		} 
		else 
		{
			phoneno = /^[0-9]+$/;
		}

		if (pno.value.match(phoneno)) 
		{
			return true;
		} 
		else 
		{
			if (pno.name === "custom.AlertsMobileNo") 
			{
				alert("Invalid Mobile Number!!\nFormat must be 2547XXXXXXXXX");
			}
			pno.focus();
			return false;
		}
	}
}

function accountSearcher()
{
	var field 	      = "account";
        var outputNames       = "chrgAcc|chrgAccCrncy|SchmCode|AccountName|Branch";
        var pageTitle         = "List of Account ";
        var scrName           = "ebAlertSearchers.scr";
        var hyperLnkCols      = "1";
        var literalNames      = "Account No| CCY | Scheme Code | Account Name|Branch";
        var isPopulationReq   = "true";
        var inputNameValues   = "cifId|" +cifId +"|"+ "field|" +field;
        var retVal            = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,isPopulationReq);
}

function phoneSearcher()
{
	var field             = "phone";
        var outputNames       = "phNum|CIFID|AccountNo|EmailID";
        var pageTitle         = "List of Registered Mobile Nos";
        var scrName           = "ebAlertSearchers.scr";
        var hyperLnkCols      = "1";
        var literalNames      = "Mobile No|Cust ID|Account No|Email ID";         
        var isPopulationReq   = "true";
        var inputNameValues   = "cifId|" +cifId +"|"+ "field|" +field +"|"+ "accNo|" +accNo;
        var retVal            = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,isPopulationReq);
}

function emailSearcher()
{
        var field             = "email";
        var outputNames       = "MobileNo|CIFID|AccountNo|email";
        var pageTitle         = "List of Registered Mobile Nos";
        var scrName           = "ebAlertSearchers.scr";
        var hyperLnkCols      = "4";
        var literalNames      = "Mobile No|Cust ID|Account No|Email ID";
        var isPopulationReq   = "true";
        var inputNameValues   = "cifId|" +cifId +"|"+ "field|" +field +"|"+ "accNo|" +accNo;
        var retVal            = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,isPopulationReq);
}



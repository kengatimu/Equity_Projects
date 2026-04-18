<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : lasch_details_custom.jsp 
<!--Description         : This jsp is used to populate default values in case of Add Mode
<!--Date                : 31-03-2013
<!--Author              : Sateesh 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HOAACLA
<!--Modification History:
<!--	Version No	Date			         Author 	       	Description
<!--	-------        	----------        		 -----------        	------------------
<!--     0.1	    	31-03-2013	        	 Sateesh	        Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">

function post_ONLOAD() 
{	
	if(mopId == "HOAACLA" )
	{
	
		if(sMode=="A")
		{
			var radioButtons = document.getElementsByName('debitIntFlg');
			radioButtons[0].checked = true;
			radioButtons[1].checked = false;
			radioButtons[0].disabled = true;
			radioButtons[1].disabled = true;
//geo start 356159
			var radioButtons = document.getElementsByName('prtLoanFlg');
            radioButtons[0].checked = false;
			radioButtons[1].checked = true;
            radioButtons[2].checked = false;
			radioButtons[0].disabled = true;
			radioButtons[1].disabled = true;
			radioButtons[2].disabled = true;
		
			{
				document.forms[0].irrRateForBank.disabled = true;
			}
		document.forms[0].repRateCode.disabled = true;
   //geo end  356159
		}
	}
}

//kate restricting operative accounts with SB113/114 scheme codes
function lasch_details_post_ONCHANGE(obj) 
{
		if (obj.id == "operacct")
		{
		
			var dco=document.forms[0].operacct.value;
					
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_acctsbgrp.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//var schmCode =a;
			//alert(a);

			if ((a=="SB113") || (a=="SB114"))
			{
					alert("Do not use SB113 or SB114");
					document.forms[0].operacct.focus();
					return false;
						
			}
			
		}

}


//kate restricting operative accounts with SB113/114

//kim start -(361658)
function lasch_details_pre_TAB_SWITCH(obj)
{
		if(mopId == "HOAACLA" || mopId == "HOAACMLA" || mopId == "HACMLA")
			{
				if (document.forms[0].repMthd.value=="D")
					{
						var radioButtons = document.getElementsByName('hldInOperAcctFlg');
						radioButtons[0].checked = false;
						radioButtons[1].checked = true;
						//mandatorise.
							var retVal = ""
							if ((retVal =  checkMandatoryFields()) == false)
								{
								  return false;
								}
					}
						
								
			}
	if (mopId == "HACMLA" && sMode == "M")
		{
		var dco=document.forms[0].operacct.value;
		var input      = "dco|"+dco;
		var outputNames    = "output|outVal";
		var scrName     =   "b_acctsbgrp.scr";
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
		var a = value;
				if (a == "SB113")
				{
				alert("SB113 cannot be used as the operative Account!!");
				document.forms[0].operacct.focus();
				return false;
				}
				else
				{
				return true;
				}
		}
		
		
	
		if(mopId == "HOAACLA" )
		{        
				if(sMode=="A")
				{
					var loanMnths = document.forms[0].loanPerdMths.value;
					var loanDays = document.forms[0].loanPerdDays.value;
					if (loanMnths == "" && loanDays == "" )
					{
						alert("Loan Period (Months/Days) is Mandatory");
						document.forms[0].loanPerdMths.focus();
						return false;
					}
					if (loanMnths == 0 && loanDays == 0 )
					{
						alert("Loan Period (Months/Days) is Mandatory");
						document.forms[0].loanPerdMths.focus();
						return false;
					}
				
			//kate restricting operative accounts with SB113/114 scheme codes
						var dco=document.forms[0].operacct.value;
								
						var input      = "dco|"+dco;
						var outputNames    = "output|outVal";
						var scrName     =   "b_acctsbgrp.scr";
						var retVal = appFnExecuteScript(input,outputNames,scrName,false);
						var retBuff = retVal.split("|");
						var output = retBuff[0];
						var value = retBuff[1];
						var a = value;
						//var schmCode =a;
						//alert(a);
						

						if ((a=="SB113") || (a=="SB114"))
						{
								alert("Do not use SB113 or SB114");
								document.forms[0].operacct.focus();
								return false;
						}
//kate restricting operative accounts with SB113/114 scheme codes

				//setFieldsToCustomData("loanPerdMths");
				}
		}
}

//kim start -(361658)

function lasch_details_pre_ONCLICK(obj)
{

		if(mopId == "HOAACLA" || mopId == "HOAACMLA" || mopId == "HACMLA")
			{
					if(obj.id=="Submit" || obj.id=="Validate")
					{
						if (document.forms[0].repMthd.value=="D")
						{
							var radioButtons = document.getElementsByName('hldInOperAcctFlg');
							radioButtons[0].checked = false;
							radioButtons[1].checked = true;
							//mandatorise.
							var retVal = ""
							if ((retVal =  checkMandatoryFields()) == false)
								{
								  return false;
								}
						}
						if (mopId == "HACMLA" && sMode == "M")
						{
						var dco=document.forms[0].operacct.value;
						var input      = "dco|"+dco;
						var outputNames    = "output|outVal";
						var scrName     =   "b_acctsbgrp.scr";
						var retVal = appFnExecuteScript(input,outputNames,scrName,false);
						var retBuff = retVal.split("|");
						var output = retBuff[0];
						var value = retBuff[1];
						var a = value;
						//var schmCode =a;
						//alert(a);
								if (a == "SB113")
								{
								alert("SB113 cannot be used as the operative Account!!");
								document.forms[0].operacct.focus();
								return false;
								}
								else
								{
								return true;
								}
						}
		
					}
			}

//kim End -(361658)

		if(mopId == "HOAACLA" )
			{
				if(sMode=="A")
				{
					if(obj.id=="Submit" || obj.id=="Validate")
					{
			
						var loanMnths = document.forms[0].loanPerdMths.value;
						var loanDays = document.forms[0].loanPerdDays.value;
						if (loanMnths == "" && loanDays == "" )
						{
							alert("Loan Period (Months/Days) is Mandatory");
							document.forms[0].loanPerdMths.focus();
							return false;
						}
	
						if (loanMnths == 0 && loanDays == 0 )
						{
							alert("Loan Period (Months/Days) is Mandatory");
							document.forms[0].loanPerdMths.focus();
							return false;
						}
					//kate restricting operative accounts with SB113/114 scheme codes
								var dco=document.forms[0].operacct.value;
										
								var input      = "dco|"+dco;
								var outputNames    = "output|outVal";
								var scrName     =   "b_acctsbgrp.scr";
								var retVal = appFnExecuteScript(input,outputNames,scrName,false);
								var retBuff = retVal.split("|");
								var output = retBuff[0];
								var value = retBuff[1];
								var a = value;
								//var schmCode =a;
								//alert(a);
								

								if ((a=="SB113") || (a=="SB114"))
								{
										alert("Do not use SB113 or SB114");
										document.forms[0].operacct.focus();
										return false;
								}
						
						//kate restricting operative accounts with SB113/114 scheme codes	
						
						//setFieldsToCustomData("loanPerdMths");
					}
				}
			}
}
		
//kim start -(361658)			
			
/**************************************************************************************
Function Name   :   fnCheckMandatoryFields()
Description     :   This function is called to check mandatory fields
**************************************************************************************/

function checkMandatoryFields()
{
       var ObjForm = document.forms[0];

			if(fnIsNull(ObjForm.operacct.value))
			{
					alert("Enter Operative A/c. ID");
					ObjForm.operacct.focus();
					return false;
			}

}


//kim End -(361658)

</script>

<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}


function fnDisableFields(){
	var ObjForm = document.forms[0];


	if (ObjForm.funcCode.value == "A")
	{
		ObjForm.contractId.value="";
		ObjForm.contractId.readOnly = true;
		showImage("search1");
		hideImage("search2");
		ObjForm.acctNum.readOnly = false;
	}
	else
	{
		if (ObjForm.funcCode.value == "")
		{
			hideImage("search2");
		}
		else
		{
		ObjForm.contractId.readOnly=false;
		showImage("search1")
		showImage("search2");
		ObjForm.contractId.value="";
		ObjForm.acctNum.value="";
		ObjForm.acctNum.readOnly=false;
		ObjForm.acctCrncy.value="";
		ObjForm.acctSolId.value="";
		ObjForm.acctName.value="";
		}
	}


}

function fnAcctDetFetch(){
	var ObjForm = document.forms[0];
	var acct = document.forms[0].acctNum.value;

	//modified for cancel searcher
	if(ObjForm.funcCode.value == "I")
	{
		if(acct == "")
		{
			alert("Please enter account Id");
			ObjForm.acctNum.focus();
		}
	}
	else {
	if ((ObjForm.funcCode.value == "M" ) || (ObjForm.funcCode.value == "V" ) || (ObjForm.funcCode.value == "E" ) || (ObjForm.funcCode.value == "Z" ) || (ObjForm.funcCode.value == "X" ) || (ObjForm.funcCode.value == "I"))
		fnFetchContractIdSearcher();
	else
		showAccountIdList(document.forms[0].acctNum,document.forms[0].acctSolId,document.forms[0].acctName,'F',document.forms[0].acctCrncy,'','','');
}
}
function fnFetchContractId()
{
	var ObjForm = document.forms[0];
	var acct = document.forms[0].acctNum.value;
	if(ObjForm.funcCode.value != "")
	{
		if(ObjForm.funcCode.value == "I")
		{
			if(acct == "")
			{
				alert("Please enter account Id");
				ObjForm.acctNum.focus();
			}
			else
			{
					var inputNameValues = "funcCode|" + ObjForm.funcCode.value + "|acctNo|" + acct;
					var outputNameValues = "contractId|acctNo|rcreUser|createdDate|funcCode|solId";
					var scriptName = "accmdp017.scr";
					var listHeading = "Contract ID List";
					var colHeader = "Contract ID|Account Number|Created By|Created Date|Function|SOL ID";
					var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false);
					if(retVal == undefined)
					{
						ObjForm.contractId.value.value = "";
						ObjForm.acctCrncy.value="";
						ObjForm.acctSolId.value="";
						ObjForm.acctName.value="";

					}
					else
					{
						var value = retVal.split("|");
						ObjForm.contractId.value = value[0];
						ObjForm.acctNum.value = value[1];
						fnShowAcctDetails();
					}
			}
		}
		else
		{
			fnFetchContractIdSearcher()
		}
	}
}
function fnFetchContractIdSearcher(){
	var ObjForm = document.forms[0];
	var acct = document.forms[0].acctNum.value;
	var funcCode = ObjForm.funcCode.value;
	if(ObjForm.funcCode.value != "")
	{
				var inputNameValues = "funcCode|" + ObjForm.funcCode.value;
				if(ObjForm.acctNum.value != "")
				{
					inputNameValues = inputNameValues + "|acctNo|" + ObjForm.acctNum.value;
				}
				var outputNameValues = "contractId|acctNo|rcreUser|createdDate|funcCode|solId";
				var scriptName = "accmdp017.scr";
				var listHeading = "Contract ID List";
				var colHeader = "Contract ID|Account Number|Created By|Created Date|Function|SOL ID";
				var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"1",false);
				if(retVal == undefined)
				{
					ObjForm.contractId.value.value = "";
							ObjForm.acctCrncy.value="";
							ObjForm.acctSolId.value="";
							ObjForm.acctName.value="";

				}
				else{
					var value = retVal.split("|");
						ObjForm.contractId.value = value[0];
					 ObjForm.acctNum.value = value[1];

					fnShowAcctDetails();
				}
	}
}

function fnDisableSearcher(){
	var ObjForm = document.forms[0];

if (ObjForm.funcCode.value == "")
	{
	hideImage("search2");
}
}


function fnFetchContract(acctNo){
 	var ObjForm = document.forms[0];
	if(ObjForm.funcCode.value != "")
	{
        var input = "funcCode|" + ObjForm.funcCode.value +"|acctNo|"+acctNo;
        var scrName  = "accmdp017.scr";
    	var output   = "recordCount|contractId|acctNo|rcreUser|createdDate|funcCode|solId|msg";
    	var retVal = appFnExecuteScript(input,output,scrName,false);

        if(retVal == undefined)
        {
	        ObjForm.contractId.value = "";
        }
        else
		{
			var value = retVal.split("|");
			if((ObjForm.funcCode.value != "I") && (value[15] != "") && (value[15] != undefined))
			{
				alert(value[15]);
				ObjForm.acctNum.value = ""
				ObjForm.acctCrncy.value="";
				ObjForm.acctSolId.value="";
				ObjForm.acctName.value="";
				ObjForm.acctNum.focus();
			}
			else
			{
				if (value[1] == 0 )
				{
					if(ObjForm.funcCode.value == "V" )
					{
						alert("Nothing to Verify");
					}
					else
					{
						if (ObjForm.funcCode.value == "I" )
						{
							alert("Contract does not exist");
						}
						else
						{
							if (ObjForm.funcCode.value == "X" )
							{
								alert("No record Exist for Cancellation");
							}
							else
							{
								if (ObjForm.funcCode.value == "M" )
								{
									alert("No record Exist for Modification");
								}
								else
								{
									alert("Contract does not Exist");
								}
							}
						}
					}
					ObjForm.acctNum.value = ""
					ObjForm.acctCrncy.value="";
					ObjForm.acctSolId.value="";
					ObjForm.acctName.value="";
				}
				else
				{

					ObjForm.contractId.value = value[3];
					ObjForm.acctNum.value = value[5];
				}
			}

        }
	}
}

function fetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType){
        if((retVal=fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID"))==false)
        {
                return false;
        }
	if(document.forms[0].funcCode.value!="A")
	{
		fnFetchContract(document.forms[0].acctNum.value);
	}
}


/*************************************************************
 * Function which validates blank entries and submits the form
 * if it is success.
 *************************************************************/
function fnValAndSubmit(btnObj){
	var ObjForm = document.forms[0];
	var funcCode = ObjForm.funcCode.value;
	if(fnValidateData()){

	    if(funcCode != "I"){

			ObjForm.nextPage.value = "accm_det.jsp";
			doSubmit(btnObj.id);
			return;

	    }
		else
			{

			ObjForm.nextPage.value = "accm_det1.jsp";
			doSubmit(btnObj.id);
			return;

	    }
	}
}



//----------modified for displaying the account details next to the account id field---------
function fnShowAcctDetails(){
var ObjForm = document.forms[0];

			var inputNameValues = "acctNum|"+ ObjForm.acctNum.value;
			var scriptName = "accmdp026.scr";
			var outputNames = "acctCrncy|acctSolId|acctName";
			var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
			var ret = new Array();
			ret = retVal.split("|");
			if(ret[1] != "N")
			{
				document.forms[0].acctCrncy.value = ret[3];
				document.forms[0].acctSolId.value = ret[5];
				document.forms[0].acctName.value = ret[7];

			}
			return true;
}


//---------end of modification------------------//
function fnLoadValues(){
	var ObjForm = document.forms[0];
		if (document.forms[0].funcCode.value !="A")
		{
			var inputNameValues = "contractId|"+ ObjForm.contractId.value;
			var scriptName = "accmdp027.scr";
			var outputNames = "acctCrncy|acctSolId|acctName|acctNum";
			var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
			var ret = new Array();
			ret = retVal.split("|");
			if(ret[1] != "N")
			{

				document.forms[0].acctCrncy.value = ret[3];
				document.forms[0].acctSolId.value = ret[5];
				document.forms[0].acctName.value = ret[7];
				document.forms[0].acctNum.value = ret[9]

			}
			return true;
		}
}
function fnClearField()
{
    document.forms[0].reset();
    doSubmit("clear");
    return true;

}

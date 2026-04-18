/*---------------------------------------------------------------------------------------------------------------->
<!--Name                : ctoda_crit_link.js 
<!--Description         : This is the criteria page link file for ctoda menu
<!--Date                : 26-08-2013
<!--Author              :  
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : ctoda
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--	
<!--	0.1					28-08-2013			Priya		Modified for TO:367775
<!--	 0.2				26-08-2013			Kalvin		Modified for TO :361667
<1--	0.3					04-09-2013			Kalvin		modification made to display account details on side
<!---------------------------------------------------------------------------------------------------------------->*/
<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		return true;
}




<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }


<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];
	return true;

}

function app_post_ONLOAD()
{
	document.forms[0].funcCode.focus();
}

function fnShowAccNum()
{
	var objForm = document.forms[0];
	//showAccountIdList(document.forms[0].accNum,'','','F');
	showAccountIdList(objForm.accNum,objForm.acctSolId,objForm.acctName,'F',objForm.acctCrncy,'','','');

}
//changes for Call Id:367775

function fnGetAvailReqId(obj)
{
	
	var funcCode = document.forms[0].funcCode.value
	if( (funcCode == "M") || (funcCode == "V")) 
	{
			var inputNameValues = "accNum|"+ document.forms[0].accNum.value;
			var scriptName = "ctodadp015.scr";
			var outputNames = "availReqId";
			var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
			var ret = new Array();
			ret = retVal.split("|");
			if(ret[1] != "")
			{
				document.forms[0].availReqId.value = ret[1];
			}
			return true;
	}
}
//Changes ends here
function fnFunctionOnchange()
{
	if(document.forms[0].funcCode.value == "A")
	{
		document.forms[0].availReqId.disabled = true;
		document.forms[0].availReqId.value = "";
		hideImage("sLnk3");
		document.forms[0].accNum.disabled = false;
		document.forms[0].accNum.value = "";
		showImage("sLnk2");
	}
	else
	{
		document.forms[0].availReqId.disabled = false;
		document.forms[0].availReqId.value = "";
		showImage("sLnk3");
		document.forms[0].accNum.disabled = false;
		document.forms[0].accNum.value = "";
		showImage("sLnk2");
	}
}

//Changes done by Pankaj
function fnShowAvailmentReqId()
{
	var funcCode = document.forms[0].funcCode.value;
	var accNum = document.forms[0].accNum.value;
	if(funcCode == "I") 
	{
		if(accNum == "")
		{
			alert("Please enter account Id");
			document.forms[0].accNum.focus();
		}
		else
		{
			fnFetchAvailmentSearcher()
		}
	}
	else
	{
			fnFetchAvailmentSearcher()
	}
}

function fnFetchAvailmentSearcher()
{
			var inputNameValues = "funcCode|"+document.forms[0].funcCode.value + "|" + "accNum|"+document.forms[0].accNum.value;
			var outputNames = "availReqId|accNum|grantDate|expiryDate|createdBy|TOD|acctSolId";
			var scrName = "ctodadp001.scr";
			var literalNames = "Availment Request ID|Account Id|Grant Date|Expiry Date|Created By|TOD Status|Sol ID";
			var pageTitle = "Availment Request ID List";
			fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,"1",true);

			if(document.forms[0].availReqId.value != "")
			{
				document.forms[0].accNum.disabled = true;
				//document.forms[0].accNum.focus();
				
				hideImage("sLnk2");
				var objForm = document.forms[0];
				fnShowAcctDetails();
			}
}
//Changes done by Pankaj
function fnCustomFEValidation()
{
	if((document.forms[0].funcCode.value != "A")  &&(document.forms[0].funcCode.value != "I") && (document.forms[0].availReqId.value == ""))
	{
		alert("Availment Request ID is required.");
		document.forms[0].availReqId.focus();
		return false;
	}
	return true;
}

/*function fnAvailmentReqIdOnchange()
{
	document.forms[0].accNum.disabled = false;
	document.forms[0].accNum.value = "";
	showImage("sLnk2");
}
*/

function preEventCall(page,obj,event)
{
	if((obj.id == "Accept") && (event == "ONCLICK"))
	{
		if (!fnCustomFEValidation())
		{
			return false;
		}
	}

	if((obj.id == "Clear") && (event == "ONCLICK"))
	{
		document.forms[0].funcCode.value = "";
		document.forms[0].accNum.value = "";
		document.forms[0].availReqId.value = "";
		doSubmit("Clear");
	}
	return true;
}

function fetchAcctDtls(acctObj, acctName, acctSol, acctCrncy, isError, fType){
        if((retVal=fnCommonFetchAcctDtls(acctObj,acctName,acctSol,acctCrncy,isError,"VALCUSTACCTID"))==false)
        {
                return false;
        }
}

function funcOnchange()
{
	objForm = document.forms[0];
	objForm.acctCrncy.value = "" ;
	objForm.acctSolId.value = "" ;
	objForm.acctName.value = "" ;
}

//-------------CHNAGE FOR TO :361667-----------------------//

/*************************************************************
 * Function which validates blank entries and submits the form
 * if it is success.
 *************************************************************/
function fnValAndSubmit(btnObj){
	var ObjForm = document.forms[0];
	var funcCode = ObjForm.funcCode.value;
	if(fnValidateData()){
	    if(funcCode != "I"){
			ObjForm.nextPage.value = "ctoda_det.jsp";
			doSubmit(btnObj.id);
			return;
				
	    }
		else
			{
			ObjForm.nextPage.value = "ctoda_det1.jsp";
			doSubmit(btnObj.id);
			return;
				
	    }

	    

	}
}
//-------------CHNAGE FOR TO :361667-----------------------//

//-------------CHNAGE FOR fetching account details in criteia page -----------------------//

function fnShowAcctDetails(){
var ObjForm = document.forms[0];

			var inputNameValues = "accNum|"+ ObjForm.accNum.value;
			var scriptName = "ctodadp019.scr";
			var outputNames = "acctCrncy|acctName";
			var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
			var ret = new Array();
			ret = retVal.split("|");
			if(ret[1] != "N")
			{
				document.forms[0].acctCrncy.value = ret[3];
				document.forms[0].acctName.value = ret[5];

			}
			return true;
}



function fnLoadValues(){

	//alert("tada");
	var ObjForm = document.forms[0];
		if (document.forms[0].funcCode.value =="I")
		{
			//alert(ObjForm.contractId.value);
			var inputNameValues = "availReqId|"+ ObjForm.availReqId.value;
			var scriptName = "ctodadp020.scr";
			var outputNames = "acctCrncy|acctSolId|acctName|acctNum";
			var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
			var ret = new Array();
			ret = retVal.split("|");
			if(ret[1] != "N")
			{
				
				document.forms[0].acctCrncy.value = ret[3];
				document.forms[0].acctSolId.value = ret[5];
				document.forms[0].acctName.value = ret[7];
				document.forms[0].accNum.value = ret[9]

			}
			return true;
		}
}

<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
	if (!fnCheckMandatoryFields())
	{
		return false;
	}
	if(fnIsNull(document.forms[0].funcCode.value))
        {
                alert("Function Code cannot be left blank");
                document.forms[0].funcCode.focus();
                return false;
        }
	if(fnIsNull(document.forms[0].preferentialLevel.value))
        {
                alert("Preferential Level cannot be left blank");
                document.forms[0].preferentialLevel.focus();
                return false;
        }
	if(document.forms[0].preferentialLevel.value == "A")
	{
		if(fnIsNull(document.forms[0].acctId.value))
		{
			alert("Account Number cannot be left blank");
			document.forms[0].acctId.focus();
			return false;
		}
	}
	 if(document.forms[0].preferentialLevel.value == "C")
        {
                if(fnIsNull(document.forms[0].custId.value))
                {
                        alert("Customer Number cannot be left blank");
                        document.forms[0].custId.focus();
                        return false;
                }
        }
	if(document.forms[0].preferentialLevel.value == "AG")
        {
                if(fnIsNull(document.forms[0].empId.value))
                {
                        alert("Agreement cannot be left blank");
                        document.forms[0].empId.focus();
                        return false;
                }
        }
	if(document.forms[0].preferentialLevel.value == "S")
        {
                if(fnIsNull(document.forms[0].segmentationLevel.value))
                {
                        alert("Segmentation Class cannot be left blank");
                        document.forms[0].segmentationLevel.focus();
                        return false;
                }
        }
	if(document.forms[0].preferentialLevel.value == "B")
        {
                if(fnIsNull(document.forms[0].customerType.value))
                {
                        alert("Customer Type cannot be left blank");
                        document.forms[0].customerType.focus();
                        return false;
                }
        }
        if(fnIsNull(document.forms[0].evtType.value))
        {
               alert("Event Type must be entered");
               document.forms[0].evtType.focus();
               return false;
        }
        if(fnIsNull(document.forms[0].evtId.value))
        {
               alert("Event ID must be entered");
               document.forms[0].evtId.focus();
               return false;
        }
	return true;
}


function acctIdSearcher()
{
	objForm = document.forms[0];

        if(objForm.funcCode.value != "")
        {
                if(objForm.funcCode.value == "A")
                {
			showAccountIdList(document.forms[0].acctId, document.forms[0].solId, document.forms[0].acctName, "F", document.forms[0].acctCrncyCode);
                }
                else
                {
                        var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|acctId|"+document.forms[0].acctId.value;
                        var outputValues=       "acctId";
                        var scrName     =       "KGP_CPCM_ACCT_AccountIdSearcher.scr";
                        var literalNames=       "Account Number";
                        var pageTitle   =       "List Of Account Number";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
		}
	}
}


function fnPopAccountDet()
{
	clearDescField("acctName","solId","acctCrncyCode");

        if(document.forms[0].acctId.value != "")
        {
		if ((a = fnCommonFetchAcctDtls(document.forms[0].acctId, 'acctName', 'solId', 'acctCrncyCode', true,'VALACCTID')) == false) 
		{
			clearDescField("acctId","acctName","solId","acctCrncyCode");
			document.forms[0].acctId.focus();
			return false;
		}
        }
	return true;
}

function custIdSearcher(obj)
{

        var funcCode = document.forms[0].funcCode.value;

        if(funcCode != "")
        {
                if(funcCode == "A")
                {
                        showCifId(obj,'ctrl','F',document.forms[0].custName);
                }
                else
                {

                        var inputValues =       "funcCode|"+funcCode+"|custId|"+document.forms[0].custId.value;

                        var outputValues=       "custId";

                        var scrName     =       "KGP_CPCM_custIdSearcher.scr";

                        var literalNames=       "Customer Id";

                        var pageTitle   =       "Customer Id List";

                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
                }
        }
}

/*function agreementCodeSearcher()
{
        if(document.forms[0].funcCode.value != "A")
        {
                        var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|agreementCode|"+document.forms[0].agreementCode.value;
                        var outputValues=       "agreementCode";
                        var scrName     =       "KGP_CPCM_ACCT_AgreementCodeSearcher.scr";
                        var literalNames=       "Agreement Code";
                        var pageTitle   =       "List Of Agreement Code";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
        }
}*/


function fnGetEmpList()
{
	var objForm=document.forms[0]
	objForm = document.forms[0];

        if(objForm.funcCode.value != "")
        {
                if(objForm.funcCode.value == "A")
                {
			showEmployerList(objForm.empId,"F",objForm.empName)
		}
                else
                {
			var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|empId|"+document.forms[0].empId.value;
                        var outputValues=       "empId";
                        var scrName     =       "KGP_CPCM_ACCT_AgreementCodeSearcher.scr";
                        var literalNames=       "Agreement Code";
                        var pageTitle   =       "List Of Agreement Code";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
		}
	}
}

function cpcm_crit_post_ONLOAD()
{
	var ObjForm = document.forms[0];

        document.forms[0].funcCode.focus();
	
	if(ObjForm.funcCode.value == "")
        {
                document.getElementById('B').style.display = "none";
                document.getElementById('C').style.display = "none";
                document.getElementById('D').style.display = "none";
		document.getElementById('E').style.display = "none";
       		document.getElementById('F').style.display = "none"; 
	}	
	fnFuncCode(ObjForm.preferentialLevel);	
  /*      if(document.forms[0].funcCode.value == "A")
        {
                hideImage("sLnk4");
        }*/
        return true;
}

function segmentationLevelSearcher()
{
	if(document.forms[0].funcCode.value == "A")
        {
                        var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|segmentationLevel|"+document.forms[0].segmentationLevel.value;
                        var outputValues=       "segmentationLevel|segmentationDesc";
                        var scrName     =       "KGP_CPCM_segmentationLevelSearcher.scr";
                        var literalNames=       "Segmentation Level Code|Segmentation Level Description";
                        var pageTitle   =       "List Of Segmentation Level";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
        }
	else
	{
			var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|segmentationLevel|"+document.forms[0].segmentationLevel.value;
                        var outputValues=       "segmentationLevel";
                        var scrName     =       "KGP_CPCM_segmentationLevelInqSearcher.scr";
                        var literalNames=       "Segmentation Level Code";
                        var pageTitle   =       "List Of Segmentation Level";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
	}
}
/*function functioncode()
{
        agreementcode();
}*/
/*function agreementcode()
{
        if(document.forms[0].funcCode.value == "A")
        {
                hideImage("sLnk4");
        }
        else
        {
                showImage("sLnk4");
        }
        return true;
}*/

function fnFuncCode(obj)
{
	if(obj.value == "A")
        {
                document.getElementById('B').style.display = "block";
                document.getElementById('D').style.display = "none";
                document.getElementById('C').style.display = "none";
		document.getElementById('E').style.display = "none";
       		document.getElementById('F').style.display = "none"; 
	}
        if(obj.value == "C")
         {
                document.getElementById('C').style.display = "block";
                document.getElementById('B').style.display = "none";
                document.getElementById('D').style.display = "none";
		document.getElementById('E').style.display = "none";
		document.getElementById('F').style.display = "none";
        }
         if(obj.value == "AG")
        {
                document.getElementById('D').style.display = "block";
                document.getElementById('C').style.display = "none";
                document.getElementById('B').style.display = "none";
		document.getElementById('E').style.display = "none";
		document.getElementById('F').style.display = "none";
        }
	if(obj.value == "S")
	{
		document.getElementById('F').style.display = "block";
		document.getElementById('C').style.display = "none";
                document.getElementById('B').style.display = "none";
                document.getElementById('E').style.display = "none";
		document.getElementById('D').style.display = "none";
	}
	if(obj.value == "B")
        {
                document.getElementById('E').style.display = "block";
                document.getElementById('B').style.display = "none";
                document.getElementById('C').style.display = "none";
                document.getElementById('D').style.display = "none";
       		document.getElementById('F').style.display = "none";	 
	}

/*	if(obj.value == "B")
        {
		document.getElementById('F').style.display = "none";
            //    document.getElementById('E').style.display = "none";
                document.getElementById('B').style.display = "none";
                document.getElementById('C').style.display = "none";
                document.getElementById('D').style.display = "none";
        }*/
}

function fnShowEvtIDList(a)
{
	var objForm=document.forms[0]
        objForm = document.forms[0];

        if(objForm.funcCode.value != "")
        {
                if(objForm.funcCode.value == "A")
                {
			getEvtIdList(document.forms[0].evtId, "ctrl", "F", "NULL", " ", "Y", document.forms[0].evtType.value);
		}
                else
                {
                        var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|evtId|"+document.forms[0].evtId.value+"|acctId|"+document.forms[0].acctId.value+"|custId|"+document.forms[0].custId.value+"|empId|"+document.forms[0].empId.value+"|customerType|"+document.forms[0].customerType.value+"|segmentationLevel|"+document.forms[0].segmentationLevel.value+"|preferentialLevel|"+document.forms[0].preferentialLevel.value;
                        var outputValues=       "evtId";
                        var scrName     =       "KGP_CPCM_evtIdSearcher.scr";
                        var literalNames=       "Event Id";
                        var pageTitle   =       "List Of Event Id";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
                }
        }
}

function fnShowEventType()
{
	var objForm=document.forms[0]
        objForm = document.forms[0];

        if(objForm.funcCode.value != "")
        {
                if(objForm.funcCode.value == "A")
                {
			showDetailsPageForDynCritSearcher("EVENTTYPES","",":evtType=event_type|:evtTypeDesc=event_type_desc")
		}
                else
                {
                        var inputValues =       "funcCode|"+ document.forms[0].funcCode.value +"|evtType|"+document.forms[0].evtType.value+"|acctId|"+document.forms[0].acctId.value+"|custId|"+document.forms[0].custId.value+"|empId|"+document.forms[0].empId.value+"|customerType|"+document.forms[0].customerType.value+"|segmentationLevel|"+document.forms[0].segmentationLevel.value+"|preferentialLevel|"+document.forms[0].preferentialLevel.value;
                        var outputValues=       "evtType";
                        var scrName     =       "KGP_CPCM_evtTypeSearcher.scr";
                        var literalNames=       "Event Type";
                        var pageTitle   =       "List Of Event Type";
                        var result      =       fnExecuteScriptForList(inputValues,outputValues,scrName,pageTitle,literalNames,"1",true);
                }
        }
}




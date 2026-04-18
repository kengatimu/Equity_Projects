<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}

		//if (!fnValidateMandatoryFields()) {
		//	return false;
	//	}
		if (document.forms[0].funcCode.value == "") 
		{
			alert("Enter Function Code");	
			document.forms[0].funcCode.focus();
			return false;
			
		}
		if (document.forms[0].Level.value == "")
                {
                        alert("Enter Level");
                        document.forms[0].Level.focus();
			return false;

                }
		if (document.forms[0].Level.value == "C")
                {
			if (document.forms[0].cifId.value == "")
			{
				alert("Enter Cif Id");
				document.forms[0].cifId.focus();
				return false;
			}
		}

		if (document.forms[0].Level.value == "A")
                {
			if (document.forms[0].acctNum.value == "")
                        {
                                alert("Enter acctNum");
                                document.forms[0].acctNum.focus();
				return false;
                        }

                }

		if (document.forms[0].Level.value == "AG")
                {
			if (document.forms[0].EmpId.value == "")
                        {
                                alert("Enter Agreement");
                                document.forms[0].EmpId.focus();
                                return false;
                        }

                }


			
		return true;
}

/**************************************************************************************
Function Name   :  Levelchng 
**************************************************************************************/
function  Levelchng(obj)
{
        if (obj.value == "A")
        {
                document.getElementById('acctnotr').style.display = "block";
		document.getElementById('cifIdtr').style.display = "none";
		document.getElementById('agreemnttr').style.display = "none";
        }
        if (obj.value == "C")
        {
                document.getElementById('cifIdtr').style.display = "block";
		document.getElementById('acctnotr').style.display = "none";
		document.getElementById('agreemnttr').style.display = "none";
        }

        if (obj.value == "AG")
        {
                document.getElementById('agreemnttr').style.display = "block";
		document.getElementById('cifIdtr').style.display = "none";
		document.getElementById('acctnotr').style.display = "none";
        }

	return true;


}



/**************************************************************************************
Function Name   :  staffIdSearcher()
**************************************************************************************/

function staffIdSearcher()
{
	
        if(document.forms[0].funcCode.value == "A")
        {
		var outputNames       = "EmpId|EmpName";
		var pageTitle         = "Emp Id List";
		var scrName           = "HCUSTCRD_EMP_Searcher.scr";
		var hyperLnkCols      = "1";
		var literalNames      = "Emp Id|Emp Name";
		var isPopulationReq   = "true";
		var inputNameValues   =  "funcCode|" +document.forms[0].funcCode.value;
		var retVal            = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,isPopulationReq);
                document.forms[0].EmpName.disabled = true;
                document.forms[0].Category.disabled = true;
        }
        else
	{
		fncommensearcher();	
	}
}
function fnEmpchange()
{
        if(document.forms[0].EmpId.value!="")
        {
                var RMID = document.forms[0].EmpId.value;
                var input = "RMID|" + RMID;
                var output = "count";
                var scrName = "HCUSTCRD_EMP_FETCHRMDETAIL.scr";
                var outputNames = "";
                var retVal = appFnExecuteScript(input,output,scrName,false);
                var retBuff = retVal.split("|");
                if (retBuff[0] == "S")
                {
                        document.forms[0].EmpName.value = retBuff[1];
                        document.forms[0].EmpName.disabled = true;
                        document.forms[0].SolID.value = retBuff[3];
                }
		if (retBuff[0] == "F") 
		{

			alert("Invalid Agrement Id");
			document.forms[0].EmpId.value ="";
			document.forms[0].EmpName.value ="";
			document.forms[0].SolID.value ="";
			document.forms[0].EmpId.focus ="";
			return false
		}
        }
}

function fncommenonchange()
{
	
	var funcCode = document.forms[0].funcCode.value;
	var Level    = document.forms[0].Level.value;
        if (Level == "A")
	{
		var acctNum  = document.forms[0].acctNum.value;
		var input = "funcCode|"+funcCode+"|Level|"+Level+"|acctNum|"+acctNum;
	}
	if (Level == "C")
	{
		var cifId    = document.forms[0].cifId.value;
		var input = "funcCode|"+funcCode+"|Level|"+Level+"|cifId|"+cifId;
	}
	if (Level == "AG")
	{
		var EmpId    =document.forms[0].EmpId.value;
                var input = "funcCode|"+funcCode+"|Level|"+Level+"|EmpId|"+EmpId;
	}
	var output = "";
	var scrName = "HCUSTCRT_validation.scr";
	var outputNames = "";
	var retVal = appFnExecuteScript(input,output,scrName,false);
	var retBuff = retVal.split("|");
	if ((retBuff[0] == "F1") || (retBuff[0] == "F3") || (retBuff[0] == "F2"))
	{	
		if (retBuff[0] == "F1")
		{
			document.forms[0].cifId.value ="";
			document.forms[0].cifId.focus();
			return false;
		}
		if (retBuff[0] == "F2")
                {
                        document.forms[0].acctNum.value ="";
                        document.forms[0].acctNum.focus();
			return false;

                }
		if (retBuff[0] == "F3")
                {
                        document.forms[0].EmpId.value ="";
                        document.forms[0].EmpId.focus();
			return false;

                }


	}
}

function fncommensearcher()
{
	var objForm = document.forms[0];
	var funcCode = objForm.funcCode.value;
	var Level    = objForm.Level.value;
        if (objForm.funcCode.value != "")
        {
		if (Level == "A")
		{
			var outputNames       = "acctNum";
			var pageTitle         = "Account No List ";
			var literalNames      = "Account No";
		}
		if (Level == "C")
                {
                        var outputNames       = "cifId";
                        var pageTitle         = "Cif Id List ";
                        var literalNames      = "Cif Id";
                }

		if (Level == "AG")
                {
                        var outputNames       = "EmpId";
                        var pageTitle         = "Agreement List ";
                        var literalNames      = "Agreement";
                }

                        var scrName           = "HCUSTCRD_custom_Searcher.scr";
                        var hyperLnkCols      = "1";
                        var isPopulationReq   = "true";
                        var inputNameValues   = "funcCode|"+funcCode+"|Level|"+Level;
                        var retVal            = fnExecuteScriptForList(inputNameValues,outputNames,scrName,pageTitle,literalNames,hyperLnkCols,isPopulationReq);
        }


}
function showAcct(){
	var objForm = document.forms[0];
	if (objForm.funcCode.value =="A") 
	{
		showAccountIdList(document.forms[0].acctNum,document.forms[0].solId,document.forms[0].acctDesc,'F',document.forms[0].CrncyCode);
		hcustcrg_crit_ONCHANGE1(document.forms[0].acctNum,document.forms[0].acctNum,'acctDesc','solId','CrncyCode',true,'VALACCTID');
	}
	else
	{
		fncommensearcher();	
	}
	
}
function showcustid()
{
	var objForm = document.forms[0];
        if (objForm.funcCode.value =="A")
        {
		showCifId(document.forms[0].cifId,'ctrl','F',document.forms[0].custName)
		hcustcrg_crit_ONCHANGE11(document.forms[0].cifId,'myframe','CIFID','F','cifId','custName');
	}
	else
        {
                fncommensearcher();
        }

}


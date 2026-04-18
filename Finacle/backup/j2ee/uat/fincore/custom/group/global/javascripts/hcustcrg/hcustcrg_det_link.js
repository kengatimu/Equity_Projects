<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		
                if(document.forms[0].startDate.value =="")
                {
                    alert("Enter Start Date");
                    document.forms[0].startDate.focus();
                    return false;
                }

                if(document.forms[0].endDate.value =="")
                {
                    alert("Enter End Date");
                    document.forms[0].endDate.focus();
                    return false;
                }
                if(document.forms[0].chrgAcctId.value =="")
                {
                    alert("Enter Charge A/C No");
                    document.forms[0].chrgAcctId.focus();
                    return false;
                }
		return true;
		
}

function showDrAcct(){
	showAccountIdList(document.forms[0].chrgAcctId,document.forms[0].ssolId,document.forms[0].sacctDesc,'F',document.forms[0].sCrncyCode,'','','','','')
	hsimnt_detBTRF_ONCHANGE1(document.forms[0].chrgAcctId,document.forms[0].chrgAcctId,'sacctDesc','ssolId','sCrncyCode',true,'VALACCTID');
}

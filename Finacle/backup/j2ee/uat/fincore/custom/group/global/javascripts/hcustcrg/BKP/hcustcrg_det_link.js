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
                if(document.forms[0].evtType.value =="")
                {
                    alert("Enter Event Type");
                    document.forms[0].evtType.focus();
                    return false;
                }
                if(document.forms[0].evtId.value =="")
                {
                    alert("Enter Event Id");
                    document.forms[0].evtId.focus();
                    return false;
                }
		return true;
		
}


function fnchangeevntid()
{
	var ObjForm = document.forms[0];
        if (ObjForm.evtType.value =="")
        {
	     alert("Enter Event Type First");
	     ObjForm.evtId.value =""
	     ObjForm.evtType.focus();
	     return false;

	}

}
function fnShowEventType()
{
	showDetailsPageForDynCritSearcher("EVENTTYPES","",":evtType=event_type|:evtTypeDesc=event_type_desc")
}

function fnMntnFormDataControls()
{
}
function fnShowEvtIDList(a)
{
	var ObjForm = document.forms[0];
	if (ObjForm.evtType.value !="") 
	{
		getEvtIdList(document.forms[0].evtId,"ctrl","F","NULL","Y",document.forms[0].evtType.value)
	}
	else
	{
		alert("Enter Event Type First");
		ObjForm.evtType.focus();
		
	}

}

function showDrAcct(){
	showAccountIdList(document.forms[0].chrgAcctId,document.forms[0].ssolId,document.forms[0].sacctDesc,'F',document.forms[0].sCrncyCode,'','','','','')
	hsimnt_detBTRF_ONCHANGE1(document.forms[0].chrgAcctId,document.forms[0].chrgAcctId,'sacctDesc','ssolId','sCrncyCode',true,'VALACCTID');
}

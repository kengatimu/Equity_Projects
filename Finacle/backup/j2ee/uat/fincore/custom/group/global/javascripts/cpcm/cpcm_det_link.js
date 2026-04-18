var AmountCrncyMap = {
	value1: "tmpCrncyCode|N"
};

ObjForm=document.forms[0];
<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
	objForm = document.forms[0];

	if (!fnCheckMandatoryFields())
	{
		return false;
	}

/*
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

*/
	if (fnIsNull(document.forms[0].startDate_ui.value))
        {
                alert("Enter Start Date");
                document.forms[0].startDate_ui.focus();
                return false;
        }
	else
		{
			if(profileId == 43){
				if (funcCode == "A" || funcCode == "M"){
					var _startDate = document.forms[0].startDate_ui.value;				
					var parts = _startDate.split('-');
					var inputDate = new Date(parts[2], parts[1] - 1, parts[0]);
					var today = new Date();
					today.setHours(0, 0, 0, 0);

					if (inputDate < today) {
						//alert("Start Date cannot be less than today.");
						alert("La date de début ne peut pas être inférieure à aujourd'hui.");
						document.forms[0].startDate_ui.value = "";
						document.forms[0].startDate_ui.focus();
						return false;
					} 
				}
			}
		}
	if (fnIsNull(document.forms[0].endDate_ui.value))
        {
                alert("Enter End Date");
                document.forms[0].endDate_ui.focus();
                return false;
        }
	var days = dateDiff(document.forms[0].startDate_ui.value,document.forms[0].endDate_ui.value);
        if(days>0)
        {
                alert("End Date should be greater than Start Date");
                document.forms[0].endDate_ui.focus();
                return false;
        }


	if(fnIsNull(document.forms[0].maxamt.value))
        {
               alert("maximum amount must be entered");
               document.forms[0].maxamt.focus();
               return false;
        }

	if(fnIsNull(document.forms[0].minamt.value))
        {
               alert("minimum amount must be entered");
               document.forms[0].minamt.focus();
               return false;
        }

	if (fnIsNull(document.forms[0].percent.value))
        {
                alert("Persent/Amount must be enter");
                document.forms[0].percent.focus();
                return false;
        }




	if(document.forms[0].percent.value == "P")
	{
		if (fnIsNull(document.forms[0].value2.value))
		{
			alert("Value must be enter");
			document.forms[0].value2.focus();
			return false;
		}
	}
	if(document.forms[0].percent.value == "A")
        {
                if (fnIsNull(document.forms[0].value1.value))
                {
                        alert("Value must be enter");
                        document.forms[0].value1.focus();
                        return false;
                }
        }
//	ObjForm.value1.value = removeCommas( ObjForm.value1.value);
	return true;
}

function cpcm_det_post_ONLOAD()
{
	objForm = document.forms[0];
	document.forms[0].startDate_ui.focus();
	if(ObjForm.percent.value == "")
        {
                document.getElementById('X').style.display = "none";
                document.getElementById('Z').style.display = "none";
        }
	if((funcCode == "V") || (funcCode == "I") || (funcCode == "X"))
        {
                hideImage("sLnk2");
		hideImage("sLnk6");
		hideImage("sLnk3");
		hideImage("sLnk5");	
	}
	functioncode();
}

/*function functioncode(obj)
{
        if(obj.value == "P")
        {
                document.getElementById('B').style.display = "block";
                document.getElementById('C').style.display = "none";
        }
        if(obj.value == "A")
         {
                document.getElementById('C').style.display = "block";
                document.getElementById('B').style.display = "none";
        }
}*/

function functioncode()
{
        if(document.forms[0].percent.value == "P")
        {
                document.getElementById('Z').style.display = "block";
                document.getElementById('X').style.display = "none";
        }
        if(document.forms[0].percent.value == "A")
        {
                document.getElementById('X').style.display = "block";
                document.getElementById('Z').style.display = "none";
        }
}

function cpcm_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpcm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpcm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cpcm_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cpcm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cpcm_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}


function cpcmDet_ONBLUR1(e, f, d, b, a) {
	if((e.value == "99999999999999") || (e.value == "99999999999999.99"))
	{
		var c = "";
		if ((c = newformatAmt(f, d, b, a)) == false) {
			e.value = "";
			e.focus();
			return false
		}
		if(!fnCheckNegativeAmt(e))
		{
			e.value = "";
			e.focus();
			return false
		}
		return (c == undefined) ? true : c
	}
	return true;
}

function cpcmDet_ONCHANGE1(e, f, d, b, a) {
        var c = "";
        if ((c = newformatAmt(f, d, b, a)) == false) {
                e.value = "";
                e.focus();
                return false
        }
        if(!fnCheckNegativeAmt(e))
        {
                e.value = "";
                e.focus();
                return false
        }
        return (c == undefined) ? true : c
}

function cpcmDet_ONCHANGE3(b, c) {
    var a = "";
    if ((a = conditionalCheckPreferredData('0')) == false) {
            b.value = "";
            b.focus();
        return false
    }
    return (a == undefined) ? true : a
}
//
function cpcmDet_ONCHANGE4(b, c) {

}

function conditionalCheckPreferredData(b)
{
        objForm = document.forms[0];
        if (funcCode == "A" || funcCode == "M")
        {
                var a = objForm.value2.value;
                if (!fnIsNull(a))
                {
                        if ((!isNumber(a)) || (a.indexOf(" ") != -1) || (getValInFloat(a)) < 0 || (!fnValidatePercent(a, 6)))
                        {
                                alert(finbranchResArr.get("FAT000167"));
                                objForm.value2.focus();
                                return false
                        }
                }
        }
        return true;
}
function cpcm_det_ONBLUR1(obj,p1,p2)
{
        var retVal = "";
        if (preEventCall('cpcm_det',obj,'ONBLUR') == false) {
                return false;
        }
        if ((retVal = onBlurFormatDate(p1)) == false) {
                p1.value = "";
                p1.focus();
                return false;
        }
        if ((retVal = fnAssignDateOnEnter(p2)) == false) {
                return false;
        }
        if (postEventCall('cpcm_det',obj,'ONBLUR') == false) {
                return false;
        }
        return (retVal == undefined) ? true : retVal;
}
/*
function fnShowEventType()
{
	showDetailsPageForDynCritSearcher("EVENTTYPES","",":evtType=event_type|:evtTypeDesc=event_type_desc")
}
function fnShowEvtIDList(a)
{
	getEvtIdList(document.forms[0].evtId,"ctrl","F","NULL","Y",document.forms[0].evtType.value)
}
*/
	

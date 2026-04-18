<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
		if (!fnSplCharChk())
		{
			return false;
		}
		if(!fnIsNull(document.forms[0].StartDate_ui.value)){
			if(!fnIsNull(document.forms[0].EndDate_ui.value)){
				if(!(fnCompareDates(document.forms[0].StartDate_ui.value,BODDate))){
					var err="Start Date must not be Greater than " + BODDate;
					alert(err);
					document.forms[0].StartDate_ui.focus();
					return false;
				}
				if(!(fnCompareDates(document.forms[0].EndDate_ui.value,BODDate))){
					var err="End Date must not be Greater than " + BODDate;
					alert(err);
					document.forms[0].EndDate_ui.focus();
					return false;
				}
				if(!(fnCompareDates(document.forms[0].StartDate_ui.value,document.forms[0].EndDate_ui.value))){
					alert("End date should be greater than or equal to Start date");
					document.forms[0].EndDate_ui.focus();
					return false;
				}
			}
		}

		if(!fnIsNull(document.forms[0].TranDate_ui.value)){
			if(!(fnCompareDates(document.forms[0].TranDate_ui.value,BODDate))){
					var err="Tran Date must not be Greater than " + BODDate;
					alert(err);
					document.forms[0].TranDate_ui.focus();
					return false;
				}
		}
		
		return true;
}

function fnSplCharChk(){
	var obj=document.forms[0];
	var len=obj.length;
	for(i=0;i<len;i++){
		if(obj[i].type == "text" && (!(obj[i].id=="bacidDesc" || obj[i].id=="setIDDesc" ||obj[i].id=="ccyDesc" || obj[i].id=="TranDate_ui" ||obj[i].id=="StartDate_ui" || obj[i].id=="EndDate_ui"))){
			if(obj[i].style.visibility == 'visible'){
				var value = fnTrim(obj[i].value);
				for(j=0;j<value.length;j++){
					if (((value.charCodeAt(j)>=32) &&(value.charCodeAt(j)<=47))||((value.charCodeAt(j)>=58) &&(value.charCodeAt(j)<=64)) ||
						((value.charCodeAt(j)>=91) &&(value.charCodeAt(j)<=96)) ||((value.charCodeAt(j)>=123) &&(value.charCodeAt(j)<=127))){
						alert("Field must not contain special characters");
						obj[i].focus();
						return false;
					}
				}
			}
		}
	}
	return true;
}

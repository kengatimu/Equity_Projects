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



function chekCnt(obj)
{
	var objForm = document.forms[0];
	var tCash = objForm.totCash.value;
	var cash = objForm.cash.value;
	var diff = parseFloat(tCash) - (-parseFloat(objForm.cash.value));
	var difference = parseFloat(diff).toFixed(numOfDecPoints);
	var retVal = ""
	if((funcCode == "M") || (funcCode == "V"))
	{
		if(parseInt(tCash) != parseInt(-cash))
		{
			if(difference < 0)
			{
				var diffValue = -difference;
				diffValue = parseFloat(diffValue).toFixed(numOfDecPoints);
			}
			else
				var diffValue = difference;

			var retValue = confirm("Cash Account Balance and Total Cash mismatch by "+diffValue+" "+currency);
			alert("Cash Account Balance and Total Cash mismatch by "+diffValue+" "+currency +",Please update Denom Amount as per available physical Cash");
			return false;
		}
	}

//	if ((retVal = fnPopulateControlValues()) == false) {
//		return false;
//	}

	return true;
}


function fnTrim(a_strString)
{
        var cnt;
        len = a_strString.length;
        var str = a_strString;
        begin = -1;
        for(cnt=0;cnt<len;cnt++)
        {
                if (str.charAt(cnt) == " ")
                {
                        begin = cnt;
                }
                else
                break;
        }
        str = str.slice(begin+1,len);
        len = str.length;
        end = len;
        for(cnt=len-1;cnt>=0;cnt--)
        {
                if (str.charAt(cnt) == " ")
                {
                        end = cnt;
                }
                else
                break;
        }
        str = str.slice(0,end);
        return str;
}

function fnRemoveCommas(sNum)
{
        sNew ="";
        var sTemp = sNum.split(",");
        for (i=0;i<sTemp.length;i++)
                if(sTemp[i]!=null) sNew = sNew + sTemp[i];
        return sNew;
}

function fnIsNumeric(str)
{
        //alert("In fun");
	sText = str + "";
	//alert(sText.length);
	for (var i = 0;i < sText.length;i++)
       	{
       	        Char = sText.charAt(i);
		//alert(Char);
		if(Char < '0' || Char > '9' || Char=='.')
			return false;
		else{}
       	}
       	return true;

}

function fnDisableFormControls1(sMode, objForm, iLinksCount){

	var ADD = "A";
	var COPY = "C";
	var MODIFY = "M";
	var VERIFY = "V";
	var INQUIRY = "I";
	var DELETE = "D"
	var UNDELETE = "U";
	var CANCEL = "X";

	if(sMode == VERIFY || sMode == INQUIRY || sMode == DELETE || sMode == UNDELETE || sMode == CANCEL){
		var frmElements = objForm.elements;
		var totalElements = frmElements.length;

		//disable links
		if(Number(iLinksCount) > 0)
			disableHyperLnks(Number(iLinksCount));

		//disable form visible data controls
		for(i = 0; i < totalElements; i++){
			if(( frmElements[i].type == 'text' )||( frmElements[i].type == 'textarea' )) {
				frmElements[i].readOnly = true;
				if(frmElements[i].getAttribute("hotKeyId") == 'LowLimit')
					frmElements[i].readOnly = false;
			} else if (frmElements[i].type == 'select-one'){
				frmElements[i].disabled = true;
			} else if ( frmElements[i].type == 'checkbox' || frmElements[i].type == 'radio') {
				frmElements[i].disabled = true;
				frmElements[i].setAttribute("fds", "Y");
			}
			if(objForm.menuName != undefined)
				objForm.menuName.readOnly = false;
		}
		if( (objForm.Validate != undefined) && (objForm.Validate != null) ){
			objForm.Validate.disabled = true;
		}
		if( (objForm.Clear != undefined) && (objForm.Clear != null) ){
			objForm.Clear.disabled = true;
		}
	}

	if(sMode == INQUIRY){
		if( (objForm.Submit != undefined) && (objForm.Submit != null) ){
			objForm.Submit.disabled = true;
		}
	}
	//if(sMode != ADD && sMode != MODIFY && sMode != COPY)
	//{
	//	if( (objForm.AddNew != undefined) && (objForm.AddNew != null) ){
	//		objForm.AddNew.disabled = true;
	//	}
	//	if( (objForm.AddNewPage != undefined) && (objForm.AddNewPage != null) ){
	//		objForm.AddNewPage.disabled = true;
	//	}
	//}
}

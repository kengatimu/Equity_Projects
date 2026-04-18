<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : laquickdet_custom.jsp 
<!--Description       : This jsp is used to populate default interest rate
<!--Date              : 18-09-2013
<!--Author            : Bharath
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HLAMOD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		18-09-2013		Bharath		Original version
<!--	0.2		24-10-2013		Bharath		Field validation added
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function laquickdet_pre_ONLOAD(obj)
{
	var originDate_ui=document.getElementById("originDate_ui");
	originDate_ui.onchange = function(){onchange_originDate(document.forms[0].originDate_ui)};
}

function laquickdet_post_ONCHANGE(obj)
{
	if(mopId == "HLAMOD")
	{
		if( (obj.id == "crncyCode") || (obj.id == "schmCode") )
		{
			getIntRate();
		}
	}
}

function custom_ONCHANGE(form,obj)
{
	if(mopId == "HLAMOD")
	{
		if( (obj.id == "instalNos") || (obj.id == "loanTenorMonths") || (obj.id == "loanTenorDays") )
		{
			if (isNaN(obj.value))
			{
				alert("Enter a valid integer data");
				obj.focus();
				return false;
			}
		}

		if( (obj.id == "loanTenorMonths") || (obj.id == "loanTenorDays") )
		{
			getIntRate();
		}
	}
}


function laquickdet_post_ONBLUR(obj)
{
	if(mopId == "HLAMOD")
	{
		if( obj.id == "loanAmt" )
		{
			getIntRate();
		}
	}
}

function laquickdet_pre_ONCLICK(obj)
{
	if(mopId == "HLAMOD")
	{
		if( (obj.id == "Compute") && ((document.forms[0].intRate.value) == "") )
		{
			getIntRate();
		}
	}
}

function getIntRate()
{
	if (isNaN(document.forms[0].loanTenorMonths.value))
	{
		alert("Enter a valid integer data");
		document.forms[0].loanTenorMonths.focus();
		return false;
	}

	if (isNaN(document.forms[0].loanTenorDays.value))
	{
		alert("Enter a valid integer data");
		document.forms[0].loanTenorDays.focus();
		return false;
	}

	if (isNaN(document.forms[0].instalNos.value))
	{
		alert("Enter a valid integer data");
		document.forms[0].instalNos.focus();
		return false;
	}

	var objForm = document.forms[0];
	var crncyCode		= objForm.crncyCode.value;
	var schmCode		= objForm.schmCode.value;
	var loanAmt			= objForm.loanAmt.value;
	loanAmt 			= loanAmt.replace(new RegExp(',','g'),"");
	var loanTenorMonths	= objForm.loanTenorMonths.value;
	var originDate		= objForm.originDate_ui.value;

	if ( crncyCode != "" && schmCode != "" && loanAmt != "" && originDate != "" && (loanTenorMonths != "" || loanTenorDays != ""))
	{
		var inputNameValues	= "crncyCode|"+crncyCode+"|schmCode|"+schmCode+"|loanAmt|"+loanAmt+"|loanTenorMonths|"+loanTenorMonths+"|loanTenorDays|"+loanTenorDays+"|originDate|"+originDate;
		var outputNames		= "intRate";
		var scrName		= "lamodmn001.scr";
		var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, true)
	}
}

function onchange_originDate(objDate)
{
    var retVal = "";
    if ((retVal = fnEventFormatDate(objDate)) == false) {
        return false;
    }

	if(mopId == "HLAMOD")
	{
		if( objDate.id == "originDate_ui" )
		{
			getIntRate();
		}
	}
}

function showSchmCodes(schmObj,glObj,sol,listWanted,inPreceedence,schmDesc,SchmType,crncyCode)
{
	var id = '';
	var schm = "";
	var glSubHead="";
	var DummySchmType = "";
	var DummyCrncy = "";

	var sUrl = "";
	var preceedence = 'B';
	var other = "NULL";

	if(SchmType == undefined)
	{
		DummySchmType = "";
	}
	else
	{
		DummySchmType = SchmType;
	}
	if(crncyCode == undefined)
	{
		DummyCrncy = "";
	}
	else
	{
		DummyCrncy = crncyCode.value;
	}

	if (listWanted == "schmcode")
	{
		id = schmObj.id;
		schm = schmObj.value;
		if(glObj != null)
			glSubHead=glObj.value;


		if(glObj != null) other = glObj.id;
	}else
	{
		id = glObj.id;
		if(schmObj != null)
			schm = schmObj.value;
		glSubHead=glObj.value;

		if(schmObj != null) other = schmObj.id;
	}

	if(arguments.length > 4)
    	{
    	    preceedence = inPreceedence;
    	}
	if (arguments.length < 6)
	{

		sUrl = "../arjspmorph/"+applangcode+"/search_scheme.jsp?wReturn="+id+"&wReturnDesc=NULL&solId="+sol+"&listreqd="+listWanted+"&schmCode="+escape(schm)+"&glSubHead="+escape(glSubHead)+"&other="+other+"&preceedence="+preceedence+"&schemeType="+DummySchmType+"&crncy="+DummyCrncy;
	}
	else
	{
		sUrl = "../arjspmorph/"+applangcode+"/search_scheme.jsp?wReturn="+id+"&wReturnDesc="+schmDesc.id+"&solId="+sol+"&listreqd="+listWanted+"&schmCode="+escape(schm)+"&glSubHead="+escape(glSubHead)+"&other="+other+"&preceedence="+preceedence+"&schemeType="+DummySchmType+"&crncy="+DummyCrncy;
	}

	if ("Microsoft Internet Explorer" == browser_name)
	{
		var retVal = popModalWindow(sUrl,"SchemeCodes");
	    if (retVal != null && retVal != undefined)
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

			if (listWanted == "schmcode")
			{
				if(schmObj != null) schmObj.value = liarrBufArray[0];
				if(schmDesc != null) schmDesc.value = liarrBufArray[1];
				if(glObj != null) glObj.value = liarrBufArray[2];
			}else
			{
				if(glObj != null) glObj.value = liarrBufArray[0];
				if(schmDesc != null) schmDesc.value = liarrBufArray[1];
				if(schmObj != null) schmObj.value = liarrBufArray[2];
			}
		}
	}
	else
		popModalWindowMozillaFrame (sUrl,"SchemeCodes");

	if(mopId == "HLAMOD")
	{
		getIntRate();
	}
}

function gfkmResourceOnPrintDate(event){
	/*here keyCode is assigned a false value so that when a Ctrl+<key> combination is pressed the character does not get printed*/
	preventDefaultAction(event);
	event.returnValue = false;
	hkpCtrlKeyDown = false;

	var frm = document.forms[0];
	var sUrl;
	var srcObject = arguments[1];
	var srcName = srcObject.getAttribute('name');
	var srcObjectDataType = srcObject.getAttribute('fdt');


	//Ctrl-X feature for fab menu options not supported.
	//CTRL-X FOR FAB MENU OPTIONS

	/*if (srcObjectDataType == "accountidFAB"){
		alert(finbranchResArr.get("FAT001218"));
		srcObjectDataType.focus();
	}*/


	// CTRL-X IMPLEMENTATION STARTS

	if (srcObjectDataType == "accountid" || srcObjectDataType == "accountidFAB"){
	if (srcObject.value == null || srcObject.value == ""){
		alert(finbranchResArr.get("FAT000131"));
		srcObject.focus();
	}
	else {
		sUrl = "../arjspmorph/INFENG/search_dispIBAN.jsp?wForacid="+srcObject.value;
		var retVal = window.showModalDialog(jsUtil.formatUrl(sUrl),"","dialogWidth:27;dialogHeight:12.25;status=no;toolbar=no;menubar=no;resizable=no");
	}
	}	// end of main if..

	// CTRL-X IMPLEMENTATION ENDS

	//TO-PRINT MAXIMUM-AMT

	if( (srcObject != null && srcObject != undefined) &&
	(srcObject.type == "text" && !srcObject.readOnly && !srcObject.disabled))
	{
    if (srcObjectDataType == "amount") {
        writeMaximumAmount(srcObject);
        return;
    }

       if (srcObjectDataType == "unit") {
            writeMaximumUnit(srcObject);
            return;
    }

	if((srcObjectDataType == null)||(srcObjectDataType == "")||(srcObjectDataType != 'uidate'))
	{
		srcObjectDataType = srcObject.getAttribute('datatype');
		if((srcObjectDataType == null)||(srcObjectDataType == "")||(srcObjectDataType != 'date')) return;
	}
	srcObject.value=fnConvertToUIDate(BODDate);
	fnAssignDateOnEnter(srcObject);
  }
	if(mopId == "HLAMOD")
	{
		getIntRate();
	}
}
</script>


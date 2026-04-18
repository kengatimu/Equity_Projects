<!-------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : ogmgrnteedtl1_custom.jsp
<!--Description         : This is used to make details of guarantee field as mandatory TOL - 362602
<!--Date                : 25-07-2013
<!--Author              : Priyanka
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : OGM
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                 26-07-2013                  Priyanka          Original version
<!--------------------------------------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script type="text/javascript">

function pre_ONLOAD(obj)
{
	if((mopId == "OGM") && (profileId == 50))
	{
		getFieldsFromCustomData("paysysId","TenderRefName","ProcuringEntityName","TenderType","DeadLineDate","TenderRefNum");
		var pEntity = document.forms[0].customData.value;
		alert(pEntity);
	}
	return true;
}


function ogmgrnteedtl1_post_ONLOAD(obj)
	
{

	document.forms[0].applcRules.value="URDG";
	
	if (('A' == funcCode) && (profileId != 50))
	{
		fnSetPropertyValue(objForm.effDate,"disabled",true);
		hideImage('sLnk3');
	}

	if(mopId == "OGM")
	{
	if((funcCode=="A") && (profileId == 50))
		{
			var pEntity = document.forms[0].customData.value;
			var pEntitytemp=pEntity.split("|");
			var EName =pEntitytemp[6];
			alert("EName:" + EName);
			var ddate =pEntitytemp[8];
				alert("EHEHE");
			var ENameG1a =pEntitytemp[0];
				alert("ENameG1a:" + ENameG1a);
			var ENameG2a =pEntitytemp[1];
				alert("ENameG2a:" + ENameG2a);
			var ENameG3a =pEntitytemp[2];
				alert("ENameG3a:" + ENameG3a);
			var ENameG4a =pEntitytemp[3];
				alert("ENameG4a:" + ENameG4a);
			var ENameG5a =pEntitytemp[4];
				alert("ENameG5a:" + ENameG5a);
			var ENameG6a =pEntitytemp[5];
				alert("ENameG6a:" + ENameG6a);
			var ENameG7a =pEntitytemp[6];
				alert("ENameG7a:" + ENameG7a);
			var ENameG8a =pEntitytemp[7];
				alert("ENameG8a:" + ENameG8a);
			var ENameG9a =pEntitytemp[8];
				alert("ENameG9a:" + ENameG9a);
			var ENameG10a =pEntitytemp[9];
				alert("ENameG10a:" + ENameG10a);
			var ENameG11a =pEntitytemp[10];
				alert("ENameG11a:" + ENameG11a);

			document.forms[0].purpOfGrntee.value=ENameG6a.substring(0 ,40);
			alert("Deadline date is:" + ddate);
			alert(ddate);
			//document.forms[0].expDate.value=ddate;
			//alert("USE EXPIRY DATE AS:"ddate);
		}

	}
}

function ogmgrnteedtl1_pre_ONCLICK(obj)
{
	if (obj.id == "Submit" || obj.id == "Validate" || obj.id == "NextPage")
        {
		var retVal = ""
                if ((retVal =  valMandatoryFields()) == false) {
                            return false;
                }
	}
}	

function ogmgrnteedtl1_pre_TAB_SWITCH()
{
	var retVal = ""
        if ((retVal =  valMandatoryFields()) == false) {
                    return false;
        }
}

function valMandatoryFields()
{
	var ObjForm = document.forms[0];
        if(fnIsNull(ObjForm.purpOfGrntee.value))
        {
                alert("Enter the Purpose of Guarantee");
                ObjForm.purpOfGrntee.focus();
                return false;
        }

}
	

</script>

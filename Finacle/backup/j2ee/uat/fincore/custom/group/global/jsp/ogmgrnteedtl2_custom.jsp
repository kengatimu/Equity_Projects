<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ogmgrnteedtl2_custom.jsp
<!--Description       : This jsp is created for checking whether details of guarantee is entered when PaySysId is not entered.
<!--Date              : 24-07-2013
<!--Author            : Priya K
<!--Called By         : None 
<!--Calling jsp       : None
<!--Menu Option       : OGM.
<!--Modification History:
<!--    Version No.      Date           Author                     Description
<!--    ---------        ----------     ---------------            --------------------
<!--	0.1		24-07-2013	Priya K			      Original Version
<!--	0.2		24-07-2013	Priyansh		Modified Version TO Id:358668
<!--    0.3		01-08-2013      Priyanka		Modified to add mandate field TO - 362602
<!--    0.4		13-08-2013      Priyansh		Modified TO - 367345
<!---------------------------------------------------------------------------------------------------------------->

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript">
function pre_ONLOAD(obj)
{
	if((mopId == "OGM"))
	{
		getFieldsFromCustomData("paysysId","funcCode","TenderRefName","ProcuringEntityName","TenderType","DeadLineDate","TenderRefNum");
		var payId = document.forms[0].customData.value;
		alert(payId);
	}
	return true;
}
function ogmgrnteedtl2_pre_ONCLICK(obj)
{
	if(obj.id == "Submit")
	{
		var payId = document.forms[0].customData.value;
		var n = payId.split("|");
		var paySysId = "";
		var len = n.length;
		for ( var i=0;i<len;i++)
		{
			if(n[i] == "ogmgendtl")
			{
				 paySysId = n[i+1];
			}
		}

		if ( paySysId == "" )
		{
			var grntDet = document.forms[0].dtlsOfGrnt.value;
			if( grntDet == "")
			{
				alert("Enter the Details of Guarantee.");
				return false;
			}
		}
	}
	//TO - 362602
	if(obj.id == "Submit" || obj.id == "PrevPage")
	{
		var ObjForm = document.forms[0];
        	if(fnIsNull(ObjForm.dtlsOfGrnt.value))
        	{
                	alert("Enter the Details of Guarantee.");
                	return false;
        	}
	}
		
	return true;
}

function ogmgrnteedtl2_pre_TAB_SWITCH()
{
	var ObjForm = document.forms[0];
        if(fnIsNull(ObjForm.dtlsOfGrnt.value))
        {
                alert("Enter the Details of Guarantee.");
                return false;
        }

}

function ogmgrnteedtl2_post_ONLOAD()
{
	if(mopId == "OGM")
	{
		document.getElementById('sLnk11').style.visibility = "hidden";
		document.getElementById('sLnk13').style.visibility = "hidden";

		var payId = document.forms[0].customData.value;
		var payIdtemp=payId.split("|");
		var funcCode =payIdtemp[1];

		 if(funcCode == "V")
		{
			 alert("am in")
		showImage('sLnk12');
		}

		if((funcCode=="A") && (profileId == 50))
		{
			var payId = document.forms[0].customData.value;
			var pEntitytemp=payId.split("|");
			var contractno =pEntitytemp[10];
			var serialno =pEntitytemp[7];
			alert(contractno);
			alert(serialno);
			if (contractno!="")
			{
				document.forms[0].dtlsOfGrnt.value=contractno;
			}
			if (serialno!="")
			{
				document.forms[0].dtlsOfGrnt2.value=serialno;
			}
			
		}

	}
}
</script>




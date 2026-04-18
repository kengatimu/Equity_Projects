<script>
function pre_ONLOAD(obj)
{
	if((mopId == "OGM") && (profileId == 50))
	{
		getFieldsFromCustomData("paysysId","TenderRefName","ProcuringEntityName","TenderType","DeadLineDate","TenderRefNum","TenderLotNumber");
		var pEntity = document.forms[0].customData.value;
		alert(pEntity);
	}
	return true;
}

function ogmpartydtl_pre_TAB_SWITCH(obj)
{
        if(mopId == "OGM" )
        {
                if((funcCode="A") || (funcCode=="M"))
                {
                                if (document.forms[0].benSector.value == "")
                                {
                                        alert("PLEASE ENTER SECTOR CODE");
                                        document.forms[0].benSector.focus();
                                        return false;
                                }

                }
	}
}

function ogmpartydtl_pre_ONCLICK(obj)
{
        if(mopId == "OGM" )
        {
		if((obj.id == "Submit") || (obj.id == "Validate"))
        	{

                	if(funcCode=="A" || funcCode=="M")
                	{
                                if (document.forms[0].benSector.value == "")
                                {
                                        alert("PLEASE ENTER SECTOR CODE");
                                        document.forms[0].benSector.focus();
                                        return false;
                                }

                	}
		}
	}
}

function ogmpartydtl_post_ONLOAD()
{
	if(mopId == "OGM")
	{
	alert("thanks");
	if((funcCode=="A") && (profileId == 50))
      {
			var pEntity = document.forms[0].customData.value;
			alert(document.forms[0].customData.value);
			var pEntitytemp=pEntity.split("|");
			var EName1 =pEntitytemp[0];
			var EName2 =pEntitytemp[1];
			var EName =pEntitytemp[7];
			var lot =pEntitytemp[11];

			alert(EName);
			alert(EName1);
			alert(EName2);
			alert("am in");
			//alert(lot);

			var EName1a =pEntitytemp[0];
				alert("EName1a:" + EName1a);
			var EName2a =pEntitytemp[1];
				alert("EName2a:" + EName2a);
			var EName3a =pEntitytemp[2];
				alert("EName3a:" + EName3a);
			var EName4a =pEntitytemp[3];
				alert("EName4a:" + EName4a);
			var EName5a =pEntitytemp[4];
				alert("EName5a:" + EName5a);
			var EName6a =pEntitytemp[5];
				alert("EName6a:" + EName6a);
			var EName7a =pEntitytemp[6];
				alert("EName7a:" + EName7a);
			var EName8a =pEntitytemp[7];
				alert("EName8a:" + EName8a);
			var EName9a =pEntitytemp[8];
				alert("EName9a:" + EName9a);

			var EName10a =pEntitytemp[9];
				alert("EName10a:" + EName10a);

			var EName11a =pEntitytemp[10];
				alert("EName11a:" + EName11a);
				
			document.forms[0].benName.value=EName7a;
			document.forms[0].benAddr3.value=EName11a;

		}

	}
}
</script>

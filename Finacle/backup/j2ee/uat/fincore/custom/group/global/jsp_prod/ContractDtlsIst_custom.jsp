<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : ContractDtlsIst_custom.jsp
<!--Description         : This is used to get assetValue from oifaFinanceApp_custom.jsp.
<!--Date                : 08-08-2013 
<!--Author              : Kim
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : 
<!--Modification History:
<!--    Version No.         Date                       Author             Description
<!--    -------             ----------                 -----------        ------------------
<!--    0.1                 08-08-2013                 Kim                Original version
<!--    0.2                 23-08-2013                 jane               Modified version
<!--    
<!--    0.3		    26-09-2013		       Mohan		  Added Builder A/c Mandatory check
<!--    0.4          2-10-2013             kate           

<!---------------------------------------------------------------------------------------------------------------->
<script>

function pre_ONLOAD(obj)
{
	getFieldsFromCustomData("schmCode","assetValue");
	
}


function post_ONLOAD(obj)
	{
	
		//alert(document.forms[0].customData.value);
		var custData = document.forms[0].customData.value;
        var custDataVal = custData.split("|");
		var schm = custDataVal[1];
		var dco = custDataVal[3];
	   //alert(schm);
	   //alert(dco);

if (mopId == "OIFA" || mopId == "AIFA" )
	    {
	if (schm == "isist")
	    {
		
		document.forms[0].costOfConstruction.value = dco;

		 }
		}
	}
		

function fnOnButtonClick(btnObj)
{
        objForm.actionCode.value = btnObj.id;
        if(btnObj.id == "Cancel")
        {
           /* fix for the ticket 601312*/
                if((sMode != 'V') && (sMode != 'X') && (sMode != 'I'))
                if(!confirm(finbranchResArr.get("FAT000925")))  return false;
                objForm.actionCode.value="Cancel";
                formReset(objForm);
                doSubmit(btnObj.id);
        }
        else
        {
                if((sMode != 'V') && (sMode != 'X'))
                if(!fnValidateForm(btnObj.id)) return false;

		var builderAcct = objForm.builderAcct.value;
		if(fnIsNull(builderAcct)){
			alert("Enter the Builder A/c. ID");
			objForm.builderAcct.focus();
			return false;
		}
                doSubmit(btnObj.id);
        }

}


</script>

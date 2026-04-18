<!--	This is getting executing on click of submit and validate button -->
var recIndex="";
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


<!-- This function is added for formatting a particular MRH Row -->

function fnValidateForm(obj){
	objForm = document.forms[0];

	return true;

}

function onClickImage(obj)
{
	recIndex = (obj.id).substring(3);
}

function searchItems(anchorId)
{

	var aId=anchorId;


	var ObjForm = document.forms[0];
	var	dco=MISCode;		

	var inputNameValues = "dco|"+dco;
	var outputNameValues = "RefCode|ItemCode|ItemDescription|UnitPrice";
	var scriptName = "cmerchalist.scr";
	var listHeading = "List Of Supplies";
	var colHeader = "Mis Code|Item Code|Item Description|Unit Price";
	var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"2",false);
   
 
	if(retVal != undefined )
	{
		var retBuff = retVal.split("|");
        
		if ( aId =="searchItem_0")
		{
		 

		ObjForm.ReferCode0.value = retBuff[0];
		ObjForm.ItemCode0.value = retBuff[1];
		ObjForm.ItemDescription0.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice0.value = retBuff[3];
		}

		if ( aId =="searchItem_1")
		{

		ObjForm.ReferCode1.value = retBuff[0];
		ObjForm.ItemCode1.value = retBuff[1];
		ObjForm.ItemDescription1.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice1.value = retBuff[3];
		}
		if ( aId =="searchItem_2")
		{

		ObjForm.ReferCode2.value = retBuff[0];
		ObjForm.ItemCode2.value = retBuff[1];
		ObjForm.ItemDescription2.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice2.value = retBuff[3];
		}
		if ( aId =="searchItem_3")
		{

		ObjForm.ReferCode3.value = retBuff[0];
		ObjForm.ItemCode3.value = retBuff[1];
		ObjForm.ItemDescription3.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice3.value = retBuff[3];
		}
				if ( aId =="searchItem_4")
		{

		ObjForm.ReferCode4.value = retBuff[0];
		ObjForm.ItemCode4.value = retBuff[1];
		ObjForm.ItemDescription4.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice4.value = retBuff[3];
		}
		if ( aId =="searchItem_5")
		{

		ObjForm.ReferCode5.value = retBuff[0];
		ObjForm.ItemCode5.value = retBuff[1];
		ObjForm.ItemDescription5.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice5.value = retBuff[3];
		}
		if ( aId =="searchItem_6")
		{

		ObjForm.ReferCode6.value = retBuff[0];
		ObjForm.ItemCode6.value = retBuff[1];
		ObjForm.ItemDescription6.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice6.value = retBuff[3];
		}
		if ( aId =="searchItem_7")
		{

		ObjForm.ReferCode7.value = retBuff[0];
		ObjForm.ItemCode7.value = retBuff[1];
		ObjForm.ItemDescription7.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice7.value = retBuff[3];
		}
		if ( aId =="searchItem_8")
		{

		ObjForm.ReferCode8.value = retBuff[0];
		ObjForm.ItemCode8.value = retBuff[1];
		ObjForm.ItemDescription8.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice8.value = retBuff[3];
		}
		if ( aId =="searchItem_9")
		{

		ObjForm.ReferCode9.value = retBuff[0];
		ObjForm.ItemCode9.value = retBuff[1];
		ObjForm.ItemDescription9.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice9.value = retBuff[3];
		}
		if ( aId =="searchItem_10")
		{

		ObjForm.ReferCode10.value = retBuff[0];
		ObjForm.ItemCode10.value = retBuff[1];
		ObjForm.ItemDescription10.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice10.value = retBuff[3];
		}
		if ( aId =="searchItem_11")
		{

		ObjForm.ReferCode11.value = retBuff[0];
		ObjForm.ItemCode11.value = retBuff[1];
		ObjForm.ItemDescription11.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice11.value = retBuff[3];
		}
		if ( aId =="searchItem_12")
		{

		ObjForm.ReferCode12.value = retBuff[0];
		ObjForm.ItemCode12.value = retBuff[1];
		ObjForm.ItemDescription12.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice12.value = retBuff[3];
		}
		if ( aId =="searchItem_13")
		{

		ObjForm.ReferCode13.value = retBuff[0];
		ObjForm.ItemCode13.value = retBuff[1];
		ObjForm.ItemDescription13.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice13.value = retBuff[3];
		}
		if ( aId =="searchItem_14")
		{

		ObjForm.ReferCode14.value = retBuff[0];
		ObjForm.ItemCode14.value = retBuff[1];
		ObjForm.ItemDescription14.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice14.value = retBuff[3];
		}
		if ( aId =="searchItem_15")
		{

		ObjForm.ReferCode15.value = retBuff[0];
		ObjForm.ItemCode15.value = retBuff[1];
		ObjForm.ItemDescription15.value = retBuff[2].replace(/[^a-z0-9]/gmi, " ");
		ObjForm.UnitPrice15.value = retBuff[3];
		}

		
		
	}

    
}

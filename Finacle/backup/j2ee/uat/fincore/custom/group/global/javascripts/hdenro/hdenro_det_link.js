function showSetList(obj,ctrlOrMorph,inPreceedence,objDesc)
{
        var set = "";
        var sUrl = "";
        var preceedence = 'B';
 var url = "../arjspmorph/";
       //var url = "../Renderer/arjspmorph/";

    if(arguments.length > 1)
    {
                if(ctrlOrMorph == 'morph')
                url = "../../";
        }

        obj.value = obj.value.replace(/\'/,"\"");

    if(arguments.length > 2)
    {
        preceedence = inPreceedence;
    }

        if(obj != null)
        {
                set = obj.id;
        }

        if (arguments.length <4)
        {
                sUrl = url +applangcode+"/get_set_list.jsp?SetId="+escape(obj.value)+"&wReturn="+set+"&wReturnDesc=NULL&preceedence="+preceedence;
        }else
        {
                sUrl = url +applangcode+"/get_set_list.jsp?SetId="+escape(obj.value)+"&wReturn="+set+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence;
        }

        var retVal = popModalWindow(sUrl,"SetIdList");

        if ("Microsoft Internet Explorer" == browser_name){
			 if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");

                obj.value = liarrBufArray[0];
                        if(objDesc != null) objDesc.value = liarrBufArray[1];
                }
    }
}


function tellerList()
{
	


var inputNameValues = "pageNumber|1|pageSize|10|funcCode|"+document.forms[0].tellerId.value;
    var outputNames = "Tier_Code|baseint";
//    var scrName = "hcivsmdp008.scr";
    var scrName = "denrodp012.scr"
    var title   = "Teller Id";
    var literalNames= "Teller Id|SOLID";
	
	var retVal=fnExecuteScriptForList(inputNameValues,outputNames,scrName,title,literalNames,"1",false);
	
	if(retVal != undefined)
	{
		var sValues = retVal.split("|");
		document.forms[0].tellerId.value = sValues[0];
	}

}


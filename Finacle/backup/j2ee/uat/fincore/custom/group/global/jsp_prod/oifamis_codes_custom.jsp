<!--------------------------------------------------------------------------------------------------------------->
<!--Name                : oifamis_codes_custom.jsp
<!--Description         : This is done as part of fix for TO 358434 .
<!--Date                : 30-07-2013 
<!--Author              : Anik
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : OIFA 
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            30-07-2013                       Anik          Original version- Created for TO  358434
<!--	0.2				14-08-2013							Priya K		Modified for TO-358434	
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript"> 
function showRefCode(obj1,refType,delFlgInd,inPreceedence,obj2)
{
        var refCode = obj1.value;
        var url = "";
        var sUrl = "";
        var preceedence = 'B';

        if(refCode == null) refCode = '';

        if(arguments.length > 3)
    	{
        	preceedence = inPreceedence;
    	}

        if (arguments.length < 5)
        {
                url = "../arjspmorph/"+applangcode+"/get_ref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc=NULL&refType="+encodeURIComponent(unescape(refType))+"&refCode="+encodeURIComponent(unescape(refCode))+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
        }else
        {
url = "../arjspmorph/"+applangcode+"/get_ref_code.jsp?wReturn="+ obj1.id +"&wReturnDesc="+ obj2.id +"&refType="+encodeURIComponent(unescape(refType))+"&refCode="+encodeURIComponent(unescape(refCode))+"&delFlgInd="+delFlgInd+"&preceedence="+preceedence;
        }
        var retVal = popModalWindow(url,"RefCodeList");
        if ("Microsoft Internet Explorer" == browser_name)
        {
            if (retVal != null && retVal != undefined )
                {
                        //Array for taking the values after splitting the value with "|".
                        var liarrBufArray = retVal.split("|");

                		obj1.value = liarrBufArray[0];
                        if(obj2 != null) obj2.value = liarrBufArray[1];
                }
    	}
	if(mopId == "OIFA") {
			autopop();
		}
	
}

//Modified for TO:358434
function oifamis_codes_pre_ONCLICK(obj)
{
	if((obj.id == 'Submit') || (obj.id == 'Validate'))
	{
		if(mopId == "OIFA")
		{
				var schmCode = document.forms[0].customData.value;
				var schmCodeTemp =schmCode.split("|");
				var schmCode =schmCodeTemp[1];
				var indusType = document.forms[0].indType.value;
				var purpAdv = document.forms[0].purpAdv.value;
				var occCode = document.forms[0].occCode.value;
				var natAdv = document.forms[0].natAdv.value;
				var misFreeText1 = document.forms[0].misFreeText1.value;
				var misFreeText2 = document.forms[0].misFreeText2.value;
				 misFreeText2 = misFreeText2.toUpperCase();
				var misFreeText3 = document.forms[0].misFreeText3.value;	
				var freeCode6 = document.forms[0].freeCode6.value;
				var freeCode9 = document.forms[0].freeCode9.value;
				var misFreeText11 = document.forms[0].misFreeText11.value;
				var misFreeText12 = document.forms[0].misFreeText12.value;
				var misFreeText15 = document.forms[0].misFreeText15.value;
				var borrCtgry = document.forms[0].borrCtgry.value;
				var modeAdv = document.forms[0].modeAdv.value;
				var typeAdv = document.forms[0].typeAdv.value;
							 
				var inputNameValues = "borrCtgry" + "|" + borrCtgry.toUpperCase()+ "|"+ "schmCode" + "|" + schmCode.toUpperCase() + "|"+ "indusType" + "|" + indusType.toUpperCase() +"|"+ "purpAdv" + "|" + purpAdv +"|"+ "natAdv" + "|" + natAdv + "|"+"misFreeText1" + "|"+misFreeText1 + "|"+ "misFreeText2" +"|"+ misFreeText2.toUpperCase() + "|"+"misFreeText3" +"|"+ misFreeText3 + "|"+"freeCode6" + "|"+freeCode6 + "|"+"freeCode9" + "|"+freeCode9 +"|"+ "misFreeText11" +"|"+ misFreeText11 + "|"+"misFreeText12" + "|" + misFreeText12 + "|" + "misFreeText15" + "|" + misFreeText15 + "|" + "typeAdv" + "|" + typeAdv;
				var scrName = "s_miscvalmn001.scr";
				var outputNames = "retMsg,sucFail,fieldId";
				var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				
				if(ret[3] == "N")
				{
					alertMsg = ret[1];
					var focusId = ret[5];
					alert(alertMsg);
					document.getElementById(focusId).focus();
					return false;
				}
				if(indusType == "" )
				{
					alert("Enter The Industry Type");
					 document.forms[0].indType.focus(); 
					return false;
				}
					
				if(occCode == ""){
					alert("Occupation Code field is mandatory");
					 document.forms[0].occCode.focus(); 
					return false;
				}
				if(modeAdv == "" ){
					alert("Mode Of Advance field is mandatory");
					 document.forms[0].modeAdv.focus(); 
					return false;
				}
			}
		
		return true;
	}
}

function oifamis_codes_pre_TAB_SWITCH(obj){
	if(obj.id != 'Back' && obj.id != 'expand'  && obj.id != 'sLnk10')
	{
		if(mopId == "OIFA")
		{
				var schmCode = document.forms[0].customData.value;
				var schmCodeTemp =schmCode.split("|");
				var schmCode =schmCodeTemp[1];
				var indusType = document.forms[0].indType.value;
				var occCode = document.forms[0].occCode.value;
				var purpAdv = document.forms[0].purpAdv.value;
				var natAdv = document.forms[0].natAdv.value;
				var misFreeText1 = document.forms[0].misFreeText1.value;
				var misFreeText2 = document.forms[0].misFreeText2.value;
				 misFreeText2 = misFreeText2.toUpperCase();
				var misFreeText3 = document.forms[0].misFreeText3.value;	
				var freeCode6 = document.forms[0].freeCode6.value;
				var freeCode9 = document.forms[0].freeCode9.value;
				var misFreeText11 = document.forms[0].misFreeText11.value;
				var misFreeText12 = document.forms[0].misFreeText12.value;
				var misFreeText15 = document.forms[0].misFreeText15.value;
				var borrCtgry = document.forms[0].borrCtgry.value;
				var modeAdv = document.forms[0].modeAdv.value;
				var typeAdv = document.forms[0].typeAdv.value;
							 
				var inputNameValues = "borrCtgry" + "|" + borrCtgry.toUpperCase()+ "|"+ "schmCode" + "|" + schmCode.toUpperCase() + "|"+ "indusType" + "|" + indusType.toUpperCase() +"|"+ "purpAdv" + "|" + purpAdv +"|"+ "natAdv" + "|" + natAdv + "|"+"misFreeText1" + "|"+misFreeText1 + "|"+ "misFreeText2" +"|"+ misFreeText2.toUpperCase() + "|"+"misFreeText3" +"|"+ misFreeText3 + "|"+"freeCode6" + "|"+freeCode6 + "|"+"freeCode9" + "|"+freeCode9 +"|"+ "misFreeText11" +"|"+ misFreeText11 + "|"+"misFreeText12" + "|" + misFreeText12 + "|" + "misFreeText15" + "|" + misFreeText15 + "|" + "typeAdv" + "|" + typeAdv;
				var scrName = "s_miscvalmn001.scr";
				var outputNames = "retMsg,sucFail,fieldId";
				var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				
				if(ret[3] == "N")
				{
					alertMsg = ret[1];
					var focusId = ret[5];
					alert(alertMsg);
					document.getElementById(focusId).focus();
					return false;
				}
				if(indusType == "" )
				{
					alert("Enter The Industry Type");
					 document.forms[0].indType.focus(); 
					return false;
				}
					
				if(occCode == ""){
					alert("Occupation Code field is mandatory");
					 document.forms[0].occCode.focus(); 
					return false;
				}
				if(modeAdv == "" ){
					alert("Mode Of Advance field is mandatory");
					 document.forms[0].modeAdv.focus(); 
					return false;
				}
			
		}
		return true;
	}
}
//Modification ends

function oifamis_codes_pre_ONCHANGE(obj){
	var indusType = document.forms[0].indType.value;	
	if(indusType  != ""){

		var inputNameValues = "indType" + "|" + indusType.toUpperCase() ;
		var scrName = "acctopnvalmn008.scr";
		var outputNames = "paramV1,paramV2";
		var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
	}
	if(ret[0] == "err"){
	alert("No Record Found in RCT for this industry type");
			return true;
	}

	document.forms[0].subSectCode.value = ret[3];
	document.forms[0].sectCode.value = ret[1];
	
}



function autopop(){
        var indusType = document.forms[0].indType.value;
        if(indusType  != ""){
                     
			var inputNameValues = "indType" + "|" + indusType.toUpperCase();
			var scrName = "acctopnvalmn008.scr";
			var outputNames = "paramV1,paramV2";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
            		document.forms[0].subSectCode.value = ret[3];
			document.forms[0].sectCode.value = ret[1];
		}
}

function post_ONLOAD(){
		if(mopId == "OIFA" ){
		document.forms[0].freeCode3.value = ".";
		document.getElementById('freeCode3').readOnly=true;
		document.getElementById('freeCode3').disabled=true;
		}
		document.getElementById('subSectCode').disabled=true;
		document.getElementById('sectCode').disabled=true;
        	document.getElementById('sLnk1').style.visibility = "hidden";
		document.getElementById('sLnk2').style.visibility = "hidden";
		
}
function pre_ONLOAD(obj)
{
	if(mopId == "OIFA")
	{
		toggleFreeText('expand');
		getFieldsFromCustomData("schmCode");
		var schmCode = document.forms[0].customData.value;
	}
	return true;
}
</script>

<!------------------------------------------------------------------------------------------------------------------->
<!--Name                : mis_codes_custom.jsp
<!--Description         : This is used to protect some fields like sectCode,subSectCode,freeCode3 .
<!--Date                : 17-03-2013 
<!--Author              : Manoj
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOAACLA
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            17-03-2013                       Manoj          Original version
<!--     0.2			05-07-2013						 Kalvin			Modified For CR no : 356839
<!--																	change made in in line number 50
<!--	   0.3			19-07-2013						Vijaya V		Modified for TOL  361782
<!--	   0.4			22-07-2013						Vijaya V		Modified for TOL  362033- industry type code validation not for V,I,X modes
<!--	   0.5			02-08-2013						Anik Soni		Modified for TOL  358434
<!--		0.6			14-08-2013						Priya K			Modified for 358434
<!--	0.7				06-09-2013						Bharath			Modified for new porting items
<!-------------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/session.js"> </script>
<script type="text/javascript"> 
var bankId="";
document.write('<input type="hidden" name="glSubHeadCode" id="glSubHeadCode"  value="">');
document.write('<input type="hidden" name="schmCode" id="schmCode"  value="">');
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
		/*-------------Chnage made in below line no :50 for CR no :356839----------------------------------------------*/
		/*----------Code added : inclusion of MopID OAACPS to get sector and subsector code populated -----------------*/
		
		if(bankId=="56")
		{
			if(mopId == "HOAACLA") {
				autopop();
			}
		}
		else
		{
			if(mopId == "HOAACSB" || mopId == "HOAACCL" ||mopId == "HOAACCC" || mopId == "HOAACCA" || mopId == "HOAACOD" || mopId == "HOAACLA" || mopId == "OAACPS" ) {
				autopop();
			}
		}
		//end of code change
}
//Modified for 358434
function mis_codes_pre_ONCLICK(obj)
{
	if((obj.id == 'Submit') || (obj.id == 'Validate'))
	{
			var inputNameValues    = "";
			var outputNames        = "bankId";
			var scrName            = "oclgirptmn003.scr";
			var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			bankId = ret[1];
			
			if(bankId == "54")
				{
					 var guarCovCode = document.forms[0].guarCovCode.value;
					if(mopId == "HOAACSB" || mopId == "HOAACCA")
					{
						if(guarCovCode == "" )
						{
							alert("Please Enter The Tertiary RMID");
						 	document.forms[0].guarCovCode.focus(); 
							return false;
						}
					}
				}
		if((mopId == "HOAACLA") || (mopId == "HOAACCL"))
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
				misFreeText3 = misFreeText3.toUpperCase();
				var misFreeText4 = document.forms[0].misFreeText4.value;
				misFreeText4 = misFreeText4.toUpperCase();
				var misFreeText5 = document.forms[0].misFreeText5.value;
				misFreeText5 = misFreeText5.toUpperCase();
				var misFreeText6 = document.forms[0].misFreeText6.value;
				misFreeText6 = misFreeText6.toUpperCase();
				var misFreeText7 = document.forms[0].misFreeText7.value;
				misFreeText7 = misFreeText7.toUpperCase();
				var misFreeText8 = document.forms[0].misFreeText8.value;
				misFreeText8 = misFreeText8.toUpperCase();
				
				var freeCode1 = document.forms[0].freeCode1.value;
				var freeCode2 = document.forms[0].freeCode2.value;
				var freeCode3 = document.forms[0].freeCode3.value;
				var freeCode4 = document.forms[0].freeCode4.value;
				var freeCode5 = document.forms[0].freeCode5.value;
				var freeCode6 = document.forms[0].freeCode6.value;
				var freeCode7 = document.forms[0].freeCode7.value;
				var freeCode8 = document.forms[0].freeCode8.value;
				var freeCode9 = document.forms[0].freeCode9.value;
				var freeCode10 = document.forms[0].freeCode10.value;
				
				var misFreeText9 = document.forms[0].misFreeText9.value;
				misFreeText9 = misFreeText9.toUpperCase();
				var misFreeText10 = document.forms[0].misFreeText10.value;
				var misFreeText11 = document.forms[0].misFreeText11.value;
				var misFreeText12 = document.forms[0].misFreeText12.value;
				var misFreeText13 = document.forms[0].misFreeText13.value;
				 misFreeText13 = misFreeText13.toUpperCase();
				var misFreeText14 = document.forms[0].misFreeText14.value;
				 misFreeText14 = misFreeText14.toUpperCase();
				var misFreeText15 = document.forms[0].misFreeText15.value;
				var borrCtgry = document.forms[0].borrCtgry.value;
				var modeAdv = document.forms[0].modeAdv.value;
				var typeAdv = document.forms[0].typeAdv.value;
							 
				var inputNameValues = "borrCtgry" + "|" + borrCtgry.toUpperCase()+ "|"+ "schmCode" + "|" + schmCode.toUpperCase() + "|"+ "indusType" + "|" + indusType.toUpperCase() +"|"+ "purpAdv" + "|" + purpAdv +"|"+ "natAdv" + "|" + natAdv + "|"+"misFreeText1" + "|"+misFreeText1 + "|"+ "misFreeText2" +"|"+ misFreeText2.toUpperCase() + "|"+"misFreeText3" +"|"+ misFreeText3 + "|"+"misFreeText4" +"|"+ misFreeText4 + "|"+"misFreeText5" +"|"+ misFreeText5 + "|"+"misFreeText6" +"|"+ misFreeText6 + "|"+"misFreeText7" +"|"+ misFreeText7 + "|"+"misFreeText8" +"|"+ misFreeText8 + "|"+"freeCode1" + "|"+freeCode1 + "|"+"freeCode2" + "|"+freeCode2 + "|"+"freeCode3" + "|"+freeCode3 + "|"+"freeCode4" + "|"+freeCode4 + "|"+"freeCode5" + "|"+freeCode5+ "|"+"freeCode6" + "|"+freeCode6 + "|"+"freeCode7" + "|"+freeCode7 + "|"+"freeCode8" + "|"+freeCode8 + "|"+"freeCode9" + "|"+freeCode9 + "|"+"freeCode10" + "|"+freeCode10 +"|"+ "misFreeText9" +"|"+ misFreeText9 +"|"+ "misFreeText10" +"|"+ misFreeText10 +"|"+ "misFreeText11" +"|"+ misFreeText11 + "|"+"misFreeText12" + "|" + misFreeText12 +"|"+"misFreeText13" + "|" + misFreeText13 + "|" +"misFreeText14" + "|" + misFreeText14 + "|" + "misFreeText15" + "|" + misFreeText15 + "|" + "typeAdv" + "|" + typeAdv;
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
				if(bankId=="56")
				{
					if(mopId == "HOAACLA") 
					{
						if(indusType == "" )
						{
							alert("Enter The Industry Type");
							 document.forms[0].indType.focus(); 
							return false;
						}
					}
				}					
				else
				{
					if(indusType == "" )
					{
						alert("Enter The Industry Type");
						 document.forms[0].indType.focus(); 
						return false;
					}
				}
				if(occCode == ""){
					alert("Occupation Code field is mandatory");
					 document.forms[0].occCode.focus(); 
					return false;
				}
				if(modeAdv == "" )
					{
					alert("Mode Of Advance field is mandatory");
					 document.forms[0].modeAdv.focus(); 
					return false;
				}
		}
		return fretxtMndGlSub();


	}
}

function mis_codes_pre_TAB_SWITCH(obj){
	if(obj.id != 'Back' && obj.id != 'expand'  && obj.id != 'sLnk10' && mopId != "HOAACTD")
	{
		var inputNameValues    = "";
		var outputNames        = "bankId";
		var scrName            = "oclgirptmn003.scr";
		var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		bankId = ret[1];
			
		if(bankId == "54")
				{
					 var guarCovCode = document.forms[0].guarCovCode.value;
					if(mopId == "HOAACSB" || mopId == "HOAACCA")
					{
						if(guarCovCode == "" )

						{
							alert("Please Enter The Tertiary RMID");
						 	document.forms[0].guarCovCode.focus(); 
							return false;
						}
					}

				}
		if((mopId == "HOAACLA") || (mopId == "HOAACCL"))
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
				misFreeText3 = misFreeText3.toUpperCase();
				var misFreeText4 = document.forms[0].misFreeText4.value;
				misFreeText4 = misFreeText4.toUpperCase();
				var misFreeText5 = document.forms[0].misFreeText5.value;
				misFreeText5 = misFreeText5.toUpperCase();
				var misFreeText6 = document.forms[0].misFreeText6.value;
				misFreeText6 = misFreeText6.toUpperCase();
				var misFreeText7 = document.forms[0].misFreeText7.value;
				misFreeText7 = misFreeText7.toUpperCase();
				var misFreeText8 = document.forms[0].misFreeText8.value;
				misFreeText8 = misFreeText8.toUpperCase();
				
				var freeCode1 = document.forms[0].freeCode1.value;
				var freeCode2 = document.forms[0].freeCode2.value;
				var freeCode3 = document.forms[0].freeCode3.value;
				var freeCode4 = document.forms[0].freeCode4.value;
				var freeCode5 = document.forms[0].freeCode5.value;
				var freeCode6 = document.forms[0].freeCode6.value;
				var freeCode7 = document.forms[0].freeCode7.value;
				var freeCode8 = document.forms[0].freeCode8.value;
				var freeCode9 = document.forms[0].freeCode9.value;
				var freeCode10 = document.forms[0].freeCode10.value;
				var misFreeText9 = document.forms[0].misFreeText9.value;
				 misFreeText9 = misFreeText9.toUpperCase();
				var misFreeText10 = document.forms[0].misFreeText10.value
				var misFreeText11 = document.forms[0].misFreeText11.value;
				var misFreeText12 = document.forms[0].misFreeText12.value;
				var misFreeText13 = document.forms[0].misFreeText13.value
				 misFreeText13 = misFreeText13.toUpperCase();
				var misFreeText14 = document.forms[0].misFreeText14.value;
				 misFreeText14 = misFreeText14.toUpperCase();
				var misFreeText15 = document.forms[0].misFreeText15.value;
				var borrCtgry = document.forms[0].borrCtgry.value;
				var modeAdv = document.forms[0].modeAdv.value;
				var typeAdv = document.forms[0].typeAdv.value;
							 
				var inputNameValues = "borrCtgry" + "|" + borrCtgry.toUpperCase()+ "|"+ "schmCode" + "|" + schmCode.toUpperCase() + "|"+ "indusType" + "|" + indusType.toUpperCase() +"|"+ "purpAdv" + "|" + purpAdv +"|"+ "natAdv" + "|" + natAdv + "|"+"misFreeText1" + "|"+misFreeText1 + "|"+ "misFreeText2" +"|"+ misFreeText2.toUpperCase() + "|"+"misFreeText3" +"|"+ misFreeText3 + "|"+"misFreeText4" +"|"+ misFreeText4 + "|"+"misFreeText5" +"|"+ misFreeText5 + "|"+"misFreeText6" +"|"+ misFreeText6 + "|"+"misFreeText7" +"|"+ misFreeText7 + "|"+"misFreeText8" +"|"+ misFreeText8 + "|"+"freeCode1" + "|"+freeCode1 + "|"+"freeCode2" + "|"+freeCode2 + "|"+"freeCode3" + "|"+freeCode3 + "|"+"freeCode4" + "|"+freeCode4 + "|"+"freeCode5" + "|"+freeCode5+ "|"+"freeCode6" + "|"+freeCode6 + "|"+"freeCode7" + "|"+freeCode7 + "|"+"freeCode8" + "|"+freeCode8 + "|"+"freeCode9" + "|"+freeCode9 + "|"+"freeCode10" + "|"+freeCode10 +"|"+ "misFreeText9" +"|"+ misFreeText9 +"|"+ "misFreeText10" +"|"+ misFreeText10 +"|"+ "misFreeText11" +"|"+ misFreeText11 + "|"+"misFreeText12" + "|" + misFreeText12 +"|"+"misFreeText13" + "|" + misFreeText13 + "|" +"misFreeText14" + "|" + misFreeText14 + "|" + "misFreeText15" + "|" + misFreeText15 + "|" + "typeAdv" + "|" + typeAdv;
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
				
				if(bankId=="56")
				{
					if(mopId == "HOAACLA") 
					{
						if(indusType == "" )
						{
							alert("Enter The Industry Type");
							 document.forms[0].indType.focus(); 
							return false;
						}
					}
				}
				else
				{
					if(indusType == "" )
					{
						alert("Enter The Industry Type");
						 document.forms[0].indType.focus(); 
						return false;
					}
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
			return fretxtMndGlSub();
	}
}
//Modification ends here

function mis_codes_pre_ONCHANGE(obj){
	if(bankId=="56")
	{
		if(mopId == "HOAACLA") 
		{
			if(obj.id == "indType" ){
				var indusType = document.forms[0].indType.value;

				if(indusType == "" && sMode != "I" && sMode != "V" && sMode != "X" ){

					alert("Enter The Industry Type");
					document.forms[0].indType.focus();
					return false;
				}

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
		}
	}
	else
	{
		if(obj.id == "indType" && mopId != "HOAACTD"){
			var indusType = document.forms[0].indType.value;

			if(indusType == "" && sMode != "I" && sMode != "V" && sMode != "X" ){

				alert("Enter The Industry Type");
				document.forms[0].indType.focus();
				return false;
			}

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
	}
}



function autopop(){
        var indusType = document.forms[0].indType.value;
        if(indusType  != ""){
                     
			var inputNameValues = "indType" + "|" + indusType.toUpperCase() ;
			var scrName = "acctopnvalmn008.scr";
			var outputNames = "paramV1,paramV2";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
            		document.forms[0].subSectCode.value = ret[3];
			document.forms[0].sectCode.value = ret[1];
		}
}

function post_ONLOAD(){
	if(mopId == "HOAACSB" || mopId == "HOAACCA" )
		{
			var inputNameValues    = "";
			var outputNames        = "bankId";
			var scrName            = "oclgirptmn003.scr";
			var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			bankId = ret[1];
			
			if(bankId == "54")
			{
					var guarCov = document.forms[0].guarCovCode.value;
					
					if(mopId == "HOAACSB" || mopId == "HOAACCA"){
						if(guarCovCode != "")
						{
							var inputNameValues = "guarCovCode|"+guarCov;
							var outputNames = "msgInfo";
							var scrName="tertiary.scr";
							retVal=appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        						retVal = retVal.split("|");
							var msgAlert=retVal[1];
							alert(msgAlert);
						}

					}
			}
		}
		
		if(mopId == "HOAACLA" && (schmCode != "LA501" || schmCode != "LA550" || schmCode != "LA558")){
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
	var inputNameValues    = "";
    var outputNames        = "bankId";
    var scrName            = "oclgirptmn003.scr";
    var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
    var ret = retVal.split("|");
    bankId = ret[1];
	
	if(bankId=="54")
		{
		if(mopId == "HOAACSB" || mopId == "HOAACCA" || mopId == "HACM" || mopId == "HACLI" || mopId == "HACI" || mopId == "HACLINQ" || mopId == "HCRV")
		{
			document.getElementById('guarCovCode').parentNode.previousSibling.innerHTML =  document.getElementById('guarCovCode').parentNode.previousSibling.innerHTML.replace("Guarantee Cover Code","Tertiary RMID");
		}
		}
	if((mopId == "HOAACLA") || (mopId == "HOAACCL"))
	{
		toggleFreeText('expand');
		getFieldsFromCustomData("schmCode");
		var schmCode = document.forms[0].customData.value;
	
	}
	return true;
}

function fretxtMndGlSub()
{
	if((mopId == "HOAACSB") || (mopId == "HOAACCA"))
	{
		var obj = document.forms[0];
		var glSubHeadCode = (getSValue("glSubHeadCode")!="null"?getSValue("glSubHeadCode"):"");
		var schmCode = getSValue("schmCode");
		if ( schmCode != "" )
		{
			var inputNameValues = "schmCode|" + schmCode.toUpperCase() + "|glSubHeadCode|" + glSubHeadCode.toUpperCase() + "|freeText10|" + obj.misFreeText10.value ;
			var scrName = "acctopnvalmn003.scr"
			var outputNames = "paramV1,paramV2";
			var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			if(ret[1] == "F")
			{
				alertMsg = ret[3];
				var focusId = ret[5];
				alert(alertMsg);
				document.getElementById(focusId).focus();
				return false;
			}
		}
	}
	return true;
}
</script>
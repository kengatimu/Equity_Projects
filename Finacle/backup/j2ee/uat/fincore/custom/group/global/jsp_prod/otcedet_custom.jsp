<!--------------------------------------------------------------------------------------------------------------->
<!--description         : Memo pad.
<!--Date                : 22-05-2013
<!--Author              : Chandrasekhar
<!--Called By           : None
<!--Calling  Jsp        : None
<!--Menu Option         : HOTCE
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            22-05-2013           Chandrasekhar           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="formatAcct.jsp" %>

<script language="javascript">
function showAccountIdList(acctObj,solId,acctName,inPreceedence,currDesc,defCrncyCode,defSchemeCode,defSchemeType,defSolId,defCifId,defGLSubHead,defOwnership,defShortName,defAcctLbl,defPartn,doAutoSubmit,defMasterAcctId,searchLang,targetBankId,dispBankIDFldFlg)
{

/* Function modified to add input parameters to default in Account Id Criteria.
If these are not supplied, the list would continue working as before.
Note that the arguments.length <5 should be modified with care. */

	var sUrl = "";
	var preceedence = 'B';
	var strCrncyCode = "";
	var strSchemeCode = "";
	var strSchemeType = "";
	var strSolId = "";
	var strCifId = "";
	var strsearchLang = "";
	var strGLSubHead = "";
	var strOwnership = "";
	var strShortName = "";
	var strAcctLbl = "";
	var strPartn = "";
	var strSubmit = "";
	var strTargetBankId = "";
	var acctIdVal = "";

/* Assigning default if passed */
	if(acctObj.value != ""){acctIdVal = acctObj.value;}
	if(targetBankId  == undefined){ strTargetBankId  = "";} else {strTargetBankId  = targetBankId.value;}
    if(defCrncyCode  == undefined){ strCrncyCode  = "";} else { strCrncyCode  = defCrncyCode;}
    if(defSchemeCode == undefined){ strSchemeCode = "";} else { strSchemeCode = defSchemeCode;}
    if(defSchemeType == undefined){ strSchemeType = "";} else { strSchemeType = defSchemeType;}
    if(defSolId      == undefined){ strSolId      = "";} else { strSolId      = defSolId;}
    if(defCifId     == undefined){ strCifId     = "";} else { strCifId     = defCifId;}
    if(searchLang     == undefined){ strsearchLang = "";} else { strsearchLang = searchLang;}
    if(defGLSubHead  == undefined){ strGLSubHead  = "";} else { strGLSubHead  = defGLSubHead;}
    if(defOwnership  == undefined){ strOwnership  = "";} else { strOwnership  = defOwnership;}
//    if(defShortName  != undefined){ strShortName  = defShortName;}
    if(defAcctLbl    == undefined){ strAcctLbl  = "";} else { strAcctLbl  = defAcctLbl;}
    if(defPartn      == undefined){ strPartn = "";} else { strPartn = defPartn;}
	if(defMasterAcctId  == undefined){ strMasterAcctId  = "";} else { strMasterAcctId  = defMasterAcctId;}
	if(doAutoSubmit  == undefined){ strSubmit = "";} else { strSubmit = doAutoSubmit;}

    if(arguments.length > 3)
    {
        preceedence = inPreceedence;
    }
	if (arguments.length < 5)
	{
		sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy=NULL&wReturnSol=NULL&wReturnAcct=NULL&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+strAcctLbl+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
	}else
	{
		sUrl = "../arjspmorph/"+applangcode+"/search_accountId.jsp?wReturn="+acctObj.id+"&wReturnCrncy="+currDesc.id+"&wReturnSol="+solId.id+"&wReturnAcct="+acctName.id+"&preceedence="+preceedence+"&defCrncyCode="+escape(strCrncyCode)+"&defSchemeCode="+escape(strSchemeCode)+"&defSchemeType="+escape(strSchemeType)+"&defSolId="+escape(strSolId)+"&defCifId="+escape(strCifId)+"&searchLang="+escape(strsearchLang)+"&defGLSubHead="+escape(strGLSubHead)+"&defOwnership="+strOwnership+"&defShortName="+escape(strShortName)+"&defAcctLbl="+escape(strAcctLbl)+"&defPartn="+strPartn+"&defMasterAcctId="+escape(strMasterAcctId)+"&targetBankId="+escape(strTargetBankId)+"&dispBankIDFldFlg="+dispBankIDFldFlg+"&defacctIdVal="+acctIdVal+"&doAutoSubmit="+strSubmit;
	}

		if ("Microsoft Internet Explorer" == browser_name) 
		{
		     var retVal = popModalWindow(sUrl,""); 
	    	if (retVal != null && retVal != undefined )
		{
			//Array for taking the values after splitting the value with "|".
			var liarrBufArray = retVal.split("|");

	        if(acctObj!=null) acctObj.value = liarrBufArray[0];
			if(currDesc!=null) currDesc.value = liarrBufArray[1];
			if(solId!=null) solId.value = liarrBufArray[2];
			if(acctName!=null) acctName.value = liarrBufArray[3];
		}
		}else{ 
                            popModalWindowMozillaFrame(sUrl,""); 
                } 

	memoPad();
}
function memoPad(){
        var acctNumber = document.forms[0].custAcctId.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}


function otcedet_post_ONLOAD(obj) {
	//modified by Anuya to populate Suspense account details
	if (mopId == "HOTCE") {
		if (funcCode == "A") {
			var susAcct = document.forms[0].suspenseAcct.value;
			if (susAcct != "") {
				//fnCommonFetchAcctDtls(suspenseAcct,suspenseAcct,suspenseAcctName,suspenseAcctSol,suspenseAcctCrncy,true,"VALACCTID");

				var inputNameValues = "acctNum|" + susAcct;
				var outputNames = "";
				var scrName = "popOTCEAcctDetails.scr";

				var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret1 = retVal.split("|");

				if (retVal != "") {
					document.forms[0].suspenseAcctName.value = ret1[5];
					document.forms[0].suspenseAcctCrncy.value = ret1[3];
					document.forms[0].suspenseAcctSol.value = ret1[1];
				}

			}
		}
	}
	//End of modification
}

//Watchlist START Edwin.zico
function otcedet_pre_ONCHANGE(obj) 
{
	if (profileId == 54)
    {
		if (obj.id == "custAcctId") 
		{
			//alert("amin");
			if (obj.value != "") 
			{
				//alert("amin2");
				//if(document.forms[0].drAcct.value != "")
				//{
					//alert("ami3");
					var acct = document.forms[0].custAcctId.value;
					var inputNameValues =  "acctNum|"+ acct;
					var outputNames     = "";
					var scrName         = "ebCamlAccVal.scr";
					var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					if(a == "Y")
					{
						alert("AML check!!! customer is watchlisted");
						return true;
					}
					else
					{
						if(a == "B")
						{
							alert("AML check!!! customer is Blacklisted");
							document.forms[0].custAcctId.focus();
							clearDescField("custAcctId");
							return false;
						}
					}
				//}
			}
		}
	}
}	

//Watchlist END Edwin.zico
</script>

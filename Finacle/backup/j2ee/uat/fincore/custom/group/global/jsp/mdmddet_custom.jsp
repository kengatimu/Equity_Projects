<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : mdmddet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 12-08-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : MDMD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		12-08-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function showCifId(obj,ctrlOrMorph,inPreceedence,objDesc,delFlg,srchCrit,targetBankId)
{
        if (arguments.length >6 && targetBankId != null && targetBankId != "")
        {
                /* !!!! WARNING!!!!!!
                Control will come inside this if block only for calls from a/c id searcher
                criteria hence hardcoding the icfg's output value into "AcctCifId"
                which is the page variable on a/c id searcher criteria page */

                showDynCritSearcher("CIF","cif_id=:AcctCifId|targetBankId=:targetBankId",":AcctCifId=cif_id");
        }else
        {
                var cifObj = "";
                var sUrl = "";
                var preceedence = 'B';
                var url = "../arjspmorph/";
        		var cif = obj.value;
        if(arguments.length > 1)
        {
		if(ctrlOrMorph == 'morph')
		url = "../";
        }

        if(browser_name != "Microsoft Internet Explorer")
        {
                url = "../arjspmorph/";
        }
        if(arguments.length > 2)
        {
                preceedence = inPreceedence;
        }

        if(obj != null) cifObj = obj.id;

	if (arguments.length < 4)
	{
		sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+cifObj+"&wReturnDesc=NULL&preceedence="+preceedence;
	}else
	{
		sUrl = url + applangcode+"/get_cust_id.jsp?wReturn="+cifObj+"&wReturnDesc="+objDesc.id+"&preceedence="+preceedence+"&delFlg="+delFlg+"&cif="+escape(cif)+"&srchCrit="+srchCrit;
	}

	// var retVal = popModalWindow(sUrl,"CifId");
	if ("Microsoft Internet Explorer" == browser_name)
	{
		var retVal = popModalWindowVar(sUrl,"CifId",55,35,55,32);
	if (retVal != null && retVal != undefined )
	{
		//Array for taking the values after splitting the value with "|".
		var liarrBufArray = retVal.split("|");

		obj.value = liarrBufArray[0];
		if(objDesc != null) objDesc.value = liarrBufArray[1];
	}
        }else{
		popModalWindowMozillaFrame(sUrl,"CifId");
             }
        }
	validateCif();
}

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

		validateAcct();

}

function mdmddet_ONCHANGE(obj)
{
	if(mopId == "MDMD")
	{
	
		if(obj.id=="cifId")
			{
				validateCif();
	
			}
		if(obj.id=="acIdRemit")
			{
				validateAcct();
	
			}
	}
}

function mdmddet_ONBLUR(obj)
{
	if(mopId == "MDMD")
	{
	
		if(obj.id=="cifId")
			{
				validateCif();
	
			}
		if(obj.id=="acIdRemit")
			{
				validateAcct();
	
			}
	}
}

function mdmddet_ONCLICK(obj)
{
	if(mopId == "MDMD")
	{
	
		if(obj.id=="cifId")
			{
				validateCif();
	
			}
		if(obj.id=="acIdRemit")
			{
				validateAcct();
	
			}
	}
}

function validateCif()
{
				var dco = document.forms[0].cifId.value;
				//alert(dco);
				var input      = "dco|"+dco;
				var outputNames    = "name|outVal";
				var outputNames    = "address1|outVal";
				var outputNames    = "address2|outVal";
				var scrName     =   "b_mdmdetails.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var name = value;
				//alert(name);

				var retBuff = retVal.split("|");
				var output = retBuff[2];
				var value = retBuff[3];
				var address1 = value;
				//alert(address1);

				var retBuff = retVal.split("|");
				var output = retBuff[4];
				var value = retBuff[5];
				var address2 = value;
				//alert(address2);


				document.forms[0].dealerName.value=name;
				document.forms[0].addressLine1.value=address1;
				document.forms[0].addressLine2.value=address2;
				
				
				
}
function validateAcct()
{
	var dco = document.forms[0].acIdRemit.value;
				//alert(dco);
				var input      = "dco|"+dco;
				var outputNames    = "name|outVal";
				var outputNames    = "address1|outVal";
				var outputNames    = "address2|outVal";
				var outputNames    = "city|outVal";
				var outputNames    = "state|outVal";
				var outputNames    = "country|outVal";
				var scrName     =   "b_mdmforacidet.scr";
				var retVal = appFnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var output = retBuff[0];
				var value = retBuff[1];
				var name = value;
				//alert(name);

				var retBuff = retVal.split("|");
				var output = retBuff[2];
				var value = retBuff[3];
				var address1 = value;
				//alert(address1);

				var retBuff = retVal.split("|");
				var output = retBuff[4];
				var value = retBuff[5];
				var address2 = value;
				//alert(address2);

				var retBuff = retVal.split("|");
				var output = retBuff[6];
				var value = retBuff[7];
				var city = value;
				//alert(city);

				var retBuff = retVal.split("|");
				var output = retBuff[8];
				var value = retBuff[9];
				var state = value;
				//alert(state);

				var retBuff = retVal.split("|");
				var output = retBuff[10];
				var value = retBuff[11];
				var country = value;
				//alert(country);
				
				document.forms[0].bnkRemit.value=name;
				document.forms[0].addressRemit1.value=address1;
				document.forms[0].addressRemit2.value=address2;
				document.forms[0].cityRemit.value=city;
				document.forms[0].stateRemit.value=state;
				document.forms[0].countryRemit.value=country;
}
</script>


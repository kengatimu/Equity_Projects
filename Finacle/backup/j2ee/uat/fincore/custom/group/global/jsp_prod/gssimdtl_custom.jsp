<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :   gssimdtl_custom.jsp 
<!--    Description       :   This jsp is for memo pad 
<!--    Date              :   23-05-2013
<!--    Author            :   Shishira 
<!--    Called By         :   None
<!--    Calling script    :   formatacctdp001.scr 
<!--    Menu Option       :   HSIM.
<!--    Modification History:
<!--    Sl No.             Date                    Author               Description
<!--   ---------         ----------      ------------------     ---------------------
<!--     0.1            30-03-2013                 		      original 
<!--     0.2            23-05-2013                 Shishira      added Function
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
	memoPad1();
}

function memoPad(){
        var acctNumber = document.forms[0].drAcctID.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}

function memoPad1(){
        var acctNumber = document.forms[0].acctID.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}

////edwin start

function gssimdtl_post_ONLOAD()
{
	if (profileId == 54)
	{	
		var siTypeRadio = document.getElementsByName('siType');
		siTypeRadio[1].checked = true;
		siTypeRadio[1].disabled = true;
		siTypeRadio[0].disabled = true;
		var valCrHoliRadio = document.getElementsByName('validateCrncyHoliday');
		valCrHoliRadio[1].checked =true;
		valCrHoliRadio[1].disabled =true;
		valCrHoliRadio[0].disabled =true;
		var autoPostRadio = document.getElementsByName('autoPost');
		autoPostRadio[0].checked =true;
		autoPostRadio[0].disabled =true;
		autoPostRadio[1].disabled =true;
		var carryFrwdIfFailed = document.getElementsByName('carryFrwdIfFailed');
		carryFrwdIfFailed[1].checked =true;	
		carryFrwdIfFailed[1].disabled =true;
		carryFrwdIfFailed[0].disabled =true;
		//document.forms[0].execTime.selectedIndex = 2;
		//document.forms[0].execTime.disabled =true;
		
	//document.forms[0].execEvt.value = "SICHRG";
	//document.forms[0].execEvt.disabled = true;
	//document.forms[0].acceptanceEvt.value = "SICHRG";
	//document.forms[0].acceptanceEvt.disabled = true;
		document.forms[0].failEvt.value = "SI FAILURE CHARGE";
		document.forms[0].failEvt.disabled = true;
		//document.forms[0].feeExchgRateCode.value = "MEAN";
		//document.forms[0].feeExchgRateCode.disabled = true;
		return true;		
	}
}

function custom_ONBLUR(p,obj)
{
	if (profileId == 54)
	{
		if(obj.id == "drAcctID")
		{	
			var acctId = document.forms[0].drAcctID.value;
			if(!fnIsNull(acctId))
			{			
				var inputNameValues = "acctId|"+ acctId;
				var outputNameValues = "";
				var scrName = "checkCif.scr";
				var retVal = appFnExecuteScript(inputNameValues,outputNameValues,scrName,false);
				var result      = retVal.split("|");
				var errFlg      = result[1];
				var errMsg      = result[3];
				var Cif			= result[5];
				var Solid		= result[7];		

				if(errFlg !="Y")
				{				
					document.forms[0].cifID.value = Cif;
					document.forms[0].cifID.disabled = true;
					document.forms[0].solID.value = Solid;
					document.forms[0].solID.disabled = true;
					return true;
				}
			}
		}
	}
}

///edwin end

</script>

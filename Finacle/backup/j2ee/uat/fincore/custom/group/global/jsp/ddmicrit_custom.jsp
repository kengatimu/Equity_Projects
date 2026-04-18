<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ddmicrit_custom.jsp
<!--Description         : This file should generate alert message
<!--Date                : 23-05-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HDDMI
<!--Modification History:
<!--    Version No.       Date               Author         Description
<!--    -------         ----------         -----------      ------------------
<!--     0.1            23-05-2013           Shilpa         Original version
<!--     0.2            19-08-2013           Priyansh         Modified version TO: 368032
<!--     0.3		20-08-2013	     Priyanka T	     Incorporated changes TO: 358474
<!---------------------------------------------------------------------------------------------------------------->
<%@ page import="fabclasses.*,FabServer.*,com.infy.bbu.*,applcommon.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*,finbranchUtil.*"%>

<%
	FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
	if(null == securityInfo)
	{
		securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
	}

	String solSetId = (securityInfo.contextSolId);

%>

<%@include file="formatAcct.jsp" %>
<script language="javascript">

var homeSol = "<%=solSetId%>";

<!------------changes added as a part of TO/CR no : 368032---------------------------->
//function ddmicrit_post_ONLOAD()
//{
if(mopId.toUpperCase()=="HDDMI")
{
	with (document) {
			write('<html>');
			write('<table width="98.5%" align="center" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
			write('<tr>');
			write('<td>');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
			write('<tr>');
			write('<td>');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
			write('<tr>');
			write('<td>');
			write('</td>');
			write('</tr>');
			write('<tr class="innertabletop1">');
			write('<td colspan="5" align="right">');
			write('<table border="0" cellspacing="0" cellpadding="0">');
			write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
			write('</tr>');

			write('<tr class="subhdrbg">');
			write('<td colspan="5"><h1 class="subhdr" style="font-size:12">Teller Balance Details (All Currencies)</h1></td>');
			write('</tr>');
			write('<tr>');
			write('<td class=textlabel2>Teller GL Balance</td>');
			write('<td class=textfielddisplaylabel6col><A id=\"sLnk99\" href=\"javascript:showTellerDtls()\" ><img  src=\"../Renderer/images/INFENG/explode.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search99\"></a>');
			write('<td>');
			write('</td>');
			write('</tr>');
			write('<tr>');

			write('</table>');
			write('<tr class="rowspacing">');
			write('<td colspan="2"><spacer type="block" height="1" width="1"></spacer></td>');
			write('</tr>');
			write('</table>');
			write('</td>');
			write('</tr>');
			write('</table>');
			write('</td>');
			write('</tr>');
			write('</table>');
			write('</td>');
			write('</tr>');
			write('</table>');

			write('</html>');

		}
  }
//}
<!------------end of  TO/CR no :368032 ---------------------------->

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
        var acctNumber = document.forms[0].ddAcctId.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
				validateSol(ddAcctId);
        }
				validateSol(ddAcctId);
 }

//Changes done for CR:-358474
function fnOnButtonClick(objBtn){

        if(objBtn.id == 'Clear' || objBtn.id == 'Cancel'){
                if(confirm(finbranchResArr.get("FAT000360"))){
                        objForm.actionCode.value = objBtn.id;
                        fnDisableFormFields();
                        formReset(objForm);
                        objForm.submit();
                        return ;
                }
        } else {
                if(objBtn.id == 'GetValueDate')
                {
                        if (fnIsNull(objForm.ddAcctId.value) && templateMode != 'Y')
                        {
                                alert(finbranchResArr.get("FAT000200"));
                                objForm.ddAcctId.focus();
                                return;
                        }
                        objForm.actionCode.value = objBtn.id;
                        fnEnableDescFields(objForm);
                        objForm.submit();
                        return;
                }

                // FC template code change
                if(objBtn.id == 'Go')
                {
                        if(objForm.funcCode.value == 'A')
                        {

				if(objForm.purPhNum.value == "" && profileId == "54")
							{ 
									alert("Enter Phone Number in the Field");
									objForm.purPhNum.focus();
									return false;
							}
							if(objForm.purFaxNum.value == "" && profileId == "54")
							{ 
									alert("Enter ID Number in the Field");
									objForm.purFaxNum.focus();
									return false;
							}


	
                                var inputNameValues = "funcCode|"+objForm.funcCode.value;
                                var outputNames     = "";
                                var scrName         = "tranvaldp003.scr";
                                var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                                var token = retVal.split("|");
                                if(token != undefined){
                                var errorMsg = token[1];
                                var errorMsgRef = token[3];
                                if(!fnIsNull(errorMsg))
                                {
                                        alert(errorMsg);
                                        return false;
                                }
	             if(!fnIsNull(errorMsgRef))
	            {
		alert(errorMsgRef);
		return false;
	             }
                                }
                        }
                        if (objForm.funcCode.value == 'T')
                        {
                                if (fnIsNull(objForm.ddTemplateId.value))
                                {
                                        alert(finbranchResArr.get("FAT000200"));
                                        objForm.ddTemplateId.focus();
                                        return false;
                                }
                        }
                }

                if(templateMode != 'Y' && !fnValidateForm()) return false;
                // end FC template code change

                objForm.actionCode.value = objBtn.id;
                convertToCaps();
                disableButtons();
                disableHyperLnks(20);
                fnEnableDescFields(objForm);

                objForm.submit();

                return;
        }
}
//End of changes done to CR - 358474

/*----------changes added as apart of TO/CR no : 368032----------------------------*/
function showTellerDtls()
{
var ObjForm = document.forms[0];
//alert(ObjForm.purAcctId.value);

        var inputNameValues = "acctId|" + ObjForm.purAcctId.value;
        var outputNameValues = "ccy|cashAc|tellerBalance";
        var scriptName = "fetchTellerBalmn001.scr";
        var listHeading = "Teller Balance Details";
        var colHeader = "currency|cash A/c|Current GL Balance";
        var hyper="";
        var retVal = fnExecuteScriptForList(inputNameValues,outputNameValues,scriptName,listHeading,colHeader,"20",true);
                if(retVal != undefined)
        {

        var value = retVal.split("|");
                alert(value);

        }
}

/*---------------------End of changes made for TO/CR no : 368032--------------------------------------------*/
//// changes to stop intersol issue of DD////

function ddmicrit_ONCHANGE6(obj,p1,p2,p3,p4,p5,p6)
{
	var retVal = "";
	if (preEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (preEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if ((retVal = fnCommonFetchAcctDtls(p1,p2,p3,p4,p5,p6)) == false) {
		return false;
	}
	
	if ((retVal = validateSol(obj)) == false) {
			return false;
	}

	if (postEventCallForLocale('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	if (postEventCall('ddmicrit',obj,'ONCHANGE') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function validateSol(obj)
{
	if(obj.id = "ddAcctId")
	{
		if((objForm.ddSolId.value!= "") && (objForm.ddSolId.value != homeSol))
		{
			alert("Account belonging to another sol not permitted here");
			document.forms[0].ddAcctId.value = "";
			document.forms[0].ddAcctCrncy.value = "";
			document.forms[0].ddSolId.value = "";
			document.forms[0].ddAcctName.value = "";
			document.forms[0].ddAcctId.focus();
			return false;
		}
	}
	return true;
}

</script>


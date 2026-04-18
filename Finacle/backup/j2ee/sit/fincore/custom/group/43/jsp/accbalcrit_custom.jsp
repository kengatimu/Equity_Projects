<!--------------------------------------------------------------------------------------------------------------->
<!--description         : Memo pad.
<!--Date                : 22-05-2013
<!--Author              : Prakash
<!--Called By           : None
<!--Calling  Jsp        : None
<!--Menu Option         : HACCBALI
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            22-05-2013           Prakash           Original version
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="../../jsp/formatAcct.jsp" %>
<%
	String acctLabel = "A/c. ID";
	String acctIdStr = "acctId";
	String solIdStr = "";
%>
<%@ include file="../../jsp/custsvswindow.jsp" %>
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
	var acctNumber = document.forms[0].acctId.value ;
	var inputNameValues = "acctNum|"+acctNumber;
	var outputNames     = "";
	var scrName         = "formatacctdp001.scr";
	var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	var ret1 = retVal.split("|");
	if(ret1[0] == "MSG" ){
		alert(ret1[1]);
	}
}

</script>

<html>
<script>
{
        document.write('<html>');
        
        document.write('<table class ="ctable" id="tbaleId" border="0" cellpadding="0" cellspacing="0" width="100%">');
        document.write('<tr>');
        document.write('<td valign="top">');
        document.write('<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
        document.write('<tr>');
        document.write('<td>');
        document.write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
        document.write('<tr>');
        document.write('<td>');
        document.write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
        document.write('<tr>');
        document.write('<td>');
        document.write('</td>');
        document.write('</tr>');
        document.write('<tr class="innertabletop1">');
        document.write('<td colspan="5" align="right">');
        document.write('<table border="0" cellspacing="0" cellpadding="0">');
        document.write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
        document.write('<tr>');
      
	document.write('<td class="textlabel" size="500">IBAN Number </td>');


	 document.write('<td class="textfield" size="200">');
       	        document.write('<input type="text" name="ibanNo" style="width: 200px" class="textfieldfont" id="ibanNo" OnChange="javascript:fnIbanVal()">');
 
        document.write('</td>');
		document.write('<td>&nbsp</td>');
        document.write('<td>&nbsp</td>');
        document.write('<td>&nbsp</td>');
        document.write('<td>&nbsp</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('<tr class="rowspacing">');
        document.write('<td colspan="2"><spacer type="block" height="1" width="1"></spacer></td>');
        document.write('</tr>');
        document.write('</table>');
		 document.write('<tr class="rowspacing">');
        document.write('<td colspan="2"><spacer type="block" height="1" width="1"></spacer></td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</td>');
        document.write('</tr>');
        document.write('</table>');
        document.write('</html>');
}
</script>
<script language="Javascript">
function fnIbanVal()
{
document.forms[0].acctId.value ='';
document.forms[0].solId.value='';
document.forms[0].accountCrncy.value='';
document.forms[0].acctName.value='';
var ibanNo = document.forms[0].ibanNo.value;
 var inputNameValues    = "ibanNo|"+ibanNo;
                         var outputNames        = "errorFlg|errorMsg|acctNum|acctName|solId|crncyCode";
                         var scrName            = "ibanToForacid.scr";
                         var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var result      = retVal.split("|");
        var errorFlg = result[1];
        var errorMsg = result[3];
        var acctNum = result[5];
        var solId = result[9];
        var crncyCode = result[11];
        var acctName = result[7];
         if (errorFlg == "Y") {
                alert(errorMsg);
                document.forms[0].acctId.value ='';
                        document.forms[0].ibanNo.value = '';
                return false;
            } else {
                    document.forms[0].acctId.value =acctNum;
                        document.forms[0].solId.value = solId;
        document.forms[0].accountCrncy.value=crncyCode;
                document.forms[0].acctName.value = acctName;
        setFieldFocus(document.forms[0].acctId);
                }
return true;
}
</script>

</html>

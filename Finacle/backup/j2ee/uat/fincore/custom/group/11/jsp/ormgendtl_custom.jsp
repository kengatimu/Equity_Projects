<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ormgendtl_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This script used to make 
<!--                      the field manadatory in General Detail tab..
<!--Date                : 13-03-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            13-03-2013           Shilpa           Original version
<!--	0.2				22-05-2013			Chandrasekhar		functions are added
<!--	0.3		20-08-2013	    Priyansh		Modification TO: 368583 	
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src= "../../custom/javascripts/custom_functions.js"></script>
<script language="javascript">
if( mopId.toUpperCase()=="HORM" ) {
	with (document) {
	write('<html>');
	write('<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
	write('<tr>');
	write('<td width="100%">');	
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td width="100%">');	
	//write('<table width="70%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<table width="70%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td class="textfielddisplaylabel"><b>Remit Amount in Home Currency</b></td>');
	write('<td>&nbsp;<input type="text" class="textfieldcode" size="2" maxlength="3" name="custHC"  id="custHC" readOnly>&nbsp;&nbsp;');
	write('<input class="textfieldamount" type="text" name="custRemitHCAmt" id="custRemitHCAmt" align="right" size="25" maxlength="25" value="0" readOnly>&nbsp;&nbsp;</td>');
	write('<td>');
	write('</td>');
	write('<td>');
	write('</td>');
	write('<td>');
	write('</td>');
	write('<td>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</table>');
	write('</td>');
	write('</table>');
	write('</html>');
	}
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
	memoPad(acctObj);
}

function ormgendtl_ONCHANGE5(obj,p1,p2,p3,p4,p5,p6,p7,p8,p9)
{
        if(obj.id == "oprAcct")
        {
                if(document.forms[0].chrgDrAcId.value == "")
                {
                        document.forms[0].chrgDrAcId.value=document.forms[0].oprAcct.value;
                }
        }
        var retVal = "";
        if (preEventCall('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
        if (preEventCallForLocale('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = clearDescField(p1,p2,p3)) == false) {
                return false;
        }
        if ((retVal = fnCommonFetchAcctDtls(p4,p5,p6,p7,p8,p9)) == false) {
                return false;
        }
        if (postEventCallForLocale('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
		memoPad(obj);
        return (retVal == undefined) ? true : retVal;
}

	function ormgendtl_ONCHANGE6(obj,p1,p2,p3,p4,p5,p6,p7,p8,p9)
	{
        var retVal = "";
        if (preEventCall('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
        if (preEventCallForLocale('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
        if ((retVal = clearDescField(p1,p2,p3)) == false) {
                return false;
        }
        if ((retVal = fnCommonFetchAcctDtls(p4,p5,p6,p7,p8,p9)) == false) {
                return false;
        }
        if (postEventCallForLocale('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
        if (postEventCall('ormgendtl',obj,'ONCHANGE') == false) {
                return false;
        }
		memoPad1(obj);
        return (retVal == undefined) ? true : retVal;
}

function memoPad(obj){
        var acctNumber = obj.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}
function memoPad1(obj){
        var acctNumber = obj.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}

function ormgendtl_pre_ONCLICK(obj){
	if(((funcCode == 'J')||(funcCode == 'M')) && (obj.id == "Submit" || obj.id == "Validate")){
		var oprAcct = document.forms[0].oprAcct.value;
		var chrgDrAcId = document.forms[0].chrgDrAcId.value;
		var purremit = document.forms[0].purOfRemit.value;
		var remitAmt = document.forms[0].remitAmt.value;
		var name = document.forms[0].name.value;
		var addr1 = document.forms[0].addr1.value;

		if(oprAcct == ""){
			alert("Enter Operativa A/c.ID"); 
			document.forms[0].oprAcct.focus(); 
			return false;
		}

		if(chrgDrAcId == ""){
			alert("Enter charge Debit A/c.ID"); 
			document.forms[0].chrgDrAcId.focus(); 
			return false;
		}

		if(purremit == ""){
			alert("Enter Purpose of remittance"); 
			document.forms[0].purOfRemit.focus(); 
			return false;
		}
		if(oprAcct!="" && chrgDrAcId!="" && purremit!="" && remitAmt!="0.00" && remitAmt!=""){
			alert("Please Visit Party Details tab");
		}
	}
	
}
function pre_TAB_SWITCH(obj){
if((funcCode == 'J')||(funcCode == 'M')){
	var oprAcct = document.forms[0].oprAcct.value;
                var chrgDrAcId = document.forms[0].chrgDrAcId.value;
                var purremit = document.forms[0].purOfRemit.value;

                if(oprAcct == ""){
                        alert("Enter Operativa A/c.ID");
                        document.forms[0].oprAcct.focus();
                        return false;
                }

                if(chrgDrAcId == ""){
                        alert("Enter charge Debit A/c.ID");
                        document.forms[0].chrgDrAcId.focus();
                        return false;
                }

                if(purremit == ""){
                        alert("Enter Purpose of remittance");
                        document.forms[0].purOfRemit.focus();
                        return false;
                }
		if(oprAcct!="" && chrgDrAcId!="" && purremit!="" && name!="" && addr1!="" && remitAmt!="0.00" && remitAmt!=""){
                	alert("Please Visit Party Details tab");
        	}
        }
}
	

function ormgendtl_ONCHANGE(obj){
        if((funcCode == 'J')||(funcCode == 'M')){
	setFieldsToCustomData("oprAcct");
        }
}
function ormgendtl_post_ONLOAD() {
	document.forms[0].custHC.value = homeCrncyCode;
	popRemitHCAmt();
}
function ormgendtl_post_ONBLUR(obj){
	if (obj.id == "remitAmt" ) {
		popRemitHCAmt();
	}
}
function popRemitHCAmt() {
	var objForm = document.forms[0];
	var remitCurrcy = document.getElementById('compField').innerHTML;
	remitCurrcy = remitCurrcy.substring(0 ,3);
	if( remitCurrcy != homeCrncyCode ){ 
		var remitAmount = 0;
		if ( objForm.remitAmt.value != "" ) {
			var remitAmount = objForm.remitAmt.value;
		}
		var rate = objForm.notConvRate.value;
		remitAmount = remitAmount.replace(new RegExp(',','g'),"");
		remitAmount = parseFloat(remitAmount,2);
		var remitHCAmt = remitAmount * rate;
		objForm.custRemitHCAmt.value = remitHCAmt;
		objForm.custRemitHCAmt.value = formatToMillion1(objForm.custRemitHCAmt.value, 0);
	}
	else{
		objForm.custRemitHCAmt.value = "0";
	}
}
</script>



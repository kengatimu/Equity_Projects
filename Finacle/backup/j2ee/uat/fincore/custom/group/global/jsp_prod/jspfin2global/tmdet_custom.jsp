<%!
	public static final String _ARJSP_JSP_NAME = "tm/tmdet.jsp";
%>
<%@ include file="../../finbranch_common.jsp" %>
<%@ page import="gcode.utils.ONSList" %>
<%@ page import="gcode.iface.IpartTranDetail" %>
<%@ page import="com.infy.bbu.ons.tran.tmConstants" %>
<%@ page errorPage="../../arjspmorph/error_page.jsp" %>
<arjsp:init groupName="tm" isEntryPoint="false" />
<%
	String sProfileId 	= ProfilesManager.getProfileInSession(session);

	String sRefId = (String)ARJspCurr.getInputWithGroup("refId","");
	String sAcctIds = "",sRefCrncys = "",sRefAmts = "",sPTranTypes = "",sDelFlgs = "",firstRec="N";;
	//Bringing in java code to form the inputs for the denomination function fnDenomPopup()
	ONSList pTranLL = (ONSList)ARJspCurr.getInputWithGroup(tmConstants.PTRAN_LL, null);
	int currPos = Integer.parseInt((String)ARJspCurr.getInputWithGroup(tmConstants.PTRANLL_CURCOUNT, "0"));
	int llSize = (pTranLL != null) ? pTranLL.size() : 0;
	IpartTranDetail pTranRec = null;
	for (int i=0; i<llSize; i++)
	{
		pTranRec = (IpartTranDetail)pTranLL.get(i);
		if(i==0)
			sDelFlgs = String.valueOf(pTranRec.getdelFlg());
		else
			sDelFlgs = sDelFlgs + "@" + String.valueOf(pTranRec.getdelFlg());			
		if(pTranRec.getdelFlg() != tmConstants.CHAR_YES) {
			if(i>0 &&(firstRec=="Y"))
			{
				sAcctIds = sAcctIds + "@" + String.valueOf(pTranRec.getacctId().getforacid());
				sRefCrncys = sRefCrncys + "@" + String.valueOf(pTranRec.getrefCrncyCode().getcrncyCode());
				sRefAmts = sRefAmts + "@" + String.valueOf(CommonFunctions.removeCrncyFromAmt(pTranRec.getrefAmtString()));
				sPTranTypes = sPTranTypes + "@" + String.valueOf(pTranRec.getpartTranType().getcode());
				
			}
			else
			{
				sAcctIds = String.valueOf(pTranRec.getacctId().getforacid());
				sRefCrncys = String.valueOf(pTranRec.getrefCrncyCode().getcrncyCode());
				sRefAmts = String.valueOf(CommonFunctions.removeCrncyFromAmt(pTranRec.getrefAmtString()));
				sPTranTypes = String.valueOf(pTranRec.getpartTranType().getcode());
				firstRec="Y";
			}
		}
	}
	

	String sDenomCount	= ((request.getParameter("custom.DenomCount")!= null)?request.getParameter("custom.DenomCount"):"");
	String sDenomEntered = ((request.getParameter("custom.DenomEntered")!= null)?request.getParameter("custom.DenomEntered"):"N");
	String sEvent	= ((request.getParameter("custom.sEvent")!= null)?request.getParameter("custom.sEvent"):"E");
	String sCifInfo = ((request.getParameter("custom.cifInfo")!= null)?request.getParameter("custom.cifInfo"):"");
	String varbiotest = ((request.getParameter("custom.varbiotest")!= null)?request.getParameter("custom.varbiotest"):"");
	String isParentRINBX = ((request.getParameter("custom.isParentRINBX")!= null)?request.getParameter("custom.isParentRINBX"):"");
	String sIsCashAcct	= ((request.getParameter("custom.isCashAcct")!=null)?request.getParameter("custom.isCashAcct"):"");
	String temp	= ((request.getParameter("custom.temp")!=null)?request.getParameter("custom.temp"):"");
	if(sIsCashAcct.equals(""))
		sIsCashAcct = (String) ARJspCurr.getInput("tm.isCashAcct","");
	else
		ARJspCurr.setInput("tm.isCashAcct",sIsCashAcct);

	String cardNum	= ((request.getParameter("cardNum")!= null )?request.getParameter("cardNum"):"");
%>
<%
        String sProcRequestRet = null;
        FABCommon.SecurityInfo70 securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("FinUserInfo");
        if(null == securityInfo)
        {
                securityInfo = (FABCommon.SecurityInfo70)session.getAttribute("UserInfo");
        }
        String sBODDate = (String)((securityInfo.bodDate).substring(0,10));
        String homeSol  = (String)((securityInfo.homeSolId));
		String workClass  = (String)((securityInfo.userWorkClass));
        String homeCcy  = (String)((securityInfo.homeCrncyCode));
        String sBgType      =   (String)ARJspCurr.getInputWithGroup("bgType", null);
        String sBgAmtCrncy  =   (String)ARJspCurr.getInputWithGroup("bgCrncyCode", null);
		String tmuserid     = (String)((securityInfo.userId));
%>

<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/app_custom.js" ></script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("session.js",sProfileId)%>"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("custom_functions.js",sProfileId)%>"> </script> 
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("array.js",sProfileId)%>"></script>
<script language="javascript" src="../Renderer/javascripts/<%=VRPKeys.getCustomFile("common_functions.js",sProfileId)%>"> </script> 
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("cust_denom_functions.js",sProfileId)%>"> </script> 
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("tmdet_custom_link.js",sProfileId)%>"> </script> 
<script language="javascript" src="../Renderer/custom/javascripts/<%=VRPKeys.getCustomFile("tmdetdp001.js",sProfileId)%>"> </script>

<script>
var RecSplitTmp	= "";
var position	= 1;
// Declarring Arrays to capture the part tran details for Denom functionality.
var aPTranTypes	= new Array();
var aRefCrncys	= new Array();
var aRefAmts	= new Array();
var aAcctIds	= new Array();
var tmuserid = "<%=tmuserid%>";
var homeCcy = "<%=homeCcy%>";
var pTranTypes = "<%=sPTranTypes%>";
var refCrncys = "<%=sRefCrncys%>";
var refAmts = "<%=sRefAmts%>";
var acctIds = "<%=sAcctIds%>";
var refId = "<%=sRefId%>";
var sDelFlgs = "<%=sDelFlgs%>";
var key="",keyCtrl="",micrId="";
var storeflg=false,swipeStatus=true;
var cifInfo ="<%=sCifInfo%>";
//var varbiotest ="<%=varbiotest%>";
var temp = "<%=temp%>";
var workClass = "<%=workClass%>";

</script>

<script type="text/javascript">

////////////////////////////////------------------------------------------------------------
// to disable Z option for all cash deposit transactions
/////////////////////////////////------------------------------------------------------------





getFieldsFromCustomData("tranType");
var trantype = document.forms[0].customData.value;
if(tranType == "C")
{
	if((tranSubType == "NP") || (tranSubType == "PI"))
		{
				
				hideImage(multiRecName+"_NextRec");
				hideImage(multiRecName+"_PrevRec");
				hideImage(multiRecName+"_AddNew");
		}
}

if (workClass <= "600") 
{
    var e = document.getElementById("Save")
    if (e != undefined) 
	{
        (e.style.display == 'none') ? e.style.display = 'block': e.style.display = 'none';
    }
}

if ((mopId == "HTM") || (mopId == "HCASHDEP")) 
{
    if (tranType == "C") 
	{
        if ((tranSubType == "NP") || (tranSubType == "CP") || (tranSubType == "PI")) 
		{
            document.forms[0].option.selectedIndex = 7;
            var radioButtons = document.getElementsByName('printAdvice');
            radioButtons[0].checked = false;
            radioButtons[1].checked = false;
            radioButtons[2].checked = true;
            document.forms[0].printAdvice.disabled = true;
            fnEnableDisableRadioButtons(document.getElementsByName("printAdvice"), 'D');
        }
    }

    if (tranType == "C") 
	{
        if ((tranSubType == "NR") || (tranSubType == "CR") || (tranSubType == "RI") || (tranSubType == "CP")) 
		{
            fnRemoveOption(document.forms[0].option, "Z");
        }
    }
    if (tranType == "T") 
	{
        if ((tranSubType == "BI") || (tranSubType == "CI") || (tranSubType == "I")) 
		{
            fnRemoveOption(document.forms[0].option, "Z");
        }
    }
}

if (funcCode == "A" || funcCode == "M" || funcCode == "C" || funcCode == "T") 
{
    if (tranType != "T") 
	{
        var e = document.getElementById("PostPartTran");
        if (e != undefined) 
		{
            if (tranType != "T") 
			{
                (e.style.display == 'none') ? e.style.display = 'block': e.style.display = 'none';
            }

            frm.pTranType[0].onclick = function() {
                eventIdPop(this)
            };
            frm.pTranType[1].onclick = function() {
                eventIdPop(this)
            };
        }
    }
}


function getAcctIdList() 
{
    var oldAcct = frm.acctId.value;
    showAccountIdList(frm.acctId, null, null, 'F');
    if (oldAcct != frm.acctId.value) 
	{
        frm.subaction.value = 'A';
        frmSubmit("GETDETAILS");
   fnAcctCrncyVal(); 

        doLocalBioMetricVal();
    }
   fnAcctCrncyVal(); 
    memoPad();
}

function getRefCrncyList() 
{
    var oldValue = frm.refCrncy.value;
    var retVal = popModalWindow("../arjspmorph/" + applangcode + "/get_currency.jsp?wReturn=refCrncy&Currency=" + oldValue, "CurrencyList");
    if (retVal != null) 
	{
        var j = retVal.split("|");
        frm.refCrncy.value = j[0];
        if (oldValue != j[0]) 
		{
            getCrncyDetails();
        }
    }
    if (workClass != "240") 
	{
        //alert(workClass);
        //hideImage("sLnk11");
        document.forms[0].rate.disabled = true;
        document.forms[0].treaRate.disabled = true;
    }
	fnAcctCrncyVal();
}


function memoPad() 
{
    var acctNumber = document.forms[0].acctId.value;
	
    var inputNameValues = "acctNum|" + acctNumber + "|partTranType|" + pTranType;
    var outputNames = "";
    var scrName = "formatacctdp004.scr";
    var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
    var ret1 = retVal.split("|");
    if (ret1[0] == "MSG") 
	{
        alert(ret1[1]);
    }
    if (pTranType == "C") 
	{
        if (ret1[2] == "Y") 
		{
            str = document.getElementById('tranParticular').value;
            //alert(str);
            if (str.indexOf(ret1[3]) == -1) 
			{
                var argsVariable;
                var answer = window.showModalDialog("../custom/jsp/shareorddp001.jsp?tramt=" + document.getElementById('refAmt').value, argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
                if (answer != undefined) 
				{
                    document.getElementById('refAmt').value = answer.amt;
                    document.getElementById('tranParticular').value = answer.secrty + ret[3] + answer.prclmt;
                    document.getElementById('refNum').value = answer.crdno;
                    document.getElementById('tranRmks').value = answer.name;

                    element = document.getElementsByName("printAdvice");
                    if (element[0].checked != true) 
					{
                        //element[0].checked = true;
                        document.forms[0].printAdvice.disabled = true;
                        fnEnableDisableRadioButtons(document.getElementsByName("printAdvice"), 'D');
                    }
                }
            }
        }
    }
    if (pTranType == "D") 
	{
        if (ret1[2] == "Error") 
		{
            alert(ret1[3]);
        }

        if (ret1[2] == "Sucess") 
		{
            shareTrade();
        }
    }
}

function shareTrade() 
{
    //if(document.forms[0].refAmt.value != "")
    //{
    var tranamt = document.forms[0].refAmt.value;
    var url = "../custom/jsp/safaricomipodp001.jsp?amt=" + tranamt
    var argsVariable;
    var answer = window.showModalDialog(url, argsVariable, "dialogWidth:400px; dialogHeight:400px; center:yes");
    if (answer != undefined) 
	{
        document.getElementById("refAmt").value = answer.amt;
        document.getElementById("tranParticular").value = answer.tranPtcls;
        document.getElementById("tranRmks").value = answer.tranRmks;
        document.getElementById("tranRmks2").value = answer.tranRmks;
        document.getElementById("refNum").value = answer.refNo;
    }
    return true;
    //}
}
/*functionality moved to tmdet_custom_link.js*/

/*function post_ONLOAD(obj)
{
	document.forms[0].treaRate.disabled = true;

	var grantTodFlg=document.getElementsByName("grantTodFlg");
	grantTodFlg[1].onclick = function(){fnOnClick()};

	if( funcCode == "A"){
		if(tranSubType == "NR"){
			element = document.getElementsByName("printAdvice");
            element[0].checked = true;
		}
	}

    if(document.forms[0].instrNum.value != "" )
    {
		document.forms[0].instrNum.readOnly=true;
    }

	if(funcCode == "A" || funcCode == "M" || funcCode == "C")
	{
		element = document.getElementsByName("pTranType");
        if(element[0].checked == true){
       		pTranType = "D"
        }
        else{
        	pTranType = "C"
        }
		if(document.forms[0].acctId.value != "") {
			if(pTranType == "C"){	
			var acctvalue =  document.forms[0].acctId.value;
			var	inputNameValues    = "acctid|"+acctvalue;
			var	outputNames        = "";
			var	scrName            = "shareorddp001.scr";
			var	retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		  	var ret = retVal.split("|"); 
			if( ret[1] == "Y" )
			{
				str = document.getElementById('tranParticular').value;
				if(str.indexOf(ret[3])==-1) {
					var argsVariable;
					var answer = window.showModalDialog("../custom/jsp/shareorddp001.jsp?tramt="+document.getElementById('refAmt').value,argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
					if(answer != undefined) {
						document.getElementById('refAmt').value = answer.amt;
						document.getElementById('tranParticular').value = answer.secrty + ret[3] +answer.prclmt;
						document.getElementById('refNum').value = answer.crdno;
						document.getElementById('tranRmks').value = answer.name;
						
						element = document.getElementsByName("printAdvice");
						if(element[0].checked != true ){
							element[0].checked = true;	
							document.forms[0].printAdvice.disabled = true;
							fnEnableDisableRadioButtons(document.getElementsByName("printAdvice"),'D');	
						}
					}
				}
			}
		}	
		//added for issue- share trading maintanence
		if(pTranType == "D" ){
		var inputNameValues = "acctNum|"+document.forms[0].acctId.value;
		var outputNames     = "";
       	var scrName         = "safaricomipodp002.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "Error" )
        {
          	alert(ret1[1]);
        }
		if(ret1[0] == "Sucess"){
			shareTrade();
		}
		}
		}
	}

	if(funcCode == "A" || funcCode == "M" )
    {
		if(document.forms[0].acctId.value != "" ){
			var acctnum = document.forms[0].acctId.value;		
	 		var inputNameValues = "acctnum"+"|"+acctnum+"|"+"funcCode"+"|" +funcCode+"|"+"tranSubType"+"|"+tranSubType;
	 		var outputNames     = "";
     		var scrName         = "formatacctdp002.scr";
     		var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
     		var ret = retVal.split("|");
     		if(ret[0] == "Error" )
     		{
       			alert(ret[1]);
       			return false;
     		}	
		}
	}

}*/


function tmdet_ONCHANGE(obj) 
{
    if (obj.id == "instrType" || obj.id == "acctId") 
	{
        if ((document.forms[0].instrType.value.toUpperCase() == "CHQ") || (document.forms[0].instrType.value.toUpperCase() == "ICH")) 
		{
            var inputNameValues = "";
            var outputNames = "stats";
            var scrName = "clginsdetfetchmn005.scr";
            var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
            var ret = retVal.split("|");
            var homsolId = ret[1];

            if (headCtxSol == homsolId) 
			{
                var instInstrNum = document.forms[0].instrNum.value;
                var acctId = document.forms[0].acctId.value;
                if (acctId == "") 
				{
                    alert("Enter account Number");
                    document.forms[0].acctId.focus();
                    document.forms[0].instrType.value = "";
                    return true;
                }
                var argsVariable;
                var answer = window.showModalDialog("../custom/jsp/clginsdetfetchmn002.jsp", argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
                if (answer != undefined) 
				{
                    var micrstring = answer.micrstring;
                    var inputNameValues = "micrstring" + "|" + micrstring + "|" + "acctId" + "|" + acctId;
                    var outputNames = "status";
                    var scrName = "clginsdetfetchmn003.scr";
                    var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                    var ret = retVal.split("|");
                    document.getElementById('instrNum').value = ret[1];
                    document.forms[0].instrNum.readOnly = true;
                    var instPayingAcct = ret[3];
                    var actId = ret[5];
                    if (actId != instPayingAcct) 
					{
                        alert("CHEQUE NOT ISSUED.......");
                        return true;
                    }
                }
            }
        }
	}
	if (obj.id == "refAmt") 
	{
		//alert("obj.id"+ obj.id);

		if (obj.value != "") 
		{
			//alert("obj.value  "+document.forms[0].refAmt.value);
			if (document.forms[0].refAmt.value > 9999999999) 
			{
				alert("INVALID AMOUNT.....CONFIRM");
				document.forms[0].refAmt.focus();
				clearDescField("refAmt");
				return false;
			}
		}
	}

	if (obj.id == "refNum") 
	{
		if ((mopId == "HTM") || (mopId == "HCASHWD")) 
		{
			if (tranType == "C") 
			{
				if ((tranSubType == "NP") || (tranSubType == "PI") || (tranSubType == "CP")) 
				{
					if (funcCode == "A" || funcCode == "M") 
					{
						fnValidatePymtToAcctGL();
					}
				}
			}
		}

		if (funcCode == "A" || funcCode == "M") 
		{
			if (document.forms[0].acctId.value != "") 
			{
				var acctnum = document.forms[0].acctId.value;
				var refNum = document.forms[0].refNum.value;
				var inputNameValues = "acctnum" + "|" + acctnum + "|" + "funcCode" + "|" + funcCode + "|" + "tranSubType" + "|" + tranSubType + "|" + "refNum" + "|" + refNum;
				var outputNames = "";
				var scrName = "formatacctdp003.scr";

				var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				if (ret[0] == "Error") 
				{
					alert(ret[1]);
					return false;
				}
				//Kim - Displaying Ref no  and ref Desc in transaction particulars.
				if (ret[0] == "refnum") 
				{
					document.forms[0].tranRmks.value = ret[3];
					document.forms[0].tranRmks2.value = ret[3];
					//document.forms[0].tranParticular.value = document.forms[0].tranParticular.value + " Ref No:" + refNum + " Ref Desc:" + ret[3] ;
					document.forms[0].tranParticular.value = (document.forms[0].tranParticular.value + refNum + "-" + ret[3]).substring(0, 50);
				} // Kim end

			}
		}
	}
}
function tmdet_ONCHANGE4(obj)
{
    var retVal = "";
    if (preEventCall('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if (preEventCallForLocale('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
   
  if ((retVal = fnAcctCrncyVal()) == false) {
        return false;
    }
if ((retVal =getAcctDetails()) == false) {
      return false;
    }
        
    if (postEventCallForLocale('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if (postEventCall('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function tmdet_ONCHANGE5(obj) 
{
    var retVal = "";
    if (preEventCall('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if (preEventCallForLocale('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if ((retVal = fnCheckPymtToAcctGL(obj)) == false) {
        return false;
    }
    if ((retVal = getCrncyDetails()) == false) {
        return false;
    }
    if (postEventCallForLocale('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if (postEventCall('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function tmdet_ONCHANGE7(obj) 
{
    var retVal = "";
    if (preEventCall('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if (preEventCallForLocale('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if ((retVal = fnCheckPymtToAcctGL(obj)) == false) {
        return false;
    }
    if ((retVal = getRateDetails()) == false) {
        return false;
    }
    if (postEventCallForLocale('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    if (postEventCall('tmdet', obj, 'ONCHANGE') == false) {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function tmdet_ONBLUR6(obj, p1) 
{
    var retVal = "";
    if (preEventCall('tmdet', obj, 'ONBLUR') == false) {
        return false;
    }
    if (preEventCallForLocale('tmdet', obj, 'ONBLUR') == false) {
        return false;
    }
    if ((retVal = computeAmt(p1)) == false) {
        return false;
    }

    if ((retVal = refAmtValidate(obj)) == false) {
        return false;
    }
    if (postEventCallForLocale('tmdet', obj, 'ONBLUR') == false) {
        return false;
    }
    if (postEventCall('tmdet', obj, 'ONBLUR') == false) {
        return false;
    }
    return (retVal == undefined) ? true : retVal;
}

function refAmtValidate(obj) 
{
    if ((mopId == "HXFER") || (mopId == "HTM") || (mopId == "HCASHWD")) 
	{
        if ((obj.id = "refAmt") && (frm.pTranType[0].checked == true) && (frm.grantTodFlg[0].checked != true) && (frm.refCrncy.value == homeCcy) && ((schmType == "SBA") || (schmType == "CAA"))) 
		{
            var acctNumVal = document.forms[0].acctId.value;
            var refAmtVal = removeCommas(document.forms[0].refAmt.value);
            var acctCrncyAmtVal = parseFloat(removeCommas(document.forms[0].acctCrncyAmt.value));
            var effAvlBalVal = parseFloat(removeCommas(document.forms[0].effAvlBal.value));

            if ((refAmtVal != "") && (acctNumVal != "")) 
			{
                if (parseFloat(removeCommas(document.forms[0].effAvlBal.value)) < parseFloat(removeCommas(document.forms[0].acctCrncyAmt.value))) 
				{
                    alert("Effective Balance is less than the entered amount");
                }
            }
        }
    }
    return true;
}


function refAmtValidateCCY(obj) 
{
    if ((mopId == "HXFER") || (mopId == "HTM") || (mopId == "HCASHWD")) 
	{
        if ((frm.refCrncy.value != homeCcy) && (frm.pTranType[0].checked == true) && (frm.grantTodFlg[0].checked != true) && (frm.refCrncy.value == homeCcy) && (schmType == "SBA") || (schmType == "CAA")) 
		{
            var acctNumVal = document.forms[0].acctId.value;
            var refAmtVal = removeCommas(document.forms[0].refAmt.value);
            var acctCrncyAmtVal = parseFloat(removeCommas(document.forms[0].acctCrncyAmt.value));
            var effAvlBalVal = parseFloat(removeCommas(document.forms[0].effAvlBal.value));

            if ((refAmtVal != "") && (acctNumVal != "")) 
			{
                if (parseFloat(removeCommas(document.forms[0].effAvlBal.value)) < parseFloat(removeCommas(document.forms[0].acctCrncyAmt.value))) 
				{
                    alert("Effective Balance is less than the entered amount");
                }
            }
        }
    }
    return true;
}

function fnCheckPymtToAcctGL(obj) 
{
    if ((obj.id == "refCrncy") || (obj.id == "rateCode")) 
	{
        if ((mopId == "HTM") || (mopId == "HCASHWD")) 
		{
            if (tranType == "C") 
			{
                if ((tranSubType == "NP") || (tranSubType == "PI") || (tranSubType == "CP")) 
				{
                    if (funcCode == "A" || funcCode == "M") 
					{
                        var retValue = "";
                        if ((retValue = fnReValidatePymtToAcctGL()) == false) 
						{
                            return false;
                        }
                    }
                }
            }
        }
    }
    return true;
}

function fnValidatePymtToAcctGL() 
{
    var ObjForm = document.forms[0];
    var refNum = ObjForm.refNum.value;
    var refCrncy = ObjForm.refCrncy.value;
    var rateCode = ObjForm.rateCode.value;

    var ieTxnRefNoCount = "0";
    if (!fnIsNull(refNum)) 
	{
        var inputNameValues = "callMode|C|refNum|" + refNum+"|tranSubType|"+tranSubType;
        var outputNames = "ieTxnRefNoCount";
        var scriptName = "cietxndp040.scr";
        var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
        var token = retVal.split("|");
        if (token != undefined) 
		{
            ieTxnRefNoCount = token[5];
        }
    }
    if (parseInt(ieTxnRefNoCount) > 0) 
	{
        var inputNameValues = "callMode|L|refNum|" + refNum + "|refCrncy|" + refCrncy + "|rateCode|" + rateCode+"|tranSubType|"+tranSubType;
        var outputNameValues = "refNum|ieTxnRefNo|tranParticular|tranRmks|tranRmks2|ieTxnAcctId|ieTxnRefAmt|ieTxnRefCrncy|refAmt|refCrncy|rateCode|rate|treaRate|errorMsg";
        var scriptName = "cietxndp040.scr";
        var listHeading = "Inter Entity Payment To A/c. GL List";
        var colHeader = "Random Ref. No|Inter Entity Txn Ref. No|Transaction Particulars|Remarks1|Remarks2|Inter Entity Account|Issued Amt|Issued CCY|Pymt Amt|Pymt CCY|Rate Code|Rate|Treasury Rate|Error Message";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNameValues, scriptName, listHeading, colHeader, "1", true);

        var ieTxnRefNo = ObjForm.ieTxnRefNo.value;
        var ieTxnAcctId = ObjForm.ieTxnAcctId.value;
        var ieTxnRefAmt = ObjForm.ieTxnRefAmt.value;
        var ieTxnRefCrncy = ObjForm.ieTxnRefCrncy.value;

        ObjForm.acctId.value = ieTxnAcctId;
        ObjForm.refNum.value = ieTxnRefNo;
        fnSetIeTxnCustData();

        if (fnIsNull(ieTxnRefNo)) 
		{
            ObjForm.refNum.value = "";
            ObjForm.acctId.value = "";
            return;
        }

        getAcctDetails();
    } 
	else 
	{
        var ieTxnRefNo = "";
        var ieTxnAcctId = "";
        var ieTxnRefAmt = "";
        var ieTxnRefCrncy = "";
        alert("This is not an Inter Entity Payment To A/c. GL Ref No");
        ObjForm.acctId.value = "";
        ObjForm.refAmt.value = "";
        ObjForm.refCrncy.value = "";
        ObjForm.tranParticular.value = "";
        ObjForm.tranRmks.value = "";
        ObjForm.tranRmks2.value = "";
        ObjForm.rateCode.value = "";
        ObjForm.rate.value = "";
        getAcctDetails();
        ObjForm.acctId.readOnly = false;
        ObjForm.refAmt.readOnly = false;
        ObjForm.refCrncy.readOnly = false;
        ObjForm.tranParticular.readOnly = false;
        ObjForm.tranRmks.readOnly = false;
        ObjForm.tranRmks2.readOnly = false;
        ObjForm.acctId.focus();
    }

}

function fnReValidatePymtToAcctGL() 
{
    var ObjForm = document.forms[0];
    var refCrncy = ObjForm.refCrncy.value;
    var rateCode = ObjForm.rateCode.value;
    var ieTxnRefNo = ObjForm.ieTxnRefNo.value;

    if (!fnIsNull(ieTxnRefNo)) 
	{
        if (fnIsNull(refCrncy)) 
		{
            return false;
        }
        if (fnIsNull(rateCode)) 
		{
            return false;
        }
        var inputNameValues = "callMode|L|ieTxnRefNo|" + ieTxnRefNo + "|refCrncy|" + refCrncy + "|rateCode|" + rateCode+"|tranSubType|"+tranSubType;
        var outputNameValues = "refNum|ieTxnRefNo|tranParticular|tranRmks|tranRmks2|ieTxnAcctId|ieTxnRefAmt|ieTxnRefCrncy|refAmt|refCrncy|rateCode|rate|treaRate|errorMsg";
        var scriptName = "cietxndp040.scr";
        var listHeading = "Inter Entity Payment To A/c. GL List";
        var colHeader = "Random Ref. No|Inter Entity Txn Ref. No|Transaction Particulars|Remarks1|Remarks2|Inter Entity Account|Issued Amt|Issued CCY|Pymt Amt|Pymt CCY|Rate Code|Rate|Treasury Rate|Error Message";
        var retVal = fnExecuteScriptForList(inputNameValues, outputNameValues, scriptName, listHeading, colHeader, "1", true);
        ObjForm.refNum.value = ObjForm.ieTxnRefNo.value;
        return false;
    }
    return true;
}



//function post_ONLOAD(obj){
//alert(tranType);
//      fnDisableFieldsForPymtToAcctGL();
//}


//function pre_ONLOAD4(obj,acctId)
function custom_ONCHANGE(obj,acctId)
{
	if(document.forms[0].partTranDetail_LowLimit.value != 1)
	{
		//alert(document.forms[0].partTranDetail_LowLimit.value);	
		var acctId = document.forms[0].acctId.value;
		var input      = "acctId|"+acctId;
		var outputNames    = "biller_chk_flg";
		var scrName     =   "Biller_Acct_check.scr";
		var retVal = fnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var biller_chk_flg = retBuff[1];
		//	if (biller_chk_flg=='Y')
		//	{
		var ObjForm = document.forms[0];
		var acctId = ObjForm.acctId.value;
		var inputNameValues = "acctId|"+acctId;
		var outputNames = "tranParticular|refNum|tranRmks";
		var scriptName = "get_tran_details_bill.scr";
		var retVal = fnExecuteScript(inputNameValues,outputNames,scriptName,false);

		var token = retVal.split("|");

		if(token[1] != 1 )
		{
			//alert("Y");
			document.forms[0].tranParticular.value = token[1];
			ObjForm.tranParticular.value = token[1];
			ObjForm.refNum.value = token[3];
			ObjForm.tranRmks.value = token[5];
		}
		//}
	}
	
	if (document.forms[0].refNum.value != "") 
	{
		if ((mopId == "HTM") || (mopId == "HCASHWD")) 
		{
			if (tranType == "C") 
			{
				if ((tranSubType == "NP") || (tranSubType == "PI") || (tranSubType == "CP")) 
				{
					if (funcCode == "A" || funcCode == "M") 
					{
						fnValidatePymtToAcctGL();
					}
				}
			}
		}
	}
}
function tmdet_pre_ONCHANGE(obj) 
{
    if (obj.id == "acctId") 
	{
        if (obj.value != "") 
		{
            var inputNameValues = "acctNum|" + obj.value;
            var outputNames = "";
            var scrName = "b_excisedty.scr";
            var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
            var ret1 = retVal.split("|");
            if (ret1[0] == "K") 
			{
                alert("COLLECT EXCISE DUTY");
            }

            //equitel start
            var inputNameValues = "acctNum|" + obj.value;
            var outputNames = "";
            var scrName = "b_equitelacct.scr";
            var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
            var ret1 = retVal.split("|");
            if (ret1[0] == "Y") 
			{
                alert("The Equitel line linked to this account is INACTIVE.Kindly advise the customer to replace their SIM card at the Equitel desk,for FREE or to BUY Equitel airtime so as to receive 100% BONUS airtime");
            }
            //equitel end

            //alert("am in");
            var acct = document.forms[0].acctId.value;
            var input = "acct|" + acct;
            var outputNames = "output|outVal";
            var scrName = "bio_check.scr";
            var retVal = appFnExecuteScript(input, outputNames, scrName, false);
            var retBuff = retVal.split("|");
            var output = retBuff[0];
            var value = retBuff[1];
            var a = value;
            //alert(a);
            var retBuff = retVal.split("|");
            var output1 = retBuff[2];
            var value1 = retBuff[3];
            var b = value1;
            //alert(b);
            if (a != 1) 
			{
                if (b != 4) 
				{
                    alert("ENROLL CUSTOMER FOR BIO");
                }
                if (b == 4) 
				{
                    alert("PLEASE ENROLL CUSTOMER FOR BIO");
                    document.forms[0].acctId.focus();
                    return false;
                }
            }
			//if (profileId == 54)
			//{
				if (profileId == 11)
				{

					var acct = document.forms[0].acctId.value;
					var inputNameValues =  "acctNum|"+ acct;
					var outputNames     = "";
					var scrName         = "phone_check.scr";
					var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					 if(a == "N")
						{
							alert("Kindly Update customers phone at CIF Level");
						}
				}
				else
			{

			//KRA PIN START
					var acct = document.forms[0].acctId.value;
					var inputNameValues =  "acctNum|"+ acct;
					var outputNames     = "";
					var scrName         = "krapin_check.scr";
					var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					 if(a == "N")
						{
							alert("Kindly Update customers PIN at CIF Level");
						}

			//KRA PIN END
			}
			//PEP START
					var acct = document.forms[0].acctId.value;
					var inputNameValues =  "acctNum|"+ acct;
					var outputNames     = "";
					var scrName         = "pep_check.scr";
					var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					 if(a == "Y")
						{
							alert("PEP");
						}

			//PEP END
			//}
            var str = document.forms[0].acctId.value;
            var res = str.substring(3, 13);
            //alert(res);

			/* need to add biller finder and alert*/
				
			var acctId = document.forms[0].acctId.value;
			var input      = "acctId|"+acctId;
			var outputNames    = "biller_chk_flg";
			var scrName     =   "Biller_Acct_check.scr";
			var retVal = fnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var biller_chk_flg = retBuff[1];
			if (biller_chk_flg=='Y')
			{
				alert("Account linked with biller");
				document.forms[0].option.value = 'J'
				//alert(jspResArr.get("FLT014276"));
				// }	
				if(document.forms[0].partTranDetail_LowLimit.value != 1)
				{
					//alert(document.forms[0].partTranDetail_LowLimit.value);
					if((tranType == "C") || (tranType == "T"))
					{
						if((pTranType == "C")||(pTranType == "D"))
						{
							//	alert(pTranType);
						   if(document.forms[0].acctId.value!="")
							{
								var frm = document.forms[0];

								if((frm.tranParticular.value=="") && (frm.refNum.value=="") &&(frm.tranRmks.value==""))
								{
									 var ObjForm = document.forms[0];
									 var acctId = ObjForm.acctId.value;
									 var inputNameValues = "acctId|"+acctId;
									 var outputNames = "tranParticular|refNum|tranRmks";
									 var scriptName = "get_tran_details_bill.scr";
									 var retVal = fnExecuteScript(inputNameValues,outputNames,scriptName,false);

									 var token = retVal.split("|");
								
									if(token[1] != 1 )
									{
										//alert("Y");	
										ObjForm.tranParticular.value = token[1];
										ObjForm.refNum.value = token[3];
										ObjForm.tranRmks.value = token[5];
									}
									else
									{
										//alert("N");
									}
								}

							}
						}
					}
				}		
			}	

            if (res == "1300100814") 
			{
                if (tranType == "C") 
				{
                    alert("Kindly Use Transfer to the Operative Account")
                    //alert(schmType);
                    document.forms[0].acctId.focus();
                    clearDescField("acctId");
                    return false;
                }
            }


            /*if(tranType == "C"){
            	if((tranSubType == "NP") || (tranSubType == "NR")){
            		 var inputNameValues = "acctNum|"+obj.value;
            		 var outputNames     = "scheme";
            	     var scrName         = "DDacctCheck.scr";
            		 var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
            		 var ret1 = retVal.split("|");
            		 if(ret1[0] == "S")
            		{
            			if(ret1[1] == "DDA")
            			{
            		 		alert("Kindly Use HDDMI for Bankers cheque related transaction.");
            				document.forms[0].acctId.focus();
            				document.forms[0].acctId.value = "";
            				return false; 
            			}
            		}	
            	}
            }*/
            var inputNameValues = "acctNum|" + obj.value + "|partTranType|" + pTranType;
            var outputNames = "";
            var scrName = "formatacctdp004.scr";
            var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
            var ret1 = retVal.split("|");
            if (ret1[0] == "MSG") 
			{
                alert(ret1[1]);
            }

            if (pTranType == "C") 
			{
                if (ret1[2] == "Y") 
				{
                    str = document.getElementById('tranParticular').value;
                    //alert(str);
                    if (str.indexOf(ret1[3]) == -1) 
					{
                        var argsVariable;
                        var answer = window.showModalDialog("../custom/jsp/shareorddp001.jsp?tramt=" + document.getElementById('refAmt').value, argsVariable, "dialogWidth:400px; dialogHeight:300px; center:yes");
                        if (answer != undefined) 
						{
                            document.getElementById('refAmt').value = answer.amt;
                            document.getElementById('tranParticular').value = answer.secrty + ret[3] + answer.prclmt;
                            document.getElementById('refNum').value = answer.crdno;
                            document.getElementById('tranRmks').value = answer.name;

                            element = document.getElementsByName("printAdvice");
                            if (element[0].checked != true) 
							{
                                //element[0].checked = true;
                                document.forms[0].printAdvice.disabled = true;
                                fnEnableDisableRadioButtons(document.getElementsByName("printAdvice"), 'D');
                            }
                        }
                    }
                }
            }
            if (pTranType == "D") 
			{
                if (ret1[2] == "Error") 
				{
                    alert(ret1[3]);
                }

                if (ret1[2] == "Sucess") 
				{
                    shareTrade();
                }
            }
        }
	}
	//Write Off - Start -Kim
	if(obj.id == "acctId")
	{
		var ObjForm = document.forms[0];
		if((tranType == "C") || (tranType == "T"))
		{
			//alert(pTranType);
			if (pTranType == "C")
			{
				//alert(tranType);
				if((tranSubType == "NR") || (tranSubType == "BI"))
				{
					//alert(tranSubType);
					var acct = document.forms[0].acctId.value;
					//alert(acct);
					var input      = "acct|"+acct;
					var outputNames    = "output|outVal";
					var scrName     =   "check_writeoff.scr";
					var retVal = fnExecuteScript(input,outputNames,scrName,false);
					var retBuff = retVal.split("|");
					var output = retBuff[0];
					var value = retBuff[1];
					var a = value;
					//alert(a);
					var retBuff = retVal.split("|");
					var output = retBuff[2];
					var value = retBuff[3];
					var b = value;
					//alert(b);
					var retBuff = retVal.split("|");
					var output = retBuff[4];
					var value = retBuff[5];
					var c = value;
					//alert(c);
					var retBuff = retVal.split("|");
					var output = retBuff[6];
					var value = retBuff[7];
					var d = value;
					//alert(d);
					if (a=="Y")
					{
						alert("WRITTEN OFF ACCOUNT");
						document.getElementById("acctId").value=d;
						document.getElementById("refNum").value=b;
						document.getElementById("tranRmks").value=c;
						document.getElementById("tranRmks2").value="WRITTENOFF";
					}
				}
			}
		}
	}
	//Write Off - End -Kim
}

function tmdet_post_ONCHANGE(obj) 
{
    if (obj.id == "acctId") 
	{
		fnAcctCrncyVal();
		//alert("here");
        //doLocalBioMetricVal(obj);
        var ObjForm = document.forms[0];
        if ((tranType == "C") || (tranType == "T")) 
		{
            if ((tranSubType == "NP") || (tranSubType == "PI") || (tranSubType == "CP") || (tranSubType == "CI")) 
			{
                if (pTranType == "D") 
				{


                    doLocalBioMetricVal();
                    //setSValue("bioStatus|"+"Q");
                    varbiotest = getSValue("bioStatus");
                    document.forms[0].varbiotest.value = getSValue("bioStatus");
                    setFieldsToCustomData("varbiotest");
                    //delSValue("bioStatus");
                    return true;
                }
            }
        }
    }
	if (obj.id == "refCrncy") {
                   fnAcctCrncyVal();
     }

    return true;
}

function doLocalBioMetricVal() 
{
    var myMopId = "";
    var retVal4Menu = "";
    var locCrDrInd = getRadioValue(frm.pTranType);
    /**************************************************************************************
     * Checking if the menu invoked is present in valMenu. Only if the
     * mopId is present in valMenu array the biometric validation has 
     * to be executed
     **************************************************************************************/
    if ((funcCode == "A") && (locCrDrInd == "D")) 
	{
        retVal4Menu = isBioValReq4Menu(mopId);
        if (retVal4Menu == true) 
		{

           var t= getFieldforBioAndCallBio(mopId);
		   
if(t == false)
{
document.forms[0].acctId.value = "";
 
}
        }
    }
    return true;
}

/*functionality moved to tmdet_custom_link.js*/
/*function tmdet_pre_ONCLICK(obj){
	if(funcCode == "A"){
		if ( obj.id == "grantTodFlg")
		{
			var grantTod = document.getElementsByName("grantTodFlg");
			if ( grantTod[0].checked )
			{
				var     inputNameValues    = "";
				var     outputNames        = "eventId";
				var     scrName            = "odchrgcalcmn001.scr";
				var     retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				if(ret[0]=="Error" && ret[1] != "dummy" )
				{
					alert(ret[1]);
				}

				if(ret[2]=="eventId" && ret[3] != "dummy" )
				{
					document.forms[0].chrgEventId.value = ret[3];
				}
			}
		}
	}
}*/
</script>
<INPUT type="hidden" name="custom.DenomEntered" id="DenomEntered" value="<%=sDenomEntered%>">
<INPUT type="hidden" name="custom.DenomCount" id="DenomCount" value="<%=sDenomCount%>" >
<INPUT type="hidden" name="custom.Event" id="Event" value="<%=sEvent%>" >
<INPUT type="hidden" name="custom.cifInfo" id="cifInfo" value ="<%=sCifInfo%>">
<INPUT type="hidden" name="custom.varbiotest" id="varbiotest" value ="<%=varbiotest%>">

<input type="hidden" name = "temp1" id = "temp1" > 
<input type="hidden" name = "temp2" id = "temp2" >

<input type="hidden" name = "cardNum" id = "cardNum"  value = "<%=cardNum%>">

<%/* Following hidden fields stores the arguments to be input for cust_fndenompopup function (separate by @) */%>
<INPUT type="hidden" name="custom.pTranTypes" id="pTranTypes" value="<%=sPTranTypes%>">
<INPUT type="hidden" name="custom.refCrncys" id="refCrncys" value="<%=sRefCrncys%>">
<INPUT type="hidden" name="custom.refAmts" id="refAmts" value="<%=sRefAmts%>">
<INPUT type="hidden" name="custom.acctIds" id="acctIds" value="<%=sAcctIds%>">
<INPUT type="hidden" name="custom.isCashAcct" id="isCashAcct" value="<%=sIsCashAcct%>">
<INPUT type="hidden" name="custom.temp" id="temp" value="<%=temp%>">

<input type="hidden" name = "ieTxnRefNo" id = "ieTxnRefNo" >
<input type="hidden" name = "ieTxnRefAmt" id = "ieTxnRefAmt" >
<input type="hidden" name = "ieTxnRefCrncy" id = "ieTxnRefCrncy" >
<input type="hidden" name = "ieTxnAcctId" id = "ieTxnAcctId" >
<input type="hidden" name = "ieTxnPartTranSrlNum" id = "ieTxnPartTranSrlNum" >

<!------------changes added as a part of TO/CR no : 348467---------------------------->
<script>
//alert(mopId.toUpperCase());
if((mopId.toUpperCase()=="HCASHDEP")||(mopId.toUpperCase()=="HTM")||(mopId.toUpperCase()=="HCASHWD"))
{
	with (document) 
	{
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
		write('<td colspan="5"><h1 class="subhdr" style="font-size:12">Account Ledger Inquiry</h1></td>');
		write('</tr>');
		write('<tr>');
		write('<td class=textlabel2>Ledger Details</td>');
		write('<td class=textfielddisplaylabel6col><A id=\"cust1\" href=\"javascript:showLedgerDetails()\" ><img  src=\"../Renderer/images/INFENG/explode.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search99\"></a>');
		write('<td>');
		write('</td>');
		write('</tr>');
		if (tranType=="C")
		{
			write('<tr>');
			write('</tr>');
			write('<tr class="subhdrbg">');
			write('<td colspan="5"><h1 class="subhdr" style="font-size:12">Teller Balance Details (All Currencies)</h1></td>');
			write('</tr>');
			write('<tr>');
			write('<td class=textlabel2>Teller GL Balance</td>');
			write('<td class=textfielddisplaylabel6col><A id=\"cust2\" href=\"javascript:showTellerDtls()\" ><img  src=\"../Renderer/images/INFENG/explode.gif\" width=\"16\" height=\"17\" border=\"0\" hotKeyId=\"search99\"></a>');
			write('<td>');
			write('</td>');
			write('</tr>');
		}
	
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

</script>

<script>
function fnSetIeTxnCustData() 
{
    var ObjForm = document.forms[0];
    var ieTxnRefNo = ObjForm.ieTxnRefNo.value;
    var ieTxnAcctId = ObjForm.ieTxnAcctId.value;
    var ieTxnRefAmt = ObjForm.ieTxnRefAmt.value;
    var ieTxnRefCrncy = ObjForm.ieTxnRefCrncy.value;
    var ieTxnPartTranSrlNum = "";

    for (var iIndex = 0; i < ObjForm.elements.length; iIndex++) 
	{
        if (ObjForm.elements[iIndex].name == "partTranDetail_LowLimit") 
		{
            ieTxnPartTranSrlNum = ObjForm.elements[iIndex].value;
            break;
        }
    }

    ObjForm.ieTxnPartTranSrlNum.value = ieTxnPartTranSrlNum;
    var inputNameValues = "operationCode|S|ieTxnRefNo|" + ieTxnRefNo + "|partTranSrlNum|" + ieTxnPartTranSrlNum;
    var outputNames = "";
    var scriptName = "cietxndp052.scr";
    var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);
}

function fnGetIeTxnCustData() 
{
    var ObjForm = document.forms[0];
    var inputNameValues = "operationCode|G";
    var outputNames = "errorFlg|errorMsg|ieTxnRefNo|partTranSrlNum";
    var scriptName = "cietxndp052.scr";
    var retVal = appFnExecuteScript(inputNameValues, outputNames, scriptName, false);

    var token = retVal.split("|");
    if (token != undefined) 
	{
        var errorFlg = token[1];
        var errorMsg = token[3];
        var ieTxnRefNo = token[5];
        var partTranSrlNum = token[7];

        if (errorFlg == "Y") 
		{
            // No IEPAGL customization
        } 
		else 
		{
            // IEPAGL customization
            ObjForm.ieTxnRefNo.value = ieTxnRefNo;
            ObjForm.ieTxnPartTranSrlNum.value = partTranSrlNum;
        }
    }
}

function fnDisableFieldsForPymtToAcctGL() 
{
    var ObjForm = document.forms[0];
    fnGetIeTxnCustData();
    var ieTxnRefNo = ObjForm.ieTxnRefNo.value;
    var ieTxnPartTranSrlNum = ObjForm.ieTxnPartTranSrlNum.value;
    var partTranSrlNum = "";

    for (var iIndex = 0; i < ObjForm.elements.length; iIndex++) 
	{
        if (ObjForm.elements[iIndex].name == "partTranDetail_LowLimit") 
		{
            partTranSrlNum = ObjForm.elements[iIndex].value;
            break;
        }
    }

    if (partTranSrlNum != ieTxnPartTranSrlNum) 
	{
        return;
    }

    if (!fnIsNull(ieTxnRefNo)) 
	{
        ObjForm.acctId.readOnly = true;
        ObjForm.refAmt.readOnly = true;
        ObjForm.refAmt.readOnly = true;
        ObjForm.refCrncy.readOnly = true;
        ObjForm.rate.readOnly = true;
        ObjForm.tranParticular.readOnly = true;
        ObjForm.tranRmks.readOnly = true;
        ObjForm.tranRmks2.readOnly = true;
        ObjForm.refNum.value = ObjForm.ieTxnRefNo.value;
        ObjForm.refNum.readOnly = true;
        hideImage("sLnk4");
        hideImage("sLnk7");
        hideImage("sLnk10");
    }
}

function callTrRefNoSearcher(trRefNumLoc, link) 
{
    //	alert("inside kiva");
    //enableFields("rateCode", "rate", "treaRate");
	enableFields("rate", "treaRate");
    //frm.rateCode.value = "";
    //frm.rate.value = "";
    //frm.treaRate.value = "";
    trRefNum = trRefNumLoc;
    showDynCritSearcher('HTREFNO', 'tr_ref_num=:document.forms[0].treaRefNum', ':document.forms[0].treaRefNum=tr_ref_num|:document.forms[0].rateCode=ratecode|:document.forms[0].rate=cust_rate|:document.forms[0].treaRate=treasury_rate');
    if (!fnIsNull(frm.rateCode.value) && !fnIsNull(frm.rate.value) && !fnIsNull(frm.treaRate.value)) 
	{
        disableFields("rateCode", "rate", "treaRate");
        if (link == '9') {
            tmDisableLink("sLnk10");
        }
        if (link == '11') {
            tmDisableLink("sLnk12");
        }
        computeAmt('rate');
    }

    document.forms[0].treaRate.disabled = true;
    document.forms[0].rate.disabled = true;

}
function post_ONLOAD(obj) 
{
//alert(mopId);
//alert(document.forms[0].acctId.value);
if (document.forms[0].acctId.value!="")
{
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
//alert(getSValue("bioStatus"));
if(getSValue("bioStatus") == "F")
{
document.forms[0].acctId.value="";
document.forms[0].acctSolId.value="";
document.forms[0].refCrncy.value="";
document.forms[0].acctName.value="";
document.forms[0].acctLabelCrncy.value="";
document.forms[0].acctCrncy.value="";
document.forms[0].refAmt.focus();

}
	if( funcCode != "I"){
var temprefCrncy=document.forms[0].refCrncy.value;
var temprate=document.forms[0].rate.value;
var temprateCode=document.forms[0].rateCode.value;
var temptreRate = document.forms[0].treaRate.value;
document.forms[0].rateCode.disabled = true;
document.forms[0].rate.disabled = true;
if((document.forms[0].treaRefNum.value == "") && (document.forms[0].refCrncy.value != "") && (document.forms[0].acctLabelCrncy.value != ""))
{
	fnAcctCrncyVal();
}
hideImage("sLnk10");
hideImage("sLnk8");
ratecodewrkclscheck();
	if(tranType == "C")
	{
		if( workClass <= "515")
		{
			if(tranSubType == "NP")
			{
			
				document.forms[0].PostPartTran.disabled = true;

			}
		}

		if(tranSubType == "NR")
		{
				var radioButtons = document.getElementsByName('printAdvice');
				radioButtons[0].checked = true;
				//radioButtons[1].checked = true;
		}
		if(tranSubType == "CR")
                        {
                                   var radioButtons = document.getElementsByName('printAdvice');
                                    radioButtons[0].checked = true;
                                    //radioButtons[1].checked = true;
                        }

	}
	if ( workClass <= "060")
	{
		document.forms[0].PostPartTran.disabled = true;

		if ((profileId==56)&& (mopId == "HTM"))
		{
			//alert("am in ok");
			var grantTod = document.getElementsByName("grantTodFlg");
			grantTod[0].disabled = true;
			//alert("ammm iin ok");
		}
	}
	if (document.forms[0].treaRefNum.value!="")
	{
		//alert(document.forms[0].treaRefNum.value);
		document.forms[0].treaRate.disabled = true;
        document.forms[0].rate.disabled = true;
		document.forms[0].treaRefNum.disabled = true;
		document.forms[0].rateCode.disabled = true;
		ratecodewrkclscheck();
		//alert("inside kiva4");
	}
	if (document.forms[0].rateCode.value!="")
	{
		//alert(document.forms[0].treaRefNum.value);
		//alert(workClass);
		if (workClass !="240")
		{
			document.forms[0].treaRate.disabled = true;
			document.forms[0].rate.disabled = true;
			document.forms[0].treaRefNum.disabled = true;
			document.forms[0].rateCode.disabled = true;
			ratecodewrkclscheck();
			//alert("inside kiva4");
		}
	}

    if (workClass <= "600") 
	{
        var e = document.getElementById("Save")
        if (e != undefined) 
		{
            (e.style.display == 'none') ? e.style.display = 'block': e.style.display = 'none';
        }
    }
	if((tranType == "C") || (tranType == "T")){
		if((pTranType == "C")||(pTranType == "D")){
	if( funcCode != "I"){
			if((document.forms[0].acctId.value!="") &&(document.forms[0].refAmt.value!="") ){
				//alert("TO check the treasury rate code");
				//fnAcctCrncyVal();
				var frm = document.forms[0];				
				if((frm.tranParticular.value=="") && (frm.refNum.value=="") &&(frm.tranRmks.value=="")){
					var ObjForm = document.forms[0];
					var acctId = ObjForm.acctId.value;
					var inputNameValues = "acctId|"+acctId;
					var outputNames = "tranParticular|refNum|tranRmks";
					var scriptName = "get_tran_details_bill.scr";
					var retVal = fnExecuteScript(inputNameValues,outputNames,scriptName,false);

					var token = retVal.split("|");
						
					if(token[1] != 1 ){
						//    alert("Y");
						ObjForm.tranParticular.value = token[1];
						ObjForm.refNum.value = token[3];
						ObjForm.tranRmks.value = token[5];
					} else {
						//       alert("N");
					}
				}	
			}
		}
	}
	}
		
	if( funcCode == "A")
	{
		if(tranSubType == "NR")
		{
			//element = document.getElementsByName("printAdvice");
			//element[0].checked = false;
			if (document.forms[0].acctId.value!="")
			{
				var acctId = document.forms[0].acctId.value;
				var input      = "acctId|"+acctId;
				//alert(acctId);
				var outputNames    = "biller_chk_flg";
				var scrName     =   "Biller_Acct_check.scr";
				var retVal = fnExecuteScript(input,outputNames,scrName,false);
				var retBuff = retVal.split("|");
				var biller_chk_flg = retBuff[1];
				if (biller_chk_flg=='Y')
				{
						element = document.getElementsByName("printAdvice");
						element[0].checked = false;
				}
				if (biller_chk_flg=='N')
				{
						element = document.getElementsByName("printAdvice");
						element[0].checked = true;
				}
			}
				////
		}
		if((tranSubType == "NP") || (tranSubType == "CP") || (tranSubType == "PI"))
		{
			document.forms[0].option.selectedIndex = 7;
			var radioButtons = document.getElementsByName('printAdvice');
			radioButtons[0].checked = false;
			radioButtons[1].checked = false;
			radioButtons[2].checked = true;
			document.forms[0].printAdvice.disabled = true;
			fnEnableDisableRadioButtons(document.getElementsByName("printAdvice"),'D');
		}
	}
    //Kim-start Disabling partrans in C/NP and defaulting Z
    if (tranType == "C") 
	{
        if ((tranSubType == "NP") || (tranSubType == "PI"))
		{
            //alert("Hide image");
            hideImage(multiRecName + "_NextRec");
            hideImage(multiRecName + "_PrevRec");
            hideImage(multiRecName + "_AddNew");

            //alert("Removing C");
            fnRemoveOption(document.forms[0].option, "C");
			fnRemoveOption(document.forms[0].option,"E");

            //alert("Defaulting Z");

            //var copyPTran =(document.forms[0].option,"Z");
            //alert(document.forms[0]);

            //alert(copyPTran);

            //alert(document.forms[0].option.selectedIndex);

            document.forms[0].option.selectedIndex = 5;

            //alert(document.forms[0].option.selectedIndex);

        }

    }
    //Kim-start Disabling partrans in C/NP and defaulting Z

//Below steps added for populating Pay To GL credit leg details
	fnPopulatePayGLCredit();
document.forms[0].refCrncy.value=temprefCrncy;
if((temprate != "") && (temprateCode !="") && (temptreRate != ""))
{
	document.forms[0].rate.value = temprate;
	document.forms[0].rateCode.value = temprateCode;
	document.forms[0].treaRate.value = temptreRate;
}
}
}
function tmdet_ONCLICK23(obj,p1)
{
	//alert("Cancel");
	var input      = "";
	var outputNames    = "";
	var scrName     =   "temp_bill_delete.scr";
	var retVal = fnExecuteScript(input,outputNames,scrName,false);
        
	//alert("deleted");
	var retVal = "";
	if (preEventCall('tmdet',obj,'ONCLICK') == false) {
			return false;
	}
	if (preEventCallForLocale('tmdet',obj,'ONCLICK') == false) {
			return false;
	}
	if ((retVal = fnOnButtonClick(p1)) == false) {
			return false;
	}
	if (postEventCallForLocale('tmdet',obj,'ONCLICK') == false) {
			return false;
	}
	if (postEventCall('tmdet',obj,'ONCLICK') == false) {
			return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function custom_ONBLUR(a,obj)
{
	if(obj.id =="acctId")
	{
	fnAcctCrncyVal();
	}
	if(obj.id =="refCrncy")
	{
		fnAcctCrncyVal();
	}
	if(obj.id =="pTranType")
	{
		fnAcctCrncyVal();
	}
}

function fnAcctCrncyVal() 
{
	if((funcCode == "A") || (funcCode == "C") || (funcCode == "M"))
	{	
    if (tranType == "T" || tranType == "C") {

	var acctId = document.forms[0].acctId.value;
	
	//var acctCrncy = document.forms[0].acctLabelCrncy.value;
	var refCrncy = document.forms[0].refCrncy.value;
	var drCrInd = getRadioValue(document.forms[0].pTranType);
	var AmtVal = removeCommas(document.forms[0].refAmt.value);
	
	if(acctId!='')
	{
		var inputNames = "acctId|" + acctId + "|refCrncy|" + refCrncy + "|tranType|" + tranType +"|drCrInd|" + drCrInd +"|AmtVal|" + AmtVal;
	}
	else
	{
		var acctCrncy = document.forms[0].acctLabelCrncy.value;
		var inputNames = "acctCrncy|" + acctCrncy + "|refCrncy|" + refCrncy + "|tranType|" + tranType +"|drCrInd|" + drCrInd;
		return true;
	}
	var outputNames = "rateCode|rate|treaRate|errorFlg|errorMsg";
	var scr = "ratecodehtm.scr";
	var retVal = appFnExecuteScript(inputNames, outputNames, scr, false);
	var result = retVal.split("|");
	var rateCode = result[1];
	var rate = result[3];
	var treaRate = result[5];
	var errorFlg = result[7];
	var errorMsg = result[9];

	if (errorFlg != "Y") 
	{
	    document.forms[0].rateCode.value = rateCode;
	    document.forms[0].rate.value = rate;
	    document.forms[0].rateCode.disabled = true;
	    document.forms[0].rate.disabled = true;
	    document.forms[0].treaRate.value = treaRate;
	    document.forms[0].treaRate.disabled = true;
	    hideImage("sLnk10");
		ratecodewrkclscheck();
	} 
	else
	{
	    showImage("sLnk10");
	    document.forms[0].rateCode.value = '';
	    document.forms[0].rate.value = '';
	    document.forms[0].rateCode.disabled = false;
	    document.forms[0].rate.disabled = false;
	    document.forms[0].treaRate.disabled = false;
	    document.forms[0].treaRate.value = '';
	}
    }
	}
    return true;
}

function ratecodewrkclscheck()
{
        //var workClass = workClass;
        //var inputNames = "workClass|" + workClass;
        var inputNames = "";
        var outputNames = "";
        var scr = "workclassCheck.scr";
        var retVal = appFnExecuteScript(inputNames, outputNames, scr, false);
        var result = retVal.split("|");
        var errFlg = result[1];
        var errMsg = result[3];
        var wrkclsFlg = result[5];

        if(errFlg == "N")
        {
                if (wrkclsFlg == "Y")
                {
                        document.forms[0].rateCode.disabled = false;
                        document.forms[0].rate.disabled = false;
                        document.forms[0].treaRate.disabled = false;
                        document.forms[0].treaRefNum.disabled = false;
                        showImage("sLnk10");
                }
        }
        else
        {
                alert(errMsg);
        }
return true;
}

</script>


<!------------end of  TO/CR no : 348467---------------------------->


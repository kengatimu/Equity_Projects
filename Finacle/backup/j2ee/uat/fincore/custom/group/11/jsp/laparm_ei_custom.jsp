<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : laparm_ei_custom.jsp 
<!--Description         : This jsp is used to populate default values in case of Add Mode
<!--Date                : 31-03-2013
<!--Author              : Sateesh 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HOAACLA
<!--Modification History:
<!--	Version No.	      	Date		         Author		Description
<!--	-------        		----------        	-----------	------------------
<!--     0.1	    		31-03-2013	        Sateesh		Original version
<!--	 0.2				03-07-2013			Kalvin		Modified for TO:356308
<!--														
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<%@ include file="../../commonInclude.jsp" %>

<script type="text/javascript">
/*-----changes made for TO/CR: 356308----------------*/
function pre_ONLOAD(obj)
{
	getFieldsFromCustomData("schmCode");
}
/*-------------end of change-----------------------------*/
function post_ONLOAD(obj) 
{		
	if(mopId == "HOAACLA")
	{
		if(sMode=="A")
		{
			var instartDate=document.forms[0].intStartDate_ui;
			/*-----changes made for TO/CR: 356308----------------*/
			var instlStartDate =document.forms[0].instlmntStartDate_ui;
			var schmCode = document.forms[0].customData.value;
			/*-------------end of change-----------------------------*/
			instartDate.onchange = function(){fnSetFlowId()};
			/*-----changes made for TO/CR: 356308----------------*/
			instlStartDate.onchange =function(){fnCalcuatePerd(schmCode,document.forms[0].instlmntStartDate_ui)};
			/*-------------end of change-----------------------------*/
		}
	}
	//-------------356308 start-----------------------------------
	if(mopId == "HOAACMLA")
	{
			var custData = document.forms[0].customData.value;
			var custDataVal = custData.split("|");
			var dco = custDataVal[1];
			//var dco =document.forms[0].customData.value;
			//alert(document.forms[0].customData.value);
			//alert(dco);
			var input      = "dco|"+dco;
			var outputNames    = "schm|outVal";
			var scrName     =   "b_loanschm.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var a = value;
			//alert(a);
			var instartDate=document.forms[0].intStartDate_ui;
			var instlStartDate =document.forms[0].instlmntStartDate_ui;
			var schmCode =a;
			//alert(schmCode);
			instartDate.onchange = function(){fnSetFlowId()};
			instlStartDate.onchange =function(){fnlaCalcuatePerd(schmCode,document.forms[0].instlmntStartDate_ui)};
			instlStartDate.onblur =function(){instStrtDateVal()};
			document.forms[0].instlmntStartDate_ui.focus();
		
	}
	//-------------356308 end-----------------------------------
}

function fnSetFlowId()
{
	var instartDt=document.forms[0].intStartDate_ui.value;
	var instdd=instartDt.substr(0,2);
	document.forms[0].intFreqStartDate.value=instdd;
}
/*-----changes made for TO/CR: 356308----------------*/
	function fnCalcuatePerd(schmCode,objDate)
{
	var retVal = "";
	if ((retVal = fnEventFormatDate(objDate)) == false) {
	return false;
	}

	if ( document.forms[0].eiFreqType.value != "B" ) {
	var instlmentDay = (document.forms[0].instlmntStartDate_ui.value).substring(0 ,2);
	document.forms[0].eiFreqStartDate.value = parseFloat(instlmentDay,0);
	}

	var schmCodeTemp =schmCode.split("|");
	var schmCode =schmCodeTemp[1];
	var instlmntStrtDate=document.forms[0].instlmntStartDate_ui.value;
	var input = "instlmntStrtDate|"+instlmntStrtDate + "|" + "schmCode" + "|" + schmCode;	
	var scrName  = "hldyPerdmn001.scr";
    var output   = "hldyPerdMths";
    var retVal = appFnExecuteScript(input,output,scrName,false);
	if(retVal != undefined)
	{
        var value = retVal.split("|");
		if (value[1] =="0")
		{
		 document.forms[0].hldyPerdMths.value="1"
		}
		else
		{
        document.forms[0].hldyPerdMths.value = value[1];
		}
	}
}

//-------------356308 start-----------------------------------
function fnlaCalcuatePerd(schmCode,objDate)
{
	var retVal = "";
	if ((retVal = fnEventFormatDate(objDate)) == false) {
	return false;
	}
	var instlmntStrtDate=document.forms[0].instlmntStartDate_ui.value;
	var input = "instlmntStrtDate|"+instlmntStrtDate + "|" + "schmCode" + "|" + schmCode + "|" + "acctOpenDate" + "|" + sShCrDate;
	var scrName  = "hldyPerdmn001.scr";
    var output   = "hldyPerdMths";
    var retVal = appFnExecuteScript(input,output,scrName,false);
	if(retVal != undefined)
	{
        var value = retVal.split("|");
		if (value[1] =="0")
		{
		 document.forms[0].hldyPerdMths.value="1"
		}
		else
		{
        document.forms[0].hldyPerdMths.value = value[1];
		}
	}
}

//-------------356308 end-----------------------------------

/*-------------end of change-----------------------------*/
function laparm_ei_ONCHANGE(obj)
{
	if( mopId == "HOAACLA" )
	{
		if(sMode=="A")
		{
			if ( obj.id == "eiFreqType" ) {
				if ( document.forms[0].eiFreqType.value == "B" ) {
					document.forms[0].eiFreqStartDate.selectedIndex = 0;
				}
				else {
					if ( document.forms[0].eiFreqType.value != "B" ) {
					var instlmentDay = (document.forms[0].instlmntStartDate_ui.value).substring(0 ,2);
					document.forms[0].eiFreqStartDate.value = parseFloat(instlmentDay,0);
					}
				}
			}
		}
	}
}
</script>


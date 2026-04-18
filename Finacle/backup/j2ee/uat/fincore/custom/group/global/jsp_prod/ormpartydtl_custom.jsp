<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : ormpartydtl_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.This script used to make the field manadatory.
<!--Date                : 28-02-2013
<!--Author              : Shilpa
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HORM/HIRM
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------         -----------        ------------------
<!--     0.1            28-02-2013           Shilpa           Original version
<!--     0.3            14-06-2013           Samrat Saha          custom field added
<!---------------------------------------------------------------------------------------------------------------->
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="ormparty" isEntryPoint="false" />
<custom:getRepository/>
<script type ="text/javascript">


<%
String sRemitId   =   (String)ARJspCurr.getInputWithGroup("remitId", "");
String sRemitType =   (String)ARJspCurr.getInputWithGroup("remitType", "");
String remitCcy = 	(String)ARJspCurr.getInputWithGroup("remitCcy", "");
%>
var remitId		= '<%=sRemitId%>';
var remitType	= '<%=sRemitType%>';
var tempRemitCrncy = "<%=remitCcy%>";

var frontCurry = tempRemitCrncy;

with (document)
{
	if(mopId == "HORM") 	
     {
       	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable" >');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable" >');
        write('<tr>');
        write('<td>');
        write('<table width="100%" border="0" cellpadding="4" cellspacing="5" class="innertabletop1">');
        write('<tr>');
        write('<td class="textlabel">Fed Wire Number/Sort Code</td>');
        write('<td>');
        write('<input class="textfieldfont" type="text" name="fedWire" id="fedWire" size="2" maxlength="30">&nbsp;&nbsp;');
        write('</td>');
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
      }
//=====================================================================================================
		var inputNameValues	= "";
		var outputNames		= "";
		var scrName		= "s_trf0031dp002.scr";
		var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
		var ret = retVal.split("|");
		
		
		if( ret[0] == "benCntryCodeUs" && ret[1] != "dummy" )
		{
			var benCntryCodeUs = ret[1]; 
		}

		if( ret[2] == "benCntryCodeUk" && ret[3] != "dummy" )
		{
			var benCntryCodeUk = ret[3];
		}
		if( ret[4] == "remitCrncyUs" && ret[5] != "dummy" )
		{
			var remitCrncyUs = ret[5]; 
		}
		if( ret[6] == "remitCrncyUk" && ret[7] != "dummy" )
		{
			var remitCrncyUk = ret[7]; 
		}
		if( ret[8] == "benCntryCodeDetUs" && ret[9] != "dummy" )
		{
			var benCntryCodeDetUs = ret[9]; 
		}
		if( ret[10] == "benCntryCodeDetUk" && ret[11] != "dummy" )
		{
			var benCntryCodeDetUk = ret[11]; 
		}
		if( ret[12] == "fedWireLengthCparam" && ret[13] != "dummy" )
		{
			var fedWireLengthCparam = ret[13]; 
		}
		if( ret[14] == "sortCodeLengthCparam" && ret[15] != "dummy" )
		{
			var sortCodeLengthCparam = ret[15]; 
		}
		if( ret[16] == "remitCrncyUk" && ret[17] != "dummy" )
		{
			var remitCrncyUk = ret[17]; 
		}
}
//--------------------------------------------------------
function post_ONLOAD(obj){

	if(mopId == "HORM")
		{
			if(funcCode == "M" ||funcCode == "V"||funcCode == "X" ||funcCode == "I"||funcCode == "J") 
			{
				getFieldsFromCustomData("fedWire");

				if(document.forms[0].fedWire.value =="")
				{
					inputNameValues = "remitId|"+remitId+"|";
					outputNames = ""
					scrName = "s_trf0031dp001.scr";
					retVal  = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
					retmsg = retVal.split("|");

					if(retmsg[1]!="Err")
					{
						if(retmsg[1]=="nvl")
						{
							document.forms[0].fedWire.value = "";
							var countOfRecord= retmsg[3]
						}
						else
						{
							document.forms[0].fedWire.value = retmsg[1]
							var countOfRecord= retmsg[3]

						}
					}
					else
					{
						document.forms[0].fedWire.value = "";
						var countOfRecord= retmsg[3]
					}
				}
			}
			if((funcCode == "I")||(funcCode == "R")||(funcCode == "G")||(funcCode == "S")||(funcCode == "W"))
			{
				document.forms[0].fedWire.disabled=true;
			}		
		}
	
//--------------------------------------------------------------
       if((funcCode == 'J')||(funcCode == 'M')){
		var custData = document.forms[0].customData.value;
		var custSplit = custData.split('|')
		var length = custSplit.length;
		var myString = custData;
		var oprAcctLen = myString.search("~ormgendtl");
		var remitTypeLen = myString.search("~ormcrit");
		var newremitType = myString.substring(remitTypeLen ,myString.length);
		var newoprAcct = myString.substring(oprAcctLen,myString.length);
		var custPayDataSplit = newremitType.split('|');
		remitType = custPayDataSplit[1].toUpperCase();
		var custPayDataSplit1 = newoprAcct.split('|');
		oprAcct= custPayDataSplit1[1];

		/*if(oprAcct!= "" && document.forms[0].partyCifId.value == ""){
			var	inputNameValues    = "oprAcct"+ "|" +oprAcct;
			var	outputNames        = "cifId";
			var	scrName            = "rmdfltpopmn004.scr";
			var	retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
			var ret = retVal.split("|");
			var custId= ret[1];
			document.forms[0].partyCifId.value = custId;
		}
		*/
	}
}

function ormpartydtl_pre_ONCLICK(obj){
if(mopId == "HORM")
	{	
		/*
		if((funcCode == 'J' || funcCode == 'M') && (obj.id == "Submit" || obj.id == "Validate")){
        
        var benefName= document.forms[0].benefName.value;
			if(benefName== ""){
				alert("Enter Drawee Bank Name"); 
				document.forms[0].benefName.focus(); 
				return false;
			}
		}
		*/
		return fnValidateCust();
		
	}
//------------------------------------------------------------------------
       
}

function ormpartydtl_pre_TAB_SWITCH(obj){

	if(mopId == "HORM")
	{
    	if((funcCode == 'J') || (funcCode == 'M')){ 
    		
    		var benefName= document.forms[0].benefName.value;
        	if(benefName== ""){
            	alert("Enter Drawee Bank Name");
            	document.forms[0].benefName.focus();
            	return false;
        	}
    	}
			return fnValidateCust();
	}
	//-------------------------------------------------------
	
}

//---------------------------------------------------------
function fnValidateCust()
{
	var benCntry = (document.forms[0].benefCntry.value).toUpperCase();
	var partyCntry = (document.forms[0].partyCntry.value).toUpperCase();
	if(document.forms[0].fedWire.value!="")
	{
		var fedWireLength =	(document.forms[0].fedWire.value).length;		
		var benCntry = (document.forms[0].benefCntry.value).toUpperCase();
		var partyCntry = (document.forms[0].partyCntry.value).toUpperCase();

		if((benCntry == benCntryCodeUk|| partyCntry == benCntryCodeDetUk)&& (fedWireLength >sortCodeLengthCparam)&& (frontCurry==remitCrncyUk))
		{
			alert("please enter Sort code of 6 Characters If Country is UK");
			return false;
		}
		if((benCntry == benCntryCodeUs || partyCntry == benCntryCodeDetUs)&& (fedWireLength >fedWireLengthCparam)&& (frontCurry==remitCrncyUs))
		{
			alert("please enter Fed Wire of 9 Characters If Country is US");
			return false;
		}
	}
	else
	{
		if(document.forms[0].fedWire.disabled == false)
		{	
			if((benCntry == benCntryCodeUs || partyCntry == benCntryCodeDetUs)&&(frontCurry==remitCrncyUs))
			{
				
				alert("please enter Fed Wire/Sort Code If the country Code is US and Remitance currency is USD");
				return false;
			}
			
			if((benCntry == benCntryCodeUk|| partyCntry == benCntryCodeDetUk)&&(frontCurry==remitCrncyUk))
			{
				alert("please enter Fed Wire/Sort Code If the country Code is UK and Remitance currency is GBP");
				return false;
			}
		}	
	}
	
	setFieldsToCustomData("fedWire","partyName","partyAddr1");	
}	


</script>



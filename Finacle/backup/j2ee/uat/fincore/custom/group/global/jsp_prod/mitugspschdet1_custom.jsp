<!--------------------------------------------------------------------------------------------------------------->
<!--    Name                    : mitugspschdet1_custom.jsp                                                         -->
<!--    Menu                    : MITUGSP                                                                      -->
<!--    Author                  : Swati Ganjoo                                                                   -->
<!--    Description             : Customization to add new fields and validations                              --> 
<!--    Modification History                                                                                   -->
<!--    <Serial No>    <Date>           <Author>        <Description>                                          -->  
<!--------------------------------------------------------------------------------------------------------------->
<%@ include file="../commonInclude.jsp" %>
<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="java.util.*" %>
<%@ page session="true"%>
	
<SCRIPT language="javascript" src="../../javascripts/common_functions.js" ></SCRIPT>
<SCRIPT language="javascript" src="../../javascripts/cust_post_evt.js" ></SCRIPT>
<SCRIPT language="javascript" src="../../javascripts/cust_pre_evt.js" ></SCRIPT>
<script language="Javascript" src="../Renderer/javascripts/lists/showBacid.js"> </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script>

var objForm = document.forms[0];


	// Fields added for MITUGSP

	if((mopId.toUpperCase()=="MITUGSP"))
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
			write('<td colspan="5"><h1 class="subhdr" style="font-size:12">With Holding Tax Details (All Currencies)</h1></td>');
                        write('</tr>');
			write('<tr>');
			write('<td class="textlabel">Withholding Tax Applicable <span  style="color:red" ></span></td>');
			write('<td class="textfield">');
			write('<input type="radio" name="withdTaxAppFlg" value="Y" id="withdTaxAppFlg" onClick="javascript:return getRadioValue1();" size="1" maxlength="1" /> Yes');
			write('<input type="radio" name="withdTaxAppFlg" value="N" id="withdTaxAppFlg" onClick="javascript:return getRadioValue1();" size="1" maxlength="1" /> No');
			write('</td>');
			write('<input type="hidden" class="text" name="flgRadioSwitch" id="flgRadioSwitch" size="10" maxlength="1" value=""></td>');
			write('<td>');
			write('</td>');
			write('</tr>');
			write('<tr>');
			
			
			
			write('<tr>');
			write('<td class="textlabel">Withholding Tax Percentage  <span  style="color:red"></span></td>');
			write('<td class="textfield">');
			write('<input type="text" class="textfieldfont" id="withdTaxPrcnt" name="withdTaxPrcnt" disabled="disabled">');
			write('</td>');
			write('<td class="textlabel">Withholding Tax Placeholder <span  style="color:red"></span></td>');
			write('<td class="textfield">');
			write('<input type="text" class="textfieldfont" id="withdTaxPlcHldr" name="withdTaxPlcHldr" disabled="disabled" >&nbsp;');
			write('<a href="javascript:fnshowBacidPlhdr()" id="showBacidPlhdr">');
			write('<img border="0" height="17" hotKeyId="search2" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
			write('</a>');
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

/*******************************************************************	
*Name:		mitugspschdet1_pre_ONLOAD
*Description: 	Pre on Load functions   
*******************************************************************/

function mitugspschdet1_pre_ONLOAD(obj)
{
	
	getFieldsFromCustomData("withdTaxPrcnt","withdTaxPlcHldr","flgRadioSwitch");
	
	

	if(document.forms[0].flgRadioSwitch.value=="")
	{
		
		document.forms[0].withdTaxPrcnt.value=""; 
		document.forms[0].withdTaxPlcHldr.value=""; 
		document.forms[0].withdTaxPrcnt.disabled=true; 
		document.forms[0].withdTaxPlcHldr.disabled=true;
		document.forms[0].withdTaxAppFlg[1].checked=true;
		document.forms[0].flgRadioSwitch.value="N";
		hideImage("showBacidPlhdr");
		
		
	}
	else
	{
		if(document.forms[0].flgRadioSwitch.value=="Y")
		{
			document.forms[0].withdTaxAppFlg[0].checked=true;
			document.forms[0].withdTaxAppFlg[1].checked=false;
			document.forms[0].withdTaxPrcnt.disabled=false; 
			document.forms[0].withdTaxPlcHldr.disabled=false;
			showImage("showBacidPlhdr");
			
		}
		else
		{
			document.forms[0].withdTaxAppFlg[1].checked=true;
			document.forms[0].withdTaxAppFlg[0].checked=false;
			document.forms[0].withdTaxPrcnt.disabled=true; 
			document.forms[0].withdTaxPlcHldr.disabled=true;
			hideImage("showBacidPlhdr");
		}
	}
	
	
	if((funcCode=="I") || (funcCode=="D") || (funcCode=="X") || (funcCode=="U") || (funcCode=="V") || (funcCode=="B") || (funcCode=="G"))
	{
		document.forms[0].withdTaxPrcnt.disabled=true; 
		document.forms[0].withdTaxPlcHldr.disabled=true;
		document.forms[0].withdTaxAppFlg[0].disabled=true;
		document.forms[0].withdTaxAppFlg[1].disabled=true;
		hideImage("showBacidPlhdr");
		
	}
	
}


/*******************************************************************	
*Name:		getRadioValue1
*Description: 	Gets called on click of WithHolding Tax applicable 
*               Radio button
*******************************************************************/

function getRadioValue1()
{
	
 	if(getRadioValue(document.forms[0].withdTaxAppFlg)=="Y")
   	{
        	document.forms[0].withdTaxPrcnt.disabled=false;
		document.forms[0].withdTaxPlcHldr.disabled=false;
		document.forms[0].flgRadioSwitch.value="Y";
		showImage("showBacidPlhdr");
	
   	}
  	else
  	{
  		document.forms[0].withdTaxPrcnt.value=""; 
		document.forms[0].withdTaxPlcHldr.value=""; 
		document.forms[0].withdTaxPrcnt.disabled=true; 
		document.forms[0].withdTaxPlcHldr.disabled=true;
		document.forms[0].flgRadioSwitch.value="N";
		hideImage("showBacidPlhdr");
  	}
}
//ends here

/*******************************************************************	
*Name:		mitugspschdet1_pre_TAB_SWITCH
*Description: 	Gets called on switching tab 
*               
*******************************************************************/
function mitugspschdet1_pre_TAB_SWITCH(obj)
{
	
	var value1=document.forms[0].withdTaxAppFlg[1].checked
	if( value1== true)
	{
		document.forms[0].flgRadioSwitch.value="N";
		hideImage("showBacidPlhdr");
	
	}
	else
	{
		document.forms[0].flgRadioSwitch.value="Y";
		showImage("showBacidPlhdr");
		if((document.forms[0].flgRadioSwitch.value=="Y") && (document.forms[0].withdTaxPrcnt.value==""))
		{
			alert("Enter Withholding Tax Percentage ");
			document.forms[0].withdTaxPrcnt.focus();
			return false;

		}
		if(!fnIsNull(document.forms[0].withdTaxPrcnt.value))
		{
			if (isNaN(document.forms[0].withdTaxPrcnt.value))
			{
				alert("Enter a numeric value");
				document.forms[0].withdTaxPrcnt.focus();
				return false;
			}

		}
		if((document.forms[0].flgRadioSwitch.value=="Y") && (document.forms[0].withdTaxPlcHldr.value==""))
		{
			alert("Enter Withholding Tax Placeholder  ");
			document.forms[0].withdTaxPlcHldr.focus();
			return false;

		}
	
	
	setFieldsToCustomData("withdTaxPrcnt","withdTaxPlcHldr","flgRadioSwitch")
     }
}
/*******************************************************************	
*Name:		mitugspschdet1_pre_ONCLICK
*Description: 	Gets called on pre onclick 
*               
*******************************************************************/
function mitugspschdet1_pre_ONCLICK(obj)
{	
   if(obj.id!="Cancel")
   {
	if((document.forms[0].flgRadioSwitch.value=="Y") && (document.forms[0].withdTaxPrcnt.value==""))
	{
		alert("Enter Withholding Tax Percentage ");
		document.forms[0].withdTaxPrcnt.focus();
		return false;
	
	}
	if(!fnIsNull(document.forms[0].withdTaxPrcnt.value))
	{
		if (isNaN(document.forms[0].withdTaxPrcnt.value))
		{
			alert("Enter a numeric value");
			document.forms[0].withdTaxPrcnt.focus();
                	return false;
		}
	
	}
	
	if((document.forms[0].flgRadioSwitch.value=="Y") && (document.forms[0].withdTaxPlcHldr.value==""))
	{
		alert("Enter Withholding Tax Placeholder  ");
		document.forms[0].withdTaxPlcHldr.focus();
		return false;
		
	}
   }	
	setFieldsToCustomData("withdTaxPrcnt","withdTaxPlcHldr","flgRadioSwitch")
	
}

function fnshowBacidPlhdr()
{
	
		var inputNameValues = "";
		var outputNames = "errorFlg|errorMsg|bankId";
		var scriptName = "whtmn027.scr";
		var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
		if(retVal != undefined)
		{
			var token = retVal.split("|");
			var errorFlg = token[1];
			var errorMsg = token[3];
			var bankId = token[5];
			if(errorFlg == "Y")
			{
				alert(errorMsg);
				return false;

			}
			else
			{
				//showBacid(document.forms[0].withdTaxPlcHldr,'ctrl','F','','',bankId)
				showDynSearcher("BACID","bacid=:withdTaxPlcHldr|targetBankId=:valuety",":withdTaxPlcHldr=bacid");

			}
		}
	
	
}

</script>
	
	


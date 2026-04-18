<!----------------------------------------------------------------------------------------------------->
<!--    Name            :       oilasch_custom.jsp                                                   -->
<!--    Menu            :       OISA,OICA,VISAO,VICAO,MISAO,MICAO                                    -->
<!--    Author          :       Nitin_kumar16                                                        -->
<!--    Description     :       customization done for adding withdTaxAppFlg radio button  .         -->
<!--    Modification History                                                                         -->
<!--    <Serial No> <Date>          <Author>        <Description>                                    -->
<!--    1           27-Jun-2013     Nitin_kumar16    Original Version                        	     -->
<!----------------------------------------------------------------------------------------------------->
 <%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="java.util.*" %>
<%@ page session="true"%>
<%@ include file='../commonInclude.jsp'%>

<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<SCRIPT language="javascript" src="../../javascripts/common_functions.js" ></SCRIPT>
<SCRIPT language="javascript" src="../../javascripts/cust_post_evt.js" ></SCRIPT>
<SCRIPT language="javascript" src="../../javascripts/cust_pre_evt.js" ></SCRIPT>

<script>

var objForm = document.forms[0];

	
	if((mopId.toUpperCase()=="OISA")|| (mopId.toUpperCase()=="OICA") ||(mopId.toUpperCase()=="VISAO")||(mopId.toUpperCase()=="VICAO")||(mopId.toUpperCase()=="MISAO")||(mopId.toUpperCase()=="MICAO"))
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
			write('<td colspan="5"><h1 class="subhdr" style="font-size:12">With Holding Tax Details</h1></td>');
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
*Name:		getRadioValue1
*Description: 	Gets called on click of WithHolding Tax applicable 
*               Radio button
*******************************************************************/

function getRadioValue1()
{
	
 	if(getRadioValue(document.forms[0].withdTaxAppFlg)=="Y")
   	{
        	
		document.forms[0].flgRadioSwitch.value="Y";
	
   	}
  	else
  	{
		document.forms[0].flgRadioSwitch.value="N";
  	}
}

function oilasch_pre_TAB_SWITCH(obj)
{
	
	if((mopId.toUpperCase()=="OISA")|| (mopId.toUpperCase()=="OICA") ||(mopId.toUpperCase()=="VISAO")||(mopId.toUpperCase()=="VICAO")||(mopId.toUpperCase()=="MISAO")||(mopId.toUpperCase()=="MICAO"))
	{
		var value1=document.forms[0].withdTaxAppFlg[1].checked
		if( value1== true)
		{
			document.forms[0].flgRadioSwitch.value="N";

		}
		else
		{
			document.forms[0].flgRadioSwitch.value="Y";
		}

		setFieldsToCustomData("flgRadioSwitch");
	}
}

function oilasch_pre_ONCLICK(obj)
{
	
	if((mopId.toUpperCase()=="OISA")|| (mopId.toUpperCase()=="OICA") ||(mopId.toUpperCase()=="VISAO")||(mopId.toUpperCase()=="VICAO")||(mopId.toUpperCase()=="MISAO")||(mopId.toUpperCase()=="MICAO"))
	{
		setFieldsToCustomData("flgRadioSwitch");
	}	
}


function oilasch_pre_ONLOAD(obj)
{
	
	if((mopId.toUpperCase()=="OISA")|| (mopId.toUpperCase()=="OICA") ||(mopId.toUpperCase()=="VISAO")||(mopId.toUpperCase()=="VICAO")||(mopId.toUpperCase()=="MISAO")||(mopId.toUpperCase()=="MICAO"))
	{
		getFieldsFromCustomData("flgRadioSwitch");

		if(document.forms[0].flgRadioSwitch.value=="")
		{

			document.forms[0].withdTaxAppFlg[1].checked=true;
			document.forms[0].flgRadioSwitch.value="N";
		}
		else
		{
			if(document.forms[0].flgRadioSwitch.value=="Y")
			{
				document.forms[0].withdTaxAppFlg[0].checked=true;
				document.forms[0].withdTaxAppFlg[1].checked=false;	
			}
			else
			{
				document.forms[0].withdTaxAppFlg[1].checked=true;
				document.forms[0].withdTaxAppFlg[0].checked=false;
			}
		}
	}
	
}
</script>

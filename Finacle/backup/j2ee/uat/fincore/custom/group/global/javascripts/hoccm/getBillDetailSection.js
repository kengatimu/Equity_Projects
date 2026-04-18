
/*******************************************************************	
*Name:		getBillDetailSection.js
*Description: 	This fxn gets called for Bill payment(Clearing)
*Author     :   Swati Ganjoo
*Modification History
*Serial No        Date         Author     Description
*******************************************************************/
function getBillDetailSection()
{
		var objForm = document.forms[0];

		with (document) {
		write('<html>');
			write('<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
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
			write('<td colspan="5"><h1 class="subhdr" style="font-size:12">Biller Details</h1></td>');
                        write('</tr>');
			write('<tr>');
			write('<td class="textlabel">');
			write('<input name="getBillDtl" value="Get Bill Details" type="submit" id="getBillDtl" onclick="fnGetBillDtl()">');
			write('</td>');
			write('<td class="columnwidth"> </td>');
			write('<td>');
			write('</td>');
			write('</tr>');
			
			
			if(billerId=="IPO")
			{
				write('<tr>');
				write('<td class="textlabel" style="height: 15px">Applicant Catagory <span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<select name="' + subGroupName + '.appCatgry" id="appCatgry" class="listboxfont">');
				write('<option value="">Select</option>');
				write('<option value="RE"> Retail</option>');
				write('<option value="Q"> Qualified Institutional Investor</option>');
				write('<option value="D">Authorised Dealer</option>');
				write('<option value="E">Employee</option>');
				write('</select>');
				write('</td>');
				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel"></td>');
				write('<td class="textfield">');
				write('</td>');
				write('</tr>');
			}
			
			if(billerId=="TURNQUEST")
			{
				
				write('<tr>');
				write('<td class="textlabel">Risk Note <span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="radio" name="' + subGroupName + '.riskNote" id="riskNote"  value="Y" title="riskNote" checked="checked"	onClick="javascript:return fnRiskNote();">YES');
				write('<input type="radio" name="' + subGroupName + '.riskNote" id="riskNote"  value="N" title="riskNote" onClick="javascript:return fnRiskNote();">NO');
				write('</td>');
				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel"></span></td>');
				write('<td class="textfield">');
				write('</td>');
				write('</tr>');
			}
			

			
			write('<tr>');
			if(billerId=="TURNQUEST")
			{
				write('<td class="textlabel">RiskNote Num<span  style="color:red"></span></td>');
			}
			else
			{
				write('<td class="textlabel">Bill Ref. Num  <span  style="color:red"></span></td>');
			}
			write('<td class="textfield">');
			write('<input type="text" class="textfieldfont" name="' + subGroupName + '.billRefNum" id="billRefNum" >');
			write('<input type="text" class="textfieldfont" name="' + subGroupName + '.refNumHidden" id="refNumHidden" style="visibility: hidden; width: 0px">');
			write('</td>');
			if((billerId=="1225") || (billerId=="1226") || (billerId=="2587"))
			{
			write('<td class="columnwidth"> </td>');
			write('<td class="textlabel">Phone No <span  style="color:red"></span></td>');
			write('<td class="textfield">');
			write('<input type="text" class="textfieldfont" name="' + subGroupName + '.name" id="name">');
			write('</td>');
			}
			else
			{
                        write('<td class="columnwidth"> </td>');
                        write('<td class="textlabel">Name <span  style="color:red"></span></td>');
                        write('<td class="textfield">');
                        write('<input type="text" class="textfieldfont" name="' + subGroupName + '.name" id="name">');
                        write('</td>');
			}

			write('</tr>');
			
			
			
			write('<tr>');
			write('<td class="textlabel">Tran Particulars  <span  style="color:red"></span></td>');
			write('<td class="textfield">');
			write('<input type="text" class="textfieldfont" name="' + subGroupName + '.tranPart" id="tranPart" maxlength="50">');
			write('<input type="text" name="' + subGroupName + '.retStrngValHid" id="retStrngValHid"  readonly="readonly" style="visibility: hidden; width: 0px">');
			write('</td>');
			write('<td class="columnwidth"> </td>');
			write('<td class="textlabel">Tran Remarks<span  style="color:red"></span></td>');
			write('<td class="textfield">');
			write('<input type="text" class="textfieldfont" name="' + subGroupName + '.tranRem" id="tranRem"  maxlength="25">');
			write('</a>');
			write('</td>');
			write('</tr>');
			
			
			
			
			write('<tr>');
			write('<td class="textlabel">');
			write('<div id="DisplayField1"></div>');
			write('</td>');
			write('<td class="textfield">');
			write('<div id="DisplayField2"></div>');
			write('</td>');
			write('<td class="columnwidth"> </td>');
			write('<td class="textlabel">');
			write('<div id="DisplayField3"></div>');
			write('</td>');
			write('<td class="textfield">');
			write('<div id="DisplayField4"></div>');
			write('</td>');
			write('</tr>');
			
			
			if(billerId=="KASNEB")
			{
				write('<tr>');
				write('<td class="textlabel">Payments for  <span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext1" id="freetext1" onBlur="javascript:return fnBlurPayRef();" onChange="javascript:return fnChangePayRef();" >');
				write('<a href="javascript:fnPayForRefCode()" id="getPayFor">');
				write('<img border="0" height="17" hotKeyId="search4" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
				write('</a>');
				write('<input type="text" class="label" name="' + subGroupName + '.refDesc" id="refDesc" maxlength="50" size="60">');
				write('</td>');
				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel">Kasneb Form Serial Number<span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext2" id="freetext2">');
				write('</a>');
				write('</td>');
				write('</tr>');
			
			}
			
			//if(billerId=="KRA")
			//{
				write('<tr>');
				write('<td class="textlabel">Biller Code  <span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext1" id="freetext1" >');
				write('</td>');
				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel">Department Code<span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext2" id="freetext2">');
				write('</a>');
				write('</td>');
				write('</tr>');
				
				write('<tr>');
				write('<td class="textlabel">Doc. Ref. Num.  <span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext3" id="freetext3" >');
				write('</td>');
				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel">Region Code<span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext4" id="freetext4">');
				write('</a>');
				write('</td>');
				write('</tr>');
				
				write('<tr>');
				write('<td class="textlabel">Slip Payment Code  <span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext5" id="freetext5" >');
				write('</td>');
				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel">Station Code<span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext6" id="freetext6">');
				write('</a>');
				write('</td>');
				write('</tr>');
				
				write('<tr>');
                                if(billerId=="2587")
                                {
					write('<td class="textlabel">Location  <span  style="color:red"></span></td>');
				}
				else
				{
					write('<td class="textlabel">System Code  <span  style="color:red"></span></td>');
				}
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext7" id="freetext7" >');
				write('</td>');
                                write('</a>');
                                write('</td>');

				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel"></td>');
				write('<td class="textfield">');
				write('</a>');
				write('</td>');
				write('</tr>');
			//}
			
			
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

/*function mitugspschdet1_pre_ONLOAD(obj)
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
	
}*/


/*******************************************************************	
*Name:		getRadioValue1
*Description: 	Gets called on click of WithHolding Tax applicable 
*               Radio button
*******************************************************************/

/*function getRadioValue1()
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
}*/
//ends here

/*******************************************************************	
*Name:		mitugspschdet1_pre_TAB_SWITCH
*Description: 	Gets called on switching tab 
*               
*******************************************************************/
/*function mitugspschdet1_pre_TAB_SWITCH(obj)
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
	}
	
	setFieldsToCustomData("withdTaxPrcnt","withdTaxPlcHldr","flgRadioSwitch")
}*/
/*******************************************************************	
*Name:		mitugspschdet1_pre_ONCLICK
*Description: 	Gets called on pre onclick 
*               
*******************************************************************/
/*function mitugspschdet1_pre_ONCLICK(obj)
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
	
	setFieldsToCustomData("withdTaxPrcnt","withdTaxPlcHldr","flgRadioSwitch")
	
}*/

/*function fnshowBacidPlhdr()
{
	
		var inputNameValues = "";
		var outputNames = "errorFlg|errorMsg|bankId";
		var scriptName = "WthFetchBankIddp001.scr";
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
	
	
}*/
	
	


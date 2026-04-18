
/*******************************************************************	
*Name:		getBillDetailSectionIECLG.js
*Description: 	This fxn gets called for Bill payment(Clearing)
*Author     :   Swati Ganjoo
*Modification History
*Serial No        Date         Author     Description
*******************************************************************/
function getBillDetailSectionIECLG()
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
			write('<td class="columnwidth"> </td>');
			write('<td class="textlabel">Name <span  style="color:red"></span></td>');
			write('<td class="textfield">');
			write('<input type="text" class="textfieldfont" name="' + subGroupName + '.name" id="name">');
			write('<input type="text" name="' + subGroupName + '.retStrngValHid" id="retStrngValHid"  readonly="readonly" style="visibility: hidden; width: 0px">');
			write('</td>');
			write('</tr>');
			
			
			
			//write('<tr>');
			//write('<td class="textlabel">Tran Particulars  <span  style="color:red"></span></td>');
			//write('<td class="textfield">');
			//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.tranPart" id="tranPart" maxlength="50">');
			//write('<input type="text" name="' + subGroupName + '.retStrngValHid" id="retStrngValHid"  readonly="readonly" style="visibility: hidden; width: 0px">');
			//write('</td>');
			//write('<td class="columnwidth"> </td>');
			//write('<td class="textlabel">Tran Remarks<span  style="color:red"></span></td>');
			//write('<td class="textfield">');
			//write('<input type="text" class="textfieldfont" name="' + subGroupName + '.tranRem" id="tranRem"  maxlength="25">');
			//write('</a>');
			//write('</td>');
			//write('</tr>');
			
			
			
			
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
			
			if(billerId=="KRA")
			{
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
				write('<td class="textlabel">System Code  <span  style="color:red"></span></td>');
				write('<td class="textfield">');
				write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freetext7" id="freetext7" >');
				write('</td>');
				write('<td class="columnwidth"> </td>');
				write('<td class="textlabel"></td>');
				write('<td class="textfield">');
				write('</a>');
				write('</td>');
				write('</tr>');
			}
			
			
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

	
	


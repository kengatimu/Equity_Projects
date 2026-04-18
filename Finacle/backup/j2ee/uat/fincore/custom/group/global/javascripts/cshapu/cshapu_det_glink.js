
function printBlock1()
{
	writeCustomHeader("cshapu_det");
	with (document){
	write('<input type="hidden" name="' + subGroupName + '.name835" id="name835">');
	write('<input type="hidden" name="' + subGroupName + '.selectedRow" id="selectedRow">');
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031859") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT006657") + '</td>');
	write('<td class="textfielddisplaylabel">');
	write('&nbsp;&nbsp;');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031347") + '</td>');

    write('<td class="textfielddisplaylabel">');
	write('&nbsp;&nbsp;');
	write('<label id="compField">' + tranType + '</label>');
	write('</td>');


	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT032045") + '</td>');

	write('<td class="textfielddisplaylabel">');
	write('&nbsp;&nbsp;');
	write('<label id="compField">' + accountnumber + '</label>');
	write('</td>');

	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031846") + '</td>');

    write('<td class="textfielddisplaylabel">');
	write('&nbsp;&nbsp;');
	write('<label id="compField">' + cdscnumber + '</label>');


	write('</tr>');

    //client details and account details

    write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT0265262") + '</td>');
    write('<td class="textlabel" disabled name="'+subGroupName+'.clientNames" id="clientNames">');
	write('<span id="sclientnames" name="sclientnames"></span>');
    write('&nbsp;&nbsp;');
    write('<span id="scurrency" name="scurrency"></span>');
	write('&nbsp;&nbsp;');
	write('<span id="sbranch" name="sbranch"></span>');
	write('&nbsp;&nbsp;');

    //explode

	write('<a href="Javascript:showAcctDetails(accountnumber)" id="sLnk4">');
	write('<img explodeId="explode1" src="../images/' + applangcode + '/explode.gif" width="16" height="16" border="0">');
	write('</a>');
	write('</td>');

	//cdsc account details
	//TODO add the detais of the CDSC number
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel">' + jspResArr.get("FLT0265263") + '</td>');
	write('<td class="textlabel" disabled name="'+subGroupName+'.clientCdscDetails" id="clientCdscDetails">');
	write('</td>');	
	write('</tr>');




	//some disable inputs

    write('<tr>');
	write('<td class="textlabel"></td>');
    write('<td class="textlabel" disabled name="'+subGroupName+'.clientNames" id="clientNames">');	
	write('</td>');	
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"></td>');
	write('<td class="textlabel" disabled >');
	write('</td>');
	write('</tr>');

   //////////////////////////////////////


	write('<td class="textfielddisplaylabel"> </td>');
	write('</tr>');
	write('</table>');
	write('<br />');
	write('<!-- DETAILSBLOCK-BEGIN -->');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertabletop1">');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a href="javascript:showHelpFile(\'det_help.htm\');" id="sLnk1">');
	write('<img  hotKeyId="finHelp" src="../Renderer/images/'+applangcode+'/help.gif" width="17" height="17" vspace="1" border="0" />');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="4" cellspacing="5" class="innertabletop1">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT032156") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.referencenumber" id="referencenumber" ' + cshapuProps.get("referencenumber_ENABLED") + '>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031850") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.trancid" id="transactionid" ' + cshapuProps.get("transactionid_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT032220") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.serialnumber" id="serialnumber" ' + cshapuProps.get("serialnumber_ENABLED") + '>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT021862") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.transactiondate" id="transactiondate" ' + cshapuProps.get("transactiondate_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT013609") + '</td>');
	write('<td>');
	write('<input type="radio" name="' + subGroupName + '.placeLienFlg" id="placeLienFlg" ' + cshapuProps.get("placeLienFlg_ENABLED") + ' value="Y">');
	write('<span>Yes</span>');
	write('<input type="radio" name="' + subGroupName + '.placeLienFlg" id="placeLienFlg" ' + cshapuProps.get("placeLienFlg_ENABLED") + ' value="N">');
	write('<span>No</span>');
	write('</td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031854") + '</td>');
	write('<td>');
	write('<textarea name="' + subGroupName + '.tranremarks" id="tranremarks" ' + cshapuProps.get("tranremarks_ENABLED") + ' rows="2" cols="23" class="textfieldfont"></textarea>');
	write('</td>');
	write('</tr>');
	write('<tr valign="middle" class="subhdrbg">');
	write('<td colspan="3" class="subhdr">' + jspResArr.get("FLT002043") + '</td>');
	write('<td colspan="4" align="right" valign="middle">&nbsp;</td>');
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
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('<div>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable" id="custTable" name="custTable">');
	write('<tr>');
	if(funcCode=='A')
		{
	write('<td class="searcheader1a" type="text">' + jspResArr.get("FLT032091") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031522") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031524") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031526") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT029546") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031562") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031863") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031739") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT032155") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031571") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031865") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031577") + '</td>');
	write('<td class="searcheader" type="text">' + jspResArr.get("FLT031767") + '</td>');
	write('<td class="searcheader" type="checkbox">' + jspResArr.get("FLT032012") + '</td>');
	write('</tr>');
		}
		if(funcCode=='V'||funcCode=='I'||funcCode=='H')
		{
			 
            write('<tr>');		    
            write('<td class="searcheader" type="text">' + jspResArr.get("FLT031767") + '</td>');
			write('<td class="searcheader" type="text">' + jspResArr.get("FLT031522") + '</td>');
            write('<td class="searcheader" type="text">' + jspResArr.get("FLT031524") + '</td>');
			write('<td class="searcheader" type="text">' + jspResArr.get("FLT031526") + '</td>');
			write('<td class="searcheader" type="text">Quantity</td>');
            write('<td class="searcheader" type="text">Tran Id</td>');
			write('<td class="searcheader" type="text">Entered By</td>');
			write('<td class="searcheader" type="text">Verified By</td>');
			write('</tr>');
            
            
			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_1"    name="orderdate_1"></td>');
			write('<td class="searcheader" type="text" id="securitycode_1" name="securitycode_1"></td>');
            write('<td class="searcheader" type="text" id="securityname_1" name="securityname_1"></td>');
			write('<td class="searcheader" type="text" id="askingprice_1"  name="askingprice_1"></td>');
			write('<td class="searcheader" type="text" id="quantity_1"  name="quantity_1"></td>')
            write('<td class="searcheader" type="text" id="tranid_1"   name="tranid_1"></td>');
			write('<td class="searcheader" type="text" id=enteredby_1  name=enteredby_1></td>');
			write('<td class="searcheader" type="text" id="verifiedby_1" name="verifiedby_1"></td>');
			write('</tr>');

			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_2"></td>');
			write('<td class="searcheader" type="text" id="securitycode_2"></td>');
            write('<td class="searcheader" type="text" id="securityname_2"></td>');
			write('<td class="searcheader" type="text" id="askingprice_2"></td>');
			write('<td class="searcheader" type="text" id="quantity_2"></td>')
            write('<td class="searcheader" type="text" id="tranid_2"></td>');
			write('<td class="searcheader" type="text" id=enteredby_2></td>');
			write('<td class="searcheader" type="text" id="verifiedby_2"></td>');
			write('</tr>');

			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_3"></td>');
			write('<td class="searcheader" type="text" id="securitycode_3"></td>');
            write('<td class="searcheader" type="text" id="securityname_3"></td>');
			write('<td class="searcheader" type="text" id="askingprice_3"></td>');
			write('<td class="searcheader" type="text" id="quantity_3"></td>')
            write('<td class="searcheader" type="text" id="tranid_3"></td>');
			write('<td class="searcheader" type="text" id=enteredby_3></td>');
			write('<td class="searcheader" type="text" id="verifiedby_3"></td>');
			write('</tr>');


			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_4"></td>');
			write('<td class="searcheader" type="text" id="securitycode_4"></td>');
            write('<td class="searcheader" type="text" id="securityname_4"></td>');
			write('<td class="searcheader" type="text" id="askingprice_4"></td>');
			write('<td class="searcheader" type="text" id="quantity_4"></td>')
            write('<td class="searcheader" type="text" id="tranid_4"></td>');
			write('<td class="searcheader" type="text" id=enteredby_4></td>');
			write('<td class="searcheader" type="text" id="verifiedby_4"></td>');
			write('</tr>');


			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_5"></td>');
			write('<td class="searcheader" type="text" id="securitycode_5"></td>');
            write('<td class="searcheader" type="text" id="securityname_5"></td>');
			write('<td class="searcheader" type="text" id="askingprice_5"></td>');
			write('<td class="searcheader" type="text" id="quantity_5"></td>')
            write('<td class="searcheader" type="text" id="tranid_5"></td>');
			write('<td class="searcheader" type="text" id=enteredby_5></td>');
			write('<td class="searcheader" type="text" id="verifiedby_5"></td>');
			write('</tr>');


			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_6"></td>');
			write('<td class="searcheader" type="text" id="securitycode_6"></td>');
            write('<td class="searcheader" type="text" id="securityname_6"></td>');
			write('<td class="searcheader" type="text" id="askingprice_6"></td>');
			write('<td class="searcheader" type="text" id="quantity_6"></td>')
            write('<td class="searcheader" type="text" id="tranid_6"></td>');
			write('<td class="searcheader" type="text" id=enteredby_6></td>');
			write('<td class="searcheader" type="text" id="verifiedby_6"></td>');
			write('</tr>');


			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_7"></td>');
			write('<td class="searcheader" type="text" id="securitycode_7"></td>');
            write('<td class="searcheader" type="text" id="securityname_7"></td>');
			write('<td class="searcheader" type="text" id="askingprice_7"></td>');
			write('<td class="searcheader" type="text" id="quantity_7"></td>')
            write('<td class="searcheader" type="text" id="tranid_7"></td>');
			write('<td class="searcheader" type="text" id=enteredby_7></td>');
			write('<td class="searcheader" type="text" id="verifiedby_7"></td>');
			write('</tr>');


			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_8"></td>');
			write('<td class="searcheader" type="text" id="securitycode_8"></td>');
            write('<td class="searcheader" type="text" id="securityname_8"></td>');
			write('<td class="searcheader" type="text" id="askingprice_8"></td>');
			write('<td class="searcheader" type="text" id="quantity_8"></td>')
            write('<td class="searcheader" type="text" id="tranid_8"></td>');
			write('<td class="searcheader" type="text" id=enteredby_8></td>');
			write('<td class="searcheader" type="text" id="verifiedby_8"></td>');
			write('</tr>');


			write('<tr>');		    
            write('<td class="searcheader" type="text" id="orderdate_9"></td>');
			write('<td class="searcheader" type="text" id="securitycode_9"></td>');
            write('<td class="searcheader" type="text" id="securityname_9"></td>');
			write('<td class="searcheader" type="text" id="askingprice_9"></td>');
			write('<td class="searcheader" type="text" id="quantity_9"></td>')
            write('<td class="searcheader" type="text" id="tranid_9"></td>');
			write('<td class="searcheader" type="text" id=enteredby_9></td>');
			write('<td class="searcheader" type="text" id="verifiedby_9"></td>');
			write('</tr>');
			

			//hidden inputs
             write('<input type="hidden" name=RECORD_1>');
			 write('<input type="hidden" name=RECORD_2>');
			 write('<input type="hidden" name=RECORD_3>');
			 write('<input type="hidden" name=RECORD_4>');
			 write('<input type="hidden" name=RECORD_5>');
			 write('<input type="hidden" name=RECORD_6>');
			 write('<input type="hidden" name=RECORD_7>');
			 write('<input type="hidden" name=RECORD_8>');
			 write('<input type="hidden" name=RECORD_9>');
			 write('<input type="hidden" name=RECORD_10>');

            
	   



           

		}
	} //End with()
} //End function

function printBlock2()
{
	with (document){
	write('</table>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');

    
    
	if(funcCode=='A')
		{


	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT032091") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname13" id="txtfldname13" ' + cshapuProps.get("txtfldname13_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">');   
	write(jspResArr.get("FLT031522"));
	setMandatory("Y");
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" onchange="javascript:secCodeChange(this.value);" onchange="javascript:secCodeChange(this.value);" name="' + subGroupName + '.txtfldname25" id="txtfldname25" ' + cshapuProps.get("txtfldname25_ENABLED") + ' size="10" maxlength="10">');	
	//image link
	write('<a href="javascript:fnOutboundShareList();" name="secIdList" id="secIdList">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031524") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname28" id="txtfldname28" ' + cshapuProps.get("txtfldname28_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">');
	write(jspResArr.get("FLT031526"));
    setMandatory("Y");
	write('</td>');
	write('<td>');
	write('<input type="text"  onblur="javascript:validateAskingPrice(this.value);" class="textfieldfont" name="' + subGroupName + '.txtfldname310" id="txtfldname310" ' + cshapuProps.get("txtfldname310_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT029546") + '</td>');
	write('<td>');
	write('<input type="text" onblur="javascript:handleDepositChange(this);" class="textfieldfont" name="' + subGroupName + '.txtfldname313" id="txtfldname313" ' + cshapuProps.get("txtfldname313_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">');
	write(jspResArr.get("FLT031562"));
    setMandatory("Y");
	write('</td>');
	write('<td>');
	write('<input type="text" onblur="javascript:validateShareQuantity(this.value);" class="textfieldfont" name="' + subGroupName + '.txtfldname415" id="txtfldname415" ' + cshapuProps.get("txtfldname415_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031863") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname418" id="txtfldname418" ' + cshapuProps.get("txtfldname418_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031739") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname520" id="txtfldname520" ' + cshapuProps.get("txtfldname520_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT032155") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname523" id="txtfldname523" ' + cshapuProps.get("txtfldname523_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031571") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname625" id="txtfldname625" ' + cshapuProps.get("txtfldname625_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031865") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname628" id="txtfldname628" ' + cshapuProps.get("txtfldname628_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031577") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname730" id="txtfldname730" ' + cshapuProps.get("txtfldname730_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031767") + '</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.txtfldname733" id="txtfldname733" ' + cshapuProps.get("txtfldname733_ENABLED") + ' size="10" maxlength="10">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT032012") + '</td>');
	write('<td>');
	write('<input type="checkbox" name="' + subGroupName + '.chkname835" id="chkname835"  onClick="javascript:return cshapu_det_ONCLICK1(this,this);">');
	write('</td>');
	write('</tr>');


		}
	


	write('</table>');
	write('</td>');
	write('</tr>');
	write('</div>');
	write('</td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield"> </td>');
	write('<td class="columnwidth"> </td>');
	write('<td class="textlabel"> </td>');
	write('<td class="textfield"> </td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
	write('<tr>');
	write('<td>');
	write('<table width="100%" border="0" cellpadding="4" cellspacing="5" class="innertabletop1">');
	write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031766") + '</td>');
	write('<td>');
	write('<input class="textfieldamount" type="hidden"  name="' + subGroupName + '.Totamt" id="Totamt" ' + cshapuProps.get("Totamt_ENABLED") + ' align="middle" size="2" maxlength="30">&nbsp;&nbsp;');
	write('</td>');
	write('</tr>');

    

	//the new Total field for display
    write('<tr>');
	write('<td class="textlabel">' + jspResArr.get("FLT031766") + '</td>');
    write('<td>');
	write('<input class="textfieldamount" type="text" name="' + subGroupName + '.DispTotal" id="DispTotal" ' + cshapuProps.get("Totamt_ENABLED") + ' align="left" size="2" maxlength="30">&nbsp;&nbsp;');
	write('</td>');
    write('</tr>');


	/////////////////////////////////////
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
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-END -->');
	write('</td>');
	write('</tr>');

    //button for testing purpose
	///////////////
	////////////////
    //write('<input type="button" class="Button" id="Test" value="Test" onClick="javascript:Tester();">');
	///////////////
	//////////////


	write('</table>');
	} //End with()
} //End function

function printFooterBlock()
{
	with (document) {
	if ((sReferralMode == 'I')||(sReferralMode == 'S')){
	write('<div align="left" class="ctable">');
	if (sReferralMode == 'S'){
	write('<input type="button" class="Button" id="Submit" value="'+jspResArr.get("FLT000193")+ '" onClick="javascript:return doRefSubmit(this);" hotKeyId="Submit" >');
	}
	writeRefFooter();
	write('<input type="button" class="Button" id="_BackRef_" value="'+jspResArr.get("FLT001721")+ '" onClick="javascript:return doSubmit(this.id);" hotKeyId="Cancel" >');
	write('</div>');
	}else{
	if(funcCode !='I'){
	write('<div class="ctable">');
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cshapu_det_ONCLICK2(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cshapu_det_ONCLICK3(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cshapu_det_ONCLICK4(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnOnLoad()
{
	var ObjForm = document.forms[0];

	
	
	pre_ONLOAD('cshapu_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);

		ObjForm.Cancel.disabled=false;
		
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cshapu_det',this);

	//all ONLOAD functions are in the link file and are called from here

	setClientCDSCNames();
    setAccountDetails();
	disableHeader();
	disableMultiRecControls();

	//set Displayed Field Total Amount
	//and Hidden Field Total Amount
    //initializeTotalAmount();
	

	if(cust_fnIsNull(document.getElementById("Totamt").value))
	{
		if(funcCode=='A')
		{

		     
         document.getElementById("Totamt").value="0.0";

         document.getElementById("DispTotal").value="0.0";

		}

	}
	else
	{
		if(funcCode=='A')
		{
		document.getElementById("DispTotal").value=formatToMillion1(document.getElementById("Totamt").value);
		}


	}

}
//function to test listing of securities from trading system
function fnCustSearcher2()
{
	
	   var sUrl = "../custom/jsp/SharesTradingList.jsp?";
        var xMax = screen.width, yMax = screen.height;
        var xOffset = (xMax - 120), yOffset = (yMax - 150);
        var params = "dialogWidth=800px;dialogHeight=50px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";
        params += ";status=yes;toolbar=yes;menubar=yes;resizable=yes;help=yes;center=no";

        var retVal = "";
        if("Netscape" == browser_name)
        {
                retVal=window.open(sUrl,"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
        }
        else
        {
                retVal = window.popModalWindow(sUrl,"",params);


        }
        if (retVal == null || retVal == undefined)
	{
                alert("There was an error opening a security list window");
				return;
	}
	
	 //after the searcher window is closed
	 //Polulate the security code with selected value
	 document.getElementById("txtfldname25").value=retVal.securityCode;
	 
	 
    
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	//all the fields that you want to validate on click of submit will be kept here

	//if(!validateLineNumber(objForm.txtfldname13.value))

	//	 return false; 
     

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.referencenumber.value = referencenumber;
	ObjForm.transactionid.value = transactionid;
	ObjForm.serialnumber.value = serialnumber;
	ObjForm.transactiondate.value = transactiondate;
	ObjForm.placeLienFlg.value = placeLienFlg;
	ObjForm.tranremarks.value = tranremarks;


    
	if(funcCode=='A')
	{

	ObjForm.txtfldname13.value = txtfldname13;
	ObjForm.txtfldname25.value = txtfldname25;
	ObjForm.txtfldname28.value = txtfldname28;
	ObjForm.txtfldname310.value = txtfldname310;
	ObjForm.txtfldname313.value = txtfldname313;
	ObjForm.txtfldname415.value = txtfldname415;
	ObjForm.txtfldname418.value = txtfldname418;
	ObjForm.txtfldname520.value = txtfldname520;
	ObjForm.txtfldname523.value = txtfldname523;
	ObjForm.txtfldname625.value = txtfldname625;
	ObjForm.txtfldname628.value = txtfldname628;
	ObjForm.txtfldname730.value = txtfldname730;
	ObjForm.txtfldname733.value = txtfldname733;
	ObjForm.name835.value = name835;
	}
	
	if(funcCode=='A')
	{
	ObjForm.Totamt.value = Totamt;
	ObjForm.chkname835.checked = (name835=="Y")?true:false;
	}

	if(funcCode=='V'||funcCode=='I'||funcCode=='H')
	{

		populateTable();

	}
	
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.placeLienFlg,placeLienFlg);
}


function cshapu_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal = fnSetCheckboxFld(p1)) == false) {
		return false;
	}
	if (postEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cshapu_det_ONCLICK2(obj,p1)
{

	if(funcCode=='V')
	{
         
		//alert("The function code is V "+tranid);
		var inputNameValues = "tranid" + "|" + tranid+"|funccode"+funcCode; 
        var outputNames1 = "RESULTS";
        var scrName1 = "trading015.scr";
        var retVal = "";
        var retVal = appFnExecuteScript(inputNameValues, outputNames1, scrName1, false);

		if(retVal!="")
		{

			var data=retVal.split("|");

			if(data[0]!='Error')
			{

				alert(data[1]);

			}
			else
			{
				alert("There was an error while verifying the record");

			}


		}

		return true;

	}

	var retVal = "";
	if (preEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cshapu_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cshapu_det_ONCLICK4(obj,p1)
{
	var retVal = "";
	if (preEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cshapu_det',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}
function getSecCodeFromModal(secCodeVal)
{

   document.getElementById("txtfldname25").value=secCodeVal;


}
function populateTable()
{

	
	var inputNameValues = "tranid" + "|" + tranid; 
        var outputNames1 = "RECORD_1|RECORD_2|RECORD_3|RECORD_4|RECORD_5|RECORD_6|RECORD_7|RECORD_8|RECORD_9|RECORD_10";
        var scrName1 = "trading017.scr";
        var retVal = "";
        var retVal = appFnExecuteScript(inputNameValues, outputNames1, scrName1, true);

		var rec1=document.getElementById("RECORD_1").value;
		var rec2=document.getElementById("RECORD_2").value;
		var rec3=document.getElementById("RECORD_3").value;
		var rec4=document.getElementById("RECORD_4").value;
		var rec5=document.getElementById("RECORD_5").value;
		var rec6=document.getElementById("RECORD_6").value;
		var rec7=document.getElementById("RECORD_7").value;
		var rec8=document.getElementById("RECORD_8").value;
		var rec9=document.getElementById("RECORD_9").value;
		var rec10=document.getElementById("RECORD_10").value;


	

               
               
               if(rec1!=""&&rec1!="undefined")
                   { 
				   
				       	
                       var record=rec1.split("!");				   
                       
                       document.getElementById("orderdate_1").innerHTML=record[0];
                       document.getElementById("securitycode_1").innerHTML=record[1];
                       document.getElementById("securityname_1").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_1").innerHTML=record[3];
                       document.getElementById("quantity_1").innerHTML=record[4];
                       document.getElementById("tranid_1").innerHTML=record[5];
                       document.getElementById("enteredby_1").innerHTML=record[6];
                       document.getElementById("verifiedby_1").innerHTML=record[7];          
              
                       
                       
                   }
				   if(rec2!=""&&rec2!="undefined")
                   {
                       var record=rec2.split("!");
                       
                       document.getElementById("orderdate_2").innerHTML=record[0];
                       document.getElementById("securitycode_2").innerHTML=record[1];
                       document.getElementById("securityname_2").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_2").innerHTML=record[3];
                       document.getElementById("quantity_2").innerHTML=record[4];
                       document.getElementById("tranid_2").innerHTML=record[5];
                       document.getElementById("enteredby_2").innerHTML=record[6];
                       document.getElementById("verifiedby_2").innerHTML=record[7]; 
                       
                   }
                   
                if(rec3!=""&&rec3!="undefined")
                   {
                       var record=rec3.split("!");
                       
                       document.getElementById("orderdate_3").innerHTML=record[0];
                       document.getElementById("securitycode_3").innerHTML=record[1];
                       document.getElementById("securityname_3").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_3").innerHTML=record[3];
                       document.getElementById("quantity_3").innerHTML=record[4];
                       document.getElementById("tranid_3").innerHTML=record[5];
                       document.getElementById("enteredby_3").innerHTML=record[6];
                       document.getElementById("verifiedby_3").innerHTML=record[7]; 
                       
                   }
                   
                 if(rec4!=""&&rec4!="undefined")
                   {
                       var record=rec4.split("!");
                       
                       document.getElementById("orderdate_4").innerHTML=record[0];
                       document.getElementById("securitycode_4").innerHTML=record[1];
                       document.getElementById("securityname_4").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_4").innerHTML=record[3];
                       document.getElementById("quantity_4").innerHTML=record[4];
                       document.getElementById("tranid_4").innerHTML=record[5];
                       document.getElementById("enteredby_4").innerHTML=record[6];
                       document.getElementById("verifiedby_4").innerHTML=record[7]; 
                       
                   }
                   
                  if(rec5!=""&&rec5!="undefined")
                   {
                       var record=rec5.split("!");
                       
                       document.getElementById("orderdate_5").innerHTML=record[0];
                       document.getElementById("securitycode_5").innerHTML=record[1];
                       document.getElementById("securityname_5").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_5").innerHTML=record[3];
                       document.getElementById("quantity_5").innerHTML=record[4];
                       document.getElementById("tranid_5").innerHTML=record[5];
                       document.getElementById("enteredby_5").innerHTML=record[6];
                       document.getElementById("verifiedby_5").innerHTML=record[7]; 
                       
                   }
                   if(rec6!=""&&rec6!="undefined")
                   {
                       var record=rec6.split("!");
                       
                       document.getElementById("orderdate_6").innerHTML=record[0];
                       document.getElementById("securitycode_6").innerHTML=record[1];
                       document.getElementById("securityname_6").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_6").innerHTML=record[3];
                       document.getElementById("quantity_6").innerHTML=record[4];
                       document.getElementById("tranid_6").innerHTML=record[5];
                       document.getElementById("enteredby_6").innerHTML=record[6];
                       document.getElementById("verifiedby_6").innerHTML=record[7]; 
                       
                   }
                   if(rec7!=""&&rec7!="undefined")
                   {
                       var record=rec7.split("!");
                       
                       document.getElementById("orderdate_7").innerHTML=record[0];
                       document.getElementById("securitycode_7").innerHTML=record[1];
                       document.getElementById("securityname_7").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_7").innerHTML=record[3];
                       document.getElementById("quantity_7").innerHTML=record[4];
                       document.getElementById("tranid_7").innerHTML=record[5];
                       document.getElementById("enteredby_7").innerHTML=record[6];
                       document.getElementById("verifiedby_7").innerHTML=record[7]; 
                       
                   }
                   if(rec8!=""&&rec8!="undefined")
                   {
                       var record=rec8.split("!");
                       
                       document.getElementById("orderdate_8").innerHTML=record[0];
                       document.getElementById("securitycode_8").innerHTML=record[1];
                       document.getElementById("securityname_8").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_8").innerHTML=record[3];
                       document.getElementById("quantity_8").innerHTML=record[4];
                       document.getElementById("tranid_8").innerHTML=record[5];
                       document.getElementById("enteredby_8").innerHTML=record[6];
                       document.getElementById("verifiedby_8").innerHTML=record[7]; 
                       
                   }
                   if(rec9!=""&&rec9!="undefined")
                   {
                       var record=rec9.split("!");
                       
                       document.getElementById("orderdate_9").innerHTML=record[0];
                       document.getElementById("securitycode_9").innerHTML=record[1];
                       document.getElementById("securityname_9").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_9").innerHTML=record[3];
                       document.getElementById("quantity_9").innerHTML=record[4];
                       document.getElementById("tranid_9").innerHTML=record[5];
                       document.getElementById("enteredby_9").innerHTML=record[6];
                       document.getElementById("verifiedby_9").innerHTML=record[7]; 
                       
                   }
                   if(rec10!=""&&rec10!="undefined")
                   {
                       var record=rec10.split("!");
                       
                       document.getElementById("orderdate_10").innerHTML=record[0];
                       document.getElementById("securitycode_10").innerHTML=record[1];
                       document.getElementById("securityname_10").innerHTML=record[2] ;                      
                       document.getElementById("askingprice_10").innerHTML=record[3];
                       document.getElementById("quantity_10").innerHTML=record[4];
                       document.getElementById("tranid_10").innerHTML=record[5];
                       document.getElementById("enteredby_10").innerHTML=record[6];
                       document.getElementById("verifiedby_10").value=record[7]; 
                       
                   }


		

}
function secCodeChange(obj)
{

	var secCodeObj = document.getElementById("txtfldname25");

	secCodeObj.value=decodeURIComponent(secCodeObj.value);

	var secNameObj = document.getElementById("txtfldname28");

	secNameObj.value=decodeURIComponent(secNameObj.value);

}


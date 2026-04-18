function printBlock()
{
	

	writeCustomHeader("cmercha_det");
	with (document){
	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">' + jspResArr.get("FLT031826") + '</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');
	write('<td class="textlabel" style="width: 159px">' + jspResArr.get("FLT020166") + '</td>');
	write('<td class="textfielddisplaylabel" style="width: 160px">');
	write('<label id="compField">' + funcCode + '</label>');
	write('</td>');
	write('<td class="columnwidth" style="width: 179px">&nbsp;</td>');
	write('<td class="textlabel" style="width: 155px"></td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 159px">' + jspResArr.get("FLT034257") + '</td>');
	write('<td>');
	write('<label id="compField">' + LoanAccount + '</label>');
	write('</td>');
	write('<td class="textlabel" style="width: 159px">' + jspResArr.get("FLT031813") + '</td>');
	write('<td style="width: 164px">');
	write('<label id="compField">' + LoanAccountName + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031814") + '</td>');
	write('<td>');
	write('<label id="compField">' + CustID + '</label>');
	write('</td>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031815") + '</td>');
	write('<td>');
	write('<label id="compField">' + LoanAcid + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT012932") + '</td>');
	write('<td>');
	write('<label id="compField">' + SchemeCode + '</label>');
	write('</td>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031816") + '</td>');
	write('<td>');
	write('<label id="compField">' + MISCode + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031817") + '</td>');
	write('<td>');
	write('<label id="compField">' + LoanDate + '</label>');
	write('</td>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031818") + '</td>');
	write('<td>');
	write('<label id="compField">' + OperativeAccount + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031819") + '</td>');
	write('<td>');
	write('<label id="compField">' + LoanAmount + '</label>');
	write('</td>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT002671") + '</td>');
	write('<td>');
	write('<label id="compField">' + Status + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT022552") + '</td>');
	write('<td>');
	write('<label id="compField">' + OrderNo + '</label>');
	write('</td>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031820") + '</td>');
	write('<td>');
	write('<label id="compField">' + OwnContribAmount + '</label>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031821") + '</td>');
	write('<td>');
	write('<label id="compField">' + ContributionAccount + '</label>');
	write('</td>');
	write('<td class="textlabel" style="width: 203px">' + jspResArr.get("FLT031822") + '</td>');
	write('<td>');
	write('<label id="compField">' + Recoverfrm + '</label>');
	write('</td>');
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
	write('<div>');
	write('<tr>');
	write('<td height="25" colspan="5" align="right">');
	write('<table border="0" cellpadding="0" cellspacing="0">');
	write('<tr>');
	write('<td align="right">');
	write('<a>');
	if(CurrentPage<=1){
	write('<img src="../Renderer/images/'+applangcode+'/arrowgraypre.gif" width="7" height="14" border="0" name="prevpage" id="prevpage">');
	}else	{
	write('<img  hotKeyId="Prev" src="../Renderer/images/'+applangcode+'/arrowpre.gif" width="7" height="14" border="0" align="absmiddle" id="prevpage" name="prevpage" onClick="javascript:doSubmit(this.id);" onMouseOver="displayHand(this)">');
	}
	write('</a>');
	write('</td>');
	write('<td>Page</td>');
	write('<td>' + CurrentPage + '</td>');
	write('<td>of ' + MaxPage + '</td>');
	write('<td>');
	write('<a>');
	write('<img  hotKeyId="Next" src="../Renderer/images/'+applangcode+'/arrownext.gif" id="nextpage" name="nextpage" width="7" height="14" border="0" align="absmiddle" onClick="javascript:fnCheckForNull(this);" onMouseOver="displayHand(this)">');
	write('</a>');
	write('</td>');
	write('</tr>');
	write('</table>');
	write('</td>');
	write('<tr>');
	write('<td colspan="5">');
	write('<table width="100%">');
	write('<tr>');
	write('<td width="25%" class="searcheader1a">' + jspResArr.get("FLT031827") + '</td>');
	write('<td width="25%" class="searcheader1a">' + jspResArr.get("FLT031828") + '</td>');
	write('<td width="25%" class="searcheader1a">' + jspResArr.get("FLT031829") + '</td>');	
	write('<td width="25%" class="searcheader1a">' + jspResArr.get("FLT016300") + '</td>');	
	write('</tr>');








   
   /********************* COMMENT

	if(CurrentSetSize>0){
	for(iIndex=0;iIndex<ListMaxDisplay;iIndex++)
	{
	startRecord = startRecord + iIndex;
	write('<tr>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.RefCode1" id="RefCode1" ' + cmerchaProps.get("RefCode1_ENABLED") + '>');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.ItemCode1" id="ItemCode1" ' + cmerchaProps.get("ItemCode1_ENABLED") + '>');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.ItemDescription1" id="ItemDescription1" ' + cmerchaProps.get("ItemDescription1_ENABLED") + '>');
	write('<a href="javascript:fnCmerchaId()" id="CmerchaIdSerch">');
	write('<img border="0" height="17" hotKeyId="search1" id="img'+iIndex+'" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16" onclick="javascript:onClickImage(this)">');
	write('</a>');
	write('</td>');
	write('<td>');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.UnitPrice1" id="UnitPrice1" ' + cmerchaProps.get("UnitPrice1_ENABLED") + '>');
	write('</td>');
	write('<td>');
	write('<input type="hidden" name="' + subGroupName + '.DeleteFlag1" id="DeleteFlag1" ><input type="checkbox" name="chkDeleteFlag1" id="chkDeleteFlag1" onClick="javascript:return fnSetCheckbox(this.id);">');
	write('</td>');
	write('</tr>');
	}
	}


    ******************************/




	write('</table>');
	write('</td>');
	write('</tr>');
	write('</tr>');
	write('</div>');
	write('</td>');
	write('</tr>');
	write('<tr>');

    ////////////////////////////////////////////*******************



	write('<table>');

    write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode0" id="ReferCode0" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode0" id="ItemCode0" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription0" id="ItemDescription0" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_0" id="searchItem_0">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');
 

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice0" id="UnitPrice0" >');
	write('</td>');


	write('</tr>');



	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode1" id="ReferCode1" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode1" id="ItemCode1" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription1" id="ItemDescription1" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_1" id="searchItem_1">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice1" id="UnitPrice1" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode2" id="ReferCode2" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode2" id="ItemCode2" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription2" id="ItemDescription2" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_2" id="searchItem_2">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice2" id="UnitPrice2" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode3" id="ReferCode3" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode3" id="ItemCode3" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription3" id="ItemDescription3" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_3" id="searchItem_3">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice3" id="UnitPrice3" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode4" id="ReferCode4" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode4" id="ItemCode4" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription4" id="ItemDescription4" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_4" id="searchItem_4">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice4" id="UnitPrice4" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode5" id="ReferCode5" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode5" id="ItemCode5" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription5" id="ItemDescription5" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_5" id="searchItem_5">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice5" id="UnitPrice5" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode6" id="ReferCode6" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode6" id="ItemCode6" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription6" id="ItemDescription6" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_6" id="searchItem_6">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice6" id="UnitPrice6" >');
	write('</td>');

    
	write('</tr>');

	
	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode7" id="ReferCode7" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode7" id="ItemCode7" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription7" id="ItemDescription7" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_7" id="searchItem_7">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice7" id="UnitPrice7" >');
	write('</td>');

    
	write('</tr>');

		
	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode8" id="ReferCode8" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode8" id="ItemCode8" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription8" id="ItemDescription8" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_8" id="searchItem_8">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice8" id="UnitPrice8" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode9" id="ReferCode9" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode9" id="ItemCode9" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription9" id="ItemDescription9" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_9" id="searchItem_9">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice9" id="UnitPrice9" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode10" id="ReferCode10" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode10" id="ItemCode10" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription10" id="ItemDescription10" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_10" id="searchItem_10">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice10" id="UnitPrice10" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode11" id="ReferCode11" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode11" id="ItemCode11" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription11" id="ItemDescription11" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_11" id="searchItem_11">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice11" id="UnitPrice11" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode12" id="ReferCode12" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode12" id="ItemCode12" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription12" id="ItemDescription12" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_12" id="searchItem_12">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice12" id="UnitPrice12" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode13" id="ReferCode13" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode13" id="ItemCode13" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription13" id="ItemDescription13" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_13" id="searchItem_13">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice13" id="UnitPrice13" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode14" id="ReferCode14" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode14" id="ItemCode14" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription14" id="ItemDescription14" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_14" id="searchItem_14">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice14" id="UnitPrice14" >');
	write('</td>');

    
	write('</tr>');

	write('<tr>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ReferCode15" id="ReferCode15" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemCode15" id="ItemCode15" >');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.ItemDescription15" id="ItemDescription15" >');
	write('<a onclick="searchItems(this.id);" name="searchItem_15" id="searchItem_15">');
	write('<img border="0" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('</td>');

	write('<td class="textfield">');
	write('<input class="textfieldamount" type="text"  name="' + subGroupName + '.UnitPrice15" id="UnitPrice15" >');
	write('</td>');

    
	write('</tr>');
   
   


   write('</table>');


   //////////////////////////////////////////////////////////******************************************



	


	




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
	write('</td>');
	write('</tr>');
	write('</table>');
	write('<!-- DETAILSBLOCK-END -->');
	write('</td>');
	write('</tr>');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return cmercha_det_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return cmercha_det_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return cmercha_det_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
	}else{
	write('<div class="ctable">');
	write('<input class="button" type="button" id="Back" value="'+jspResArr.get("FLT026526")+ '" onClick="javascript:return doSubmit(this.id)" hotKeyId="Ok">');
	}
	writeFooter();
	write('</div>');
	}
	} //End with()
}//End function

function fnSetCheckbox(objChkCtrl){
	
	var objChkFld = eval("document.forms[0]."+objChkCtrl.substring(3));
	var objChkboxCtrl = eval("document.forms[0]."+objChkCtrl);
	var isArray = (typeof(objChkboxCtrl.length)=="undefined")?false:true;
	if(isArray){
		for(var i=0;i<objChkboxCtrl.length;i++)
		{
			if(objChkboxCtrl[i].checked)
				objChkFld[i].value = "Y";
			else
				objChkFld[i].value = "N";
		}
	}
}


function fnOnLoad()
{

	var ObjForm = document.forms[0];

	pre_ONLOAD('cmercha_det',this);

	var funcName = "this."+"locfnOnLoad";
	if(eval(funcName) != undefined){
		eval(funcName).call(this);
	}

	fnPopulateControlValues();

	if(funcCode =='V' || funcCode =='I' || funcCode =='D' || funcCode =='U' ||  funcCode =='X' || sReferralMode =='I' || sReferralMode =='S'){
		fnDisableFormDataControls('V',ObjForm,0);
	}
	fnPopUpExceptionWindow(ObjForm.actionCode);
	if((typeof(WF_IN_PROGRESS) != "undefined") && (WF_IN_PROGRESS == "PEAS")){
		checkCustErrExecNextStep(Message);
	}

	post_ONLOAD('cmercha_det',this);
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues()
{
	var ObjForm = document.forms[0];

		/*
		ObjForm.RefCode1.value=RefCode1;
		alert(ObjForm.RefCode1.value);
		ObjForm.ItemCode1.value=ItemCode1;
		alert(ObjForm.ItemCode1.value);
		ObjForm.ItemDescription1.value=ItemDescription1;
		alert(ObjForm.ItemDescription1.value);
		ObjForm.UnitPrice1.value=UnitPrice1;
		alert(ObjForm.UnitPrice1.value);
		ObjForm.chkDeleteFlag1.checked=(DeleteFlag1=="Y")?true:false;
		ObjForm.DeleteFlag1.value=DeleteFlag1;
		*/

/*
	else
	{
		for(var i=0;i<iListMaxDisplay;i++)
		{
			if(RefCode[i] != 'null')
			{
				ObjForm.RefCode[i].value=RefCode[i];
				ObjForm.ItemCode[i].value=ItemCode[i];
				ObjForm.ItemDescription[i].value=ItemDescription[i];
				ObjForm.UnitPrice[i].value=UnitPrice[i];
				ObjForm.chkDeleteFlag[i].checked=(DeleteFlag[i]=="Y")?true:false;
				ObjForm.DeleteFlag[i].value=DeleteFlag[i];
			}
		}
	}
*/

	//ObjForm.TotalAmount.value = TotalAmount;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

}
/*
function fnCheckForNull(obj)
{
	var fieldValue =iListMaxDisplay;
	var ObjForm = document.forms[0];
	if(iListMaxDisplay == 1){
		if(!(ObjForm.RefCode.value)&&!(ObjForm.ItemCode.value)&&!(ObjForm.ItemDescription.value)&&!(ObjForm.UnitPrice.value)&&!(ObjForm.chkDeleteFlag.checked))
		{
			fieldValue--;
		}
	}else{
		for(var i=0;i<iListMaxDisplay;i++)
		{
			if(!(ObjForm.RefCode[i].value)&&!(ObjForm.ItemCode[i].value)&&!(ObjForm.ItemDescription[i].value)&&!(ObjForm.UnitPrice[i].value)&&!(ObjForm.chkDeleteFlag[i].checked))
			{
				fieldValue--;
			}
		}
	}
	if(fieldValue>=0 && fieldValue<iListMaxDisplay)
	{
		alert("Enter all records in the current screen");
	}
	else
	{
		doSubmit(obj.id);
	}
}
*/

function cmercha_det_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmercha_det',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmercha_det',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmercha_det_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmercha_det',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  fnValidateData(p1)) == false) {
		return false;
	}
	if (postEventCall('cmercha_det',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function cmercha_det_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('cmercha_det',obj,'ONCLICK') == false) {
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('cmercha_det',obj,'ONCLICK') == false) {
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}


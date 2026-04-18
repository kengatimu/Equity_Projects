function printBlock()
{
	writeCustomHeader("paydetdet");
	with (document){

	write('<input type="hidden" id="settldate" fdt="fdate" mneb1="N" vFldId="settldate_ui" name="' + subGroupName + '.settldate">');

	write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
	write('<tr>');
	write('<td>');
	write('<table border="0" cellspacing="0" cellpadding="0">');
	write('<tr>');
	write('<td class="page-heading">Over The Counter Transactions</td>');
	write('</tr>');
	write('</table>');
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%">');
	write('<tr>');

	write('<td class="textlabel">Function Code</td>');
	write('<td class="textfielddisplaylabel">' + funcCode + ' </td>');
	write('<td class="columnwidth">&nbsp; </td>');

	write('<td class="textlabel">Transaction Type</td>');
	write('<td class="textfielddisplaylabel">' + trantype + ' </td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('</tr>');
	write('<tr>')
	write('<td class="textlabel">SOL ID</td>');
	write('<td class="textfielddisplaylabel"> ' + solid + ' </td>');
	write('<td class="columnwidth">&nbsp; </td>');
//	write('</tr>');
//	write('<tr>');
	write('<td class="textlabel">Payment System Id</td>');
	write('<td class="textfielddisplaylabel">' + paysysid + ' </td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfielddisplaylabel"> </td>');

	write('</tr>');
	write('<tr>');

	write('<td class="textlabel">Ecs. Transaction Ref Num</td>');
	write('<td class="textfielddisplaylabel">' + Ecstranrefnum + ' </td>');
	write('<td class="columnwidth">&nbsp; </td>');
	write('<td class="textlabel"></td>');
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
	write('<tr class="subhdrbg" >');
	write('<td  colspan="5">');
	write('<h2 class="subhdr"> Sender Customer Details</h2>');
	write('</td>');
	write('</tr>');
	write('<tr>');

//
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Customer A/c ID <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
//	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custacc" id="custacc"  fdt="String" ' + paydetProps.get("custacc_ENABLED") + '>');
//	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031841") + '</td>');
//	write('<td class="textfield">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" onchange="javascript:return paydetdet_onChange_custacc();" name="' + subGroupName + '.custacc" id="custacc"  fdt="String" ' + paydetProps.get("custacc_ENABLED") + '>');
	write('&nbsp;<a id="sLnk6" href="javascript:showAccountIdList(document.forms[0].custacc,document.forms[0].custaccsolIdS,document.forms[0].custaccacctDescS,\'F\',document.forms[0].custacccrncyCodeS);">');
	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');

	write('</a>&nbsp;');
        write('<a id="customExplode1"  target="_self" href="JavaScript:fnExplodeBalanceDetails(document.forms[0].custacc.value)">');
        write('<img class="img" onmouseover="this.style.cursor=\'hand\';"  onmouseout=" this.style.cursor=\'default\';" src="../Renderer/images/'+applangcode+'/explode.gif" width="16" height="16" border="0" alt="Balance Details" width="24" height="20" onClick=""></img>');
        write('</a>');


	write('<br>');
	write('<input  type="text" class="label" readonly size="5" id="custaccsolIdS" name="' + subGroupName + '.custaccsolIdS">');
	write('<input  type="text" class="label" readonly size="40" id="custaccacctDescS" name="' + subGroupName + '.custaccacctDescS">');
	write('<input  type="text" class="label" readonly size="5" id="custacccrncyCodeS" name="' + subGroupName + '.custacccrncyCodeS">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield"></td>');


	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
//	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.thresholdLmtDr" id="thresholdLmtDr"  fdt="String" ' + paydetProps.get("thresholdLmtDr_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">ECS membership ID</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.ecsmebid" id="ecsmebid"  fdt="String" ' + paydetProps.get("ecsmebid_ENABLED") + '>');
	write('</td>');
//erick	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px">ECS Transaction code <script>setMandatory("Y");</script> </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.ecstrancode" id="ecstrancode"  fdt="String" ' + paydetProps.get("ecstrancode_ENABLED") + '>');
	      write("&nbsp;<a id=\"sLnk2\" target=_self href=\"Javascript:showRefCode(document.forms[0].ecstrancode,'CQ','N','F',document.forms[0].ecsTranCodedesc)\">");
      write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></img></a>');
      write('<input type=hidden class="label" name="' + subGroupName + '.ecsTranCodedesc" id="ecsTranCodedesc" size=3 maxlength="3" >');

	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Settlement Date<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
//	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.settldate" id="settldate"  fdt="String" ' + paydetProps.get("settldate_ENABLED") + '>');

	write('<input  maxlength="10" hotKeyId="calender1"  type="text" class="textfieldfont" fdt="uidate"  mnebl="false" name="' + subGroupName + '.settldate_ui" id="settldate_ui" >');
        write('&nbsp;<a  href="javascript:openDate(document.forms[0].settldate_ui,BODDate)"   id="sLnk2"><img align="absmiddle" alt="Date picker" border="0" height="19"  hotKeyId="calender1" src="../Renderer/images/'+applangcode+'/calender.gif" width="24" class="img" >');
        write('</a>');

	write('</td>');
	write('<td class="columnwidth"></td>');

	write('</tr>');


	write('<tr>');
	write('<td class="textlabel" style="height: 15px"> Net/Gross</td>');
	write('<td class="textfield">');
	write('<input type="radio" name="' + subGroupName + '.pymntType" id="pymntType"  fdt="String" ' + paydetProps.get("pymntType_ENABLED") + ' value="N" checked>Net');
	write('<input type="radio" name="' + subGroupName + '.pymntType" id="pymntType"  fdt="String" ' + paydetProps.get("pymntType_ENABLED") + ' value="G"> Gross');
	write('</td>');

//	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px">ECS Reference</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.ecsref" id="ecsref"  fdt="String" ' + paydetProps.get("ecsref_ENABLED") + '>');
	write('</td>');
	write('</tr>');

//eric start

	    write('<tr>');
  	write('<td class="textlabel" style="height: 15px">Rate Code/Rate<script>setMandatory("Y");</script></td>');
       	 write('<td class="textfield">');
    write('<input name="' + subGroupName + '.treaRate" id="treaRate" ' + paydetProps.get("treaRate_ENABLED") + ' hotKeyId="search1" type="text"  onchange="javascript:return paydetdet_onChange_ratechange();" class="twotextfieldsearchicon" size="9" maxlength="16" fdt="default">');
        write("<a id=\"sLnk5\" target=_self href=\"Javascript:showRefCode(document.forms[0].treaRate,'67','N','F')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');
        write('&nbsp;<input id="treaRefNum" readonly="readonly" name="' + subGroupName + '.treaRefNum" ' + paydetProps.get("treaRate_ENABLED") + ' type="text" class="twotextfieldsearchicon" size="9" maxlength="20" fdt="default" >');      

        write('</td>');
//	write('</tr>');

	write('<td class="textlabel" style="height: 15px">Tran CCY Code/Amount<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.tranccy" id="tranccy" ' + paydetProps.get("tranccy_ENABLED") + ' hotKeyId="search1" type="text" class="twotextfieldsearchicon" size="9" maxlength="16" fdt="default">');
//        write('&nbsp;<a id="treaRefNumImg" href="javascript:cust_callTrRefNoSearcher(this)">');
	write('&nbsp;<a id="sLnk8" href="javascript:showCurrencyList(document.forms[0].tranccy)">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');
        write('&nbsp;<input id="remitamt" name="' + subGroupName + '.remitamt" ' + paydetProps.get("remitamt_ENABLED") + ' type="text" class="twotextfieldsearchicon" onchange="javascript:return paydetdet_onChange_ratechange();" size="9" maxlength="20" fdt="default">');
        write('</td>');
	write('</tr>');

	write('<td class="textlabel" style="height: 15px">Charge Event ID</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.chrgeventid" id="chrgeventid"  fdt="String" ' + paydetProps.get("chrgeventid_ENABLED") + '>');
	write('&nbsp;<a id="sLnk9" href="javascript:getEvtIdList(document.forms[0].chrgeventid,\'ctrl\',\'F\',\'\',\'N\',\'Y\',\'ECO\')">');
	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></a>');
	write('</td>');
//	write('</tr>');
//	write('<tr>');

//	write('<td class="textlabel">&nbsp;</td>');

	write('<td class="textlabel" style="height: 15px">Treasury Ref Number</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.trearefcode" id="trearefcode" onChange="javascript: FetchPrefrate();" fdt="String" ' + paydetProps.get("trearefcode_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('</tr>');

//erick end

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Charge A/c ID</td>');
	write('<td class="textfield">');
//	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.chrgacc" id="chrgacc"  fdt="String" ' + paydetProps.get("chrgacc_ENABLED") + '>');
	write('&nbsp;<a id="sLnk6" href="javascript:showAccountIdList(document.forms[0].chrgacc,document.forms[0].chrgaccsolIdS,document.forms[0].chrgaccacctDescS,\'F\',document.forms[0].chrgacccrncyCodeS);">');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" onchange="javascript:return paydetdet_onChange_chrgacc();" name="' + subGroupName + '.chrgacc" id="chrgacc"  fdt="String" ' + paydetProps.get("chrgacc_ENABLED") + '>');

	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<br>');
	write('<input  type="text" class="label" readonly size="5" id="chrgaccsolIdS" name="' + subGroupName + '.chrgaccsolIdS">');
	write('<input  type="text" class="label" readonly size="40" id="chrgaccacctDescS" name="' + subGroupName + '.chrgaccacctDescS">');
	write('<input  type="text" class="label" readonly size="5" id="chrgacccrncyCodeS" name="' + subGroupName + '.chrgacccrncyCodeS">');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield"></td>');

	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Suspence A/c ID <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
//	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.suspacc" id="suspacc"  fdt="String" ' + paydetProps.get("suspacc_ENABLED") + '>');
	write('<input hotKeyId="search3" type="text" class="textfieldfont" onchange="javascript:return paydetdet_onChange_suspacc();" name="' + subGroupName + '.suspacc" id="suspacc"  fdt="String" ' + paydetProps.get("suspacc_ENABLED") + '>');
	write('&nbsp;<a id="sLnk6" href="javascript:showAccountIdList(document.forms[0].suspacc,document.forms[0].suspaccsolIdS,document.forms[0].suspaccacctDescS,\'F\',document.forms[0].suspacccrncyCodeS);">');
	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
	write('</a>');
	write('<br>');
	write('<input  type="text" class="label" readonly size="5" id="suspaccsolIdS" name="' + subGroupName + '.suspaccsolIdS">');
	write('<input  type="text" class="label" readonly size="40" id="suspaccacctDescS" name="' + subGroupName + '.suspaccacctDescS">');
	write('<input  type="text" class="label" readonly size="5" id="suspacccrncyCodeS" name="' + subGroupName + '.suspacccrncyCodeS">');
//	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel"></td>');
	write('<td class="textfield"></td>');

	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">TRansaction Remarks</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.tranrmks" id="tranrmks" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("tranrmks_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');



//

//	write('<td class="columnwidth"></td>');
//	write('<td class="textlabel">' + jspResArr.get("FLT031840") + '</td>');
//	write('<td class="textfield">');
//	write('<input hotKeyId="search2" type="text" class="textfieldfont" name="' + subGroupName + '.BICCode" id="BICCode"  fdt="String" ' + paydetProps.get("BICCode_ENABLED") + '>');
//	//write('&nbsp;<a id="sLnk5" href="javascript:showBICCodes(document.forms[0].BICCode,document.forms[0].BICCode1.value,document.forms[0].BICCode2.value,document.forms[0].BICCode3)">');
//       write('&nbsp;<a id="sLnk5" href="javascript:showBICCodes(document.forms[0].BICCode)">');
//	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></a>');
//	write('</td>');
//	write('</tr>');
//	write('<tr>');
//	write('<td  class="textlabel">');
//	write('</td>');
//	write('<td " class="textfield">');
//	write('<input  type="text" class="label" readonly size="5" id="solIdN" name="' + subGroupName + '.solIdN">');
//	write('<input  type="text" class="label" readonly size="40" id="acctDescN" name="' + subGroupName + '.acctDescN">');
//	write('<input  type="text" class="label" readonly size="5" id="crncyCodeN" name="' + subGroupName + '.crncyCodeN">');
//	write('</td>');
//	write('<td  class="columnwidth">');
//	write('</td>');
//	write('<td  class="textlabel">');
//	write('</td>');
//	write('<td  class="textfield">');
//	write('<input  type="text" class="label" readonly id="BICCode1" name="' + subGroupName + '.BICCode1">');
//	write('<input  type="text" class="label" readonly id="BICCode2" name="' + subGroupName + '.BICCode2">');
//	write('<input  type="text" class="label" readonly id="BICCode3" name="' + subGroupName + '.BICCode3">');
//	write('</td>');
//	write('</tr>');
//	write('<tr>');
//	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031841") + '</td>');
//	write('<td class="textfield">');
//	write('<input hotKeyId="search3" type="text" class="textfieldfont" onchange="javascript:return paydetdet_onChange_suspenseAcct();" name="' + subGroupName + '.suspenseAcct" id="suspenseAcct"  fdt="String" ' + paydetProps.get("suspenseAcct_ENABLED") + '>');
//	write('&nbsp;<a id="sLnk6" href="javascript:showAccountIdList(document.forms[0].suspenseAcct,document.forms[0].solIdS,document.forms[0].acctDescS,\'F\',document.forms[0].crncyCodeS);">');
//	write('<img border="0" height="17" hotKeyId="search3" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
//	write('</a>');
//	write('<br>');
//	write('<input  type="text" class="label" readonly size="5" id="solIdS" name="' + subGroupName + '.solIdS">');
//	write('<input  type="text" class="label" readonly size="40" id="acctDescS" name="' + subGroupName + '.acctDescS">');
//	write('<input  type="text" class="label" readonly size="5" id="crncyCodeS" name="' + subGroupName + '.crncyCodeS">');
//	write('</td>');
//	write('<td class="columnwidth"></td>');
//	write('<td class="textlabel"></td>');
//	write('<td class="textfield"></td>');
//	write('</tr>');

//


	write('</tr>');

	write('<tr class="subhdrbg">');
	write('<td colspan="5">');
	write('<h2 class="subhdr">Destination Customer Details</h2>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">City </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.citycode" id="citycode"  fdt="String" ' + paydetProps.get("citycode_ENABLED") + '>');
	write('</td>');


//	write('<td class="columnwidth" style="width: 105px"></td>');
	write('<td class="textlabel" style="height: 15px">Bank Code/Branch Code<script>setMandatory("Y");</script></td>');
        write('<td class="textfield">');
        write('<input name="' + subGroupName + '.bankcode" id="bankcode" ' + paydetProps.get("bankcode_ENABLED") + ' hotKeyId="search1" type="text" class="twotextfieldsearchicon" size="9" maxlength="16" fdt="default">');
//        write('&nbsp;<a id="treaRefNumImg" href="javascript:cust_callTrRefNoSearcher(this)">');

//        write('<td width="18"><a id="sLnk10" target=_self href="Javascript:listBankCodes(\'N\',document.forms[0].bankcode,\'F\',document.forms[0].destBankName)">');

        write('<a id="sLnk10" target=_self href="Javascript:listBankCodes(\'N\',document.forms[0].bankcode,\'F\',document.forms[0].destBankName)">');

//	write('<br>');
//	write('<td>');
	write('<input  type="text" class="label" readonly size="5" id="destBankName" name="' + subGroupName + '.destBankName">');
//	write('</td>');
//        write('<a id="sLnk11" target=_self href="Javascript:showBranchCodes(document.forms[0].bankcode,document.forms[0].branchcode,\'ctrl\',\'F\',document.forms[0].destBranchName)">');

        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');
        write('&nbsp;<input id="branchcode" name="' + subGroupName + '.branchcode" ' + paydetProps.get("branchcode_ENABLED") + ' type="text" class="twotextfieldsearchicon" size="9" maxlength="20" fdt="default">');

        write('<a id="sLnk11" target=_self href="Javascript:showBranchCodes(document.forms[0].bankcode,document.forms[0].branchcode,\'ctrl\',\'F\',document.forms[0].destBranchName)">');

//	write('<br>');
//	write('<td>');
	write('<input  type="text" class="label" readonly size="5" id="destBranchName" name="' + subGroupName + '.destBranchName">');
//	write('</td>');

//        write('&nbsp;<a id="treaRefNumImg" href="javascript:cust_callTrRefNoSearcher(this)">');
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');
    
        write('</td>');
	write('</tr>');

//	write('<td class="columnwidth"></td>');
//	write('<td class="textlabel" style="height: 15px">Bank/Branch Code </td>');
//	write('<td class="textfield">');
//	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.bankcode" id="bankcode"  fdt="String" ' + paydetProps.get("bankcode_ENABLED") + '>');
//	write('</td>');
//	write('</tr>');
//	write('<tr>');
//

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">A/c ID <script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.receiveracc" id="receiveracc" onchange="javascript:return paydetdet_onChange_receiveracc();" onClick="javascript:FetchCity();" onblur="javascript: FetchCity();" size="13" maxlength="13"  fdt="String" ' + paydetProps.get("receiveracc_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">A/c Name<script>setMandatory("Y");</script></td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.receiveraccname" id="receiveraccname" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("receiveraccname_ENABLED") + '>');
	write('</td>');
	write('<td class="columnwidth"></td>');
	write('<td class="textlabel" style="height: 15px"> </td>');
	write('<td class="textfield">');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel">&nbsp;</td>');
	write('</tr>');



//


write('<tr class="subhdrbg">');
	write('<td  colspan="5">');
	write('<h2 class="subhdr">IBAN Details</h2>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Charge Account (IBAN) </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.chrgibanacc" id="chrgibanacc"  fdt="String" ' + paydetProps.get("chrgibanacc_ENABLED") + '>');
	write('</td>');

//	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Customer Account (Iban)</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont"  onchange="javascript:return paydetdet_onChange_custaccIban(); name="' + subGroupName + '.custaccIban" id="custaccIban"  fdt="String" ' + paydetProps.get("custaccIban_ENABLED") + '>');
	write('</td>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Customer Destination Acc (Iban) </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custdestaccIban" id="custdestaccIban"  fdt="String" ' + paydetProps.get("custdestaccIban_ENABLED") + '>');
	write('</td>');


	write('<tr class="subhdrbg">');
	write('<td  colspan="5">');
	write('<h2 class="subhdr">Address Details</h2>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Customer Name</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.custname" id="custname" onChange="javascript: fnchk_invld_chr(this);"  fdt="String" ' + paydetProps.get("custname_ENABLED") + '>');
//	write('&nbsp;<a id="sLnk8" href="javascript:getEvtIdList(document.forms[0].outEventId,\'ctrl\',\'F\',\'\',\'N\',\'Y\',\'RECHO\')">');
//	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></a>');
	write('</td>');

//	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Address Line 1</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.addline1" id="addline1" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("addline1_ENABLED") + '>');
	write('</td>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Address line 2 </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.addline2" id="addline2"  onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("addline2_ENABLED") + '>');
	write('</td>');

//	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Address line 3 </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.addline3" id="addline3" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("addline3_ENABLED") + '>');
	write('</td>');

	write('<tr>');
	write('<td class="textlabel" style="height: 15px">Address line 4 </td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.addline4" id="addline4" onChange="javascript: fnchk_invld_chr(this);"  fdt="String" ' + paydetProps.get("addline4_ENABLED") + '>');
	write('</td>');





//	write('<td class="columnwidth"></td>');
//	write('<td class="textlabel">' + jspResArr.get("FLT031849") + '</td>');
//	write('<td class="textfield">');
//	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.inEventId" id="inEventId"  fdt="String" ' + paydetProps.get("inEventId_ENABLED") + '>');
//	if(pymntIndctrD == "RTGS")
//	write('&nbsp;<a id="sLnk9" href="javascript:getEvtIdList(document.forms[0].inEventId,\'ctrl\',\'F\',\'\',\'N\',\'Y\',\'RECHI\')">');
//	if(pymntIndctrD == "ACH")
//	write('&nbsp;<a id="sLnk9" href="javascript:getEvtIdList(document.forms[0].inEventId,\'ctrl\',\'F\',\'\',\'N\',\'Y\',\'ACHCI\')">');
//	write('<img src="../images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" hotKeyId="search2"></a>');
//	write('<br>');
//	write('</td>');
//	write('</tr>');
//	write('<tr>');
//	write('<td class="textlabel">&nbsp;</td>');
//	write('</tr>');
	write('<tr class="subhdrbg">');
	write('<td  colspan="5">');
	write('<h2 class="subhdr">' + jspResArr.get("FLT000143") + '</h2>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031829") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeTxt1" id="freeTxt1" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("freeTxt1_ENABLED") + '>');
	write('</td>');
//	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031830") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeTxt2" id="freeTxt2" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("freeTxt2_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031831") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeTxt3" id="freeTxt3" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("freeTxt3_ENABLED") + '>');
	write('</td>');
//	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT031846") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeTxt4" id="freeTxt4" onChange="javascript: fnchk_invld_chr(this);"  fdt="String" ' + paydetProps.get("freeTxt4_ENABLED") + '>');
	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT031847") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeTxt5" id="freeTxt5" onChange="javascript: fnchk_invld_chr(this);" fdt="String" ' + paydetProps.get("freeTxt5_ENABLED") + '>');
	write('</td>');
//	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000134") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeCode1" id="freeCode1"  fdt="String" ' + paydetProps.get("freeCode1_ENABLED") + '>');

	write("<a id=\"sLnk1\" target=_self href=\"Javascript:showRefCode(document.forms[0].freeCode1,'DA','N','F')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');

	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000135") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeCode3" id="freeCode2"  fdt="String" ' + paydetProps.get("freeCode2_ENABLED") + '>');
//
 	write("<a id=\"sLnk2\" target=_self href=\"Javascript:showRefCode(document.forms[0].freeCode2,'DA','N','F')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');

	write('</td>');
//	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000136") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeCode3" id="freeCode3"  fdt="String" ' + paydetProps.get("freeCode3_ENABLED") + '>');

	write("<a id=\"sLnk1\" target=_self href=\"Javascript:showRefCode(document.forms[0].freeCode3,'DA','N','F')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');

	write('</td>');
	write('</tr>');
	write('<tr>');
	write('<td class="textlabel" style="height: 15px">' + jspResArr.get("FLT000137") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeCode4" id="freeCode4"  fdt="String" ' + paydetProps.get("freeCode4_ENABLED") + '>');

   	write("<a id=\"sLnk1\" target=_self href=\"Javascript:showRefCode(document.forms[0].freeCode4,'DA','N','F')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');



	write('</td>');
//	write('<td class="columnwidth"></td>');
	write('<td class="textlabel">' + jspResArr.get("FLT000138") + '</td>');
	write('<td class="textfield">');
	write('<input type="text" class="textfieldfont" name="' + subGroupName + '.freeCode5" id="freeCode5"  fdt="String" ' + paydetProps.get("freeCode5_ENABLED") + '>');

   	write("<a id=\"sLnk1\" target=_self href=\"Javascript:showRefCode(document.forms[0].freeCode5,'DA','N','F')\">");
        write('<img src="../Renderer/images/' + applangcode + '/search_icon.gif" width="16" height="17" border="0" alt="Search list" hotKeyId="search4"></a>');

	write('<input type="hidden" name="tsCnt">');
	write('<input type="hidden" name="flg">');
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
	write('<input id="Submit" name="Submit" type="button" class="button"	onClick="javascript:return paydetdet_ONCLICK1(this,this);"" value="' + jspResArr.get("FLT000193") + '" hotKeyId="Submit">');
	write('<input id="Validate" name="Validate" type="button" class="button" value="' + jspResArr.get("FLT000194") + '"	onClick="javascript:return paydetdet_ONCLICK2(this,this);"" hotKeyId="Validate">');
	write('<input id="Cancel" name="Cancel" type="button" class="button" value="' + jspResArr.get("FLT001721") + '"	onClick="javascript:return paydetdet_ONCLICK3(this,this.id);"" hotKeyId="Cancel">');
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

	initFocusHandler();

	pre_ONLOAD('paydetdet',this);

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

	post_ONLOAD('paydetdet',this);
	paydetdet_post_onLoad();
	//document.forms[0].BICCode2.value ="B";
}

function fnCheckMandatoryFields()
{
	var ObjForm = document.forms[0];

	return true;
}

function fnPopulateControlValues() 
{
	var ObjForm = document.forms[0];

	ObjForm.custacc.value = custacc;
	ObjForm.ecsmebid.value = ecsmebid;
	ObjForm.ecstrancode.value = ecstrancode;
	ObjForm.settldate.value = settldate;
	ObjForm.pymntType.value = pymntType;
	ObjForm.ecsref.value = ecsref;
	ObjForm.treaRate.value = treaRate;
	ObjForm.treaRefNum.value = treaRefNum;
	ObjForm.tranccy.value = tranccy;
	ObjForm.remitamt.value =remitamt;
	ObjForm.chrgeventid.value = chrgeventid;
	ObjForm.chrgacc.value = chrgacc;

	ObjForm.trearefcode.value =trearefcode;

	ObjForm.suspacc.value = suspacc;
	ObjForm.tranrmks.value = tranrmks;
	ObjForm.citycode.value = citycode;
	ObjForm.branchcode.value = branchcode;
	ObjForm.bankcode.value = bankcode;
	ObjForm.receiveracc.value = receiveracc;
	ObjForm.receiveraccname.value = receiveraccname;
	ObjForm.chrgibanacc.value = chrgibanacc;
	ObjForm.custaccIban.value = custaccIban;
	ObjForm.custdestaccIban.value = custdestaccIban;
	ObjForm.custname.value = custname;
	ObjForm.addline4.value = addline4;
	ObjForm.addline3.value = addline3;
	ObjForm.addline2.value = addline2;
	ObjForm.addline1.value = addline1;


	ObjForm.freeTxt1.value = freeTxt1;
	ObjForm.freeTxt2.value = freeTxt2;
	ObjForm.freeTxt3.value = freeTxt3;
	ObjForm.freeTxt4.value = freeTxt4;
	ObjForm.freeTxt5.value = freeTxt5;
	ObjForm.freeCode1.value = freeCode1;
	ObjForm.freeCode2.value = freeCode2;
	ObjForm.freeCode3.value = freeCode3;
	ObjForm.freeCode4.value = freeCode4;
	ObjForm.freeCode5.value = freeCode5;
	fnCheckControls();

}

function fnCheckControls()
{
	var ObjForm = document.forms[0];

	checkRadio(ObjForm.pymntType,pymntType);
}


function paydetdet_ONCLICK1(obj,p1)
{
	var retVal = "";
	if (preEventCall('paydetdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('paydetdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function paydetdet_ONCLICK2(obj,p1)
{
	var retVal = "";
	if (preEventCall('paydetdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  fnValAndSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('paydetdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}

function paydetdet_ONCLICK3(obj,p1)
{
	var retVal = "";
	if (preEventCall('paydetdet',obj,'ONCLICK') == false) { 
		return false;
	}
	if ((retVal =  doSubmit(p1)) == false) {
		return false;
	}
	if (postEventCall('paydetdet',obj,'ONCLICK') == false) { 
		return false;
	}
	return (retVal == undefined) ? true : retVal;
}



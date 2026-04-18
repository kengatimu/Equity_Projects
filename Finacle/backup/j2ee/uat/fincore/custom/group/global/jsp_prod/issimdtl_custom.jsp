<%!
/*-----------------------------------------------------------------------------------------
   Name         :   issimdtl_custom.jsp 
   Calling Jsp  :   NA
   Called JSP   :   NA
   Called JS    :   issimdtl_custom.js
   Called Script:   NA
   Description  :   This page displays inter entity standing instructions details of an account.
   Menu Option  :   HSSIM
   Author       :   Priyanka_T02

   Modification History:
   ====================
   Serial No.       Date                Author           Description
  ------------    -------------      --------------     ---------------
      1.0          23-Apr-2013       Priyanka_T02     This page displays inter entity standing instructions details.
      2.0	08-Aug-2013	Mohan Raghu Arudi	366057, 366050 changes done
------------------------------------------------------------------------------------------
*/
%>
<script language="javascript" src="../Renderer/custom/javascripts/issimdtl_custom.js"></script>

<script>
        with(document){
        write('<table width="99.25%" border="0" cellpadding="0" cellspacing="0" class="ctable"><tr><td>');
        write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table"><tr><td>');
        write('<table width="100%" border="0" cellpadding="1" cellspacing="0" class="innertable">');
        write('<tr class="subhdrbg" align="left">');
        write('<td class = "subhdr">Inter Entity Standing Instruction</td>');
        write('<td ALIGN="left">');
        write('</td>');
        write('<td class = "textlabel"></td>');
        write('<td ALIGN="left">');
        write('</td>');
        write('</tr>');

        write('<tr>');
	write('<td class = "textlabel">Inter Entity SI</td>');
        write('<td class="textfield">');
	write('<input type="radio" name="interEntity" id="interEntity" value="Y"  onclick="fnCheck(this)">Yes');
	write('<input type="radio" name="interEntity" id="interEntity" value="N"  onclick="fnCheck(this)" checked>No');
	write('<input type="hidden" name="interEntityFlg" id="interEntityFlg" value="N" >');
	write('</td>');
	write('<td class="textlabel">&nbsp;</td>');	
	write('<td class="textfield">&nbsp;</td>');
	write('</tr>');

	write('<tr>');
	write('<td class = "textlabel">Target Entity</td>');
        write('<td class="textfield">');
        write('<input type="text"  class="textfieldfont" name="targetEntity" id="targetEntity" maxlength="8">&nbsp;&nbsp;');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="text"  class="label" name="targetEntityDesc" id="targetEntityDesc" size="35" maxlength="50">');
	write('</td>');
        write('<td class="textfield">&nbsp;</td>');
	write('</tr>');
	
        write('<tr>');
	write('<td class = "textlabel">Target Entity Customer A/c ID</td>');
	write('<td class="textfield">');
	write('<input type="text"  class="textfieldfont" name="targetEntityAcctId" id="targetEntityAcctId" onBlur="javascript:fnGetAcctDetails()" maxlength="16">');
	write('&nbsp;<a id="targetEntityAcctIdImg" href="javascript:getAcctIdList()">');
        write('<img border="0" alt="Search List" height="17" hotKeyId="search1" src="../Renderer/images/'+applangcode+'/search_icon.gif" width="16">');
        write('</a>&nbsp;');
	write('</td>');
	write('<td class="textfield">');
	write('<input type="text"  class="label" name="targetAcctIdSolId" id="targetAcctIdSolId" size="3" maxlength="8">&nbsp;&nbsp;');
	write('<input type="text"  class="label" name="targetAcctIdCcy" id="targetAcctIdCcy" size="3" maxlength="3">&nbsp;&nbsp;');
	write('<input type="text"  class="label" name="targetAcctIdName" id="targetAcctIdName" size="35" maxlength="50">');
	write('</td>');
        write('</tr>');

        write('</table>');
        write('</td></tr></table>');
        write('</td></tr></table>');
	}

	
</script>



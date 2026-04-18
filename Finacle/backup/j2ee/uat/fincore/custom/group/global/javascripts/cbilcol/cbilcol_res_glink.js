function printBlock()
{
    writeCustomHeader("cbilcol_res");
    with (document){
    write('<table border="0" cellspacing="0" cellpadding="0" class="ctable">');
    write('<tr>');
    write('<td>');
    write('<table border="0" cellspacing="0" cellpadding="0">');
    write('<tr>');
    write('<td class="page-heading">BILL COLLECTION TRANSACTION</td>');
    write('</tr>');
    write('</table>');
    write('</td>');
    write('</tr>');
    write('</table>');
    write('<table class="ctable1" width="100%" border="0" cellspacing="0" cellpadding="0">');
    write('<tr class="rowspacing">');
    write('<td colspan="5">&nbsp;</td>');
    write('</tr>');
    write('</table>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ctable">');
    write('<tr>');
    write('<td valign="top">');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder">');
    write('<tr>');
    write('<td>');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">');
    write('<tr class="textfielddisplaylabel1" valign="middle">');
    write('<td colspan="5">');
    write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="resultpage">');
    write('<tr>');
    write('<td width="3%">');
    write('<img class="img" src="../Renderer/images/info.gif" width="29" height="29" align="right" border="0">');
    write('</img></td>');

    write('<td width="97%" style="color:black"> ' + Message + '</td>');
    write('</tr>');
    write('</table>');
    write('</td></tr>');
    write('</table></td></tr>');
    write('</table></td></tr>');
    write('</table></td></tr>');
    write('</table>');
    } //End with()
} //End function

function printFooterBlock()
{
    with (document) {
    write('<div class="ctable">');
    write('<input type="button" class="button" id="ok" value="Ok" onClick="javascript:return cbilcol_res_ONCLICK(this);" hotKeyId="Go">');
    writeFooter();
    write('</div>');
    }
}//End function



function cbilcol_res_ONCLICK(obj)
{
    var retVal = "";
    /*if (pre_ONCLICK('cbilcol_res',obj) == false) { 
        return false;
    }*/
    if ((retVal = fnLastButtonClick()) == false) {
        return false;
    }
    /*if (post_ONCLICK('cbilcol_res',obj) == false) { 
        return false;
    }*/
    return (retVal == undefined) ? true : retVal;
}

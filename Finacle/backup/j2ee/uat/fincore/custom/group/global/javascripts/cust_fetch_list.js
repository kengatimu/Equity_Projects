function printHTML()
{
	with(document)
	{
		write('<table class="ctable" align="center" border="0" cellspacing="1" cellpadding="1">');
		write('<tr><td class="ctext" colspan="' + colsLen + '" align="center">');
		write('<b>&nbsp;' + pageTitle + '<b></td>');
		write('</tr></table>');

		if (!displayRecs)
		{
			showErrors();
		}
		else
		{
			write('<table class="ctable" align="center" cellspacing="2" cellpadding="2" border="1">');

			/*
				Literal Names
			*/

			write('<tr>');
			for (var colCount=0; colCount<colsLen; colCount++)
			{
				write('<td class="ccaption" align=center><b>' + literalsBuff[colCount] + '</b></td>');
			}
			write('</tr>');

			if(totRecs == 0)
			{
				write('<tr>');
				write('<td colspan="' + colsLen + '" align="center">No records were fetched.</td>');
				write('</tr>');
			}
			else
			{
				showList();
			}

			write('<tr><td align="center" colspan="' + colsLen + '">');
			write('<input type="button" class="button" value="Close" onclick="javaScript:fnClose();">');
			write('</td></tr></table>');
		}
	}
}

function showList()
{
	var effColNum = 0;
	var retVal = "";
	var obj = null;
	
	for (var i=0; i<totRecs; i++)
	{
		document.write('<tr>');
		
		retVal = getReturnValues(i);
		
		for(var j=0; j<colsLen; j++)
		{
			/*
				Column Names are starting with 1. Hence, used effColNum.
			*/
			
			effColNum = j+1;
			
			obj = eval("col" + effColNum);
					
			if (isHyperLink(effColNum))
			{
				document.write('<td align="center">');
				document.write('<font color="blue">');
				document.write('<a onclick="javaScript:fnSetValue(\'' + retVal + '\');" onmouseover="this.style.cursor=\'hand\';"');
				document.write(' onmouseout="this.style.cursor=\'default\';">' + unescape(obj[i]) + '</font></a></td>');
			}
			else 
			{
				document.write('<td align="center">' + unescape(obj[i]) + '&nbsp;</td>');
			}				
		}
		
		document.write('</tr>');			
	}
}

function getReturnValues(recNum)
{
	var str = "";
	for(var i=0; i<colsLen; i++)
	{
		str += eval("col"+(i+1) + "[" + recNum + "]");
		if (i != (colsLen-1))
			str += "|";
	}
	return str;
}

function isHyperLink(colNum)
{
	var chk = false;
	for(var i=0; i<hyperLnksLen; i++)
	{
		if (parseInt(hyperLnksBuff[i], 10) == colNum)
		{
			chk = true;
			break;
		}
	}

	return chk;
}

function fnClose()
{
	window.close();
}

function fnSetValue(str)
{
	window.returnValue = str;
	window.close();
}

function showErrors()
{
    with (document) {

    write('<table class="ctable" align="center" cellspacing="2" cellpadding="2" border="0">');
    write('<tr><td>');
    write('<table class="ctable" align="center" cellspacing="0" cellpadding="0" border="1">');
    write('<tr>');
    write('<td class="ccaption">' + finbranchResource.FLT003072 + '</td>');
    write('<td class="ccaption">' + finbranchResource.FLT000217 + '</td>');
    write('<td class="ccaption">' + finbranchResource.FLT002771 + '</td>');
    write('</tr>');

    for (var i=0; i<errCode.length; i++)
    {
	    with(document)
	    {
	    write('<tr><td align="left">&nbsp;' + errCode[i] + '</td>');
	    write('<td align="left">&nbsp;' + errType[i] + '</td>');
	    write('<td align="left">&nbsp;' + errDesc[i] + '</td></tr>');
	    }
    }

    write('<tr>');
    write('<td class="ctext" colspan="3"  align="center">');
    write('<center><font color="blue">');
    write('<a onClick=\'window.close()\' onmouseover="this.style.cursor=\'hand\'"; onmouseout="this.style.cursor=\'default\'"><b>Close<b></a>');
    write('</font></center></td>');
    write('</tr>');
    write('</table>');
    write('</td></tr></table>');

    } //End with()
}

var sTmpVal = null,attr = "";
var sExtraNote =0;
var sExtraCoin =0;
var totLoopIndex = 0,totIndex = 1,maxIndex = 0;
function printFunctionBlock()
{
	with (document) {
	write('<tr><td><table border="0" cellspacing="0" cellpadding="0"><tr><td class="page-heading">');
	write('' + menuTitle + '');
	write('</td></tr></table><table width="100%" border="0" cellpadding="0" cellspacing="0">'); //Row 1
	write('<tr width="100%">'); //Row 1 - DataSet 1
	write('<td colspan=1 class="textlabel2">'+'Function  ');
	write('</td><td colspan=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>:</b>&nbsp;&nbsp;&nbsp;');
	if(Func=="A"||Func=="M1")	write('<input class="label" READONLY value="ADD" TABINDEX=-1>');
	else if(Func=="I")	write('INQUIRE');
	else if(Func=="M")	write('MODIFY');
	else if(Func=="R")	write('REVERSAL');
	else if(Func=="D")	write('DELETE');
	else if(Func=="P")	write('POST');
	else if(Func=="T")	write('Copy Template');
	else if(Func=="C")	write('COPY');
	else if(Func=="V")	write('VERIFY');
	write('&nbsp;&nbsp;&nbsp;</td>'); //Row 1 - DataSet 2
	write('<td colspan=1 class="textlabel2">' + 'Currency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : </td>');
	write('<td align="left" colspan=1 class="textlabel">');
	write('<input class="label" READONLY value=' + currency + ' TABINDEX=-1></td>'); //Row 1 - DataSet 3
	write('<td colspan=1 class="textlabel2">' + 'Decimal points : ' + '</td><td colspan=1>');
	write(numOfDecPoints);
	write('</td></tr>'); //Row 2
	write('<tr>'); //Row 2 - DataSet 1
	write('<td colspan=2 class="textlabel2">' + 'Total Tran Amount : ');
	write('<input class=label id="partTranAmt" name="custom.partTranAmt" READONLY value="' + partTranAmt +'" TABINDEX=-1></td>');
	write('<td colspan=1 class="textlabel">' + 'Credit / Debit : ');
	write('</td><td colspan=1 class="textlabel">');
	if(PartTranType=="C")
		write('<input class="label" READONLY value="Cash IN" TABINDEX=-1>');
	else
		write('<input class="label" READONLY value="Cash OUT" TABINDEX=-1>');
	write('</td><td class="textlabel"></td>'); //Row 2 - DataSet 1
	write('</tr></table>'); //End of Function block
	}
	var partTranAmt1=document.getElementById("partTranAmt");
//	cust_newformatAmt('Million',partTranAmt1,currency,'N');
}

function printDenomBlock(pageName,fieldValues,blockName,type)
{

	var ValuesList = fieldValues.split("!");
	var NoteIndex = 0,CoinIndex = 0;
	totLoopIndex  = maxIndex;

//	writeHeader("tmdet");
	with (document) {

	//Start of Table 
	write('<table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td valign="top">');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableborder"><tr><td>');
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable"><tr><td>');
	//Start of data block
	write('<table width="100%" border="0" cellpadding="0" cellspacing="0">');
	write('<tr class="innertabletop1"><td colspan="5" align="right">');
	write('<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>');
	//Tran Status can be put here
	write('<td align="right"><table border="0" cellspacing="0" cellpadding="0"><tr><td align="right">');
	// Image <a> can be put here
	write('</td></tr></table></td></tr></table></td></tr>');
	// Name Block
	write('<tr class="subhdrbg"><td width="58%" class="textlabel">');
	write(blockName);
	write('</td>');
	/*
	write('<td width="58%">');
	write('&nbsp;&nbsp;<a href="javascript:copyScreen();">');
	write('<img src="../images/' + applangcode + '/contra.gif" alt="Copy Screen" width="16" height="16" border="0"></a>');
	write('&nbsp;&nbsp;<a href="javascript:pasteScreen();">');
	write('<img src="../images/' + applangcode + '/contra.gif" alt="Paste Screen" width="16" height="16" border="0"></a>');
	write('&nbsp;&nbsp;<a href="javascript:retainOldVals();">');
	write('<img src="../images/' + applangcode + '/contra.gif" alt="Restore Screen" width="16" height="16" border="0"></a>');
	write('</td>');
	*/
	write('<td colspan="10" align="right">');
	write('<table border="0" cellpadding="0" cellspacing="0">');
	write('<tr><td align="right">');
	if(type=="")
	{
	write('<a href="javascript:fnPressPrev();" id="sPrev">');
	write('<img hotKeyId="Prev" src="/finbranch/images/INFENG/arrowpre.gif" width="7" height="14" vspace="1" border="0"></a>');
	write('&nbsp;&nbsp;&nbsp;');
	write('</td><td>');
	write('&nbsp;' + (arrayPtr+1) + '&nbsp;of&nbsp;' + recCount + '&nbsp;');
	write('</td><td>');
	write('<a href="javascript:fnPressNext();" id="sNext">');
	write('<img hotKeyId="Next" src="/finbranch/images/INFENG/arrownext.gif" width="7" height="14" vspace="1" border="0" align="absmiddle"></a>');
	write('&nbsp;&nbsp;&nbsp;&nbsp;');
	}
	write('</td></tr></table></td></tr>');
	// End of Name Block
	//Heading Rows
	write('<tr colspan=6 width="100%">');
	write('<td width="15%" class="textlabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note</td>');
	write('<td width="15%" class="textlabel">' + 'Note Denomination' + '');
	if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")
	write('<td width="15%" class="textlabel" >' + 'Max Avl.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + '</td>');
	else
	write('<td width="15%" class="textlabel"></td>');
	write('<td width="10%">&nbsp;</td>');
	write('<td width="15%" class="textlabel">Coin</td>');
	write('<td width="15%" class="textlabel">' + 'Coin Denomination' + '');
	
	if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")
	write('<td width="15%" class="textlabel">' + 'Max Avl.' + '</td>');
	else
	write('<td width="15%" class="textlabel"></td>');
	write('</tr>');
	while((NoteIndex < lenNoteValArr)||(CoinIndex < lenCoinValArr))
	{
		write('<tr><td class="textlabel">'); // Note Denominations display
		if (NoteIndex < lenNoteValArr)
		{
			write('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="label" id="NoteDenomValue'+NoteIndex+'" name="custom.NoteDenomValue'+NoteIndex+'" size=5 READONLY value="' + CurrNoteValues[NoteIndex] +'" TABINDEX=-1>');
			write('&nbsp;&nbsp;-');
		}
		write('</td><td>');
		if (NoteIndex < lenNoteValArr)
		{
			attr = "Note";
			totIndex = totLoopIndex + parseInt(NoteIndex) + 1;
			if(totIndex > maxIndex) maxIndex = totIndex;
			sTmpVal = (ValuesList[CoinCount+NoteIndex]==null)?"0":ValuesList[CoinCount+NoteIndex];
// Changes done here for setVarFlag = N case (Notes)
			if (setVarFlg == "N") {
				sExtraNote = sTmpVal * CurrNoteValues[NoteIndex];
			}else{
				sExtraNote = sTmpVal;
			}
			write('<input class=textfieldamount17num fblk="'+type+'" id="'+type+'NoteDenomCount'+NoteIndex+'" name="denom.'+pageName+'NoteDenomCount'+NoteIndex+'" type="hidden" size="5" maxlength="12" value="'+sTmpVal+'" TABINDEX="'+totIndex+'">' );
			write('<input class=textfieldamount17num fblk="'+type+'" id="'+type+'NoteDenomCountExtra'+NoteIndex+'" name="'+pageName+'NoteDenomCountExtra'+NoteIndex+'" size="5" maxlength="12" onChange="return fnCalcTotalAmount(\''+type+'\',this);" value="'+sExtraNote+'" TABINDEX="'+totIndex+'">' );
		}
		write('<td>');
		if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")
		{
			if (NoteIndex < lenNoteValArr)
			{
				var maskFlag = CurrNoteCounts[NoteIndex].charAt(0);
				if(maskFlag == "M")
				{
				CurrNoteCounts[NoteIndex] = CurrNoteCounts[NoteIndex].slice(1);
				write('&nbsp;&nbsp;<input class="label" id="'+type+'NoteAvailDenomCount'+NoteIndex+'" name="custom.NoteAvailDenomCount'+NoteIndex+'" size=15 align="left" READONLY value="***" TABINDEX=-1>');
				}			
				else	
				{
				write('&nbsp;&nbsp;<input class="label" id="'+type+'NoteAvailDenomCount'+NoteIndex+'" name="custom.NoteAvailDenomCount'+NoteIndex+'" size=15 align="left" READONLY value="'+CurrNoteCounts[NoteIndex]+'" TABINDEX=-1>');
				}	
			}
		}
		write('</td><td>&nbsp;</td>');
		// End of Note Denominations display
		// Coin Denominations display
		write('<td class="textlabel">');
		if (CoinIndex < lenCoinValArr)
		{
			if (CurrCoinValues[CoinIndex] != 0) {
					write('<input class="label" id="CoinDenomValue'+CoinIndex+'" name="custom.CoinDenomValue'+CoinIndex+'" size="5" READONLY value="'+CurrCoinValues[CoinIndex]+'" TABINDEX=-1>');
					write('&nbsp;&nbsp;-');
			}
		}
		write('</td><td>');
		if (CoinIndex < lenCoinValArr)
		{
			attr = "Coin";
			totIndex = totLoopIndex + parseInt(lenNoteValArr) + parseInt(CoinIndex) + 1;
			if(totIndex > maxIndex)	maxIndex = totIndex;
			sTmpVal = ((ValuesList[CoinIndex]==null)||(ValuesList[CoinIndex]==""))?"0":ValuesList[CoinIndex];
//changes for setvarFlag N - (Coins) 
			if (setVarFlg == "N") {
	       			sExtraCoin= CurrCoinValues[CoinIndex] * sTmpVal;
			}else{ 
				sExtraCoin = sTmpVal * 1.00;
			}
			sExtraCoin= parseFloat(sExtraCoin.toFixed(numOfDecPoints));
			write('<input class=textfieldamount17num fblk="'+type+'" id="'+type+'CoinDenomCount'+CoinIndex+'" name="denom.'+pageName+'CoinDenomCount'+CoinIndex+'" size="10" maxlength="16" type="hidden" value="'+sTmpVal+'" TABINDEX="'+totIndex+'"readonly >');
			if (CurrCoinValues[CoinIndex] != 0) {
				write('<input class=textfieldamount17num fblk="'+type+'" id="'+type+'CoinDenomCountExtra'+CoinIndex+'" name="'+pageName+'CoinDenomExtra'+CoinIndex+'" size="10" maxlength="16" onChange="return fnCalcTotalAmount(\''+type+'\',this);" value="'+sExtraCoin+'" TABINDEX="'+totIndex+'" >');
			}
		}
		write('<td>');
		if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")
		{
			if (CoinIndex < lenCoinValArr)
			{
				if (CurrCoinValues[CoinIndex] != 0) {
					var maskFlag = CurrCoinCounts[CoinIndex].charAt(0);
					if(maskFlag == "M")
					{
					CurrCoinCounts[CoinIndex] = CurrCoinCounts[CoinIndex].slice(1);	
					write('&nbsp;&nbsp;<input class="label" id="CoinAvailDenomCount'+CoinIndex+'" name="custom.CoinAvailDenomCount'+CoinIndex+'" READONLY value="***" TABINDEX=-1>');
					}
					else
					{	
					write('&nbsp;&nbsp;<input class="label" id="CoinAvailDenomCount'+CoinIndex+'" name="custom.CoinAvailDenomCount'+CoinIndex+'" READONLY value="'+CurrCoinCounts[CoinIndex]+'" TABINDEX=-1>');
					}	
				}
			}
		}
		write('</td>');
		// End of Coin Denominations display
		write('</tr>');
		// Loop end - increment the counters
		CoinIndex++, NoteIndex++;
	}
	write('</table><table>');
	// Total Denom Amt
	write('<tr><td class="textlabel">' + 'Total Amount' + '</td><td>');
	if(type=="")
		sTmpVal = (ValuesList[CoinCount+NoteCount+2]==null)?"0":ValuesList[CoinCount+NoteCount+2];
	else
		sTmpVal = (ValuesList[CoinCount+NoteCount]==null)?"0":ValuesList[CoinCount+NoteCount];
	write('<input class="textfieldamount" id="'+type+'TotalDenomAmt" name="denom.'+pageName+'TotalDenomAmt" size="15" maxlength="16"  READONLY value="'+sTmpVal+'" TABINDEX=-1>');
	write('</td><td></td><td></td></td></tr>');
	//End of Total Denom Amt + Round Off Amt details
	//End of data block
	write('</td></tr></table></td></tr></table></td></tr></table>');
	}
	var TotalDenomAmt1=document.getElementById(type+"TotalDenomAmt");
	
	//cust_newformatAmt('Million',TotalDenomAmt1,currency,'N');
}

function printRoundOffBlock(pageName)
{
	var ValuesList = fieldValues.split("!");
	/*----------------------------------------------------------------
		Author	:	Sandeep Patil
		Change	:	Round Off made hidden for Namibia
	-----------------------------------------------------------------*/
	with (document) 
	{
	write('<table><tr><td class="textlabel">'+'Round off Amt' + '&nbsp;</td><td>');
	sTmpVal = (ValuesList[CoinCount+NoteCount+1]==null)?"0":ValuesList[CoinCount+NoteCount+1];
	write('<input class="textfieldamount" id="RoundOffVal" name="denom.'+pageName+'RoundOffVal" size="15" maxlength="10"  onBlur="fnSetRoundOffTot(this)" value="'+sTmpVal+'" TABINDEX='+(maxIndex+1)+'>');
	maxIndex++;
	write('</td><td>Credit' + '&nbsp;');
	write('<INPUT TYPE="radio" NAME="custom.ptran" id="ptranC" onClick="fnSetRoundOffPType(0)">');
	write('Debit' + '&nbsp;');
	write('<INPUT TYPE="radio" NAME="custom.ptran" id="ptranD" onClick="fnSetRoundOffPType(1)">');
	write('<INPUT type="hidden" name="denom.'+pageName+'RoundOffTyp" id="RoundOffTyp">');
	write('</td><td>');
	write('<INPUT type="hidden" name="custom.'+pageName+'RoundOffTot" id="RoundOffTot" value="0">');
	write('</td></tr></table>');
	}
	//Setting the Round off type check box and hidden fields
	var frm = document.forms[0],crDb;
	if(ValuesList[CoinCount+NoteCount+1]!=null)
	{
		if(ValuesList[CoinCount+NoteCount]=="C")
			crDb = (Func != "R")?"C":"D";
		else
			crDb = (Func != "R")?"D":"C";
	}
	else
		frm.RoundOffTyp.value="D";
	if(crDb == "C")
	{
		frm.ptranC.checked = true;
		frm.RoundOffTyp.value="C";
		frm.RoundOffTot.value=(frm.RoundOffVal.value);
	}
	else
	{
		frm.ptranD.checked = true;
		frm.RoundOffTyp.value="D";
		frm.RoundOffTot.value=-(frm.RoundOffVal.value);
	}
	var RoundOffVal1=document.getElementById("RoundOffVal");
	//cust_newformatAmt('Million',RoundOffVal1,currency,'N');
}

function printButtonBlock()
{
	with (document) {
	write('<BR><div align="left" class="ctable">');
	if(Func=="I" || Func=="D" || Func=="P" || Func=="V")
		write('<input type="Button" class="button" id="GoInq" name="GoInq" value="OK" onClick="window.close();">'); 
	else
	{
		write('<input type="Submit" class="button" id="Submit" name="Submit" value="Submit" onClick="javascript:return fnSubmit(this);">');
		write('<input type="Button" class="button" id="Clear" name="Clear" value="Cancel" onClick="window.close();">');
		write('<INPUT type="button" class="button" value="PRINT" name="Print" onclick ="javascript:window.print();">');
		if((TranType!="CCT" && isPbGb=="Y") || (Func=="M" && TranType!="CCT"))	{
		write('<INPUT type="button" class="button" value="PayBack" name="Getback" id="Getback" onclick ="fnPayBack();">');
		write('<INPUT type="button" class="button" value="GetBack" name="PayBack" id="PayBack" onclick ="fnGetBack();">');
		}
		if((TranType!="CCT" && isPbGb=="N") || (Func=="M" && TranType!="CCT"))  {
		write('<INPUT type="button" class="button" value="PayBack" name="Getback" id="Getback" onclick ="fnPayBack();">');
		}

	}
	write('</div>');
	}
}

function fnChkRndAmt()
{
	var frm = document.forms[0];
	var roundoffvalue = frm.RoundOffVal.value;
	(frm.ptranC.checked == true)?fnSetRoundOffPType('0'):fnSetRoundOffPType('1');
	if(!isNaN(roundoffvalue))	{
		var inputNameValues = "frm.RoundOffVal.value";
		var outputNameValues = "roundVal";
		var scriptName = "denomRoundOff.scr";
		var retVal = cust_fnExecuteScript(inputNameValues,outputNameValues,scriptName,false);
		var value = retVal.split("|");
		if(value[0] != "F")
		{
		var roundChk = value[1];	
		if(parseFloat(roundoffvalue) > roundChk )
		{
			var round = "Round off amount cannot be more  "
			var round = round + roundChk
			var round = round + " units"  	
			//alert("Round off amount cannot be more that" + roundChk + " units");
			alert(round);	
			frm.RoundOffVal.focus();
			return false;
		}
		}
		else
                {
                        alert("cparam setup not available for roundoff");
                        return false;
                }
	
	}
	else	{
		alert("Enter a valid amount");
		frm.RoundOffVal.focus();
		frm.RoundOffVal.select();
		return false;
	}
	return true;
}

function IsNumeric(sText)
{
	var ValidChars = "0123456789", IsNumber=true, Char;
	for (i = 0;i < sText.length && IsNumber == true;i++)
	{
		Char = sText.charAt(i); 
		if(ValidChars.indexOf(Char) == -1)
		IsNumber = false;
	}
	return IsNumber;
}

function cust_newformatAmt(format, obj, crncy, prn)
{
	var prec = numOfDecPoints;
	if(fnIsNull(crncy))
	{
		var amt = (prn=='Y')?obj : obj.value;
		var decLen = 0,iIndex = 0;
		var sourceAmt = removeCommas(amt);
		if(!isNaN(sourceAmt))	{
			iIndex = sourceAmt.indexOf(".");
			if(iIndex != -1)
				decLen = sourceAmt.substring(iIndex+1).length;
		}
		if(decLen > prec) prec = decLen;
	}
	formatAmountToMillionOrLakh(format, obj, prec, prn)
}

function fnDisableCtrls()
{
	disableButtons();
	hideImage("sPrev");
	hideImage("sNext");
}

function fnEnableCtrls()
{
	enableButtons();
	showImage("sNext");
	showImage("sPrev");
	if(arrayPtr==0) hideImage("sPrev");
	if(arrayPtr==(recCount-1)) hideImage("sNext");
}

function loadTI(arrayTI)
{
	var frm = document.forms[0], obj;
	var tabIndex = null;
	for (var i=0; i < frm.elements.length; i++) 
	{
		obj = frm.elements[i];
		tabIndex = obj.getAttribute("tabindex");
		if (tabIndex > -1 && obj.type == "text")
			arrayTI[tabIndex] = obj;
	}
}

var ctrlKeyDown = false;
function fnKeyUp(event)
{
	if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")	{
		if(event.keyCode == "38" || event.keyCode == "40") event.srcElement.select();
		if(event.keyCode == "17") ctrlKeyDown = false;
	}
	return true;
}

function fnKeyDown(event)
{
	var frm = document.forms[0];
	if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")
	{
		if(event.keyCode == "17") {
			ctrlKeyDown = true;
			return true;
		}
		if(ctrlKeyDown) {
			if(event.keyCode == '67')		{ copyScreen(); event.keyCode = 0; event.returnValue = false; }
			else if(event.keyCode == '80')	{ pasteScreen(); event.keyCode = 0; event.returnValue = false; }
			else if(event.keyCode == '82')	{ retainOldVals(); event.keyCode = 0; event.returnValue = false; }
		}
		if(event.keyCode == "115"||event.keyCode == "119"||event.keyCode == "121")
		{	if(!fnCalcTotalAmount(''))
							return false;
			if(payBack == "Y") {
				if(!fnCalcTotalAmount('PB'))
				{
					return false;
				}
			}
			if(getBack == "Y"){
				if(!fnCalcTotalAmount('GB'))
				{
					return false;
				}
			}		
			if(event.keyCode == "115") {
				for(var i=0; i<recCount; i++)
				{
					if(arrVstdFlg[i]=="N")
					{
						fnPressNext();
						return false;
					}
				}
			}
			frm.Submit.click();
		}
		else if(event.keyCode == "114"||event.keyCode == "27")
			frm.Clear.click();
		else if(event.keyCode == "38"||event.keyCode == "40")
		{
			var targetInd = (event.keyCode=="38")?event.srcElement.tabIndex - 1:event.srcElement.tabIndex + 1;
			if(arrayTI[targetInd] != undefined && arrayTI[targetInd].type == "text")
			{
				if(!isNaN(event.srcElement.value)||event.srcElement.value==undefined)
				{
					arrayTI[targetInd].focus();
					arrayTI[targetInd].select();
				}
				else
				{
					alert("Please enter valid number") ;
					event.srcElement.value = "0";
					fnCalcTotalAmount(dataBlk,obj);
					event.srcElement.focus();
					event.srcElement.select();
					return false;
				}
			}
			return true;
		}
		if(event.srcElement != undefined && event.srcElement.id == "RoundOffVal")
		{
			if(event.keyCode == "67") // User has pressed "c" or "C"
			{
				frm.ptranC.click();
				event.srcElement.select();
				event.cancelBubble = true; 
				event.returnValue = false;
			}
			else if(event.keyCode == "68") // User has pressed "d" or "D"
			{
				frm.ptranD.click();
				event.srcElement.select();
				event.cancelBubble = true;
				event.returnValue = false;
			}
		}
		return true;
	}
	else
	{
		if(event.keyCode == "115"||event.keyCode == "114"||event.keyCode == "27")
			frm.GoInq.click();
	}
	return true;
}

function fnAlphaCheck(obj)
{
	var validChars = /[0-9.]/;
	if(validChars.test(obj.value))
	return true;
	alert(finbranchResource.FAT000485);
	Obj.value = "";
	Obj.focus();
	fnEnableCtrls();
	return false;
}

function fnFieldsReadOnly()
{
	var frm=document.forms[0];
	var len=frm.length;
	for(i=0;i<len;i++)
		if(frm[i].type == "text") frm[i].readOnly = true;
	frm.ptranC.disabled=true;
	frm.GoInq.focus();
	frm.ptranD.disabled=true;
}

function fnSetRoundOffPType(Ptypeobj)
{
	var frm = document.forms[0];
	frm.RoundOffVal.READONLY=false;
	if(Ptypeobj=="0")
	{
		frm.RoundOffTyp.value = "C";
		frm.RoundOffTot.value = (PartTranType=="D")?frm.RoundOffVal.value:-(frm.RoundOffVal.value);
	}
	else
	{
		frm.RoundOffTyp.value = "D";
		frm.RoundOffTot.value = (PartTranType=="D")?-(frm.RoundOffVal.value):frm.RoundOffVal.value;
	}
}

function isValidAmount(amt)
{
    if((amt.length >17)||(isNaN(amt)))
        return false;
    index =amt.indexOf(".");
    if(index > 14)
        return false;
    if((index== -1)&&(amt.length > 14))
        return false;
    return true;
}


function fnCalcTotalAmount(dataBlk,obj)
{
	if(obj!=undefined)
	{
		if(obj.value.trim() == "") obj.value="0";
		if(!isValidAmount(obj.value))
		{
				alert("Please enter Valid number") ;
				obj.value = "0";
				obj.focus();
				fnEnableCtrls();
				fnCalcTotalAmount(dataBlk,obj);
				obj.cancelBubble = true;
				obj.returnValue = false;
				return false;
		}
	}
	var objTotal = document.getElementById(dataBlk + "TotalDenomAmt");
	var TotAmt = 0, attr = "Note", CoinCnt = 0;
	for(var i=0; i<2; i++ )
	{
		var Cnt = 0;
		var HiddenDenomCount = 0;
		while(Cnt<NoteCount || Cnt<CoinCount)
		{
			var objValue = document.getElementById(attr + "DenomValue" + Cnt);
			var objCount = document.getElementById(dataBlk + attr + "DenomCountExtra" + Cnt);
			var objHidden = document.getElementById(dataBlk + attr + "DenomCount" + Cnt);
			if(objValue!=undefined)
			{
				if(objCount.value.trim()=="") objCount.value="0";
				if(!isValidAmount(objCount.value))
				{
					alert("Please enter Valid number") ;
					objCount.focus();
					fnEnableCtrls();
					objCount.value = "0";
					fnCalcTotalAmount(dataBlk,obj);
					return false;
				}
				if(Func!="I" && Func!="P" && Func!="V")
					fnAlphaCheck(objCount);

           		var objValue1=removeCommas(objValue.value);

				if(setVarFlg=="Y"){
					// The case where I would enter 1 use the DenomCount field so objHidden
                	var objCount1=removeCommas(objCount.value);
				} else {
					// The case where I would enter 1000 use the new DenomCountExtra field so objCount
           			var objCount1=removeCommas(objCount.value);
				}

				if(setVarFlg=="Y"){
					if(Func!="I" && Func!="P" && Func!="V")
					{
						if(!objCount1==0)
						{	
							iIndex = objValue1.indexOf(".");
							// The case of coin denomination
							if(iIndex != -1)
							{
						//		var objCount2  = objCount1 * 1000;
								var objCount2  = objCount1 ;
								HiddenDenomCount = (parseFloat(objCount2));
								objHidden.value = HiddenDenomCount;
								if(!IsNumeric(objHidden.value))
								{
									alert("Please enter in the multiples of the denom");
									objCount.focus();
									fnEnableCtrls();
									objCount.value = "0";
									fnCalcTotalAmount(dataBlk,obj);
									return false;
								}
							}
							else
							// The case of note denomination
							{
								HiddenDenomCount = (parseFloat(objCount1));
								objHidden.value = HiddenDenomCount;
								if(!IsNumeric(objHidden.value))
								{
									alert("Please enter in the multiples of the denom");
									objCount.focus();
									fnEnableCtrls();
									objCount.value = "0";
									fnCalcTotalAmount(dataBlk,obj);
									return false;
								}
							}
						}
					}
					TotAmt += parseFloat(objValue1) * parseFloat(objCount1);
				}
				//setvar flg - N
				else
				{
					if(Func!="I" && Func!="P" && Func!="V")
					{
						if(!objCount1==0)
						{	
							iIndex = objValue1.indexOf(".");
							// The case of coin denomination
							if(iIndex != -1)
							{
							//	var objValue2  = objValue1 * 1000;
						        //	var objCount2  = objCount1 * 1000;
								var objValue2  = objValue1;
								var objCount2  = objCount1;
								HiddenDenomCount = (parseFloat(objCount2) / parseFloat(objValue2));
								objHidden.value = HiddenDenomCount;
								if(!IsNumeric(objHidden.value))
								{
									alert("Please enter in the multiples of the denom");
									objCount.focus();
									fnEnableCtrls();
									objCount.value = "0";
									fnCalcTotalAmount(dataBlk,obj);
									return false;
								}
							}
							else
							// The case of note denomination
							{
								HiddenDenomCount = (parseFloat(objCount1) / parseFloat(objValue1));
								objHidden.value = HiddenDenomCount;
								if(!IsNumeric(objHidden.value))
								{
									alert("Please enter in the multiples of the denom");
									objCount.focus();
									fnEnableCtrls();
									objCount.value = "0";
									fnCalcTotalAmount(dataBlk,obj);
									return false;
								}
							}
						}
					}
					TotAmt += parseFloat(objCount1);
				}
				TotAmt = parseFloat(TotAmt.toFixed(numOfDecPoints));
			}
			Cnt++;
		}
		attr = "Coin";
		CoinCnt = Cnt;
	}
	//Take mantissa part out of the number
	var sNum;
	var Num = '' + TotAmt;
	//if (Num.indexOf(DEF_DECIMAL_SEPARATOR) != -1)
	//	sNum = Num.substring(0,Num.indexOf(DEF_DECIMAL_SEPARATOR));
	//else
	//	sNum = Num;
	//Following loop will check for max digits of the sum
	//if ((''+sNum).length > 14)
	//{
//		alert("Maximum 14 digits allowed");
//		obj.value = "0";
//		obj.focus();
//		obj.select();
//		fnCalcTotalAmount('');
//		if(payBack == "Y")
//			fnCalcTotalAmount('PB');
//		if(getBack == "Y")
//			fnCalcTotalAmount('GB');
//		var targetInd = obj.tabIndex - 1;
//		return false;
//	}
	objTotal.value = TotAmt;
	var TotalDenomAmt=document.getElementById(dataBlk+"TotalDenomAmt");
	cust_newformatAmt('Million',TotalDenomAmt,currency,'N');
	if(TranType == "CCT") fnCalcCCTchk();
	return true;
}

function fnSetRoundOffTot()
{
	var frm = document.forms[0];
	fnChkRndAmt();
	if(frm.RoundOffVal.value == "") frm.RoundOffVal.value = "0"
}

function fnCheckDenomCnt()
{
	if(PartTranType=="D" || payBack == "Y")
	{
		var objNoteCount,objCoinCount,objHidden;
		var Cnt = 0,TotAmt = 0,tmpNoteCnt = 0;
		var ValuesList  = fieldValues.split("!");
		var ValuesListPB= fieldValuesPB.split("!");
		var ValuesListGB= fieldValuesGB.split("!");
		while(Cnt<NoteCount || Cnt<CoinCount)
		{
			if (Cnt<NoteCount)
			{
				objNoteCount	= document.getElementById("NoteDenomCount" + Cnt);
				tmpNoteCnt		= parseInt(objNoteCount.value);
				tmpNoteCntPB	= 0;
				tmpNoteCntGB	= 0;
				if(PartTranType=="D")
				{
					if((Func=="A"||Func=="C"||Func=="T"||Func=="M" ||Func=="R")||(parseInt(objNoteCount.value) > parseInt(ValuesList[CoinCount+Cnt])))
					{
						if((parseInt(CurrNoteCounts[Cnt]))<(parseInt(objNoteCount.value)))
						{
							alert("You dont have sufficient denominations");
							fnEnableCtrls();
							return false;
						}
					}
				}
				else
					tmpNoteCnt = -tmpNoteCnt;
				if(payBack == "Y")
				{
					objNoteCountPB	= document.getElementById("PBNoteDenomCount" + Cnt);
					tmpNoteCntPB	= parseInt(objNoteCountPB.value);
				}
				if(getBack == "Y")
				{
					objNoteCountGB	= document.getElementById("GBNoteDenomCount" + Cnt);
					tmpNoteCntGB	= parseInt(objNoteCountGB.value);
				}
				if((Func=="A"||Func=="C"||Func=="T"||Func=="M")||(tmpNoteCntPB > parseInt(ValuesListPB[CoinCount+Cnt]) || tmpNoteCntGB > parseInt(ValuesListGB[CoinCount+Cnt])))
				{
					if((parseInt(CurrNoteCounts[Cnt])+tmpNoteCntGB)<(tmpNoteCntPB+tmpNoteCnt))
					{
						alert("You dont have sufficient denominations");
						fnEnableCtrls();
						return false;
					}
				}
			}
			if (Cnt<CoinCount)
			{
				objCoinCount	= document.getElementById("CoinDenomCount" + Cnt);
				tmpCoinCnt		= parseInt(objCoinCount.value),tmpCoinCntPB = 0,tmpCoinCntGB = 0;
				if(PartTranType == "D") {
					if((Func=="A"||Func=="C"||Func=="T"||Func=="M")||(parseInt(objNoteCount.value) > parseInt(ValuesList[Cnt])))
					{
						if((parseInt(CurrCoinCounts[Cnt]))<(parseInt(objCoinCount.value)))
						{
							alert("you dont have sufficient denominations");
							fnEnableCtrls();
							return false;
						}
					}
				}
				else
					tmpCoinCnt = -tmpCoinCnt;
				if(payBack == "Y")
				{
					objCoinCountPB	= document.getElementById("PBCoinDenomCount" + Cnt);
					tmpCoinCntPB	= parseInt(objCoinCountPB.value);
				}
				if(getBack == "Y")
				{
					objCoinCountGB	= document.getElementById("GBCoinDenomCount" + Cnt);
					tmpCoinCntGB	= parseInt(objCoinCountGB.value);
				}
				if((Func=="A"||Func=="C"||Func=="T"||Func=="M")||(tmpCoinCntPB > parseInt(ValuesListPB[Cnt]) || tmpCoinCntGB > parseInt(ValuesListGB[Cnt])))
				{
					if((parseInt(CurrCoinCounts[Cnt])+tmpCoinCntGB)<(tmpCoinCntPB+tmpCoinCnt))
					{
						alert("You dont have sufficient denominations");
						fnEnableCtrls();
						return false;
					}
				}
			}
			Cnt++;
		}
		return true;
	}
	return true;
}

function removeCommas(sNum)
{
	sNew ="";
	var sTemp = sNum.split(",");
	for (i=0;i<sTemp.length;i++)
		if(sTemp[i]!=null) sNew = sNew + sTemp[i];
	return sNew;
}

function fnValTotAmt()
{
	var frm = document.forms[0], payBackAmt=0, getBackAmt=0;
	acctCrncyAmt1 = acctCrncyAmt + '';
	if(payBack == "Y"||payBackLen > 0)
	{
		payBackAmt = frm.PBTotalDenomAmt.value;
		payBackAmt = payBackAmt + '';
		payBackAmt = removeCommas(payBackAmt);
		payBackAmt = parseFloat(payBackAmt);
		payBackAmt = -payBackAmt;
	}
	if(getBack == "Y"||getBackLen > 0)
	{
		getBackAmt = frm.GBTotalDenomAmt.value;
		getBackAmt = getBackAmt + '';
		getBackAmt = removeCommas(getBackAmt);
		getBackAmt = parseFloat(getBackAmt);
	}
	acctCrncyAmt1 = removeCommas(acctCrncyAmt1);
	var roundOff = frm.RoundOffTot.value;
	roundOff = removeCommas(roundOff);
	acctCrncyAmt1 = parseFloat(acctCrncyAmt1)-parseFloat(roundOff);
	var TotAmt = removeCommas(frm.TotalDenomAmt.value);
	TotAmt = parseFloat(TotAmt);
	partTranAmt = parseFloat(partTranAmt)-parseFloat(roundOff);
	if(PartTranType=="D")
	{
		TotAmt = -TotAmt;
		acctCrncyAmt1 = -acctCrncyAmt1;
		if(partTranAmt > 0) partTranAmt = -partTranAmt;
	}
	TotAmt = TotAmt + payBackAmt + getBackAmt;
	TotAmt = TotAmt.toFixed(numOfDecPoints);
	acctCrncyAmt1 = acctCrncyAmt1.toFixed(numOfDecPoints);
	partTranAmt = partTranAmt.toFixed(numOfDecPoints);
	if(parseFloat(acctCrncyAmt1)==parseFloat(TotAmt))
	{
		if(Func =="R")
		{
			partTranAmt = acctCrncyAmt1;
		}
		if(!(parseFloat(acctCrncyAmt1)==parseFloat(TotAmt)&&(parseFloat(TotAmt)==parseFloat(partTranAmt))&&(parseFloat(acctCrncyAmt1)==parseFloat(partTranAmt))))
		{
			alert("Please invoke the denomination screen again");
			window.close();
			return false;
		}
		return true;
	}
	else
	{
		alert("Entered amount & transaction amount not matching");
		fnEnableCtrls();
		return false;
	}

}

function fnCalcCCTchk(action)
{
	if(TranType=="CCT")	{
		switch(action)	{
		/*  if page visited for first time then increment the DenomCnt counters with the
			page field values else decrement the DenomCnt counters with the page field values
		*/
		case 'ONLOAD':
			if(arrVstdFlg[arrayPtr] == "Y")
				fnSetCCTCounters('dec');
			break;
		//Increment the DenomCnt counters with the page field values
		case 'NEXT':
		case 'PREV':
		case 'SUBMIT':
			fnSetCCTCounters('inc');
			break;
		case 'REVERSE':
			fnSetCCTCounters('dec');
			break;
		default:
			break;
		}
	}
}

function fnSetCCTCounters(oper)
{
	var frm			= document.forms[0], TotAmt = 0, CoinCnt = 0, attr = "Coin";
	sAllDenomCntsCr = allDenomCntsCr.join("!");
	sAllDenomCntsDr = allDenomCntsDr.join("!");
	var objTotal	= document.getElementById("TotalDenomAmt");
	for( var i=0; i<2; i++ )
	{
		var Cnt = 0;
		while(Cnt<NoteCount || Cnt<CoinCount)
		{
			var objValue = document.getElementById(attr + "DenomValue" + Cnt);
			var objCount = document.getElementById(attr + "DenomCount" + Cnt);
			if(objValue!=undefined)
			{
				if(oper == "inc")
				{
					if(PartTranType=="D")
						allDenomCntsDr[Cnt+CoinCnt] = parseInt(allDenomCntsDr[Cnt+CoinCnt]) + parseInt(objCount.value);
					else
						allDenomCntsCr[Cnt+CoinCnt] = parseInt(allDenomCntsCr[Cnt+CoinCnt]) + parseInt(objCount.value);
				}
				else
				{
					if(PartTranType=="D")
						allDenomCntsDr[Cnt+CoinCnt] = parseInt(allDenomCntsDr[Cnt+CoinCnt]) - parseInt(objCount.value);
					else
						allDenomCntsCr[Cnt+CoinCnt] = parseInt(allDenomCntsCr[Cnt+CoinCnt]) - parseInt(objCount.value);
				}
			}
			Cnt++;
		}
		attr = "Note";
		CoinCnt = Cnt-1;
	}
	sAllDenomCntsCr = allDenomCntsCr.join("!");
	sAllDenomCntsDr = allDenomCntsDr.join("!");
	frm.allDenomCntsCr.value = sAllDenomCntsCr;
	frm.allDenomCntsDr.value = sAllDenomCntsDr;
}

function fnPressPrev()
{
	var frm = document.forms[0];
	var jspName = (Func == "M")?"denomdp007.jsp":"denomdp006.jsp";
	if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")
	{
		fnDisableCtrls();
		if(fnCheckDenomCnt())
		{
			if(fnValTotAmt())
			{
				arrayPtr--;
				fnCalcCCTchk('PREV');
				frm.target="DenomPopup";
				frm.action="/finbranch/custom/jsp/"+jspName+"?sDummy=N&Func="+Func+"&ScrName=denomdp006.scr&pTranType=C&arrayPtr="+arrayPtr+"&vstdFlg="+vstdFlg+"&allDenomCntsCr="+sAllDenomCntsCr+"&allDenomCntsDr="+sAllDenomCntsDr+"&bufValues="+bufValues+"&refFlg="+refFlg;
				frm.submit();
			}
		}
	}
	else
	{
		arrayPtr--;
		frm.target="DenomPopup";
		frm.action="/finbranch/custom/jsp/"+jspName+"?sDummy=N&Func="+Func+"&ScrName=denomdp006.scr&pTranType=C&arrayPtr="+arrayPtr+"&vstdFlg="+vstdFlg+"&refFlg="+refFlg;
		frm.submit();
	}
}

function fnPressNext()
{
	var frm = document.forms[0];
	var jspName = (Func=="M")?"denomdp007.jsp":"denomdp006.jsp";
	if(Func=="A"||Func=="M"||Func=="M1"||Func=="R"||Func=="T"||Func=="C")
	{
		fnDisableCtrls();
		if(fnCheckDenomCnt())
		{
			if(fnValTotAmt())
			{
				arrayPtr++;
				fnCalcCCTchk('NEXT');
				frm.target = "DenomPopup";
				frm.action = "/finbranch/custom/jsp/"+jspName+"?sDummy=N&Func="+Func+"&ScrName=denomdp006.scr&pTranType=C&arrayPtr="+arrayPtr+"&vstdFlg="+vstdFlg+"&allDenomCntsCr="+sAllDenomCntsCr+"&allDenomCntsDr="+sAllDenomCntsDr+"&bufValues="+bufValues+"&refFlg="+refFlg;
				frm.submit();
			}
		}
	}
	else
	{
		arrayPtr++;
		frm.target = "DenomPopup";
		frm.action = "/finbranch/custom/jsp/"+jspName+"?sDummy=N&Func="+Func+"&ScrName=denomdp006.scr&pTranType=C&arrayPtr="+arrayPtr+"&vstdFlg="+vstdFlg+"&refFlg="+refFlg;
		frm.submit();
	}
}

function fnSubmit()
{
		fnDisableCtrls();
	var frm = document.forms[0],objCoinCount,TotAmt;
	if(fnCheckDenomCnt())
	{
		if(fnValTotAmt())
		{
			TotAmt = frm.TotalDenomAmt.value;
			TotAmt = removeCommas(TotAmt);
			if(parseFloat(acctCrncyAmt)==parseFloat(TotAmt))
				frm.SuccessOrFailure.value = "S";
			if(Dummy!="Y")
			{
				TotAmt = frm.TotalDenomAmt.value;
				TotAmt = removeCommas(TotAmt);
				for(var i=0; i<recCount; i++)
				{
					if(arrVstdFlg[i]=="N")
					{
						alert("All denomination screens have to be visited");
						fnEnableCtrls();
						return false;
					}
				}
				if(TranType=="CCT")
				{
					fnCalcCCTchk('SUBMIT');
					if(frm.allDenomCntsCr.value != frm.allDenomCntsDr.value)
					{
						alert("Mismatch in Credit/Debit denominations");
						fnCalcCCTchk('REVERSE');
						fnEnableCtrls();
						return false;
					}
				}
				frm.target = "DenomPopup";
				frm.action = frm.pagename.value+"?sDummy=Y&Func="+Func+"&pTranType=C";
				frm.submit();
			}
			return true;
		}
	}
	
	fnEnableCtrls();
	return false;
}

function copyScreen()
{
	var i;
	bufValues = currency + "^";
	for(i=0; i<CoinCount; i++)
		bufValues = bufValues + document.getElementById("CoinDenomCount" + i).value + "!";
	for(i=0; i<NoteCount; i++)
		bufValues = bufValues + document.getElementById("NoteDenomCount" + i).value + "!";
	bufValues = bufValues + document.getElementById("RoundOffTyp").value + "!";
	bufValues = bufValues + document.getElementById("RoundOffTot").value + "!";
	bufValues = bufValues + document.getElementById("TotalDenomAmt").value + "!";
	bufValues = bufValues.substring(0,bufValues.length-1);
}

function setVals(inpFieldVals)
{
	var i, Cnt=0, vals = inpFieldVals.split("!");
	for(i=0; i<CoinCount; i++,Cnt++)
		document.getElementById("CoinDenomCount" + i).value = vals[Cnt];
	for(i=0; i<NoteCount; i++,Cnt++)
		document.getElementById("NoteDenomCount" + i).value = vals[Cnt];
	document.getElementById("RoundOffTyp").value = vals[Cnt]; Cnt++;
	document.getElementById("RoundOffTot").value  = vals[Cnt]; Cnt++;
	fnCalcTotalAmount('');
}

function pasteScreen()
{
	var bufFieldVals = bufValues.split("^");
	if(bufFieldVals[0] != currency)	{
		alert("Pattern mismatch");
		return;
	}
	copyScreen();
	setVals(bufFieldVals[1]);
}

function retainOldVals()
{
	if(bufValues != "")
		pasteScreen();
	else if(fieldValues != "")
		setVals(fieldValues);
}



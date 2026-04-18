var rowspNo = 0;
var iCount = 0;
var ObjForm = document.forms[0];
var inputs = new Array(
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("text","left",""),
			new Array("checkbox","left","")
		);
var numOfRows =10 ;
function addCustomHeader(){

	document.write('<tr class="subhdrbg" >');
	document.write('<td colspan="2">&nbsp;&nbsp;&nbsp;');
	if(funcCode == 'I'){
		document.write('<input value ="Add New" disabled type="button" name="addNew" id="addNew"  class="button1" onClick="JavaScript:fnGetNewRecord(\'Add\')">');
		}
	else{
		document.write('<input value ="Add New" type="button" name="addNew" id="addNew"  class="button1" onClick="JavaScript:fnGetNewRecord(\'Add\')">');
		}
	document.write('</td>');
	document.write('<td align="right" colspan="'+inputs.length+'">');
	document.write('<table border="0" cellpadding="0" cellspacing="0">' +
				  '<tr height="18">' +
				  '<td width="99%">&nbsp;</td><td align="right">' +
				  '<img src="../Renderer/images/arrowpre.gif" id="prevPage" hotKeyId="PrevPage" alt="Go to the previous set of records" height="14" width="7" vspace="1" align="middle" style="cursor:hand" name="prevPage" onClick="JavaScript:fnGetNewRecordPrev(\'prevPage\')"/>&nbsp;&nbsp;</td>' +
				 '<td style="white-space:nowrap"><span class="pagination">' +"Records"+ '&nbsp;</span>' +
				 '<input id="lowLimit" hotKeyId="LowLimit" type="text" name="lowLimit"  value="'+lowerLmt+'" class="pgnumdisplay" maxlength="3" style="vertical-align:middle" onChange="JavaScript:fnGetModifiedRecord(this)"/><span class="pagination">&nbsp;&nbsp;to&nbsp;&nbsp;'+highestLimit+'&nbsp;&nbsp;of&nbsp;&nbsp;' + totalRec + '&nbsp;&nbsp;</span></td>' +
				 '<td>' +
				 '<img src="../Renderer/images/arrownext.gif" id="nextPage" hotKeyId="NextPage" alt=" Go to the next set of records" height="14" width="7" vspace="1" align="middle" style="cursor:hand" name="nextPage" onClick="JavaScript:fnGetNewRecordNext(\'nextPage\')"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>' +
				 '</tr>' +
		  	  '</table>' );
	 document.write('</td>');
	 document.write('</tr>');
}

function addCustomDetRow1(arrObj)
{

  

	var recNum = arrObj[0]; //Record Number.
	var isCurrRec = arrObj[1]; //Is the record is current one.
		
	var locStyle = "";
	var suffix = "[" + recNum + "]";
	var status = "";


	if( isCurrRec == 'Y')
		locStyle = 'class="searclist1arow"';
	else
	{
		if(recNum % 2 == 0)
		{
			locStyle = 'class="searclist1a"';
		}
		else
		{
			locStyle = 'class="searclist2a"';
		}
	}

	document.write('<tr id="trrecNum_'+recNum+'" ' + locStyle + ' >');
	
	var numOfCol = inputs.length;
	
		
	//Customization hook to format values of a multirec
	arrObj = formatRowValue(arrObj, numOfCol);
	
	

	for(iInputs = 0;iInputs < inputs.length;iInputs++)
	{
		
		document.write('<td name="rowNum_'+recNum+'" onmouseover="this.style.cursor = \'hand\'" align="' + inputs[iInputs][1] + '" onClick="JavaScript:fnGetSelectedRow(this)">');	
				
		if(inputs[iInputs][0] == "checkbox")
		{
			if(arrObj[iInputs+2] == 'Y')
				status = " checked ";
			document.write('<input type="checkbox" name="chkBox' + suffix + '" disabled ' + status + '> </td>' );
		}
		else if(inputs[iInputs][0] == "radio")
		{
			if(arrObj[iInputs+2] == 'Y')
				status = " checked ";
			document.write('<input type="radio" name="rad' + suffix + '" disabled ' + status + '> </td>' );
		}
		
		else
			{
				document.write(arrObj[iInputs+2] + '&nbsp; </td>');
			}
		
		status = "";
	}
	
	if(iCount == 0)
	{
		document.write('<td class="leftscroll" width="1%" align="center"><a href="JavaScript:fnPrevRecord(\'prev\')"><img id="prev" alt= "View the previous record." class="img" src="../Renderer/images/uparrow.gif" border="0" width="18" height="20" hotKeyId="Up"></img></a></td>');
	}
	else if(iCount == numOfRows - 1)
	{
		document.write('<td class="leftscroll" width="1%" align="center"><a href="JavaScript:fnNextRecord(\'next\')"><img id="next" alt= "View the next record or add a new record" class="img" src="../Renderer/images/downarrow.gif" border="0" width="18" height="20" hotKeyId="Down"></img></a></td>');
	}
	else
	{
		if(rowspNo != -1)
		{
			document.write('<td align="center" width="1%" class="leftscroll" rowspan="'+rowspNo+'">&nbsp;</td>');
			rowspNo = -1;
		}
	}

	document.write('</tr>');
	
	iCount = iCount + 1;
	
}

function fnGetSelectedRow(obj)
{
	var rowName = obj.name;
	var rowNum = rowName.substring(7);
	var rowNum1 = 0;
	var nbspSpace = "&nbsp; ";
	var nbsp = "&nbsp;";

	if(lowerLmt>0){

		if(rowNum == lowerLmt-1){
			rowNum1 = rowNum;
		}else{
			rowNum1 = rowNum - 1;
		}
	}

	var container = document.getElementById('trrecNum_'+rowNum1);
	var tdItems = container.getElementsByTagName('td');

	for (var j = 0; j < tdItems.length-1; j++) { 
		if (tdItems[j].childNodes[0].type == 'checkbox') { 
			if(tdItems[j].childNodes[0].checked == true){
				flag = 0;
				break
			}
		}else{
			if(nbspSpace != tdItems[j].innerHTML && nbsp != tdItems[j].innerHTML ){
				flag = 0;
				break
			}
		}
	}
	if(flag == 1){
		alert("Select a Record");
		return;
	}
	document.forms[0].selectedRow.value=rowNum;
	if(fnValidateData()){

		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& !(currentPosition  == totalRec))
		{
			alert("Enter the value in the field.");
			return;
		}
		doSubmit("SelRec::MultirecAct");
	}
}

function fnGetNewRecord(dirType)
{
	if(fnValidateData())
	{
		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& !(currentPosition  == totalRec))
		{
			alert("Enter the value in the field.");
			return;
		}
		doSubmit(dirType);
	}
}

function fnGetModifiedRecord(obj)
{
	var rowNum = obj.value;
	document.forms[0].selectedRow.value=rowNum;
	if(fnValidateData())
	{
		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& !(currentPosition  == totalRec))
		{
			alert("Enter the value in the field.");
			return;
		}
		doSubmit("ModRec::MultirecAct");
	}
}

function fnPrevRecord(dirType)
{
	var ObjForm = document.forms[0];
	var iFlag = 0;
	var iFlag1 = 0;
	if(fnValidateData())
	{
		iFlag1 = 1;
		if(currentPosition==0)
		{
			alert("There are no more records");
			iFlag = 1;
		}
	}
	if(iFlag!=1 && iFlag1==1)
	{
		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& !(currentPosition  == totalRec))
		{
			alert("Enter the value in the field.");
			return;
		}
		doSubmit(dirType);
	}
}

function fnNextRecord(dirType)
{
	var ObjForm = document.forms[0];
	var iFlag = 0;
	var iFlag1 = 0;
	var iCount = 0;
	if(fnValidateData())
	{
		iFlag1 = 1;
		while(currentPosition==totalRec && iCount<=0)
		{
			if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked))
			{
				alert("There are no more records");
				iCount++;
				iFlag=1;	
			}
		break;
		}
		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& iCount<=0)
		{
			alert("Enter the value in the field.");
			iFlag=1;
		}
	}
	if(iFlag!=1 && iFlag1==1)
	{
		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& !(currentPosition  == totalRec))
		{
			alert("Enter the value in the field.");
			return;
		}
		doSubmit(dirType);
	}
}

function fnGetNewRecordNext(dirType)
{
	var ObjForm = document.forms[0];
	var iFlag = 0;
	var iFlag1 = 0;
	if(fnValidateData())
	{
		iFlag1 = 1;
		if(currentPosition==totalRec||totalMRHRecords <= numOfRows)
		{
			 alert("There are no more records");
			 iFlag = 1;
		}
	}
	if(iFlag!=1 && iFlag1==1)
	{
		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& !(currentPosition  == totalRec))
		{
			alert("Enter the value in the field.");
			return;
		}
		doSubmit(dirType);
	}
}

function fnGetNewRecordPrev(dirType)
{
	var iFlag = 0;
	var iFlag1 = 0;
	if(fnValidateData())
	{
		iFlag1 = 1;
		if(currentPosition==0)
		{
			alert("There are no more records");
			iFlag = 1;
		}
	}
	if(iFlag!=1 && iFlag1==1)
	{
		if(!(ObjForm.txtfldname13.value)&&!(ObjForm.txtfldname25.value)&&!(ObjForm.txtfldname28.value)&&!(ObjForm.txtfldname310.value)&&!(ObjForm.txtfldname313.value)&&!(ObjForm.txtfldname415.value)&&!(ObjForm.txtfldname418.value)&&!(ObjForm.txtfldname520.value)&&!(ObjForm.txtfldname523.value)&&!(ObjForm.txtfldname625.value)&&!(ObjForm.txtfldname628.value)&&!(ObjForm.txtfldname730.value)&&!(ObjForm.txtfldname733.value)&&!(ObjForm.chkname835.checked)&& !(currentPosition  == totalRec))
		{
			alert("Enter the value in the field.");
			return;
		}
		doSubmit(dirType);
	}
}

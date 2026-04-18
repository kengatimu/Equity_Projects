/**************************************************************************************************
File        : EquityProcessCustom.js
Description : This file contains function to attach a process.
**************************************************************************************************/

/**************************************************************************************************
Function is called attach process as per selector setup thorugh AJAX call.
***************************************************************************************************/
function fnProcessSelection(strProcessURL,strBOURL)
{ try{
	//alert("Niharika fnProcessSelection");
	var xmlhttp;
	if (window.XMLHttpRequest)
	{
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		alert("Your browser does not support XMLHTTP!");
	}
	 /*xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status == 200)
		{

		}
	}*/
    xmlhttp.abort();
	xmlhttp.open("GET",strProcessURL,false);
    xmlhttp.send();
	if(xmlhttp.status == 200)
			{
			var exeStatus = xmlhttp.responseXML.selectSingleNode("XML/Status").text;
			var url = xmlhttp.responseXML.selectSingleNode("XML/BIOMETRICURL").text;
			var lastOperPerformed=xmlhttp.responseXML.selectSingleNode("XML/LASTOPERPERFORMED").text;
			//url = "../Renderer/Customization/Bio_Enroll.jsp";
			//alert("Url :" + url);
			if(exeStatus == 'SUCCESS' && url!='' && lastOperPerformed=='C')
			{ //top.close();
				//window.showModalDialog(url+"","",'dialogHeight:150px;dialogWidth:235px;status:no;help:no;dialogTop:none; dialogLeft:none;center:yes;scroll:yes');
//window.showModalDialog(url+"","",'center:yes;unadorned:yes;resizable:no;status:no;dialogHeight:600px;dialogWidth:800px;scrollbars=no');
			//	window.open(url);
 window.open(url,'','height=600,left=120,top=120,width=900,location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=no');
 window.moveTo(180,120);
 top.window.focus();
			}
			else if (exeStatus == 'SUCCESS' )
			{
			top.close();
			}

		}
	}
	catch(e){
		alert(e.message);
	}
}

function fnloadCorpSQDE()
{
 
 document.getElementsByName(boName+".primary_Service_Center")[0].disabled=true;
 document.getElementsByName("Cat_"+ boName+".primary_Service_Center")[0].disabled=true;
 document.getElementsByName("btnone_" + boName + ".primary_Service_Center")[0].disabled = true;
 document.getElementsByName("btntwo_" + boName + ".primary_Service_Center")[0].disabled = true;

 document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].disabled = true;
 var ReferenceNumber = getCookie('Filter_uniqueId');
 document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value = ReferenceNumber;
 
  
  /*Added for currency issue*/
  
  var accountid="";
  var strProcessURL = '../servlet/com.infy.cis.custom.EquityGetCurrency?entityId='+accountid;
  fnEquityGetCurrency(strProcessURL);
/*Added for currency issue*/

}

/*Added for currency issue*/
function fnEquityGetCurrency(strProcessURL)
{ 
    try{
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
	
        xmlhttp.abort();
	xmlhttp.open("GET",strProcessURL,false);
        xmlhttp.send();
	if(xmlhttp.status == 200)
	  { 
	   Currency = xmlhttp.responseXML.selectSingleNode("XML/Currency").text;
	   
	  }
	  }
      catch(e)
           {
		alert(e.message);
	   }
} 
/*Added for currency issue*/

 /**************************************************************************************************
 File        : EquityNonCustomerRetailProcessCustom.js
 Description : This file contains function to attach a process.
 **************************************************************************************************/
 
 /**************************************************************************************************
 Function is called attach process as per selector setup thorugh AJAX call.
 ***************************************************************************************************/
 function fnProcessSelection(strProcessURL,strBOURL)
 { try{
 	
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
    
     			
			var lastOperPerformed=xmlhttp.responseXML.selectSingleNode("XML/LASTOPERPERFORMED").text;
			
			 if (lastOperPerformed == 'E' )
						{
						top.close();
						}

			
			}
     
 	}
 	catch(e){
 		//alert("outmermost catch "+e.message);
 	}
}
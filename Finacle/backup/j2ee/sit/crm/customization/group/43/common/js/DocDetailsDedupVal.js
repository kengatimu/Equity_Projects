function getCookieValue(cookieName) 
{
	var cookies = document.cookie.split(';');
	for (var i = 0; i < cookies.length; i++) 
	{
		var cookie = cookies[i].trim();

		if (cookie.indexOf(cookieName + '=') === 0) 
		{
			return cookie.substring(cookieName.length + 1);
		}
	}
	return null;
}

function populateRefNumDocCodeDedupData()
{


         //alert("crmcif");
	//alert("mode = "+mode);
	//if((operationType != 'Edit Entity') && (mode != 'Queue') && (mode != 'ConvtoCust'))
	if(mode == 'add')
	{ 	var myUniqueId = getCookieValue('myUniqueID');
		//alert(myUniqueId);
		var myDocCode = getCookieValue('myDocCode');
		//alert(myDocCode);
		var userUniqueId = document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].value;
		var userDocCode = document.getElementsByName("EntityDocumentBO.DocCode")[0].value;
	
		if(myUniqueId != "" && userUniqueId !=""){
		
			if(userUniqueId != myUniqueId){
				alert("The unique id : " +userUniqueId+ "does not match : " +myUniqueId+ " from the Customer Onboarding page!!!");
				document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].value = "";
				document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].focus;
				return;
			}
		}
	
	//if(myDocCode != "" && userDocCode != ""){
		//if(userDocCode != myDocCode){
			//alert("The Document code : " +userDocCode+ " does not match : " +myDocCode+ " from the Customer Onboarding page!!!");
			//document.getElementsByName("EntityDocumentBO.DocCode")[0].value = "";
			//document.getElementsByName("EntityDocumentBO.DocCode")[0].focus;
			//return;
		//}
	//}
	}
}

function validateUniqueId(){
	var uniqueId = document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].value;
	
	if(uniqueId !="")
	{
		try
		{
			var s_xmlHttp;
			if (window.XMLHttpRequest)
			{
				s_xmlHttp=new XMLHttpRequest();
			}
			else
			{
				s_xmlHttp=new ActiveXObject("MSXML2.XMLHTTP");
			}
			var Count = "";
			var vStatus = "";
			var sucMsg = "";
			s_xmlHttp.abort();
			/*var strURL = '../servlet/com.infy.cis.custom.DRCCustomIDDedupcheck?UniqueID='+UniqueID+'&DocCode='+DocCode; */
			var strURL = '../servlet/com.infy.cis.custom.DRCCustomIDDedupcheck?UniqueID='+UniqueID;
			s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200)
			{	
				var responseText = s_xmlHttp.responseText;

				try {
					var xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
					xmlDoc.async = false;
					xmlDoc.loadXML(responseText);

					var statusElement = xmlDoc.getElementsByTagName('STATUS')[0];
					var statusValue = statusElement.text;

				} catch (e) {
					// Handle any errors that may occur during XML parsing
				}

				if (statusValue == "MATCH")
				{
					alert("THE UNIQUE ID: "+ UniqueID +" ENTERED ALREADY EXISTS IN THE SYSTEM. DUPLICATED RECORD!!!");
					
					document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].focus;
					document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value = "";
				}
				else
				{
					if(statusValue == "NOMATCH")
					{
						/*alert("RECORD NOT FOUND");*/
					}
					else
					{
						alert("An error occured. Please try again.");
					}
				}
				
			}
		}
		catch(e)
		{
			DebugMessage(e.message);
		}
	}
}

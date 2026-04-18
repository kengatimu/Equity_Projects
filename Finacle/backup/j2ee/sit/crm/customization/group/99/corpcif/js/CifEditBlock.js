//C.M EMT 17FEB2026 Start
//Any CIF of account in scheme code SB199/CA299 to be blocked for editing until the scheme code has been changed.
function blockCifEdit(myCifId)
{
	alert(myCifId);
	if (myCifId != "")
	{
		try
		{
			var s_xmlHttp;
			if (window.XMLHttpRequest)
			{
				s_xmlHttp = new XMLHttpRequest();
			}
			else
			{
				s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
			}

			s_xmlHttp.abort();
			var strURL = '../servlet/com.infy.cis.custom.CifEditBlocking?orgkey=' + myCifId;
			s_xmlHttp.open("POST", strURL, false);
			s_xmlHttp.send();
		
			if (s_xmlHttp.status == 200)
			{
				var responseText = s_xmlHttp.responseText;

				try
				{
					var xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
					xmlDoc.async = false;
					xmlDoc.loadXML(responseText);

					var statusElement = xmlDoc.getElementsByTagName('STATUS')[0];
					var sbElement = xmlDoc.getElementsByTagName('SB199_COUNT')[0];
					var caElement = xmlDoc.getElementsByTagName('CA299_COUNT')[0];
					var totalElement = xmlDoc.getElementsByTagName('TOTAL_COUNT')[0];

					var statusValue = statusElement.text;
					var sbCount = sbElement.text;
					var caCount = caElement.text;
					var totalCount = totalElement.text;
				}
				catch(e)
				{
					alert("Error reading response." + e);
					return false;
				}
				
				alert(statusValue);

				if (statusValue == "EXISTS")
				{
					var message = "CIF Edit Blocked !!!\n\n";
					message += "CIF ID: " + myCifId + "\n";

					if (sbCount != "0")
					{
						message += "SB199 Accounts: " + sbCount;
					}
					if (caCount != "0")
					{
						message += "CA299 Accounts: " + caCount;
					}
					message += "\nTotal Accounts: " + totalCount;
					alert(message);
					try
					{
						var allElements = document.getElementsByTagName("*");

						for (var i = 0; i < allElements.length; i++)
						{
							var text = allElements[i].innerText || allElements[i].textContent;

							if (text)
							{
								text = text.trim();

								if (text === "Edit" || text === "Quick Edit")
								{
									// Disable clicking
									allElements[i].style.pointerEvents = "none";
									allElements[i].style.color = "gray";
									allElements[i].style.cursor = "default";

									// If it's actually a button/input
									if (typeof allElements[i].disabled !== "undefined")
									{
										allElements[i].disabled = true;
									}

									// Remove onclick if exists
									allElements[i].onclick = null;
								}
							}
						}
					}
					catch(e)
					{
					}
					
					return false;
				}
				else if (statusValue == "NOMATCH")
				{
					return true;
				}
				else
				{
					alert("An error occurred while validating CIF.");
					return false;
				}
			}
		}
		catch(e)
		{
			alert(e.message);
			return false;
		}
	}
			
}
//C.M EMT 17FEB2026 End
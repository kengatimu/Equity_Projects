function validateDrmant(acctid)
{
	if(acctid !="")
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
			//var strURL = "../servlet/com.infy.cis.custom.SchemeValidation?acctid="+acctid;
			var strURL = "../servlet/com.infy.cis.custom.DormantValidation?acctid="+acctid;
			s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200)
			{
				var node1 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/COUNTVAL");
				Count = node1.text;
				var node2 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/STATUS");
				vStatus = node2.text;
			}

			if (vStatus == "MATCH")
			{
				return "YES";
			}
			else
			{
				return "NO";
			}
		}
		catch(e)
		{
			DebugMessage(e.message);
		}
	}
}

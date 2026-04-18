function ValidateISIC(Type,ID,TID,RType)
{
	if(ID !="")
	{

		try
		{
		var element =boName+ID;
		var Targetelement =boName+TID;
		var value = document.getElementsByName(element)[0].value;
		if(value!="")
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
			var Data = "";
			var vStatus = "";
			var sucMsg = "";
			s_xmlHttp.abort();
			var strURL = '../servlet/com.infy.cis.custom.ISICValidation?Type='+Type+'&Rating='+value+'&RType='+RType;
			s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200)
			{
				var node1 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/COUNTVAL");
				if(node1!=""){
				Data = node1.text;
				var node2 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/STATUS");
				vStatus = node2.text;
				}
				else{return false;}
				
			}
			if (vStatus == "Success")
			{
			
				var SValue = Data.split("|");
				var elm = document.getElementsByName(Targetelement)[0];	
				clearOptions(elm);
				for (var i = 0; i < SValue.length; i++) 
				{
					var val = SValue[i];
					var Sval = val.split("!");
					var Sdata = Sval[0];
					var text =Sval[1];
					if(Sdata!="")
					{
					
					var drp_elm = document.getElementsByName(Targetelement)[0];	
					var option = document.createElement("option");
					option.value = Sdata;
					option.text = text;	
					drp_elm.add(option);
					}
				}
			}
			else
			{
				return "NO";
			}
		}
		}
		catch(e)
		{
			DebugMessage(e.message);
		}
	}
}

function clearOptions(elm)
{
    for (var i = elm.options.length - 1 ; i >= 0 ; i--)
	{
        elm.remove(i);
	}
	elm.options.length = 0;
					
					var option = document.createElement("option");
					option.value = "";
					option.text = "--Select--";	
					elm.add(option);
}


function ISICValue(cifid,ID)
{
	

	if(cifid !="")
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
			var Data = "";
			var vStatus = "";
			var sucMsg = "";
			s_xmlHttp.abort();
			var strURL = '../servlet/com.infy.cis.custom.ISICValues?CIFID='+cifid+'&ID='+ID;
			s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200)
			{
				
				var node1 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/VALUE");
				if(node1!=""){
				Data = node1.text;
				var node2 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/STATUS");
				vStatus = node2.text;
				}
				else{return false;}
				
			}
			else
			{
					
			}
			if (vStatus == "Success")
			{
				
				document.getElementsByName("AccountBO."+ID)[0].value = Data;
				
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


function CorpISICValue(cifid,ID)
{	

	if(cifid !="")
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
			var Data = "";
			var vStatus = "";
			var sucMsg = "";
			s_xmlHttp.abort();
			var strURL = '../servlet/com.infy.cis.custom.CorpISICValue?CIFID='+cifid+'&ID='+ID;
			s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200)
			{
				var node1 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/VALUE");

				if(node1!=""){
				Data = node1.text;
				var node2 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/STATUS");
				vStatus = node2.text;
				}
				else
				{
				return false;
				}
				
			}
			else
			{
					
			}
			if (vStatus == "Success")
			{
				
				document.getElementsByName("CorporateBO."+ID)[0].value = Data;
				
			}
			else
			{
				return "NO1";
			}
		}
		catch(e)
		{
			DebugMessage(e.message);
		}
	}
}

function SubsectorValue(cifid,ID)
{
	if(cifid !="")
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
			var Data = "";
			var vStatus = "";
			var sucMsg = "";
			s_xmlHttp.abort();
			var strURL = '../servlet/com.infy.cis.custom.CorpISICValue?CIFID='+cifid+'&ID='+ID;
			s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200)
			{
				var node1 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/VALUE");

				if(node1!=""){
				Data = node1.text;
				var node2 = s_xmlHttp.responseXML.selectSingleNode("GETDATA/STATUS");
				vStatus = node2.text;
				}
				else
				{
				return false;
				}
				
			}
			else
			{
					
			}
			if (vStatus == "Success")
			{
								
				document.getElementsByName('CorporateBO.Subsector_Code')[0].value=Data;
				
			}
			else
			{
				//alert("NO12");
				return "NO1";
			}
		}
		catch(e)
		{
			DebugMessage(e.message);
		}
	}
}



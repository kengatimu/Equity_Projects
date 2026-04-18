<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Gss.Veracious.SL.RD.API</title>
    <style type="text/css">
        html, body
        {
            height: 100%;
            overflow: auto;
        }
        body
        {
            padding: 0;
            margin: 0;
        }
        #silverlightControlHost
        {
            height: 100%;
            text-align: center;
        }
    </style>
</head>
<body>
    <form name="form1" id="form1" runat="server" style="height: 100%">
    <div id="silverlightControlHost">
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="100%">
            <param name="source" value="Gss.Veracious.SL.RD.API.xap" />
            <param name="onError" value="onSilverlightError" />
            <param name="onLoad" value="pluginLoaded" />
            <param name="background" value="white" />
		<param name="initParams" value="Param=SI" />
            <param name="autoUpgrade" value="true" />
            <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=5.0.61118.0" style="text-decoration: none">
                <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight"
                    style="border-style: none" />
            </a>
        </object>
     </div>
    </form>
</body>
</html>

  <script type="text/javascript" src="Silverlight.js"></script>

    <script type="text/javascript">
	
	var slCtl = null;
	var params = null;
	
	
	function onSilverlightError(sender, args) {
		var appSource = "";
		alert("Error");
		if (sender != null && sender != 0) {
			appSource = sender.getHost().Source;
		}

		var errorType = args.ErrorType;
		var iErrorCode = args.ErrorCode;

		if (errorType == "ImageError" || errorType == "MediaError") {
			return;
		}

		var errMsg = "Unhandled Error in Silverlight Application " + appSource + "\n";

		errMsg += "Code: " + iErrorCode + "    \n";
		errMsg += "Category: " + errorType + "       \n";
		errMsg += "Message: " + args.ErrorMessage + "     \n";

		if (errorType == "ParserError") {
			errMsg += "File: " + args.xamlFile + "     \n";
			errMsg += "Line: " + args.lineNumber + "     \n";
			errMsg += "Position: " + args.charPosition + "     \n";
		}
		else if (errorType == "RuntimeError") {
			if (args.lineNumber != 0) {
				errMsg += "Line: " + args.lineNumber + "     \n";
				errMsg += "Position: " + args.charPosition + "     \n";
			}
			errMsg += "MethodName: " + args.methodName + "     \n";
		}

		throw new Error(errMsg);
	}

    </script>
 
    <script type="text/javascript">
        document.domain = 'ebsafrica.com';
    </script>
    
    <script type="text/javascript">
 
     function GetParams() {
			var arguments;
			//alert("Inside GetParams");	
			params = getURLParameter('Params');
			//params = params + "|net.tcp://10.1.6.132:4504/RDAPI";
			//params = params + "|net.tcp://10.1.9.170:4504/RDAPI";
			var modParams = "&rtId";
			var paramLen = params.indexOf(modParams);
			if( paramLen != -1){
				var params = params.substring(0,paramLen);
			}
			params = params + "|net.tcp://10.1.6.121:4504/RDAPI";
			//params = params + "|net.tcp://veraciousdev.ebsafrica.com:4504/RDAPI";
					
			arguments = params;
           // arguments = window.location.search.substr(1);
            return arguments;
	}

 
	function pluginLoaded(sender, args) {
        slCtl = sender.getHost();
    }

	function OnInitParam(sender, args) {
		//alert("On Init param");
	}
		
    function getURLParameter(name) {
	      return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
    }
 
 
	function ReturnValue(par1)
	 {
		//alert(par1);
		if (window.opener) {
			window.opener.returnValue = par1;
		}
		window.returnValue = par1;
		alert("Parameter : " + window.returnValue);
		self.close();
	 }

	 </script>
<script language="javascript" type="text/javascript" for="Ranger" event="TransportFeedingStopped(reason,itemsFed,itemsrequested)">
        slCtl.Content.SL2JS.BindItems(reason,itemsFed,itemsrequested);
</script>
<script language="javascript" type="text/javascript" for="Ranger" event="TransportNewState(newState,previousState)">
        slCtl.Content.SL2JS.GetState(newState,previousState);
</script>
<script language="javascript" type="text/javascript" for="Ranger" event="TransportChangeOptionsState(previousState)">
        slCtl.Content.SL2JS.GetchangeState(previousState);
</script>
<script type="text/javascript" language="javascript" for="Ranger" event="TransportItemInPocket(itemID)">
        slCtl.Content.SL2JS.TransportItemInPocket(Ranger.GetMicrText(1),itemID);
</script>


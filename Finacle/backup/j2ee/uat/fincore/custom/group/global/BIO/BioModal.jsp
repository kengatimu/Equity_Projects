<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head> 	
		<title>Verify Fingerprint</title>
	<link rel="stylesheet" href="../BIO/verify/css/bootstrap.min.css">
	<link rel="stylesheet" href="../BIO/verify/css/custom.css">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		 document.domain = "ebsafrica.com";
		</script>
	</head>
<body  onload="onload()">
		<div class="container"><div>

			<div style="text-align: center;">
				<label id="wait">Click Verify and Capture Fingerprint</label>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<div>
						<div class="form-group" method="GET">
							<label for="searchKey">Search Key (Customer Id):</label>
							<input type="text" class="form-control" id="accountNumber" placeholder="Account number">
						</div>
					</div>
					<div class="finger-print">
						<div>
							<div>
								<img id="print" class="raw-image img-responsive" src="" data-toggle="tooltip" data-placeholder="right" title="Capture image" />
							</div>
							<div class="center-block">
								<button id="verifyButton" style="background-color:#990000 ; border-color:#990000"  class="btn btn-success btn-lg btn-block" onclick="smartVerify()" style="border-radius: 0px;">Verify</button>
							</div>
							<p></p>
							<div class="center-block">
								<button id="OverrideButton" style="background-color:#990000 ; border-color:#990000"  class="btn btn-success btn-lg btn-block" onclick="smartOverride()" style="border-radius: 0px;">Override</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type='text/javascript' src='../BIO/verify/js/json2.js'></script>


<script type='text/javascript'>

function onload()
{
var params = getURLParameter('cif');
document.getElementById("accountNumber").value=params;
document.getElementById("accountNumber").readOnly =true;
}
function getURLParameter(name) {
			return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
		   }</script>
		<script type="text/javascript"><!--

		var fingerprints = [];
		var fingers = { fingerprints: [] };
		var biodata = {};
		// secugen URL
		var secugenCaptureUrl = "https://localhost:8443/SGIFPCapture?nocache=";

var secugen_lic = "8MMq4CGtQ5mwC18f5dLXNAW53dCf4BaO3ujun7Rw4UJQXZuRV0ls8GDC1AtRhVTb";   
		function smartOverride() {
		document.getElementById("verifyButton").disabled = true;
		
		//Add validation for bank id 43 - start
		var cif_id = document.getElementById("accountNumber").value
		var bank_id = cif_id.substring(0, 2);

		if(bank_id == "43"){
			//document.getElementById("OverrideButton").disabled = false;
		}else{
			document.getElementById("OverrideButton").disabled = true;
		}
		//Add validation for bank id 43 - start
		
		//document.getElementById("OverrideButton").disabled = true;
		SuccessVFunc("O");
		}
		function smartVerify() {
			var acc = document.getElementById("accountNumber").value;
			if (acc === "") {
			alert("Unable to Fetch Customer Id");
			}
			else
			{
				document.getElementById("verifyButton").disabled = true;
				
				//Add validation for bank id 43 - start
				var cif_id = document.getElementById("accountNumber").value
				var bank_id = cif_id.substring(0, 2);

				if(bank_id == "43"){
					//document.getElementById("OverrideButton").disabled = false;
				}else{
					document.getElementById("OverrideButton").disabled = true;
				}
				//Add validation for bank id 43 - start
				
				//document.getElementById("OverrideButton").disabled = true;
			}
			
			captureFingerprint(successCall, failCall);	

		}


		function failCall(status) {

			fingerPrints = [];
			prof = {};
			document.getElementById("accountNumber").value = '';
			alert("Check if device is connected well");

			document.getElementById("verifyButton").disabled = false;
			
			//Add validation for bank id 43 - start
			var cif_id = document.getElementById("accountNumber").value
			var bank_id = cif_id.substring(0, 2);

			if(bank_id == "43"){
				//document.getElementById("OverrideButton").disabled = true;
			}else{
				document.getElementById("OverrideButton").disabled = false;
			}
			//Add validation for bank id 43 - start
			
			//document.getElementById("OverrideButton").disabled = false;
		}
	
		function successCall(result) {
alert("Device Output: "+result.ErrorCode);
			if (result.ErrorCode == 3) {
			alert("Kindly check if device is connected");
		document.getElementById("verifyButton").disabled = false;
		document.getElementById("OverrideButton").disabled = false;
			}
			else if (result.ErrorCode == 0) {
				alert("Image Quality "+result.ImageQuality);
				if (result.ImageQuality < 50) {
				alert("Kindly place your finger properly");
		document.getElementById("verifyButton").disabled = false;
		document.getElementById("OverrideButton").disabled = false;
				}
				else {
					alert("Finger Print Captured Successfully");
var v=result.BMPBase64;
					verifyFingerprint(SuccessVFunc, ErrorVFunc,v);	
				}
			}
			else if (result.ErrorCode == 54) {
			alert("Kindly place finger on the  device or reconnect bio device and retry again");
		document.getElementById("verifyButton").disabled = false;
		document.getElementById("OverrideButton").disabled = false;
			}
			else {
				alert("Failed to capture fingerprint");
		document.getElementById("verifyButton").disabled = false;
		document.getElementById("OverrideButton").disabled = false;
			}
		}


		function captureFingerprint(successCall, failCall) {
		debugger
			var xmlhttp;
if(window.ActiveXObject)
{
xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
}
else if (window.XMLHttpRequest)
{
xmlhttp = new XMLHttpRequest();
}
			
			xmlhttp.onreadystatechange = function () {

if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

					fpobject = JSON.parse(xmlhttp.responseText);
					successCall(fpobject);
				}
				else if (xmlhttp.status == 404) {

					failCall(xmlhttp.status)
				}
			}
			/*xmlhttp.onerror = function () {
				failCall(xmlhttp.status);
				
				
			}*/

			var params = "Timeout=" + encodeURIComponent("5000");
			params += "&Quality=" + encodeURIComponent("50");
params += "&licstr=" + encodeURIComponent(secugen_lic);
			params += "&templateFormat=" + encodeURIComponent("ISO");
			xmlhttp.open("GET", secugenCaptureUrl+(new Date()).getTime(), true);
			xmlhttp.send(params);
		}

function ErrorVFunc(status) {
			alert("BIO server Connection not established");
		document.getElementById("verifyButton").disabled = false;
		document.getElementById("OverrideButton").disabled = false;
		}
	
		function SuccessVFunc(result) {
parent.window.returnValue = result;
top.close();
		}
		
			function verifyFingerprint(successVCall, failVCall,v) {
		debugger
			var xhr;
if(window.ActiveXObject)
{
	xhr = new ActiveXObject("Microsoft.XMLHTTP");
}
else if (window.XMLHttpRequest)
{
	xhr = new XMLHttpRequest();
}
document.getElementById("print").src = "data:image/bmp;base64," + v;
var secugenVerifyUrl="https://finaclepreprodweb.ebsafrica.com:11500/finbranch/custom/BIO/postReqScrExe.jsp";

xhr.onreadystatechange = function () {

if (xhr.readyState == 4 && xhr.status == 200) 
	{
		fpobject= xhr.responseText.replace(/(\r\n|\n|\r|\\)/gm, "");
		
		var ret1 = fpobject.split("|");
		var s=ret1[0];
		
		if(parseInt(s,10)>0)
		{
			SuccessVFunc("Y");
		}
		else
		{
			var msg = ret1[1] + "Would you like to override?"; 
			if(confirm(msg))
			{
				SuccessVFunc("O");
			}
			else
			{
				SuccessVFunc("1");
			}
			
		}
	}
	else if (xhr.status == 404) {

		ErrorVFunc("Unable To Contact BIO")
	}
}
/*xhr.onerror = function () {
	failVCall(xhr.status);	
}*/

var params = "cif=" + encodeURIComponent(document.getElementById("accountNumber").value);
params += "&sign=" + encodeURIComponent(v);
xhr.open("POST", secugenVerifyUrl, true);
xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
xhr.send(params);
		}
		--></script>
	</body>
</html>

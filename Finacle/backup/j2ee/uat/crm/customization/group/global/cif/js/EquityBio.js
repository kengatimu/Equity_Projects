
     //document.write('<script language=javascript src="'+applPath+'/Customization/cif/js/EquityProcessCustom.js">'+'<\/script>'); 
	// document.write('<script language=javascript src="../BIO/js/json2.js">'+'<\/script>');
	document.write('<script type="text/javascript" src="../BIO/js/json2.js" language="javascript"></script>');
	
	var Succ_index= [];
   var fingerpos = new Array();
   fingerpos=["LEFT_THUMB","LEFT_INDEX","LEFT_MIDDLE","LEFT_RING","LEFT_LITTLE","RIGHT_THUMB","RIGHT_INDEX","RIGHT_MIDDLE","RIGHT_RING","RIGHT_LITTLE"];  
   var captured = ["L0", "L1", "L2", "L3","L4","R0","R1", "R2", "R3", "R4"];
	var imgId = null;
    var captS = null;
    var btnid = null;
    var bios = [];
    var fingerprints = [];
    var fingers = { fingerprints: [] };
    var biodata = {};
    // secugen URL
    var secugenCaptureUrl = "https://localhost:8443/SGIFPCapture?nocache=";
    var secugenMatchUrl = "https://localhost:8443/SGIMatchScore?nocache=";
	var secugen_lic = "xaONWr4+RmyJWPxcY88wqNWVdLk+qrQQVUslrniIPgA6PCkVGtMtE4LGxWqpOg8t";   
    var pos = 0;
    //const defaultSrc = "assets/images/enroll/noImage_1.png";
	var Fingercount=0;
	
   function addFinger(index) {
	
	  /* if(Fingercount>8)
	   {
		   alert("Kindly capture maximum 8 fingerprints only");
		   return true;
	   }
	   else{*/
	//alert("in add");
      imgId = fingerpos[index];
      captS = captured[index];
      btnid = 'BTN_' + imgId;
	  disableFingers(index);
      captureFingerprint(imgId, SuccessFunc, ErrorFunc);
	
	
	  //enrollFingerprint(SuccessVFunc, ErrorVFunc,v,imgId);
	  // }
    }
  function failCall(status) {
alert("Error in Capture fingerprint");
enableFingers();
    }

	function captureFingerprint(index, SuccessFunc, failCall) {
		
      var xmlhttp = new XMLHttpRequest();

      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			//alert("in capture fingerprint success");
          fpobject = JSON.parse(xmlhttp.responseText);
          SuccessFunc(fpobject, index,xmlhttp);
        }
        else if (xmlhttp.status == 404) {
         failCall(xmlhttp.status);
		
        }
      }
      xmlhttp.onerror = function () {
		         failCall(xmlhttp.status);				
      }

      var params = "Timeout=" + encodeURIComponent("5000");
      params += "&Quality=" + encodeURIComponent("50");
	  params += "&licstr=" + encodeURIComponent(secugen_lic);
      params += "&templateFormat=" + encodeURIComponent("ISO");
	 // xmlhttp.abort();	
      xmlhttp.open("GET", secugenCaptureUrl+(new Date()).getTime(), true);
      xmlhttp.send(params);
	
	  
          
    }
	
    


 
    function ErrorFunc(status) {
	alert("Error in Capture fingerprint");
	enableFingers();

    }

  
   function SuccessFunc(result, index,xmlhttp) {
		try{
				//alert("ErrorCode"+result.ErrorCode);
				
			//alert("resultImageQuality"+result.ImageQuality);
			//alert("index"+index);

		 if (result.ErrorCode == 3) {
      //  return swal({ title: "Warning!", text: "Make sure your device is connected", timer: 5000 });
	  alert("Make sure your device is connected");
	  enableFingers();
	  return true;
	// parent.window.returnValue = "1";
	

//top.close();

      }
	  
       else if (result.ErrorCode == 0) {
		alert("resultImageQuality"+result.ImageQuality); 
if(result.ImageQuality=='undefined')
{
alert("Kindly place your finger ");
enableFingers();
return true;
//parent.window.returnValue = "1";

}

      else  if (result.ImageQuality < 50 ) {
          //return swal({ title: "Warning!", text: "Please place your finger properly", timer: 5000 });
		    //alert("Please place your finger properly");
	alert("Kindly place your finger properly");
	enableFingers();
	return true;
//parent.window.returnValue = "1";
//top.close();

        }
		else {
					alert("Finger Print Captured Successfully");	
					Succ_index.push(index);
   Fingercount=Fingercount+1;
xmlhttp.abort();

				
       if (bios.length > 0) {
          var temp2 = result.TemplateBase64;
          for (var i = 0; i < bios.length; i++) {
            var params = 'template1=' + encodeURIComponent(bios[i]);
            params += '&template2=' + encodeURIComponent(temp2);
            params += '&templateFormat=' + 'ISO';
			params += "&licstr=" + encodeURIComponent(secugen_lic);
            var data = { quality: result.ImageQuality, index: index }
            matchFingerprint(data, params, matchSuccessFunc, matchErrorFunc);
          }

        }
        bios.push(result.TemplateBase64);
        document.getElementById(imgId).src = 'data:image/bmp;base64,' + result.BMPBase64;
        document.getElementById(btnid).disabled = true;
        document.getElementById(captS).src = '../BIO/assets/images/enroll/S' + captS + '.png';
        var finger = {};
        var fingerprintImage = {};
        fingerprintImage.format = 'BMP'
        fingerprintImage.resolutionDpi = result.ImageDPI;
        fingerprintImage.data = result.BMPBase64;
        finger.position = imgId;
        finger.image = fingerprintImage;
        fingers.fingerprints.push(finger);
        biodata = { 'fingerprints': fingers };
		enableFingers();
}

      }
	
      else if (result.ErrorCode == 54) {
       // return swal({ title: "Warning!", text: "Timeout... Please try again", timer: 5000 });
		alert("Time out... please try again");
enableFingers();
//xmlhttp.abort();
return true;
								//parent.window.returnValue = "1";
//top.close();
      }
      else {
alert("ErrorCode"+result.ErrorCode);
        alert("Failed to capture finger print , kindly retry");
		enableFingers();
//xmlhttp.abort();
		//parent.window.returnValue = "1";
return true;
      }
		}catch(e)
	{
		//alert(e); 
	}
    }
	function getURLParameter(name) {
			return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
		   }

    function showCapturedFingers() {
		if(Succ_index.length>0)
		{
		document.getElementById('BTN_SAVE').disabled = true;
		disableAllFingers();
//alert("showCapturedFingers");
	var params = getURLParameter('cif');
var params1= JSON.stringify({ 'biometrics': this.biodata });
var index="NA";
//alert("params1"+JSON.stringify({ 'biometrics': this.biodata }));
fnEnrollCIF(params,params1,index);
      //console.log(JSON.stringify({ 'biometrics': this.biodata }))
		}
		else{
			alert("No fingerprints captured successfully");
			
		}
    }

    function matchFingerprint(data, params, matchSuccessFunc, matchErrorFunc) {
		//alert("matchFingerprint");
      var API_KEY = 'API KEY';
      var headers = { 'Content-Type': 'application/json', 'apiKey': API_KEY, 'signature': 'nah' };
	
     // var loadedHeaders = headers;
       // loadedHeaders.signature = hashData(message);
      //console.log('headers: ', loadedHeaders);
     // console.log(JSON.stringify(message));
     // message = encryptData(message);
	
     // console.log('encData: ', JSON.stringify(message));
      var xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          var response = decryptData(xmlhttp.responseText);
          fpobject = JSON.parse(response);
		  
          matchSuccessFunc(fpobject, data);
        }
        else if (xmlhttp.status == 404) {
			
          matchErrorFunc(xmlhttp.status)
        }
      }
      xmlhttp.onerror = function () {
		  
        failCall(xmlhttp.status);
      }

      xmlhttp.open("POST", secugenMatchUrl+(new Date()).getTime(), true);
      xmlhttp.send(params);
	  
    }

   function matchSuccessFunc(result, data) {
	  
      if (result.MatchingScore >= data.quality) {
        bios.splice(data.index, 1);
        document.getElementById(fingerpos[data.index]).src = "../BIO/assets/images/enroll/noImage_1.png";		
        document.getElementById(captured[data.index]).src = '../BIO/assets/images/enroll/' + captured[data.index] + '.png';
        document.getElementById(btnid = 'BTN_' + fingerpos[data.index]).disabled = false;
        //return swal({ title: "Warning!", text: "Fingerprint already captured. Please capture the next print", timer: 5000 });
		alert("Fingerprint already captured. Please capture the next print");
		enableFingers();
		      }
    }
    function matchErrorFunc(result) {
		alert("Error in Match Fingerprint");
			enableFingers();

    }
	

function fnEnrollCIF(CIFID,sign,index)
{
	
	var s_xmlHttp;
try{
if (window.XMLHttpRequest)
	{
		// code for IE7+, Firefox, Chrome, Opera, Safari
		s_xmlHttp=new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		// code for IE6, IE5
		s_xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		alert("Your browser does not support XMLHTTP!");
	}
//var CIFID=request.getParameter("cif");
//var sign=request.getParameter("sign");

var fingerPrintData="param:"+CIFID+"param:"+sign+"param:"+index;

	
var strURL1 = '../../servlet/com.infy.cis.custom.EquityCustomBIOCall';
 //?&cifID='+cifID+'&fingerPrintData='+fingerPrintData;
//  s_xmlHttp.abort();
				s_xmlHttp.open("POST",strURL1,false);
				//s_xmlHttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
				//s_xmlHttp.setRequestHeader('Access-Control-Allow-Origin', '*');
			

				s_xmlHttp.send(fingerPrintData);
				

				if(s_xmlHttp.status == 200)
				{

				var node1 = s_xmlHttp.responseXML.selectSingleNode("XML/VALUE");
			//var node1= s_xmlHttp.responseText;
				//alert('node1'+node1);
			var status=node1.text;
			//alert('status'+status);
			 if(status=='FAILURE')
			{
				var errormessage = s_xmlHttp.responseXML.selectSingleNode("XML/ERROR");
				alert("Exception in CIF BIO Enrollment"+errormessage.text);
				document.getElementById('BTN_SAVE').disabled = false;
				enableAllFingers();
				s_xmlHttp.abort();


			}
				
			else{
					var jsonobj=JSON.parse(status);
					var resp=jsonobj.status;
					var message=jsonobj.message;
					//alert('resp'+resp);
					//alert('message'+message);
					
					if(resp=='000')
					{
						alert("CIF BIO Enrollment is successful");
						fnClose();
						top.close();
					}
				
					else{
						alert("Error in BIO Call: "+resp+" "+message);
							document.getElementById('BTN_SAVE').disabled = false;
							//alert("Error in BIO Call: "+status);
							enableAllFingers();
							s_xmlHttp.abort();
						}

				}
				}
			}
			catch(e){
		alert("Error in BIO "+e.message);
		s_xmlHttp.abort();
		document.getElementById('BTN_SAVE').disabled = true;
		fnClose();
		top.close();
	}



			
			
			

}		//DRC Changes for new bio ends

function disableFingers(index)
{
	 for (var i = 0; i < 10; i++) 
	{
		if(i!=index)
		{
	var imgId1 = fingerpos[i];
	var btnid1 = 'BTN_' + imgId1;
	document.getElementById(btnid1).disabled = true;	
		}
	}
	document.getElementById('BTN_SAVE').disabled = true;
}

function disableAllFingers()
{
	 for (var i = 0; i < 10; i++) 
	{
		
	var imgId1 = fingerpos[i];
	var btnid1 = 'BTN_' + imgId1;
	document.getElementById(btnid1).disabled = true;	
		
	}
	document.getElementById('BTN_SAVE').disabled = true;
}
function enableFingers()
{
	document.getElementById('BTN_SAVE').disabled = false;

	
	 for (var i = 0; i < 10; i++) 
	{
	var imgId1 = fingerpos[i];
	
	if(Succ_index.length==0 )
	{
		var btnid1 = 'BTN_' + imgId1;
	document.getElementById(btnid1).disabled = false;	
	}
	else 
	{		
	
		for(var j=0;j<Succ_index.length;j++)
		{
			
			if(Succ_index[j]==imgId1)
			{
	var btnid1 = 'BTN_' + imgId1;
	document.getElementById(btnid1).disabled = true;
			}
			else{
				var btnid1 = 'BTN_' + imgId1;
	document.getElementById(btnid1).disabled = false;
			}
		}
	}
		
	}
		
	
}
function enableAllFingers()
{
	document.getElementById('BTN_SAVE').disabled = false;
	Fingercount=0;
	 for (var i = 0; i < 10; i++) 
	{
	var imgId1 = fingerpos[i];	
	var btnid1 = 'BTN_' + imgId1;
	document.getElementById(btnid1).disabled = false;	
	document.getElementById(fingerpos[i]).src = "../BIO/assets/images/enroll/noImage_1.png";		
	
		
	}		
	
}
function Reset()
{
	enableAllFingers();	
	 Succ_index= [];
  
	 imgId = null;
     captS = null;
     btnid = null;
     bios = [];
     fingerprints = [];
     fingers = { fingerprints: [] };
     biodata = {};
     pos = 0;   
	Fingercount=0;
	   var captS =null;
	   for(var i=0;i<captured.length;i++)
	   {
		captS = captured[i];
	 
	 document.getElementById(captS).src = '../BIO/assets/images/enroll/'+ captS + '.png';
	   }
}

function fnClose()
{
	
	
	try{

	var dataArea = window.opener.parent.parent.parent.parent.parent;

var screenTitle= window.opener.parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
screenTitle.titleMsg.innerHTML = "CIF Retail > New Entity > Customer Onboarding";	
dataArea.location.href="../../servlet/com.infy.cis.custom.OnboardDetWizard?type=Retail";
	}catch(e)
	{
		alert(e);
	}
	//window.top.close();
	
}
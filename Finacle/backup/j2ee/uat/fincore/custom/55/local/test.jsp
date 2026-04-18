<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

 	<style>
        body{
                width: auto;
                height: auto;
        }
        </style>
		<title>eVeri2.0</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		 document.domain = "ebsafrica.com";
		</script>
	</head>
 
	<body bgcolor="#F0F0F0" onload="onload()" WIDTH="100%" HEIGHT="100%">
		<object type="application/x-java-applet" width="400" height="350" id="bioId" name="bioId">
			<param name="codebase" value="https://10.1.19.62:8080/bio"/>
			<param name="code" value="org.compulynx.bio.applet.Validate" />
			<param name="archive" value="evalidate.jar" />
		</object>
 
 		</br>
		<input name="button" type="button" id="btnClose" value="Reset Device" />
		<input name="button" type="button" id="btnCapture" value="onCapture" onclick="capture()" />
		<!--<input name="button" type="button" id="btnOverRide" value="Override" onclick="override()"/>-->

	<script type="text/javascript"><!--
		   function onload(){
				var params = getURLParameter('IDDtls');
				//alert(params);
			    var obj = document.getElementById("bioId");
				//console.log(obj);
				obj.OnDeviceInit(params);   
		   }   		   
		   function capture(){
			   var obj = document.getElementById("bioId");
			   var t=  obj.onScan();
			   //alert("FROM POPUP :" +t);
			   if (window.opener) {
				   window.opener.returnValue =t;
				 }
			   window.returnValue = t;
			   self.close();
			   /*if (window.opener) {
				   window.opener.returnValue =t;
				 }
			   window.returnValue = t;
			   self.close();
			   //alert(t);
			   window.returnValue = t;
			   window.close();*/
			  // alert(t);
			  //window.dialogArguments.callback(t);
			  //window.close();
		   }
                   function override() {
                          window.returnValue = "O";
                          self.close();
                   }

		   function getURLParameter(name) {
			return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
		   }
--></script>
	</body>
</html>


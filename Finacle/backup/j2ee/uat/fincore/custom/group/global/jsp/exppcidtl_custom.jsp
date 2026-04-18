<%@ page import="com.infy.finbranch.groups.CustomizeBean" %>
<arjsp:init groupName="exppci" isEntryPoint="false" />
<script>
com.infy.finbranch.groups.finbranch_sessionBean finbranch;
synchronized(session) {
finbranch = (com.infy.finbranch.groups.finbranch_sessionBean) session.getAttribute("finbranch");
	if (finbranch == null) 
	{
		finbranch = (com.infy.finbranch.groups.finbranch_sessionBean)
	        ARJspCustomMapper.fetchClassInstance("com.infy.finbranch.groups.finbranch_sessionBean");
	        session.setAttribute("finbranch", finbranch);
	}
}
</script>
<html>
<head>
<script>
var frm = null;
function exppcidtl_post_ONLOAD(){
	frm = document.forms[0];
	var strValue = document.forms[0].customData.value;
	var strTemp=new Array();
	var strTempo=new Array();
	if(strValue.indexOf("~") != -1){
		strTemp=strValue.split("~");	        
	}
	
	if(strTemp[1].indexOf("|") != -1){
			strTempo=strTemp[1].split("|");		        
	}
	
	frm.freeFld1.value = strTempo[1];
	frm.freeFld2.value = strTempo[2];
	frm.freeFld3.value = strTempo[3];
	frm.freeFld4.value = strTempo[4];
}
</script>

</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
	<tr>
	<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="innertable">
		<tr>
        	<td>
		        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		                <tr class="innertabletop1">
		                <td colspan="5" align="right">
				        <table border="0" cellspacing="0" cellpadding="0">
				        <tr>
			                <td align="right">
				       	         <a href="javascript:showHelpFile(dsammUsrAddnlDtls_help.htm);">
				       		         <img src="../Renderer/images/help.gif" width="47" height="21" vspace="1" border="0">
        					 </a>
        	         		</td>
        				</tr>
					</table>
        			</td>
				</tr>
        			<tr>
  				<td class="textlabel">Free Field 1<script>setMandatory("N")</script></td>
  				<td class="textfield">
				        <input type="text" class="textfieldfont" name="custom.freeFld1" id="freeFld1" value="" size="16" maxlength = "30">
  				</td>
  			        <td class="textlabel">Free Field 2<script>setMandatory("N")</script></td>
  				<td class="textfield">
  				        <input type="text" class="textfieldfont" name="custom.freeFld2" id="freeFld2" value="" size="16" maxlength = "30">
  				</td>
  				</tr>
        			<tr>
  			        <td class="textlabel">Free Field 3<script>setMandatory("N")</script></td>
  	                        <td class="textfield">
  					<input type="text" class="textfieldfont" name="custom.freeFld3" id="freeFld3" value="" size="16" maxlength = "30">
  	     			</td>
             			<td class="textlabel">Free Field 4<script>setMandatory("N")</script></td>
             			<td class="textfield">
  	     		  	      <input type="text" class="textfieldfont" name="custom.freeFld4" id="freeFld4" value="" size="16" maxlength = "30">
             			</td>
         			</tr>
  			</table>
          	 </td>
         	 </tr>
        	 </table>
        </td>
        </tr>
</table>
</body>
</html>






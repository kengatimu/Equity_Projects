<%@ page import="com.infy.finbranch.groups.CustomizeBean" %>
<%@ include file='../../custom/javascripts/exppcicrit_custom.js' %>
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

function inquirycriteria_ONCLICK8(obj,p1)
{
	setFieldsToCustomData("freeFld1","freeFld2","freeFld3","freeFld4");
	var retVal = "";
        if (preEventCall('inquirycriteria',obj,"ONCLICK") == false) { 
        	return false;
        }
        if ((retVal = form_ONCLICK(p1)) == false) {
                return false;
        }
        if (postEventCall('inquirycriteria',obj,"ONCLICK") == false) { 
                return false;
        }
        
        return (retVal == undefined) ? true : retVal;
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






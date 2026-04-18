<%-- This Sample Parameter Acceptance form can be used in Workflow Process in Finacle 9.0  --%>
<%--  The Sample Parameter Acceptance form is done to accomodate any additional values that are not defined in a Workflow Process.It can be configured to contain the list of all those fields which the user wants to enter
at runtime.This must go as the First Activity of the Workflow Process.This sets all the field entered in the
paramacceptance form to the context which are accessible when the relevant activty is invoked.
The jsp written to take values at runtime should be placed in finbranch/custom/jsp --%>


<%--    This is the COMMON include for any custom tab/menu which will written  --%>

<arjsp:init groupName="custom" isEntryPoint="true" />

<%@ include file="commonInclude.jsp"%>
<%--    The GROUPNAME specified below should be same as the value of pagename HIDDEN field below  --%>
<arjsp:init groupName="custom" isEntryPoint="true" />

<jsp:useBean id="customBeanInst" class="com.infy.finbranch.groups.paramBean" scope="session" />

<% 
	 String sBaseHref = (String)pageContext.getAttribute("_ARJspApplicationBaseHref_", PageContext.SESSION_SCOPE);
	 String sFinContextPath  = request.getContextPath();
	 boolean isInitSuccessful = true;
	 String sNextPage;
	 String outErrorPage[] = new String[1];
         fabclasses.FinSessionInit sessInit;
         synchronized(session) {
	 		sessInit = (fabclasses.FinSessionInit) session.getAttribute("FinSessionInit");
	 		if (sessInit == null) {
	 			sessInit = (fabclasses.FinSessionInit)CustomMapper.fetchClassInstance("fabclasses.FinSessionInit");
	 			session.setAttribute("FinSessionInit", sessInit);
	 		}
	}
 
             if(sessInit.InitializeSession(pageContext, ARJspCurr, outErrorPage) != 0)
            {
                       sNextPage = outErrorPage[0] != null ? outErrorPage[0] : "../arjspmorph/error_page.jsp"; 
                        isInitSuccessful = false;
                        
            }

 

 	  if(isInitSuccessful)

            {

                 
                       customBeanInst.Refresh(pageContext, ARJspCurr, ARJspRet);
                       customBeanInst.populateFields(finbranch, PropertyManager.getProperties(session),ResourceManager.getResourceBundle(pageContext, "finbranch"));
  

                        //String sAppNextPage = customBeanInst.procRequest();
			String sAppNextPage = " ";
                        if (null == sAppNextPage) return; 

 			 sNextPage = "/custom/paramacceptance.jsp";


                       /* sNextPage = FCCustomMapper.getCustomJSPName(ARJspCurr,sAppNextPage,session);*/

 

            }  

 
	
		String actionCode = null;
	actionCode = request.getParameter("actionCode");
	if (actionCode != null)
	{
		 
		ARJspCurr.setInput("actionCode",actionCode);
		if(actionCode.equals("setValues"))
		{
			Enumeration names = request.getParameterNames();
            		while(names.hasMoreElements())
            		{
               		 	String sName = (String)names.nextElement();
               		 	String sValue = request.getParameter(sName);
                		ARJspCurr.setInput(sName,sValue);
            		}
		 }
		String sAppNextPage = customBeanInst.procRequest();
		                       
	} 
	
	
%>

<HTML>
<HEAD>

<% if (null != sBaseHref) { %>
<base href="<%=sBaseHref + sFinContextPath + "/custom/"%>">
<% } %>

<TITLE>Workflow- Parameter Acceptance Form </TITLE>
<META http-equiv="Content-Type" content="text/html;charset=utf-8">
<LINK href="../Renderer/stylesheets/services.css" rel=STYLESHEET  title="Finacle Stylesheet" type=text/css />
<custom:mbuild/>
<script language="javascript" src="../Renderer/javascripts/finbranchResource_INFENG.js" > </script>
<script language="javascript" src="../Renderer/custom/samples/custfetch/custom_functions.js" > </script>
<script language="javascript" src="../Renderer/javascripts/header_link.js" > </script>
<script language="javascript">

	function pressSubmit()
	{
		document.frm.actionCode.value = "setValues";
    	document.frm.submit();
	}

    function pressOK()
		{
			document.frm.actionCode.value = "endWorkflow";
    	    document.frm.submit();
		}


	function fnClear()
	{
		formReset(document.frm);
	}

</script>
</HEAD>
<BODY class="cbody">
<form method="post" class="cform" name="frm" action="../custom/paramacceptance.jsp">
<%@ include file="../javascripts/appl_inc.js"%>
<%@ include file="../javascripts/header.js"%>
<%  	String populated = (String)ARJspCurr.getInput("values",null); 
	 
%>

<table width=80% align=center class="htable">
    <thead>
        <tr>
            <th class="ccaption">Parameter Acceptance Form</th>
        </tr>
    </thead>
</table>
<%

	if(populated == null || populated==""){ %>

<table width=80% align="center" class="ctable">
         <tbody>

	            <tr colspan=6 class="ctext">
	   			 <TD width=25% align=left>
	   			     Account Id
	   			  </TD>
	   			  <TD width=25% align=left>
	   				<INPUT TYPE="text" name="custom.cifId" id="cifId" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">
	   			   </TD>
	   		</tr>

	            <tr colspan=6 class="ctext">
	   	               	<TD width=25% align=left>
	   	    			Account Name
	   	    		</TD>
	   	    		<TD width=25% align=left>

	   	    			<INPUT TYPE="text" name="custom.acctName" id="acctName" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">
	   	    		</TD>
	   		</tr>

	   		<tr colspan=6 class="ctext">

	   		 <TD width=25% align=left>
	   			Account ShortName
	   		</TD>
	   		<TD width=25% align=left>
	   		<INPUT TYPE="text" name="custom.acctShortName" id="acctShortName" size="15" onblur="javascript:{this.value = this.value.toUpperCase();}">

	   		</TD>
	         </tr>
	   	     <tr colspan=6 class="ctext">
	                  	<TD width=25% align=left>
	                              Location Code
	                   </TD>
	   		<TD width=25% align=left>

	   			<INPUT TYPE="text" name="custom.locationCode" id="locationCode" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">

	   		</TD>
	   		<TD width=25% align=left>
	   			Remarks
	   	        </TD>
	   		<TD width=25% align=left>

	   			<INPUT TYPE="text" class="textfieldfont" cols="23" rows="3" name="custom.remarks" id="remarks" size="35" maxlength="240" onblur="javascript:{this.value = this.value.toUpperCase();}">

	   		</TD>

	   	     </TR>
	   	     <tr colspan=6 class="ctext">
	   	               <TD width=25% align=left>
	   	                         Contact Phone num
	   	               </TD>
	   	     		<TD width=25% align=left>

	   	     			<INPUT TYPE="text" name="custom.contactPhNum" id="contactPhNum" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">

	   	     		</TD>
	   	     		<TD width=25% align=left>
	   	     			 Withhold Tax Floor Limit
	   	     	        </TD>
	   	     		<TD width=25% align=left>

	   	     			<INPUT TYPE="text" name="custom.wtaxFloorLim" id="wtaxFloorLim" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">
	   	      		</TD>

	   	     </TR>

	   	      <tr colspan=6 class="ctext">
	   			<TD width=25% align=left>
	   					Max Allowed Limit

	   			 </TD>
	   			<TD width=25% align=left>

	   				<INPUT TYPE="text" name="custom.maxAlwdLimit" id="maxAlwdLimit" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">

	   			</TD>
	   				<TD width=25% align=left>
	   					Transaction Remarks
	   				</TD>
	   				<TD width=25% align=left>

	   					<INPUT TYPE="text" name="custom.tranRmks" id="tranRmks" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">

	   				</TD>

	   	     </TR>
	   	     <tr colspan=6 class="ctext">
	   	     	     	                <TD width=25% align=left>
	   	     	     	     	         Reference Number

	   	     	     	                 </TD>
	   	     	     	         	<TD width=25% align=left>

	   	     	     	        		<INPUT TYPE="text" name="custom.refNum" id="refNum" size="3" onblur="javascript:{this.value = this.value.toUpperCase();}">

	   	     	     	       		</TD>


	   	     </TR>


	</tbody>
</table>
<table width=80% align="center" class="ctable">

 <TR>
			<TD colspan="3" align="center">
				<INPUT TYPE="BUTTON" CLASS="button" VALUE=ACCEPT onClick="pressSubmit()">
				&nbsp;&nbsp;&nbsp;
				<INPUT TYPE=RESET CLASS="button" VALUE="Clear" onClick="fnClear()">
			</TD>
</TR>
<%}else{%>
	<table width=80% align="center" class="ctable">
	        <tbody>

		     <tr colspan=6 class="ctext">

	          The Values entered will be populated in relevant screens

        	     </TR>


		</tbody>
 <TR>
			<TD colspan="3" align="center">
			<INPUT TYPE="BUTTON" CLASS="button" VALUE=OK onClick="pressOK()">
</TD>
</TR>
</table>

 <%}%>
    <input type="Hidden" name="actionCode">


</FORM>
</BODY>
</HTML>

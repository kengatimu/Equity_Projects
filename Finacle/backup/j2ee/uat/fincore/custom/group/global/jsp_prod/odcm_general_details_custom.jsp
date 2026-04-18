<!------------------------------------------------------------------------------------------------>
<!--    Name            :       odcm_general_details_custom.jsp				     -->
<!--    Menu            :       ODCM								     -->
<!--    Author          :       									     -->
<!--    Description     :       									     -->
<!--    Modification History                                                                    -->
<!--    <Serial No> <Date>          <Author>        <Description>                               -->
<!--    1           10-Jul-2013     Venki 	    	Fix for 357258                          -->
<!------------------------------------------------------------------------------------------------>

<%@ page import="com.infy.bbu.jsputil.*" %>
<%@ page import="com.infy.finbranch.groups.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.infy.bbu.jsputil.*,FABProcess.*,FABCommon.*,FABInquiry.*,java.util.*, java.lang.*"%>
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>

<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script language="javascript">
function odcm_general_details_pre_TAB_SWITCH()
{
  if(mopId == "ODCM")
  {		
	setFieldsToCustomData("dcAvailValAmt");
  }
}
</script>

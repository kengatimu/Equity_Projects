<!------------------------------------------------------------------------------------------------>
<!--    Name            :       idcm_criteria_custom.jsp                                        
<!--    Menu            :       IDCM                                                    
<!--    Author          :       Priya K                                               
<!--    Description     :       cifId values is being set to get it in details page        
<!--    Modification History                                                                    
<!--    <Serial No>  <Date>          <Author>        <Description>                               
<!--    1            10-Jul-2013     Priya K            Original Version                           
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

function idcm_criteria_pre_ONCLICK(obj)
{
        setFieldsToCustomData("cifId");
        return true;
}
</script>

<%@ page import="applcommon.ParseValue" %>
<%@ page import="finbranchUtil.CustomMultiRecHandler2"%>
<%@ page import="finbranchUtil.CustomMultiRecHandlerInfo"%>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<arjsp:init groupName="Customize" isEntryPoint="false" />



<%
		String sCustMultiRecName1 ="custMRH1";
		finbranchUtil.CustomMultiRecHandler2 custMrh1 = (finbranchUtil.CustomMultiRecHandler2)ARJspCurr.getInputWithGroup(sCustMultiRecName1,null);
		if(custMrh1 == null) {
				custMrh1 = new finbranchUtil.CustomMultiRecHandler2();
				finbranchUtil.CustomMultiRecHandlerInfo m1 = new finbranchUtil.CustomMultiRecHandlerInfo();
				m1.setIsInGroup(true);
				m1.setMultiRecName(sCustMultiRecName1);
				m1.setRecordsPerPage(5);
				m1.setMultiRecType("L");
				m1.setPageName("hoccm_det1");
				m1.setContextManager(ARJspCurr);
				m1.setAddDisableModes(new String[] {"D","I","U","V"});

				custMrh1.setMultiRecHandlerInfo(m1);
				String arrCustOutPut1[][]=
				{
						{"d1CrAmt","text","Y"},
						{"d1AcctFreetext1","text","Y"},
						{"d1AcctFreetext2","text","Y"},
				};
				custMrh1.setOutPutArr(arrCustOutPut1);
				ARJspCurr.setInputWithGroup(sCustMultiRecName1,custMrh1);
				custMrh1.prepareCustDataMap();
				custMrh1.callCustomMultiRecHandler();
		}

		String sFuncCode1 = (String)ARJspCurr.getInputWithGroup("funcCode","");
		custMrh1.getMultiRecHandlerInfo().setFunctionCode(sFuncCode1);

%>




<script language="javascript">
	var sMultiRecName1 	= "<%=ParseValue.checkString(sCustMultiRecName1)%>";
</script>

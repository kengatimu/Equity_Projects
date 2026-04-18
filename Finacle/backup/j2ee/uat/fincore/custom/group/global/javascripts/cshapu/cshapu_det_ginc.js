<%-- Generated from spec file --%>

<%
	String sGrpName = ARJspCurr.getCurrentGroup(); 
	String sPopUpExceptionWindow = (String)ARJspCurr.getInput(sGrpName+".PopUpExceptionWindow" ,"false");
	String sReferralMode = (String)ARJspCurr.getInput("refSubMode" ,"");
	ARJspCurr.setInput(sGrpName+".PopUpExceptionWindow","false");
%>
<script>

	var groupName = '<%=ParseValue.checkString(ARJspCurr.getCurrentGroup())%>';
	var employerId = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("employerId",""))%>';
    var clientNames = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("clientNames",""))%>';
	var employerIdDesc = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("employerIdDesc",""))%>';
	var debitAcctNo = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("debitAcctNo",""))%>';
	var debitAcctName = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("debitAcctName",""))%>';
	var debitAcctCcy = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("debitAcctCcy",""))%>';
	var debitAcctSolId = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("debitAcctSolId",""))%>';
	var debitAcctschmType = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("debitAcctschmType",""))%>';
	var valueDate = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("valueDate",""))%>';
	var glDate = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("glDate",""))%>';
	var referenceNo = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("referenceNo",""))%>';
	var refSolId = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("refSolId",""))%>';
	var tranId = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranId",""))%>';
	var tranDate = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranDate",""))%>';
	var partTranSrlNo = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("partTranSrlNo",""))%>';
	var tranRemarks = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranRemarks",""))%>';
	var placeLienFlg = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("placeLienFlg",""))%>';
	var operAcctNo = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("operAcctNo",""))%>';
	var operAcctName = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("operAcctName",""))%>';
	var operAcctCcy = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("operAcctCcy",""))%>';
	var operAcctSolId = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("operAcctSolId",""))%>';
	var operAcctschmType = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("operAcctschmType",""))%>';
	var creditAmt = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("creditAmt",""))%>';
	var creditCrcyCode = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("creditCrcyCode",""))%>';
	var tranParticulars = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranParticulars",""))%>';
	var delFlg = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("delFlg",""))%>';
	var expOperAcctNo = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("expOperAcctNo",""))%>';
	var expCreditAmt = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("expCreditAmt",""))%>';
	var expCreditCrcyCode = '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("expCreditCrcyCode",""))%>';
	var sPrntDtGroupName = '<%=ParseValue.checkString(ARJspCurr.getCurrentGroup())%>';
	var BODDate = '<%=ParseValue.checkString(sBODDate)%>';
	var format = '<%=ParseValue.checkString(format)%>';
	var serialNo = '<%=ParseValue.checkString(iSerialNo)%>';
	var multiRecName = '<%=ParseValue.checkString(sMultiRecName)%>';
	var sPopUpExceptionWindow = '<%=sPopUpExceptionWindow%>' ;
	var sReferralMode = '<%=sReferralMode%>' ;

	var sTotalAmount= '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("Totamt",""))%>';
	var hTotalAmount=  '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("hTotalAmount",""))%>';
    var Totamt=  '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("Totamt",""))%>';


	var tranid=  '<%=ParseValue.checkString(ARJspCurr.getInputWithGroup("tranid",""))%>';
	



	
</script>

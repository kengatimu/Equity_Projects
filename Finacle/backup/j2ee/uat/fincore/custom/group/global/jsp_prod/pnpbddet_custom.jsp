<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : pnpbddet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : 28-06-2013
<!--Author            : jane
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HBPAD
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		28-06-2013	jane		Original version
<!---------------------------------------------------------------------------------------------------------------->
<script>
function fnOnChangebillAmtPymtMode()
{
	if(objForm.billAmtPymtMode.value =='R')
	{
		objForm.chargeAmtInBillCur.value=sTotalChrgCCAmt;
		objForm.totalChrgAmt.value=sTotalChrgCCAmt;
	}
	else
	{
		objForm.chargeAmtInBillCur.value=sTotalChrgAmt;
		objForm.totalChrgAmt.value=sTotalChrgAmt;
	}
	if((objForm.payNow.value=="N" ) || isEmptyObjValue(objForm.billAmtPymtMode.value))
		hideImage("sLnk2");
	else
		showImage("sLnk2");
	if(objForm.chargeAmtInBillCur.value== getAmtInCustomFormat("0.00"))
		hideImage("sLnk2");
	if(objForm.billAmtPymtMode.value =='R')
		objForm.chargeAmtInBillCur.value=sTotalChrgCCAmt;
	else
		objForm.chargeAmtInBillCur.value=sTotalChrgAmt;
	if(objForm.payNow.value=="N" && (objForm.billAmtPymtMode.value == 'C' || objForm.billAmtPymtMode.value == 'L'))
	{
		if(funcCode != 'S')
		{
			objForm.scheduledate.value = sBODDate;
			if(objForm.billAmtPymtMode.value == 'L')
				addDayMonthsToDate(document.forms[0].scheduledate,smonth,sclearingfloatdays,document.forms[0].scheduledate);
			if(objForm.billAmtPymtMode.value == 'C')
			{
				if((templateMode == "Y") && (tempFuncCode != "M") && (tempFuncCode != "A") && (tempFuncCode != "C"))
				{
				    objForm.pymtCrncyCode.disabled = true;
					hideImage("sLnk3");
				}
				else
				{
					enableFields("pymtCrncyCode");
					showImage("sLnk3");
				}
			}
			fnEnableDisablePay();
			fnSchDateDisableEnable();
		}
	}
	if( objForm.chkwaiveChrgFlg.checked == false && !((((funcCode == 'A')||(funcCode == 'T')) && (payerChrgCollnFlg == "N"|| payerChrgCollnFlg == "R")) || ((funcCode == 'P' || funcCode == 'S' || funcCode == 'M') && (payerChrgCollnFlg == "N"|| payerChrgCollnFlg == "P"))))
	{

		if (objForm.billAmtPymtMode.value != 'L' )
			objForm.chrgAmtPymtMode.selectedIndex=objForm.billAmtPymtMode.selectedIndex;
		else
			objForm.chrgAmtPymtMode.value='C';
	}
	else
		objForm.chrgAmtPymtMode.value='';

	if ((objForm.billAmtPymtMode.value == 'R' && objForm.payNow.value == "Y") || objForm.billAmtPymtMode.value == 'L')
		objForm.scheduledate.value = sBODDate;

	if(objForm.billAmtPymtMode.value == 'R' && objForm.payNow.value != "Y")
	{

		objForm.scheduledate.value = sBODDate;
		addDayMonthsToDate(objForm.scheduledate,smonth,sccfloatdays,objForm.scheduledate);
	}
	if(objForm.billAmtPymtMode.value == 'L')
	{
		addDayMonthsToDate(document.forms[0].scheduledate,smonth,sclearingfloatdays,document.forms[0].scheduledate);
	}
	if(objForm.payNow.value=="N" && objForm.billAmtPymtMode.value == 'T')
		objForm.scheduledate.value = sBODDate;

	fnSchDateDisableEnable();
	fnonBlur();
	fnEnableDisablePay();
	minpaymentadd();
	fnOnChangebillAmt();
}



function pnpbddet_post_ONLOAD(obj)
{
//alert("am in");
document.forms[0].chkwaiveChrgFlg.disabled=true;

}

function pnpbddet_ONCHANGE(obj)
{
	fnOnChangebillAmt();
}

function fnOnChangebillAmt(obj)
{
	if (document.forms[0].chkwaiveChrgFlg.value!="")
	{
	document.forms[0].chkwaiveChrgFlg.disabled=true;
	}
	
}
</script>

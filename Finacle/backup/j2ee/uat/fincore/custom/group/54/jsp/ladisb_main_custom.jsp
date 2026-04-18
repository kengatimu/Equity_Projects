<!---------------------------------------------------------------------------------------------------------------->
<!--Name		: ladisb_main_custom.jsp 
<!--Description		: This is used to set todgrant field to no and that field is made protected.
<!--Date		: 31-03-2013
<!--Author		: Saurabh 
<!--Called By		: None    
<!--Calling  Jsp	: laadisbmn001.scr
<!--Menu Option		: HLADISB
<!--Modification History:
<!--    Version No.       Date               Author             Description
<!--    -------         ----------           -----------        ------------------
<!--     0.1            31-03-2013           Saurabh            Original version
<!--     0.2            31-03-2013           Farhan            	Original version
<!--	 0.3			22-05-2013	     	 Chandrasekhar		functions are added
<!--	 0.4			13-06-2013	     	 Prashanth			added some fields to custom data
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">

//ebl start customization 


function  ladisb_main_post_ONLOAD(obj)
{
	//alert("im in");
	var radioButtons = document.getElementsByName('tranType');
	radioButtons[0].checked = false;
    radioButtons[1].checked = true;
	}

//ebl end customization 

function fnCallLoanAcctList()
{
	if(funcCode=="V" || funcCode=="X") {
        showLoanDisbVerifyPendList(objForm.acctNum,'morph','F',objForm.acctCrncy,objForm.acctSol,objForm.acctName);
        if( !(fnIsNull(objForm.acctNum.value))) {
                        if(!sendDataToServer('myframe','LOANACCTFETCH','F','acctNum|valueDate|dummy|funcCode', 'acctCrncy|acctSol|acctName|loanAmt|loanPeriodMths|loanPeriodDays|loanAmtDisb|avlForDisb|disbAmt|advIntAmount|isAdvIntAcct|nominalRate|effIntRate|schmCode|dummy|dummy|dummy|creditAcctNum|rdotranType|rdofinalDisbFlg|hldyPerdExistFlg|tranRateCode|chargeRateCode|dummy|dummy|valueDate|rdogrossNetDisb|dummy|dummy|dummy|dummy|dealerContrib|dummy|dummy|chargeFromCrncy|chargeToCrncy|chargeRate|chargeTresRate|tresRefNum|reversalTranId|reversalRemarks|glDate|overDueDeductFlg|marginMoneyAmt|retentionAmt|builderProfitAmt|retentionReleaseFlg'))
                        {
                                objForm.acctNum.value = "";
                                clearDescField('acctCrncy','acctSol','acctName');
                        }
                        fnSetCheckboxCtrl(objForm);
                        fnAssignDateOnLoad(objForm);
                        if(!(fnIsNull(objForm.disbAmt.value))){
                var payout_Amt;
        payout_Amt = getAmtInFloat(objForm.marginMoneyAmt.value) + getAmtInFloat(objForm.disbAmt.value);
        payout_Amt = payout_Amt * 100 ;
        payout_Amt = Math.round(payout_Amt);
        payout_Amt = (payout_Amt)/100;
        objForm.payoutAmt.value=getAmtInCustomFormat(new String(payout_Amt));
        objForm.netPayoutAmt.value = getAmtInFloat(objForm.payoutAmt.value) - getAmtInFloat(objForm.retentionAmt.value) - getAmtInFloat(objForm.builderProfitAmt.value);
                }
                }

    }
    else    {
        getLaAcctDetails(objForm.acctNum,objForm.acctSol,objForm.acctName,"F",objForm.acctCrncy);
    }
    newformatAmt(format, objForm.loanAmt, objForm.acctCrncy.value, "N");
    newformatAmt(format, objForm.loanAmtDisb, objForm.acctCrncy.value, "N");
    newformatAmt(format, objForm.avlForDisb, objForm.acctCrncy.value, "N");
    newformatAmt(format, objForm.disbAmt, objForm.acctCrncy.value, "N");
        newformatAmt(format, objForm.marginMoneyAmt, objForm.acctCrncy.value, "N");
    newformatAmt(format, objForm.payoutAmt, objForm.acctCrncy.value, "N");
    newformatAmt(format, objForm.retentionAmt, objForm.acctCrncy.value, "N");
    newformatAmt(format, objForm.builderProfitAmt, objForm.acctCrncy.value, "N");
    newformatAmt(format, objForm.netPayoutAmt, objForm.acctCrncy.value, "N");
	memoPad();
	//ebl customization start 359926
	finalDisb();
	
	//ebl customization end 359926
}
function memoPad(){
        var acctNumber = document.forms[0].acctNum.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}			var loanAmt		= document.forms[0].loanAmt.value;
function ladisb_main_pre_ONCLICK(obj) 
{

	if (mopId == "HLADISB" )
	{
		//cate reversal remarks 358960

		if (funcCode == "R" )
		{
			if ( obj.id == "accept")
			{
			if(document.forms[0].reversalRemarks.value=="")
				{
					alert("Enter reversal Remarks");
					document.forms[0].reversalRemarks.focus();
					return false;
				}
				//jane start 362214
				setFieldsToCustomData("funcCode","acctNum");
				//jane end 362214
			}
		}

		//cate end reversal remarks 358960
		

		if (funcCode == "D" )
		{
			
			if ( obj.id == "accept")
			{
			
			if(document.forms[0].acctNum.value=="")
				{
					alert("Enter account ID");
					document.forms[0].acctNum.focus();
					return false;
				}
				setFieldsToCustomData("funcCode","acctNum","loanAmtDisb","disbAmt");
				//alert(document.forms[0].customData.value);
				var loanAcctId		= document.forms[0].acctNum.value;
				var disbAmt		= document.forms[0].disbAmt.value;
				var loanAmt		= document.forms[0].loanAmt.value;
				var avlForDisb		= document.forms[0].avlForDisb.value;
				var inputNameValues	= "loanAcctId|"+loanAcctId+"|disbAmt|"+disbAmt+"|loanAmt|"+loanAmt+"|avlForDisb|"+avlForDisb;
				var outputNames		= "";
				var scrName		= "laadisbmn001.scr";
				var retVal		= appFnExecuteScript(inputNameValues, outputNames, scrName, false);
				var ret = retVal.split("|");
				if( ret[0] == "Error" && ret[1] != "dummy" )
				{
					alert(ret[1]);
					return false;
				}
				else 
				{
					if (ret[2] == "tranType" && ret[3]=="T" )
					{
						var radioButtons = document.getElementsByName('tranType');
						radioButtons[0].checked = false;
						radioButtons[1].checked = true;
					}
					
					if (ret[4] == "grossNetDisb" && ret[5]=="G")
					{
						var radioButtons = document.getElementsByName('grossNetDisb');
						radioButtons[0].checked = true;
						radioButtons[1].checked = false;
					}
					
					if (ret[6] == "tranTypeAttr" && ret[7]=="P")
					{
						var radioButtons = document.getElementsByName('tranType');
						radioButtons[0].disabled = true;
						radioButtons[1].disabled = true;
					}
				}
			var dco = document.forms[0].acctNum.value;
			//alert(dco);
			var input      = "dco|"+dco;
			var outputNames    = "output|outVal";
			var scrName     =   "b_loanval.scr";
			var retVal = appFnExecuteScript(input,outputNames,scrName,false);
			var retBuff = retVal.split("|");
			var output = retBuff[0];
			var value = retBuff[1];
			var stgcompflg = value;
			//alert(stgcompflg);
			if (stgcompflg=="N")
			{
				alert("First do valuation for this stage");
				document.forms[0].acctNum.focus();
				return false;
			}

			}
		}   
	}
}

function  ladisb_main_post_ONCHANGE(obj) {
if(obj.id == "acctNum") {
	
	var inputNameValues = "acctNum|"+obj.value;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" )
        {
                alert(ret1[1]);
        }
	//ebl customization start 359926
	finalDisb();

	//ebl customization end 359926

	return true;
}
}
//ebl customization start 359926 
function finalDisb()
{
	var radioButtons = document.getElementsByName('finalDisbFlg');
	radioButtons[0].checked = false;
    radioButtons[1].checked = true;
	
}
//ebl customization end 359926

	

</script>

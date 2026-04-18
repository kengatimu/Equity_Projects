<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
                if(fnIsNull(document.forms[0].custtrantype.value)){
                    alert("Select Transaction Type");
                    document.forms[0].custtrantype.focus();
                    return false;
                }	

                if(fnIsNull(document.forms[0].benefCrncy.value)){
                    alert("Enter Beneficiary Currency Code");
                    document.forms[0].benefCrncy.focus();
                    return false;
                }
				
                if(fnIsNull(document.forms[0].custtranmode.value)){
                    alert("Select Transfer to");
                    document.forms[0].custtranmode.focus();
                    return false;
                }	
                if(fnIsNull(document.forms[0].APIMode.value)){
                    alert("Select System Mode to Transact");
                    document.forms[0].APIMode.focus();
                    return false;
                }	
				
				if((document.forms[0].custtranmode.value) == "BANK"){
					//if(((document.forms[0].custtrantype.value) =="C2C") ||((document.forms[0].custtrantype.value) =="P2P")){
					//	alert("Bank Transfer not allowed for C2C and P2P");
					//	document.forms[0].benefMobileNum.focus();
					//	return false;	
					//}							
					if(fnIsNull(document.forms[0].bbankCode.value)){
						alert("Enter Beneficiary Bank Bic Code");
						document.forms[0].bbankCode.focus();
						return false;
					}
					//if(fnIsNull(document.forms[0].bbrCode.value)){
					//	alert("Enter Beneficiary Branch Code");
					//	document.forms[0].bbrCode.focus();
					//	return false;
					//}	
					if(fnIsNull(document.forms[0].orgpin.value)){
						alert("Enter OrgPin Code");
						document.forms[0].orgpin.focus();
						return false;
					}
					if(fnIsNull(document.forms[0].orgregnum.value)){
						alert("Enter OrgRegNum Code");
						document.forms[0].orgregnum.focus();
						return false;
					}
				}
                
				if((document.forms[0].custtranmode.value) == "WALLET"){
					if(fnIsNull(document.forms[0].bicWallet.value)){
						alert("Enter BicWallet Value");
						document.forms[0].bicWallet.focus();
						return false;
					}
					if(((document.forms[0].custtrantype.value) =="C2B") ||((document.forms[0].custtrantype.value) =="P2B") ||((document.forms[0].custtrantype.value) =="B2B") ){
						alert("Wallet Transfer not allowed for C2B, B2B and P2B");
						document.forms[0].benefMobileNum.focus();
						return false;	
					}
				}
	
		        if(isNaN(document.forms[0].benefMobileNum.value)){
                    alert("Enter valid mobile number");
                    document.forms[0].benefMobileNum.focus();
                    return false;
                }	
/*
		        if(isNaN(document.forms[0].benefAcctNum.value)){
                    alert("Enter valid beneficiary account number");
                    document.forms[0].benefAcctNum.focus();
                    return false;
                }							
*/
				
                if(fnIsNull(document.forms[0].Dracno.value)){
                    alert("Enter Debit Account Number");
                    document.forms[0].Dracno.focus();
                    return false;
                }
                if(fnIsNull(document.forms[0].refCrncy.value)){
                    alert("Enter Tran Currency Code");
                    document.forms[0].refCrncy.focus();
                    return false;
                }
                if(fnIsNull(document.forms[0].refAmt.value)){
                    alert("Enter Tran Amount");
                    document.forms[0].refAmt.focus();
                    return false;
                }
				
				if(funcCode == "A")
				{
					if(fnIsNull(document.forms[0].BenDOB.value)){
						alert("Enter Beneficiary Date of Birth");
						document.forms[0].BenDOB.focus();
						return false;
					}	
				}
                if(fnIsNull(document.forms[0].benID.value)){
                    alert("Enter Beneficiary ID");
                    document.forms[0].benID.focus();
                    return false;
                }						
			/*  
                if(fnIsNull(document.forms[0].TranParticulars.value)){
                        alert("Enter Transaction Particulars");
                        document.forms[0].TranParticulars.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].TranRemarks.value)){
                        alert("Enter Transaction Remarks");
                        document.forms[0].TranRemarks.focus();
                        return false;
                }
                
                if(fnIsNull(document.forms[0].ChargeType.value)){
                        alert("Enter Charge Event Id");
                        document.forms[0].ChargeType.focus();
                        return false;
                }
			*/  
                if(fnIsNull(document.forms[0].benefFName.value)){
                        alert("Enter Beneficiary Name");
                        document.forms[0].benefFName.focus();
                        return false;
                }
                if(!isNaN(document.forms[0].benefFName.value)){
                        alert("Beneficiary First Name Should be Alphabet");
                        document.forms[0].benefFName.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].benefLName.value)){
                        alert("Enter Beneficiary Name");
                        document.forms[0].benefLName.focus();
                        return false;
                }
                if(!isNaN(document.forms[0].benefLName.value)){
                        alert("Beneficiary Last Name Should be Alphabet");
                        document.forms[0].benefLName.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].benefAcctNum.value)){
                        alert("Enter Beneficiary Account Number");
                        document.forms[0].benefAcctNum.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].benefMobileNum.value)){
                        alert("Enter Beneficiary Mobile Number");
                        document.forms[0].benefMobileNum.focus();
                        return false;
                }
                
                if(fnIsNull(document.forms[0].benefBnkTel.value)){
                        alert("Enter Beneficiary Email id");
                        document.forms[0].benefBnkTel.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].benefCntry.value)){
                        alert("Enter Beneficiary Country");
                        document.forms[0].benefCntry.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].purOfRemit.value)){
                        alert("Enter Purpose of Remittance");
                        document.forms[0].purOfRemit.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].benefState.value)){
                        alert("Enter Beneficiary State");
                        document.forms[0].benefState.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].BenefAddress1.value)){
                        alert("Enter Beneficiary Address1");
                        document.forms[0].BenefAddress1.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].BenefAddress2.value)){
                        alert("Enter Beneficiary Address2");
                        document.forms[0].BenefAddress1.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].BenefAddress3.value)){
                        alert("Enter Beneficiary Address3");
                        document.forms[0].BenefAddress3.focus();
                        return false;
                }
                if(fnIsNull(document.forms[0].PostalCode.value)){
                        alert("Enter Beneficiary Postal Code");
                        document.forms[0].PostalCode.focus();
                        return false;
                }
		if(document.forms[0].custtrantype.value=="B2B"){
			if(fnIsNull(document.forms[0].BrnIfscBsbn.value)){
				alert("Enter Beneficiary BranchNumber/IFSC Code/BSB Number");
				document.forms[0].BrnIfscBsbn.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].benefAcctType.value)){
				alert("Enter Beneficiary Account Type");
				document.forms[0].benefAcctType.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].benefIdType.value)){
				alert("Enter Beneficiary ID Type");
				document.forms[0].benefIdType.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].RecvBusName.value)){
				alert("Enter Receiving Business Name");
				document.forms[0].RecvBusName.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].RecvBusRegNum.value)){
				alert("Enter Receiving Business Registration Number ");
				document.forms[0].RecvBusRegNum.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].RecvBusAddr.value)){
				alert("Enter Receiving Business Address");
				document.forms[0].RecvBusAddr.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].RecvBusCity.value)){
				alert("Enter Receiving Business City");
				document.forms[0].RecvBusCity.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].RecvBusDtInc.value)){
				alert("Enter Receiving Business Date of Incorporation");
				document.forms[0].RecvBusDtInc.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].SendBusName.value)){
				alert("Enter Sender Business Name");
				document.forms[0].SendBusName.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].SendBusRegNum.value)){
				alert("Enter Sender Business Registration Number ");
				document.forms[0].SendBusRegNum.focus();
				return false;
			}
			if(fnIsNull(document.forms[0].SendBusDtInc.value)){
				alert("Enter Sender Business Date of Incorporation");
				document.forms[0].SendBusDtInc.focus();
				return false;
			}

		}
		if(fnIsNull(document.forms[0].benDOB_ui.value)){
			alert("Enter Beneficiary Date of Birth");
			document.forms[0].benDOB_ui.focus();
			return false;
		}else{
			//alert(document.forms[0].benDOB_ui.value);	
			var d1 = new Date(document.forms[0].benDOB_ui.value); 
			var d2 = new Date(); 
			var diff = d2.getTime() - d1.getTime(); 
			if(diff<1){
				alert("Beneficiary date of birth should be atleast 1 Year");
				return false;
			}
		}
				
				
                
		//alert(document.forms[0].custtrantype.value);
		//alert("su");
		return true;
}
function getRefCrncyList(){
        var ObjForm = document.forms[0];
        var oldValue = ObjForm.refCrncy.value;
        var retVal = popModalWindow("../arjspmorph/"+applangcode+"/get_currency.jsp?wReturn=refCrncy&Currency="+oldValue,"CurrencyList");
        if (retVal != null) {
                var j = retVal.split("|");
                ObjForm.refCrncy.value = j[0];
                ObjForm.refAmt.focus();
                fnComputeTranAmt(ObjForm.refCrncy);
        }
}
function fnFormatAmountField(obj){
	//alert("format");
        var p1 = removeCommas(obj.value);
        var ObjForm = document.forms[0];
        var amountFormat = "Million";
        var crncyCode = "";
        crncyCode = ObjForm.targetCcy.value;
        if(obj.id == "refAmt"){
                if(fnIsNull(p1)){
                        fnClearAmtFields();
                        return false;
                }
                crncyCode = ObjForm.refCrncy.value;
        }
        var retValue = ""
        retValue = newformatAmt(amountFormat,obj,crncyCode,'N');
        if(retValue == false){
                return false;
        }
        p1 = removeCommas(obj.value);
        if(parseFloat(p1) <= parseFloat("0")){
                alert("Amount should be greater than zero");
                fnClearAmtFields();
                setFieldFocus(ObjForm.refAmt);
                return false;
        }
        if(fnIsNull(ObjForm.refCrncy.value)){
                ObjForm.refCrncy.focus();
                return false;
        }
        return true;
}
function fnRemoveCommas(){
        var ObjForm = document.forms[0];
        var refAmt = ObjForm.refAmt.value;
        refAmt = removeCommas(refAmt);
        ObjForm.refAmt.value = refAmt;
}
function fnClearAmtFields(){
        var ObjForm = document.forms[0];
        ObjForm.refAmt.value = "";
        ObjForm.refCrncy.value = "";
        return true;
}
function fnGetDraweeBankList(){
	listBankCodes('N',document.forms[0].bbankCode,'F',document.forms[0].bankCodeDesc);
	fnFetchDraweeBranchDetails();
}
//function fnGetDraweeBranchCode(){
//	showBranchCodes(document.forms[0].bbankCode,document.forms[0].bbrCode,'ctrl','F',document.forms[0].brCodeDesc);
//	fnFetchDraweeBranchDetails();
//}
//function fnFetchDraweeBranchDetails(){
//	var objForm = document.forms[0];
//	if ((!fnIsNull(objForm.bbankCode.value))&&(!fnIsNull(objForm.bbrCode.value))){
//		var rtn = sendDataToServer('myframe','FBMBRANCHCODE','F','bbankCode|bbrCode','');
//	}
//	if (rtn == false){
//		fnClearDBank1Flds();
//		objForm.bbrCode.focus();
//	}else if(fnIsNull(objForm.bbrCode.value))
//		  fnClearDBank1Flds();                              
//}
function fnClearDBank1Flds(){
   document.forms[0].brCodeDesc.value="";
}
function fnDisableFormDataControls(b, f, d) {
    ADD = "A";
    POST = "P";
    COPY = "C";
    MODIFY = "M";
    VERIFY = "V";
    INQUIRY = "I";
    DELETE = "D";
    UNDELETE = "U";
    CANCEL = "X";
    REVERSAL = "E";
    CLOSE = "O";
    if (b == VERIFY || b == INQUIRY || b == DELETE || b == UNDELETE || b == CANCEL || b == REVERSAL || b == CLOSE || b == POST) {
	alert(b);
        var c = f.elements;
        var a = c.length;
        var e = arguments.length;
        if (Number(d) > 0) {
            disableHyperLnks(Number(d))
        } else {
            if (Number(d) == 0) {
                hideAnchors()
            }
        }
        for (i = 0; i < a; i++) {
            if ((c[i].type == "text") || (c[i].type == "textarea")) {
                c[i].readOnly = true;
                if (c[i].getAttribute("hotKeyId") == "LowLimit") {
                    c[i].readOnly = false
                }
            } else {
                if (c[i].type == "select-one") {
                    c[i].disabled = true
                } else {
                    if (c[i].type == "checkbox") {
                        c[i].disabled = true;
                        c[i].setAttribute("fds", "Y")
                    } else {
                        if (c[i].type == "radio") {
                            c[i].disabled = true
                        }
                    }
                }
            }
            if (f.menuName != null && f.menuName != undefined) {
                f.menuName.readOnly = false
            }
        }
        if ((f.Validate != undefined) && (f.Validate != null)) {
            f.Validate.disabled = true
        }
        if ((f.Cancel != undefined) && (f.Cancel != null)) {
            f.Cancel.disabled = true
        }
    }
    if (b != ADD && b != MODIFY && b != COPY) {
        if ((f.AddNew != undefined) && (f.AddNew != null)) {
            f.AddNew.disabled = true
        }
        if ((f.AddNewPage != undefined) && (f.AddNewPage != null)) {
            f.AddNewPage.disabled = true
        }
    }
}
function getRateCodeList() {
        var frm = document.forms[0];
        rateCode = frm.rateCode.value;
        var retVal = popModalWindow("../arjspmorph/"+applangcode+"/rate_codes.jsp?wReturn=document.forms[0].rateCode&DebitCrncy="+frm.drAcctNumCcy.value+"&CreditCrncy="+frm.refCrncy.value,"RateCodes");
        if(retVal != null){
                frm.rateCode.value = retVal;
                frm.rate.value = "";
                //fnComputeTranAmt(frm.rateCode);^M
        }
}




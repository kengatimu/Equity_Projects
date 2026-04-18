<!--    This is getting executing on click of submit and validate button -->
var crncy;
var sysAmt;
var usrAmt;
var chrgPart;
var isMod;
var clicked = "N";


// Changes done for CR - 358474
function hcashdx_det_pre_ONCLICK(objBtn){

        if(objBtn.id == "Submit"){
                 amlChk();
                                var inputNameValues = "funcCode|A";
                var outputNames     = "";
                var scrName         = "tranvaldp003.scr";
                var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
                var token = retVal.split("|");
                if(token != undefined){
                var errorMsg = token[1];
                var errorMsgRef = token[3];
                if(!fnIsNull(errorMsg)){
                       alert(errorMsg);
                       return false;
                }
                if(!fnIsNull(errorMsgRef)){
                       alert(errorMsgRef);
                       return false;
                }
                }

                if (mop_id = "HCASHDX"){
                        var     frm=document.forms[0];
                        //alert(document.forms[0].custName.value);

                        var input = "acctCrncy|" + frm.acctCrncy.value + "|refCrncy|" + frm.refCrncy.value + "|receivedAmt|" + frm.receivedAmt.value
                        + "|" +"custName|" + frm.custName.value + "|idNum|" + frm.idNum.value
                        + "|" + "phoneNo|" + frm.phoneNo.value + "|docDetails|" + frm.docDetails.value + "|nationDet|" + frm.nationDet.value + "|treaRefNum|" + frm.treaRefNum.value;
                        var outputNames    = "output3|outVal";
                        var outputNames    = "status|outVal";
                        var scrName     =   "hcasdxcustom.scr";
                        //alert("before script");
                        var retVal = appFnExecuteScript(input,outputNames,scrName,false);
                        //alert("after script");
                                var retBuff = retVal.split("|");
                                var output = retBuff[0];
                                var value = retBuff[1];
                                var a = value;

                                var retBuff = retVal.split("|");
                                var output = retBuff[2];
                                var value = retBuff[3];
                                var b = value;

                                /*      if (frm.custName.value == "")
                                        {
                                                alert("Customer Name is mandatory");
                                                frm.custName.focus();
                                                return false;
                                        }
                                        if (frm.idNum.value == "")
                                        {
                                                alert("Id Number is mandatory");
                                                frm.idNum.focus();
                                                return false;

                                        }
                                        if (frm.phoneNo.value == "")
                                        {
                                                alert("Phone Number is mandatory");
                                                frm.phoneNo.focus();
                                                return false;
                                        }

                                        if (profileId=='56')
                                        {
                                        //      frm.nationDet.enabled = true;
                                                if (frm.docDetails.value == "")
                                                {
                                                alert("Supporting Details is mandatory");
                                                frm.docDetails.focus();
                                                return false;
                                                }
                                                if (frm.nationDet.value == "")
                                                {
                                                        alert(frm.nationDet.value);
                                                        alert("Nationality is mandatory");
                                                        frm.nationDet.focus();
                                                        return false;
                                                }
                                                else
                                                {
                                                        alert(frm.nationDet.value);
                                                }
                                        }

                                if (a == "Y")
                                {
                                        if (frm.docDetails.value == "")
                                        {
                                                alert("Supporting Details is mandatory");
                                                frm.docDetails.focus();
                                                return false;

                                        }
                                }*/
                //Below steps added for treasury rate values
                        var treaRefNum = document.forms[0].treaRefNum.value;
                        if(treaRefNum != "")
                        {
                                var rateCode = document.forms[0].rateCode.value;
                                var rate = document.forms[0].rate.value;
                                var treaRate = document.forms[0].treaRate.value;
                                var refCrncy = document.forms[0].refCrncy.value;
                                var acctCrncy = document.forms[0].acctCrncy.value;
                                var receivedAmt = document.forms[0].receivedAmt.value;
                                var inputNames = "acctCrncy|" + acctCrncy +"|refCrncy|" + refCrncy + "|rateCode|"+rateCode+"|rate|"+rate+"|treaRate|"+treaRate+"|treaRefNum|"+treaRefNum+"|tranType|C"+"|refAmt|"+receivedAmt;
                                var outputNames = "errorFlg|errorMsg";
                                var scr="cietxntreasval.scr";
                                var retVal = appFnExecuteScript(inputNames,outputNames,scr,false);
                                var result      = retVal.split("|");
                                var errorFlg      = result[1];
                                var errorMsg      = result[3];
                                if(errorFlg == "Y")
                                {
                                        alert(errorMsg);
                                        document.forms[0].treaRefNum.focus();
                                        return false;
                                }
                        }


                }


                }
        }


//End of changes


function fnValidateData() {

                if (!fnCheckMandatoryFields())
                {
                        return false;
                }
                if(!amlChk()){
                        return false;
                }
                if(!fnAccept())
                {
                        return false;
                }
                return true;
}

function getRateCodeList()
{
        var frm = document.forms[0];
        var oldCode = frm.rateCode.value;
        //showRefCode(frm.rateCode,'67','N','B');
        //showRefCode(frm.rateCode,'DD','N','F');
        showRefCode(frm.rateCode,'67','N','B');
        fnChgRateCode();
}

function showCurrcy1(obj)
{
        var frm = document.forms[0];
        showCurrency(frm.acctCrncy,'ctrl','F','','N');
        fnDfltRC(obj);
}

function showCurrcy2(obj)
{
        var frm = document.forms[0];
        showCurrency(frm.refCrncy,'ctrl','F','','N');
        fnDfltRC(obj);
}

function fnShowEvtIDList()
{
        var inputNameValues = "chargeId|";
        var outputNames = "S|output";
        var scrName = "charge_evntDetails_fetch.scr";
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
        var strMesg1 = retVal.split("|");
                if(strMesg1[0] == "S")
                {
                        document.forms[0].chrgEvntId.value = strMesg1[3];
//                      getEvtIdList(document.forms[0].chrgEvntId, 'ctrl','F', 'NULL',' ','Y','TRANF');
                        document.forms[0].chrgEvntId.focus();
                }
                else
                {
                        document.forms[0].chrgEvntId.value = "NO CHARGES";
                        document.forms[0].chrgAmt.value = "0.0";
                        //document.forms[0].chrgAmt.disabled = true;
                        document.forms[0].chrgEvntId.disabled = true;
                        hideImage("Rsearch4");
                        hideImage("Rexplode1");
                }

        if(clicked == "N"){
                fnget_chrg(document.forms[0].chrgEvntId);
        }
}

function getChargeDetails()
{

        var frm = document.forms[0];
        convertToCaps();
        if(frm.chrgEvntId.value != "")
        {
                var inputNameValues = "groupName|hcashdx|pageName|hcashdx_popup";
                var ret =  cust_showPopUp(inputNameValues);

        }
        else
        {
                alert("Charge Event Id should be Entered");
        }


}

<!-- This function is added for formatting a particular MRH Row -->

function formatRowValue(Obj, colNumber) {

      return Obj;

       }

function fnValidate()
{
         var frm = document.forms[0];
        var amt1 = frm.receivedAmt.value;
        if((fnValidate_fields())&&(fnvalidate_received(amt1)))
        {

                //alert("test alert1");
                //alert(document.forms[0].amtFrmCcy.value);
                //alert(document.forms[0].receivedAmt.value);
                showCrncyConverterForTranMaint(frm.acctCrncy,frm.refCrncy,frm.rateCode,frm.rate,frm.amtFrmCcy);
                javascript:newformatAmt('MILLION',frm.amtFrmCcy,frm.refCrncy.value,'N');
                javascript:newformatAmt('MILLION',frm.acctCrncyAmt,frm.acctCrncy.value,'N');
                //alert("test alert2");
                //alert(document.forms[0].amtFrmCcy.value);
                //alert(document.forms[0].receivedAmt.value);
                return true;
        }
        else
                return false;
}

function fnValidate_fields()
{
        var frm = document.forms[0];
        if(frm.acctCrncy.value == "")
        {
                alert("Currency code cannot be blank,Enter a valid currency code.");
                frm.acctCrncy.focus();
                return false;
        }
        if(frm.refCrncy.value == "")
        {
                alert("Currency code cannot be blank,Enter a valid currency code.");
                frm.refCrncy.focus();
                return false ;
        }
        if(frm.rateCode.value == "")
        {
                if(frm.refCrncy.value != frm.acctCrncy.value)
                {
                        alert("RateCode cannot be left blank,Enter a valid rate code.");
                        frm.rateCode.focus();
                        return false;
                }
        }
        if(frm.refCrncy.value == frm.acctCrncy.value)
        {
                if(frm.acctCrncy.value == "")
                {
                        alert("Currency code cannot be blank,Enter a valid currency code.");
                        frm.acctCrncy.focus();
                        return false;
                }
        }



        var acctCrncy = frm.acctCrncy.value;
        var refCrncy = frm.refCrncy.value;
        var RateCode = frm.rateCode.value;
        var scrName = "denomdp009.scr";
        var outputNames = "";
        var inputNameValues = "RateCode|"+RateCode
                                                 +"|acctCrncy|"+acctCrncy
                                                 +"|refCrncy|"+refCrncy;
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
        var values = retVal.split("|");
        if(values[0] == "Success")
        {
                return true;
        }
        else
        {
                var val = values[1].split("&");
                if (val[0] == "FROM")
                {
                                                alert(val[1]);
                        frm.acctCrncy.focus();
                        return false;
                }

                if (val[0] == "TO")
                {
                                                alert(val[1]);
                        frm.refCrncy.focus();
                        return false;
                }

                if(val[0] == "RATE")
                {
                                                alert(val[1]);
                        frm.rateCode.focus();
                        return false;
                }
                return true;
        }
                //fnValidateAddFields();
        return true;
}

/* VALIDATING THE AMOUNT RECEIVED FIELD */
function fnvalidate_received(obj)
{
        var frm = document.forms[0];
        var receivedamt = removeCommas(frm.receivedAmt.value);
        if(isNaN(receivedamt))
        {
                alert("Enter valid Received Amount");
                frm.receivedAmt.focus();
                return false;
        }
        if(receivedamt < 0)
        {
                alert("Enter a positive value for 'Amount received' field");
                frm.receivedAmt.focus();
                return false;
        }
        if(receivedamt == 0)
        {
                alert("Enter a valid value for 'Amount received' field to make a transaction");
                frm.receivedAmt.focus();
                return false;
        }
        javascript:newformatAmt('MILLION',frm.receivedAmt,frm.acctCrncy.value,'N');
        return true;
}

/* FUNCTION FOR CHECKING SPECIAL CHARACTERS IN THE CURRENCY CODE FIELDS */
function fnchk_invld_chr(obj)
{
        obj.value = obj.value.toUpperCase();
        var iChars = "!~@`#$&*()+=[]\\\';,/{}|\":<>?.%-^_ ";
        var iFlag1  = 0;
        var value = obj.value;
        for (var j = 0; j < value.length; j++)
        {
                if (iChars.indexOf(value.charAt(j)) != -1)
                {
                        alert("Special characters are not allowed");
                        obj.value="";
                        obj.focus();
                        return false;
                }
        }

        return true;
}

function fnrate_chng(obj)
{
        obj.value = obj.value.toUpperCase();
        var ObjForm = document.forms[0];
        var chrg = 0;
        if(ObjForm.amtFrmCcy.value == "")
        {
           alert("From Currency Cannot be Empty");
           ObjForm.rate.value = "";
           ObjForm.receivedAmt.focus();
           return false;
        }
        if(ObjForm.chrgAmt.value != "")
        {
           chrg = removeCommas(ObjForm.chrgAmt.value);
        }

        //fnPopulateAmtnRate1(ObjForm.rate);
        fnPopulateAmtnRate(ObjForm.rate);

        //ObjForm.acctCrncyAmt.value = "";
        //alert("Rate has been changed please use the Currnecy converter to Calculate the amount");

        return true;
}

function fnChrg_chng(obj)
{
        obj.value = obj.value.toUpperCase();
        var ObjForm = document.forms[0];
        if(ObjForm.amtFrmCcy.value == "")
        {
                alert("Amount Recieved Cannot be Empty");
                if(ObjForm.chrgEvntId.value != "NO CHARGES")
                        ObjForm.chrgAmt.value = "";
                ObjForm.receivedAmt.focus();
                return false;
        }

        var amt = ObjForm.amtFrmCcy.value;
        var chrg = ObjForm.chrgAmt.value;
        var rateVal = ObjForm.rate.value;
        //var actCrncy = amt - chrg;
        actCrncy = actCrncy * rateVal;
        ObjForm.acctCrncyAmt.value = actCrncy;
        return true;

}



function fnch_Amt(obj)
{
        obj.value = obj.value.toUpperCase();
        var ObjForm = document.forms[0];
        if(ObjForm.receivedAmt.value != "")
        {
                //if(!fnAlphaCheck(obj))
                //{
                //ObjForm.acctCrncyAmt.value = "";
                //ObjForm.receivedAmt.value = "";
                //ObjForm.receivedAmt.focus();
                //if(ObjForm.chrgEvntId.value != "NO CHARGES")
                //      ObjForm.chrgAmt.value = "";
                //return false;
                //}


        }
        //ObjForm.acctCrncyAmt.value = "";
        if(ObjForm.chrgEvntId.value != "NO CHARGES")
                ObjForm.chrgAmt.value = "";


fnPopulateAmtnRate(ObjForm.receivedAmt);

if((fnTrim(ObjForm.acctCrncy.value) != "") && (fnTrim(ObjForm.refCrncy.value) != "") && (fnTrim(ObjForm.receivedAmt.value) != ""))
{
        fnShowEvtIDList();
}
        return true;
}

function fnDfltRC(obj)
{
        fnrefCrncyVal();
        var frm = document.forms[0];

        frm.receivedAmt.value="";
        frm.amtFrmCcy.value="";
        frm.chrgEvntId.value="";
        frm.chrgAmt.value="";
        frm.acctCrncyAmt.value = "0.00";
        clicked = "N";

        if((fnTrim(frm.acctCrncy.value) != "") && (fnTrim(frm.refCrncy.value) != "") )
                {
                        //var ptype = (frm.pTranType[0].checked==true)?"D":"C";
                        var input = "pTranType|D|rateType|TM|acctCrncy|"+frm.acctCrncy.value+"|refCrncy|"+frm.refCrncy.value;
                        var output= "";
                        var retVal = appFnExecuteScript(input,output,"denomdp053.scr",false);
                        if(retVal !=undefined)
                        {
                                var vals = retVal.split("|");
                                if(vals[0] !="N")
                                {
                                        //frm.rateCode.value = vals[1];
                                        //frm.treaRate.value = vals[3];
                                        //frm.rateCode.onchange();
                                }
                                else
                                {
                                        alert(vals[1]);
                                        //frm.rateCode.value = "";
                                        return false;
                                }
                        }
                }
                fnPopulateAmtnRate(frm.refCrncy);


                if((fnTrim(frm.acctCrncy.value) != "") && (fnTrim(frm.refCrncy.value) != "") && (fnTrim(frm.receivedAmt.value) != ""))
                {
                        fnShowEvtIDList();
                }
                //fnValidateAddFields();
                return true;
}


/* FUNCTION TO ASSIGN THE VALUE OF RECEIVED AMOUNT TO AMOUNT IN FROM CURRENCY*/
function fnSetAmtFrnCry(obj)
{

        var frm = document.forms[0];
        var chrg = 0;
        if(obj.id == 'refCrncy' || obj.id == 'acctCrncy')
        {
                if(frm.refCrncy.value != frm.acctCrncy.value)
                {
                        frm.amtFrmCcy.value = "";
                        //frm.rate.value = "";
                        frm.rateCode.readOnly = false;
                }
        }
        //javascript:newformatAmt('MILLION',frm.receivedAmt,frm.acctCrncy.value,'N');
        //javascript:frm.acctCrncyAmt.value=frm.receivedAmt.value;
        if(frm.chrgAmt.value != "")
        chrg = removeCommas(frm.chrgAmt.value);
        if(frm.refCrncy.value == frm.acctCrncy.value)
        {
                var ramt = removeCommas(frm.receivedAmt.value);
                //frm.amtFrmCcy.value = ramt - chrg;
                frm.rate.value = "";
                frm.rateCode.value = "";
                frm.rateCode.readOnly = true;
        }
        if(frm.amtFrmCcy.value!="")
        {
        frm.amtFrmCcy.value="";
        }

}

function fnget_chrg(obj)
{
        var frm = document.forms[0];
        convertToCaps();

        if(frm.receivedAmt.value != "")
        {
                frm.amtFrmCcy.value = removeCommas(frm.receivedAmt.value);
        }

        if(frm.chrgEvntId.value != "")
        {

                if(frm.acctCrncy.value == "")
                {
                  alert("From Currency Should Not be blank");
                  return false;
                }
                if(frm.amtFrmCcy.value == "")
                {
                  alert("Amount in From Currency Should Not be blank");
                  return false;
                }
                var retVal = "";
                var amt = removeCommas(frm.receivedAmt.value);
                var inputNameValues = "chargeId|"+frm.chrgEvntId.value+"|Crrncy|"+frm.acctCrncy.value+"|Amt|"+amt;
                var outputNames = "output";
                var scrName = "charge_details.scr";

                var retVal = appFnExecuteScript(inputNameValues,outputNames,scrName,false);
                var strMesg = retVal.split("|");
                if(strMesg[0] == "S")
                {
                        retVal = strMesg[1];
                        var strMesg = retVal.split("*");

                         crncy  = strMesg[0];
                         sysAmt = strMesg[1];
                         usrAmt = strMesg[2];
                         chrgPart = strMesg[3];
                         isMod   = strMesg[4];
                         var fmrCrncy = amt;
                         //frm.amtFrmCcy.value = Math.round((fmrCrncy - sysAmt)*100)/100;
                         frm.receivedAmt.value = Math.round((parseFloat(fmrCrncy) + parseFloat(sysAmt))*100)/100;
                         frm.chrgAmt.value = sysAmt;

                         clicked="Y";

                                                //if (isMod == "N")
                                                //{
                                                //      frm.chrgAmt.value = sysAmt;
                                                //      frm.chrgAmt.disabled = true;
                                                //}
                                                //else
                                                //{
                                                //      frm.chrgAmt.value = sysAmt;
                                                //      frm.chrgAmt.disabled = false;
                                                //}

                }
                else
                {
                        if(strMesg[0] == "N")
                        {
                                frm.chrgEvntId.value = "NO CHARGES";
                                frm.chrgAmt.value = "0.0";
                                frm.chrgAmt.disabled = true;
                                frm.chrgEvntId.disabled = true;
                                hideImage("Rsearch4");
                                hideImage("Rexplode1");
                        }
                        else
                        {
                                alert("Enter Valid Charge Event Id");
                                frm.chrgAmt.value = "";
                                frm.chrgAmt.disabled = true;
                                return false;
                        }

                }


        }


}

function CheckNumberOrNot() {
        var phoneNo = document.getElementById("phoneNo");
        var limitNum = 10;
                if (isNaN(phoneNo.value))
                {
                        alert("Enter a valid phoneNo.");
                clearDescField("phoneNo");
                        document.forms[0].phoneNo.focus();
            return false;
                }
                if (phoneNo.value.length != limitNum)
                {
                        alert ("Input MUST be 10 numeric characters");
                        clearDescField("phoneNo");
                        document.forms[0].phoneNo.focus();
                        return false;
                }
}


function fnAlphaCheck(obj)
{
        var validChars = /[0-9.]/;
        if(validChars.test(obj.value))
        return true;
        alert("Numbers Only Allowed ");
        return false;
}



function fnamt_Chng(Obj)
{
var frm = document.forms[0];
var chrg = 0;
if(frm.receivedAmt.value != "")
{
 if(frm.chrgAmt.value != "")
 chrg = removeCommas(frm.chrgAmt.value);
 var amt = removeCommas(frm.receivedAmt.value);
frm.amtFrmCcy.value = amt;

//if(frm.chrgAmt.value != "0.0")
//{
//      frm.chrgAmt.value = "";
//}

}

}

function fnAccept()
{

        var frm = document.forms[0];
        var receivedamt = removeCommas(frm.receivedAmt.value);
        var acctcrncyAmt = removeCommas(frm.acctCrncyAmt.value);
        var refAmt = removeCommas(frm.acctCrncyAmt.value);
        var refCrncys   = frm.acctCrncy.value + "@" + frm.refCrncy.value;
        var refAmts             =  frm.receivedAmt.value + "@" + frm.acctCrncyAmt.value;
        if(frm.retValue.value == ""){
        var retVal = cust_fndenompopup("A","C","CR","",refCrncys,refAmts,"C@D","","","D","N@Y","");
        alert(retVal);
      //var retVal = cust_fndenompopup1("A","C","CR","","USD@KES","50@100","C@D","","","D","N@Y","");
        if(retVal == "cancel" || retVal == false)
                return false;
        else
        frm.retValue.value = retVal;
        var receivedamt = removeCommas(frm.receivedAmt.value);
        frm.receivedAmt.value = receivedamt;
        var acctcrncyAmt = removeCommas(frm.acctCrncyAmt.value);
        frm.acctCrncyAmt.value = acctcrncyAmt;
//      var refAmt = removeCommas(frm.refAmt.value);
//      frm.refAmt.value = refAmt;
//      var payBackAmt = removeCommas(frm.payBckAmt.value);
//      var getBackAmt = removeCommas(frm.getBckAmt.value);
        var acctCrncy = frm.acctCrncy.value;
        var refCrncy = frm.refCrncy.value;
        var rateCode = frm.rateCode.value;
        //var bopFlag = frm.bopFlag.value;
        var inputNameValues = "acctCrncy|"+acctCrncy
                +"|refCrncy|"+refCrncy
                +"|receivedAmt|"+receivedamt
                +"|acctCrncyAmt|"+acctcrncyAmt
                +"|rateCode|"+rateCode
//              +"|payBckAmt|"+payBackAmt
//              +"|getBckAmt|"+getBackAmt
                //+"|retval|"+retVal
                        +"|retval|"+retVal;

        var outputNames = "";
        var scrName;
        }

return true;
}

function showCrncyConverterForTranMaint(refCrncyObj,tranCrncyObj,rateCodeObj,rateObj,refAmtObj){

        var frm = document.forms[0];
                //var sUrl ="../custom/hcashdx/hcashdx_det_dp001.jsp?fromCrncy="+refCrncyObj.value+"&toCrncy="+tranCrncyObj.value+"&rateCode="+rateCodeObj.value+"&rate="+rateObj.value+"&fromAmt="+refAmtObj.value+"&returnReq=Y&calledMenu=tranMaint";
        var sUrl = "../arjspmorph/"+applangcode+"/crncyconv.jsp?fromCrncy="+refCrncyObj.value +"&toCrncy="+tranCrncyObj.value+"&rateCode="+rateCodeObj.value+"&rate="+rateObj.value+"&fromAmt="+refAmtObj.value+"&returnReq=Y&calledMenu=tranMaint";
        var retVal = popModalWindow(sUrl,"crncyconv");
                //var retVal = popModalWindow(sUrl,"hcashdx_det_dp001");

        if(retVal != undefined){
        var liarrBufArray = retVal.split("|");
        frm.acctCrncy.value = liarrBufArray[0];
        frm.refCrncy.value = liarrBufArray[1];
        frm.rateCode.value = liarrBufArray[2];
        frm.rate.value = liarrBufArray[3];
        frm.amtFrmCcy.value = liarrBufArray[4];
        frm.acctCrncyAmt.value = liarrBufArray[5];
                //alert("test alert6");
                //alert(document.forms[0].amtFrmCcy.value);
                //alert(document.forms[0].receivedAmt.value);
                //frm.receivedAmt.value = liarrBufArray[4];
                }
}

function cust_showPopUp(inputNameValues){

                var frm = document.forms[0];
               if(cust_fnIsNull(inputNameValues))
               {
                              alert("Group Name and Page Name are mandatory");
                              return;
               }

               var inputValueArray = inputNameValues.split("|");

               var groupName = inputValueArray[1];
               var pageName = inputValueArray[3];
               var sUrl = "../custom/"+ subGroupName + "/" + pageName+".jsp?currncy="+frm.acctCrncy.value+"&sysCalAmt="+sysAmt+"&usrEntAmt="+usrAmt+"&chrgPart="+chrgPart+"&isMod="+isMod;
              for( iCount=4;iCount <inputValueArray.length;iCount++){

                              sUrl +="&"+inputValueArray[iCount]+"="+inputValueArray[iCount+1];

                              iCount++;

               }

               var strFeatures = "dialogWidth:50;dialogHeight:25;status=no;toolbar=no;menubar=no;resizable=yes";

        var retValue = window.showModalDialog(sUrl,"",strFeatures);

        return retValue;

}


function fnDisplayRefNum(obj)
{
    var ObjForm = document.forms[0];
    var inputNameValues = "pageNumber|1|pageSize|10|frmCrncy|" + ObjForm.acctCrncy.value + "|toCrncy|" + ObjForm.refCrncy.value;
    var outputNames = "treaRefNum|treaRate|acctId|refCrncy|acctCrncy|rateCode|rate|unutilAmt";
    var scrName = "hcashdx_trfnum_ftch.scr";
    var title   = "List of Treasury Ref Num Values";
    var literalNames= "Treasury Ref.No.|Treasury Ref.Rate|A/c.ID|Frm Ccy|To Ccy|Rate Code|Rate|Unutilised Amt in Frm Ccy";
    var retVal=fnExecuteScriptForList(inputNameValues,outputNames,scrName,title,literalNames,"1",false);
    if(retVal != undefined)
    {
        var sValues = retVal.split("|");
        ObjForm.trRefNum.value = sValues[0];
        ObjForm.rateCode.value = sValues[5];
        ObjForm.rate.value = sValues[6];
        ObjForm.acctCrncyAmt.value = "";
        alert("Rate has been changed please use the Currnecy converter to Calculate the amount");
     }
}

function fnPopulateAmtnRate(obj){
        var ObjForm = document.forms[0];
        var fromCrncy = ObjForm.acctCrncy.value.toUpperCase();
        var toCrncy = ObjForm.refCrncy.value.toUpperCase();
        var refAmtTmp = ObjForm.receivedAmt.value;
        var refAmt = removeCommas(refAmtTmp);
        var rateCode = ObjForm.rateCode.value.toUpperCase();
        var rateTmp = ObjForm.rate.value;
        var rate = removeCommas(rateTmp);
        var treaRate = ObjForm.treaRate.value;

                var custName = ObjForm.custName.value.toUpperCase();
        var phoneNo = ObjForm.phoneNo.value;
        var idNum = ObjForm.idNum.value;
        var docDetails = ObjForm.docDetails.value.toUpperCase();
                //var bankId = ObjForm.bankId.value;
                var nationDet = ObjForm.nationDet.value.toUpperCase();

        var retVal = "";

        if((obj.id == "rateCode") || (obj.id == "refCrncy") || (obj.id == "acctCrncy"))
        {
                rate = "";
        }

        var inputNameValues = "acctCrncy|"+fromCrncy+"|refCrncy|"+toCrncy+"|refAmt|"+refAmt+"|rateCode|"+rateCode+"|rate|"+rate+"|treaRate|"+treaRate;
        var outputNames = "errorFlg|errorMsg|rate|treaRate|tranAmt|tranAmtCcy";
        var scriptName = "cietxndp012.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var rate = token[5];
                var treaRate = token[7];
                var tranAmt = token[9];
                var tranAmtCcy = token[11];
                if(errorFlg == "Y"){
                        alert(errorMsg);
                        ObjForm.acctCrncyAmt.value = "";
                        ObjForm.rate.value = "";
                        ObjForm.rateCode.value = "";
                        return false;

                }else{
                        //ObjForm.rate.value = rate;
                        //ObjForm.treaRate.value = treaRate;
                        ObjForm.acctCrncyAmt.value = tranAmt;
                        var acctCrncyAmtCcy = tranAmtCcy;
                        newformatAmt("Million",ObjForm.acctCrncyAmt,acctCrncyAmtCcy,'N');
                }
        }

        return;
}

function fnPopulateAmtnRate1(obj){
        var ObjForm = document.forms[0];
        var fromCrncy = ObjForm.acctCrncy.value.toUpperCase();
        var toCrncy = ObjForm.refCrncy.value.toUpperCase();
        var refAmtTmp = ObjForm.amtFrmCcy.value;
        var refAmt = removeCommas(refAmtTmp);
        var rateCode = ObjForm.rateCode.value.toUpperCase();
        var rateTmp = ObjForm.rate.value;
        var rate = removeCommas(rateTmp);

                var custName = ObjForm.custName.value.toUpperCase();
        var phoneNo = ObjForm.phoneNo.value;
        var idNum = ObjForm.idNum.value;
        var docDetails = ObjForm.docDetails.value.toUpperCase();
                 //var bankId = ObjForm.bankId.value;
                 var nationDet = ObjForm.nationDet.value.toUpperCase();

        var retVal = "";

        if((obj.id == "rateCode") || (obj.id == "refCrncy") || (obj.id == "acctCrncy"))
        {
                rate = "";
        }

        var inputNameValues = "refCrncy|"+fromCrncy+"|acctCrncy|"+toCrncy+"|refAmt|"+refAmt+"|rateCode|"+rateCode+"|rate|"+rate+"|treaRate|"+treaRate;
        var outputNames = "errorFlg|errorMsg|rate|treaRate|tranAmt|tranAmtCcy";
        var scriptName = "cietxndp012.scr"
        var retVal = appFnExecuteScript(inputNameValues,outputNames,scriptName,false);
        var token = retVal.split("|");
        if(token != undefined){
                var errorFlg = token[1];
                var errorMsg = token[3];
                var rate = token[5];
                var treaRate = token[7];
                var tranAmt = token[9];
                var tranAmtCcy = token[11];
                if(errorFlg == "Y"){
                        alert(errorMsg);
                        ObjForm.acctCrncyAmt.value = "";
                        ObjForm.rate.value = "";
                        ObjForm.rateCode.value = "";
                        return false;

                }else{
                        ObjForm.rate.value = rate;
                        //ObjForm.treaRate.value = treaRate;
                        ObjForm.acctCrncyAmt.value = tranAmt;
                        var acctCrncyAmtCcy = tranAmtCcy;
                        newformatAmt("Million",ObjForm.acctCrncyAmt,acctCrncyAmtCcy,'N');
                }
        }

        return;
}

function fnChgRateCode()
{
        var frm = document.forms[0];
        fnPopulateAmtnRate(frm.rateCode);
}

function chrgAmtBlur()
{
        if(document.forms[0].chrgAmt.value == "")
        {
                clicked="N";
        }
        else
        {
                if(document.forms[0].amtFrmCcy.value == "")
                {
                        alert("Amount in From Currency Should Not be blank");
                        return false;
                }
                var amt = removeCommas(document.forms[0].amtFrmCcy.value);
                var chrgamt = removeCommas(document.forms[0].chrgAmt.value);

                document.forms[0].receivedAmt.value = Math.round((parseFloat(amt) + parseFloat(chrgamt))*100)/100;

                //fnPopulateAmtnRate1(document.forms[0].chrgAmt);
                fnPopulateAmtnRate(document.forms[0].chrgAmt);
        }
}

function cust_callTrRefNoSearcher(obj){
        callTrRefNoSearcher('S','10');
        var ObjForm = document.forms[0];
        var treaRefNum = ObjForm.treaRefNum.value;


                ObjForm.rate.disabled = true;
                ObjForm.treaRate.disabled = true;
                hideImage("rateCodeImg");

}

function callTrRefNoSearcher(trRefNumLoc,link){
        //enableFields("rateCode","rate","treaRate");
        //frm.rateCode.value="";
        //frm.rate.value="";
        //frm.treaRate.value="";
        trRefNum = trRefNumLoc;

        showDynCritSearcher('HTREFNO','tr_ref_num=:document.forms[0].treaRefNum',':document.forms[0].treaRefNum=tr_ref_num|:document.forms[0].rateCode=ratecode|:document.forms[0].rate=cust_rate|:document.forms[0].treaRate=treasury_rate');
	var frm = document.forms[0];
	if(!fnIsNull(frm.rateCode.value) && !fnIsNull(frm.rate.value) && !fnIsNull(frm.treaRate.value))
	{
		disableFields("rateCode","rate","treaRate");
		if(link == '9')
		{
		        tmDisableLink("sLnk10");
	        }
	        if(link == '11')
		{
			tmDisableLink("sLnk12");
	        }

		if (profileId == 50)
		{	
			alert(profileId);
			disableFields("acctCrncy","refCrncy","treaRefNum");
			hideImage("sLnk6");
			hideImage("sLnk2");
			hideImage("treaRefNumImg");
		}
        }
        fnPopulateAmtnRate(frm.rate);
}


function fnrefCrncyVal()
{
var acctCrncy = document.forms[0].acctCrncy.value;

var refCrncy = document.forms[0].refCrncy.value;
var inputNames = "acctCrncy|" + acctCrncy +"|refCrncy|" + refCrncy;
var outputNames = "rateCode|rate|treaRate|errorFlg|errorMsg";
var scr="hcashdxrate.scr";
 var retVal = appFnExecuteScript(inputNames,outputNames,scr,false);
                var result      = retVal.split("|");
                var rateCode      = result[1];
                var rate      = result[3];
                var treaRate = result[5];
                                var errorFlg = result[7];
                                var errorMsg = result[9];
if(errorFlg!="Y")
{
document.forms[0].rateCode.disabled=true;
document.forms[0].rateCode.value=rateCode;
document.forms[0].rate.value=rate;
document.forms[0].rate.disabled=true;
document.forms[0].treaRate.value=treaRate;
document.forms[0].treaRate.disabled=true;
hideImage("sLnk3");
ratecodewrkclscheck();
}
else
{
document.forms[0].rateCode.value ='';
document.forms[0].rate.value ='';
document.forms[0].rateCode.disabled=false;
document.forms[0].rate.disabled=false;
document.forms[0].treaRate.disabled=false;
document.forms[0].treaRate.value='';
showImage("sLnk3");
}
return true;
}
function ratecodewrkclscheck()
{
        //var workClass = workClass;
        //var inputNames = "workClass|" + workClass;
        var inputNames = "";
        var outputNames = "";
        var scr = "workclassCheck.scr";
        var retVal = appFnExecuteScript(inputNames, outputNames, scr, false);
        var result = retVal.split("|");
        var errFlg = result[1];
        var errMsg = result[3];
        var wrkclsFlg = result[5];

        if(errFlg == "N")
        {
                if (wrkclsFlg == "Y")
                {
                        document.forms[0].rateCode.disabled = false;
                        document.forms[0].rate.disabled = false;
                        document.forms[0].treaRate.disabled = false;
                        document.forms[0].treaRefNum.disabled = false;
                        showImage("sLnk3");
                }
        }
        else
        {
                alert(errMsg);
        }
return true;
}
function amlChk(){
        if (profileId == 54){

                var frm=document.forms[0];
		alert (frm.acctCrncy.value);
		alert (frm.rateCode.value);
                var input = "acctCrncy|" + frm.acctCrncy.value + "|refCrncy|" + frm.refCrncy.value + "|receivedAmt|" + frm.receivedAmt.value + "|MiddleName|" + frm.MiddleName.value+ "|" +"custName|" + frm.custName.value + "|idNum|" + frm.idNum.value + "|" + "acctCrncyAmt|" + frm.acctCrncyAmt.value + "|LastName|" + frm.LastName.value+ "|" + "phoneNo|" + frm.phoneNo.value + "|docDetails|" + frm.docDetails.value + "|nationDet|" + frm.nationDet.value + "|treaRefNum|" + frm.treaRefNum.value + "|RateCodedx|" + frm.rateCode.value;
                var outputNames    = "";
                var outputNames = "isWatchBlack|isEqCust|isLimit|isExistTran|isCumm";
                var scrName = "vpcashdxVal.scr";
                var retVal  = appFnExecuteScript(input,outputNames,scrName,false);
                var ret = retVal.split("|");
                if(ret[1] == "W"){
                                alert("Exchange Not Allowed for WatchList ID Number");
                                return false;
                }else if (ret[1] == "B"){
                                alert("Exchange Not Allowed for Blacklisted ID Number");
                                return false;
                }else if (ret[3] == "Y"){
                                alert("Exchange Not Allowed for Equity Customer");
                                return false;
                }else if (ret[5] == "L"){
                                alert("Exchange Limit Exceeded");
                                return false;
                }else if (ret[7] != "N"){
                                alert(ret[7]);
                                alert(ret[9]);
                                return true;
                }else {
                        return true;
                }
        }else{
                        return true;
        }

}

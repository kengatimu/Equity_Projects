/*This custom JS file is written suppress the alert to enter the pegging freq.
when acctpeg flag is Y and peg review date is not null. 
This is not given as the part of Base Product, this is a costomization script */

function fnValidateForm(){
        var wtaxPcnt            = objForm.wtaxPcnt;
        var minIntPcntCr        = objForm.minIntPcntCr;
        var maxIntPcntCr        = objForm.maxIntPcntCr;

        enableFields("wtaxLevelFlg","wtaxFloorLim","wtaxPcnt","tdsOpAcct");

        /* changed as part of recon for ticket 297648 */
        var pegFreqMnths    = objForm.pegFreqMnths
        var pegFreqDay      = objForm.pegFreqDay;
        var pegRevDate      = objForm.pegRevDate;
        /* end of change as part of recon for ticket 297648 */
        if( sMode == "V" || sMode == "C" || sMode == "I" || sMode == "X" ){                             //Inquiry Modes
                fnEnableFormDataControls(objForm);
                return true;
        }

        if((fnIsNull(objForm.intRateCode.value)) && (templateMode != "Y")){
                alert(finbranchResArr.get("FAT000200"));
                objForm.intRateCode.focus();
                return false;
        }

        if (!(validateTypes(objForm)))
                return false;

        if ((objForm.wtaxFlg.value == 'W') && (!fnIsNull(objForm.tdsOpAcct.value))){
                alert(finbranchResArr.get("FAT000217"));
                objForm.tdsOpAcct.focus();
                return false;
        }

    if (sShowTDAddnlFields == "Y")  // ACM - Following field is protected.
        return true;

    // Validation for Max Int Pcnt NOT LESS than Min Int Pcnt (Credit)
        if(!fnIsNull(minIntPcntCr.value) && !fnIsNull(maxIntPcntCr.value) ){
                if (getValInFloat(minIntPcntCr.value) > getValInFloat(maxIntPcntCr.value)){
                        alert(finbranchResArr.get("FAT000404"));
                        minIntPcntCr.focus();
                        return false;
                }
        }
/*changed as part of recon for ticket 297648 If Account is Pegged and Peg frequency is entered and Peg Review Date is not entered then Peg Review Date =BOD + Frequency*
/
        if(getRadioValue(objForm.acctPegged) == 'Y' && (sMode == 'A' || sMode=='Y')){
                if ( (!fnIsNull(pegFreqMnths.value) || !fnIsNull(pegFreqDay.value)) ){
                        objForm.dummyDate.value = BODDate;
                        addDayMonthsToDate(objForm.dummyDate, pegFreqMnths.value, pegFreqDay.value, objForm.pegRevDate);
                }
        }
        if(getRadioValue(objForm.acctPegged) == 'Y' && !fnIsNull(pegRevDate.value)){
                if(fnIsNull(pegFreqDay.value) && fnIsNull(pegFreqMnths.value))
                        //alert(finbranchResource.FAT000627);
        }
        /* end of change as part of recon for ticket 297648 */
  return true;   // If all validations are through
}
/////edwin
function tdintdet_post_ONLOAD()
{
	if (profileId == 54)
	{ 
		//alert("tax");
		//alert(headUserId);
		var dco=headUserId;
		var input      = "dco|"+dco;
		var outputNames    = "output|outVal";
		var scrName     =   "b_workclass.scr";
		var retVal = appFnExecuteScript(input,outputNames,scrName,false);
		var retBuff = retVal.split("|");
		var output = retBuff[0];
		var value = retBuff[1];
		var a = value;
		//alert(a);	
		
		if ((a!="131")&&(a!="147")&&(a!="242"))
		{
			//alert("taxin");
			var wtaxPcnt = objForm.wtaxPcnt;
			var wtaxFlg = objForm.wtaxFlg;
			disableFields("wtaxPcnt","wtaxFlg")
			return true;					
		}    
	}
}

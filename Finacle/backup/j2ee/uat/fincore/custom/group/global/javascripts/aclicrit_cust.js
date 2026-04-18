/*-----------------------------------------------------------------------------------------
    NAME            :   aclicrit_custom.js
    Module Code     :   DENOM
    Menu Option     :   HACLINQ
    Author          :   Khan
    DATE            :   11-07-2013

    Modification History:
    ====================
    Serial No.      DATE            Author               Description
    1           11-07-2013          Khan                 Draft Version
--------------------------------------------------------------------------------------------*/
function fnSetDefault() {

        /* sTempStartDate contains acctOpenDate when back is pressed
         * from res page.
         * If user goes with empty startDate then after pressing back
         * from res page crit page is loaded with acctOpenDate, Else
         * BODDate is loaded. If lastNTran field is not empty then
         * date fields are not loaded.
         */
        if((sStartDate == "") && (sTempStartDate != "") &&
                                        (objForm.lastNTran.value == "")){
                        setValue("startDate",sTempStartDate);
        }
        else if ((sStartDate == "") && (sTempStartDate == "") &&
                                                        (objForm.lastNTran.value == "")){
                setValue("startDate",BODDate);
        }

        if((sEndDate == "") && (objForm.lastNTran.value == "")){
                setValue("endDate",BODDate);
        }

        if (sOrderBy != ""){
                checkRadio(objForm.orderBy, sOrderBy);
        }
        else{
                checkRadio(objForm.orderBy, 'T');
        }

        if (sOrderTran != ""){
                checkRadio(objForm.orderTran, sOrderTran);
        }
        else{
                checkRadio(objForm.orderTran, 'O');
        }

        if (sSourceInd != ""){
                checkRadio(objForm.sourceInd, sSourceInd);
        }
        else{
                checkRadio(objForm.sourceInd, 'N');
        }

        if(fnIsNull(sPhoneNo1)){
                sPhoneNo1 = "                ";
        }

        if (fnIsNull(sPhoneNo2)){
                sPhoneNo2 = "                ";
        }

        objForm.phoneNo.value = sPhoneNo1 + " / " + sPhoneNo2;

}

function fnOnButtonClick(objBtn){
    if(objBtn.id == "Accept"){
        if (!validateTypes(objForm) || !fnValidateMandatoryFields()){
            return false;
        }
                if(!fnIsNull(objForm.lastNTran.value)){
                        if(!isNumber(objForm.lastNTran.value)){

                                alert(finbranchResArr.get("FAT002692"));
                                objForm.lastNTran.focus();
                                return false;
                        }
                        else if (getAmtInFloat(objForm.lastNTran.value) < 0) {

                                alert(finbranchResArr.get("FAT002637"));
                                objForm.lastNTran.focus();
                                return false;
                        }
                }
                objBtn.id = "SUBMIT";
    }
        else if(objBtn.id == "Clear"){
                /* Radio buttons are checked before reseting to achieve default
                 * population.
                 */
                checkRadio(objForm.orderBy, 'T');
                checkRadio(objForm.orderTran, 'O');
                checkRadio(objForm.sourceInd, 'N');
                formReset(objForm);
        }
        else
            objBtn.id = "endMenu";

        fnOnFormSubmit(objBtn.id);
        return true;
}


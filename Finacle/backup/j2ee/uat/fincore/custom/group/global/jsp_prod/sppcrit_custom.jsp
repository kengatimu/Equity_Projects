<!---------------------------------------------------------------------------------------------------------------->
<!--    Name              :   sppcrit_custom.jsp 
<!--    Description       :   This jsp is for memo pad 
<!--    Date              :   23-05-2013
<!--    Author            :   Shishira 
<!--    Called By         :   None
<!--    Calling script    :   formatacctdp001.scr 
<!--    Menu Option       :   HSPPAU.
<!--    Modification History:
<!--    Sl No.             Date                    Author               Description
<!--   ---------         ----------      ------------------     		---------------------
<!--     0.2            23-05-2013                 Shishira				added Function
<!--     0.3            12-08-2013              Pankaj Gaur				added sppcrit_pre_ONCLICK
<!---------------------------------------------------------------------------------------------------------------->
<%@include file="formatAcct.jsp" %>
<script language="javascript">

function showAcctIdListForSpp()
{
        var objForm = document.forms[0];
        var locFuncCode = objForm.funcCode.value ;
        if (locFuncCode != Const.VERIFY_MODE && locFuncCode != Const.CANCEL_MODE)
        {
           showAccountIdList(document.forms[0].acctId,document.forms[0].acctSolId,document.forms[0].acctName,'F',document.forms[0].acctCrncyCode);
        }
        else
        {
                showDetailsPageForDynCritSearcher('HSRPENDA',
                        'callmenu=SPPAU|menu_parm=ASPT|set_id='+cxtSol+'|audit_date='+sAudit_date,
                        ':acctId=table_key_disp');
                arrKeySPP   = objForm.acctId.value.split("/");
                objForm.acctId.value = arrKeySPP[0];
                objForm.acctCrncyCode.value = arrKeySPP[1];
                objForm.acctSolId.value = arrKeySPP[2];
                objForm.beginChqNum.value = fnTrim(arrKeySPP[3]);
                setFieldFocus(objForm.acctId);
        }
	memoPad();
}

function memoPad(){
        var acctNumber = document.forms[0].acctId.value ;
        var inputNameValues = "acctNum|"+acctNumber;
        var outputNames     = "";
        var scrName         = "formatacctdp001.scr";
        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret1 = retVal.split("|");
        if(ret1[0] == "MSG" ){
                alert(ret1[1]);
        }
}

function sppcrit_pre_ONCLICK(obj)
{
        //alert("inside pre onclick");
		setFieldsToCustomData("acctId","beginChqNum","noOfLvs");
				
        return true;
}
</script>

<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : laint_details_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 03-03-2022
<!--Author              : Sos
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HACMLA
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                03-03-2022             Sos              Original version
<!-- <!---------------------------------------------------------------------------------------------------------------->
<script>
function laint_details_post_ONLOAD(obj)
{
        if (mopId=="HACMLA")
        {

                        alert("isha kuwa");
                        //document.forms[0].limLvlIntFlg.value="Y";
			var radioButtons = document.getElementsByName('intOnPrinFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			document.forms[0].prinOvrdPerdMths.disabled = true;
			document.forms[0].prinOvrdPerdDays.disabled = true;
			var radioButtons = document.getElementsByName('intOvrdAtEOMFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			var radioButtons = document.getElementsByName('chrgOvrdAtEOMFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			var radioButtons = document.getElementsByName('appLateFeeFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			var radioButtons = document.getElementsByName('intRtSancLimFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			document.forms[0].lateFeeGrcPerdMths.disabled = true;
			document.forms[0].defApplIntRate.disabled = true;
			document.forms[0].lateFeeGrcPerdDays.disabled = true;
			document.forms[0].defApplIntRateFlg.disabled = true;
			var radioButtons = document.getElementsByName('penOnPrinOvrdFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			fnSetPropertyValue(objForm.intDmdEffDate,"disabled",true);
			var radioButtons = document.getElementsByName('penalProdMthdFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			document.forms[0].penIntBasedOn.disabled = true;
			document.forms[0].grcPrdForPnlIntMths.disabled = true;
			document.forms[0].grcPrdForPnlIntDays.disabled = true;
			var radioButtons = document.getElementsByName('prinOvrdAtEOMFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			var radioButtons = document.getElementsByName('intOnIntFlg');
			radioButtons[0].disabled = false;
		    radioButtons[1].disabled = false;
			document.forms[0].intOvrdPerdMths.disabled = true;
			document.forms[0].intOvrdPerdDays.disabled = true;
			document.forms[0].chrgOvrdPerdMths.disabled = true;
			document.forms[0].chrgOvrdPerdDays.disabled = true;
			var radioButtons = document.getElementsByName('intOverdueFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			var radioButtons = document.getElementsByName('penOnIntOvrdFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			var radioButtons = document.getElementsByName('penalRateMthdFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			var radioButtons = document.getElementsByName('fullPenalMthdFlg');
			radioButtons[0].disabled = true;
		    radioButtons[1].disabled = true;
			document.getElementById("sLnk2").style.visibility = 'hidden';

        }
}

</script>


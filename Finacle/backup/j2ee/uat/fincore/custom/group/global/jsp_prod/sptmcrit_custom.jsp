<script>
//GDA10092
function sptmcrit_post_ONLOAD()
{

	var inputNameValues    = "";
        var outputNames        = "bankId";
       	var scrName            = "oclgirptmn003.scr";
        var retVal             = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
        var ret = retVal.split("|");
        bankId = ret[1];

	if(bankId=="43")
	{

		var radioButtons = document.getElementsByName('postTranFlag');
		radioButtons[0].checked= false;
		radioButtons[1].checked = true;
		radioButtons[0].disabled= true;
		radioButtons[1].disabled= true;

		var radiomode = document.getElementsByName('sptm.processingMode');
		radiomode[0].checked= true;
		radiomode[1].checked= false;
		radiomode[2].checked = false;
		radiomode[0].disabled = true;
		radiomode[1].disabled= true;
		radiomode[2].disabled= true;

	}

}
</script>







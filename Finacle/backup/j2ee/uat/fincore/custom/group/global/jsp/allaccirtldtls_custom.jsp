<script type="text/javascript">

function allaccirtldtls_post_ONCHANGE(obj){
	memoPad();
}
function allaccirtldtls_pre_ONCLICK(obj){
	memoPad();
}
function memoPad(){
	        var cifId= document.forms[0].cifId.value ;
	        var inputNameValues = "cifId|"+cifId;
	        var outputNames     = "";
	        var scrName         = "formatcifdp001.scr";
	        var retVal          = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
	        var ret1 = retVal.split("|");
	        if(ret1[0] == "MSG" ){
			                alert(ret1[1]);
			        }
}

</script>
<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>
<script type="text/javascript">

function linttmcrit_post_ONCHANGE(obj){
	if(obj.id == "acctNum"){
		if(obj.value != "" ){
			setFieldsToCustomData("acctNum");
		}
	}
}


function linttmcrit_pre_ONCLICK(obj){
	if(obj.id == "Accept"){
		if(obj.value != "" ){
			setFieldsToCustomData("acctNum");
		}
	}
}
</script>

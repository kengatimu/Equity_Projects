<script type="text/javascript">
function drpcrit_pre_ONCLICK(obj){
	if(profileId=="54"){
        if(obj.id == "Go" && (document.forms[0].solSetId.value != "" || document.forms[0].fromAcctSolId.value != "")) {
			//alert(contextSolId);
			//alert(document.forms[0].solSetId.value);
			//alert(document.forms[0].fromAcctSolId.value);
		if((contextSolId != document.forms[0].fromAcctSolId.value) || (contextSolId!=document.forms[0].solSetId.value)){
			alert("Inter-sol Receipt Printing Not Allowed");
			return false;
		}
        }
	}
        return true;
}
</script>


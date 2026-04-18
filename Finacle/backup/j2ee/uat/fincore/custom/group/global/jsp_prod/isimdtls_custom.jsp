<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : isimdtls_custom.jsp 
<!--Description         : Setting custom date value for pymt_det_custom.jsp
<!--Date                : 11-03-2013
<!--Author              : Chandrasekhar
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HSIM
<!--Modification History:
<!--    Version No.          Date                Author             Description
<!--    ---------          ----------           ---------          -----------------
<!--     0.1               11-03-2013            Chandrasekhar      Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type ="text/javascript">
function  isimdtls_post_ONCLICK(){ 
setFieldsToCustomData("mRefCrncy");
	getFieldsFromCustomData("remitMode");
	var Remit = document.forms[0].customData.value;
	//alert(Remit);
	var mod = Remit.split("|");
	var remitmode = ret[5];
	//alert(remitmode);
}

function  isimdtls_pre_ONCLICK(){ 
setFieldsToCustomData("mRefCrncy");
}
function  isimdtls_ONCHANGE(){ 
setFieldsToCustomData("mRefCrncy");       
}
function  isimdtls_ONBLUR(){ 
setFieldsToCustomData("mRefCrncy");       
}
</script>

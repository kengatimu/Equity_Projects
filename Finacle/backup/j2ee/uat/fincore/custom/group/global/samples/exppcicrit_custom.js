<%-- 
	Allow/disallowing Tran/Part Tran wise posting
        This jsp file is hand coded and not generated. 
        This file can be customized at sites for allowing or disallowing 
        Tran wise or Part Tran wise posting in HTM.
        The file name of this jsp should not be changed.
        This file should reside in finbranch/custom/jsp folder
--%>

<script>
var frm = null;
function exppcicrit_pre_ONLOAD(){
	frm = document.forms[0];
        frm.freeFld1.value = "1";
        frm.freeFld2.value = "2";
        frm.freeFld3.value = "3";
	frm.freeFld4.value = "4";
}

</script>

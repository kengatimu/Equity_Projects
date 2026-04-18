<!-------------------------------------------------------------------------------------------------------------->
<!--Name                : linttmacct_custom.jsp
<!--Description         : This is used to protect custPrefIntCr and custPrefIntDr.
<!--Date                : 13-03-2013 
<!--Author              : Manoj
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HOAACOD
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            13-03-2013                       Manoj          Original version
<!---------------------------------------------------------------------------------------------------------------->

<script type="text/javascript">
function post_ONLOAD(){
	if(mopId == "HOAACOD" ){
		document.getElementById('custPrefIntCr').disabled=true;	
		document.getElementById('custPrefIntDr').disabled=true;	
	}
}
</script>

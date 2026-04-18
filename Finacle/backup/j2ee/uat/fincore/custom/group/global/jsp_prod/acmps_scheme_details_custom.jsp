<!--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : acmps_scheme_details_custom.jsp
<!--Description         : This is used to protect field Maximum allowed limit .
<!--Date                : 01-08-2013 
<!--Author              : Anik
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : ACMPS
<!--Modification History:
<!--    Version No.           Date             Author                 Description
<!--    -------         ----------            -----------        ------------------
<!--	   0.1		01-08-2013	      Anik Soni		Created for TOL  359738
<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<script type="text/javascript"> 

function post_ONLOAD(){
		if(mopId == "ACMPS" )
		{
		        
		        document.getElementById('maxAllowLimit').readOnly=true;
		        document.getElementById('maxAllowLimit').disabled=true;
		}
		
}
</script>

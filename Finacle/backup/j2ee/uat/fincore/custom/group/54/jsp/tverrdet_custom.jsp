<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : tverrdet_custom.jsp
<!--Description       : This file should reside in finbranch/custom/jsp folder.
<!--Date              : Mark Nderitu
<!--Author            : Farhan
<!--Called By         : Menu
<!--Calling jsp       : None
<!--Menu Option       : HTV
<!--Modification History:
<!--	Version No.	Date		Author		Description
<!-- 	-----------	------		----------	---------------------------
<!--	0.1		0804-2025	Mark Nderitu		Original version
 
<!---------------------------------------------------------------------------------------------------------------->



<script language="javascript" >



 

function tverrdet_post_ONLOAD(obj){
	
	
	//alert("Hallo");
	//alert(sPopUpExceptionWindow);
	
	
	//if(sMsg=="Job successfully completed."){
		
	
	
	
      var inputNameValues = "" ;
      var outputNames = "";
     var scrName = "ttumSalLienRemove.scr";
      var retVal = appFnExecuteScript(inputNameValues, outputNames, scrName, false);
   
		
	   return true;
	   //}
}


 

</script>

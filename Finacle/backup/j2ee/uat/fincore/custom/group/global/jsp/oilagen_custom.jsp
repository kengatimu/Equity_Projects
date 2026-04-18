<!--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<!--Name                : oilagen_custom.jsp
<!--Description         : This is used to make mandatory check on field Mode of Operation .
<!--Date                : 31-07-2013
<!--Author              : Anik
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : 
<!--Modification History:
<!--    Version No.           Date                       Author                 Description
<!--    -------         ----------                       -----------        ------------------
<!--     0.1            31-07-2013                       Anik          Original version -TO 364533
<!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
<script type="text/javascript"> 

function oilagen_pre_ONCLICK(obj){
	if(obj.id != 'Back' && obj.id != 'expand'  && obj.id != 'sLnk10' ){
		var modeOfOperCode = document.forms[0].modeOfOperCode.value;
		
		if(modeOfOperCode == "" && sMode != "I" && sMode != "V" && sMode != "X" ){
			alert("Mode of Operation field is mandatory");
			 document.forms[0].modeOfOperCode.focus(); 
			return false;
		}
	}
}

function oilagen_pre_TAB_SWITCH(obj){
	if(obj.id != 'Back' && obj.id != 'expand'  && obj.id != 'sLnk10'){
		var modeOfOperCode = document.forms[0].modeOfOperCode.value;
		
                 if(modeOfOperCode == "" && sMode != "I" && sMode != "V" && sMode != "X" ){         
			alert("Mode of Operation field is mandatory"); 
			document.forms[0].modeOfOperCode.focus();
                        return false;
                }
	}
}
		//
function oilagen_pre_ONCHANGE(obj){
	if(obj.id == "modeOfOperCode"){
		var modeOfOperCode = document.forms[0].modeOfOperCode.value;
		
		 if(modeOfOperCode == "" && sMode != "I" && sMode != "V" && sMode != "X" ){		
			alert("Mode of Operation field is mandatory");
			 document.forms[0].modeOfOperCode.focus(); 
			return false;
		}
		
	}
}


</script>

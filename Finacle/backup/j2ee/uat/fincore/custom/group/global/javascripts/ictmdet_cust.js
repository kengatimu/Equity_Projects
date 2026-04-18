function ictmdet_post_ONCHANGE(obj){
	if(obj.id == "instAmt"){
		if(obj.value != ""){
			
			setFieldsToCustomData("instAmt");
		}
	}
}

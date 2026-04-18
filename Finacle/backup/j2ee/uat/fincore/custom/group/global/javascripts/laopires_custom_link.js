function post_ONLOAD(obj){
	var ret=true;
	if (isCalledMenu == "Y") {
		document.forms[0].Cancel.disabled = "true";
		document.forms[0].Print.disabled = "true";
	}
	return ret;
}

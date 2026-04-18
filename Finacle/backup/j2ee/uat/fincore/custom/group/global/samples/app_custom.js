<!--	This source is only a sample source. It illustrates the way to implement 
		application level customization and also customization of help content.
-->

<script language="javascript">
var downFlg = false;

function getExternalHelpUrl(pageName, menuName){
	if(pageName == "cumm_accept")
		return "../custom/customhelp/cumm_accept_help_custom.htm";
	else if(menuName == "HDAM" || menuName == "HCUS")
		return "file://Chnmct62892/help/help.htm";
	//else
		//return;
}

function app_post_ONKEYDOWN(obj){
	if(window.event.keyCode == 17){ //For Ctrl key
		downFlg = true;
	}
	if(downFlg == true && window.event.keyCode == 78){ //For 'n' key
		downFlg = false;
		event.keyCode = 0;
		return false;
	}
	return true;
}

function app_pre_ONLOAD(obj){
	return true;
}

function app_post_ONKEYUP(obj){
	if(window.event.keyCode == 18)
	return true;
}

</script>

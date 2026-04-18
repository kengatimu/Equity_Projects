/*
Added on DEC-20-2003 as part of SRRECON
*/

function init() {
<!-- Tracker ID :756914 - Chrome Porting Changes -->
	parent.parent.parent.parent.frames[3].hideSaveButton('true');
	parent.parent.parent.parent.frames[3].document.all.newButton.style.display = 'none';
}


function refreshParent(){
<!-- Tracker ID :756914 - Chrome Porting Changes -->
	top.opener.parent.parent.parent.parent.frames[0].frames[0].frames[1].location.reload(true);
}
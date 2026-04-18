function customSave() {
}

function customSaveAccount(){
}

function setDefaultTime(){

	var hh1 = document.getElementsByName ('Hrs')[0];
	var hh2 = document.getElementsByName ('Hrs')[1];
	var mi1 = document.getElementsByName ('Mins')[0];
	var mi2 = document.getElementsByName ('Mins')[1];
	
	//set the Default From Time 
	hh1.value = 9;	// 9 Hours AM
	mi1.value = 0;  // 0 Minutes
	
	//set the Default From Time 
	hh2.value=  17; // 5 Hours PM
	mi2.value = 0;  // 0 Miutes
}
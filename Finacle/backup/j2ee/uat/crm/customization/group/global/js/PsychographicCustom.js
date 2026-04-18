// CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES

function customSave() {
}
// CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES
/* Look up CR changes*/
function fnBlurproductLookup(type) {			
	
	var check = chkBlurFrom1();
	
	if(check){		
		var manager = "";	  	     
		manager = document.getElementsByName("PsychographicBO.ProductPref.ProductID")[0].value;
		<!-- Tracker ID :756914 - Chrome Porting Changes -->
		var s_xmlHttp;
if(window.ActiveXObject) {//For IE 
 s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
}
else if(document.implementation && document.implementation.createDocument) {//For Mozilla
   s_xmlHttp=document.implementation.createDocument("","",null);
   }
		var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?Manager='+manager+"&Type="+type;
		
		s_xmlHttp.open("GET",strURL,false);
		s_xmlHttp.send();
		var lastName = '';		
		
		if(s_xmlHttp.status == 200)
		{			
			lastName = getColorCookie('sBoolean');
			
			if(lastName=='False'){
				showUserMessage(MSGJ50716,"");
				document.getElementsByName("PsychographicBO.ProductPref.ProductID")[0].value  = "";
			}
		}
	}
	else{

	    /* Tracker: 108382: Changes for centering popup */ 
	    windowAlign();
	    var prodPrefLookUpWin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForProdPref',
				 'Lookup',
				 'height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
	    /* Tracker: 108382: End of Changes */
	}
}
/* Look up CR changes*/

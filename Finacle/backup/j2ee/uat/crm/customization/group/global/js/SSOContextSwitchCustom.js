// CRM62ENH:SSO : **BEGIN OF CHANGES

function getCorrectFrame()
{
var parentPrefix="top.";
for(i=0;i<10;i++){	
try{		
	if(eval(parentPrefix + "window.frames.loginFrame"))
	{
		break;
	}		
	parentPrefix += "window.opener.top.";
}catch(e){		
	parentPrefix += "window.opener.top.";
	}
}
return parentPrefix;
}


function fnContextSwitch(bkServer,data,menu) {
	try{
		if(top.window.loginFrame)
			top.window.loginFrame.invokeApplicationContext( bkServer, data, menu);
		else{
			var parentHierarchy = getCorrectFrame();
			eval(parentHierarchy + "window.loginFrame.invokeApplicationContext( bkServer, data, menu)");
		}
	}catch(e)
	{
		return false;
	}
	return true;
}


// CRM62ENH:SSO : **END OF CHANGES

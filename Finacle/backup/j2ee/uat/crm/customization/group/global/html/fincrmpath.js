
//Changes for domain name modification starts

//document.domain="ad.infosys.com";
if(document.documentMode>8 || !window.ActiveXObject){
	var domain =document.domain;
	if(location.hostname==domain){
		document.domain = domain.substring(domain.indexOf(".")+1, domain.length)
	}
}
document.write('<script language="javascript" src="/FinacleCRM/common/js/CRMDomainName.js"></script>');

//Changes for domain name modification ends

var g_wndCTIFrame = null;

var currLocale = getDateFormatCookie("SRMLocale")
var finaclecrmlocale = gettingFormats();

function gettingApplPath(){
	var wnd = null;
	try{
	/* Tracker ID :756914 - Chrome Porting Changes */
	if(top.window.opener != undefined && top.window.opener.name == 'CRMServer'){
		
		return top.window.opener.frames[1].applPath;
	}
	if(top.window.opener != undefined && top.window.opener.name !=''){
	
		wnd = GetCTIFrame(top.window.opener);
	}else
	{
		
		wnd = GetCTIFrame(window);
	}
	
	wnd.loading();
	
	applPath    = wnd.applPath;
	} catch(e){		
	}
	//Fix for 437409 starts 
	if(applPath == undefined || applPath !='' || applPath == null || applPath =="null")
	applPath ="/FinacleCRM";
	//Fix for 437409 ends 
	return applPath;
}


function GetCTIFrame(wnd)
{
	try{
	
	if( g_wndCTIFrame != null )
	{
	
		return g_wndCTIFrame;
	}
	if( wnd.name == "GlobalOptionsFrm" )
	{
	
		g_wndCTIFrame = wnd;
		return g_wndCTIFrame;
	}
	else if (wnd == wnd.parent)
	{
	
		if (wnd.opener != null)
		{
		
			return GetCTIFrame(wnd.opener);
		}
		else
		{
			return null;//we have reached the end of the tree
		}
	}
	else
	{
	
		var i;
		for (i = 0; i < wnd.parent.frames.length; i++)
		{
			/* Tracker ID :756914 - Chrome Porting Changes */
			if (wnd.parent.frames[i].name == "GlobalOptionsFrm")
			{
			
			
				g_wndCTIFrame = wnd.parent.frames[i];
				return g_wndCTIFrame;
			}
		}
	}
	return  GetCTIFrame(wnd.parent);
	} catch (e) {			
		return  GetCTIFrame(wnd.parent);
	}
}

function gettingFormats(){
	var wnd = null;
	try{
	if(currLocale != null && currLocale !=''){
		return currLocale;
	}
	/* Tracker ID :756914 - Chrome Porting Changes */
	if(top.window.opener != undefined && top.window.opener.name == 'CRMServer'){
		return top.window.opener.frames[1].FcrmLocale
	}
	if(top.window.opener != undefined && top.window.opener.name !=''){
		wnd = GetCTIFrame(top.window.opener);
	}else
	{
		wnd = GetCTIFrame(window);
	}
	wnd.loading();
	currLocale    = wnd.FcrmLocale;
	} catch(e){
	}
	//Fix for 437409 starts 
	if(currLocale == undefined || currLocale !='' || currLocale == null || currLocale =="null")
	currLocale ="en_US";
	//Fix for 437409 ends 
	return currLocale;
}

function getDateFormatCookie(sName) {
try{
     var aCookie = top.document.cookie.split("; ");
     for (var i=0; i < aCookie.length; i++)
     {
         var aCrumb = aCookie[i].split("=");
             if (sName == aCrumb[0])
                    return unescape(aCrumb[1]);
     }
  return null;
  }catch(e){
  }

}
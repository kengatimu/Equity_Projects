/******************************************************************************************
*	HotKeyProcessor : For processing the KeyDown and KeyUp Events
*
*	the functions fnKeyDownProcessor and fnKeyUpProcessor can be called
*	from events onKeyDown and onKeyUp respectively. It is always better to
*	call these functions together (meaning if fnKeyDownProcessor is called, then
*	calling fnKeyUpProcessor is advisable).
*
*	to execute these functions, the following resources are mandatory
*
*	fkmResource	:	is a local key-function map resource and it should be available
*					in the scope of the web page that calls these functions. it can take
*					the values [null, "", key-value pair]. where key is the logical key
*					mentioned in hkmResource and value is the local function to be
*					executed when the specified event occurs. if a page requires
*					any key (logicalkey as mentioned in hkmResource) event handling
*					an entry [key-value pair] for that key should be available in this
*					(fkmResource) map. event handler for any logical key other than
*					those available in hkmResource are not executed.
*
*	hkmResource	:	is a global key map resource for mapping physical and logical keys
*					mapping. physical key consists of optional "ALT", optional "CTRL"
*					and mandatory "<KEY>" that has a valid ASCII code. if an event
*					that consists of CTRL, ALT and a KEY is to be handled the logical
*					key should always be in form "CTRL+ALT+<KEY>".
*
*	hkmCtrKey	:	is a global string value for CTRL key. default value is "CTRL"
*
*	hkmAltKey	:	is a global string value for ALT key. default value is "ALT"
*
*	developed by: 	Pandeya, Ishwarraj
******************************************************************************************/
/* HtmlMenu changed to PrecArray - 7.0.6
* Changed by Mamatha C V
* Dated 19th January 2005
******************************************************************************************/
/*This hotkeyprocessor will be mirrored in crv*/

/* Varibles declared for providing customization to the clients */
var hkmResource;
var hkmResourceCustomPage;
var hkmResourceCustomSite;
var hkmResourceDeveloper;

/* special key */
var hkmSpecialKey =
{
	188: "LESSER-THAN"
	,190: "GREATER-THAN"
	,191: "QUESTION-MARK"
	,33 : "PAGE-UP"
	,34 : "PAGE-DOWN"
	,37 : "LEFT-ARROW"
	,38 : "UP-ARROW"
	,39 : "RIGHT-ARROW"
	,40 : "DOWN-ARROW"
	,112: "F1"
	,113: "F2"
	,114: "F3"
	,115: "F4"
	,116: "F5"
	,117: "F6"
	,118: "F7"
	,119: "F8"
	,120: "F9"
	,121: "F10"
	,122: "F11"
	,123: "F12"
	,9  : "TAB"
	,27 : "ESC"
}

/* flag for exclusive check */
var hkpXCheck  = true;

/* event source object */
var evtSource	= null;
var physicalKey = "";
var logicalKey 	= "";
var fnString	= "";
var fnName		= "";
var blockName	= "";
var currentFocusId      = null;

//New requiremnt start
	var elementFocus = null;
//New requiremnt end

/* NO_KEY is used to suppress certain keys. For functionalities like Ctrl+Y where a child window gets opened we are assigning
the keyCode as NO_KEY (which has a value 0) so that when the child window is closed the characker doesn't gets printed*/

var NO_KEY			= 0;

/* control key flag */
var hkpCtrlKey 			= 17;
var hkpAltKey 			= 18;
var hkpCtrlKeyDown 		= false;
var hkpAltKeyDown		= false;
var hkpShiftKey 		= 16;
var hkpShiftKeyDown 	= false;
var fkmResource 		= "";
var tfkmResource 		= "";
var moz 				= false;
var HIGHLIGHT_COLOR 	= "progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#cccccc',EndColorStr='#ffffff')";
var NORMAL_COLOR 		= "progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#ffffff',EndColorStr='#ffffff')";
var MANDATORY_COLOR		= "progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='#ddeaf8',EndColorStr='#ffffff')";

if (navigator.appName == "Mozilla" || navigator.appName == "Netscape")
{
   moz = true;
   window.onfocus = gfkmResourceOnFocus;
   //document.addEventListener("keypress",gfkmResourceOnKeyPress,true);
}
else
{
    document.onfocusin = gfkmResourceOnFocus;
    document.onfocus = gfkmResourceOnFocus;
}

/*	This function handles the focus-change-event */
function initFocusHandler()
{

	if (!SSO){
		//Maximize the window
		var x=window.screen.availWidth;
		var y=window.screen.availHeight;
		window.moveTo(0,0);
		window.resizeTo(x,y);
	}
	if(moz)
	{
		window.captureEvents(Event.FOCUS);
		window.captureEvents(Event.ONKEYDOWN);
		window.captureEvents(Event.ONKEYUP);
		window.onfocus = gfkmResourceOnFocus;
		window.onkeypress = gfkmResourceOnKeyPress;
	}
	else
	{
		document.forms[0].onfocusin = gfkmResourceOnFocus;
		document.onkeypress=gfkmResourceOnKeyPress;
		document.onclick=gfkmResourceOnClick;
	}
}

function gfkmResourceOnKeyPress(e)
{
	var navName = navigator.appName;
	var tmp = getEvtKeyCode(e);
	
	if (!e) var e = window.event;
	
	if (tmp == 33 || tmp == 124) // !,|
	{
		if (navName != "Microsoft Internet Explorer") e.stopPropagation();
		return false;
	}
	return true;
}
function gfkmResourceOnClick()
{
	return findVersionDisplay();
}

function findVersionDisplay(event)
{
	evtSource = fnGetEventSource(event);
	var parentType = evtSource.tagName;

	if (hkpCtrlKeyDown && parentType.toUpperCase() == "IMG")
	{
		var obj = evtSource;
		var hkId = obj.getAttribute("hotKeyId");
		if (hkId != undefined && !fnIsNull(hkId) && hkId == "finHelp")
		{
			showVersion();
			return false;
		}
	}
	if (hkpCtrlKeyDown && parentType.toUpperCase() == "A")
		{
			var len = (evtSource.children != undefined && evtSource.children != null) ? evtSource.children.length : 0;

			if (len > 0)
			{
				for (var i=0; i<len; i++)
				{
					var obj = evtSource.children[i];
					if (obj != undefined && obj != null)
					{
						if ((obj.tagName).toUpperCase() == 'IMG')
						{
							var hkId = obj.getAttribute("hotKeyId");
							if (hkId != undefined && !fnIsNull(hkId) && hkId == "finHelp")
							{
								showVersion();
								return false;
							}
						}
					}
				}
			}
		}


	return true;
}

/* does eXclusive check for the availability of objects */
function fnXCheck(){
	if(hkpXCheck){
		/* is hkmCtrKey available */
		if( (hkmCtrKey == null) || (hkmCtrKey == undefined) || (hkmCtrKey.length < 1) ) return false;

		/* is hkmAltKey available */
		if( (hkmAltKey == null) || (hkmAltKey == undefined) || (hkmAltKey.length < 1) ) return false;

		/* is hkmShiftKey available */
		if( (hkmShiftKey == null) || (hkmShiftKey == undefined) || (hkmShiftKey.length < 1) ) return false;

		/* is hkmResource available */
		if( (hkmResource == null) || (hkmResource == undefined) ) return false;
		/* is fkmResource available */
		if( (fkmResource == null) || (fkmResource == undefined) ) return false;
		/* is gfkmResource available */
		if( (gfkmResource == null) || (gfkmResource == undefined) ) return false;
		return true;
		/* is tfkmResource available */
		if( (tfkmResource == null) || (tfkmResource == undefined) ) return false;
		return true;
	}
}

/* returns the event source object */
function fnGetEventSource(event){

	if(navigator.appName.indexOf("Netscape") == -1) {

		return window.event.srcElement;
	} else {
		return event.target;
	}
}

/* executes the event handler */
function fnExecEventHandler(event, evtSource, fnName){
	/* Changed for the Ticket id 220994. when ctrl+tab is pressed from
	   Searcher window, js error is thrown, as goToNextTab is undefined for searchers.*/
	if(eval("this."+fnName)!=undefined)
		eval(fnName+"(event, evtSource)");
	return false;
}

document.onhelp = function ()
   {
           event.cancelBubble = true;
           event.returnValue = false;
   }


/* common key down processor */
function fnKeyDownProcessor(event){
	var BACK_SPACE_KEY  = 8;
	physicalKey = "";
	logicalKey 	= "";
	fnName 		= "";
	fnString	= "";
	blockName 	= "";
	var funcName = "";

	funcName ="this.fnResetTimers";
	if (eval(funcName) != undefined){
        fnResetTimers();
    }

	if(!fnXCheck()) return;

	switch(getEvtKeyCode(event)){
		case hkpCtrlKey	:
			hkpCtrlKeyDown = true;
			break;
		case hkpAltKey	:
			hkpAltKeyDown = true;
			break;
		case hkpShiftKey	:
			hkpShiftKeyDown = true;
			break;
		default			:
			/* both ctrl key and alt key on */
			if(hkpCtrlKeyDown && hkpAltKeyDown){
				physicalKey = hkmCtrKey + "+" + hkmAltKey + "+" + getEvtKeyCode(event);

				hkpCtrlKeyDown = false;
				hkpAltKeyDown = false;
			}
			/* both ctrl key and shift key on */
			else if(hkpCtrlKeyDown && hkpShiftKeyDown){
				physicalKey = hkmCtrKey + "+" + hkmShiftKey + "+" + hkmSpecialKey[getEvtKeyCode(event)];
			}
			/* only ctrl key on */
			else if(hkpCtrlKeyDown){
				physicalKey = hkmSpecialKey[getEvtKeyCode(event)];
				if(physicalKey != undefined)
				{
					if(physicalKey == "TAB")
					{
						hkpCtrlKeyDown	= false;
					}
					physicalKey = hkmCtrKey + "+" + physicalKey;
				}
				else
				{
					var pKey = String.fromCharCode(getEvtKeyCode(event));
					physicalKey = hkmCtrKey + "+" + pKey;

				}
			/* only alt key on */
			} else if(hkpAltKeyDown){
			        /* Checking whether the keypressed is not UP and DOWN. If Not then enter
				 * get the physicalKey and make hkpAltKeyDown false*/
				if(getEvtKeyCode(event)!=40 && getEvtKeyCode(event)!=38 && getEvtKeyCode(event)!=33 && getEvtKeyCode(event)!=34)
				{
					physicalKey = hkmAltKey + "+" + String.fromCharCode(getEvtKeyCode(event));
					hkpAltKeyDown = false;
				}

				/* For functionalities for moving between records in popups, if the user presses ALT key and
				 * then presses UP/DOWN arrows without releasing the ALT key thenit would not enter this else if hkpAltKeyDown
				 * is false. So, here the variable is not made false*/
				else
					physicalKey = hkmAltKey + "+" +hkmSpecialKey[getEvtKeyCode(event)];


			/* Only Shift Key Down */
			}else if(hkpShiftKeyDown){

				physicalKey = hkmSpecialKey[getEvtKeyCode(event)];
				if(physicalKey != undefined)
				{
					/* F11 is a default windows functionality for maximizing the window,hence suppressed*/
					if(physicalKey == "F11")
					{
						preventDefaultAction(event);
						event.returnValue = false;
					}
					physicalKey = hkmShiftKey + "+" + physicalKey;
				}
			/* both ctrl key and alt key off */
			} else {
				physicalKey = hkmSpecialKey[getEvtKeyCode(event)];
				if(getEvtKeyCode(event)== BACK_SPACE_KEY) {
					event.keyCode = NO_KEY;
					return;
				}
				if(physicalKey == undefined) break;
			}

			/* get event source */
			evtSource = fnGetEventSource(event);

			/*Handling For the customization provided.Here first it is checked whether do we have keys
			  defined at the page level*/
			if (hkmResourceCustomPage != undefined)
			{
				/*Yes, get the logical key.*/
				logicalKey = hkmResourceCustomPage[physicalKey];
				/*If the logical key is not found check whether we have
				  master client keys(keys at site level) defined*/
				if((logicalKey == "" || logicalKey == undefined) && hkmResourceCustomSite != undefined )
				{
					/*If yes get the logical key*/
					logicalKey = hkmResourceCustomSite[physicalKey];
					/* If the logical key is not found check whether keys are defined at the developer level*/
					if((logicalKey == "" || logicalKey == undefined) && hkmResourceDeveloper != undefined )
					{
						/*If yes get the logical key*/
						logicalKey = hkmResourceDeveloper[physicalKey];
					}
				}
			}
			/* If Mapping at page level is not defined check at the site level, if defined get the logical key*/
			else if (hkmResourceCustomSite != undefined)
			{
				/*get the logical key*/
				logicalKey = hkmResourceCustomSite[physicalKey];
				/* If logical key is not defined check whether key mappings are defined at developer level. if yes get the logical key*/
				if((logicalKey == "" || logicalKey == undefined) && hkmResourceDeveloper != undefined )
				{
					logicalKey = hkmResourceDeveloper[physicalKey];
				}
			}
			/* If mappings at site level also is not defined check whether mappings are defined by developer.
			   If yes get the logical key. */

			else if (hkmResourceDeveloper != undefined)
			{
				logicalKey = hkmResourceDeveloper[physicalKey];
			}
			/* If still logical key is not defined take the default keys*/

			if((logicalKey == "" || logicalKey == undefined) && hkmResource != undefined )
			{
				logicalKey = hkmResource[physicalKey];
			}

			/* Suppressing the F1, F3, F4, F5, F6, F7, F9,F10 and Esc keys inorder to cancel the default browser events */
			if (getEvtKeyCode(event)== 112 || getEvtKeyCode(event)== 114 || getEvtKeyCode(event)== 115 || getEvtKeyCode(event)== 116 || getEvtKeyCode(event)== 117 || getEvtKeyCode(event)== 118 || getEvtKeyCode(event)== 120 || getEvtKeyCode(event)== 121 || getEvtKeyCode(event)== 27)
			{
				preventDefaultAction(event);
				event.returnValue = false;
			}

			/*Checking if still logical key is null or undefined or "" it means user has pressed a wrong key*/
			if((logicalKey == null) || (logicalKey == undefined) || (logicalKey == "")) break;


			/* get associated  block for event source object */

			blockName = evtSource.getAttribute("blockname");
			if((blockName == null)||(blockName == ""))
				blockName = evtSource.getAttribute("fblk");




			/* if block name is available */
			if( (blockName != null) && (blockName != "") ) {
				fnString = logicalKey+"|"+blockName;
				/* get function associated for that logical key and block */
				fnName = fkmResource[fnString];
				/* if function available, exec that and come out*/
				if(fnName != undefined && (fnName != "")){
					return fnExecEventHandler(event, evtSource, fnName)
				}
			}
			/* either block name or block function not available
				so search for the function available for the form		*/
			fnString = logicalKey+"|FORM";
			fnName = fkmResource[fnString];



			/* if form function available, exec that */
			if(fnName != undefined) {
				return fnExecEventHandler(event, evtSource, fnName);
			} else {
				fnName = tfkmResource[fnString];
				if(fnName != undefined){
					return fnExecEventHandler(event, evtSource, fnName);
				} else {
					fnName = gfkmResource[fnString];
					if(fnName != undefined) {
						/*Here a check is applied to see if hotkey for cookies is pressed. If yes set keyCode to false so that when a Ctrl+<key> combination is pressed
						the character does not get printed. This is not done inside the function showCookies as it is written inside common_functions and not in hotkeyprocessor*/
						if(fnName =='showCookies')
						{
							 preventDefaultAction(event);
							 event.returnValue = false;
							 hkpCtrlKeyDown = false;
						}
						return fnExecEventHandler(event, evtSource, fnName);
					}
				}
			}
			/* end of event processing */
			break;
	}
	return true;
}

/* common key up processor */
function fnKeyUpProcessor(event){
	/* set control and alt key off */
	switch(getEvtKeyCode(event)){
		case hkpCtrlKey	:
			hkpCtrlKeyDown = false;
			break;
		case hkpAltKey	:
			hkpAltKeyDown = false;
			break;
		case hkpShiftKey :
			hkpShiftKeyDown = false;
			break;
	}
}

/***********************************************************************
*   HotKeyMapResource   :--:
*   mapps the logical key with physical key, use the logical key in local key-function
*   map resource (fkmResource). physical key consists of optional CTRL, optional ALT
*   and a mandatory KEY (that has a valid ASCII code).
*   Syntax                              :--: Physical-Key([CTRL+][ALT+]<KEY> : Logical-Key
************************************************************************/
var hkmAltKey   = "ALT";            //holds the string value of alt key, use this value to define the physical key
var hkmCtrKey   = "CTRL";           //holds the string value of ctrl key, use this value to define the physical key
var hkmShiftKey = "SHIFT";			//holds the string value of shift key, use this value to define the physical key

var gfkmResource =
{
	 "FORM-SUBMIT|FORM"					: "gfkmClickOnFormSubmit"
	,"FORM-VALIDATE|FORM"					: "gfkmClickOnValidate"
	,"FORM-CANCEL|FORM"					: "gfkmClickOnCancleBackClose"
	,"FORM-SAVE|FORM"       				: "gfkmResourceOnFormSave"
	,"PRINT-DATE|FORM"					: "gfkmResourceOnPrintDate"
	,"RETURN-BACK|FORM"					: "gfkmResourceOnReturnBack"
	,"PREV-RECORD|FORM"					: "gfkmClickOnPrevRecord"
	,"NEXT-RECORD|FORM"					: "gfkmClickOnNextRecord"
	,"FOCUS-MENU|FORM"      				: "gfkmFocusOnMenuShortCut"
	,"HTML-MENU|FORM"       				: "showHtmlMenu"
	,"SHOW-COOKIE|FORM"					: "showCookies"
	,"HTML-MEMOPAD|FORM"					: "showHeaderMemopad"
	,"HTML-KEYMAPS|FORM"					: "showKeymaps"
	,"BG-MENU|FORM"						: "showBackgroundMenu"
	,"CYY-CONVERTER|FORM"					: "showCurrencyconverter"
	,"FORM-ACCEPT|FORM"					: "gfkmClickOnGoOkAccept"
	,"COPY-RECORD|FORM"					: "copyToNextRecord"
	,"SHOW-HELP|FORM"       				: "showHelpFileForMenu"
	,"REFRESH|FORM"         				: "refreshPrecArray"
	,"FOCUS-BUTTON|FORM"					: "gfkmFocusOnButton"
	,"FORM-SIGNATURE|FORM"					: "showSign"
	,"PREVIOUS|FORM"					: "showTopRecord"
	,"NEXT|FORM"						: "showBottomRecord"
	,"SEARCH|FORM"						: "showSearchPopUp"
	,"NEXT-TAB|FORM"					: "goToNextTab"
	,"PREV-TAB|FORM"					: "goToPrevTab"
	,"EXPLODE|FORM"						: "showRecordOnExplode"
	,"SHOW-VERSION|FORM"					: "showVersion"
    	,"PREV-PAGE|FORM"                			: "goToPrevPage"
    	,"NEXT-PAGE|FORM"                			: "goToNextPage"
		,"AUDIT|FORM"                               : "showAudit"
		,"AUDIT-INFO|FORM" :"showAuditInfo"
    ,"HRINBX-MENU|FORM"				: "showHRINBXMenu"
}

/* Mapping of F1 for help */

function showHelpFileForMenu()
{
	var imgs = document.images;
	var totalImgs = imgs.length;
	var id;
	var hotKeyId;
	for(i=0;i<totalImgs;i++)
	{
		hotKeyId = imgs[i].getAttribute("hotKeyId");
		/*Checks for the image having hotKeyId as "finHelp",if found click the image*/
		if(hotKeyId == 'finHelp' )
		{
			clickImage(imgs[i]);
			break;
		}

	}
}

/* Function coded to show keymaps (Ctr+K) */

function showKeymaps(event) {
	/*here keyCode is assigned a false value so that when a Ctrl+<key> combination is pressed the character does not get printed*/
	preventDefaultAction(event);
	event.returnValue = false;
	hkpCtrlKeyDown = false;
	showHelpFile('hotkeys.htm');
}

/* Function coded to show Background Menu (Ctr+B) */

function showBackgroundMenu(event) {
	/*here keyCode is assigned a false value so that when a Ctrl+<key> combination is pressed the character does not get printed*/
	preventDefaultAction(event);
	event.returnValue = false;
	hkpCtrlKeyDown = false;

	if (eval(isBackGround) != undefined && !isBackGround)
	{
		fnMenuHdr('showbglist');
	}
	else if(eval(isBackGround) != undefined && isBackGround)
	{
		exitBgMenu();
	}
}

/* Function coded to show Memopad (Ctr+D) */

function showHeaderMemopad() {
    hkpCtrlKeyDown = false;
    var frm = document;
    var elements = frm.links;
    var totalElements = elements.length;
    for(i=0;i<totalElements;i++)
    {
		var name = elements[i].id;
		if(name == 'anc_hdrm')
		{
			fnMenuHdr('showmemopad');
		}
		if(name == 'anc_hmemo')
		{
			exitMemopad();
		}
	}

}

/* Function coded to show Currencyconverter pop-up (Ctr+Y) */

function showCurrencyconverter(event) {
	/*here keyCode is assigned a false value so that when a Ctrl+<key> combination is pressed the character does not get printed*/
	preventDefaultAction(event);
	event.returnValue = false;
	hkpCtrlKeyDown = false;

	var frm = document.forms[0];
	var elements = frm.elements;
	var totalElements = elements.length;
	for(i=0;i<totalElements;i++)
	{
		var name = elements[i].name;
		if(name == 'ccyconverterpopup')
		{
			parent.window.close();
			break;
		}
		else
		{
			showCrncyConverter();
			break;
		}
	}
}

function showVersion() {
	hkpCtrlKeyDown = false;
	displayFinacleVersion();
}


/* To bring the focus on Menu Shortcut (Ctr+M)*/

function gfkmFocusOnMenuShortCut(){
	hkpCtrlKeyDown = false;
	var frm = document.forms[0];
	if( (frm.menuName != undefined) && (frm.menuName != null) )
		frm.menuName.focus();
}

/* To activate Cancle Back and close Button through hotkeys  (F3) */
/* the elements from the form are picked up. element type is checked to find if its of
   type button, the hotKeyId of the button is picked and compared with 'Cancel' if yes
   then that button is clicked*/

function gfkmClickOnCancleBackClose(event) {

    /* get event source */
	evtSource = fnGetEventSource(event);

	/* get associated  block for event source object */

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");

	var frm = document.forms[0];
	var elements = frm.elements;
	var totalElements = elements.length;
	var id;
	var hotKeyId;
	var flag = true;
	for(i=0;i<totalElements;i++)
	{
		if(elements[i].type == 'button')
		{
			hotKeyId = elements[i].getAttribute("hotKeyId");
			if(hotKeyId == 'Cancel'  && !(elements[i].disabled == true || elements[i].style.display == "none"))
			{
				id = elements[i];
				if(blockName == elements[i].getAttribute("blockName") || blockName == elements[i].getAttribute("fblk"))
				{
					flag = false;
					id.focus();
					elements[i].click();
					break;
				}
			}
		}
	}
	/*if there is only one block present, the array read would give an undefined.
	  So, this code will click the lone CANCEL button present at the form level.*/
	if(flag && id != undefined)
	{
		id.focus();
		id.click();
	}
}


/* To activate Go Ok and Accept Button through hotkeys (F4)*/
/* the elements from the form are picked up. element type is checked to find if its of type
   button, the hotKeyId of the button is picked and compared with 'Go' if yes then that
   button is clicked*/

function gfkmClickOnGoOkAccept(event) {
	var frm = document.forms[0];
	var elements = frm.elements;
	var totalElements = elements.length;
	var id;
	var hotKeyId;
	var flag = true;
    /* get event source */
	evtSource = fnGetEventSource(event);

	/* get associated  block for event source object */

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");
	/*--------Stopping the Control when Invalid Date is Entered--------------*/
	if(evtSource.getAttribute("fdt")=='uidate' || evtSource.getAttribute("fdt")=='datetime' || evtSource.getAttribute("fdt")=='date')
	{
		if(fnEventFormatDate(evtSource)==false)
		{
			return false;
		}
	}

	for(i=0;i<totalElements;i++)
	{
		if(elements[i].type == 'button')
		{
			hotKeyId = elements[i].getAttribute("hotKeyId");
			if(hotKeyId == 'Go'  && !(elements[i].disabled == true || elements[i].style.display == "none"))
			{
				id = elements[i];
				if(blockName == elements[i].getAttribute("blockName") || blockName == elements[i].getAttribute("fblk"))
				{
					flag = false;
					id.focus();
					id.click();
					break;
				}
			}
		}
	}
	/*if there is only one block present, the array read would give an undefined.
	  So, this code will click the lone Go/Accept/Ok button present at the form level.*/
	if(flag && id != undefined)
	{
		id.focus();
		id.click();
	}
}
/* Mapping of F9 for signature (Only for FAB Screens) */

function showSign()
{
	var imageCounter;
	var totalImages = document.images.length;
	for(imageCounter = 0; imageCounter < totalImages; imageCounter++)
	{
		var curcss = document.images[imageCounter];
		if(curcss != null){
			var len = curcss.src.length;
			var firstIndex = curcss.src.lastIndexOf('/');
			var imageName = curcss.src.substring(firstIndex+1);
			if(imageName == "sig_new1.gif")
			{
				showFinacleSignature();
				break;
			}
		}
	}
}

/* To activate up arrow (Multirec)*/

function showTopRecord(event)
{

	if(elementFocus!=null)
	{
		elmntid = parseint(elementFocus.id) - 1;
		if(elmntid >= 0)
		{
			var id = document.getelementbyid(elmntid.tostring());
			id.focus();
			elementFocus = null;
		}
	}
	else
	{
		/* get event source */
		evtsource = fnGetEventSource(event);

		var flag = true;
		var id;

		var blockName = evtSource.getAttribute("blockname");
		if((blockName == null)||(blockName == ""))
			blockName = evtSource.getAttribute("fblk");

		/*If the focus is inside textarea or a select tag a click wont be made.
	          Pageup/Pagedown have their own object specific meaning inside textarea/select tags.
	          Page Up/Down will be used to scroll up and down within these elements.*/

		var imgs = document.images;
		var totalImgs = imgs.length;
		var hotKeyId;

		for(i=0;i<totalImgs;i++)
		{
			hotKeyId = imgs[i].getAttribute("hotKeyId");

			if(hotKeyId == 'Up')
			{
				id = imgs[i];
				if(!(blockName == null)||(blockName == ""))
				{
					if(blockName == imgs[i].getAttribute("blockName") || blockName == imgs[i].getAttribute("fblk"))
					{
						flag = false;
						imgs[i].click();
						break;
					}
				}
			}
		}
		/*if there is only one block present, the array read would give an undefined.
		So, this code will click the lone Up arrow present at the form level.*/
		if(flag && id != undefined)
		{
			id.click();
		}
	}
}

/* To activate down arrow (Multirec)*/

function showBottomRecord(event)
{
	if(elementFocus!=null)
	{
		var totalLinks = parseInt(elementFocus.getAttribute("hotKeyId"));
		var elmntId = parseInt(elementFocus.id) + 1;
		if(elmntId < totalLinks)
		{
			var id = document.getElementById(elmntId.toString());
			id.focus();
			elementFocus = null;
		}
	}
	else
	{
		/* get event source */
		evtSource = fnGetEventSource(event);

		var flag = true;
		var id;

		var blockName = evtSource.getAttribute("blockname");
		if((blockName == null)||(blockName == ""))
			blockName = evtSource.getAttribute("fblk");

		/*If the focus is inside textarea or a select tag a click wont be made.
		  Pageup/Pagedown have their own object specific meaning inside textarea/select tags.
	          Page Up/Down will be used to scroll up and down within these elements.*/

		var imgs = document.images;
		var totalImgs = imgs.length;
		var hotKeyId;

		for(i=0;i<totalImgs;i++)
		{
			hotKeyId = imgs[i].getAttribute("hotKeyId");

			if(hotKeyId == 'Down')
			{
				id = imgs[i];
				if(!(blockName == null)||(blockName == ""))
				{
					if(blockName == imgs[i].getAttribute("blockName") || blockName == imgs[i].getAttribute("fblk"))
					{
						flag = false;
						imgs[i].click();
						break;
					}
				}
			}
		}
		/*if there is only one block present, the array read would give an undefined.
		So, this code will click the lone Down arrow present at the form level.*/
		if(flag && id != undefined)
		{
			id.click();
		}
	}
}


/* To activate the corresponding search adjacent to focused text box  on clicking  F2 */

function showSearchPopUp(event)
{
	var searchLink = fnGetEventSource(event);
	if(searchLink != null)
	{
		var srcHotKeyId = searchLink.getAttribute("hotKeyId");
		var imgs = document.images
		var totalImgs = imgs.length;

		var hotKeyId;
		for(i=0;i<totalImgs;i++)
		{
			hotKeyId = imgs[i].getAttribute("hotKeyId");
			if(hotKeyId != undefined && hotKeyId == srcHotKeyId && !(imgs[i].parentNode.style.display == "none" || imgs[i].style.display == "none"))
			{
        imgs[i].parentNode.focus();
				clickImage(imgs[i]);
				break;
			}
		}
	}
}


/* shift the focus on first button (focus after the menushort cut button)   (F12) */

function gfkmFocusOnButton()
{
	var frm = document.forms[0];
	var elements = frm.elements;
	var totalElements = elements.length;
	for(i=0;i<totalElements;i++)
	{
		if(elements[i].type == 'button')
		{

			var str = elements[i].name;
			if(str == null || str == undefined || str == "")
			{
				str = elements[i].id;
			}
			if((str != 'gotomenu') && (elements[i].disabled == false))
			{
				frm[str].focus();
				break;
			}
		}
	}
}

/* Function added to show HTML menu (Ctr+N) */

function showHtmlMenu(event){
	/*here keyCode is assigned a false value so that when a Ctrl+<key> combination is pressed the character does not get printed*/
	preventDefaultAction(event);
	event.returnValue = false;
	hkpCtrlKeyDown = false;

	var frm = document;

	if(frm != null && frm != undefined)
	{
		var elements = frm.links;
		if(elements != null && elements != undefined)
		{
			var totalElements = elements.length;
			for(i=0;i<totalElements;i++)
			{
				var name = elements[i].id;
				if(name == 'anc_html')
				{
					mKeyPress();

				}
				if(name == 'sidepane')
				{
					parent.flag = true;
					if(parent.document.getElementById("menutree") != undefined)
					{
						parent.document.getElementById("menutree").style.display="none";
					}
					if(parent.document.getElementById("mtitle_tab") != undefined)
					{
						parent.document.getElementById("mtitle_tab").style.display="none";
					}
				}
			}
		}
	}
	return;
}

/* To activate Submit Button. (F10)*/
/* the elements from the form are picked up. element type is checked to find if its of type
   button,the hotKeyId of the button is picked and compared with 'Submit' if yes then that
   button is clicked*/

function gfkmClickOnFormSubmit(event){
	var frm = document.forms[0];
	var elements = frm.elements;
	var totalElements = elements.length;
	var id;
	var hotKeyId;
	var flag = true;
   	 /* get event source */
	evtSource = fnGetEventSource(event);

	/* get associated  block for event source object */

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");

	for(i=0;i<totalElements;i++)
	{
		if(elements[i].type == 'button')
		{
			hotKeyId = elements[i].getAttribute("hotKeyId");

			if(hotKeyId == 'Submit' && !(elements[i].disabled == true || elements[i].style.display == "none"))
			{
				id = elements[i];
				if(blockName == elements[i].getAttribute("blockName") || blockName == elements[i].getAttribute("fblk"))
				{
					flag = false;
					id.focus();
					id.click();
					break;
				}
			}
		}
	}
	/*if there is only one block present, the array read would give an undefined.
	  So, this code will click the lone Submit button present at the form level.*/
	if(flag && id != undefined)
	{
		id.focus();
		id.click();
	}
}

/* To activate left arrow for pagination following code is added.(PAGE-UP) */

function gfkmClickOnPrevRecord(event){

	var evtSource = fnGetEventSource(event);
	var id;

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");
	/*If the focus is inside textarea or a select tag a click wont be made.
	  Pageup,Pagedown have their own object specific meaning inside textarea,select tags.
	  Page Up,Down will be used to scroll up and down within these elements.*/
	if(evtSource.tagName !='TEXTAREA' && evtSource.tagName != 'SELECT')
	{
		var imgs = document.images;
		var totalImgs = imgs.length;
		var hotKeyId;

		for(i=0;i<totalImgs;i++)
		{
			hotKeyId = imgs[i].getAttribute("hotKeyId");

			if(hotKeyId == 'Prev')
			{
				id = imgs[i];
				if(!(blockName == null)||(blockName == ""))
				{
					if(blockName == imgs[i].getAttribute("blockName") || blockName == imgs[i].getAttribute("fblk"))
					{
						imgs[i].parentNode.focus();
						clickImage(imgs[i]);
						return;
					}
				}
			}
		}
		/*if there is only one block present, the array read would give an undefined.
	  	  So, this code will click the lone Previous arrow present at the form level. If
	  	  Previous image is found, it will perform a click on it and exit the function. */
		if(id != undefined)
		{
			id.parentNode.focus();
			clickImage(id);
			return;
		}
		/* If no Previous image has been found, a search will be made for Previous buttons. If
		   a Previous button is found, it will be clicked. If even a Previous button is not present,
		   no action will be taken. */
			var frm = document.forms[0];
			var elements = frm.elements;
			var totalElements = elements.length;

			for(i=0;i<totalElements;i++)
			{
				if(elements[i].type == 'button')
				{
					hotKeyId = elements[i].getAttribute("hotKeyId");

					if(hotKeyId == 'Prev' && !(elements[i].disabled == true || elements[i].style.display == "none"))
					{
						id = elements[i];
						if(blockName == elements[i].getAttribute("blockName") || blockName == elements[i].getAttribute("fblk"))
						{
							id.focus();
							elements[i].click();
							return;
						}
					}
				}
			}
			/*if there is only one block present, the array read would give an undefined.
			  So, this code will click the lone Previous button present at the form level.*/
			if(id != undefined)
			{
				id.focus();
				id.click();
				return;
			}


	}

}

/* To activate right arrow for pagination following code is added. (PAGE-DOWN)*/

function gfkmClickOnNextRecord(event){

	var evtSource = fnGetEventSource(event);
	var hotKeyId;
	var id;

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");
	/*If the focus is inside textarea or a select tag a click wont be made.
	  Pageup,Pagedown have their own object specific meaning inside textarea,select tags.
	  Page Up,Down will be used to scroll up and down within these elements.*/
	if(evtSource.tagName!='TEXTAREA' && evtSource.tagName != 'SELECT')
	{
		var imgs = document.images;
		var totalImgs = imgs.length;

		for(i=0;i<totalImgs;i++)
		{
			hotKeyId = imgs[i].getAttribute("hotKeyId");

			if(hotKeyId == 'Next')
			{
				id = imgs[i];
				if(!(blockName == null)||(blockName == ""))
				{
					if(blockName == imgs[i].getAttribute("blockName") || blockName == imgs[i].getAttribute("fblk"))
					{
						imgs[i].parentNode.focus();
						clickImage(imgs[i]);
						return;
					}
				}
			}
		}
		/*if there is only one block present, the array read would give an undefined.
	  	  So, this code will click the lone Next arrow present at the form level. If
	  	  Next image is found, it will perform a click on it and exit the function. */
		if(id != undefined)
		{
			id.parentNode.focus();
			clickImage(id);
			return;
		}
		/* If no Next image has been found, a search will be made for Next buttons. If
		   a Next button is found, it will be clicked. If even a Next button is not present,
		   no action will be taken. */

			var frm = document.forms[0];
			var elements = frm.elements;
			var totalElements = elements.length;

			for(i=0;i<totalElements;i++)
			{
				if(elements[i].type == 'button')
				{
					hotKeyId = elements[i].getAttribute("hotKeyId");

					if(hotKeyId == 'Next' && !(elements[i].disabled == true || elements[i].style.display == "none"))
					{
						id = elements[i];
						if(blockName == elements[i].getAttribute("blockName") || blockName == elements[i].getAttribute("fblk"))
						{
							id.focus();
							elements[i].click();
							return;
						}
					}
				}
			}
			/*if there is only one block present, the array read would give an undefined.
			  So, this code will click the lone Next button present at the form level.*/
			if(id != undefined)
			{
				id.focus();
				id.click();
				return;
			}

	}
}

function gfkmResourceOnReturnBack(){
		var frm = document.forms[0];
		if( (frm.back != undefined) && (frm.back != null) )
			frm.back.click();
}
function gfkmResourceOnFormValidate(){
	var frm = document.forms[0];
	if( (frm.Validate != undefined) && (frm.Validate != null) )
		frm.Validate.click();
}
function gfkmResourceOnFormCancel(){
	var frm = document.forms[0];
	if( (frm.Cancel != undefined) && (frm.Cancel != null) )
		frm.Cancel.click();
}
function gfkmResourceOnFormSave() {
    var frm = document.forms[0];
    if( (frm.Save != undefined) && (frm.Save != null) )
        frm.Save.click();
}
function gfkmResourceOnPrintDate(event){
	/*here keyCode is assigned a false value so that when a Ctrl+<key> combination is pressed the character does not get printed*/
	preventDefaultAction(event);
	event.returnValue = false;
	hkpCtrlKeyDown = false;

	var frm = document.forms[0];
	var sUrl;
	var srcObject = arguments[1];
	var srcName = srcObject.getAttribute('name');
	var srcObjectDataType = srcObject.getAttribute('fdt');


	//Ctrl-X feature for fab menu options not supported.
	//CTRL-X FOR FAB MENU OPTIONS

	/*if (srcObjectDataType == "accountidFAB"){
		alert(finbranchResArr.get("FAT001218"));
		srcObjectDataType.focus();
	}*/


	// CTRL-X IMPLEMENTATION STARTS

	if (srcObjectDataType == "accountid" || srcObjectDataType == "accountidFAB"){
	if (srcObject.value == null || srcObject.value == ""){
		alert(finbranchResArr.get("FAT000131"));
		srcObject.focus();
	}
	else {
		sUrl = "../arjspmorph/INFENG/search_dispIBAN.jsp?wForacid="+srcObject.value;
		if(window.showModalDialog)
			var retVal = window.showModalDialog(jsUtil.formatUrl(sUrl),"","dialogWidth:27;dialogHeight:12.25;status=no;toolbar=no;menubar=no;resizable=no");
		else
			window.open(jsUtil.formatUrl(sUrl),"","dialogWidth:27;dialogHeight:12.25;status=no;toolbar=no;menubar=no;resizable=no");
	}
	}	// end of main if..

	// CTRL-X IMPLEMENTATION ENDS

	//TO-PRINT MAXIMUM-AMT

	if( (srcObject != null && srcObject != undefined) &&
	(srcObject.type == "text" && !srcObject.readOnly && !srcObject.disabled))
	{
    if (srcObjectDataType == "amount") {
        writeMaximumAmount(srcObject);
        return;
    }

       if (srcObjectDataType == "unit") {
            writeMaximumUnit(srcObject);
            return;
    }

	if((srcObjectDataType == null)||(srcObjectDataType == "")||(srcObjectDataType != 'uidate'))
	{
		srcObjectDataType = srcObject.getAttribute('datatype');
		if((srcObjectDataType == null)||(srcObjectDataType == "")||(srcObjectDataType != 'date')) return;
	}
	srcObject.value=fnConvertToUIDate(BODDate);
	fnAssignDateOnEnter(srcObject);
  }
}
function gfkmResourceOnFocus(event)
{
	evtSource = fnGetEventSource(event);

	if( (evtSource != null && evtSource != undefined)
		&& (evtSource.type == "text" && !evtSource.readOnly && !evtSource.disabled)
		|| (evtSource.type == "select-one" && !evtSource.readOnly && !evtSource.disabled)
		|| (evtSource.type == "textarea" && !evtSource.readOnly && !evtSource.disabled)
		|| (evtSource.type == "radio" && !evtSource.readOnly && !evtSource.disabled)
		|| (evtSource.type == "checkbox" && !evtSource.readOnly && !evtSource.disabled))
	{
		fnResetFormControlColor(evtSource);
		fnSetFormControlColor(evtSource);
		currentFocusId = evtSource.id;
	}
	
	if (window.navigator.appVersion.indexOf("MSIE") == -1)
	{
		if (modalWin!=null && !modalWin.closed)
		{
			self.blur();
			modalWin.focus();
		}
	}
}
function fnResetFormControlColor(evtSource)
{
	var tmpFrmObj = evtSource.form;
	for(iCtr = 0; iCtr < tmpFrmObj.elements.length; iCtr++)
  	{
		var obj = tmpFrmObj.elements[iCtr];
		if(obj.type == "text" || obj.type == "select-one" || obj.type == "textarea" || obj.type == "radio" || obj.type == "checkbox")
		{
			tmpFrmObj.elements[iCtr].style.filter = NORMAL_COLOR;
		}

	}
}
function fnSetFormControlColor(evtSource)
{
	if("Microsoft Internet Explorer" == navigator.appName)
			evtSource.style.filter = HIGHLIGHT_COLOR;
	else
		evtSource.style.backgroundColor = '#eeeeee';
}
function refreshPrecArray()
{
	var frm = document.forms[0];
	if(confirm(finbranchResArr.get("FAT000514"))==true)
	{
		sendDataToRefreshPrecArray('RFRMNU','F');
		self.location.reload();
	}
}
function sendDataToRefreshPrecArray(fetchId, precedence)
{
	var sUrl = "../arjspmorph/"+applangcode+"/frm_fetch.jsp?fetchId="+fetchId+"&precedence="+precedence;
	var xMax = screen.width, yMax = screen.height;
	var xOffset = (xMax - 120), yOffset = (yMax - 150);
	var params = "dialogWidth=0px;dialogHeight=0px;dialogLeft="+xOffset+"px;dialogTop="+yOffset+"px";

	if(!window.showModalDialog)
	{
		window.open(jsUtil.formatUrl(sUrl),"title","width=10px,height=10px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,scrollbars=yes,toolbar=no,menubar=no,help=no");
	}else{
	var retval = window.showModalDialog(jsUtil.formatUrl(sUrl),document.forms[0],params);
	}
}
function copyToNextRecord()
{
	var frm = document.forms[0];
	if( (frm.next != undefined) && (frm.next != null) )
	{
		if(frm.copyRecordFlg != undefined && frm.copyRecordFlg != null)
			frm.copyRecordFlg.value = 'Y';
		frm.next.click();
	}
}

/* Function added to invoke explode functionality (Ctr+E) */
function showRecordOnExplode(event)
{
preventDefaultAction(event);
event.returnValue = false;
var searchLink = fnGetEventSource(event);
if(searchLink != null)
{
	var srcExplodeId = searchLink.getAttribute("explodeId");
	var imgs = document.images
	var totalImgs = imgs.length;

	var explodeId;
	for(i=0;i<totalImgs;i++)
	{
		explodeId = imgs[i].getAttribute("explodeId");
		if(explodeId != undefined && explodeId == srcExplodeId && imgs[i].parentNode.style.display != "none")
		{
			hkpCtrlKeyDown	= false;
			clickImage(imgs[i]);
			break;
		}
	}
}
}

/* To activate Validate Button through hotkeys (SHIFT+F11)*/
/* the elements from the form are picked up. element type is checked to find if its of type
   button, the hotKeyId of the button is picked and compared with 'Validate' if yes then
   that button is clicked*/
function gfkmClickOnValidate(event) {
	var frm = document.forms[0];
	var elements = frm.elements;
	var totalElements = elements.length;
	var id;
	var hotKeyId;
	var flag = true;
    /* get event source */
	evtSource = fnGetEventSource(event);

	/* get associated  block for event source object */

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");


	for(i=0;i<totalElements;i++)
	{
		if(elements[i].type == 'button')
		{
			hotKeyId = elements[i].getAttribute("hotKeyId");
			if(hotKeyId == 'Validate'  && !(elements[i].disabled == true || elements[i].style.display == "none"))
			{
				id = elements[i];
				if(blockName == elements[i].getAttribute("blockName") || blockName == elements[i].getAttribute("fblk"))
				{
					flag = false;
					hkpShiftKeyDown = false;
					id.focus();
					id.click();
					break;
				}
			}
		}
	}
	/*if there is only one block present, the array read would give an undefined.
	  So, this code will click the lone Validate button present at the form level.*/
	if(flag && id != undefined)
	{
		hkpShiftKeyDown = false;
		id.focus();
		id.click();
	}
}

/* To activate up arrow to go to Previous Page (Multirec)*/

function goToPrevPage()
{

    if(elementFocus!=null)
    {
        elmntId = parseInt(elementFocus.id) - 1;
        if(elmntId >= 0)
        {
            var id = document.getElementById(elmntId.toString());
            id.focus();
            elementFocus = null;
        }
    }
    else
    {
        var flag = true;
        var id;

        /*If the focus is inside textarea or a select tag a click wont be made.
              Pageup/Pagedown have their own object specific meaning inside textarea/select tags.
              Page Up/Down will be used to scroll up and down within these elements.*/

        var imgs = document.images;
        var totalImgs = imgs.length;
        var hotKeyId;

        for(i=0;i<totalImgs;i++)
        {
           	hotKeyId = imgs[i].getAttribute("hotKeyId");

		if(hotKeyId == 'PrevPage')
		{
			id = imgs[i];
			if(!(blockName == null)||(blockName == ""))
			{
				if(blockName == imgs[i].getAttribute("blockName") || blockName == imgs[i].getAttribute("fblk"))
				{
					flag = false;
					imgs[i].click();
					break;
				}
			}
		}
	}
        /*if there is only one block present, the array read would give an undefined.
        So, this code will click the lone Up arrow present at the form level.*/
        if(flag && id != undefined)
        {
            id.click();
        }
    }
}
/* To activate up arrow to go to Next Page (Multirec)*/

function goToNextPage(event)
{

    if(elementFocus!=null)
    {
	var totalLinks = parseInt(elementFocus.getAttribute("hotKeyId"));
	var elmntId = parseInt(elementFocus.id) + 1;
	if(elmntId < totalLinks)
	{
	     var id = document.getElementById(elmntId.toString());
	     id.focus();
	     elementFocus = null;
	}
    }
    else
    {
	/* get event source */
	evtSource = fnGetEventSource(event);

        var flag = true;
        var id;

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");

        /*If the focus is inside textarea or a select tag a click wont be made.
              Pageup/Pagedown have their own object specific meaning inside textarea/select tags.
              Page Up/Down will be used to scroll up and down within these elements.*/

        var imgs = document.images;
        var totalImgs = imgs.length;
        var hotKeyId;

        for(i=0;i<totalImgs;i++)
        {
            	hotKeyId = imgs[i].getAttribute("hotKeyId");

		if(hotKeyId == 'NextPage')
		{
			id = imgs[i];
			if(!(blockName == null)||(blockName == ""))
			{
				if(blockName == imgs[i].getAttribute("blockName") || blockName == imgs[i].getAttribute("fblk"))
				{
					flag = false;
					imgs[i].click();
					break;
				}
			}
		}
        }
        /*if there is only one block present, the array read would give an undefined.
        So, this code will click the lone Up arrow present at the form level.*/
        if(flag && id != undefined)
        {
            id.click();
        }
    }
}

function showAudit(event)
{
	var frm = document.forms[0];
	var elements = frm.elements;
	var totalElements = elements.length;
	var id;
	var hotKeyId;
	var flag = true;
	/* get event source */
	evtSource = fnGetEventSource(event);

	/* get associated  block for event source object */

	var blockName = evtSource.getAttribute("blockname");
	if((blockName == null)||(blockName == ""))
		blockName = evtSource.getAttribute("fblk");

	for(i=0;i<totalElements;i++)
	{
		hotKeyId = elements[i].getAttribute("hotKeyId");

		if(hotKeyId == 'Audit' && !(elements[i].disabled == true || elements[i].style.display == "none"))
		{
			id = elements[i];
			if(blockName == elements[i].getAttribute("blockName") || blockName == elements[i].getAttribute("fblk"))
			{
				flag = false;
				id.focus();
				id.click();
				break;
			}
		}
	}

	/*if there is only one block present, the array read would give an undefined.
	  So, this code will click the lone ViewAudit button present at the form level.*/

	if(flag && id != undefined)
	{
		id.focus();
		id.click();
	}
}


function showAuditInfo(event)
{

	var frm = document.forms[0];

	if(frm != null && frm != undefined)
	{
					var screenName;
					var fieldCtrl =document.getElementsByName("screenName");
					if(undefined != fieldCtrl[0] && null != fieldCtrl[0])
					{
						screenName = fieldCtrl[0].value;
					}

					if(undefined != screenName && null != screenName)
					{
						var sUrl = "../arjspmorph/"+applangcode+"/audit_info.jsp?&screenName="+screenName;

						var fieldName= fnGetEventSource(event);
						var fieldId=fieldName.id;
						if(undefined != fieldId && null!=fieldId)
						{
							sUrl += "&fieldName="+fieldId;
						}

						if("Netscape" == browser_name)
						{
							event.preventDefault();
						}

						var xOffset = 100, yOffset =  100;
						window.open(jsUtil.formatUrl(sUrl),"title","width=700px,height=100px,modal=yes,top="+yOffset+"px,left="+xOffset+"px,menubar=no,help=no");
						
					}
		}


}
/* New function added for making image click event compatible with IE, Mozilla
 * and netscape */
 function clickImage(img) {
  	var funcName;
	var hrefVal = img.parentNode.href;
	if(hrefVal != null || hrefVal != undefined)
	{
		if(hrefVal.indexOf("javascript") != -1 || hrefVal.indexOf("Javascript") != -1)
			hrefVal = hrefVal.substring(11,hrefVal.length);
		
		funcName = "this."+ hrefVal;
		
		if(eval(funcName) != undefined)
			eval(funcName).call(this);
	}
}
/* New function to prevent default action of the browser function
* */
function preventDefaultAction(event) {
	if (navigator.appName == "Microsoft Internet Explorer")
		event.keyCode = NO_KEY;
	else
		event.preventDefault();
}
function showHRINBXMenu(event){
         handleMenuDisplay('HRINBX', true, null,'Go');
}
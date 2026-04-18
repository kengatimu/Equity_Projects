document.write('<script language=javascript src="'+applPath+'/corpcif/js/Message_corpcif_'+finaclecrmlocale+'.js">'+'<\/script>');
document.write('<script type="text/javascript" src="'+applPath+'/common/js/ClientResourceBundle_'+finaclecrmlocale+'.js" language="javascript"></script>');
/**********ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
/* including a file having conversion logic*/
document.write('<script type="text/javascript" src="'+applPath+'/common/js/Rendcommon.js" language="javascript"></script>');
 document.write('<script type="text/javascript" src="'+applPath+'/common/js/Reduce_Form.js" language="javascript"></script>');
 /*************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
var arraydoc_Type = new Array();
var docCodearr = new Array();
var elemStr;
var dualflag;
var CIF_Type = "Corporate";
var docCode_CIFTypearr = new Array();
var docType_docCodearr=new Array();
var docCode_docDescarr=new Array();
var doc_TypeDescarr=new Array();
//changes for call id 371085 and recon of call id 369315 starts
var docCode_IDTypearr=new Array();
//changes for call id 371085 and recon of call id 369315 ends
elemStr = new String(doc_Type);
if (elemStr != "") {
	arraydoc_Type = elemStr.split("|");
}
elemStr = new String(docCode);
if (elemStr != "") {
	docCodearr = elemStr.split("|");
}
elemStr = new String(docCode_CIFType);
if (elemStr != "") {
	docCode_CIFTypearr = elemStr.split("|");
}
//changes for call id 371085 and recon of call id 369315 starts
elemStr = new String(doc_TypeDesc);
if (elemStr != "") {
	doc_TypeDescarr = elemStr.split("|");
}
elemStr = new String(docCode_docDesc);
if (elemStr != "") {
	docCode_docDescarr = elemStr.split("|");
}
elemStr = new String(docCode_IDType);
if (elemStr!= ""){
	docCode_IDTypearr= elemStr.split("|");
}
//changes for call id 371085 and recon of call id 369315 ends

elemStr = new String(docType_docCode);
if (elemStr!= ""){
	docType_docCodearr= elemStr.split("$");
}

 function initThis(tabName,reqParams,isPopup) {

	tempFrm.addPrimaryForm(tabName,"../servlet/com.infy.cis.ui.corpcif.CorpSQDE_CustomerSQDEDetForm?Params="+reqParams+"&isPopup="+isPopup,null);


	if(isPopup == 'No')
	{
		tempFrm.setButtonsVisible(true);
		tempFrm.setTabsVisible(true);
	}

}



function loadDocCode(listObj) {

	var selectedType = listObj.options[listObj.selectedIndex].value;
	var selIndex = listObj.options[listObj.selectedIndex];
	loadSelectList(document.getElementsByName("EntityDocumentBO.DocCode")[0],
			docCodearr, selectedType);
}

	var escChars = new Array(',');
	/*Tracker 159095 : Sonali begin of changes*/
	var escCharsAddr = new Array('%');
	/*Tracker 159095 : Sonali end of changes*/
	var updateIDDet = false;
	var editMode = false;
	var recordIndex1 = null;
	var servletURL = null;
	var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
	var updateAdrDet = false;
	var recordIndex = null;
	var lookupFor = '';
	var EDoc_identifier_type_Code     = new Array();
	var EDoc_unique_id                = new Array();
	var EDoc_placeofissue             = new Array();
	var EDoc_placeofissue_cat         = new Array();
	var EDoc_countryofissue           = new Array();
	var EDoc_countryofissue_cat       = new Array();
	var EDoc_dateofissue              = new Array();
	var EDoc_validity_date            = new Array();
	var EDoc_EntityDocumentID         = new Array();
	var EDoc_EntityDocumentURL        = new Array();
	var EDoc_URL                      = new Array();
	var EDoc_Status                   = new Array();
	var EDoc_detachedURLs             = new Array();
	var currIDTableRow      		= null;
	var IDArrayIndex        		= null;
	var IDRecordIndex       		= null;


	var EDoc_docCode          		= new Array();
	var EDoc_docDescr         		= new Array();
	var EDoc_docTypeCode      		= new Array();
	var EDoc_docTypeDescr     		= new Array();
	var EDoc_docReceivedDate  		= new Array();
	var EDoc_docRemarks       		= new Array();
	var EDoc_isMandatory      		= new Array();
	var EDoc_scanRequired     		= new Array();
	var EDoc_IsDirty                	= new Array();
	var EDoc_isDocumentVerified    		= new Array();
	var updateIDDet 				= false;
	var EDoc_idIssuedOrg			= new Array();//Fix for ticket 296523
	var currConcessionTableRow;
	var ConcessionPref    	= false;
	var ConcessioncreditDiscountPercentage	       	= new Array();
	var ConcessiondebitDiscountPercentage   	= new Array();
	var ConcessionwithTaxPercentage   		= new Array();
	var ConcessionwithTaxFloorLimit  		= new Array();
	var ConcessionpreferentialExpiryDate   		= new Array();
	var ConcessionCurrency   			= new Array();
	var ConcessionPsychoURL                		= new Array();
	var DeletedConcessioncreditDiscountPercentage   = new Array();
	var DeletedConcessiondebitDiscountPercentage   	= new Array();
	var DeletedConcessionwithTaxPercentage  	= new Array();
	var DeletedConcessionwithTaxFloorLimit        	= new Array();
	var DeletedConcessionpreferentialExpiryDate    	= new Array();
	var DeletedConcessionID                		= new Array();
	var lookupwindow_UB = null;
	var reserveCIFID="";
	var st="";
	/*Swift addess changes*/
	var SwiftName;
	var SwiftAddr1;
	var SwiftAddr2;
	var SwiftAddr3;
	var SwiftAddressDetails="";
	var edit ="";
// Ticket ID 349230 and tracker ID 213541 changes start ('Add Address' window issue)
var adrWindow = null;
// Ticket ID 349230 and tracker ID 213541 changes end ('Add Address' window issue)

/*Swift addess changes*/

            var addrType;
            var addrFlag ;
	    var introLookUpWin = null;
//Tracker 129381 changes start
var altLangActv =document.getElementsByName("altLocaleActv")[0].value;
//Tracker 129381 changes End

function closebtn(){
		if(corpURL==null || corpURL==''){
		parent.frames(0).location.href = parent.frames(0).location.href;
		}else{
			top.window.close();
		}
}

function formatCorpAmount(amtObj,dropObj,place) {
            formatAmount(amtObj,boName +".crncy_Code", place);
}

function clear() {
		/* Tracker ID 100035 Begin of Changes */
		if ((IntWFID != 'null') && (IntWFID != null) && (IntWFID != undefined) && (IntWFID != '')) {
		/* Tracker ID 100035 End of Changes */
			if (entityType == "Customer") {
				Updatedb(IntWFID,"Corp_Customer");
			} else if (entityType == "Propsect") {
				Updatedb(IntWFID,"Corp_Prospect");
			} else if (entityType == "Non Customer") {
				Updatedb(IntWFID,"Corp_Non_Customer");
			}
		}
		parent.parent.parent.parent.setButtonsVisible(true);
		//parent.frames(0).location.href = parent.frames(0).location.href;
		//changes for Ticket 367381
		document.location.reload(true);

}
function  clearLookupOne(type){
	if (type == "PRM"){
		document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value = "";
	}
	else if (type == "SRM"){
		document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value = "";
	}
  	else if (type == "Parent"){
		document.getElementsByName("CorporateBO.parent_CIF")[0].value = "";
	}
 	else if (type == "Group")	{
		document.getElementsByName("CorporateBO.Group_ID_Code")[0].value = "";
		document.getElementsByName("CorporateBO.group_ID")[0].value = "";
	}
	 else if (type == "RelCrea")	{
		document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].value = "";
	}else if (type == "DSAID")	{
			document.getElementsByName("CorporateBO.dsaID")[0].value = "";
	}
	else if (type == "Lastname")	{
		//Tracker 129381 changes start
		if(altLangActv=='true'){
			document.getElementsByName("CorporateRepBO.last_Name_alt1")[0].value = "";
		}
		//Tracker 129381 changes end
		document.getElementsByName("CorporateRepBO.last_Name")[0].value = "";
		document.getElementsByName("CorporateRepBO.dob")[0].value = "";
		document.getElementsByName("CorporateRepBO.entityKey")[0].value = "";
	}
	else if (type == "entityKey")	{
			//Tracker 129381 changes start

			//Tracker 129381 changes end
			//document.getElementsByName("CorporateRepBO.last_Name")[0].value = "";
		//	document.getElementsByName("CorporateRepBO.dob")[0].value = "";
			document.getElementsByName("CorporateRepBO.entityKey")[0].value = "";
	}
	else if (type == "str5")	{
	//Tracker 129381 changes start
	if(altLangActv=='true'){
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value = "";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].readOnly = false;
	}
	//Tracker 129381 changes end
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = "";
	document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = "";
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = "";
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = false;
	document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= false;
	}
if (type =="PRM" || type == "SRM" ) {
	setAgentValues();
}
}

function storeSegment() {
	defaultOwnerSegment=document.getElementsByName(boName+'.AccessOwnerSegment')[0].value;
	defaultPrimaryRM=document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value;
	defaultSecondaryRM=document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value;
}
function fnload(){


		try{
		//Changes for call id 399601 and recon of call id 395278 starts
		document.getElementsByName("CorporateBO.Address.country")[0].value =code_country;
		document.getElementsByName('CorporateBO.Address.state')[0].value = stateCode;
		document.getElementsByName('CorporateBO.Address.city')[0].value = cityCode;
		//Changes for call id 399601 and recon of call id 395278 ends
		//changes for ticket 688464 begin
		//Recon of RBS FS : 714946 SET4 starts
	if(sectorValue!=null && sectorValue!='null' && sectorValue!=''){
		if(document.getElementsByName("CorporateBO.sector")[0]!=undefined){
			document.getElementsByName("CorporateBO.sector")[0].value =sectorValue;
		}
	}
	if(segment!=null && segment!='null' && segment!=''){
		if(document.getElementsByName("CorporateBO.segment")[0]!=undefined){
			document.getElementsByName("CorporateBO.segment")[0].value =segment;
		}
	}
	if(preferredPhone!=null && preferredPhone!='null' && preferredPhone!=''){
		if(document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0]!=undefined){
			document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].value =preferredPhone;
		}
	}
	
	//Recon of RBS FS : 714946 SET4 ends
		//changes for ticket 688464 ends
	var obj = parent.parent.parent.parent.frames(3);
	obj.enableButton_Ub();
                //changes for tracker 392411
	obj.hideSaveButton('true');
}catch(e)
{ }

	document.getElementsByName('EntityDocumentBO.DocTypeCode')[0].value = docTypeCodeSel;
	loadTypeData1(document.getElementsByName("EntityDocumentBO.DocTypeCode")[0]);
	document.getElementsByName('EntityDocumentBO.DocCode')[0].value = docCodeSel;
	//Added for call id: 396777 starts - Recon of call 393939 starts
	s_loadTypeData1(document.getElementsByName("EntityDocumentBO.DocCode")[0]);
	//Added for call id: 396777 starts - Recon of call 393939 ends
	//document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value = uniqueId;
		try{
			var temp = document.getElementsByName(boName+".trade_Services_Availed")[0].value;
			document.getElementsByName(boName+".Purge_Allowed_Flag")[0].value = "N";
			if((temp == null)||(temp == "null")||(temp == ""))
			{
				document.getElementsByName(boNameCI+".TreasuryCounterParty")[0].value = "N";
				document.getElementsByName(boName+".trade_Services_Availed")[0].value = "N";
			}

		customLoad();
		}catch(e)
		{ }
		try{
			if(corpURL!=''){
				if(entityCreflg == 'N'){
					document.getElementsByName("CorporateBO.corp_Key")[0].disabled = false;
					document.getElementsByName("CorporateBO.corp_Key")[0].readOnly = false;
					document.getElementsByName("hid_cifid")[0].value = document.getElementsByName("CorporateBO.corp_Key")[0].value;
				}
			}
			else{

				if (keyGeneration == 'Both'|| (keyGeneration=="" && (isAutoGenKey== 'false' || isAutoGenKey == ''))) {
					document.getElementsByName("CorporateBO.corp_Key")[0].readOnly = false;
					if (keyGeneration != 'Both') {
						keyGeneration ='Manual';
					}
				}
			}
		}catch(e)
		{ }
		/* Changes by Elango to populate address start date*/
		locDate = getCurrentDate();		
											
	if(calType=='H')
	{	
	   locDate = convertGregToHij(locDate);
	}		
					
	document.getElementsByName('3_CorporateBO.Address.Start_Date')[0].value = locDate;


}
function selectProcess() {

      var entityType = "";
      if (document.frm2.mcJNDIFlag.value == "true"
                  && document.frm2.isMCEditedGeneral.value == "N") {
            appFlag = "false";
      }
      if (appFlag == 'true') {
            entityType = "CorporateMod";
      } else {
            entityType = "Corporate";
      }
      var corpId = parent.formSaveFrame.savedValue;
      window
                  .open(
                              '../../../servlet/com.infy.cis.ui.cif.CorpProcessSelectionDetWizard?entityId='
                                          + corpId + '&entityType=' + entityType
                                          + '&IntWFID=' + IntWFID + '&isPopup=Yes&SECUREHKEY='+hashkey+'&FLDHASHKEY='+fldhashkey,
                              'save',
                              'directories=No, height=436, left=210, top=120, width=575, location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
}

function sortMe(sortColumn,sortOrder)
{
// later.
}
function populateAccContAttr()
{
		if(trim(corpURL) == ""){
			document.getElementsByName("Cat_CorporateBO.primary_Service_Center")[0].value = Cat_bcName;
			document.getElementsByName("CorporateBO.primary_Service_Center")[0].value = bcName;
		}
	elem1=eval("document.getElementsByName(boName+'.accessOwnerGroup')[0]");
	for(i=0;i<elem1.options.length;i++)
		{
			if(elem1.options[i].value==priGrpID)
			{
			elem1.selectedIndex=i
			break;
			}
		}
	elem2=eval("document.getElementsByName(boName+'.accessOwnerSegment')[0]");
	for(i=0;i<elem2.options.length;i++)
		{
			if(elem2.options[i].value==priSegName)
			{
			elem2.selectedIndex=i
			break;
			}
		}
	setAccessOwnerGroup()
	setBCCodeValues('accessOwnerBC',primBCCODE,primBCID)
}
function validatePrimary(){
var cifType =  document.getElementsByName(boName+".CorpMiscellaneousInfo.str9")[0].value;
var cifID = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value;
var lastName = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value;
var cifDate = document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value;
	   	if(cifType!=null && cifType!=''){
			   		if((cifID =='')){
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
											MSGJ50115,'CorporateBO.CorpMiscellaneousInfo.str2','HYPER_LINK');
					parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			   		return "interactive";
			   		}
		}
	   	else if(cifID!=null && cifID!=''){
		   		if((lastName =='')){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,
									MSGJ50118,'CorporateBO.CorpMiscellaneousInfo.str5','HYPER_LINK');
	        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);

	   			return "interactive";
		   		}
	   			else if ((cifDate =='')){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,
									MSGJ50116,'3_CorporateBO.CorpMiscellaneousInfo.date1','HYPER_LINK');
	        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
	   			return "interactive";
	   			}
	    }
	   	else if(lastName!=null && lastName!=''){
	   			if((cifID =='')){
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
											MSGJ50115,'CorporateBO.CorpMiscellaneousInfo.str2','HYPER_LINK');
	        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
	   	   			return "interactive";
	   		   	}
	   	   		else if ((cifDate =='')){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,
									MSGJ50116,'3_CorporateBO.CorpMiscellaneousInfo.date1','HYPER_LINK');
	        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
	   	   			return "interactive";
	   			}
	  	}
	   	else if(cifDate!=null && cifDate!=''){
	   		if((cifID =='')){
					parent.parent.parent.parent.messageFrm.addMessage(selTabId,
											MSGJ50115,'CorporateBO.CorpMiscellaneousInfo.str2','HYPER_LINK');
	        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return "interactive";
	   		}
	   		if((lastName =='')){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId,
									MSGJ50118,'CorporateBO.CorpMiscellaneousInfo.str5','HYPER_LINK');
	        	parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			 	return "interactive";
		   	}
	   	}
	   	else{
	   	}
   return true
 }

function clearvalinprimary(){

//Tracker 129381 changes Start
if(altLangActv=='true'){
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value = "";
}
//Tracker 129381 changes End
 document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = "";
 document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = "";
 document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = "";
}


function clearval(){

 //Tracker 129381 changes Start

//Tracker 129381 changes End
 document.getElementsByName("CorporateRepBO.entityKey")[0].value = "";
disableCorpRep();
}

//Recon of changes  Callid :386529 ,390032
function loadseg(){

var len = document.getElementsByName("CorporateBO.segment")[0].options.length;
for(i =0;i<len;i++){
if(document.getElementsByName("CorporateBO.segment")[0].options[i].text == SegmentCorp){
document.getElementsByName("CorporateBO.segment")[0].options[i].selected = true;

break;
}
}
		
}

function onAddrSelect(){


		var addr = document.getElementsByName(boNameRep+".cifAddrEntity")[0].value;

		var x= document.frm2;
		for (var i=x.length - 1; i >-1; i--) {

			var e = x.elements[i];
			if(e.value == "Retail" && e.name == boNameRep+".cifAddrEntity"){
			temp = x.elements[i+4];
			x.elements[i+4].disabled = false;
			}
			else if((e.value == "Corporate" || e.value == "") && e.name == boNameRep+".cifAddrEntity"){
			x.elements[i+4].disabled = true;
			}
		}
		for(j=document.frm2.addressCategory.length-1;j>=0;j--)
		{
			document.frm2.addressCategory.remove(j);
		}
		if(addr == "Retail"){

		var mydata = new Array();


			for(i=0;i<RetAddr.length;i++){
				// Tracker ID: 122044 Changes START
				document.frm2.addressCategory[i+1] = new Option(RetAddr[i],RetAddr1[i]);
				// Tracker ID: 122044 Changes END
			}
			if(addressCategory == ""){
				document.getElementsByName("addressCategory")[0].value = "Mailing";
			}else{
				document.getElementsByName("addressCategory")[0].value = addressCategory;
			}
		}
		else if(addr == "Corporate"){

			for(i=0;i<CorpAddr.length;i++){
			// Tracker ID: 122044 Changes START
			document.frm2.addressCategory[i+1] = new Option(CorpAddr[i],CorpAddr1[i]);
			// Tracker ID: 122044 Changes END
			}
			if(addressCategory == ""){
				document.getElementsByName("addressCategory")[0].value ="Registered";
			}else{
				document.getElementsByName("addressCategory")[0].value = addressCategory;
			}
		}
		else if(addr == "") {
			document.frm2.addressCategory[document.frm2.addressCategory.length] = new Option('NONE','');
		}
		addressCategory ="";
	setFocusOnComp("addressCategory");
}


function onCIFSelect()
{

		var mydata = new Array();
		for(j=document.frm2.Corp.length-1;j>=0;j--)
		{
			document.frm2.Corp.remove(j);
		}
		document.frm2.Corp[0] = new Option('','');
		if(document.getElementsByName(boName+".CorpMiscellaneousInfo.str9")[0].value == "Retail")
		{
			for(j=0,i=1;i<forRet.length+1;i++,j++){
			document.frm2.Corp[i] = new Option(forRet[j],forRet1[j]);
			}
		}
		else if(document.getElementsByName(boName+".CorpMiscellaneousInfo.str9")[0].value == "Corporate")
		{
			for(j=0,i=1;i<forCorp.length+1;i++,j++){
			document.frm2.Corp[i] = new Option(forCorp[j],forCorp[j]);
			}
		}
		else{
			document.frm2.Corp[document.frm2.Corp.length] = new Option('','');
			}
		setFocusOnComp("Corp");
}
function MakeEnable()
{
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = "";
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = "";
	document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = "";
	var cifType = document.getElementsByName(boName+".CorpMiscellaneousInfo.str9")[0].value;
	if(cifType!=null && cifType!=''){
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].readOnly = true;
		enableLookup();
	}
	else{
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].readOnly = false;
		disableLookup();
	}
}
function disableLookup() {
	var eleLookupp = document.getElementsByName("btnone_CorporateBO.CorpMiscellaneousInfo.str2")[0];
	eleLookupp.style.visibility = "hidden";
var eleClear = document.getElementsByName("btntwo_CorporateBO.CorpMiscellaneousInfo.str2")[0];
	eleClear.style.visibility = "hidden";
}
function enableLookup() {
	var eleLookupp = document.getElementsByName("btnone_CorporateBO.CorpMiscellaneousInfo.str2")[0];
	eleLookupp.style.visibility = "";
	var eleClear = document.getElementsByName("btntwo_CorporateBO.CorpMiscellaneousInfo.str2")[0];
	eleClear.style.visibility = "";
}
function refreshParent(){
	frm = top.opener.parent.frames(1);
	frm.navigate (frm.location.href);
}

function shouldRefresh()
{
	return true;
}
function resubmit(){
	parent.parent.parent.parent.parent.parent.frames(0).submit();
}
function addAddressdetails()
{
	var getMCRequired=document.frm2.getMCRequired.value;
	updateAdrDet = false;
	var servletURL = "../servlet/com.infy.cis.ui.corpcif.CorpAddressForm_Det?getMCRequired="+getMCRequired;
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	// Ticket ID 349230 and tracker ID 213541 changes start ('Add Address' window issue)
	// docTypeNew = window.open(servletURL, '','height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	adrWindow = window.open(servletURL, 'AddrDetails','height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
	adrWindow.name = 'AddrDetails';
	// Ticket ID 349230 and tracker ID 213541 changes end ('Add Address' window issue)
}
function addIdendetails(dualflag)
{
	var getMCRequired=document.frm2.getMCRequired.value;
	updateIDDet = false;
	var servletURL = "../servlet/com.infy.cis.ui.common.EntityDocument_Det?mode=add&choice_nameIDType=ID_TYPE&getMCRequired="+getMCRequired+"&dual="+dualflag;
	wid=900;
	ht=360;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	docTypeNew = window.open(servletURL, 'IDDetails','height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+', location=no, menubar=no, resizable=no, status=no, toolbar=no,scrollbars=yes');
}
function addConcession(){
		ConcessionPref = false;
	wid=900;
	ht=260;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	var  InterestedProductsDetEdit = window.open('../servlet/com.infy.cis.ui.corpcif.CorpConcessionSelection?corpid=' + '<xsl:value-of select="$corpID"/>' , '', 'directories=No, height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+', location=no, menubar=no, resizable=no, status=no, toolbar=no, scrollbars=yes');
 }

function call(){
	for (i=0; i < document.all.AdrRecordSet.rows.length; i++) {
		var row_bgcolor=document.all.AdrRecordSet.rows(i).className;
		if ( row_bgcolor == 'rowHighLighted'){
			if ( i % 2 == 0) {
				document.all.AdrRecordSet.rows(i).className = 'color1';
			}
			else{
				document.all.AdrRecordSet.rows(i).className = 'color2';
			}
		}
	}
	if(event.srcElement.tagName == 'FONT' || event.srcElement.tagName == 'INPUT') {
		event.srcElement.parentElement.parentElement.className="rowHighLighted";
	}
	else if(event.srcElement.tagName == 'TD'){
		event.srcElement.parentElement.className="rowHighLighted";
	}
}
function changetoMillis(datevalue)
{
	if(datevalue.length == 0)
	{
		return 0;
	}
	else{
		var date1 = new Date(datevalue.substring(3,5) + "/" + datevalue.substring(0,2) + "/" + datevalue.substring(6,10));
		var millis = date1.valueOf();
		return millis;
	}
}

function save(corpsubmit)
{
	
	/** ********* PhoneEmail Co-Mandatory Validations *********** */
	// Phone Type
	var Filter_uniqueId = getCookie('Filter_uniqueId');
	var Filter_documentcode = getCookie('Filter_documentcode');
	var docType = document.getElementsByName("EntityDocumentBO.DocTypeCode")[0].value;
        var docCode = document.getElementsByName("EntityDocumentBO.DocCode")[0].value;
        
        document.frm2.currencyCode.value=Currency;
        
	
	if(document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].value != Filter_uniqueId || Filter_documentcode!=docCode)
	{
	alert("The identification document details do not match with the details entered in customer onboard menu");
	document.getElementsByName("EntityDocumentBO.ReferenceNumber")[0].focus();
	return "interactive";
	}
	if ((document.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.localCode")[0].value != null && document
			.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.localCode")[0].value != "")
			&& (document
					.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].value == null || document
					.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].value == "")) {
		showUserMessage("MSG086","'Phone Type'");
		document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].focus();
		return 'interactive';
	} 
	// Phone Number

	if ((document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].value != null && document
			.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType")[0].value != "")
			&& (document.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.localCode")[0].value == null || document
					.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.localCode")[0].value == "")) {
		showUserMessage("MSG086","'Phone No.'");
		document.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.cntrycode")[0].focus();
		return 'interactive';
	} 
	// Email Type
	if ((document.getElementsByName("CorporateBO.PhoneEmail.Email")[0].value != null && document
			.getElementsByName("CorporateBO.PhoneEmail.Email")[0].value != "")
			&& (document
					.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType1")[0].value == null || document
					.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType1")[0].value == "")) {
		showUserMessage("MSG086","'Email Type'");
		document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType1")[0].focus();
		return 'interactive';

	} 
	// Email Id
	if ((document.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType1")[0].value != null && document
			.getElementsByName("CorporateBO.PhoneEmail.PhoneEmailType1")[0].value != "")
			&& (document.getElementsByName("CorporateBO.PhoneEmail.Email")[0].value == null || document
					.getElementsByName("CorporateBO.PhoneEmail.Email")[0].value == "")) {
		showUserMessage("MSG086","'E-mail ID'");		
		document.getElementsByName("CorporateBO.PhoneEmail.Email")[0].focus();
		return 'interactive';
	} 

	/** ********* PhoneEmail Co-Mandatory Validations *********** */
	

		//Change for tracker 153485

		var altCalendarHij = document.all.ALTCALENDAR_TYPE.value;

		try{

		customSave();
			if(document.frm2.isMCEdited.value=="Y"){
				document.frm2.isMCEditedGeneral.value="Y";
			}
		}
		catch(e)
		{
		}

	if(corpsubmit=='false')
	{

		var validate=false;
		if(document.getElementsByName("CorporateBO.corporate_Name")[0].value == "")
		{
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG086","'Corporate Name'"),
					'CorporateBO.corporate_Name' , 'HYPER_LINK');
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			validate = 'true';
		}
		if(document.getElementsByName("CorporateBO.corp_Key")[0].value == "")
		{
			if(document.all.isAutoGenKey.value == 'true')
			{
				document.getElementsByName("CorporateBO.corp_Key")[0].IsMandatory = "false";
			}
			else
			{
				parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserMessage("MSG086","'CIF ID'"),
							'CorporateBO.corp_Key' , 'HYPER_LINK');
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				validate = 'true';
			}
		}
		if(validate == 'true')
		{
		return 'interactive';
		}
	}
		var entityType1 = document.getElementsByName(boNameRep+".entity_Type")[0].value;

		var corpRepStat = "";
		if(entityType1 != ""){
			corpRepStat = validateCorpRep();

			if(corpRepStat == "true"){
				parent.parent.parent.parent.messageFrm.showMessages(selTabId);
				return 'interactive';
			}
		}
		var regad = true;
		var defad = true;
		noOfAdr = adr_URL.length;

		//alert("noOfAdr" +noOfAdr);
		//chkadres = document.all.AdrRecordSet.rows.length;
		//alert("chkadres" +chkadres);

	if(corpsubmit == 'true')
		{
		if(entityType1 != ""){
                    var addr1 = document.getElementsByName(boNameRep+".cifAddrEntity")[0].value;

					if(addr1=='Retail'){
						// Tracker ID - 122044 changes BEGIN here
						addrCheck();
						addrFlag = 'true';
						// TRACKER 97917 Changes BEGIN
					}
					else if(addr1=='Corporate'){
						corpAddrCheck();
					}
					if(addrFlag != "true"){
						return "interactive";
					}
				}



			preferredPhone = document.getElementsByName(boName+'.PhoneEmail.PhoneEmailType')[0];

			preferredEmail = document.getElementsByName(boName+'.PhoneEmail.PhoneEmailType1')[0];


			var preferredPhoneFlag = false;
			var preferredEmailFlag = false;

			//Tracker 184709 Starts
				//var phoneCheck = phoneEmailCheck();
				//alert("phoneCheck"+phoneCheck);
				//if(phoneCheck == "false" || phoneCheck == false) {
				//	return "interactive";
				//}

			//Tracker 184709 Ends


		}
			noOfPhoneEmail = phoneEmail_URL.length;
			addPhoneEmailCounter = 0;
              addAdrCounter = 0 ;
         //   clearValues();
//Fix For Ticket 436178
         if (defAddress == "M")
	 		defAddress = "Mailing";
	 	else if (defAddress == "H")
	 		defAddress = "Home";
	 	else if (defAddress == "W")
		defAddress = "Work";
//Changes for ticket id 591624 and recon for call id 308347 starts
		else if (defAddress == "R")
		defAddress = "Registered";
//Changes for ticket id 591624 and recon for call id 308347 ends
try {
		//Changes for call id 399601 and recon of call id 395278 starts
		if(preferredAddressType==null || preferredAddressType==''){
			document.frm2.address_type.value = defAddress;
		}
		else{
			document.frm2.address_type.value = preferredAddressType;
		}
		//Changes for call id 399601 and recon of call id 395278 ends
		document.frm2.PhoneNoLocalCode.value = document
				.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.localCode")[0].value;
		document.frm2.PhoneNoCityCode.value = document
				.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.areacode")[0].value;
		document.frm2.PhoneNoCountryCode.value = document
				.getElementsByName("CorporateBO.PhoneEmail.PhoneNo.cntrycode")[0].value;
	} catch (ge) {
		DebugMessage(ge.message);
	}
	//document.getElementsByName("hidDocCode")[0].value = document
		//	.getElementsByName("EntityDocumentBO.DocCode")[0].value;
	//document.getElementsByName("hidDocTypeCode")[0].value = document
	//		.getElementsByName("EntityDocumentBO.DocTypeCode")[0].value;

	var flag = false;



	//	document.frm2.AdrRemoved.value = getCSVforArray(adr_detachedURLs);
 	noOfID = EDoc_URL.length;
 	//clearIDValues();
 	try
 	{
	for(var i = 0; i <noOfID; i++)
 		{
 			if(EDoc_URL[i] != null)
 			{
 				document.frm2.identifier_type_Code.value		= document.frm2.identifier_type_Code.value + "," + srmEscape(EDoc_identifier_type_Code[i], '^', escChars);
 				document.frm2.unique_id.value					= document.frm2.unique_id.value + "," + srmEscape(EDoc_unique_id[i], '^', escChars);;
 	  /*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
	  			      var ALTCALENDAR_TYPE = ALTCALENDAR_TYPE;
	  				if(ALTCALENDAR_TYPE == 'true')
	  				{
	  				   if(EDoc_dateofissue[i] != '')
	  				   {
	  				    var strFlag = isGregDateWithoutConv(EDoc_dateofissue[i]);
	  				    if(strFlag != 'true')
	  					{
	  						EDoc_dateofissue[i]=convertHijToGreg(EDoc_dateofissue[i]);
	  					}
	  				   }
	  				if(EDoc_validity_date[i] != '')
	  				   {
	  				    var strFlag = isGregDateWithoutConv(EDoc_validity_date[i]);
	  				    if(strFlag != 'true')
	  					{
	  						EDoc_validity_date[i]=convertHijToGreg(EDoc_validity_date[i]);
	  					}
	  				   }
	  				}
 				document.frm2.hidDocCode.value 					= document.frm2.hidDocCode.value + "," + srmEscape(EDoc_docCode[i], '^', escChars);
 				document.frm2.hidDocDescr.value 				= document.frm2.hidDocDescr.value + "," + srmEscape(EDoc_docDescr[i], '^', escChars);
 				document.frm2.hidDocTypeCode.value 				= document.frm2.hidDocTypeCode.value + "," + srmEscape(EDoc_docTypeCode[i], '^', escChars);
 				document.frm2.hidDocTypeDescr.value 			= document.frm2.hidDocTypeDescr.value + "," + srmEscape(EDoc_docTypeDescr[i], '^', escChars);
 			}
 		}
 		document.frm2.identifier_type_Code.value		= document.frm2.identifier_type_Code.value.substr(1);
 		document.frm2.unique_id.value					= document.frm2.unique_id.value.substr(1);
 		document.frm2.hidEntityDocumentID.value 			= document.frm2.hidEntityDocumentID.value.substr(1);
 		document.frm2.hidEntityDocumentURL.value 			= document.frm2.hidEntityDocumentURL.value.substr(1);
 		document.frm2.hidDocCode.value 					= document.frm2.hidDocCode.value.substr(1);
 		document.frm2.hidDocDescr.value 				= document.frm2.hidDocDescr.value.substr(1);
 		document.frm2.hidDocTypeCode.value 				= document.frm2.hidDocTypeCode.value.substr(1);
 		document.frm2.hidDocTypeDescr.value 			= document.frm2.hidDocTypeDescr.value.substr(1);
 	}
 	catch(e)
 	{
 	}
 //	document.frm2.IDRemoved.value = getCSVforArray(EDoc_detachedURLs);
 addIDCounter = 0 ;
  setHiddenFields();

	noOfID = EDoc_URL.length;
	//clearIDValues();
	try
	{
		for(var i = 0; i <noOfID; i++)
		{
			if(EDoc_URL[i] != null)
			{
				document.frm2.identifier_type_Code.value		= document.frm2.identifier_type_Code.value + "," + srmEscape(EDoc_identifier_type_Code[i], '^', escChars);
				document.frm2.unique_id.value					= document.frm2.unique_id.value + "," + srmEscape(EDoc_unique_id[i], '^', escChars);;
	  /*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
	  			      var ALTCALENDAR_TYPE = ALTCALENDAR_TYPE;
	  				if(ALTCALENDAR_TYPE == 'true')
	  				{
	  				   if(EDoc_dateofissue[i] != '')
	  				   {
	  				    var strFlag = isGregDateWithoutConv(EDoc_dateofissue[i]);
	  				    if(strFlag != 'true')
	  					{
	  						EDoc_dateofissue[i]=convertHijToGreg(EDoc_dateofissue[i]);
	  					}
	  				   }
	  				if(EDoc_validity_date[i] != '')
	  				   {
	  				    var strFlag = isGregDateWithoutConv(EDoc_validity_date[i]);
	  				    if(strFlag != 'true')
	  					{
	  						EDoc_validity_date[i]=convertHijToGreg(EDoc_validity_date[i]);
	  					}
	  				   }
	  				}
	/************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
				document.frm2.dateofissue.value 				= document.frm2.dateofissue.value + "," + srmEscape(EDoc_dateofissue[i], '^', escChars);
				document.frm2.validity_date.value 				= document.frm2.validity_date.value + "," + srmEscape(EDoc_validity_date[i], '^', escChars);
				document.frm2.hidEntityDocumentID.value 		= document.frm2.hidEntityDocumentID.value + "," + srmEscape(EDoc_EntityDocumentID[i], '^', escChars);
				document.frm2.hidEntityDocumentURL.value		= document.frm2.hidEntityDocumentURL.value + "," + srmEscape(EDoc_EntityDocumentURL[i], '^', escChars);
				document.frm2.hidDocCode.value 					= document.frm2.hidDocCode.value + "," + srmEscape(EDoc_docCode[i], '^', escChars);
				document.frm2.hidDocDescr.value 				= document.frm2.hidDocDescr.value + "," + srmEscape(EDoc_docDescr[i], '^', escChars);
				document.frm2.hidDocTypeCode.value 				= document.frm2.hidDocTypeCode.value + "," + srmEscape(EDoc_docTypeCode[i], '^', escChars);
				document.frm2.hidDocTypeDescr.value 			= document.frm2.hidDocTypeDescr.value + "," + srmEscape(EDoc_docTypeDescr[i], '^', escChars);
				document.frm2.hidDocReceivedDate.value 			= document.frm2.hidDocReceivedDate.value + "," + srmEscape(EDoc_docReceivedDate[i], '^', escChars);
				document.frm2.hidDocRemarks.value 				= document.frm2.hidDocRemarks.value + "," + srmEscape(EDoc_docRemarks[i], '^', escChars);
				document.frm2.hidStatus.value 					= document.frm2.hidStatus.value + "," + srmEscape(EDoc_Status[i], '^', escChars);
				document.frm2.hidIsMandatory.value 				= document.frm2.hidIsMandatory.value + "," + srmEscape(EDoc_isMandatory[i], '^', escChars);
				document.frm2.hidScanRequired.value 			= document.frm2.hidScanRequired.value + "," + srmEscape(EDoc_scanRequired[i], '^', escChars);
				document.frm2.placeofissue.value 				= document.frm2.placeofissue.value + "," + srmEscape(EDoc_placeofissue[i], '^', escChars);
				document.frm2.countryofissue.value 				= document.frm2.countryofissue.value + "," + srmEscape(EDoc_countryofissue[i], '^', escChars);
				document.frm2.hidEDoc_IsDirty.value 			= document.frm2.hidEDoc_IsDirty.value + "," + srmEscape(EDoc_IsDirty[i], '^', escChars);
				document.frm2.hidIsDocumentVerified.value		= document.frm2.hidIsDocumentVerified.value + "," + srmEscape(EDoc_isDocumentVerified[i], '^', escChars);
				document.frm2.hidIDIssuedOrg.value		= document.frm2.hidIDIssuedOrg.value + "," + srmEscape(EDoc_idIssuedOrg[i], '^', escChars);//Fix for ticket 296523
			}
		}
		document.frm2.identifier_type_Code.value		= document.frm2.identifier_type_Code.value.substr(1);
		document.frm2.unique_id.value					= document.frm2.unique_id.value.substr(1);
		document.frm2.dateofissue.value 				= document.frm2.dateofissue.value.substr(1);
		document.frm2.validity_date.value 				= document.frm2.validity_date.value.substr(1);
		document.frm2.hidEntityDocumentID.value 			= document.frm2.hidEntityDocumentID.value.substr(1);
		document.frm2.hidEntityDocumentURL.value 			= document.frm2.hidEntityDocumentURL.value.substr(1);
		document.frm2.hidDocCode.value 					= document.frm2.hidDocCode.value.substr(1);
		document.frm2.hidDocDescr.value 				= document.frm2.hidDocDescr.value.substr(1);
		document.frm2.hidDocTypeCode.value 				= document.frm2.hidDocTypeCode.value.substr(1);
		document.frm2.hidDocTypeDescr.value 			= document.frm2.hidDocTypeDescr.value.substr(1);
		document.frm2.hidDocReceivedDate.value 			= document.frm2.hidDocReceivedDate.value.substr(1);
		document.frm2.hidDocRemarks.value 				= document.frm2.hidDocRemarks.value.substr(1);
		document.frm2.hidStatus.value 					= document.frm2.hidStatus.value.substr(1);
		document.frm2.hidIsMandatory.value 				= document.frm2.hidIsMandatory.value.substr(1);
		document.frm2.hidScanRequired.value 			= document.frm2.hidScanRequired.value.substr(1);
		document.frm2.placeofissue.value 				= document.frm2.placeofissue.value.substr(1);
		document.frm2.countryofissue.value				= document.frm2.countryofissue.value.substr(1);
		document.frm2.hidEDoc_IsDirty.value 			= document.frm2.hidEDoc_IsDirty.value.substr(1);
		document.frm2.hidIsDocumentVerified.value 		= document.frm2.hidIsDocumentVerified.value.substr(1);
		document.frm2.hidIDIssuedOrg.value 		= document.frm2.hidIDIssuedOrg.value.substr(1);//Fix for ticket 296523
	}
	catch(e)
	{
	}
	//document.frm2.IDRemoved.value = getCSVforArray(EDoc_detachedURLs);
	//Change for DBS ticket 325152
	//document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;
saveConcession();
 var saveFlag = 0;
 if(corpsubmit=='false')
 {
 	saveFlag = 1;
 }

//	var ownerSegment= document.getElementsByName(boName+'.AccessOwnerSegment')[0].value;
	var primaryRM=document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value;
	var secondaryRM=document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value;
	if (RMChanged=="true") {
		if(showConfirmMessage(MSGJ50358)){
		}else{
			return "interactive";
		}
	}
	else if (RMChanged=="true") {
		if(showConfirmMessage(MSGJ50358)){
		}else{
			return "interactive";
		}
	}
	else if ((primaryRM!=null && primaryRM!='') || (secondaryRM!=null && secondaryRM!='')) {
		if(showConfirmMessage(MSGJ50357)){
		}else{
			return "interactive";
		}
	}
		var str;
		//str  = document.getElementsByName("CorporateRepBO.dob")[0].value;
		//document.frm2.corpRepDate.value =  str;
	    /***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
		//var strAltCalType = ALTCALENDAR_TYPE;
		//var strCorpRepDob = document.frm2.corpRepDate.value;
	//	if(strAltCalType = 'true')
	//	{

		//	  var strFlag = isGregDateWithoutConv(strCorpRepDob);
		//	if(strFlag != 'true')
		//	{
		//		strCorpRepDob=convertHijToGreg(strCorpRepDob);
		//	}

		//}
	      /***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
		//str  = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.date1")[0].value;
	//	str  = document.getElementsByName(boNameRep+".isSignatory")[0].value;
	str  = document.getElementsByName(boNameRep+".entity_Type")[0].value;
		//str  = document.getElementsByName(boNameRep+".addressCategory")[0].value;
			var cifAddress = document.getElementsByName("addressCategory")[0].value;

		 /***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
		//	fnConvertDate();
	/***ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
		/* fix for ticket 214674 start*/
		//if (altLocaleActv==true){
		//var altname =document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value;
	//	document.frm2.hAltname.value = altname;
	//	}
		/* fix for ticket 214674 ends*/
		/*Swift address changes --tracker 132659----START*/
	//	if(SwiftAddressDetails==""){
			//alert("SwiftAddressDetails inside if--->"+SwiftAddressDetails);
		//	SwiftAddressDetails='YYY';
			//alert("SwiftAddressDetails--->"+SwiftAddressDetails);
			//if(corpsubmit == 'true'){
				//parent.parent.parent.parent.addTip(parent.parent.parent.parent.frames(0).getSelectedTabId(), "Swift Address is Defaulted from Preferred Address Type");
				//parent.parent.parent.parent.showTip(parent.parent.parent.parent.frames(0).getSelectedTabId());
			//}
		//}
		newPara = document.getElementById("myPar");
		                   var frame='formSaveFrame';
		                   /* Null changes */

//modified for ticket 629798

			if(editMode != null && editMode)
						{
						// recon of 386529 changes
						try{
						document.frm2.edit.value='Edit';
						}catch(e){}
							
						}
		                              var CorpURL = "../servlet/com.infy.cis.ui.corpcif.CorpSQDEWriter?saveFlag="+saveFlag+"&boName="+boName+"&boNameRep="+boNameRep+"&dual="+dualflag+"&corpId="+corpId+"&operationType="+operationType+"&SECUREHKEY="+hashkey+"&FLDHASHKEY="+fldhashkey;



		                   //fnRemoveNull(newPara,CorpURL,document.frm2,frame);

		                  /* Null changes end*/

// Changes for call id 334833 STARTS
//changes for call id 415849 and recon of callid 414031 starts
//document.frm2.hid_reservestatus.value=operationType;
//changes for call id 415849 and recon of callid 414031 ends
// Changes for call id 334833 ENDS

//Change for ticket 326535
//document.frm2.SwiftAddressDetails.value 		= SwiftAddressDetails;
/* Changes for Saving the CorpRep, Passing boName and boNameRep to Writer :start*/
<!--tracker id 113227 starts-->
//Change for DBS ticket 325152
 //***document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.QDECorpEntityWriter?saveFlag="+saveFlag+"&SwiftAddressDetails="+SwiftAddressDetails+"&boName="+boName+"&boNameRep="+boNameRep+"&dual="+dualflag;

//document.frm2.action = "../servlet/com.infy.cis.ui.corpcif.CorpSQDEWriter?saveFlag="+saveFlag+"&boName="+boName+"&boNameRep="+boNameRep+;
document.frm2.action = CorpURL;
<!--tracker id 113227 ends-->
//Changes for Saving the CorpRep,Passing boName and boNameRep to Writer :End */
		/*Swift address changes --tracker 132659----END*/

document.frm2.target="formSaveFrame";
//alert("2document.frm2"+document.getElementsByName("CorporateBO.legalEntity_Type")[0].value);

 document.getElementsByName(boName+".primary_Service_Center")[0].disabled=false;
 document.getElementsByName("Cat_"+ boName+".primary_Service_Center")[0].disabled=false;
 document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].disabled = false;
document.frm2.hidCorprepID.value
document.frm2.submit();
flag = true;
//clearValues();
//clearIDValues();
return 'true';
}


function fnConvertDate()
		{
			var arrDateList = new Array();
			var arrFinalDateList = new Array();
			var strAltCalType = ALTCALENDAR_TYPE;
			var strRelExpDt =document.getElementsByName("3_CorporateBO.relationship_StartDate")[0].value;
			var strDateOfIncorp =document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].value;
			var strRiskProfileExpDt =document.getElementsByName("3_CorporateBO.RiskProfileExpiryDate")[0].value;
			var strBirthOrIncorpDt =document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value;
				arrDateList[0] = strRelExpDt;
				arrDateList[1] = strDateOfIncorp;
				arrDateList[2] = strRiskProfileExpDt;
				arrDateList[3] = strBirthOrIncorpDt;
			        var iLength = arrDateList.length-1;
				if(strAltCalType == 'true')
				{
					for(iCount=0;iCount<=iLength;iCount++)
					{
						date=arrDateList[iCount];
						   if(date != '')
						   {
							  var strFlag = isGregDateWithoutConv(date);
							if(strFlag != 'true')
							{
								date=convertHijToGreg(date);
								arrFinalDateList[iCount]= date;
							}
							else
							{
								arrFinalDateList[iCount]= date;
							}
						   }
						   else
						   {
						     arrFinalDateList[iCount]='';
						   }
					  }
					  document.all.relationship_StartDate.value = arrFinalDateList[0];
					  document.all.date_Of_Incorporation.value = arrFinalDateList[1];
					  document.all.RiskProfileExpiryDate.value = arrFinalDateList[2];
					  document.all.date1.value = arrFinalDateList[3];
				  }
			}
function clearIDValues()		//abhinav added
{
	document.frm2.identifier_type_Code.value		= "";
	document.frm2.unique_id.value					= "";
	document.frm2.dateofissue.value 				= "";
	document.frm2.validity_date.value 				= "";
	document.frm2.hidEntityDocumentID.value 		= "";
	document.frm2.hidEntityDocumentURL.value 		= "";
	document.frm2.hidDocCode.value 					= "";
	document.frm2.hidDocDescr.value 				= "";
	document.frm2.hidDocTypeCode.value 				= "";
	document.frm2.hidDocTypeDescr.value 			= "";
	document.frm2.hidDocReceivedDate.value 			= "";
	document.frm2.hidDocRemarks.value 				= "";
	document.frm2.hidStatus.value					= "";
	document.frm2.hidIsMandatory.value 				= "";
	document.frm2.hidScanRequired.value 			= "";
	document.frm2.placeofissue.value 				= "";
	document.frm2.countryofissue.value				= "";
	document.frm2.hidIsDocumentVerified.value 			= "";
	document.frm2.hidIDIssuedOrg.value 			= "";//Fix for ticket 296523
  }

    function clearValues(){
		document.frm2.address_type.value= "";
		document.frm2.houseno.value= "";
		document.frm2.premiseno.value =  "";
		document.frm2.building.value =  "";
		document.frm2.country.value =  "";
		document.frm2.city.value =  "";
		document.frm2.state.value =  "";
		document.frm2.start_date.value =  "";
		document.frm2.zip.value =  "";
		document.frm2.end_date.value =  "";
		document.frm2.addrID.value =  "";
		document.frm2.streetno.value= "";
		document.frm2.town.value= "";
		document.frm2.locality.value= "";
		document.frm2.domicile.value= "";
		document.frm2.website.value= "";
		document.frm2.mailstop.value= "";
		document.frm2.streetname.value= "";
		document.frm2.suburb.value= "";
		document.frm2.AdrRemoved.value = "";
		document.frm2.addr_city_code.value = "";
		document.frm2.addr_state_code.value = "";
		document.frm2.addr_cntry_code.value = "";
 }
function getCSVforArray(arr){
	retVal = "";
	tmpCnt = 0;
	noOfElems = arr.length;
	for(var i = 0; i < noOfElems; i++) {
		if(arr[i] != null) {
			if(tmpCnt == 0) {
				tmpCnt  = 1;
				retVal = arr[i];
			} else {
				retVal = retVal + "," + arr[i];
			}
		}
	}
	return retVal;
}
function myEscape(src, escChar) {
		// implementation Later....
		return src;
}
function  openAgentLookup (type)	{
	lookupFor = "Agent_" + type;
	var url;
	if(type == "DSAID")
		url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForPartner";
	else
		url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAgent&onlyActive=Y";
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	lookupwindow_UB=window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
}
function  fnBluropenLastLookup(type){

	var chk1 = chkBlurFrom1();

	if(chk1 == true) {





		var strUserName = document.getElementsByName("CorporateRepBO.entityKey")[0].value;
		var entityType = document.getElementsByName(boNameRep+".entityKey")[0].value;


		if(strUserName != null){
			var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?cifID='+strUserName+"&RELATION=Bene"+"&lookup="+entityType;
			var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
                        /* Ticket 240033 changes start*/
                                    s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			var flag = '';
			if(s_xmlHttp.status == 200){
                                                recFlag   = getColorCookie('sManyRecords');
				flag   = getColorCookie('sBooleans');
                                                if ((recFlag=="True")){
                                                flag='';
                                                }
                                    }
                                    if(recFlag=='True'){
                                    var lookup = document.getElementsByName(boNameRep+".entity_Type")[0].value;
                                    if(lookup == "CUSTOMER" || lookup == "Customer")
                                    {
                                    lookupFor = "ForAccount"
                                    }
                                    else if(lookup == "CONTACT"){
                                    lookupFor = "ForContact"
                                    }
                                    else if(lookup == "PROSPECT"){
                                    lookupFor = "ForSuspect"
                                    }
                                    var strCorpLastName1;
                                    var the_length=strUserName.length;
                                    var last_char=strUserName.charAt(the_length-1);
                                    if(last_char=='*'){
                                                strCorpLastName1=strUserName;
                                    }
                                    else{
                                                strCorpLastName1 = strUserName + '*';
                                    }
                                    wid=900;
                                    ht=460;
                                    topCord=(screen.height-ht)/2;
                                    leftCord=(screen.width-wid)/2;
                                    var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode="+lookupFor+"&amp;lastName="+strCorpLastName1;
                                    var newwin = window.open(url, 'Lookup', 'height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
                                    }
			if(flag=='False'){
				//showUserMessage("MSGJ50716","");
				document.getElementsByName("CorporateRepBO.entityKey")[0].value = "";
			}
                                    else if(flag=='True'){
				var cif      	= getColorCookie('cif');
				var dob         = getColorCookie('dob');
                                                document.getElementsByName("3_CorporateRepBO.dob")[0].value = dob;
                                                document.getElementsByName("CorporateRepBO.entityKey")[0].value = cif;
	   		}
                         /* Ticket 240033 changes end*/
		}
	}
	else{

				var lookup = document.getElementsByName(boNameRep+".entity_Type")[0].value;

				if(lookup == "CUSTOMER" || lookup == "Customer")
				{
				lookupFor = "ForAccount"
				var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAccount";
				wid=900;
				ht=460;
				topCord=(screen.height-ht)/2;
				leftCord=(screen.width-wid)/2;
				window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
				}
				else if(lookup == "CONTACT"){
				lookupFor = "ForContact"
				var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForContact";
				wid=900;
				ht=460;
				topCord=(screen.height-ht)/2;
				leftCord=(screen.width-wid)/2;
				window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
				}
				else if(lookup == "PROSPECT"){
				lookupFor = "ForSuspect"
				var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForSuspect";
				wid=900;
				ht=460;
				topCord=(screen.height-ht)/2;
				leftCord=(screen.width-wid)/2;
				window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
				}
				else if(lookup == ""){
				 showUserMessage("MSGJ50119",null);
					return;
				}
	}
}


function openprimarylookup(){
wid=900;
ht=360;
topCord=(screen.height-ht)/2;
leftCord=(screen.width-wid)/2;
var type = document.getElementsByName(boName+".CorpMiscellaneousInfo.str9")[0].value;
var relation =  document.frm2.Corp.value;
	if(relation == ""){
	showUserMessage("MSGJ50119",null);
	return;
	}
	if(type == "Corporate"){
		if(relation == "CUSTOMER"){
		lookupFor = "ForCorpCust"
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForCorpCust";
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	introLookUpWin = window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
		}
		else if(relation == "PROSPECT"){
		lookupFor = "ForCorpProspect"
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForCorpProspect";
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	introLookUpWin = window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
			}
		}
	else if(type == "Retail"){
		if(relation == "CUSTOMER")
		{
		lookupFor = "ForRetAccount"
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForAccount";
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	introLookUpWin = window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
		}

		else if(relation == "CONTACT"){
		lookupFor = "ForRetContact"
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForContact";
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	introLookUpWin = window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
		}
		else if(relation == "PROSPECT"){
		lookupFor = "ForRetSuspect"
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=ForSuspect";
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	introLookUpWin = window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
		}
	}
}

function onRecordSelect() {
try{
MinorFlag = getCookie("isMinor");
 if (lookupFor == "Agent_PRM")	{
document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value = getCookie("LookupLoginID");
document.frm2.prim_id.value = getCookie("LookupLoginID");
document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].fireEvent("onChange");
prmURL = getCookie("AgentURL");
        }
if (lookupFor == "Agent_SRM")	{
document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value = getCookie("LookupLoginID");
document.frm2.sec_id.value = getCookie("LookupLoginID");
document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].fireEvent("onChange");
srmURL = getCookie("AgentURL");
	}
if (lookupFor == "Group")	{
document.getElementsByName("CorporateBO.Group_ID_Code")[0].value = getCookie("LookupGroupID");
document.getElementsByName("CorporateBO.group_ID")[0].value = getCookie("LookupGroupName");
document.frm2.newGrpVal.value = document.getElementsByName("CorporateBO.group_ID")[0].value;
	}
if (lookupFor == "Parent")	{
document.getElementsByName("CorporateBO.parent_CIF")[0].value = getCookie("LookupParentCIF");
}
if (lookupFor == "Agent_RelCrea")	{
document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].value = getCookie("LookupLoginID");
document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].fireEvent("onChange");
}
if (lookupFor == "Agent_DSAID")	{
document.getElementsByName("CorporateBO.dsaID")[0].value = getCookie("LookupPartnerName");
document.getElementsByName("CorporateBO.dsaID")[0].fireEvent("onChange");
}
if (lookupFor == 'ForAccount')
{

var tempvar = getCookie('AccountKey');

document.getElementsByName("CorporateRepBO.entityKey")[0].value = tempvar;
//var tempdate = getCookie('LookupAccountDOB');
//document.getElementsByName("3_CorporateRepBO.dob")[0].value = tempdate;

document.frm2.hidCorprepID.value =  getCookie('AccountID');
document.frm2.hidEntID.value = getCookie('AccountKey');
//document.getElementsByName("CorporateRepBO.entityKey")[0].value = getCookie('AccountKey');
//Tracker 129381 changes Start
if(altLangActv=='true'){
/*ticker id 209661 tracker id 125246 changes starts*/
document.getElementsByName("CorporateRepBO.last_Name_alt1")[0].value = getCookie('LookupLastName_alt1');
/*ticker id 209661 tracker id 125246 changes ends*/
document.getElementsByName("hid_CorporateRepBO.first_Name_alt1")[0].value = getCookie('LookupFirstName_alt1');
}
//document.getElementsByName("hid_CorporateRepBO.first_Name")[0].value = getCookie('LookupAccountFirstName');
//Tracker 129381 changes End
//document.getElementsByName("CorporateRepBO.entityKey")[0].fireEvent("onChange");
lookupload();
}
if(lookupFor == 'ForSuspect'){

document.getElementsByName("CorporateRepBO.entityKey")[0].value = getCookie('SuspectsKey');

//document.getElementsByName("3_CorporateRepBO.dob")[0].value = getCookie("LookupProspectDOB");
//document.getElementsByName("CorporateRepBO.last_Name")[0].value = getCookie("LookupProspectLastName");
document.frm2.hidCorprepID.value = getCookie('ProspectID');
//document.frm2.hidEntID.value = getCookie('SuspectsKey');
//document.getElementsByName("CorporateRepBO.entityKey")[0].value = getCookie('SuspectsKey');
//Tracker 129381 changes Start
if(altLangActv=='true'){
/*ticker id 206142 changes starts*/
//document.getElementsByName("CorporateRepBO.last_Name_alt1")[0].value = getCookie('LookupLastName_alt1');
/*ticker id 206142 changes ends*/
// document.getElementsByName("hid_CorporateRepBO.first_Name_alt1")[0].value = getCookie('LookupFirstName_alt1');
 }
 document.getElementsByName("hid_CorporateRepBO.first_Name")[0].value = getCookie('LookupAccountFirstName');
//Tracker 129381 changes End
document.getElementsByName("CorporateRepBO.entityKey")[0].fireEvent("onChange");
lookupload();
}
if(lookupFor == 'ForContact'){

document.getElementsByName("CorporateRepBO.entityKey")[0].value = getCookie('ContactKey');

//document.getElementsByName("3_CorporateRepBO.dob")[0].value = getCookie("LookupContactDOB");
//document.getElementsByName("CorporateRepBO.last_Name")[0].value = getCookie("LookupContactLastName");
document.frm2.hidCorprepID.value = getCookie('ContactID');
//document.frm2.hidEntID.value = getCookie('ContactKey');
//Tracker 129381 changes Start
if(altLangActv=='true'){
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateRepBO.last_Name_alt1")[0].value = getCookie('LookupLastName_alt1');
/*ticker id 206142 changes ends*/
document.getElementsByName("hid_CorporateRepBO.first_Name_alt1")[0].value = getCookie('LookupFirstName_alt1');
 }
 document.getElementsByName("hid_CorporateRepBO.first_Name")[0].value = getCookie('LookupAccountFirstName');
//Tracker 129381 changes End
document.getElementsByName("CorporateRepBO.entityKey")[0].fireEvent("onChange");
lookupload();
}
if(lookupFor == 'ForCorpCust'){
try{
//Fix For Tracker:142719:Ticket:237444 Begin Changes
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = getCookie("LookupCIFID");
//Fix For Tracker:142719:Ticket:237444 End of Changes
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = getCookie("LookupCorpCustName");
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = getCookie("LookupCorpCustDOC");
//Tracker 129381 changes Start
if(altLangActv=='true'){
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value = getCookie('LookupCorpCustName_alt1');
/*ticker id 206142 changes ends*/
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].readOnly = true;
/*ticker id 206142 changes ends*/
}
//Tracker 129381 changes End
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].fireEvent("onChange");
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].readOnly = true;
/*ticker id 206142 changes ends*/
	}catch(E){
	}
}
if(lookupFor == 'ForCorpProspect'){
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = getCookie("LookupProspectCorpID");
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = getCookie("LookupCorpProspectName");
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = getCookie("LookupCorpProspectDOC");
//Tracker 129381 changes Start
/* Tracker 121950 Changes START */
//var active1 = getCookie("active");
//if(active1 == 'true'){
if(altLangActv=='true'){
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value = getCookie("LookupCorpProspectName_alt1");
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].disabled = true;
}
/* Tracker 121950 Changes END */
//Tracker 129381 changes End
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].fireEvent("onChange");
}
if(lookupFor == 'ForRetAccount'){
if(MinorFlag == "Y"){
showUserMessage("MSGJ50252",'');
	if(introLookUpWin && introLookUpWin != null) {
	introLookUpWin.focus();
	}
return false;
}
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = getCookie("AccountKey");
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = getCookie("LookupAccountLastName");
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = getCookie("LookupAccountDOB");
document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str50")[0].value = getCookie("LookupAccountTitle");
document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str4")[0].value = getCookie("LookupAccountFirstName");
//Tracker 129381 changes Start
if(altLangActv=='true'){
document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str4_alt1")[0].value = getCookie("LookupFirstName_alt1");
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value = getCookie('LookupLastName_alt1');
/*ticker id 206142 changes ends*/
/* Ticket#: 214635 FIX STARTS */
//document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
/* Ticket#: 214635 FIX ENDS */
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].readOnly = true;
/*ticker id 206142 changes ends*/
}
//Tracker 129381 changes End
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].fireEvent("onChange");
introLookUpWin.close();
}
if(lookupFor == 'ForRetContact'){
if(MinorFlag == "Y"){
showUserMessage("MSGJ50252",'');
	if(introLookUpWin && introLookUpWin != null) {
	introLookUpWin.focus();
	}
return false;
}
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = getCookie("ContactKey");
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = getCookie("LookupContactLastName");
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = getCookie("LookupContactDOB");
//Tracker 129381 changes Start
document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str4")[0].value = getCookie("LookupAccountFirstName");
if(altLangActv=='true'){
document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str4_alt1")[0].value = getCookie("LookupFirstName_alt1");
/*ticker id 209661 tracker id 125246 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value = getCookie('LookupLastName_alt1');
/*ticker id 209661 tracker id 125246 changes ends*/
/* Ticket#: 214635 FIX STARTS */
//document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
/* Ticket#: 214635 FIX ENDS */
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].readOnly = true;
/*ticker id 206142 changes ends*/
}
//Tracker 129381 changes End
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].fireEvent("onChange");
introLookUpWin.close();
}
if(lookupFor == 'ForRetSuspect'){
if(MinorFlag == "Y"){
showUserMessage("MSGJ50252",'');
	if(introLookUpWin && introLookUpWin != null) {
	introLookUpWin.focus();
	}
return false;
}
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value = getCookie("SuspectsKey");
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value = getCookie("LookupProspectLastName");
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value = getCookie("LookupProspectDOB");
//Tracker 129381 changes Start
document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str4")[0].value = getCookie("LookupAccountFirstName");
if(altLangActv=='true'){
document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str4_alt1")[0].value = getCookie("LookupFirstName_alt1");
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].value = getCookie('LookupLastName_alt1');
/*ticker id 206142 changes ends*/
/* Ticket#: 214635 FIX STARTS */
//document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
/* Ticket#: 214635 FIX ENDS */
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
/*ticker id 206142 changes starts*/
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5_alt1")[0].readOnly = true;
/*ticker id 206142 changes ends*/
}
//Tracker 129381 changes End
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].readOnly = true;
document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].readOnly= true;
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].fireEvent("onChange");
introLookUpWin.close();
}
if (lookupFor =="Agent_PRM" || lookupFor == "Agent_SRM" ) {
	setAgentValues();
}
	}
	catch(e)
	{
	}
}
function Lookup() {
	corpCustLookup();
}

function corpCustLookup() {
    lookupFor = 'Customer';
    var newwin = window.open('../servlet/com.infy.cis.ui.common.Lookup?Mode=ForCorpCust',
			     'Lookup',
			     'height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
}

function AccMgrLookup(type)
 {
	 var iAccManagerID = "";
	 lookupFor = "Agent_" + type;
	 var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode=CorpAM_Lookup&OldAccManagerID="+iAccManagerID;
	wid=900;
	ht=460;
	topCord=(screen.height-ht)/2;
	leftCord=(screen.width-wid)/2;
	window.open (url, "Lookup", "height="+ht+", left="+leftCord+", top="+topCord+", width="+wid+",resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes");
 }
function loadBaseCurrency(){
	document.getElementsByName(boName+".Crncy_Code")[0].value = BaseCurrency;
}
 function lookupload(){
        var entityType = document.getElementsByName("CorporateRepBO.entity_Type")[0].value;
        var entityName = document.getElementsByName("CorporateRepBO.entityKey")[0].value;
 	var accountID 	= getCookie('AccountID');
 	var contactID 	= getCookie('ContactID');
 	var prospectID 	= getCookie('ProspectID');
 	var entityFor 	= document.getElementsByName("CorporateRepBO.entity_Type")[0].value;
 	hdifrm_empform.location.href="../servlet/com.infy.cis.ui.corpcif.CorpRepRefersh?accountID=" + accountID+"&amp;entityFor=" + entityFor+"&amp;contactID=" + contactID+"&amp;prospectID=" + prospectID+"&amp;forQDE=true";
   }

function MapAddressType()
 {
 var defAddType = document.getElementsByName("CorporateBO.DefaultAddressType")[0].value;
 if( defAddType == 'M'){
    document.getElementsByName("addType")[0].value = "M";
 }else if( defAddType == 'R' ){
   document.getElementsByName("addType")[0].value = "R";
 }else if( defAddType == 'H'){
    document.getElementsByName("addType")[0].value = "H";
	 }
 }
function addrdetails(){

	var accountID = getCookie('LookupAccountID');
	var contactID = getCookie('ContactID');
	var prospectID = getCookie('ProspectID');
	var entityFor = document.getElementsByName(boNameRep+".entity_Type")[0].value;
	var caseID = document.getElementsByName("CorporateRepBO.last_Name")[0].value;
	var cifAddress = document.getElementsByName("addressCategory")[0].value;
	var addCategory = document.getElementsByName(boNameRep+".cifAddrEntity")[0].value;
	var Flag='Y';
	addrType = document.getElementsByName("addressCategory")[0];
	if((caseID =='')){
		showUserMessage("MSGJ50118",null);
		return false
	}
	hdifrm_empform.location.href= "../servlet/com.infy.cis.ui.corpcif.CorpRepRefersh?accountID=" + accountID+"&amp;cifAddress=" + cifAddress+"&amp;addCategory=" + addCategory+"&amp;contactID="+ contactID +"&amp;prospectID="+ prospectID + "&amp;Flag=" +Flag;
}
function addrCheck(){

	var accountID = getCookie('LookupAccountID');
	var contactID = getCookie('ContactID');
	var prospectID = getCookie('ProspectID');
	var entityFor = document.getElementsByName(boNameRep+".entity_Type")[0].value;
	var caseID = document.getElementsByName("CorporateRepBO.entityKey")[0].value;
	var cifAddress = document.getElementsByName("addressCategory")[0].value;
	var addCategory = document.getElementsByName(boNameRep+".cifAddrEntity")[0].value;
	var Flag='check';
	addrType = document.getElementsByName("addressCategory")[0];
	//alert("caseID"+caseID);
//	alert("cifAddress"+cifAddress);
	//alert("addCategory"+addCategory);
	//alert("addrType"+addrType);

	if((caseID =='')){
		showUserMessage("MSGJ50118",null);
		return false;
	}
	// TRACKER 97917 Changes BEGIN
	hdifrm_empform.location.href= "../servlet/com.infy.cis.ui.corpcif.CorpRepRefersh?accountID=" + accountID+"&amp;cifAddress=" + cifAddress+"&amp;addCategory=" + addCategory+"&amp;contactID="+ contactID +"&amp;prospectID="+ prospectID + "&amp;Flag=" +Flag;
        // TRACKER 97917 Changes END
}
function checkAddrList(list1){
    if(list1.length == 0)
     {
	// TRACKER 97917 Changes BEGIN
	showUserMessage("MSGJ50139",null);
	addrFlag = 'false';
	addrType.focus();
	// TRACKER 97917 Changes END
     }
    else{
    addrFlag = 'true';
    }
}
function corpAddrCheck()
{
		var corpAddrFlag = false;
		var addrCat= document.getElementsByName("addressCategory")[0];
		/*if(boName=='CorporateBO'){
		for(var r=0 ; r < document.all.AdrRecordSet.rows.length ; r++)
				{
				recordSetAddressCategory = document.all.AdrRecordSet.rows(r).getAttribute("CorporateBO.Address.addressCategory");
					if(addrCat.value == recordSetAddressCategory)
					{
						corpAddrFlag = true;
					}
				}
		}
		else if (boName=='CorporateModBO'){
			for(var r=0 ; r < document.all.AdrRecordSet.rows.length ; r++)
			{
				recordSetAddressCategory = document.all.AdrRecordSet.rows(r).getAttribute("CorporateModBO.Address.addressCategory");
				if(addrCat.value == recordSetAddressCategory)
				{
					corpAddrFlag = true;
				}
			}
		}*/
		   if(!corpAddrFlag)
			{
				showUserMessage("MSGJ50139",null);
				addrCat.focus();
				addrFlag ='false';
			}
		   else{
			   addrFlag = 'true';
			   return;
		    }
}

var currentDateFormat = getColorCookie("SRMDateFormat");
// Changes for Ticket Id 359941:start
function toConvertDate(strDate) {
	var str = strDate.toString();
	var str1 = str.substring(0,4);
	var str2 = str.substring(5,6);
	var str3 = str.substring(6,7);
	var str4 = str.substring(8,9);
	var str5 = str.substring(9,10);
	if(str2 == "0") {
		if(str4 == "0") {
			return formatDate(str5,str3,str1,currentDateFormat);
		}
		else {
			return formatDate(str4+str5,str3,str1,currentDateFormat);
		}
	}
	else {
		if(str4 == "0") {
			return formatDate(str5,str2+str3,str1,currentDateFormat);
		}
		else {
			return formatDate(str4+str5,str2+str3,str1,currentDateFormat);
		}
	}
}
  function assignAddr(list1){
	  if(list1.length == 0){
	  	showUserMessage("MSGJ50139",null);
		  addrType.focus();
		addrFlag = 'false';
		}
		 else {
			addrFlag = 'true';
			var splittedDt = new Array();
			var splittedstDate = new Array();
			var splittedCustids = new Array();
			var tempvalue= new Array();
			var temps = new Array();
			tempvalue=list1.split("|");
			for(var i=0; i<tempvalue.length; i++){
			temps=tempvalue[i].split("^");
			}
			for(var i=0; i<temps.length; i++) {
				if(temps[i]  == "null")
					temps[i] = "";
			}
			document.frm2.addrID.value = temps[0];
			document.frm2.address_type.value = temps[0];
			document.frm2.houseno.value= temps[1];
			document.frm2.premiseno.value = temps[2];
			document.frm2.building.value = temps[3];
			document.frm2.streetno.value = temps[4];
			document.frm2.suburb.value = temps[5];
			document.frm2.streetname.value = temps[6];
			document.frm2.locality.value = temps[7];
			document.frm2.town.value = temps[8];
			document.frm2.city.value = temps[9];
			document.frm2.state.value = temps[11];
			document.frm2.country.value = document.frm2.country.value = srmEscape(temps[14], '^', escChars) +"|#"+srmEscape(temps[13], '^', escChars);
			document.frm2.zip.value = temps[15];
			document.frm2.domicile.value = temps[18];
			str_date = toConvertDate(temps[18]);
			end_date = toConvertDate(temps[19]);
			document.frm2.start_date.value = str_date;
			document.frm2.end_date.value = end_date;
			document.frm2.extension.value = temps[22];
			document.frm2.Email.value = temps[25];
			document.frm2.website.value = temps[27];
			document.frm2.mailstop.value = temps[28];
		    document.frm2.PreferredFormat.value = temps[29];
			document.frm2.PreferredAddress.value = temps[30];
			document.frm2.AddressLine1.value = temps[39];
			document.frm2.AddressLine2.value = temps[40];
			document.frm2.AddressLine3.value = temps[31];
			document.frm2.FreeTextLabel.value = temps[32];
			document.frm2.HoldMailInitiatedBy.value = temps[33];
			document.frm2.HoldMailFlag.value = temps[34];
			document.frm2.HoldMailReason.value = temps[35];
			document.frm2.BusinessCenter.value = temps[36];
			EduDetDetailsEdit = window.open('../common/html/SSOblank.html', 'temps', 'directories=No, height=436, left=70, top=120, width=860,resizable=no,titlebar=no,toolbar=no,status=no,scrollbars=yes');
			document.frm2.target = 'temps'
			document.frm2.action = '../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?hreadOnly=Y';
			document.frm2.submit();
      }
 }
//changes done for ticket id 435934 starts
function loadprimesolid(){
         /*Changes for firestone tracker id 351531 Starts*/          
         var indexValue= Cat_bcName.indexOf('#');         
	//changes for call id 369294 and recon of call id 366454 starts
	var indexValue1= bcName.indexOf('#');
	//var Cat_value=Cat_bcName.substring(0,indexValue);
	var Cat_value=bcName.substring(indexValue1+1);
	//changes for call id 369294 and recon of call id 366454 end   
         var Cat_textValue = Cat_bcName.substring(indexValue+1);   
         document.getElementsByName("Cat_CorporateBO.primary_Service_Center")[0].value = Cat_textValue;   
         //document.getElementsByName("CorporateBO.primary_Service_Center")[0].value = Cat_value;   
         document.getElementsByName("CorporateBO.primary_Service_Center")[0].value = bcName;
         /*Changes for firestone tracker id 351531 Ends*/ 

}
//changes done for ticket id 435934 ends

 function loadrel()
{

	var str;
	//LegalCode = legalEntType;


	//document.getElementsByName(boName+".Subsector_Code")[0].value = SubsecCode;
	document.getElementsByName(boName+".Sector_Code")[0].value = SecCode;
	//document.getElementsByName(boName+".legalEntity_Type_Code")[0].value = LegalCode;


}
 function addIDDetails(IdentificationDetails)	//modified by abhinav
 {
 	try
 	{
 		identifier_type_Code         = IdentificationDetails[0];
 		unique_id                    = IdentificationDetails[1];
 		placeofissue                 = IdentificationDetails[2];
 		dateofissue                  = IdentificationDetails[3];
 		validity_date                = IdentificationDetails[4];
 		countryofissue             	 = IdentificationDetails[5];
 		placeofissue_cat	         = IdentificationDetails[7];
 		countryofissue_cat           = IdentificationDetails[8];
		identifier_type_Code_cat     = GetCookie('EntityDocumentBO.IdentificationType');
 		docCode               		 = IdentificationDetails[10];
 		docDescr              		 = IdentificationDetails[11];
 		docTypeCode            		 = IdentificationDetails[12];
 		docTypeDescr           		 = IdentificationDetails[13];
 		docRemarks             		 = IdentificationDetails[14];
 		isMandatory            		 = IdentificationDetails[15];
 		scanRequired           		 = IdentificationDetails[16];
 		status               		 = IdentificationDetails[17];
 		docReceivedDate              = IdentificationDetails[18];
		isDocumentVerified    		 = IdentificationDetails[24];
		idIssuedOrg                  = IdentificationDetails[25];//Fix for ticket 296523
 		IDURL                	     = identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
 		var noOfexistingURLs = EDoc_URL.length;
 		var alreadyAdded=false;
 		var tempIndex;
 		/* Changes for ticket 306045 start */
		for(var x = 0; x < noOfexistingURLs ; x++)
		{
						if(identifier_type_Code!= '' || EDoc_identifier_type_Code[x] !='')
						{
							if(identifier_type_Code == EDoc_identifier_type_Code[x])
							{
								alreadyAdded = true;
								break;
							}

						}
						else
						{
							if((EDoc_docTypeCode[x] == docTypeCode) && (EDoc_docCode[x] == docCode))
							{
								alreadyAdded = true;
								break;
							}
						}
		}
		/* changes for ticket 306045 end */
 		for(var x = 0; x < noOfexistingURLs ; x++)
 		{
 			if(IDURL == EDoc_URL[x])
 			{
 				alreadyAdded = true;
 				break;
 			}
 		}

 		if(updateIDDet)
 		{
 			tempIndex=IDArrayIndex;
 		}
 		else
 		{
 			if(alreadyAdded)
 			{
 				showUserMessage("MSG_IDEXISTS",null);
 				return;
 			}
 			tempIndex=EDoc_URL.length;
 			EDoc_EntityDocumentID[tempIndex] = null;
 			EDoc_EntityDocumentURL[tempIndex] = null;
 		}
 		EDoc_identifier_type_Code[tempIndex] = identifier_type_Code;
 		EDoc_docCode[tempIndex] = docCode;
 		EDoc_docDescr[tempIndex] = docDescr;
 		EDoc_docTypeCode[tempIndex] = docTypeCode;
 		EDoc_docTypeDescr[tempIndex] = docTypeDescr;
 		EDoc_docReceivedDate[tempIndex] = docReceivedDate;
 		EDoc_docRemarks[tempIndex] = docRemarks;
 		EDoc_Status[tempIndex] = status;
 		EDoc_isMandatory[tempIndex] = isMandatory;
 		EDoc_scanRequired[tempIndex] = scanRequired;
 		EDoc_unique_id[tempIndex] = unique_id;
 		EDoc_placeofissue[tempIndex] = placeofissue;
 		EDoc_placeofissue_cat[tempIndex] = placeofissue_cat;
 		EDoc_dateofissue[tempIndex] = dateofissue;
 		EDoc_validity_date[tempIndex] = validity_date;
 		EDoc_countryofissue[tempIndex] = countryofissue;
 		EDoc_countryofissue_cat[tempIndex] = countryofissue_cat;
 		EDoc_URL[tempIndex] = IDURL;
		EDoc_isDocumentVerified[tempIndex] = isDocumentVerified;
		EDoc_idIssuedOrg[tempIndex] = idIssuedOrg;//Fix for ticket 296523
		if(EDoc_IsDirty[tempIndex]=='N')
			EDoc_IsDirty[tempIndex]='Y';
 		if (updateIDDet)
 		{
			/*Changes for firestone tracker id 360539 starts*/
			currIDTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + docCode + "</font>";
			/*Changes for firestone tracker id 360539 ends*/
			/*Changes for Ticket id:321666 Start */
 			currIDTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + unique_id + "</font>";
 			currIDTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + placeofissue_cat + "</font>";
 			/*Changes for Ticket id:321666 End */
 			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
 			if((dateofissue!= '') && (dateofissue != undefined))
			{
				dateofissue = changeDateAccToPresentCalendar(dateofissue);
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
			/*Changes for Ticket id:321666 Start */
 			currIDTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + dateofissue + "</font>";
 			/*Changes for Ticket id:321666 End*/
 			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
 			if((validity_date!=null) && (validity_date!= '') && (validity_date != undefined))
 			{
				validity_date = changeDateAccToPresentCalendar(validity_date);
				/*Changes for Ticket id:321666 Start*/
 				currIDTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + validity_date + "</font>";
 				/*Changes for Ticket id:321666 End*/
 			}
 			if((docReceivedDate!= '') && (docReceivedDate != undefined))
			{
				docReceivedDate = changeDateAccToPresentCalendar(docReceivedDate);
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
			/*Changes for Ticket id:321666 Start*/
 			currIDTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + docReceivedDate + "</font>";
 			/*Changes for Ticket id:321666 End*/
			if(entityDocumentBO_Name=='EntityDocumentBO'){
			    document.all.EDocRecordSet.rows(IDRecordIndex).setAttribute("EntityDocumentBO.url", IDURL);
			}
			else if(entityDocumentBO_Name=='EntityDocumentModBO'){
			    document.all.EDocRecordSet.rows(IDRecordIndex).setAttribute("EntityDocumentModBO.url", IDURL);
			}
 		}
 		else
 		{
 			oNewNode = document.createElement("TR");
 			if(TBODY_EDocRecordSet.childNodes.length % 2 == 0)
 			{
 				oNewNode.setAttribute("className", "color1");
 			}
 			else
 			{
 				oNewNode.setAttribute("className", "color2");
 			}
 			TBODY_EDocRecordSet.appendChild(oNewNode);
 			var tdNode = document.createElement("TD");
 			oNewNode.appendChild(tdNode);
		    tdNode.innerHTML =  "<font class='fntColData'>" + docCode + "</font>";
 			var tdNode2 = document.createElement("TD");
 			oNewNode.appendChild(tdNode2);
 			tdNode2.innerHTML =  "<font class='fntColData'>" + unique_id+ "</font>";
 			var tdNode3 = document.createElement("TD");
 			oNewNode.appendChild(tdNode3);
 			tdNode3.innerHTML = "<font class='fntColData'>" + placeofissue_cat + "</font>";
 			var tdNode4 = document.createElement("TD");
 			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
			//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
			var idIndex = document.all.EDocRecordSet.rows.length;
			tdNode4.setAttribute("id","DATE1CorpCustQDEIDoc"+idIndex);
			if((dateofissue!= '') && (dateofissue != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
				dateofissue = changeDateAccToPresentCalendar(dateofissue);
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
 			oNewNode.appendChild(tdNode4);
 			tdNode4.innerHTML = "<font class='fntColData'>" + dateofissue + "</font>";
 			var tdNode5 = document.createElement("TD");
 			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
			//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
			tdNode5.setAttribute("id","DATE2CorpCustQDEIDoc"+idIndex);
			if((validity_date!= '') && (validity_date != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
				validity_date = changeDateAccToPresentCalendar(validity_date);
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
 			oNewNode.appendChild(tdNode5);
 			tdNode5.innerHTML = "<font class='fntColData'>" + validity_date + "</font>";
 			var tdNode6 = document.createElement("TD");
 			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
			//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
			tdNode6.setAttribute("id","DATE3CorpCustQDEIDoc"+idIndex);
			if((docReceivedDate!= '') && (docReceivedDate != undefined))
			{
			//date converted acc to the present calendar type before displaing in the multirec
				docReceivedDate = changeDateAccToPresentCalendar(docReceivedDate);
			}
			/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
 			oNewNode.appendChild(tdNode6);
 			tdNode6.innerHTML = "<font class='fntColData'>" + docReceivedDate + "</font>";
 			var tdNode7 = document.createElement("TD");
 			oNewNode.appendChild(tdNode7);
 			tdNode7.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editIdentificationDetails()'>";
 			oNewNode.attachEvent("onclick", callID);
			if(entityDocumentBO_Name=='EntityDocumentBO'){
			    oNewNode.setAttribute("EntityDocumentBO.url", IDURL);
			}
			else if(entityDocumentBO_Name=='EntityDocumentModBO'){
			    oNewNode.setAttribute("EntityDocumentModBO.url", IDURL);
			}
 		}
 		return "true";
 	}
     catch(e)
     {
     return 'false';
 	}
 	return 'true';
}
  function callID()
 {
 	for (i=0; i < document.all.EDocRecordSet.rows.length; i++)
 	{
 		var row_bgcolor=document.all.EDocRecordSet.rows(i).className;
 		 if ( row_bgcolor == 'rowHighLighted')
 		 {
 			  if ( i % 2 == 0)
 			  {
 				   document.all.EDocRecordSet.rows(i).className = 'color1';
 			  }
 			  else
 			  {
 				   document.all.EDocRecordSet.rows(i).className = 'color2';
 			  }
 		 }
 	}
 	if(event.srcElement.tagName == 'FONT' || event.srcElement.tagName == 'INPUT')
 	{
 		event.srcElement.parentElement.parentElement.className="rowHighLighted";
 	}
 	else if(event.srcElement.tagName == 'TD')
 	{
 		event.srcElement.parentElement.className="rowHighLighted";
 	}
 }
function editIdentificationDetails()     //modified by abhinav
{
    try
    {
        updateIDDet = true;
        deleteCookie('EntityDocumentBO.IdentificationType');
        var tempTableRow = '';
        if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '')
        {
		   tempTableRow = event.srcElement.parentElement.parentElement;
        }
        else
        {
			tempTableRow = event.srcElement.parentElement;
		}
        currIDTableRow = tempTableRow;
	if(entityDocumentBO_Name=='EntityDocumentBO'){
		IDDetURL = tempTableRow.getAttribute("EntityDocumentBO.url");

	}
	else if(entityDocumentBO_Name=='EntityDocumentModBO'){
		IDDetURL = tempTableRow.getAttribute("EntityDocumentModBO.url");

	}
        var i;
        for(i=0; i < EDoc_URL.length; i++)
        {
            if(EDoc_URL[i] == IDDetURL)
            {
				IDArrayIndex=i;
				break;
            }
        }
		var j;
	if(entityDocumentBO_Name=='EntityDocumentBO'){
        for (j=2; j < document.all.EDocRecordSet.rows.length; j++)
        {
				var docURL = document.all.EDocRecordSet.rows(j).getAttribute("EntityDocumentBO.url");
            if(docURL == IDDetURL)
            {
                break;
            }
		}
	}
	else if(entityDocumentBO_Name=='EntityDocumentModBO'){
		for (j=2; j < document.all.EDocRecordSet.rows.length; j++)
		{
				var docURL = document.all.EDocRecordSet.rows(j).getAttribute("EntityDocumentModBO.url");
		    if(docURL == IDDetURL)
		    {
			break;
		    }
		}
	}
        IDRecordIndex = j;
        document.frm2.identifier_type_Code.value=srmEscape(EDoc_identifier_type_Code[i], '^', escChars);
        document.frm2.unique_id.value=srmEscape(EDoc_unique_id[i], '^', escChars);;
         /*******ERPBOCF1:TRACKER:113259:STORAGE OF DATES :STARTOFCHANGES***********/
	 			      var ALTCALENDAR_TYPE = ALTCALENDAR_TYPE;
	 				if(ALTCALENDAR_TYPE == 'true')
	 				{
	 				   if(EDoc_dateofissue[i] != '')
	 				   {
	 				    var strFlag = isGregDateWithoutConv(EDoc_dateofissue[i]);
	 				    if(strFlag != 'true')
	 					{
	 						EDoc_dateofissue[i]=convertHijToGreg(EDoc_dateofissue[i]);
	 					}
	 				   }
	 				if(EDoc_validity_date[i] != '')
	 				   {
	 				    var strFlag = isGregDateWithoutConv(EDoc_validity_date[i]);
	 				    if(strFlag != 'true')
	 					{
	 						EDoc_validity_date[i]=convertHijToGreg(EDoc_validity_date[i]);
	 					}
	 				   }
	 				}
	/************ERPBOCF1:TRACKER:113259:STORAGE OF DATES :ENDOFCHANGES***********/
        document.frm2.dateofissue.value = srmEscape(EDoc_dateofissue[i], '^', escChars);
        document.frm2.validity_date.value = srmEscape(EDoc_validity_date[i], '^', escChars);
		document.frm2.hidDocCode.value 			= srmEscape(EDoc_docCode[i], '^', escChars);
		document.frm2.hidDocDescr.value 			= srmEscape(EDoc_docDescr[i], '^', escChars);
		document.frm2.hidDocTypeCode.value 		= srmEscape(EDoc_docTypeCode[i], '^', escChars);
		document.frm2.hidDocTypeDescr.value 		= srmEscape(EDoc_docTypeDescr[i], '^', escChars);
		document.frm2.hidDocReceivedDate.value 	= srmEscape(EDoc_docReceivedDate[i], '^', escChars);
		document.frm2.hidDocRemarks.value 			= srmEscape(EDoc_docRemarks[i], '^', escChars);
		document.frm2.hidStatus.value			= srmEscape(EDoc_Status[i], '^', escChars);
		document.frm2.hidIsMandatory.value 		= srmEscape(EDoc_isMandatory[i], '^', escChars);
		document.frm2.hidScanRequired.value 		= srmEscape(EDoc_scanRequired[i], '^', escChars);
        document.frm2.placeofissue.value = srmEscape(EDoc_placeofissue[i], '^', escChars);
        document.frm2.placeofissue_cat.value = srmEscape(EDoc_placeofissue_cat[i], '^', escChars);
		document.frm2.countryofissue.value = srmEscape(EDoc_countryofissue[i], '^', escChars);
		document.frm2.countryofissue_cat.value = srmEscape(EDoc_countryofissue_cat[i], '^', escChars);
document.frm2.hidIsDocumentVerified.value 		= srmEscape(EDoc_isDocumentVerified[i], '^', escChars);
document.frm2.hidIDIssuedOrg.value 		= srmEscape(EDoc_idIssuedOrg[i], '^', escChars);//Fix for ticket 296523
		recordIndex1 = i;
		/* Tracker: 108382: Changes for centering popup */
		windowAlign();
		IDDetDetailsEdit = window.open('../common/html/SSOblank.html', 'IDDetails', 'directories=No,height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no, titlebar=no,toolbar=no,status=no,scrollbars=yes');
		/* Tracker: 108382: End of Changes */
		document.frm2.target = 'IDDetails'
		document.frm2.action = "../servlet/com.infy.cis.ui.common.EntityDocument_Det?dual="+dualflag;
        document.frm2.submit();

    }
    catch(e)
    {
	}
}
function removeIDdetails()
{
	try
	{
        var tempIDDetURL = '';
        var tempEntityDocumentID = '';
        var tempIDRow;
        if(CheckForSelectedRow(document.getElementsByName('EDocRecordSet'))=="false")
        {
            showUserMessage("MSG158",'MSG_LODOC');
            return;
        }
        if(!showUserChoiceMessage("MSG045","MSG_LODOC"))
        	return;
        for (i=0; i < document.all.EDocRecordSet.rows.length ; i++)
        {
            var row_bgcolor = document.all.EDocRecordSet.rows(i).className;
            if ( row_bgcolor == 'rowHighLighted')
            {
				tempIDRow=document.all.EDocRecordSet.rows(i);
				break;
			}
        }
	if(entityDocumentBO_Name=='EntityDocumentBO'){
    		tempEntityDocumentID=tempIDRow.getAttribute("EntityDocumentBO.EntityDocumentID");
		tempIDDetURL = tempIDRow.getAttribute("EntityDocumentBO.url");
	}
	else if(entityDocumentBO_Name=='EntityDocumentModBO'){
    		tempEntityDocumentID=tempIDRow.getAttribute("EntityDocumentModBO.EntityDocumentID");
		tempIDDetURL = tempIDRow.getAttribute("EntityDocumentModBO.url");

	}
		noOfAttachURLs = EDoc_URL.length;
		for(r=0; r< noOfAttachURLs; r++)
		{
			if(EDoc_URL[r] == tempIDDetURL)
			{
				EDoc_URL[r] = null;
				break;
			}
		}
		document.all.EDocRecordSet.deleteRow(i);
		if(tempEntityDocumentID!=null)
		{
			EDoc_detachedURLs[EDoc_detachedURLs.length] = tempEntityDocumentID;
		}
		for (i=0; i < document.all.EDocRecordSet.rows.length ; i++)
		{
			if(i % 2 != 0)
			{
				document.all.EDocRecordSet.rows(i).setAttribute("className", "color2");
			}
			else
			{
				document.all.EDocRecordSet.rows(i).setAttribute("className", "color1");
			}
		}
    }
    catch(e)
    {
	}
}
function validateDOI(){
/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
/* DBS Enhancement tracker ID :-402520 by rattandeep_singh01 */
	//isGregDate("3_CorporateBO.date_Of_Incorporation");
	isGregDate_IOC("3_CorporateBO.date_Of_Incorporation");
/* DBS Enhancement tracker ID :-402520 by rattandeep_singh01 */
/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	var tempMsg = new Array();
	var todaydate = new String();
	todaydate.value =  getTodayDate1();
	var elem1 = document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0];
	/*ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	if(elem1.value != '')
	{
		/* CRM102BETA : Ticket ID:369198 TrackerID:226282 Begin of Change */
		todaydate.value = convertDate(todaydate.value);
		/* CRM102BETA : Ticket ID:369198 TrackerID:226282 End of Change */
		}
		// Changes for Ticket Id 359941:End
	/* ERPBOCF1:TRACKER:113259:BEGIN OF CHANGES(HIJRI)*/
	var currDate = changetoMillisForToday(todaydate.value);
	var DOI = changetoMillis(elem1.value);
	if ( DOI > currDate){
		showUserMessage("MSGJ50157");
		document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].value='';
		document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].focus();
		return;
	}
// Fix For Ticket 435932 Starts
	elem2 = document.getElementsByName("3_CorporateBO.Address.Start_Date")[0];
		var mill1 = changetoMillis(elem2.value); 
		if ((mill1 != '')&&(mill1 < DOI)){
		
	
		showUserMessage("MSGJ52429");
	
         	elem2.value = "";                                    

        	}
// Fix For Ticket 435932 Ends
}
function check(Tab,corpsubmit) {

	if(corpsubmit == false) {
		noValidationMsg = true;
	}
	else {
		noValidationMsg = false;
	}
	/* Ticket ID 202878 Fix Start */
	//FormatBeforeSave("3_CorporateBO.average_AnnualIncome");
	/* Ticket ID 202878 Fix End */
          //     validateRM();
		var dob = document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].value;
		var fieldDob = document.getElementsByName("CorporateBO.date_Of_Incorporation")[0];
		var hasOtherErrors1;
		var hasOtherErrors;
		var altCalendarHij = ALTCALENDAR_TYPE;
	//	hasOtherErrors1 = Validate_againstDobHij(altCalendarHij,selTabId,document.getElementsByName("3_CorporateBO.relationship_StartDate")[0],getLabel(fieldDob.Display),dob);
		//tracker 113259:Hijri:to validate for hijri dates:change end
		if(hasOtherErrors1 == "true") {
			hasOtherErrors = "true";
		}
		if(hasOtherErrors=="true"){
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
		}
       		/*tracker id 156972 changes starts*/

		if(hasOtherErrors == 'true'){
			Screen = 0;
			parent.parent.parent.parent.messageFrm.showMessages(selTabId);
			return "interactive";
		}
       		/*tracker id 156972 changes ends*/
		if(document.getElementsByName("CorporateBO.corp_Key")[0].value == "")
		 {
				if(document.all.isAutoGenKey.value == 'true')
				{
					document.getElementsByName("CorporateBO.corp_Key")[0].IsMandatory = "false";
				}
		}
	return parent.parent.parent.parent.ValidateFormCorporate(document.frm2,true,Tab,noValidationMsg);
}

function setFocusOnComp(compName) {
  var object = "";
  var elementName = eval(object + "document.getElementsByName(compName)[0]");
	if(elementName) {
		if(elementName.displayFieldName){
			elementName = eval(object + "document.getElementsByName(elementName.displayFieldName)[0]");
		}
		try{
			var ids = elementName.parentElement.parentElement.parentElement.parentElement.parentElement.id;
			ids = trim(ids.replace("det_",""));
			eval(object + "showTabFortabEntityFieldDetails('" + ids +"')");
		}catch(e){
		}

		if (elementName.type == "text" || elementName.type == "textarea"){
			elementName.select();
		}else{
			elementName.focus();
		}
	}
}

function makekeyMand(){
	if(document.all.isAutoGenKey.value == 'false' || document.all.isAutoGenKey.value == '') {
		document.getElementsByName("mandStarCorporateBO.corp_Key")[0].style.visibility="visible";
		document.getElementsByName("CorporateBO.corp_Key")[0].IsMandatory = "true";
	}
}
function loadID()
{
	try
	{
		customLoad();
	}
	catch(e)
	{}
	if(document.frm2.hid_corporateURL.value != '')
	{
		editMode = true;
		if(entityDocumentBO_Name=='EntityDocumentBO'){
		for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
		{
				var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID");
			if ((EntityDocumentID != null) && (EntityDocumentID != 'undefined'))
			{
					identifier_type_Code			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IdentificationType"));
					unique_id 						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ReferenceNumber"));
					placeofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.PlaceOfIssue"));
					placeofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentBO.PlaceOfIssue"));
					countryofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.CountryOfIssue"));
					countryofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentBO.CountryOfIssue"));
					dateofissue  					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocIssueDate"));
					validity_date 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocExpiryDate"));
					EntityDocumentID 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.EntityDocumentID"));

					EntityDocumentURL 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.url_"));

					docCode							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocCode"));
					docDescr						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocDescr"));
					docTypeCode						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeCode"));
					docTypeDescr					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocTypeDescr"));
					docReceivedDate					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocReceivedDate"));
					docRemarks						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.DocRemarks"));
					status							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.Status"));
					isMandatory						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IsMandatory"));
					scanRequired					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.ScanRequired"));
					isDocumentVerified					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IsDocumentVerified"));
					idIssuedOrg			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentBO.IDIssuedOrganisation"));//Fix for ticket 296523
				EDoc_identifier_type_Code[i-2] 	= identifier_type_Code;
				EDoc_docCode[i-2] 				= docCode;
				EDoc_docDescr[i-2] 				= docDescr;
				EDoc_docTypeCode[i-2] 			= docTypeCode;
				EDoc_docTypeDescr[i-2] 			= docTypeDescr;
				EDoc_docReceivedDate[i-2] 		= docReceivedDate;
				EDoc_docRemarks[i-2]		 	= docRemarks;
				EDoc_Status[i-2] 				= status;
				EDoc_isMandatory[i-2] 			= isMandatory;
				EDoc_scanRequired[i-2] 			= scanRequired;
				EDoc_unique_id[i-2] 			= unique_id;
				EDoc_placeofissue[i-2] 			= placeofissue;
				EDoc_countryofissue[i-2] 		= countryofissue;
				EDoc_placeofissue_cat[i-2] 		= placeofissue_cat;
				EDoc_countryofissue_cat[i-2] 	= countryofissue_cat;
				EDoc_dateofissue[i-2] 			= dateofissue;
				EDoc_validity_date[i-2] 		= validity_date;
				EDoc_EntityDocumentID[i-2] 		= EntityDocumentID;
				EDoc_EntityDocumentURL[i-2] 	= EntityDocumentURL;
				EDoc_URL[i-2] 					= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
				EDoc_IsDirty[i-2] 				= 'N';
				EDoc_isDocumentVerified[i-2] 		= isDocumentVerified;
				EDoc_idIssuedOrg[i-2]			= idIssuedOrg;//Fix for ticket 296523
					document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
				}
			}
		}
		else if(entityDocumentBO_Name=='EntityDocumentModBO'){
			for (i=2; i < document.all.EDocRecordSet.rows.length; i++)
			{
				var EntityDocumentID = document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID");
				if ((EntityDocumentID != null) && (EntityDocumentID != 'undefined'))
				{
					identifier_type_Code			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IdentificationType"));
					unique_id 						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ReferenceNumber"));
					placeofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.PlaceOfIssue"));
					placeofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.PlaceOfIssue"));
					countryofissue 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.CountryOfIssue"));
					countryofissue_cat 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("Cat_EntityDocumentModBO.CountryOfIssue"));
					dateofissue  					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocIssueDate"));
					validity_date 					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocExpiryDate"));
					EntityDocumentID 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.EntityDocumentID"));
					EntityDocumentURL 				= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.url_"));
					docCode							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocCode"));
					docDescr						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocDescr"));
					docTypeCode						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeCode"));
					docTypeDescr					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocTypeDescr"));
					docReceivedDate					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocReceivedDate"));
					docRemarks						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.DocRemarks"));
					status							= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.Status"));
					isMandatory						= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IsMandatory"));
					scanRequired					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.ScanRequired"));
					isDocumentVerified					= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IsDocumentVerified"));
					idIssuedOrg			= trim(document.all.EDocRecordSet.rows(i).getAttribute("EntityDocumentModBO.IDIssuedOrganisation"));//Fix for ticket 296523
					EDoc_identifier_type_Code[i-2] 	= identifier_type_Code;
					EDoc_docCode[i-2] 				= docCode;
					EDoc_docDescr[i-2] 				= docDescr;
					EDoc_docTypeCode[i-2] 			= docTypeCode;
					EDoc_docTypeDescr[i-2] 			= docTypeDescr;
					EDoc_docReceivedDate[i-2] 		= docReceivedDate;
					EDoc_docRemarks[i-2]		 	= docRemarks;
					EDoc_Status[i-2] 				= status;
					EDoc_isMandatory[i-2] 			= isMandatory;
					EDoc_scanRequired[i-2] 			= scanRequired;
					EDoc_unique_id[i-2] 			= unique_id;
					EDoc_placeofissue[i-2] 			= placeofissue;
					EDoc_countryofissue[i-2] 		= countryofissue;
					EDoc_placeofissue_cat[i-2] 		= placeofissue_cat;
					EDoc_countryofissue_cat[i-2] 	= countryofissue_cat;
					EDoc_dateofissue[i-2] 			= dateofissue;
					EDoc_validity_date[i-2] 		= validity_date;
					EDoc_EntityDocumentID[i-2] 		= EntityDocumentID;
					EDoc_EntityDocumentURL[i-2] 	= EntityDocumentURL;
					EDoc_URL[i-2] 					= identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue;
					EDoc_IsDirty[i-2] 				= 'N';
					EDoc_isDocumentVerified[i-2] 		= isDocumentVerified;
					EDoc_idIssuedOrg[i-2]			= idIssuedOrg;//Fix for ticket 296523
					document.all.EDocRecordSet.rows(i).setAttribute("EntityDocumentModBO.url", identifier_type_Code + unique_id + placeofissue + dateofissue + countryofissue);
				}
			}

		}
 	}
}
function disableCorpRep(){

	var entityType = document.getElementsByName(boNameRep+".entity_Type")[0].value;

	if(entityType == ""){

		document.getElementsByName("mandStar"+boNameRep+".entity_Type")[0].style.visibility="hidden";
		document.getElementsByName("mandStar"+boNameRep+".cifAddrEntity")[0].style.visibility="hidden";
		document.getElementsByName("mandStaraddressCategory")[0].style.visibility="hidden";
		document.getElementsByName("mandStarCorporateRepBO.entityKey")[0].style.visibility="hidden";
		document.getElementsByName(boNameRep+".entity_Type")[0].IsMandatory = "false";
		document.getElementsByName(boNameRep+".cifAddrEntity")[0].IsMandatory = "false";
		document.getElementsByName("addressCategory")[0].IsMandatory = "false";
		document.getElementsByName("CorporateRepBO.entityKey")[0].IsMandatory = "false";
		document.getElementsByName(boNameRep+".cifAddrEntity")[0].disabled = true;
		document.getElementsByName("addressCategory")[0].disabled = true;
		document.getElementsByName(boNameRep+".designation")[0].disabled = true;
		document.getElementsByName("CorporateRepBO.entityKey")[0].disabled = true;
		document.getElementsByName(boNameRep+".cifAddrEntity")[0].value = "";
		document.getElementsByName("addressCategory")[0].value = "";
		document.getElementsByName(boNameRep+".designation")[0].value = "";
	}else{

		document.getElementsByName("mandStar"+boNameRep+".entity_Type")[0].style.visibility="";
		document.getElementsByName("mandStar"+boNameRep+".cifAddrEntity")[0].style.visibility="";
		document.getElementsByName("mandStaraddressCategory")[0].style.visibility="";
		document.getElementsByName("mandStarCorporateRepBO.entityKey")[0].style.visibility="";
		document.getElementsByName(boNameRep+".entity_Type")[0].IsMandatory = "true";
		document.getElementsByName(boNameRep+".cifAddrEntity")[0].IsMandatory = "true";
		document.getElementsByName("addressCategory")[0].IsMandatory = "true";
		document.getElementsByName("CorporateRepBO.entityKey")[0].IsMandatory = "true";
		document.getElementsByName("CorporateRepBO.entityKey")[0].disabled = false;

		document.getElementsByName(boNameRep+".cifAddrEntity")[0].disabled = false;
		document.getElementsByName("addressCategory")[0].disabled = false;
		document.getElementsByName(boNameRep+".designation")[0].disabled = false;
	}
}

function validateCorpRep(){

	//var dob_obj = document.getElementsByName("CorporateRepBO.dob")[0];
	//var lastname_obj = document.getElementsByName("CorporateRepBO.last_Name")[0];
	var addrCategory_obj = document.getElementsByName("addressCategory")[0];
	var addrMode_obj = document.getElementsByName(boNameRep+".cifAddrEntity")[0];
	var status = "false";
	//var dob = dob_obj.value;
	//var lastname = lastname_obj.value;
	var addrCategory = addrCategory_obj.value;
	var addrMode = addrMode_obj.value;
	//if(dob == ""){
			//parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserErrorMessage("MSG086",getLabel(dob_obj.Display)),
			//		dob_obj.name , 'HYPER_LINK');
		//	status = "true";
	//}
	//if(lastname == ""){
			//parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserErrorMessage("MSG086",getLabel(lastname_obj.Display)),
			//		lastname_obj.name , 'HYPER_LINK');
			//status = "true";
	//}
	if(addrCategory == ""){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserErrorMessage("MSG086",getLabel(addrCategory_obj.Display)),
					addrCategory_obj.name , 'HYPER_LINK');
			status = "true";
	}
	if(addrMode == ""){
			parent.parent.parent.parent.messageFrm.addMessage(selTabId, getUserErrorMessage("MSG086",getLabel(addrMode_obj.Display)),
					addrMode_obj.name , 'HYPER_LINK');
			status = "true";
	}
	return status;
}
function loadBackEnd() {
	var k = 0;
	if (assignedBackEndID!=null && assignedBackEndID!="" && assignedBackEndID!= "null" ) {
		var backendid = new Array();
		var len_avail =0;
		backendid = assignedBackEndID.split(",");
		var len_backendid = backendid.length;
		var len_assign = document.frm2.Assigned_BackendID.length;
		for (var i=0;i < len_assign;i++ ) {
			var assign_backend=document.frm2.Assigned_BackendID.options[i].text;
			for (var j=0; j< len_backendid; j++ ) {
				if (backendid[j] == assign_backend) {
					try {
						k++;
						document.frm2.Available_BackendID.length =k;
						document.frm2.Available_BackendID.options[len_avail].text = assign_backend;
						len_avail++;
						document.frm2.Assigned_BackendID.options[i] = null;
						i--;
						len_assign--;
						break;
					} catch (ex) {
					}
				}
			}
		}
	}
}
function setAgentValues() {
	var primaryRM=document.getElementsByName("CorporateBO.PrimaryRMLogin_ID")[0].value;
	var secondaryRM=document.getElementsByName("CorporateBO.SecondRMLogin_ID")[0].value;
	if ( (primaryRM!="" && primaryRM != defaultPrimaryRM && primaryRM!=null && primaryRM!="null") || (secondaryRM !="" && secondaryRM != defaultSecondaryRM && secondaryRM !=null && secondaryRM!="null") ) {
		RMChanged='true';
	}
	else {
		RMChanged='false';
	}
}
	 function addConcessionInfo(URL,
			 creditDiscountPercentage,
			 debitDiscountPercentage,
			 withTaxPercentage,
			 withTaxFloorLimit,
			 preferentialExpiryDate,
			 currency){

	    ConcessionappendTRChild(URL,
			 creditDiscountPercentage,
			 debitDiscountPercentage,
			 withTaxPercentage,
			 withTaxFloorLimit,
			 preferentialExpiryDate,
			 currency);
}
function ConcessionappendTRChild(URL,
			 creditDiscountPercentage,
			 debitDiscountPercentage,
			 withTaxPercentage,
			 withTaxFloorLimit,
			 preferentialExpiryDate,
			 currency)
{
    var alreadyAdded = false;
    var uid;
    var i =0;
    for(i=0;i<ConcessionCurrency.length;i++)
    {
    	if(currency == ConcessionCurrency[i])
    	{
    		var showAlert = false;

		  if(ConcessionPref)
		  {
			if(currencyID != i) {
			 showAlert = true;
			}
		  }
		else if(!ConcessionPref) {

			showAlert = true;
		}
		if(showAlert) {
		    showMessage(MSGJ0550);
		    return;
		}
    	}
    }
	var add_category_ML = GetCookie('PreferencesBO.CorpMiscellaneousInfo.str1');
    if(!ConcessionPref)
    {  // New Entry
        oNewNode = document.createElement("TR");
        if(TBODY_ConcessionRecordSet.childNodes.length % 2 == 0) {
            oNewNode.setAttribute("className", "color1");
        } else {
            oNewNode.setAttribute("className", "color2");
        }
        TBODY_ConcessionRecordSet.appendChild(oNewNode);
        var s = "";
 	if(boNamePrefe=='PreferencesModBO'){
		oNewNode.id = creditDiscountPercentage;
		oNewNode.setAttribute("PreferencesModBO.preference_ID", URL);
		oNewNode.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage1", creditDiscountPercentage);
		oNewNode.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage2",debitDiscountPercentage);
		oNewNode.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage3",withTaxPercentage);
		oNewNode.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.amount1",withTaxFloorLimit);
		oNewNode.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.date1",preferentialExpiryDate);
		oNewNode.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.str1",currency);
	}else if(boNamePrefe=='PreferencesBO'){
		oNewNode.id = creditDiscountPercentage;
		oNewNode.setAttribute("PreferencesBO.preference_ID", URL);
		oNewNode.setAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage1", creditDiscountPercentage);
		oNewNode.setAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage2",debitDiscountPercentage);
		oNewNode.setAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage3",withTaxPercentage);
		oNewNode.setAttribute("PreferencesBO.CorpMiscellaneousInfo.amount1",withTaxFloorLimit);
		oNewNode.setAttribute("PreferencesBO.CorpMiscellaneousInfo.date1",preferentialExpiryDate);
		oNewNode.setAttribute("PreferencesBO.CorpMiscellaneousInfo.str1",currency);
	}
        populateConcessionListEntry(URL,
			 creditDiscountPercentage,
			 debitDiscountPercentage,
			 withTaxPercentage,
			 withTaxFloorLimit,
			 preferentialExpiryDate,
			 currency);

        var tdNode = document.createElement("TD");
        oNewNode.appendChild(tdNode);
        tdNode.innerHTML =  "<font class='fntColData'>" + creditDiscountPercentage + "</font>";
        var tdNode2 = document.createElement("TD");
        oNewNode.appendChild(tdNode2);
        tdNode2.innerHTML = "<font class='fntColData'>" + debitDiscountPercentage + "</font>";
        var tdNode1 = document.createElement("TD");
        oNewNode.appendChild(tdNode1);
        tdNode1.innerHTML = "<font class='fntColData'>" + withTaxPercentage + "</font>";
        var tdNode3 = document.createElement("TD");
        oNewNode.appendChild(tdNode3);
        tdNode3.innerHTML = "<font class='fntColData'>" + withTaxFloorLimit + "</font>";
        var tdNode4 = document.createElement("TD");
        /* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
	//id has been set for the date field such dat "date" phrase has 0 index and rowindex has been appended to make id unique for ever row
	var idIndex = document.all.ConcessionRecordSet.rows.length;
	tdNode4.setAttribute("id","DATE1CorpCustQDECurrencyDetails"+idIndex);
	if((preferentialExpiryDate!= '') && (preferentialExpiryDate != undefined))
	{
	//date converted acc to the present calendar type before displaing in the multirec
		preferentialExpiryDate = changeDateAccToPresentCalendar(preferentialExpiryDate);
	}
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
        oNewNode.appendChild(tdNode4);
        tdNode4.innerHTML = "<font class='fntColData'>" + preferentialExpiryDate + "</font>";
        var tdNode5 = document.createElement("TD");
        oNewNode.appendChild(tdNode5);
        //tdNode5.innerHTML = "<font class='fntColData'>" + currency + "</font>";
        tdNode5.innerHTML = "<font class='fntColData'>" + add_category_ML + "</font>";
        var tdNode6 = document.createElement("TD");
        oNewNode.appendChild(tdNode6);
        tdNode6.innerHTML = "<INPUT class='sbttn' TYPE = 'button' value = '...' onclick='editConcession()'>";
        oNewNode.attachEvent("onclick", rowHighLight_Concession);
    } else
    {
        // update mode
        if(boName=='PreferencesModBO'){
		currConcessionTableRow.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.miscellaneous_ID", URL);
		if(boName=='CorporateBO'){
			currConcessionTableRow.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage1", creditDiscountPercentage);   currConcessionTableRow.setAttribute("CorporateBO.CorpMiscellaneousInfo.percentage2",debitDiscountPercentage);
		}
		else if(boName=='CorporateModBO'){
			currConcessionTableRow.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage1", creditDiscountPercentage);   currConcessionTableRow.setAttribute("CorporateModBO.CorpMiscellaneousInfo.percentage2",debitDiscountPercentage);
		}
		currConcessionTableRow.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage3",withTaxPercentage);
		currConcessionTableRow.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.amount1",withTaxFloorLimit);
		currConcessionTableRow.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.date1",preferentialExpiryDate);
		currConcessionTableRow.setAttribute("PreferencesModBO.CorpMiscellaneousInfo.str1",currency);
        }else if(boName=='PreferencesBO'){
		currConcessionTableRow.setAttribute("PreferencesBO.CorpMiscellaneousInfo.miscellaneous_ID", URL);
		if(boName=='CorporateBO'){
			currConcessionTableRow.setAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage1", creditDiscountPercentage);   currConcessionTableRow.setAttribute("CorporateBO.CorpMiscellaneousInfo.percentage2",debitDiscountPercentage);

		}
		else if(boName=='CorporateModBO'){
			currConcessionTableRow.setAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage1", creditDiscountPercentage);   currConcessionTableRow.setAttribute("CorporateModBO.CorpMiscellaneousInfo.percentage2",debitDiscountPercentage);

		}
		currConcessionTableRow.setAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage3",withTaxPercentage);
		currConcessionTableRow.setAttribute("PreferencesBO.CorpMiscellaneousInfo.amount1",withTaxFloorLimit);
		currConcessionTableRow.setAttribute("PreferencesBO.CorpMiscellaneousInfo.date1",preferentialExpiryDate);
		currConcessionTableRow.setAttribute("PreferencesBO.CorpMiscellaneousInfo.str1",currency);
        }
        populateConcessionListEntry(URL,
			 creditDiscountPercentage,
			 debitDiscountPercentage,
			 withTaxPercentage,
			 withTaxFloorLimit,
			 preferentialExpiryDate,
			 currency);
        currConcessionTableRow.childNodes(0).innerHTML="<font class='fntColData'>" + creditDiscountPercentage + "</font>";
        currConcessionTableRow.childNodes(1).innerHTML="<font class='fntColData'>" + debitDiscountPercentage + "</font>";
        currConcessionTableRow.childNodes(2).innerHTML="<font class='fntColData'>" + withTaxPercentage + "</font>";
        currConcessionTableRow.childNodes(3).innerHTML="<font class='fntColData'>" + withTaxFloorLimit + "</font>";
        /* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- START*/
        if((preferentialExpiryDate!= '') && (preferentialExpiryDate != undefined))
	{
	//date converted acc to the present calendar type before displaing in the multirec
		preferentialExpiryDate = changeDateAccToPresentCalendar(preferentialExpiryDate);
	}
	/* Tracker-ID 113259:ERPBOCF1:Hijri:To refresh multirec on toggle of calendar type- END*/
        currConcessionTableRow.childNodes(4).innerHTML="<font class='fntColData'>" + preferentialExpiryDate + "</font>";
        //currConcessionTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + currency + "</font>";
        currConcessionTableRow.childNodes(5).innerHTML="<font class='fntColData'>" + add_category_ML + "</font>";
        ConcessionPref = false;
    }
}
// Function to Store the values in an Array for saving in DB
function populateConcessionListEntry(URL,
			 creditDiscountPercentage,
			 debitDiscountPercentage,
			 withTaxPercentage,
			 withTaxFloorLimit,
			 preferentialExpiryDate,
			 currency)
{
	try{
		var updateFlag = "false";
		var updateIndex = 0;

		for (i=0; i < document.all.ConcessionRecordSet.rows.length; i++)
		{
			var row_bgcolor = document.all.ConcessionRecordSet.rows(i).className;
			if ( row_bgcolor == 'rowHighLighted')
			{
				updateFlag = "true"
				updateIndex = i-2;
				break;
			}
		}
		if(updateFlag == "false") {
			ConcessionPsychoURL[ConcessionPsychoURL.length]        		 		 = URL;
			ConcessioncreditDiscountPercentage[ConcessioncreditDiscountPercentage.length]    = creditDiscountPercentage;
			ConcessiondebitDiscountPercentage[ConcessiondebitDiscountPercentage.length] 	 = debitDiscountPercentage;
			ConcessionwithTaxPercentage[ConcessionwithTaxPercentage.length]	  		 = withTaxPercentage;
			ConcessionwithTaxFloorLimit[ConcessionwithTaxFloorLimit.length] 		 = withTaxFloorLimit;
			ConcessionpreferentialExpiryDate[ConcessionpreferentialExpiryDate.length]        = preferentialExpiryDate;
			ConcessionCurrency[ConcessionCurrency.length]        				 = currency;
		} else {
			ConcessionPsychoURL[updateIndex]   	      		= URL;
			ConcessioncreditDiscountPercentage[updateIndex]         = creditDiscountPercentage;
			ConcessiondebitDiscountPercentage[updateIndex]          = debitDiscountPercentage;
			ConcessionwithTaxPercentage[updateIndex]   		= withTaxPercentage;
			ConcessionwithTaxFloorLimit[updateIndex]         	= withTaxFloorLimit;
			ConcessionpreferentialExpiryDate[updateIndex]           = preferentialExpiryDate;
			ConcessionCurrency[updateIndex]           		= currency;
		}
	}catch(e){
        	}
}
function removeConcession()
{
	var deleteFlag = false;
	var ConcessionURL = '';
	for (i=0; i < document.all.ConcessionRecordSet.rows.length; i++)
		{
		var row_bgcolor = document.all.ConcessionRecordSet.rows(i).className;
		if ( row_bgcolor == 'rowHighLighted')
		{
			var temp ='';
			if(boNamePrefe=='PreferencesModBO'){
				temp = document.all.ConcessionRecordSet.rows(i).getAttribute("PreferencesModBO.CorpMiscellaneousInfo.str1");
				ConcessionURL = document.all.ConcessionRecordSet.rows(i).getAttribute("PreferencesModBO.CorpMiscellaneousInfo.miscellaneous_ID");
			}else if(boNamePrefe=='PreferencesBO'){
				temp = document.all.ConcessionRecordSet.rows(i).getAttribute("PreferencesBO.CorpMiscellaneousInfo.str1");
				ConcessionURL = document.all.ConcessionRecordSet.rows(i).getAttribute("PreferencesBO.CorpMiscellaneousInfo.miscellaneous_ID");

			}
			document.all.ConcessionRecordSet.deleteRow(i);
			for (j=0; j<ConcessionPsychoURL.length; j++)
			{
				if (ConcessionCurrency[j] == temp)
				{
					ConcessioncreditDiscountPercentage[j]   = null;
					ConcessiondebitDiscountPercentage[j] = null;
					ConcessionwithTaxPercentage[j] = null;
					ConcessionwithTaxFloorLimit[j] = null;
					ConcessionpreferentialExpiryDate[j] = null;
					ConcessionCurrency[j] = null;
					// Deleted records are stored in an Array
					if((ConcessionPsychoURL[j] != null) && (ConcessionPsychoURL[j] != "")) {
						DeletedConcessioncreditDiscountPercentage[DeletedConcessioncreditDiscountPercentage.length] 			= ConcessioncreditDiscountPercentage[j];
						DeletedConcessiondebitDiscountPercentage[DeletedConcessiondebitDiscountPercentage.length] 			= ConcessiondebitDiscountPercentage[j];
						DeletedConcessionwithTaxPercentage[DeletedConcessionwithTaxPercentage.length]     				= ConcessionwithTaxPercentage[j];
						DeletedConcessionwithTaxFloorLimit[DeletedConcessionwithTaxFloorLimit.length] 					= ConcessionwithTaxFloorLimit[j];
						DeletedConcessionpreferentialExpiryDate[DeletedConcessionpreferentialExpiryDate.length]				= ConcessionpreferentialExpiryDate[j];
					}
					ConcessioncreditDiscountPercentage[j] = null;
					ConcessiondebitDiscountPercentage[j] = null;
					ConcessionwithTaxPercentage[j] = null;
					ConcessionwithTaxFloorLimit[j] = null;
					ConcessionpreferentialExpiryDate[j] = null;
					ConcessionCurrency[j] = null;
					break;
				}
			}
			DeletedConcessionID[DeletedConcessionID.length] = ConcessionURL;
			deleteFlag = true;
			break;
		}
	}
	if(deleteFlag == true) {
		for(var iRow = 2; iRow < document.all.ConcessionRecordSet.rows.length; iRow++){
			if(iRow % 2 == 0)
				document.all.ConcessionRecordSet.rows(iRow).className = "color1";
			else
				document.all.ConcessionRecordSet.rows(iRow).className = "color2";
		}
	}
	else {
		showUserMessage('MSG158', 'MSG_LOROW');
		return;
	}
}
function editConcession()
{
	ConcessionPref = true;
	var tempTableRow = '';
	if(event.srcElement.parentElement.id == null || event.srcElement.parentElement.id == '') {
		tempTableRow = event.srcElement.parentElement.parentElement;
	} else {
		tempTableRow = event.srcElement.parentElement;
	}
	currConcessionTableRow = tempTableRow;
	try {
		var  ConcessionURL='';
		if(boNamePrefe=='PreferencesModBO'){
			 ConcessionURL = tempTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.miscellaneous_ID");
			document.frm2.hConcessionPsychoURL.value 		= currConcessionTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.miscellaneous_ID");
			document.frm2.hConcessioncreditDiscountPercentage.value	= currConcessionTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage1");
			document.frm2.hConcessiondebitDiscountPercentage.value	= currConcessionTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage2");
			document.frm2.hConcessionwithTaxPercentage.value        = currConcessionTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.percentage3");
			document.frm2.hConcessionwithTaxFloorLimit.value 	= currConcessionTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.amount1");
			document.frm2.hConcessionpreferentialExpiryDate.value 	= currConcessionTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.date1");
			document.frm2.hConcessionCurrency.value 		= currConcessionTableRow.getAttribute("PreferencesModBO.CorpMiscellaneousInfo.str1");
		}else if(boNamePrefe=='PreferencesBO'){
			 ConcessionURL = tempTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.miscellaneous_ID");
			document.frm2.hConcessionPsychoURL.value 		= currConcessionTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.miscellaneous_ID");
			document.frm2.hConcessioncreditDiscountPercentage.value	= currConcessionTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage1");
			document.frm2.hConcessiondebitDiscountPercentage.value	= currConcessionTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage2");
			document.frm2.hConcessionwithTaxPercentage.value        = currConcessionTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.percentage3");
			document.frm2.hConcessionwithTaxFloorLimit.value 	= currConcessionTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.amount1");
			document.frm2.hConcessionpreferentialExpiryDate.value 	= currConcessionTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.date1");
			document.frm2.hConcessionCurrency.value 		= currConcessionTableRow.getAttribute("PreferencesBO.CorpMiscellaneousInfo.str1");

		}
		var CustCurr = document.frm2.hConcessionCurrency.value;
		for(i=0;i<ConcessionCurrency.length;i++) {
		      if(CustCurr == ConcessionCurrency[i])
			break;
		}
		currencyID = i;


	}
	catch(e)
	{
	}

	tempAction = document.frm2.action;

	document.frm2.action = '../servlet/com.infy.cis.ui.corpcif.CorpConcessionSelection?';
	/* Tracker: 108382: Changes for centering popup */
        windowAlign();
	//ProductPrefDet = window.open('../common/html/SSOblank.html', 'Concession', 'directories=No, height=436, left=70, top=120, width=860,resizable=no, location=no, menubar=no,  status=no, toolbar=no, scrollbars=yes');
	ProductPrefDet = window.open('../common/html/SSOblank.html', 'Concession', 'directories=No, height='+ wh+ ',left='+ left_x +',top='+ left_y+',width='+ww+',resizable=no, location=no, menubar=no,  status=no, toolbar=no, scrollbars=yes');
	/* Tracker: 108382: End of Changes */
	/* CRM10:TRACKER:40169,40170 :ENDOFCHANGES  */
	document.frm2.target = 'Concession';
	document.frm2.submit();
	document.frm2.action = tempAction;
}
function rowHighLight_Concession(){
	var selectedRow ;
	var ConcessionRecordSet ;
	for (i=0; i < document.all.ConcessionRecordSet.rows.length; i++) {
	    if ( i % 2==0)  {
	       document.all.ConcessionRecordSet.rows(i).className = 'color1';
		} else 	{
	       document.all.ConcessionRecordSet.rows(i).className = 'color2';
		}
   	}
	if(event.srcElement.tagName == 'FONT' || event.srcElement.tagName == 'INPUT') {
		event.srcElement.parentElement.parentElement.className="rowHighLighted";
	}
	else if(event.srcElement.tagName == 'TD'){
		event.srcElement.parentElement.className="rowHighLighted";
	}
}
function saveConcession() {
	try{
		document.all.hConcessionPsychoURL.value = "";
		document.all.hConcessioncreditDiscountPercentage.value = "";
		document.all.hConcessiondebitDiscountPercentage.value = "";
		document.all.hConcessionwithTaxPercentage.value = "";
		document.all.hConcessionwithTaxFloorLimit.value = "";
		document.all.hConcessionpreferentialExpiryDate.value = "";
		document.all.hConcessionCurrency.value = "";
		document.all.hDeletedConcessionID.value= "";
		for (i=0;i< ConcessionwithTaxFloorLimit.length;i++)
		{
			if (ConcessionwithTaxFloorLimit[i] != null && ConcessionwithTaxFloorLimit[i] != '')
			{
				if(document.all.hConcessionwithTaxFloorLimit.value != '')
				{
					document.all.hConcessionPsychoURL.value    		  = document.all.hConcessionPsychoURL.value + "," + myEscape(ConcessionPsychoURL[i]);
					document.all.hConcessioncreditDiscountPercentage.value    = document.all.hConcessioncreditDiscountPercentage.value + "," + myEscape(ConcessioncreditDiscountPercentage[i]);
					document.all.hConcessiondebitDiscountPercentage.value 	  = document.all.hConcessiondebitDiscountPercentage.value + "," + myEscape(ConcessiondebitDiscountPercentage[i]);
					document.all.hConcessionwithTaxPercentage.value 	  = document.all.hConcessionwithTaxPercentage.value + "," + myEscape(ConcessionwithTaxPercentage[i]);
					document.all.hConcessionwithTaxFloorLimit.value 	  = document.all.hConcessionwithTaxFloorLimit.value + "," + myEscape(ConcessionwithTaxFloorLimit[i]);
					document.all.hConcessionpreferentialExpiryDate.value 	  = document.all.hConcessionpreferentialExpiryDate.value + "," + myEscape(ConcessionpreferentialExpiryDate[i]);
					document.all.hConcessionCurrency.value 	  		  = document.all.hConcessionCurrency.value + "," + myEscape(ConcessionCurrency[i]);
				}
				else
				{
					document.all.hConcessionPsychoURL.value    		  = document.all.hConcessionPsychoURL.value + myEscape(ConcessionPsychoURL[i]);
					document.all.hConcessioncreditDiscountPercentage.value    = document.all.hConcessioncreditDiscountPercentage.value + myEscape(ConcessioncreditDiscountPercentage[i]);
					document.all.hConcessiondebitDiscountPercentage.value 	  = document.all.hConcessiondebitDiscountPercentage.value + myEscape(ConcessiondebitDiscountPercentage[i]);
					document.all.hConcessionwithTaxPercentage.value 	  = document.all.hConcessionwithTaxPercentage.value + myEscape(ConcessionwithTaxPercentage[i]);
					document.all.hConcessionwithTaxFloorLimit.value 	  = document.all.hConcessionwithTaxFloorLimit.value + myEscape(ConcessionwithTaxFloorLimit[i]);
					document.all.hConcessionpreferentialExpiryDate.value 	  = document.all.hConcessionpreferentialExpiryDate.value + myEscape(ConcessionpreferentialExpiryDate[i]);
					document.all.hConcessionCurrency.value 	 		  = document.all.hConcessionCurrency.value + myEscape(ConcessionCurrency[i]);
				}
			}
		}
	}catch(er){}
	for (i=0;i< DeletedConcessionID.length;i++)
	{
		if (DeletedConcessionID[i] != null && DeletedConcessionID[i] != '')
		{
			if(document.all.hDeletedConcessionID.value != '')
			{
				document.all.hDeletedConcessionID.value = document.all.hDeletedConcessionID.value + "," + myEscape(DeletedConcessionID[i]);
			} else {
				document.all.hDeletedConcessionID.value = document.all.hDeletedConcessionID.value  + myEscape(DeletedConcessionID[i]);
			}
		}
	}
}
function onRecordSelectCIFID(reservedID) {
	document.getElementsByName("CorporateBO.corp_Key")[0].value=reservedID;
	document.getElementsByName("hid_reservestatus")[0].value = "Lookup";
	reserveCIFID = reservedID;
}
function checkStatus(elename,keyGeneration) {
try {
	var elemValue = document.getElementsByName(elename)[0].value;
	if (elemValue =="" || reserveCIFID == elemValue|| keyGeneration== 'Reserved'||keyGeneration=="") {
		return;
	}
	else {
		checkReseravtion(elename,'Corporate',keyGeneration);
	}
}
catch (e) {
}
}
/* Ticket#: 214635 FIX STARTS */
function fnBluropenEntityLookup(type){
	var chk1 = chkBlurFrom1();
	if(chk1) {
		fnTabOut();
		return;
	}
	openprimarylookup();
}
function fnTabOut(){
	cifType = document.getElementsByName(boName+".CorpMiscellaneousInfo.str9")[0].value;
	var strCorpLastName = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value;
	if(strCorpLastName==''){
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value="";
		document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value= "";
		return ;
	}
	var recFlag ='';
	var flag = '';
	if((cifType=='RETAIL')||(cifType== 'Retail')){
		lookup = document.getElementsByName("Corp")[0].value;
	        if (lookup == ""){
			document.getElementsByName("corp")[0].value = "";
			showMessage(MSGJ50119);
			document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value="";
			return;
	  	}
	  	if(lookup == 'CUSTOMER' || lookup == 'Customer') {
	 		lookupFor = 'CUSTOMER';
	  		var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	  		var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+strCorpLastName+"&lookup="+lookupFor+"&cifType="+cifType;
	  		s_xmlHttp.open("POST",strURL,false);
	  		s_xmlHttp.send();
	  		if(s_xmlHttp.status == 200)
	  		{
	  			recFlag   = getColorCookie('sManyRecords');
	  			flag   = getColorCookie('sBooleans');
	  			if ((recFlag=="True")){
	  				flag='';
	  			}
	  		}
	  		s_xmlHttp.open("GET",strURL,false);
	  		s_xmlHttp.send();
	  	}
	  	if(lookup == 'CONTACT' || lookup == 'Contact') {
	  		lookupFor = 'CONTACT';
	  		var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	  		var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+strCorpLastName+"&lookup="+lookupFor+"&cifType="+cifType;
	  		s_xmlHttp.open("POST",strURL,false);
	  		s_xmlHttp.send();
	  		if(s_xmlHttp.status == 200)
	  		{
	  			recFlag   = getColorCookie('sManyRecords');
	  			flag   = getColorCookie('sBooleans');
	  			if ((recFlag=="True")){
	  				flag='';
	  			}
	  		}
	  		s_xmlHttp.open("GET",strURL,false);
	  		s_xmlHttp.send();
	  	}
	  	if(lookup == 'PROSPECT' || lookup == 'Prospect') {
	  		lookupFor = 'PROSPECT';
	  	        var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	  		var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+strCorpLastName+"&lookup="+lookupFor+"&cifType="+cifType;
	  		s_xmlHttp.open("POST",strURL,false);
	  		s_xmlHttp.send();
	  		if(s_xmlHttp.status == 200)
	  		{
	  			recFlag   = getColorCookie('sManyRecords');
	  			flag   = getColorCookie('sBooleans');
	  			if ((recFlag=="True")){
	  				flag='';
	  			}
	  		}
	  		s_xmlHttp.open("GET",strURL,false);
	  		s_xmlHttp.send();
	  	}
	}
	if((cifType=='CORPORATE')||(cifType== 'Corporate')){
		lookup = document.getElementsByName("Corp")[0].value;
		//alert("lookup "+lookup);
	  	if (lookup == ""){
	        	document.getElementsByName("Corp")[0].value = "";
			showMessage(MSGJ50138);
			document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value="";
			return;
	  	}
	  	if(lookup == 'CUSTOMER' || lookup == 'Customer') {
			lookupFor = 'CUSTOMER';
		  	var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
			var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+strCorpLastName+"&lookup="+lookupFor+"&cifType="+cifType;
			s_xmlHttp.open("POST",strURL,false);
			s_xmlHttp.send();
			if(s_xmlHttp.status == 200)
			{
				recFlag   = getColorCookie('sManyRecords');
				flag   = getColorCookie('sBooleans');
				if ((recFlag=="True")) {
					flag='';
				}
			}
			s_xmlHttp.open("GET",strURL,false);
			s_xmlHttp.send();
		}
	  	if(lookup == 'PROSPECT' || lookup == 'Prospect') {
	  		lookupFor = 'PROSPECT';
	  	        var s_xmlHttp = new ActiveXObject("MSXML2.XMLHTTP");
	 		var strURL = '../servlet/com.infy.cis.ui.cif.CifLookupValidate?lastName='+strCorpLastName+"&lookup="+lookupFor+"&cifType="+cifType;
	  		s_xmlHttp.open("POST",strURL,false);
	  		s_xmlHttp.send();
	  		if(s_xmlHttp.status == 200)
	  		{
	  			recFlag   = getColorCookie('sManyRecords');
	  			flag   = getColorCookie('sBooleans');
	  			if ((recFlag=="True")) {
	  				flag='';
	  			}
	  		}
	  		s_xmlHttp.open("GET",strURL,false);
	  		s_xmlHttp.send();
	  	}
	}
	if(recFlag=='True'){
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value= "";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value= "";
		document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value= "";
		if((cifType=='RETAIL')||(cifType== 'Retail')){
			document.getElementsByName("hid_CorporateBO.CorpMiscellaneousInfo.str4")[0].value="";
			document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value= "";
		}
		if((cifType== 'Retail')&&( lookup == "CUSTOMER" )) {
			lookupFor = "ForRetAccount"
		  	vMode='ForAccount';
		}
		else if((cifType== 'Retail')&& ( lookup == "CONTACT" )) {
			lookupFor = 'ForRetContact';
		  	vMode='ForContact';
		}
		else if((cifType== 'Retail')&&( lookup == "PROSPECT" )) {
			lookupFor = 'ForRetSuspect';
		  	vMode='ForSuspect';
		}
		else if((cifType== 'Corporate')&&( lookup == "PROSPECT" )) {
			lookupFor = 'ForCorpProspect';
		 	vMode='ForCorpProspect';
		}
		else if((cifType== 'Corporate')&&( lookup == "CUSTOMER" )) {
			lookupFor = 'ForCorpCust';
		  	vMode='ForCorpCust';
		}
		var strCorpLastName1;
		var the_length=strCorpLastName.length;
		var last_char=strCorpLastName.charAt(the_length-1);
		if(last_char=='*'){
			strCorpLastName1=strCorpLastName;
		}
		else{
			strCorpLastName1 = strCorpLastName + '*';
		}
		wid=900;
		ht=460;
		topCord=(screen.height-ht)/2;
		leftCord=(screen.width-wid)/2;
		var url = "../servlet/com.infy.cis.ui.common.Lookup?Mode="+vMode+"&amp;lastName="+strCorpLastName1;
		var newwin = window.open(url, 'Lookup', 'height='+ht+', left='+leftCord+', top='+topCord+', width='+wid+',resizable=no,titlebar=no,toolbar=no,status=yes,scrollbars=yes');
    	}
	if(flag=='False'){
	  	showUserMessage(MSGJ50716,"");
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].value= "";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value="";
		document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value= "";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str5")[0].focus();
	}
	else if(flag=='True'){
		var cif_id   = getColorCookie('strcifID');
		var dob    = getColorCookie('dob');
		if(cif_id=="undefined")
			document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value="";
		else
			document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str2")[0].value= cif_id;

		if(dob=="undefined")
			document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value= "";
		else
			document.getElementsByName("3_CorporateBO.CorpMiscellaneousInfo.date1")[0].value= dob;
	}
}
/* Ticket#: 214635 FIX ENDS */


function loadTypeData1(listObj)
{
    var selectedType = listObj.options[listObj.selectedIndex].value;
    // added if/else condition for fixing the ticketID: 435634
    if (selectedType != null && selectedType != ""){
        var selIndex=listObj.options[listObj.selectedIndex];
        document.getElementsByName("EntityDocumentBO.DocTypeDescr")[0].value="";

	for(i=0;i < docCode_docDescarr.length;i++)
	{
		var elemStr = new String(doc_TypeDescarr[i]);
		var elemArr = elemStr.split("=");
		if(elemArr[0] == selectedType)
		{
			var elemStr1=new String(elemArr[1]);
			if(elemStr1=='null'){
				break;
			}
			document.getElementsByName("EntityDocumentBO.DocTypeDescr")[0].value=elemStr1;
			break;
		}
	}
	document.getElementsByName("EntityDocumentBO.DocDescr")[0].value="";
	loadSelectList(document.getElementsByName("EntityDocumentBO.DocCode")[0], docType_docCodearr, selectedType);
     }else{
     	clearList(document.getElementsByName("EntityDocumentBO.DocCode")[0]);
     }
}
//changes for call id 371085 and recon of call id 369315 starts
function s_loadTypeData1(listObj)
{
    var selectedType = listObj.options[listObj.selectedIndex].value;
    var selIndex=listObj.options[listObj.selectedIndex];
    for(i=0;i < docCode_docDescarr.length;i++)
    {
        var elemStr = new String(docCode_docDescarr[i]);
        var elemArr = elemStr.split("=");
       	var elemStr3 = new String(docCode_IDTypearr[i]);
        var elemArr2 = elemStr3.split("=");
        if(elemArr[0] == selectedType)
        {
			var elemStr1=new String(elemArr[1]);
			document.getElementsByName("EntityDocumentBO.DocDescr")[0].value=elemStr1;
			document.getElementsByName("hidIdentificationType")[0].value=elemArr2[1];
			break;
    	}
    }
}
//changes for call id 371085 and recon of call id 369315 ends

function loadSelectList(typeObj,typeDataArr,selectedType)
{

    var dataArr = new Array();
    dataArr = getDataArray(typeDataArr,selectedType);
    //changes for recon callID 151489 BEGIN
    if(CIF_Type!=null)
    {
		dataArr=filterDocCodeForCIF(dataArr)
	}
   //changes for recon callID 151489 END
//	alert(dataArr);
    clearList(typeObj);
    createTypeData(dataArr, typeObj);
}

function getDataArray(typeDataArr,selectedType)
{

    var dataArray = new Array();
    var boolSelected = 0;

    for(i=0;i < typeDataArr.length;i++){
		var elemStr = new String(typeDataArr[i]);
		var elemArr = elemStr.split("=");

		if(elemArr[0] == selectedType){
			var elemStr1=new String(elemArr[1]);
			var elemArr1 = elemStr1.split("|");
			boolSelected =1;
			break;
		}
    }
    if(boolSelected ==1)
    return elemArr1 ;
    else
    return docCodearr;
}
function clearList(typeObj)
{

    typeObj.options.length = 1;
    typeObj.selectedIndex = 0;
}


function filterDocCodeForCIF(arrDocCodes)
{
	arrFilterDocCodes=new Array();
	var iFiltered=-1;

	for(i=0;i<arrDocCodes.length;i++)
	{
		tempDocCode=arrDocCodes[i];
		for(j=0;j<docCode_CIFTypearr.length;j++)
		{
			docCode_CIFType=docCode_CIFTypearr[j].split("=");
			if(tempDocCode==docCode_CIFType[0])
			{
				if(CIF_Type==docCode_CIFType[1])
				{
					arrFilterDocCodes[++iFiltered]=arrDocCodes[i];
				}
				break;
			}
		}
	}
	return arrFilterDocCodes;
}


function populateDocCodeOnLoad()
{
    createTypeData(docCodearr, document.getElementsByName("EntityDocumentBO.DocCode")[0]);
}
// Function which is called on load of the form that populates the data in DocTypeCode select list.

function populateDocTypeOnLoad()
{

    createTypeData(arraydoc_Type, document.getElementsByName("EntityDocumentBO.DocTypeCode")[0]);
}

// Function that creates select list options for each type data.
function createTypeData(dataArr, typeObj)
{
    for(i=0;i < dataArr.length;i++)
    {
		var o = new Option(dataArr[i],dataArr[i]);
		typeObj.options[typeObj.options.length] = o;
    }
}

function checkKeys() {

		if (event.keyCode == 42 || event.keyCode ==37) {
			event.keyCode=0;
		}
	}

// Fix For Ticket 435932 Starts
function validateIssueDate1(){   


	/* calling the function isGregDate for on blur functionality*/
	isGregDate("3_CorporateBO.Address.Start_Date");


	var todaydate = new String();
	todaydate.value = getTodayDate1(locDate); 

	elem1 = document.getElementsByName("3_CorporateBO.Address.Start_Date")[0];
	/* calling the function isGregDate for on blur functionality*/
	var elem2 = document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0];

	if (elem1.value != '')
	{
	todaydate.value = convertDate(todaydate.value);
	}
	
	var mill1 = changetoMillisInUSFormat(todaydate.value);
	var mill2 = changetoMillis(elem1.value);   
	var mill3 = changetoMillis(elem2.value); 

	if ( mill2 > mill1){
	showUserMessage("MSGJ50157");
	document.getElementsByName("3_CorporateBO.Address.Start_Date")[0].value='';
	document.getElementsByName("3_CorporateBO.Address.Start_Date")[0].focus();
	return;
	}

	
	if ((mill2 != '')&&(mill3 > mill2)){

	showUserMessage("MSGJ52429");

	elem1.value = "";                                    

	}
				
}
// Fix For Ticket 435932 Ends

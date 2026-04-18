<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
 <!--tracker id 113227 starts-->
        <xsl:param name="altLocaleActv"/>
        <!--tracker id 113227 ends-->

    	<xsl:param name="altLocaleType"/>
    	<xsl:param name="baseLocaleType"/>

<xsl:variable name="file1">../Renderer/Customization/43/corpcif/resource/CorpRelationshipSelection_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<!-- Tracker ID :756914 - Chrome Porting Changes -->
<xsl:variable name="file1XML" select="substring-before(substring-after($file1,'resource/'),'.xml')"/>
<xsl:variable name="configFile_1" select="SRM"/>
<xsl:variable name="configLabels" select="$configFile_1/SRMBO/ResourceFile[@filename=$file1XML]/*"/>


<!--Tracker ID: 131246 Chnges by sonali_narula-->
<xsl:variable name="screenName" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='screenName']"></xsl:variable>
<!--Tracker ID: 131246 End of Changes-->

<xsl:variable name="RelPsychographicURL" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RelPsycho.URL_']"></xsl:variable>
<xsl:variable name="CorporateBO.CorpMiscellaneousInfo.str2" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CorpMiscellaneousInfo.str2']"></xsl:variable>
<xsl:variable name="CorporateBO.CorpMiscellaneousInfo.str4" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CorpMiscellaneousInfo.str4']"></xsl:variable>
<xsl:variable name="CorporateBO.CorpMiscellaneousInfo.str50" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CorpMiscellaneousInfo.str50']"></xsl:variable>
<xsl:variable name="scifType" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CorpMiscellaneousInfo.str9']"></xsl:variable>
<xsl:variable name="BoDate" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CorpMiscellaneousInfo.date2']"></xsl:variable>
<xsl:variable name="childCoreCustID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CorpMiscellaneousInfo.Core_Child_Cust_ID']"></xsl:variable>
<xsl:variable name="readMode" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='IsReadOnly']"/>
<xsl:variable name="allfields" select="/SRM/SRMData//Z"/>

<xsl:variable name="AllowBL" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AllowBL']"></xsl:variable>
<xsl:variable name="AllowNeg" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AllowNeg']"></xsl:variable>
<xsl:variable name="AllowSus" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='AllowSus']"></xsl:variable>
<!-- changes for recon tracker 403626-->
<xsl:variable name="sal_code" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='CorporateBO.CorpMiscellaneousInfo.str50']"></xsl:variable>
<xsl:variable name="iEntityID" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='iEntityID']"></xsl:variable>
<!-- caching changes start -->
<xsl:param name="viewname"/>
<xsl:variable name="PresFileName">../servlet/com.infy.cis.ui.corpcif.CorpCIF_DetPresCacheServlet?ViewName=<xsl:value-of select="$viewname"/></xsl:variable>
<xsl:variable name="PresFile" select="document(concat($PresFileName,''))"/>
<!-- Tracker ID :756914 - Chrome Porting Changes -->
<xsl:variable name="PresData" select="SRM/SRMPresentation"/>

<!-- caching changes end -->
<!-- Change for Other Relation Enhancement -->
<xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"></xsl:variable>
<!-- Change for Other Relation Enhancement -->
<xsl:param name="locale"/>

<xsl:template match="/">

<html>
<head>
<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
<script type="text/javascript" src="../corpcif/js/Message_corpcif_{$locale}.js" language="javascript"></script>
<script>

<!--Tracker ID: 131246 Chnges by sonali_narula-->
var screenName= '<xsl:value-of select="$screenName"/>';
<!--Tracker ID: 131246 End of Changes-->

var locale = '<xsl:value-of select="$locale"/>';
var BoDate = '<xsl:value-of select="$BoDate"/>';
var cifType = '<xsl:value-of select="$scifType"/>';		
var childCoreCustID = '<xsl:value-of select="$childCoreCustID"/>';
var readMode = '<xsl:value-of select="$readMode"/>';
<!-- changes for recon tracker 403626-->
var salCode = '<xsl:value-of select="$sal_code"/>';

var AllowBL 	     	=	'<xsl:value-of select="$AllowBL"/>';
var AllowNeg 	     	= 	'<xsl:value-of select="$AllowNeg"/>';
var AllowSus       	= 	'<xsl:value-of select="$AllowSus"/>';
<!-- Change for Other Relation Enhancement -->
var isAutoGenKey = '<xsl:value-of select="$isAutoGenKey"/>';
<!-- Change for Other Relation Enhancement -->
	/* <!-- Tracker ID:124440 & Ticket# 207288 changes STARTS-->
	    A flag variable is created on basis of which 
	    it will be decided which data to be displayed */

	/*Tracker ID 145437 changes start 
	 * Dual flag default value is set to 1
	 */
	var dualflag = 1;
	/*Tracker ID 145437 changes end */
	
	var locale = '<xsl:value-of select="$locale"/>'; 
	var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>'; 
	var altLocaleType = '<xsl:value-of select="$altLocaleType"/>'; 
	var baseLocaleType = '<xsl:value-of select="$baseLocaleType"/>'; 
	
	if (altLocaleActv=="true"){
		if (locale==altLocaleType){
			dualflag=0;
		}
	/* Tracker ID 145437 changes start 
	 * Commenting the following code
	 */
	 }
	/*	else if (locale==baseLocaleType){
			dualflag=1;
		}
	}
	else{
		dualflag=1;

	}*/		
	/*Tracker ID 145437 changes end */

	<!-- Tracker ID:124440 & Ticket# 207288 changes ENDS-->
</script>
<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
<!-- Tracker ID 113227 Vishal Changes Begin -->
<script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
<!-- Tracker ID 113227 Vishal Changes End -->

<script type="text/javascript" src="../common/js/SRMTableRowColor.js" language="javascript"></script>
<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
<script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>        
<script type="text/javascript" src="../common/html/validateL2.js" language="javascript"></script>        
<!--<script type="text/javascript" src="../corpcif/js/CorpContactSelection.js" language="javascript"></script>       
-->
<script type="text/javascript" src="../Customization/43/corpcif/js/BioVal.js" language="javascript"></script>
<script type="text/javascript" src="../Customization/43/corpcif/js/Relationship.js" language="javascript"></script>
<!--<script type="text/javascript" src="../corpcif/js/Contact.js" language="javascript"></script>-->
<script type="text/javascript" language="javascript">
</script>
</head>
	
<script type="text/javascript" language="javascript">	
	<!--CRM102.06 TicketID: 370690 Begin of Change  -->
	<!-- var cifType = '';	-->
	<!--CRM102.06 TicketID: 370690 End of Change  -->
  /*sanity defect fix starts*/ 
var altLocaleActv = '<xsl:value-of select="$altLocaleActv"/>';		 
/*sanity defect fix ends*/ 
	function enableClose(){
		try{
			document.getElementsByName("Close")[0].disabled = false;
		}catch(e){
		}
//changes for recon tracker 403626
//358519 call-id changes start
			var b=document.getElementsByName("Cat_CorporateBO.CorpMiscellaneousInfo.str50")[0].value;
			if(b != null || b != ""){
				document.getElementsByName("Cat_CorporateBO.CorpMiscellaneousInfo.str50")[0].value = "";
				document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].value = salCode;
				categoryLookup('PERSONSALUTATION', 'CorporateBO.CorpMiscellaneousInfo.str50',true);
			}	else{
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].value = salCode;
		categoryLookup('PERSONSALUTATION', 'CorporateBO.CorpMiscellaneousInfo.str50',true);
	}
//358519 call-id changes end
	}
	
	function setMandatoryfld(){
		if(document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.entityType")[0].value == ""){
		document.getElementsByName("btnone_CorporateBO.CorpMiscellaneousInfo.str1")[0].style.display = "none";
		document.getElementsByName("btntwo_CorporateBO.CorpMiscellaneousInfo.str1")[0].style.display = "none";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str1")[0].IsMandatory = "false";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly = true; // Change for TOL 677035
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].disabled = false;
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str4")[0].readOnly = false;
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str14")[0].disabled = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.cntrycode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.areacode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.localcode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.cntrycode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.areacode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.localcode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.cntrycode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.areacode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.localcode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.cntrycode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.areacode')[0].readOnly = false;
		document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.localcode')[0].readOnly = false;
		clearAllFlds();
		}else{
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.cntrycode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.areacode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.localcode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.cntrycode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.areacode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.localcode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.cntrycode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.areacode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.localcode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.cntrycode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.areacode')[0].readOnly = true;
			document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.localcode')[0].readOnly = true;
		document.getElementsByName("btnone_CorporateBO.CorpMiscellaneousInfo.str1")[0].style.display = "";
		document.getElementsByName("btntwo_CorporateBO.CorpMiscellaneousInfo.str1")[0].style.display = "";
		document.getElementsByName("btnone_CorporateBO.CorpMiscellaneousInfo.str1")[0].style.visibility = "visible";

		document.getElementsByName("btntwo_CorporateBO.CorpMiscellaneousInfo.str1")[0].style.visibility = "visible"; 
        document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str1")[0].style.visibility="visible"; 
        document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str1")[0].IsMandatory = "true"; 
        document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly = true; 
        document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].disabled = true; 
       	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str4")[0].readOnly = true;
        document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str14")[0].disabled = true; 
		 			 		
		clearAllFlds();
		}
	}

	function PhoneValidate(wpCountryCode, wpAreaCode, wpLocalCode ){
	    try{
	        		
			if(wpCountryCode.value != "") {
		      if (validate_phoneField(wpCountryCode,false,true)==false){
				return false;}
			}
			
			if(wpAreaCode.value != "") {
				 if (validate_phoneField(wpAreaCode,false,true)==false){
				return false;}
			}
	
			if(wpLocalCode.value != "") {
		     if (validate_phoneField(wpLocalCode,false,true)==false){
			  return false;}
			}
	
	   }catch(e){}
	   return true;
}
<!-- Change for Other Relation Enhancement -->
function hideFields(){

  	var cifType = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str9")[0].value; 
  	document.frm2.hCorporateBOCorpMiscellaneousInfostr9.value = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str9")[0].value;
    	ciftype = document.frm2.hCorporateBOCorpMiscellaneousInfostr9.value;
  	var hRelPsychoURL = document.frm2.hid_RelPsychographicURL.value;
  	var hCorporateBOCorpMiscellaneousInfoEntityID = document.frm2.iEntityID.value;
  	if (cifType == 'CORPORATE' || cifType == 'Corporate') {
  	
  		var url = '../servlet/com.infy.cis.ui.corpcif.CorpRelationshipSelection?hCorporateBOCorpMiscellaneousInfostr9='+ciftype+'&amp;AllowBL='+AllowBL+'&amp;AllowNeg='+AllowNeg+'&amp;AllowSus='+AllowSus+'&amp;hRelPsychoURL='+hRelPsychoURL+'&amp;hCorporateBOCorpMiscellaneousInfoEntityID='+hCorporateBOCorpMiscellaneousInfoEntityID;
  	  	document.location.href = url 
           
  	}else if (cifType == 'RETAIL' || cifType == 'Retail')
  	{
  	
  		var url = '../servlet/com.infy.cis.ui.corpcif.CorpRelationshipSelection?hCorporateBOCorpMiscellaneousInfostr9='+ciftype+'&amp;AllowBL='+AllowBL+'&amp;AllowNeg='+AllowNeg+'&amp;AllowSus='+AllowSus+'&amp;hRelPsychoURL='+hRelPsychoURL+'&amp;hCorporateBOCorpMiscellaneousInfoEntityID='+hCorporateBOCorpMiscellaneousInfoEntityID;
  		document.location.href = url 
  	}else{
  		var url = '../servlet/com.infy.cis.ui.corpcif.CorpRelationshipSelection';
  		document.location.href = url 
  	}
  	
  	
}
function corponChange(){
//changes for recon tracker 403626
//358519 call-id changes start
		// Changes for TOL 677035 starts
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly = true;
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].disabled = true;
		// Changes for TOL 677035 ends
	//Changes for Ticket 724761 begin
	var b="";
	if(document.getElementsByName("Cat_CorporateBO.CorpMiscellaneousInfo.str50")[0]!=undefined){
		b= document.getElementsByName("Cat_CorporateBO.CorpMiscellaneousInfo.str50")[0].value;
		}
	if(b != null &amp;&amp; b != ""){
		document.getElementsByName("Cat_CorporateBO.CorpMiscellaneousInfo.str50")[0].value = "";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].value = salCode;
		categoryLookup('PERSONSALUTATION', 'CorporateBO.CorpMiscellaneousInfo.str50',true);

	}else{
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].value = salCode;
		//categoryLookup('PERSONSALUTATION', 'CorporateBO.CorpMiscellaneousInfo.str50',true);
	//Changes for Ticket 724761 ends
	}
//358519 call-id changes end

if(isAutoGenKey != 'true'){
			// Changes for TOL 677035 starts
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].IsMandatory = "false";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly = true;
			// Changes for TOL 677035 ends
		document.getElementsByName("mandStarCorporateBO.CorpMiscellaneousInfo.str49")[0].style.visibility="visible";
	}else{
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].IsMandatory = "false";
		document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly = true;
		document.getElementsByName("mandStarCorporateBO.CorpMiscellaneousInfo.str49")[0].style.visibility="hidden";
	
	}

if(cifType == null || cifType == ''){
	Obj1=document.frm2.elements('CorporateBO.CorpMiscellaneousInfo.entityType');
	for(j=Obj1.length-1;j&gt;=1;j--){
		Obj1.remove(j);
	}
	
}
else if (cifType == 'CORPORATE' || cifType == 'Corporate') {

	Obj=document.frm2.elements('CorporateBO.CorpMiscellaneousInfo.entityType');
	for(var i=Obj.length-1;i&gt;=0;i--){
			if((Obj.options[i].value)=="CONTACT") {
				Obj.remove(i);
			}
		}
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str11")[0].disabled = true; 
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str12")[0].disabled = true; 
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str4")[0].disabled = true; 
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].disabled = true; 
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str43")[0].disabled = true; 
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str14")[0].disabled = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.cntrycode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.areacode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.localcode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.cntrycode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.areacode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.localcode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.cntrycode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.areacode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.localcode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.cntrycode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.areacode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.localcode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.cntrycode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.areacode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.localcode')[0].readOnly = true; 
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str1_alt1')[0].readOnly = true; 
	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly=true;
	

}else if(!(cifType == null || cifType == '')){
document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly=true;

}
}
<!-- Change for Other Relation Enhancement -->
	function saveRelationship(){  
		var RelationshipDetails = new Array();
		
		<!-- Tracker ID 113227 Vishal Changes Begin -->
/*sanity defect fix starts*/ 		 
if(altLocaleActv=="true"){	   
<!-- Change for Other Relation Enhancement -->
		var lookupLastName_alt1 = '';
<!-- Change for Other Relation Enhancement -->
/*sanity defect fix ends*/ 
		<!-- Change for Other Relation Enhancement -->
		if(document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.entityType')[0].value != ''){
			lookupLastName_alt1 = getCookie('LookupLastName_alt1');
		}else{
			lookupLastName_alt1 = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str1_alt1')[0].value)
		}
		/* changes for tracker id:337383 START */
		//}
		if(lookupLastName_alt1 == 'null' || lookupLastName_alt1 == null){
		lookupLastName_alt1 = '';
		}
<!-- CRM102BETA: TicketID:370930 TrackerID:227592 Begin of Change -->
		if(lookupLastName_alt1 == ''){
			lookupLastName_alt1 = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str1_alt1')[0].value)
		}
		}
		/* changes for tracker id:337383 END */
<!-- CRM102BETA: TicketID:370930 TrackerID:227592 End of Change -->
		<!-- Change for Other Relation Enhancement -->

		<!-- Tracker ID 113227 Vishal Changes End -->
		
		try{
		customSave();
		}catch(e){ }
		
		try{
		var retStat = ValidateFormContents(document.frm2,false);;
		if(retStat == "false") {
		return "interactive";
		}
		}catch(e){}

		    RelationshipDetails[0] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.entityType')[0].value);
		    RelationshipDetails[1] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str49')[0].value);
		    RelationshipDetails[2] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str1')[0].value);
		    RelationshipDetails[3] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str11')[0].value);
			/*Changes for call id 413614 starts*/
			RelationshipDetails[33] = trim(''+document.getElementsByName('Cat_CorporateBO.CorpMiscellaneousInfo.str11')[0].value);
			/*Changes for call id 413614 ends*/
		    RelationshipDetails[4] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str12')[0].value);

		    RelationshipDetails[5] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.cntrycode')[0].value;
		    RelationshipDetails[6] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.areacode')[0].value;
		    RelationshipDetails[7] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.localcode')[0].value;

		    RelationshipDetails[8] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.cntrycode')[0].value;
		    RelationshipDetails[9] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.areacode')[0].value;
		    RelationshipDetails[10] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.localcode')[0].value;

		    RelationshipDetails[11] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.cntrycode')[0].value;
		    RelationshipDetails[12] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.areacode')[0].value;
		    RelationshipDetails[13] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.localcode')[0].value;

		    RelationshipDetails[14] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.cntrycode')[0].value;
		    RelationshipDetails[15] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.areacode')[0].value;
		    RelationshipDetails[16] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.localcode')[0].value;

		    RelationshipDetails[17] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.cntrycode')[0].value;
		    RelationshipDetails[18] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.areacode')[0].value;
		    RelationshipDetails[19] = document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.localcode')[0].value;

		    RelationshipDetails[20] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str43')[0].value);

		    RelationshipDetails[21] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str44')[0].value);
		    RelationshipDetails[22] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str45')[0].value);
		    RelationshipDetails[23] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str46')[0].value);
		    RelationshipDetails[24] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str47')[0].value);
		    RelationshipDetails[25] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str48')[0].value);
			
		    RelationshipDetails[26] = document.frm2.hid_RelPsychographicURL.value;
		    RelationshipDetails[27] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str2')[0].value);
		    RelationshipDetails[28] = trim(''+document.getElementsByName('iEntityID')[0].value);
		    
			/** CRM10.0CR Start TrackerID:102868 */ 
		    RelationshipDetails[29] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str4')[0].value); 
			RelationshipDetails[30] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str50')[0].value); 
			RelationshipDetails[31] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str14')[0].value); 
			<!-- Tracker ID 113227 Vishal Changes Begin -->
		    /*TRACKER ID 123664 Changes Begin*/
<!-- Change for Other Relation Enhancement -->
		    RelationshipDetails[34] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str9')[0].value); 
<!-- Change for Other Relation Enhancement -->
		    //(;) was missing
/*sanity defect fix starts*/ 		    
if(altLocaleActv=="true"){		  
/*sanity defect fix ends*/ 
	/*Changes for Tracker 275995 start */
		    //RelationshipDetails[32] = lookupLastName_alt1;
		    RelationshipDetails[32] = trim(''+document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str1_alt1')[0].value) ;
	/*Changes for Tracker 275995 end */
		   }
		    /*TRACKER ID 123664 Changes End*/
			<!-- Tracker ID 113227 Vishal Changes Begin -->
		   /** CRM10.0CR End*/ 

		    
			 <!-- check to prevent attaching same entity as relation -->
		
				if(RelationshipDetails[20] !=''){
		                var chkStat=validate_emailField(RelationshipDetails[20]);	
					if(chkStat=='false'){
						return;
					}
				}
		
		
		   var cifid = getCookie('cifId');
		   
		   
		   if(cifid == RelationshipDetails[1])
			
			{
			  <!-- Changed mesasge code -->		
			  showUserMessage("MSG50466");
			  return;
			  
			 } 
<!-- Change for Other Relation Enhancement -->
		if(document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str9")[0].value == "" &amp;&amp; document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.entityType')[0].value != ""){	
				showMessage(MSGJ50143);	
				return;
		}
<!-- Change for Other Relation Enhancement -->
		<!-- Tracker ID:143071 changes BEGINS-->
		/* Commenting done was incorrect */
		/*   New variable "dualflag" is passed in the function below */  
		<!-- Tracker ID:143071 changes ENDS-->   				
		window.opener.addRelationshipInfo(RelationshipDetails,dualflag);  
		self.close();
		window.opener.focus();
	} 
		
	function validate_emailField(mail){
	var email=mail;
	if(email.value!= ""){
	    var retVal = validate_email(email, true, false, true)
	    if(!retVal) {
	           showMessage(MSG081);
		   return 'false';
	       }
	 }
	 return 'true'
	}
		

	function cancel(){
	
	//Ticket 327295 changes begin
		if ( !this.parent.parent.showConfirmMessage(MSG022)) {
			return;
				}
	//Ticket 327295 changes end
	
		try {
		self.close();
		window.opener.focus();
		}catch(e) {}
	}


	function validationForCookie(CookieVal){		
		var BLANKSPACE = '';
		if(CookieVal == null){
			return BLANKSPACE;
		} else {
			return CookieVal;
		}
	}

	function focusFirstField()
	{
		try
		{
			document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.entityType")[0].focus();
		}
		catch (e)
		{
		}
	}
		
		
	function fnBluropenEntityLookup(type){
	  		 var chk1 = chkBlurFrom1();
	   		if(chk1) {
	  	             	 fnTabOut();
	  	        	return;
		        	}
		       else{
		     	Lookup();
		       }
  }
		
		
  
  
  //Ticket 327310 begin
  function disableAutopopFields(){
  
  var entType = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.entityType")[0].value;
  
  if(!(entType == null || entType == "" )){
  
   	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].readOnly = true;;
      	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str50")[0].disabled = true;;
      	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str4")[0].readOnly = true;;
      	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.cntrycode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.areacode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str16.localcode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.cntrycode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.areacode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str13.localcode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.cntrycode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.areacode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str19.localcode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.cntrycode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.areacode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str22.localcode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.cntrycode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.areacode')[0].readOnly = true;
	document.getElementsByName('CorporateBO.CorpMiscellaneousInfo.str25.localcode')[0].readOnly = true;
      	document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str14")[0].disabled = true;
        document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str43")[0].readOnly = true;
        }
  
  
  
  } 
	//Ticket 327310 end	
	<!-- Tracker ID :756914 - Chrome Porting Changes -->
	function functionBodyOnload(){
	
		if(readMode=='Y'){
			showInReadOnlyMode('<xsl:value-of select="$readMode"/>');
			enableClose();
		}else{
			corponChange();
			disableAutopopFields();
			focusFirstField();
			setOnLoadMandatory();
			load();
		}
	}
	</script>
	<body class="popup">	
	<xsl:choose>
		<xsl:when test="normalize-space($readMode)='Y'">
			<xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');enableClose();</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
<!-- Change for Other Relation Enhancement -->
			<xsl:attribute name="onload">corponChange();disableAutopopFields();focusFirstField();setOnLoadMandatory();load();</xsl:attribute>
<!-- Change for Other Relation Enhancement -->
		</xsl:otherwise>
       </xsl:choose>
		 <table class="background" width="100%" cellpadding="0" cellspacing="0" border="0"  align="center"> 
		 <xsl:apply-templates select="SRM"/>   		 
		 </table>
		 
		 
		 
		<table class="background" cellpadding="2" cellspacing="2" width ="100%" border="0"  align="left">
			<xsl:choose>
				<xsl:when test="normalize-space($readMode)='Y'">
					<xsl:call-template name="user_button">
						<xsl:with-param name="button_name">Close</xsl:with-param>
						<xsl:with-param name="button_fnc">cancel()</xsl:with-param>
					</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				 
				<xsl:call-template name="user_button">
				    <xsl:with-param name="button_name">Save</xsl:with-param>
				    <xsl:with-param name="button_fnc">saveRelationship()</xsl:with-param>
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button">
				<!--Tracker:108387: Changes for button name -->
				    <xsl:with-param name="button_name">Close</xsl:with-param>
				    <xsl:with-param name="button_fnc">cancel()</xsl:with-param>
				<!--Tracker:108387: End of Changes-->
				</xsl:call-template>&#160;
				<xsl:call-template name="user_button">
								    <xsl:with-param name="button_name">Refresh</xsl:with-param>
								    <xsl:with-param name="button_fnc">Refresh()</xsl:with-param>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</table>
        </body>
        </html>
 </xsl:template>    

<!-- Change for Other Relation Enhancement -->
		<xsl:template name="CorporateBO.CorpMiscellaneousInfo.str9">
			<xsl:call-template name="mdrpdown">
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str9']" />
				<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str9</xsl:with-param>
				<xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.str9</xsl:with-param>	
				<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
				<xsl:with-param name="onchangefn">hideFields();</xsl:with-param>
				<xsl:with-param name="presdata" select="$PresData" />
				<xsl:with-param name="search_type">value</xsl:with-param>
				<xsl:with-param name="starshow">true</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
<!-- Change for Other Relation Enhancement -->
	
	
		
	
	
	      <xsl:template name="CorporateBO.CorpMiscellaneousInfo.entityType">
		    <xsl:call-template name="mdrpdown">
		        <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.entityType']"/>
			<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.entityType</xsl:with-param>
			<xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.entityType</xsl:with-param>
			<xsl:with-param name="search_type">value</xsl:with-param>
			<!-- caching changes start -->
		    	<xsl:with-param name="presdata" select="$PresData"/>                
			<!-- caching changes end -->
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>	
			<xsl:with-param name="onchangefn">setMandatoryfld();</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		      </xsl:call-template>
	      </xsl:template>
	
	
             <xsl:template name="CorporateBO.CorpMiscellaneousInfo.entityID">
	     	     <xsl:call-template name="lookup">
	     		 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.entityID']"/>
	     		 <xsl:with-param name="elename">CorporateBO.CorpMiscellaneousInfo.entityID</xsl:with-param>
	     		 <xsl:with-param name="eleval">CorporateBO.CorpMiscellaneousInfo.entityID</xsl:with-param>
	     		 <xsl:with-param name="buttonone_name"><xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param>
	     		 <xsl:with-param name="buttontwo_name"><xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param>
	     		 <xsl:with-param name="buttonone_fnc">Lookup()</xsl:with-param>
	     		 <xsl:with-param name="buttontwo_fnc">clearBankEntity(),clearIntxnFor()</xsl:with-param>
	     	     	 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
	     	     	 <xsl:with-param name="starshow">true</xsl:with-param>
	     	     </xsl:call-template>
	     </xsl:template>
        
	      <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str1">
			<xsl:call-template name="lookup"> 
				<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str1']"/> 
				<xsl:with-param name="elename">CorporateBO.CorpMiscellaneousInfo.str1</xsl:with-param> 
				<xsl:with-param name="eleval">CorporateBO.CorpMiscellaneousInfo.str1</xsl:with-param> 
				<xsl:with-param name="buttonone_name"><xsl:value-of select="$configLabels[@name='LOOKUP']/@configLabel"/></xsl:with-param> 
				<xsl:with-param name="buttontwo_name"><xsl:value-of select="$configLabels[@name='CLEAR']/@configLabel"/></xsl:with-param> 
				<!--xsl:with-param name="buttonone_fnc">Lookup()</xsl:with-param-->
				<!-- sudhakar #CR101 start -->
				<xsl:with-param name="buttonone_fnc">fnBluropenEntityLookup("Product")</xsl:with-param>
				<!-- sudhakar #CR101 start -->
				<xsl:with-param name="starshow">true</xsl:with-param> 
				<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param> 
				<xsl:with-param name="buttontwo_fnc">clearBankEntity(),clearIntxnFor()</xsl:with-param> 
			 </xsl:call-template> 
            </xsl:template> 
		    
		  <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str4">
		  <xsl:call-template name="label">
		  <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str4']"/>
		  <xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str4</xsl:with-param>
		  <xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str4</xsl:with-param>
		  <xsl:with-param name="max_length">20</xsl:with-param>
		  <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		  </xsl:call-template>
		  </xsl:template>
		  
		  
           <!-- CRM10.0CR End --> 
		   <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str50"> 
		   <xsl:call-template name="mdrpdown"> 
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str50']"/> 
			<xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.str50</xsl:with-param> 
			<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str50</xsl:with-param> 
			<xsl:with-param name="search_type">value</xsl:with-param> 
			<xsl:with-param name="presdata" select="$PresData"/> 
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param> 

		   </xsl:call-template> 
		   </xsl:template> 
			 <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str14"> 
				   <xsl:call-template name="mdrpdown"> 
						<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str14']"/> 
						<xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.str14</xsl:with-param> 
						<xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str14</xsl:with-param> 
						<xsl:with-param name="search_type">value</xsl:with-param> 
						<xsl:with-param name="presdata" select="$PresData"/> 
						<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param> 
				   </xsl:call-template> 
	 			</xsl:template> 
		  		 
	     
 <!-- CODE ADDED BY KAMAL for tracker id 349409 -->
     <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str11">
		   <xsl:call-template name="lookup">
			  <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str11']"/>
				  <xsl:with-param name="elename">CorporateBO.CorpMiscellaneousInfo.str11</xsl:with-param>
				  <xsl:with-param name="eleval">CorporateBO.CorpMiscellaneousInfo.str11</xsl:with-param>
				   <!-- Field Rationalization changes start -->
						<!--   <xsl:with-param name="code_req">true</xsl:with-param> -->
								<!-- Field Rationalization changes end -->
						<!--  TRACKER ID:150150  CHANGES BEGIN   -->
								<xsl:with-param name="buttonone_name" select="$configLabels[@name='BTN_LOOKUP']/@configLabel"/>
								<xsl:with-param name="buttontwo_name" select="$configLabels[@name='BTN_CLEAR']/@configLabel"/>
								<xsl:with-param name="buttonone_fnc">categoryLookup('DESIGNATION', 'CorporateBO.CorpMiscellaneousInfo.str11')</xsl:with-param>
								<xsl:with-param name="buttontwo_fnc">clearCategoryValue('CorporateBO.CorpMiscellaneousInfo.str11')</xsl:with-param>
								<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
								<xsl:with-param name="checkASCII">false</xsl:with-param>
						<!--  TRACKER ID:150150  CHANGES END  -->
								<!-- CIF Changes for Caching Views : Start -->
				<xsl:with-param name="presdata" select="$PresData"/>
				<!-- CIF Changes for Caching Views : End -->
				       </xsl:call-template>
    </xsl:template>
		        
  <!--CODE ADDED BY KAMAL for tracker id 349409 -->  
	      
	      
	      
					
	      <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str12">
		    <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str12']"/>
			 <xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.str12</xsl:with-param>
			 <xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str12</xsl:with-param>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="max_length">12</xsl:with-param>
			 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			 <xsl:with-param name="presdata" select="$PresData"/>                
		     </xsl:call-template>
	      </xsl:template>
	      
	      <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str13">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str13']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str13</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str13</xsl:with-param>
			<xsl:with-param name="max_length">20</xsl:with-param>
			<xsl:with-param name="is_phone">true</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>

	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str16">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str16']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str16</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str16</xsl:with-param>
			<xsl:with-param name="max_length">20</xsl:with-param>
			<xsl:with-param name="is_phone">true</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>

	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str19">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str19']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str19</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str19</xsl:with-param>
			<xsl:with-param name="max_length">20</xsl:with-param>
			<xsl:with-param name="is_phone">true</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		    </xsl:call-template>
		</xsl:template>

	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str22">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str22']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str22</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str22</xsl:with-param>
			<xsl:with-param name="max_length">20</xsl:with-param>
			<xsl:with-param name="is_phone">true</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template> 
	                     
	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str25">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str25']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str25</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str25</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="is_phone">true</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>
	       
               <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str43">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str43']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str43</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str43</xsl:with-param>
			<xsl:with-param name="max_length">25</xsl:with-param>
		
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>
<!-- Equity DRC, Customization changes for CR23 starts 
	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str44">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str44']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str44</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str44</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>-->
		   
		   <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str44">
		    <xsl:call-template name="mdrpdown">
			 <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str44']"/>
			 <xsl:with-param name="selectname">CorporateBO.CorpMiscellaneousInfo.str44</xsl:with-param>
			 <xsl:with-param name="selectdisp">CorporateBO.CorpMiscellaneousInfo.str44</xsl:with-param>
			 <xsl:with-param name="search_type">value</xsl:with-param>
			 <xsl:with-param name="max_length">50</xsl:with-param>
			 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			 <xsl:with-param name="presdata" select="$PresData"/>                
		     </xsl:call-template>
	      </xsl:template>
		  
		   <xsl:template name="Signature">
		<xsl:call-template name="hyperlink">
		<xsl:with-param name="res_name">View AML Check Results</xsl:with-param>
		<xsl:with-param name="fncname">showSVS();</xsl:with-param>
		</xsl:call-template>
	  </xsl:template>
<!-- Equity DRC, Customization changes for CR23 ends -->
	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str45">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str45']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str45</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str45</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>

	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str46">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str46']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str46</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str46</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>

	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str47">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str47']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str47</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str47</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>

	       <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str48">
		    <xsl:call-template name="label">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str48']"/>
			<xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str48</xsl:with-param>
			<xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str48</xsl:with-param>
			<xsl:with-param name="max_length">10</xsl:with-param>
			<xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>
			<xsl:with-param name="starshow">true</xsl:with-param>
		    </xsl:call-template>
	       </xsl:template>
            
            
            <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str49"> 
			   <xsl:call-template name="label"> 
			   <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str49']"/> 
			   <xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str49</xsl:with-param> 
			   <xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str49</xsl:with-param> 			
			   <xsl:with-param name="max_length">10</xsl:with-param> 
			   <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param> 
			   <xsl:with-param name="starshow">true</xsl:with-param> 
			   </xsl:call-template> 
			 </xsl:template> 

       <!-- Tracker ID 113227 Vishal Changes Begin -->		 
			 
	    <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str1_alt1">
	              <xsl:call-template name="label_alternate">
	                  <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str1_alt1']"/>
	                  <xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str1_alt1</xsl:with-param>
	                  <xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str1_alt1</xsl:with-param>
	                  <xsl:with-param name="max_length">10</xsl:with-param>
	                  <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>  
	 		  <xsl:with-param name="starshow">true</xsl:with-param>
	              </xsl:call-template>
         </xsl:template>
       <!--Ticket ID 203491 Changes Begin-->
         <!-- <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str4_alt1">
	 	              <xsl:call-template name="label_alternate">
	 	                  <xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str4_alt1']"/>
	 	                  <xsl:with-param name="ele_name">CorporateBO.CorpMiscellaneousInfo.str4_alt1</xsl:with-param>
	 	                  <xsl:with-param name="ele_val">CorporateBO.CorpMiscellaneousInfo.str4_alt1</xsl:with-param>
	 	                  <xsl:with-param name="max_length">10</xsl:with-param>
	 	                  <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param>  
	 	 		  <xsl:with-param name="starshow">true</xsl:with-param>
	 	              </xsl:call-template>
         </xsl:template>-->	 
<!--Ticket ID 203491 Changes End-->
       <!-- Tracker ID 113227 Vishal Changes End -->
                  
            <xsl:template name="CorporateBO.CorpMiscellaneousInfo.str2">
			<xsl:call-template name="mtextarea">
			<xsl:with-param name="res_name" select="$configLabels[@name='CorporateBO.CorpMiscellaneousInfo.str2']"/>
			<xsl:with-param name="mname">CorporateBO.CorpMiscellaneousInfo.str2</xsl:with-param>
			<xsl:with-param name="mvalue">CorporateBO.CorpMiscellaneousInfo.str2</xsl:with-param>
			<xsl:with-param name="mwrap">on</xsl:with-param>
			<xsl:with-param name="mrows">2</xsl:with-param>
			<xsl:with-param name="mcols">77</xsl:with-param>
			<xsl:with-param name="mcolspan">5</xsl:with-param>
			<xsl:with-param name="checkASCII">false</xsl:with-param>
			 <xsl:with-param name="UsrDataSpace">CustomData</xsl:with-param> 
			</xsl:call-template>
		</xsl:template>

	       <xsl:template match="*" mode="mode1">   
	          <form name="frm2" method="post">
	          <IFRAME name="hdifrm_empform" width="0" height="0" src="../common/html/SSOblank.html"/>	          
			   <input type="hidden" name="hTodayDate" value=""/>  
			   <input type="hidden" name="hcifType" value=""/>  
			   <input type="hidden" name="CorporateBO.CorpMiscellaneousInfo.date2" value=""/>  
			   <input type="hidden" name="CorporateBO.CorpMiscellaneousInfo.Core_Child_Cust_ID" value=""/>  
	   		   <input type="hidden" name="hid_RelPsychographicURL" value="{$RelPsychographicURL}"/>
			   <input type="hidden" name="iEntityID" value="{$iEntityID}"/> 
<!-- Change for Other Relation Enhancement -->
			   <input type="hidden" name="hCorporateBOCorpMiscellaneousInfostr9" value=""/>
			   
			   <xsl:call-template name="Begin"/>                           
			  	 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str9"/>
			  	 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.entityType"/>
			   <xsl:call-template name="End"/>  
			   
			  <xsl:call-template name="Begin"/>                           
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str1"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str11"/>
			   <xsl:call-template name="End"/>   

			   <xsl:call-template name="Begin"/>                           
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str12"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str49"/>			   	 
			   <xsl:call-template name="End"/> 

			   <xsl:call-template name="Begin"/>                           
				<xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str4"/> 
				   <!-- CRM10.0CR Start TrackerID:102868 --> 
				   <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str50"/> 
				   <!-- CRM10.0CR End --> 			   	 
			   <xsl:call-template name="End"/> 

			   <xsl:call-template name="Begin"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str13"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str16"/>
			  <xsl:call-template name="End"/>
			  
               <xsl:call-template name="Begin"/> 
					<xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str19"/> 
					<xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str22"/> 
				<xsl:call-template name="End"/> 
			  
			  
			   <xsl:call-template name="Begin"/>                           
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str25"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str43"/>
			   <xsl:call-template name="End"/> 

			    <xsl:call-template name="Begin"/>                           				 
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str14"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str44"/>
			   <xsl:call-template name="End"/> 

			   <xsl:call-template name="Begin"/>                           
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str45"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str46"/>
			   <xsl:call-template name="End"/> 

			   <xsl:call-template name="Begin"/>                           
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str47"/>
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str48"/>
			   <xsl:call-template name="End"/> 

			   <xsl:call-template name="Begin"/>                           
				 <xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str2"/>
				<!-- <xsl:call-template name="Signature"/>-->
			   <xsl:call-template name="End"/> 
<!-- Change for Other Relation Enhancement -->
			  
			  <!-- Tracker ID 113227 Vishal Changes Begin -->
			  <xsl:choose>
			  			<xsl:when test="normalize-space($altLocaleActv)='true'">
		
				<xsl:variable name="DUAL"><xsl:value-of select="$configLabels[@name='Details in Alternate Language']/@configLabel"/></xsl:variable>
				<tr style="cursor:hand" STYLE="border-bottom: 10px black;" ID="rowdual" name="rowdual">
				<xsl:attribute name="oncontextmenu">setClickedArea();doContextMenu();</xsl:attribute>
				<td onclick="Toggle('dual','all');" colspan = "5" NOWRAP="true" class="LabelFont">
				     <A HREF="javascript:Toggle('DUAL','all');"><IMG onclick="Toggle('dual','all');" SRC="../reports/images/minus.gif" ID="dualgif"
				      BORDER="0" ALIGN="absmiddle" HEIGHT="12" WIDTH="12" HSPACE="3" VSPACE="4"/></A>
				     <label FOR="CPD" class="LabelFont"><xsl:value-of select="$DUAL"/>
				     </label>
				</td>
				</tr>

			<DIV ID = 'native' STYLE= 'visibility:visible;'>
			<TR ID='rowdual' name='rowdual'>
				
				<xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str1_alt1"></xsl:call-template>
               <!--Ticket ID 203491 Changes Begin-->			
                 <!--<xsl:call-template name="CorporateBO.CorpMiscellaneousInfo.str4_alt1"></xsl:call-template>-->
			   <!--Ticket ID 203491 Changes End-->	
			</TR>						
		        </DIV>
	<tr></tr>
	</xsl:when>
				
  	</xsl:choose>
			  
<!-- Tracker ID 113227 Vishal Changes Begin -->			  
			   			   			  
	           </form>                 
        </xsl:template>

    <xsl:template match="SRM">
        <xsl:for-each select=".">       
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" class="tableborder" vspace="0" hspace="0">
		    		    		   	  	 <tr>
		    		    		   	  	  <td>
		    		    		   	  	    <table border="0" bgcolor='ffffff' cellspacing="0" cellpadding="0" class="innertable" width="100%" vspace="0" hspace="0">
		    		    		   	  	     <tr>
		    		    		   	  		 <td>
		    		    		   	  		   <table bgcolor='ffffff' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
		    		    		   	  		     <tr>
		    		    		   	  		         <xsl:call-template name="apply">
		    		    		   	  		           <xsl:with-param name="apply_head">
		    		    		   	  		               <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
		    		    		   	  		</xsl:with-param>
		    		    		   	  	</xsl:call-template>
		    		    		   	  	</tr>
		    		    		   	       </table>
		    		    		   	  	   <table bgcolor='ffffff' width="100%" border="0" cellspacing="0" cellpadding="2">
		    		    		   	  	      <xsl:apply-templates select="." mode="mode1"/>
		    		    		   	  		</table>
		    		    		   	  	      </td>
		    		    		   	  	   </tr>
		    		    		   	  	  </table>
		    		    		   	  	 </td>
		    		    		   	  	</tr>
      </table>
         </xsl:for-each>
        </xsl:template>
        
</xsl:stylesheet>






















<?xml version="1.0"?>
 <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <!--impoting variables wich hold the jvm properties-->
     <xsl:import href="../Renderer/common/display/getJVMProperties.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>
     <xsl:import href="../Renderer/common/display/SRMListTemplate.xsl"/>

<!-- importing xml files InciDDReq.xml -->
     <xsl:variable name="configFile" select="document(concat('../Renderer/customization/resource/Inci_EdGa_Addr_Chg.xml', ''))"/>	
     <xsl:variable name="configLabels" select="$configFile/SRMBO/*"/>
     

     <xsl:variable name="allfields" select="//SRMData//Z"/>
     <xsl:variable name="requestURL" select="//SRMData//Z[@n='RequestBO.url_']"></xsl:variable>
     <xsl:variable name="concurDetectX" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='RequestBO.ConcurDetect_X']"></xsl:variable>
     <xsl:variable name="isAutoGenKey" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='isAutoGenKey']"></xsl:variable>
     
    <xsl:variable name="SRMTips" select="$configLabels[@name='Tips']/@value"/>
	<xsl:variable name="CustomFields" select="/SRM/SRMData[@SRMDataSpace='CustomData']"/>
	<xsl:variable name="readMode" select="$CustomFields/Z[@n='IsReadOnly']"/>
	<xsl:variable name="Mode" select="$CustomFields/Z[@n='mode']"/>
    <xsl:param name="locale"/>
	<xsl:template match="/">

    <html>

	<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>

    <head>
		<script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>
		<script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
		<script>var locale = '<xsl:value-of select="$locale"/>';</script>
<!--404 changes-->
<!--		<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup.css"/> -->
<!--		<link rel="stylesheet" Type="text/css" href="../Branding/css/common/PopupMenu.css"/> -->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMTableDisplay.css"/> -->
<!--		<link rel="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate.css"/> -->
<!--	    <link rel="stylesheet" type="text/css" href="../Branding/css/common/MultiTabs.css"/> -->

     </head>

        <script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
        <script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
        <script type="text/javascript" src="../common/html/validate.js" language="javascript"></script>
        <script type="text/javascript" src="../common/html/utils.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/ListBoxFunctions.js" language="javascript"></script>
        <script type="text/javascript" src="../common/js/PopupMenu.js"></script>
        <script type="text/javascript" src="../Renderer/wizards/html/ShowButtons.html"></script>

		
	<body  class="popup" bottommargin="0" topmargin="0" style="padding-top=10px; padding-left=5px; padding-right=5px" onload="populateAddr()">
		

		<xsl:choose>
	    <xsl:when test="normalize-space($readMode)='Y'">
	    <xsl:attribute name="onload">showInReadOnlyMode('<xsl:value-of select="$readMode"/>');</xsl:attribute>
	    </xsl:when>
        </xsl:choose>  
         
        <script type="text/javascript" language="javascript">

	
		var readonly_var = "<xsl:value-of select ='$isReadOnly' />";
        var mode="<xsl:value-of select ='$Mode' />";

/* Function to change Address Details if Update Flag is Y */

	function ChangeAddress()
	{
		<![CDATA[
		for(var i = 0; i < 3; i ++)
		{
			
			var addrUpd = document.getElementsByName('AddressUpdate')[i].value;
			if (addrUpd == "Y")
			{
				document.getElementsByName('AddressLine1')[i].IsMandatory = "true";
				document.getElementsByName('AddressLine2')[i].IsMandatory = "true";
				document.getElementsByName('City')[i].IsMandatory = "true";
				document.getElementsByName('State')[i].IsMandatory = "true";
				document.getElementsByName('Country')[i].IsMandatory = "true";
				document.getElementsByName('Zip')[i].IsMandatory = "true";
				
			}
			else
			{
				document.getElementsByName('AddressLine1')[i].IsMandatory = "false";
				document.getElementsByName('AddressLine2')[i].IsMandatory = "false";
				document.getElementsByName('City')[i].IsMandatory = "false";
				document.getElementsByName('State')[i].IsMandatory = "false";
				document.getElementsByName('Country')[i].IsMandatory = "false";
				document.getElementsByName('Zip')[i].IsMandatory = "false";
				
			}
		}
		]]>
	}
/*end**/

/*Function to Validate values*/				  

	function validateForm()
	{
		retStat = parent.parent.parent.parent.parent.parent.parent.parent.ValidateFormContents(document.frm2,true);
		return retStat;
	}

/*end**/	

                
/*Save Template Function**/

	function save(incidentID) 
    {	
		var test = setHiddenvalue();
		if (test == "TRUE")
		{
			try{	
				
				if(readonly_var!="Y")
				{
					if(mode=="Edit")
					{
						document.frm2.action = "../servlet/com.infy.cis.ui.support.RequestWriter?mode=Edit&amp;incidentid=" + incidentID;
					}
					else
					{
						document.frm2.action = "../servlet/com.infy.cis.ui.support.RequestWriter?mode=New&amp;incidentid=" + incidentID;
					}
					document.frm2.target="inciSaveFrame";
					document.frm2.submit();
					return "true";
				}
			}catch(e){alert(e.message);}
		}
		else
			alert("At lease one Address should be selected for update");
	}

/*end**/

/*Set one-to-many values Function**/

				function setHiddenvalue()
				{					
					var addCounter=0;
					var type="ADDRESS";
					<![CDATA[
					for(var i=0; i<3; i ++)
					{
						
						var addrUpd = document.getElementsByName('AddressUpdate')[i].value;
						var addrCat = document.getElementsByName('AddressCategory')[i].value;
						var addrln1 = document.getElementsByName('AddressLine1')[i].value;
						var addrln2 = document.getElementsByName('AddressLine2')[i].value;
						var addrln3 = document.getElementsByName('AddressLine3')[i].value;
						var city	= document.getElementsByName('City')[i].value;
						var state	= document.getElementsByName('State')[i].value;
						var country = document.getElementsByName('Country')[i].value;
						var zip		= document.getElementsByName('Zip')[i].value;
						var tel		= document.getElementsByName('Telephone')[i].value;
						var fax		= document.getElementsByName('Fax')[i].value;
						var swift	= document.getElementsByName('Swift')[i].value;
						var email	= document.getElementsByName('Email')[i].value;
						var cell	= document.getElementsByName('Cell')[i].value;
						var pager	= document.getElementsByName('Pager')[i].value;
						var sDate	= document.getElementsByName('3_StartDate')[i].value;
						var eDate	= document.getElementsByName('3_EndDate')[i].value;
						
						if (addrUpd=="Y")
						{
							if(addCounter==0)
							{
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=addrCat;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value=addrln1;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField3')[0].value=addrln2;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField4')[0].value=addrln3;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField5')[0].value=city;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField6')[0].value=state;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField7')[0].value=country;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField8')[0].value=zip;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField9')[0].value=addrUpd;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField10')[0].value=tel;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField11')[0].value=fax;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField12')[0].value=swift;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField13')[0].value=email;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField14')[0].value=cell;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField15')[0].value=pager;
								document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value=sDate;
								document.getElementsByName('RequestBO.RequestGenInfo.userDateField2')[0].value=eDate;
								document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=type;
								addCounter=1;
							}
							else
							{
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField1')[0].value+"$"+addrCat;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField2')[0].value+"$"+addrln1;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField3')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField3')[0].value+"$"+addrln2;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField4')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField4')[0].value+"$"+addrln3;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField5')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField5')[0].value+"$"+city;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField6')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField6')[0].value+"$"+state;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField7')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField7')[0].value+"$"+country;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField8')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField8')[0].value+"$"+zip;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField9')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField9')[0].value+"$"+addrUpd;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField10')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField10')[0].value+"$"+tel;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField11')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField11')[0].value+"$"+fax;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField12')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField12')[0].value+"$"+swift;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField13')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField13')[0].value+"$"+email;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField14')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField14')[0].value+"$"+cell;
								document.getElementsByName('RequestBO.RequestGenInfo.userStrField15')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userStrField15')[0].value+"$"+pager;
								document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userDateField1')[0].value+"$"+sDate;
								document.getElementsByName('RequestBO.RequestGenInfo.userDateField2')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.userDateField2')[0].value+"$"+eDate;
								document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value=document.getElementsByName('RequestBO.RequestGenInfo.requestInfoType')[0].value+"$"+type;
								addCounter=addCounter+1;
							}
						}
					}
					]]>
					document.getElementsByName('listSize')[0].value=addCounter;
					if(addCounter==0)
					{
						return "FALSE";
					}
					else
					{
						return "TRUE";
					}



				}

/*end**/

/*Populate A/c No Function**/

				function populateAddr()
				{
					try {

						var iCount = 0;
						var addrCat;
						var addrUpd;
						var addrln1;
						var addrln2;
						var addrln3;
						var city;
						var state;
						var country;
						var zip;
						var tel;
						var fax;
						var swift;
						var email;
						var cell;
						var pager;
						var sdate;
						var edate;
						var j;
						
						<![CDATA[
						for(var i=0; i<3; i ++)
						{
							document.getElementsByName('AddressUpdate')[i].value="";
							document.getElementsByName('AddressCategory')[i].value="";
							document.getElementsByName('AddressLine1')[i].value="";
							document.getElementsByName('AddressLine2')[i].value="";
							document.getElementsByName('AddressLine3')[i].value="";
							document.getElementsByName('City')[i].value="";
							document.getElementsByName('State')[i].value="";
							document.getElementsByName('Country')[i].value="";
							document.getElementsByName('Zip')[i].value="";
							document.getElementsByName('Telephone')[i].value="";
							document.getElementsByName('Fax')[i].value="";
							document.getElementsByName('Swift')[i].value="";
							document.getElementsByName('Email')[i].value="";
							document.getElementsByName('Cell')[i].value="";
							document.getElementsByName('Pager')[i].value="";
							document.getElementsByName('3_StartDate')[i].value="";
							document.getElementsByName('3_EndDate')[i].value="";

						}
						]]>
						

						document.getElementsByName('AddressCategory')[0].value="Mailing";
						document.getElementsByName('AddressCategory')[1].value="Work";
						document.getElementsByName('AddressCategory')[2].value="Home";

						document.getElementsByName('AddressCategory')[0].disabled="true";
						document.getElementsByName('AddressCategory')[1].disabled="true";
						document.getElementsByName('AddressCategory')[2].disabled="true";

						'<xsl:for-each select="//SRMData[@SRMDataSpace='Main']/SRMComposite[@n='RecordSet']/SRMRow">'

							addrCat						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField1']"/>';
							addrln1						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField2']"/>';
							addrln2						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField3']"/>';
							addrln3						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField4']"/>';
							addrUpd						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField9']"/>';
							city						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField5']"/>';
							state						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField6']"/>';
							country						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField7']"/>';
							zip							= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField8']"/>';
							tel							= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField10']"/>';
							fax							= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField11']"/>';
							swift						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField12']"/>';
							email						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField13']"/>';
							cell						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField14']"/>';
							pager						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userStrField15']"/>';
							sdate						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userDateField1']"/>';
							edate						= '<xsl:value-of select="./Z[@n='RequestBO.RequestGenInfo.userDateField2']"/>';


							if(addrCat=="Mailing")
								j=0;
							if(addrCat=="Work")
								j=1;
							if(addrCat=="Home")
								j=2;
							
								document.getElementsByName("AddressUpdate")[j].options.value=addrUpd;
								if(addrUpd=="Y")
								{
									ChangeAddress();		
								}
								document.getElementsByName("AddressLine1")[j].value=addrln1;
								document.getElementsByName("AddressLine2")[j].value=addrln2;
								document.getElementsByName("AddressLine3")[j].value=addrln3;
								document.getElementsByName('City')[j].options.value=city;
								document.getElementsByName('State')[j].options.value=state;
								document.getElementsByName('Country')[j].options.value=country;
								document.getElementsByName('Zip')[j].value=zip;
								document.getElementsByName('Telephone')[j].value=tel;
								document.getElementsByName('Fax')[j].value=fax;
								document.getElementsByName('Swift')[j].value=swift;
								document.getElementsByName('Email')[j].value=email;
								document.getElementsByName('Cell')[j].value=cell;
								document.getElementsByName('Pager')[j].value=pager;
								document.getElementsByName('3_StartDate')[j].value=sdate;
								document.getElementsByName('3_EndDate')[j].value=edate;
							

							iCount=iCount+1;

						'</xsl:for-each>'

					}
					catch(e)
					{
						alert('inside populateAddr'+e.message);
					}
				}
        
/*end**/


                </script>

                 <!--javascript ends here-->


                 <table width="100%" border="0" cellpadding="0" cellspacing="0" vspace="0" hspace="0">
                     <xsl:apply-templates select="SRM"/>
                 </table>



      </body>
      </html>
      </xsl:template>


	<xsl:attribute-set name="cellstyle1">
	  <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
	  <xsl:attribute name="align">center</xsl:attribute>
	  <xsl:attribute name="colspan">7</xsl:attribute>
	  <xsl:attribute name="class">header</xsl:attribute>
	</xsl:attribute-set>

	<xsl:template name="apply1">
	<xsl:param name="apply_head">blank</xsl:param>
		<td xsl:use-attribute-sets="cellstyle1">
	        <xsl:value-of select="$apply_head"/>
	       </td>
	</xsl:template>

<!--template for Form Mode Delivery -->
	<xsl:template name="RequestBO.userStrField1">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField1']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">RequestBO.userStrField1</xsl:with-param>
		<xsl:with-param name="selectname">RequestBO.userStrField1</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

<!--template for Form Received Confirmation Mode -->
	<xsl:template name="RequestBO.userStrField2">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField2']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">RequestBO.userStrField2</xsl:with-param>
		<xsl:with-param name="selectname">RequestBO.userStrField2</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

<!--template for Form Despatch Details -->	         
	<xsl:template name="RequestBO.userStrField3">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField3']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField3</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField3</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--template for Form Received Details -->
	<xsl:template name="RequestBO.userStrField4">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField4']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField4</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField4</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--template for Docs sent to HO Details -->
	<xsl:template name="RequestBO.userStrField5">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField5']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField5</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField5</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--template for Docs Received at HO Details  -->
	<xsl:template name="RequestBO.userStrField6">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField6']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField6</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField6</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!--template for Authentication Result -->
	<xsl:template name="RequestBO.userStrField7">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField7']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">RequestBO.userStrField7</xsl:with-param>
		<xsl:with-param name="selectname">RequestBO.userStrField7</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

<!--template for Auth Decision Details -->
	<xsl:template name="RequestBO.userStrField8">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField8']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField8</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField8</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--template for Request Confirmation to Customer Details -->
	<xsl:template name="RequestBO.userStrField9">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField9']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField9</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField9</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--template for Documents Sent to EdGa Details -->
	<xsl:template name="RequestBO.userStrField10">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField10']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField10</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField10</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Default Mailing Address1 -->
	<xsl:template name="RequestBO.userStrField23">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField23']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField23</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField23</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Default Mailing Address2 -->
	<xsl:template name="RequestBO.userStrField24">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField24']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField24</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField24</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Default Mailing Address3 -->
	<xsl:template name="RequestBO.userStrField25">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField25']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField25</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField25</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for City -->
	<xsl:template name="RequestBO.userStrField26">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField26']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">RequestBO.userStrField26</xsl:with-param>
		<xsl:with-param name="selectname">RequestBO.userStrField26</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

	<!--template for State -->
	<xsl:template name="RequestBO.userStrField27">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField27']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">RequestBO.userStrField27</xsl:with-param>
		<xsl:with-param name="selectname">RequestBO.userStrField27</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

	<!--template for Zip -->
	<xsl:template name="RequestBO.userStrField28">
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField28']"/>
		<xsl:with-param name="ele_name">RequestBO.userStrField28</xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.userStrField28</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Documents Country -->
	<xsl:template name="RequestBO.userStrField29">
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userStrField29']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">RequestBO.userStrField29</xsl:with-param>
		<xsl:with-param name="selectname">RequestBO.userStrField29</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

	<!--template for Special Instructions for Despatch -->
	<xsl:template name="RequestBO.userTextField1">
		<xsl:call-template name="mtextarea">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.userTextField1']"/>
		<xsl:with-param name="mname">RequestBO.userTextField1</xsl:with-param>
		<xsl:with-param name="mvalue">RequestBO.userTextField1</xsl:with-param>
		<xsl:with-param name="mwrap">on</xsl:with-param>
		<xsl:with-param name="mrows">4</xsl:with-param>
		<xsl:with-param name="mcols">70</xsl:with-param>
		<xsl:with-param name="mcolspan">5</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for AddressUpdate -->
	<xsl:template name="AddressUpdate">
		<xsl:param name="selectname"/>
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField9']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">AddressUpdate</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select ="$selectname"/></xsl:with-param> 
		<xsl:with-param name="onchangefn">ChangeAddress()</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for AddressCategory -->
	<xsl:template name="AddressCategory">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField1']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField1</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for AddressLine1 -->
	<xsl:template name="AddressLine1">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField2']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField2</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--template for AddressLine2 -->
	<xsl:template name="AddressLine2">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField3']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField3</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for AddressLine3 -->
	<xsl:template name="AddressLine3">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField4']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField4</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for City -->
	<xsl:template name="City">
		<xsl:param name="selectname"/>
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField5']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">City</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select ="$selectname"/></xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

	<!--template for State -->
	<xsl:template name="State">
		<xsl:param name="selectname"/>
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField6']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">State</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select ="$selectname"/></xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

	<!--template for Country -->
	<xsl:template name="Country">
		<xsl:param name="selectname"/>
		<xsl:call-template name="mdrpdown">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField7']"/>
		<xsl:with-param name="search_type">value</xsl:with-param>
		<xsl:with-param name="selectdisp">Country</xsl:with-param>
		<xsl:with-param name="selectname"><xsl:value-of select ="$selectname"/></xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

	<!--template for Zip Code -->
	<xsl:template name="Zip">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField8']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField8</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Telephone -->
	<xsl:template name="Telephone">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField10']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField10</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Fax -->
	<xsl:template name="Fax">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField11']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField11</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Swift -->
	<xsl:template name="Swift">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField12']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField12</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Email -->
	<xsl:template name="Email">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField13']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField13</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Cell No -->
	<xsl:template name="Cell">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField14']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField14</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for Pager No -->
	<xsl:template name="Pager">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userStrField15']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userStrField15</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<!--template for Start Date -->
	<xsl:template name="StartDate">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userDateField1']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userDateField1</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--template for End Date -->
	<xsl:template name="EndDate">
		<xsl:param name="ele_name"/>
		<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='RequestBO.RequestGenInfo.userDateField2']"/>
		<xsl:with-param name="ele_name"><xsl:value-of select ="$ele_name"/></xsl:with-param>
		<xsl:with-param name="ele_val">RequestBO.RequestGenInfo.userDateField2</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!--test end -->

	<xsl:template match="*" mode="mode1">
	<xsl:call-template name="Begin"/>

<td>
		<form name="frm2" method="post">

		<input type="hidden" name="hid_requestURL" value="{$requestURL}"/>
		<input type="hidden" name="hid_concurDetectX" value="{$concurDetectX}"/>
		<input type="hidden" value="{$isAutoGenKey}" name="isAutoGenKey"/>

		<input type="hidden" value="" name="RequestBO.RequestGenInfo.requestInfoType"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField1"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField2"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField3"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField4"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField5"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField6"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField7"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField8"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField9"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField10"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField11"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField12"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField13"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField14"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userStrField15"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userDateField1"/>
		<input type="hidden" value="" name="RequestBO.RequestGenInfo.userDateField2"/>

		<input type="hidden" value="" name="listSize"/>
	       
<table width="100%" bgcolor='E5E5E5' cellspacing="0" vspace="0" hspace="0" border="0">

				<xsl:call-template name="BeginTabView">
					<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
					<xsl:with-param name="tabPageHeight">100</xsl:with-param>
					<xsl:with-param name="colSpan">20</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageAddressDetails</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes" select="'Address Details'"/>
					<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
					<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
				</xsl:call-template>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressCategory">
					<xsl:with-param name="ele_name">AddressCategory</xsl:with-param>
					</xsl:call-template>					
				<xsl:call-template name="End"/>			

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressLine1">
					<xsl:with-param name="ele_name">AddressLine1</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="AddressLine2">
					<xsl:with-param name="ele_name">AddressLine2</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressLine3">
					<xsl:with-param name="ele_name">AddressLine3</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="City">
					<xsl:with-param name="selectname">City</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="State">
					<xsl:with-param name="selectname">State</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Country">
					<xsl:with-param name="selectname">Country</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Zip">
					<xsl:with-param name="ele_name">Zip</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Telephone">
					<xsl:with-param name="ele_name">Telephone</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Fax">
					<xsl:with-param name="ele_name">Fax</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Swift">
					<xsl:with-param name="ele_name">Swift</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Cell">
					<xsl:with-param name="ele_name">Cell</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Pager">
					<xsl:with-param name="ele_name">Pager</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Email">
					<xsl:with-param name="ele_name">Email</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="AddressUpdate">
					<xsl:with-param name="selectname">AddressUpdate</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="StartDate">
					<xsl:with-param name="ele_name">StartDate</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="EndDate">
					<xsl:with-param name="ele_name">EndDate</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>


				<xsl:call-template name="LineBreak">
					<xsl:with-param name="drawLine">true</xsl:with-param>
					<xsl:with-param name="lineColor">gray</xsl:with-param>
					<xsl:with-param name="width">95%</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="addemptycell"/>
					<xsl:call-template name="addemptycell"/>
				<xsl:call-template name="End"/>
				

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressCategory">
					<xsl:with-param name="ele_name">AddressCategory</xsl:with-param>
					</xsl:call-template>					
				<xsl:call-template name="End"/>			

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressLine1">
					<xsl:with-param name="ele_name">AddressLine1</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="AddressLine2">
					<xsl:with-param name="ele_name">AddressLine2</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressLine3">
					<xsl:with-param name="ele_name">AddressLine3</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="City">
					<xsl:with-param name="selectname">City</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="State">
					<xsl:with-param name="selectname">State</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Country">
					<xsl:with-param name="selectname">Country</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Zip">
					<xsl:with-param name="ele_name">Zip</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Telephone">
					<xsl:with-param name="ele_name">Telephone</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Fax">
					<xsl:with-param name="ele_name">Fax</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Swift">
					<xsl:with-param name="ele_name">Swift</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Cell">
					<xsl:with-param name="ele_name">Cell</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Pager">
					<xsl:with-param name="ele_name">Pager</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Email">
					<xsl:with-param name="ele_name">Email</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="AddressUpdate">
					<xsl:with-param name="selectname">AddressUpdate</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="StartDate">
					<xsl:with-param name="ele_name">StartDate</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="EndDate">
					<xsl:with-param name="ele_name">EndDate</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="LineBreak">
					<xsl:with-param name="drawLine">true</xsl:with-param>
					<xsl:with-param name="lineColor">gray</xsl:with-param>
					<xsl:with-param name="width">95%</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="addemptycell"/>
					<xsl:call-template name="addemptycell"/>
				<xsl:call-template name="End"/>


				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressCategory">
					<xsl:with-param name="ele_name">AddressCategory</xsl:with-param>
					</xsl:call-template>					
				<xsl:call-template name="End"/>			

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressLine1">
					<xsl:with-param name="ele_name">AddressLine1</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="AddressLine2">
					<xsl:with-param name="ele_name">AddressLine2</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="AddressLine3">
					<xsl:with-param name="ele_name">AddressLine3</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="City">
					<xsl:with-param name="selectname">City</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="State">
					<xsl:with-param name="selectname">State</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Country">
					<xsl:with-param name="selectname">Country</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Zip">
					<xsl:with-param name="ele_name">Zip</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Telephone">
					<xsl:with-param name="ele_name">Telephone</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Fax">
					<xsl:with-param name="ele_name">Fax</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Swift">
					<xsl:with-param name="ele_name">Swift</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Cell">
					<xsl:with-param name="ele_name">Cell</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="Pager">
					<xsl:with-param name="ele_name">Pager</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="Email">
					<xsl:with-param name="ele_name">Email</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="AddressUpdate">
					<xsl:with-param name="selectname">AddressUpdate</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="StartDate">
					<xsl:with-param name="ele_name">StartDate</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="EndDate">
					<xsl:with-param name="ele_name">EndDate</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="addemptycell"/>
					<xsl:call-template name="addemptycell"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="EndTabPage"/>

				<xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageDispatchDetails</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes" select="'Dispatch Details'"/>
					<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
					<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
				</xsl:call-template>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField1"/>
					<xsl:call-template name="RequestBO.userStrField3"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField23"/> 
					<xsl:call-template name="RequestBO.userStrField24"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
						<xsl:call-template name="RequestBO.userStrField25"/>
						<xsl:call-template name="RequestBO.userStrField26"/>
				<xsl:call-template name="End"/>

					
				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField27"/>
					<xsl:call-template name="RequestBO.userStrField29"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField28"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userTextField1"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="LineBreak">
					<xsl:with-param name="drawLine">true</xsl:with-param>
					<xsl:with-param name="lineColor">gray</xsl:with-param>
					<xsl:with-param name="width">95%</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField2"/>
					<xsl:call-template name="RequestBO.userStrField4"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="addemptycell"/>
					<xsl:call-template name="addemptycell"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="EndTabPage"/>

				<xsl:call-template name="BeginTabPage">
					<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
					<xsl:with-param name="tabPageName">tpageHODetails</xsl:with-param>
					<xsl:with-param name="tabPageDisplayNameRes" select="'HO Details'"/>
					<xsl:with-param name="isTabNameHardCoded" select="'Yes'"/>
					<xsl:with-param name="isInnerToInnerTab" select="'N'"/>
				</xsl:call-template>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField5"/>
					<xsl:call-template name="RequestBO.userStrField6"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField7"/>
					<xsl:call-template name="RequestBO.userStrField8"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="LineBreak">
					<xsl:with-param name="drawLine">true</xsl:with-param>
					<xsl:with-param name="lineColor">gray</xsl:with-param>
					<xsl:with-param name="width">95%</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="RequestBO.userStrField10"/>
					<xsl:call-template name="RequestBO.userStrField9"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="Begin"/>
					<xsl:call-template name="addemptycell"/>
					<xsl:call-template name="addemptycell"/>
				<xsl:call-template name="End"/>

				<xsl:call-template name="EndTabPage"/>

				<xsl:call-template name="EndTabView">
					<xsl:with-param name="tabViewName">tabSRAddrChg</xsl:with-param>
					<xsl:with-param name="selectedTabPageName">tpageAddressDetails</xsl:with-param>
				</xsl:call-template>



	</table>
       </form>
      </td>
      <xsl:call-template name="End"/>

       </xsl:template>
        <xsl:template match="SRM">
        <xsl:for-each select=".">
             <xsl:call-template name="startTable"/>
                <table bgcolor='E5E5E5' border="0" cellspacing="0" cellpadding="2" width="100%" vspace="0" hspace="0">
                   <tr>
                     <xsl:call-template name="apply">
                     <xsl:with-param name="apply_head">
                     <b><xsl:value-of select="$configLabels[@name='Header']/@configLabel"/></b>
                     </xsl:with-param>
                     </xsl:call-template>
                 </tr>
              </table>

                <table bgcolor='E5E5E5' width="100%" border="0" cellspacing="0" cellpadding="2">
                  <xsl:apply-templates select="." mode="mode1"/>
                </table>
             <xsl:call-template name="endTable"/>
         </xsl:for-each>
        </xsl:template>

</xsl:stylesheet>

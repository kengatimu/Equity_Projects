<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="../Renderer/common/display/SRMFormWidgets.xsl"/>
<xsl:import href="../Renderer/common/display/SRMFormDisplay.xsl"/>   

<xsl:param name="locale"/>
       
<xsl:variable name="file1">../Renderer/Customization/corpcif/resource/CorpCustOnboard_<xsl:value-of select="$locale"/>.xml</xsl:variable>
<xsl:variable name="configFile_1" select="document(concat($file1, ''))"/>
<xsl:variable name="configLabels" select="$configFile_1/SRMBO/*"/>
<xsl:variable name="customfields" select="/SRM/SRMData[@SRMDataSpace='CustomData']/Z"/>

<xsl:variable name="noofpages" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='TotalPages']" />

<xsl:variable name="doccodelist" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='attr5']" />
<xsl:variable name="categoryvaluelist" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='attr4']" />

<xsl:variable name="s1" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='s1']" />
<xsl:variable name="s2" select="//SRMData[@SRMDataSpace='CustomData']/Z[@n='s2']" />




<xsl:template match="/">
  <html>
    <head>
      <script type="text/javascript" src="../common/js/ClientResourceBundle_{$locale}.js" language="javascript"></script>

	  <script>
        var locale = '<xsl:value-of select="$locale"/>';
        
        var doccodelist = '<xsl:value-of select="$doccodelist"/>';
        var categoryvaluelist = '<xsl:value-of select="$categoryvaluelist"/>';
        
         var s1 = '<xsl:value-of select="$s1"/>';
        var s2 = '<xsl:value-of select="$s2"/>';
       
         var noofpages='<xsl:value-of select="$noofpages"></xsl:value-of>';
         /*alert("s1 "+s1);
         alert("s2 "+s2);
         alert("doccodelist "+doccodelist);
         alert("categoryvaluelist "+categoryvaluelist);*/
         
       
        
       
      </script>

<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Admin_{$locale}.css"/>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Popup_{$locale}.css"/>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/Admin_{$locale}.css"/>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/MultiTabs_{$locale}.css"/>
<LINK REL="stylesheet" type="text/css" href="../Branding/css/common/SRMListTemplate_{$locale}.css"/>
<LINK REL="stylesheet" Type="text/css" href="../Branding/css/common/SRMTableDisplay_{$locale}.css"/>
<title><xsl:value-of select="//SRMPresentation/SRMSystem[@n='Strings']/SRMString[@n='Title']/@value"/></title>
<script type="text/javascript" src="../common/js/SRMTableRowColor.js"></script>
<script type="text/javascript" src="../common/js/SRMFormToggle.js"></script>
<script type="text/javascript" src="../common/html/validate.js"></script>
<style>
  .size{width=120px;}
</style>
<script language='javascript'>
	<![CDATA[
	function submitForm(){
			var uniqueid = document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value;
						
			var documentcode = document.getElementsByName('documenttype')[0].value;
			
			
			
			if(uniqueid == '' || documentcode == ''){
						alert("Please fill all the mandatory fields!");
						return;
			}
			document.FindForm.ReferenceNumber.value =uniqueid;
						
			document.FindForm.documenttype.value = documentcode;
			
			document.FindForm.action = "../servlet/com.infy.cis.custom.CorpCustOnboardList?ReferenceNumber="+uniqueid+"&IdentificationType="+documentcode+"";
			document.FindForm.submit();
					
		}
		
		
		function clearForm() {
							document.getElementsByName('EntityDocumentBO.ReferenceNumber')[0].value = "";
							
							document.getElementsByName('documenttype')[0].value = "";
							document.getElementsByName('CREATE1')[0].disabled= true;
										document.getElementsByName('CREATE2')[0].disabled= true;
													document.getElementsByName('CREATE3')[0].disabled= true;
													document.getElementsByName('CREATE4')[0].disabled= true;
													document.getElementsByName('CREATE5')[0].disabled= true;
										document.getElementsByName('CREATE6')[0].disabled= true;
						
			}
		
	
	function load(){
	
			document.getElementsByName('CREATE1')[0].disabled= true;
			document.getElementsByName('CREATE2')[0].disabled= true;
						document.getElementsByName('CREATE3')[0].disabled= true;
						document.getElementsByName('CREATE4')[0].disabled= true;
						document.getElementsByName('CREATE5')[0].disabled= true;
			document.getElementsByName('CREATE6')[0].disabled= true;
						
	}
		
		
	function CreateCorpCustomerQDE(){
					
							
					
					//setCookie("Filter_uniqueId",document.FindForm.ReferenceNumber.value);
					//setCookie("Filter_documentcode",document.FindForm.documenttype.value);
					setcookies();
				
					var dataArea = parent.parent.parent.parent.parent;
					var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
					screenTitle.titleMsg.innerHTML = "Registered Entity CIF > New Entity > CustomerQDE";
					<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Begins-->
					
					dataArea.location.href="../servlet/com.infy.cis.ui.corpcif.CorpQDEDetWizard?entityType=Customer";
					
		    		<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Ends-->
		    		
		    		
		    	
	}
	
	function setcookies()
	{
	var documentcode1 = document.getElementsByName('documenttype')[0].value;
						setCookie("Filter_uniqueId",document.FindForm.ReferenceNumber.value);
						//setCookie("Filter_documentcode",document.FindForm.documenttype.value);
						
						
						var temp = new Array();
	      	                                temp=s1.split(",");
	      	                                var temp1 = new Array();
	      	                                temp1=s2.split(",");
						var documentcode2;
						for(i=0;i<temp.length;i++)
						{
						
						if(temp[i]==documentcode1)
						{
						  documentcode2 = temp1[i];
						  break;
						}
						
						}
						
						 
						
						
					setCookie("Filter_documentcode",documentcode2);
	}
	
	
		
		function CreateCorpCustomer(){
						
								
						
						//setCookie("Filter_uniqueId",document.FindForm.ReferenceNumber.value);
						//setCookie("Filter_documentcode",document.FindForm.documenttype.value);
					        setcookies();
						var dataArea = parent.parent.parent.parent.parent;
						var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
						screenTitle.titleMsg.innerHTML = "Registered Entity CIF > New Entity > Customer DDE";						
						<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Begins-->
						
						dataArea.location.href="../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?entityType=Customer";
						
			    		<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Ends-->
			    		
			    		
			    	
		}
	
	function CreateCorpCustomerSQDE(){
						
								
						
						//setCookie("Filter_uniqueId",document.FindForm.ReferenceNumber.value);
						//setCookie("Filter_documentcode",document.FindForm.documenttype.value);
						setcookies();
					
						var dataArea = parent.parent.parent.parent.parent;
						var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
						screenTitle.titleMsg.innerHTML = "Registered Entity CIF > New Entity > Customer SQDE";
						<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Begins-->
						
						dataArea.location.href="../servlet/com.infy.cis.ui.corpcif.CorpSQDEWizard";
						
			    		<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Ends-->
			    		
			    		
			    	
	}
	
	
	function CreateNonCustomer(){
							
									
							
							setCookie("Filter_uniqueId",document.FindForm.ReferenceNumber.value);
							setCookie("Filter_documentcode",document.FindForm.documenttype.value);
						
							var dataArea = parent.parent.parent.parent.parent;
							var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
							screenTitle.titleMsg.innerHTML = "Registered Entity CIF > New Entity > Non-customer";
							<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Begins-->
							
							dataArea.location.href="../servlet/com.infy.cis.ui.corpcif.CorpNonCustomerDetWizard";
							
				    		<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Ends-->
				    		
				    		
				    	
	}
	
	function CreateProspect(){
								
										
								
								setCookie("Filter_uniqueId",document.FindForm.ReferenceNumber.value);
								setCookie("Filter_documentcode",document.FindForm.documenttype.value);
							
								var dataArea = parent.parent.parent.parent.parent;
								var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
								screenTitle.titleMsg.innerHTML = "Registered Entity CIF > New Entity >Prospect";
								<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Begins-->
								
								dataArea.location.href="../servlet/com.infy.cis.ui.corpcif.CorpCreateDetWizard?entityType=Prospect";
								
					    		<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Ends-->
					    		
					    		
					    	
		}
	
	function CreateProspectQDE(){
								
										
								
								setCookie("Filter_uniqueId",document.FindForm.ReferenceNumber.value);
								setCookie("Filter_documentcode",document.FindForm.documenttype.value);
							
								var dataArea = parent.parent.parent.parent.parent;
								var screenTitle= parent.parent.parent.parent.parent.parent.ScreenTitleFrm;
								screenTitle.titleMsg.innerHTML = "Registered Entity CIF > New Entity > Non-customer";
								<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Begins-->
								
								dataArea.location.href="../servlet/com.infy.cis.ui.corpcif.CorpQDEDetWizard?entityType=Prospect";
								
					    		<!--CRM_STD_Frank updated on 2012/5/14. Ref.:QC707. Ends-->
					    		
					    		
					    	
		}
	
	
	]]>
</script>
</head>
<body class="popup" onload="load();">
	<table   align='center' width="100%" cellpadding="0" cellspacing="0" border="0">
	<xsl:apply-templates select="SRM"/>
	</table>
</body>
</html>
</xsl:template>

<xsl:template name="EntityDocumentBO.ReferenceNumber">
	<xsl:call-template name="label">
		<xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.ReferenceNumber']"/> 
		<xsl:with-param name="ele_name">EntityDocumentBO.ReferenceNumber</xsl:with-param>        
		<xsl:with-param name="ele_val">EntityDocumentBO.ReferenceNumber</xsl:with-param>
	</xsl:call-template>
</xsl:template>








<xsl:template name="EntityDocumentBO.IdentificationType">
    <xsl:call-template name="mdrpdown">
      <xsl:with-param name="res_name" select="$configLabels[@name='EntityDocumentBO.IdentificationType']"/>
      <xsl:with-param name="selectdisp">Condition</xsl:with-param>
      <xsl:with-param name="selectname">documenttype</xsl:with-param>
      
   <xsl:with-param name="search_type">value</xsl:with-param>
 

    </xsl:call-template>
  </xsl:template>
  

<xsl:template match="*" mode="mode1">
  <form name="FindForm" target='formDispFrame' method="post">
	<input type="hidden" name="SortOrder" value=""/>
	<input type="hidden" name="SortColumn" value=""/> 
	<input type="hidden" name="ReferenceNumber" value=""/> 
	
	
<input type="hidden" name="IdentificationType" value=""/> 

		<xsl:call-template name="Begin"/>
			<xsl:call-template name="EntityDocumentBO.ReferenceNumber"/>
			<xsl:call-template name="End"/>
			
			
			<xsl:call-template name="Begin"/>
					<xsl:call-template name="EntityDocumentBO.IdentificationType"/>
					
		<xsl:call-template name="End"/>
			
	
	
	
		<tr>
		<td>
	
			<xsl:call-template name="user_button_withText">
			<xsl:with-param name="button_name">dedup check</xsl:with-param>
			<xsl:with-param name="button_text">dedup check</xsl:with-param>
			<xsl:with-param name="button_fnc">submitForm();</xsl:with-param>
			<xsl:with-param name="class">sbttn</xsl:with-param>
			</xsl:call-template>&#160;
			
			
			<xsl:call-template name="user_button_withText">
					<xsl:with-param name="button_name">clear</xsl:with-param>
					<xsl:with-param name="button_text">clear</xsl:with-param>
					<xsl:with-param name="button_fnc">clearForm();</xsl:with-param>
					<xsl:with-param name="class">sbttn</xsl:with-param>
			</xsl:call-template>&#160;
			
			
			
			
			
		</td>
		</tr>
			<tr>
		        <td>
		        <br/>
		        </td>
	</tr>
	     <tr>
	        <td>
	       
	       
	       
	       <xsl:call-template name="user_button_withText">
	       		<xsl:with-param name="button_name">CREATE1</xsl:with-param>
	       		<xsl:with-param name="button_text">Customer QDE</xsl:with-param>
	       		<xsl:with-param name="button_fnc">CreateCorpCustomerQDE();</xsl:with-param>
	       		<xsl:with-param name="class">sbttn</xsl:with-param>
       		</xsl:call-template>&#160;
       		
       		
       		
       		
       		
       		<xsl:call-template name="user_button_withText">
				       		<xsl:with-param name="button_name">CREATE2</xsl:with-param>
			<xsl:with-param name="button_text">Customer DDE</xsl:with-param>
				       		<xsl:with-param name="button_fnc">CreateCorpCustomer();</xsl:with-param>
				       		<xsl:with-param name="class">sbttn</xsl:with-param>
						</xsl:call-template>&#160;
				       
				 
				       <xsl:call-template name="user_button_withText">
				       					<xsl:with-param name="button_name">CREATE3</xsl:with-param>
				       					<xsl:with-param name="button_text">Customer SQDE</xsl:with-param>
				       					<xsl:with-param name="button_fnc">CreateCorpCustomerSQDE();</xsl:with-param>
				       					<xsl:with-param name="class">sbttn</xsl:with-param>
							</xsl:call-template>&#160;
				    
				       <xsl:call-template name="user_button_withText">
				       					<xsl:with-param name="button_name">CREATE4</xsl:with-param>
				       					<xsl:with-param name="button_text">Non-customer</xsl:with-param>
				       					<xsl:with-param name="button_fnc">CreateNonCustomer();</xsl:with-param>
				       					<xsl:with-param name="class">sbttn</xsl:with-param>
						</xsl:call-template>&#160;
							
							
	
			        <xsl:call-template name="user_button_withText">
											<xsl:with-param name="button_name">CREATE5</xsl:with-param>
											<xsl:with-param name="button_text">Prospect</xsl:with-param>
											<xsl:with-param name="button_fnc">CreateProspect();</xsl:with-param>
											<xsl:with-param name="class">sbttn</xsl:with-param>
								</xsl:call-template>&#160;
       		
			        

							<xsl:call-template name="user_button_withText">
							<xsl:with-param name="button_name">CREATE6</xsl:with-param>
							<xsl:with-param name="button_text">ProspectQDE</xsl:with-param>
							<xsl:with-param name="button_fnc">CreateProspectQDE();</xsl:with-param>
							<xsl:with-param name="class">sbttn</xsl:with-param>
							</xsl:call-template>&#160;
						
						
							
							
	
       		
       		
	</td>
			
			
	</tr>
</form>
</xsl:template>
        <xsl:template match="SRM">
     	<xsl:for-each select=".">
       	<tr>
        <td colspan="9">
       		<table border="0" width="100%" cellspacing="1" cellpadding="0">
		<tr>
			<xsl:call-template name="apply">
			<xsl:with-param name="apply_head">
			<b>Customer Onboard</b><br/>
			</xsl:with-param>
			</xsl:call-template>
		</tr>
           </table>              
          </td>
       </tr>
       <xsl:apply-templates select="." mode="mode1"/>
     </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>








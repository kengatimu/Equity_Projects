<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml"/>

<xsl:template match="/" >
<!--**************************Enter the unique ID**************************-->
<xsl:variable name="uniqueID" select="'AccountBO.accountID'"/>    
<!--**************************Enter the Inner class Name replacing only Address**************************-->
<xsl:variable name="childClass" select="'.Address.'"/>  <xsl:for-each select="SRM">  <xsl:element name="SRM">
   <xsl:for-each select="SRMData">
   <xsl:element name="SRMData">
   <xsl:variable name="attributeNameLocal1" select="@SRMDataSpace"/>
   <xsl:attribute name="SRMDataSpace"><xsl:value-of select="$attributeNameLocal1"/></xsl:attribute>
      <xsl:for-each select="SRMComposite"> <xsl:element name="SRMComposite"> <xsl:variable name="attributeNameLocal2" select="@n"/>
      <xsl:attribute name="n"><xsl:value-of select="$attributeNameLocal2"/></xsl:attribute>
        <xsl:for-each select="SRMRow">
          <xsl:variable name="pos" select="position()-1"/> 
          <xsl:variable name="position" select="position()"/> 
            <xsl:variable name="select1">
                <xsl:if test="position()=1">F</xsl:if>
                <xsl:if test="position()!=1">
		      <xsl:for-each select="Z">
			   <xsl:if test="@n=$uniqueID">
			      <xsl:call-template name="merge">
					<xsl:with-param name="attributeValue" select="current()" />
					<xsl:with-param name="position" select="$position" />
					<xsl:with-param name="uniqueID" select="$uniqueID" />
			      </xsl:call-template>
			   </xsl:if>
		      </xsl:for-each>
		  </xsl:if>    
          </xsl:variable>
         
         
       <xsl:if test="not(contains($select1,'T'))">  
        <xsl:element name="SRMRow"> 
         <xsl:for-each select="Z">
	                            
			

			
				<xsl:choose>  
				  <xsl:when test="position()=last()">
				    <xsl:call-template name="merge2">
				        <xsl:with-param name="position" select="$position" />
				        <xsl:with-param name="childClass" select="$childClass" />
				    </xsl:call-template>
				  </xsl:when>  
				     
				  <xsl:when test="not(contains(@n,$childClass))">
				    <xsl:if test="not(contains(@n,'transformid'))">
				  <xsl:variable name="element1" select="@n"/>
				  <xsl:element name="{$element1}">
						
						<xsl:value-of select="current()"/>
				    </xsl:element>
				    </xsl:if>
				    </xsl:when>
				    
				</xsl:choose>

			
	                            
			
  
        </xsl:for-each>
        
        <xsl:variable name="attributeValue">
		<xsl:for-each select="Z">
		   <xsl:if test="@n=$uniqueID"><xsl:value-of select="current()"/></xsl:if>
		</xsl:for-each>
        </xsl:variable>
             <xsl:call-template name="merge3">
			<xsl:with-param name="position" select="$position" />
			<xsl:with-param name="attributeValue" select="$attributeValue" />
			<xsl:with-param name="uniqueID" select="$uniqueID" />
			<xsl:with-param name="childClass" select="$childClass" />
	    </xsl:call-template>
        
       </xsl:element> 
     </xsl:if>  
        
 </xsl:for-each>
 </xsl:element>
 </xsl:for-each>
 </xsl:element>
 </xsl:for-each>
 <xsl:for-each select="SRMPresentation">  <xsl:element name="SRMPresentation">
    <xsl:for-each select="SRMSystem">
 	<xsl:element name="SRMSystem">
	<xsl:variable name="attributeNameLocal4" select="@n"/>
	<xsl:attribute name="n"><xsl:value-of select="$attributeNameLocal4"/></xsl:attribute>
	  <xsl:for-each select="SRMString">
	     <xsl:element name="SRMString">
	     <xsl:variable name="attributeNameLocal5" select="@n"/>
	     <xsl:attribute name="n"><xsl:value-of select="$attributeNameLocal5"/></xsl:attribute>
             <xsl:variable name="attributeNameLocal6" select="@value"/>
	     <xsl:attribute name="value"><xsl:value-of select="$attributeNameLocal6"/></xsl:attribute>
              </xsl:element>
          </xsl:for-each>
 
 
 
 
 </xsl:element>
  </xsl:for-each>
 </xsl:element>
 </xsl:for-each>
 </xsl:element>
 </xsl:for-each>
</xsl:template>	


<xsl:template name="merge" >
<xsl:param name="attributeValue" />
<xsl:param name="position" />
<xsl:param name="uniqueID" />


<xsl:for-each select="/SRM/SRMData/SRMComposite">

<xsl:for-each select="SRMRow">


      <xsl:variable name="positionofSRMROW" select="position()"/>           
                 
                    <xsl:if test="$position>$positionofSRMROW">
                 	<xsl:for-each select="Z"> 
                 	     <xsl:if test="@n=$uniqueID">
                 	          <xsl:choose>
                 	          <xsl:when test="current()=$attributeValue">T</xsl:when>
                 	           <xsl:otherwise>F</xsl:otherwise> 
                 	           </xsl:choose>
                             </xsl:if>                       	
                 	</xsl:for-each>
                    </xsl:if>
                 	
                 	
               
               
</xsl:for-each>
</xsl:for-each>
</xsl:template>	


<xsl:template name="merge2" >
<xsl:param name="position" />
<xsl:param name="childClass" />
<xsl:for-each select="/SRM/SRMData/SRMComposite">
 <xsl:for-each select="SRMRow">
   <xsl:if test="$position=position()">
         <xsl:element name="AccountBO.Address">
	 	  
	 		<xsl:for-each select="Z">
	 			
	 			<xsl:if test="contains(@n,$childClass)">
	                                <xsl:variable name="element2" select="@n"/>
	 				<xsl:element name="{$element2}">
	 					
	 					<xsl:value-of select="current()"/>
	 				</xsl:element>
	 
	 			</xsl:if>
	 			
	 		</xsl:for-each>
	</xsl:element>
   </xsl:if>
 </xsl:for-each>
</xsl:for-each>
</xsl:template>	






<xsl:template name="merge3" >
<xsl:param name="position" />
<xsl:param name="attributeValue" />
<xsl:param name="uniqueID" />
<xsl:param name="childClass" />

<xsl:for-each select="/SRM/SRMData/SRMComposite">
	<xsl:for-each select="SRMRow">
	  <xsl:variable name="pos" select="position()"/>
	     <xsl:if test="position()>$position"> 
		
		
         <xsl:variable name="select1">
		   <xsl:for-each select="Z">
			   <xsl:if test="@n=$uniqueID"> 
			       <xsl:if test="current()=$attributeValue">T</xsl:if> 
			   </xsl:if>   
		      </xsl:for-each>
		    
          </xsl:variable>
		
		
		
	
		
		<xsl:for-each select="Z">
			
			<xsl:if test="$select1='T'">
			
			
			
			<xsl:if test="position()=last()">
			
			<xsl:call-template name="merge2">
			<xsl:with-param name="position" select="$pos" />
			<xsl:with-param name="childClass" select="$childClass" />
			</xsl:call-template>
				
			</xsl:if>
			</xsl:if>
			
		
		</xsl:for-each>
	     </xsl:if>
	</xsl:for-each>
</xsl:for-each>	
	
</xsl:template>




	
</xsl:stylesheet>



function fnNullifyDummyCustFlds(isDummy){

	if((isDummy == 'Y' && TabValidator.indexOf('Corp_Customer_GE=Y') == "-1") || (ModIsDummy != 'N' && trim(ModIsDummy) != "")){
		// Changes for TOL 677906 starts
		document.all.ConcessionRecordSet.deleteRow(2);
		// Changes for TOL 677906 ends
		//Changes for call id 313962 STARTS
		document.getElementsByName("Cat_CorporateBO.primary_Service_Center")[0].value = '';
		document.getElementsByName("Cat_CorporateBO.segment")[0].value = '';
		document.getElementsByName("CorporateBO.segment")[0].value = '';
		document.getElementsByName("Cat_CorporateBO.Crncy_code")[0].value = '';
		document.getElementsByName("CorporateBO.Crncy_code")[0].value = '';
		//Changes for call id 313962 ENDS
		document.getElementsByName("CorporateBO.corporate_Name")[0].value = '';
		document.getElementsByName("CorporateBO.short_Name")[0].value = '';
		document.getElementsByName(boName+".Status_Desc")[0].value = '';
		//Changes for call id 313962 STARTS
		//document.getElementsByName(boName+".segment")[0].value = '';
		//Changes for call id 313962 ENDS
		document.getElementsByName(boName+".subSegment")[0].value = '';
		document.getElementsByName(boName+".priority")[0].value = '';
		document.getElementsByName(boName+".trade_Services_Availed")[0].value = '';
		document.getElementsByName("3_CorporateBO.date_Of_Incorporation")[0].value = '';
		document.getElementsByName(boName+".subSector")[0].value = '';
		//Changes for call id 313962 STARTS
		//document.getElementsByName(boName+".Crncy_Code")[0].value = '';
		//Changes for call id 313962 ENDS
		// Changes for TOL 677906 starts
		// document.getElementsByName(boName+".str6")[0].value = '';
		// Changes for TOL 677906 ends
		document.getElementsByName(boName+".Cust_Grp_Desc")[0].value = '';
		document.getElementsByName("CorporateBO.Line_of_Activity_Desc")[0].value = '';
		document.getElementsByName("CorporateBO.relationship_CreatedBy")[0].value = '';
		
		if(boName=="CorporateBO"){
			document.getElementsByName(boName+".Health_Desc")[0].value = '';
			document.getElementsByName(boName+".Tds_Tbl_Desc")[0].value = '';
		}else
		{
			document.getElementsByName(boName+".health_Desc")[0].value = '';
			document.getElementsByName(boName+".tds_Tbl_Desc")[0].value = '';
		}
		document.getElementsByName("CorporateBO.Cust_Swift_Code_Desc")[0].value = '';
		document.getElementsByName(boName+".Is_Swift_Code_of_Bank")[0].value = '';
		document.getElementsByName(boName+".Cust_Type_Desc")[0].value = '';
		// Changes for TOL 677906 starts
		if (document.getElementsByName(boName+".str6")[0])
			document.getElementsByName(boName+".str6")[0].value = '';
		// Changes for TOL 677906 ends
	}

}

function clearDummyAddress(isDummy){

	if((isDummy == 'Y' && TabValidator.indexOf('Corp_Customer_GE=Y') == "-1") || (ModIsDummy != 'N' && trim(ModIsDummy) != "")){

		for (i=0; i < document.all.AdrRecordSet.rows.length ; i++){
			if(i>1){
			<!-- Tracker ID :756914 - Chrome Porting Changes -->
			EduDetURL = document.all.AdrRecordSet.rows[i].getAttribute(boName+".Address.url_");
			noOfAttachURLs = adr_URL.length;
			var deleteAlreadyExistingEduDet = true;
			for(r=0; r< noOfAttachURLs; r++) {
				if(adr_URL[r] == EduDetURL){
					if(adr_Status[r] != "New") {
					    deleteAlreadyExistingEduDet = false;
					}				
					adr_URL[r] = null;
					ad_address_type[r]=null;
					adr_Status[r] = "Remove";
					addrID = ad_addrID[r];
					break;
				    }
				}
				document.all.AdrRecordSet.deleteRow(i);
				if( (EduDetURL == null) || (EduDetURL == 'undefined')) {
				    EduDetURL= "";
				}
				if(deleteAlreadyExistingEduDet) {
				    adr_detachedURLs[adr_detachedURLs.length] = addrID;
				}
			}
		}
	}
}



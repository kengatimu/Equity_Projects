// CRM61SR:SRCIUICU :TRACKER# 44233 **BEGIN OF CHANGES

function customSave() {
}

function customSaveAccount(){
}

// CRM61SR:SRCIUICU :TRACKER# 44233 **END OF CHANGES

// CRM10CIF-  changes start

	var Male =['Mr.','Sir','MR','FR','GEN','HISEX','HISW'];
	var Female = ['Mrs.','Miss','Madam','Ms.','MISS','MRS','HEREX','HERW','MS.','SR']; 
	
function fnNullifyDummyCustFlds(isDummy){

	if((isDummy == 'Y' && TabValidator.indexOf('Retail_Customer_GE=Y') == "-1") || (ModIsDummy != 'N' && trim(ModIsDummy) != "")){
		//Changes for call id 313962 STARTS
		document.getElementsByName("Cat_AccountBO.Primary_sol_id")[0].value = '';
		document.all.CurrencyDetRecordSet.deleteRow(2);
		//Changes for call id 313962 ENDS
		document.getElementsByName("AccountBO.Cust_Last_Name")[0].value = '';
		document.getElementsByName("AccountBO.PreferredName")[0].value = '';
		document.getElementsByName(boName+".StaffFlag")[0].value = '';
		document.getElementsByName(boName+".CustomerNREFlg")[0].value = '';
		document.getElementsByName(boName+".CustomerMinor")[0].value = '';
		document.getElementsByName("3_AccountBO.RelationshipOpeningDate")[0].value = '';
		//document.getElementsByName("AccountBO.primary_service_centre")[0].value = '';
		document.getElementsByName("AccountBO.Primary_sol_id")[0].value = '';
		document.getElementsByName("AccountBO.short_name")[0].value = '';
		document.getElementsByName(boName+".Salutation")[0].value = '';
		document.getElementsByName(boName+".Gender")[0].value = '';
		/*recon for Call Id:380528 Start*/
		document.getElementsByName(boName+".Cust_DOB")[0].value = '';
		document.getElementsByName("AccountBO.Name")[0].value = '';
		/*recon for Call Id:380528 End*/
		document.getElementsByName(boName+".Cust_Type")[0].value = '';
		document.getElementsByName(boName+".Cust_hlth")[0].value = '';
		document.getElementsByName(boName+".status")[0].value = '';
		document.getElementsByName(boName+".Tds_tbl")[0].value = '';
		document.getElementsByName(boName+".Sector")[0].value = '';
		document.getElementsByName(boName+".Subsector")[0].value = '';
		document.getElementsByName(boName+".NativeLangTitle")[0].value = '';
		document.getElementsByName(boName+".Introd_Status")[0].value = '';
		document.getElementsByName(boName+".IntroducerSalutation")[0].value = '';
	}

}

function clearDummyAddress(isDummy){

	if((isDummy == 'Y' && TabValidator.indexOf('Retail_Customer_GE=Y') == "-1") || (ModIsDummy != 'N' && trim(ModIsDummy) != "")){

		for (i=0; i < document.all.RecordSet.rows.length ; i++){
			if(i>1){
			EduDetURL = document.all.RecordSet.rows(i).getAttribute(boName+".Address.url_");
			noOfAttachURLs = edu_URL.length;
			var deleteAlreadyExistingEduDet = true;
			for(r=0; r< noOfAttachURLs; r++) {
				if(edu_URL[r] == EduDetURL){
					if(edu_Status[r] != "New") {
					    deleteAlreadyExistingEduDet = false;
					}				
					edu_URL[r] = null;
					ad_address_type[r]=null;
					edu_Status[r] = "Remove";
					addrID = ad_addrID[r];
					break;
				    }
				}
				document.all.RecordSet.deleteRow(i);
				if( (EduDetURL == null) || (EduDetURL == 'undefined')) {
				    EduDetURL= "";
				}
				if(deleteAlreadyExistingEduDet) {
				    edu_detachedURLs[edu_detachedURLs.length] = addrID;
				}
			}
		}
	}	
}

// CRM10CIF- changes end






var ad_addrID           = new Array();
var ad_address_type     = new Array();
var ad_houseno          = new Array();
var ad_premiseno        = new Array();
var ad_end_date         = new Array();
var ad_LastUpdate_Date  = new Array();
var ad_LastUpdate_Flag  = new Array();
var ad_start_date       = new Array();
var ad_state            = new Array();
var ad_state_cat        = new Array();
var ad_city             = new Array();
var ad_city_cat         = new Array();
var ad_zip              = new Array();
//Equity bank DRC  CGCR19 changes start
var ad_Region             = new Array();
//Equity bank DRC  CGCR19 changes end

var ad_country          = new Array();
var ad_country_cat      = new Array();
var ad_building         = new Array();
var adr_detachedURLs    = new Array();
var adr_Status          = new Array();
var ad_streetno         = new Array();
var ad_town	            = new Array();
var ad_domicile         = new Array();
var ad_locality	    = new Array();
var ad_website	    = new Array();
var ad_mailstop	    = new Array();
var ad_streetname	    = new Array();
var ad_suburb	    = new Array();
var ad_extension	    = new Array();
var ad_IsAddressProofRcvd = new Array();
var adr_URL             = new Array();
var ad_PreferredFormat = new Array();
var ad_HoldMailReason = new Array();
var ad_BusinessCenter = new Array();
var ad_HoldMailInitiatedBy = new Array();
var ad_HoldMailFlag = new Array();
var ad_AddressLine1 = new Array();
var ad_AddressLine2 = new Array();
var ad_AddressLine3 = new Array();
var ad_FreeTextLabel = new Array();
var ad_swiftcode = new Array();
var ad_PhoneOrEmail = new Array();
var ad_PhoneNo = new Array();
var ad_PhoneNoCountryCode = new Array();
var ad_PhoneNoCityCode = new Array();
var ad_PhoneNoLocalCode = new Array();
var ad_PhoneEmailType = new Array();
var ad_PhoneEmailID = new Array();
var ad_Email = new Array();
var phoneEmail_URL = new Array();
var phoneEmail_Status = new Array();
var phone_detachedURLs = new Array();
var escChars = new Array(',');
var escChars1 = new Array('@');

/*Tracker 159095 : Sonali begin of changes*/
var escCharsAddr = new Array('%');
/*Tracker 159095 : Sonali end of changes*/

var updateEduDet = false;
var editMode = false;
var adrWindow = null;
var recordIndex = null;
var phoneRecordIndex = null;
var emailRecordIndex = null;
var servletURL = null;
var name = "";
try {
	var selTabId = parent.parent.parent.parent.frames(0).getSelectedTabId();
} catch(e) {
}
var lookupFor = '';
function sortList(recordSetName){
var temp = new Array();
temp=LastUpdate_Date.split(",");
	var addrDetails = new Array();
	var addressId = '';
	var deleteFlag = false;
	var previousRowDeleted = false;
	var previousAddressType = "";
	var noOfAddressCount = eval('document.all.'+recordSetName).rows.length;
				// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
			for(k=0 ; k < noOfAddressCount ; k++)
			{
				addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("CorporateBO.Address.addressCategory"));
				arr_AddressType = new Array();
				arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("CorporateBO.Address.AddressCategory"));
				arr_AddressType[1] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.house_no"));
				arr_AddressType[2] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.premise_name"));
				arr_AddressType[3] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.End_Date"));
				arr_AddressType[4] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.Start_Date"));
				arr_AddressType[5] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.city"));
				arr_AddressType[6] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.country"));
				arr_AddressType[7] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.state"));
				arr_AddressType[8] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.zip"));
				arr_AddressType[9] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.building_level"));
				addressId = document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.addressID");
				arr_AddressType[10]= trim(''+addressId);
				arr_AddressType[11] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.street_no"));
				arr_AddressType[12] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.locality_name"));
				arr_AddressType[13] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.town"));
				arr_AddressType[14] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.domicile"));
				arr_AddressType[15] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.street_name"));
				arr_AddressType[16] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.suburb"));
				arr_AddressType[17] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.City_code"));
				arr_AddressType[18] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.State_code"));
				arr_AddressType[19] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.Country_code"));
				arr_AddressType[20] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.PreferredFormat"));
				arr_AddressType[21] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.HoldMailReason"));
				arr_AddressType[22] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.BusinessCenter"));
				arr_AddressType[23] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.HoldMailInitiatedBy"));
				arr_AddressType[24] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.HoldMailFlag"));
				arr_AddressType[25] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.Address_Line1"));
				arr_AddressType[26] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.Address_Line2"));
				arr_AddressType[27] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.Address_Line3"));
				arr_AddressType[28] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.FreeTextLabel"));
				arr_AddressType[29] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.mailStop"));
				arr_AddressType[30] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.URL"));
				arr_AddressType[31] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.Swift_Code"));
				arr_AddressType[32] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateBO.Address.city"));
				arr_AddressType[33] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateBO.Address.state"));
				arr_AddressType[34] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateBO.Address.country"));
				arr_AddressType[35] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.LastUpdate_Date"));
				arr_AddressType[36] ='N';
				arr_AddressType[38] =trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.IsAddressProofRcvd"));
				arr_AddressType[39] =trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.Swift_Name"));
				/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				arr_AddressType[40] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.IsAddressVerified"));
// changes for Tracker ID 456637 - TOL ID 455246
				arr_AddressType[41] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateBO.Address.AddressCategory"));
// changes for Tracker ID 456637 - TOL ID 455246
				/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
				//Equity bank DRC  CGCR19 changes start
				arr_AddressType[45] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.userField1"));
				//Equity bank DRC  CGCR19 changes end

				if(addressType != previousAddressType)
				{
					reOrder(addrDetails);
					previousAddressType = addressType;
					addrDetails = new Array();
					addrDetails[k] = arr_AddressType;
				}
				else
				{
					addrDetails[k] = arr_AddressType;
				}
				if((k+1) > noOfAddressCount-1)
				{
					reOrder(addrDetails);
				}
			}//end of for loop
            	}
            	else if(boName=='CorporateModBO'){
			for(k=0 ; k < noOfAddressCount ; k++)
			{
				addressType = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("CorporateModBO.Address.addressCategory"));
				arr_AddressType = new Array();
				arr_AddressType[0] = trim(''+eval('document.all.'+recordSetName).rows(k).getAttribute("CorporateModBO.Address.AddressCategory"));
				arr_AddressType[1] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.house_no"));
				arr_AddressType[2] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.premise_name"));
				arr_AddressType[3] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.End_Date"));
				arr_AddressType[4] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.Start_Date"));
				arr_AddressType[5] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.city"));
				arr_AddressType[6] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.country"));
				arr_AddressType[7] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.state"));
				arr_AddressType[8] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.zip"));
			
				arr_AddressType[9] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.building_level"));
				addressId = document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.addressID");
				
				arr_AddressType[10]= trim(''+addressId);
				arr_AddressType[11] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.street_no"));
				arr_AddressType[12] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.locality_name"));
				arr_AddressType[13] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.town"));
				arr_AddressType[14] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.domicile"));
				arr_AddressType[15] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.street_name"));
				arr_AddressType[16] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.suburb"));
				arr_AddressType[17] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.City_code"));
				arr_AddressType[18] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.State_code"));
				arr_AddressType[19] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.Country_code"));
				arr_AddressType[20] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.PreferredFormat"));
				arr_AddressType[21] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.HoldMailReason"));
				arr_AddressType[22] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.BusinessCenter"));
				arr_AddressType[23] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.HoldMailInitiatedBy"));
				arr_AddressType[24] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.HoldMailFlag"));
				arr_AddressType[25] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.Address_Line1"));
				
				arr_AddressType[26] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.Address_Line2"));
				arr_AddressType[27] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.Address_Line3"));
				arr_AddressType[28] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.FreeTextLabel"));
				arr_AddressType[29] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.mailStop"));
				arr_AddressType[30] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.URL"));
				arr_AddressType[31] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.Swift_Code"));
				arr_AddressType[32] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateModBO.Address.city"));
				arr_AddressType[33] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateModBO.Address.state"));
				arr_AddressType[34] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateModBO.Address.country"));
				arr_AddressType[35] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.LastUpdate_Date"));
				arr_AddressType[36] ='N';
				arr_AddressType[38] =trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.IsAddressProofRcvd"));
				arr_AddressType[39] =trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.Swift_Name"));
				/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x begin*/
				arr_AddressType[40] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.IsAddressVerified"));
// changes for Tracker ID 456637 - TOL ID 455246
				arr_AddressType[41] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("Cat_CorporateModBO.Address.AddressCategory"));
// changes for Tracker ID 456637 - TOL ID 455246
				/*Tracker Id: 267465, Changes for PAF enhancement from 10.3.x end*/
				//Equity bank DRC  CGCR19 changes start
				arr_AddressType[45] = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.userField1"));
				//Equity bank DRC  CGCR19 changes end
				if(addressType != previousAddressType)
				{
					reOrder(addrDetails);
					previousAddressType = addressType;
					addrDetails = new Array();
					addrDetails[k] = arr_AddressType;
				}
				else
				{
					addrDetails[k] = arr_AddressType;
				}
				if((k+1) > noOfAddressCount-1)
				{
					reOrder(addrDetails);
				}
			}//end of for loop
            	}
			// Tracker ID: 135125: XMLEncoding Changes ENDS
}
function reOrder(addrDetails)
{
	previousFilled = false;
	currentAddrFound = false;
	var date = getTodayDate();
	currentDate = changetoMillis(date);
	currentArrayLength = globalAddrDetails.length;
	if(addrDetails != null && addrDetails != '')
	{
		for(i=0 ; i < addrDetails.length; i++)
		{
			if(addrDetails[i] != null && addrDetails[i] != undefined)
			{
				tempArr = new Array(addrDetails[i]);
				if(tempArr[0][4] != 'null' && tempArr[0][4] != 'undefined')
				{
					dateFromList = changetoMillis(tempArr[0][4]);//getting Start Date from array
					endDateFromList = changetoMillis(tempArr[0][3]);//getting End Date from array
					if(dateFromList <= currentDate && endDateFromList >= currentDate && !currentAddrFound) //currentAddress is not found
					{
//						globalAddrDetails[currentArrayLength] = addrDetails[i];
						if(!previousFilled)
						{
							globalAddrDetails[globalAddrDetails.length] = addrDetails[i];
						}
						else
						{
							globalAddrDetails[tempPos] = addrDetails[i];
						}
						previousFilled = true;
						currentAddrFound = true;
					}
					else
					{
						if(!previousFilled)
						{
							tempPos = globalAddrDetails.length;
							globalAddrDetails[globalAddrDetails.length] = '';
							globalAddrDetails[globalAddrDetails.length] = addrDetails[i];
						}
						else
						{
							globalAddrDetails[globalAddrDetails.length] = addrDetails[i];
						}
						previousFilled = true;
					}
				}
			}
		}//end of for loop
	}
}
function addAddressList()
{
	var currentAddressType = "";
	var clientCurrentDate = getTodayDate();
	clientCurrentDate = changetoMillis(clientCurrentDate);
	if(globalAddrDetails != '')
	{
	for(i=0; i < globalAddrDetails.length; i++)
	{
			if(globalAddrDetails[i] != 'undefined' && globalAddrDetails[i] != null && globalAddrDetails[i] != '')
		{
			addAddrDetails(globalAddrDetails[i],true);
				if(globalAddrDetails[i][0] != currentAddressType && changetoMillis(globalAddrDetails[i][4]) <= clientCurrentDate  && changetoMillis(globalAddrDetails[i][3]) >= clientCurrentDate)
				{
					if(document.all.AdrRecordSet.rows(i+2) != undefined)
			{
                document.all.AdrRecordSet.rows(i+2).className = 'color3';
				currentAddressType = globalAddrDetails[i][0];
			}
					else
					{
						/*Fix Start for Ticket : 253226 */
						try
						{
							document.all.AdrRecordSet.rows(i+1).className = 'color3';
						}
						catch(e)
						{
						}
						/* Fix End for Ticket : 253226 */
						currentAddressType = globalAddrDetails[i][0];
					}
				}
			}
		}//end of for
	}
}
function deleteList(recordSetName)
{
	var noOfAddressCount = document.all.AdrRecordSet.rows.length;
				// Tracker ID: 135125: XMLEncoding Changes STARTS
            	if(boName=='CorporateBO'){
			for(k = noOfAddressCount-1 ; k > 1 ; k--)
			{
				addrCat = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateBO.Address.AddressCategory"));
				if(addrCat != null && addrCat != 'undefined')
				{
					document.all.AdrRecordSet.deleteRow(k);
				}
			}
            	}
            	else if(boName=='CorporateModBO'){
			for(k = noOfAddressCount-1 ; k > 1 ; k--)
			{
				addrCat = trim(''+document.all.AdrRecordSet.rows(k).getAttribute("CorporateModBO.Address.AddressCategory"));
				if(addrCat != null && addrCat != 'undefined')
				{
					document.all.AdrRecordSet.deleteRow(k);
				}
			}
           	
            	}
				// Tracker ID: 135125: XMLEncoding Changes ENDS
}
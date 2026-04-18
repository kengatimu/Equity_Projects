//new custom file created for Equity bank DCR,Customization changes CGCR19
function fnCustomCallonLocationSelect(categoryFld, lookupVals, check,lookupText){
	if(categoryFld == 'AccountBO.Address.country'){

	if (lookupVals == null || lookupVals.length == 0) return;
	countryVal= lookupVals[0];
	if (countryVal != 'CD'){
		document.getElementsByName('Cat_AccountBO.Address.state')[0].value='FOREIGNER';
		document.getElementsByName('AccountBO.Address.state')[0].value='FOR';
		document.getElementsByName('Cat_AccountBO.Address.city')[0].value='FOREIGNER';
		document.getElementsByName('AccountBO.Address.city')[0].value='047';
		document.getElementsByName('Cat_AccountBO.Address.userField1')[0].value='FOREIGNER';
		document.getElementsByName('AccountBO.Address.userField1')[0].value='FOR';
		document.getElementsByName('AccountBO.Address.city')[0].disabled = true;
		document.getElementsByName('Cat_AccountBO.Address.city')[0].disabled = true;
		document.getElementsByName('btnone_AccountBO.Address.city')[0].disabled = true;
		document.getElementsByName('btntwo_AccountBO.Address.city')[0].disabled = true;
		document.getElementsByName('AccountBO.Address.state')[0].disabled = true;
		document.getElementsByName('Cat_AccountBO.Address.state')[0].disabled = true;
		document.getElementsByName('btnone_AccountBO.Address.state')[0].disabled = true;
		document.getElementsByName('btntwo_AccountBO.Address.state')[0].disabled = true;
		document.getElementsByName('AccountBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('Cat_AccountBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('btnone_AccountBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('btntwo_AccountBO.Address.userField1')[0].disabled = true;
		//document.getElementsByName('AccountBO.Address.userField6')[0].disabled = false;
	}
	else{
		document.getElementsByName('Cat_AccountBO.Address.state')[0].value='';
		document.getElementsByName('AccountBO.Address.state')[0].value='';
		document.getElementsByName('Cat_AccountBO.Address.city')[0].value='';
		document.getElementsByName('AccountBO.Address.city')[0].value='';
		document.getElementsByName('Cat_AccountBO.Address.userField1')[0].value='';
		document.getElementsByName('AccountBO.Address.userField1')[0].value='';
		document.getElementsByName('AccountBO.Address.city')[0].disabled = false;
		document.getElementsByName('Cat_AccountBO.Address.city')[0].disabled = false;
		document.getElementsByName('btnone_AccountBO.Address.city')[0].disabled = false;
		document.getElementsByName('btntwo_AccountBO.Address.city')[0].disabled = false;
		document.getElementsByName('AccountBO.Address.state')[0].disabled = false;
		document.getElementsByName('Cat_AccountBO.Address.state')[0].disabled = false;
		document.getElementsByName('btnone_AccountBO.Address.state')[0].disabled = false;
		document.getElementsByName('btntwo_AccountBO.Address.state')[0].disabled = false;
		document.getElementsByName('AccountBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('Cat_AccountBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('btnone_AccountBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('btntwo_AccountBO.Address.userField1')[0].disabled = false;
		//document.getElementsByName('AccountBO.Address.userField6')[0].disabled = true;
	}
	}
	
	if(categoryFld == 'CorporateBO.Address.country'){

	if (lookupVals == null || lookupVals.length == 0) return;
	countryVal= lookupVals[0];
	if (countryVal != 'CD'){
		document.getElementsByName('Cat_CorporateBO.Address.state')[0].value='FOREIGNER';
		document.getElementsByName('CorporateBO.Address.state')[0].value='FOR';
		document.getElementsByName('Cat_CorporateBO.Address.city')[0].value='FOREIGNER';
		document.getElementsByName('CorporateBO.Address.city')[0].value='047';
		document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].value='FOREIGNER';
		document.getElementsByName('CorporateBO.Address.userField1')[0].value='FOR';
		document.getElementsByName('CorporateBO.Address.city')[0].disabled = true;
		document.getElementsByName('Cat_CorporateBO.Address.city')[0].disabled = true;
		document.getElementsByName('btnone_CorporateBO.Address.city')[0].disabled = true;
		document.getElementsByName('btntwo_CorporateBO.Address.city')[0].disabled = true;
		document.getElementsByName('CorporateBO.Address.state')[0].disabled = true;
		document.getElementsByName('Cat_CorporateBO.Address.state')[0].disabled = true;
		document.getElementsByName('btnone_CorporateBO.Address.state')[0].disabled = true;
		document.getElementsByName('btntwo_CorporateBO.Address.state')[0].disabled = true;
		document.getElementsByName('CorporateBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('btnone_CorporateBO.Address.userField1')[0].disabled = true;
		document.getElementsByName('btntwo_CorporateBO.Address.userField1')[0].disabled = true;
	}
	else{
		document.getElementsByName('Cat_CorporateBO.Address.state')[0].value='';
		document.getElementsByName('CorporateBO.Address.state')[0].value='';
		document.getElementsByName('Cat_CorporateBO.Address.city')[0].value='';
		document.getElementsByName('CorporateBO.Address.city')[0].value='';
		document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].value='';
		document.getElementsByName('CorporateBO.Address.userField1')[0].value='';
		document.getElementsByName('CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('Cat_CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('btnone_CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('btntwo_CorporateBO.Address.city')[0].disabled = false;
		document.getElementsByName('CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('Cat_CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('btnone_CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('btntwo_CorporateBO.Address.state')[0].disabled = false;
		document.getElementsByName('CorporateBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('Cat_CorporateBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('btnone_CorporateBO.Address.userField1')[0].disabled = false;
		document.getElementsByName('btntwo_CorporateBO.Address.userField1')[0].disabled = false;
	}
	}
}
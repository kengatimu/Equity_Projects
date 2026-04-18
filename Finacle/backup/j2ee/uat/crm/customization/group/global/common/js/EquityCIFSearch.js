document.write('<script language="javascript" src="../common/html/Rendvalidate.js"></script>');

function validate_Retail()
{
	
	try{
	alert("The CIF entered is Corporate CIF.");
	   var titleText = "";
        if(parent.parent.parent.ScreenTitleFrm){
            parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt; Corp Accounts";
        }else if(parent.parent.parent.parent.ScreenTitleFrm){
             parent.parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt; Corp Accounts";
        }else if(parent.parent.parent.parent.parent.ScreenTitleFrm){
           parent.parent.parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt; Corp Accounts";
        }else{
            parent.parent.parent.parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt; Corp Accounts";
        }
	

//360 Degrees View &gt; Accounts//43000057232//  43000737211


	parent.parent.window.location.href='../servlet/com.infy.cis.ui.searchconsole.SearchWorkArea?BOName=CorporateBO&amp;ViewName=CorpAccountsSearch';
	//window.open('../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?BOName=CorporateBO&amp;ViewName=CorpAccountsSearch','_self');
	}catch(e)
	{
	//alert("ERROR: "+e.message);
	}
}
function validate_corp()
{
	alert("The CIF entered is Retail CIF.");
	
		   var titleText = "";
        if(parent.parent.parent.ScreenTitleFrm){
            parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt;  Accounts";
        }else if(parent.parent.parent.parent.ScreenTitleFrm){
             parent.parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt;  Accounts";
        }else if(parent.parent.parent.parent.parent.ScreenTitleFrm){
           parent.parent.parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt;  Accounts";
        }else{
            parent.parent.parent.parent.parent.parent.ScreenTitleFrm.titleMsg.innerHTML="360 Degrees View &gt;  Accounts";
        }
	
	
	//alert("parent.parent.window.location.href"+parent.parent.window.location.href);	
	
	parent.parent.window.location.href='../servlet/com.infy.cis.ui.searchconsole.SearchWorkArea?BOName=BankAccountBO&amp;ViewName=BankAccount_Search';
	//window.open('../servlet/com.infy.cis.ui.cif.QDECustomerAddressForm_Det?BOName=CorporateBO&amp;ViewName=CorpAccountsSearch','_self');
}
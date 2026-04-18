  function showSVS(){
		
		
		var cifID = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str49")[0].value;
		
  	var cifType = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.str9")[0].value; 
	  var entType = document.getElementsByName("CorporateBO.CorpMiscellaneousInfo.entityType")[0].value;
	  alert("cifType"+cifType+entType+cifID);
	  if(cifType=='Retail' && entType=='CUSTOMER' ){
	
		var urlWithBioInp=
		applPath+"/Customization/43/BioModal.jsp?IDDtls=C|NA|43|"+cifID;
			
		//var urlWithBioInp="https://finbpd01.ebsafrica.com:34567/finbranch/BioModal.jsp?IDDtls=C|NA|54|RET0000132|UBSADMIN54&rtId=1d5fza0p9ug01&isPopUp=Y";
		var params = "center:yes;unadorned:yes;resizable:no;dialogHeight:400px;dialogWidth:600px;scrollbars=no";
		var bioResp = window.showModalDialog(urlWithBioInp,"",params);
		alert("bioResp"+bioResp);
		
		if (bioResp == undefined) {
                        alert("Biometric validation Cancelled");
						//clear related fields
						clearBankEntity();
		}
		else if (bioResp != undefined) {
                        var aResult = bioResp.split("|");
                        if (aResult[1] == "Y") {
						alert("Bio validation successful");
                          
                        }
                        if (aResult[1] != "Y")  {
                            alert("Biometric validation failed");
							//clear related fields
							clearBankEntity();
                         
                        }
                    }
		
		}
  }

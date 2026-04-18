<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : imcdtl_custom.jsp 
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 18-01-2013
<!--Author              : Farhan 
<!--Called By           : None    
<!--Calling jsp         : None
<!--Menu Option         : HIMC
<!--Modification History:
<!--	Version No.	      Date		         Author 	       	Description
<!--	-------        	----------         -----------        ------------------
<!--     0.1	    	18-01-2013	         Farhan	           Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function fnOnLoad(){
        objForm = document.forms[0];
        fnPopulateControlValues();

        fnSetCheckboxCtrl(objForm);
        objForm.serialNo.value = serialNo;
        fnEnabledisableFlds();
        initFocusHandler();
        if (funcCode == Const.INQUIRE_MODE){
                objForm.Ok.focus();
        }
        else if (funcCode == Const.ADD_MODE || funcCode == Const.MODIFY_MODE){
                objForm.invtClass.focus();
        }
        else {
                objForm.Submit.focus();
        }
    	// added for customization
        document.forms[0].invtSrlAlpha.disabled=true;
}
function fnShowInvtClassList(){
        if (invtLocnClassFrom == invtConst.EXTERNAL_LOCATION_CLASS){
                showDynSearcher('HSRINCDL','invt_class=:invtClass|invt_type=:invtType',':invtClass=invt_class|:invtType=invt_type|:invtDesc=invt_desc');
        }
        else {
                showDynSearcher('HSRINCTL','invt_locn_class='+invtLocnClassFrom+'|invt_locn_code='+invtLocnCodeFrom+'|invt_class=:invtClass|invt_type=:invtType|sol_id=' +contextSolId+'',':invtClass=invt_class|:invtType=invt_type|:invtDesc=invt_desc|:invtSrlAlpha=invt_srl_alpha|:invtBeginSrlNum=begin_srl_num|:invtEndSrlNum=end_srl_num|: invtQty=invt_qty');
        }
    	// added for customization
        document.forms[0].invtSrlAlpha.value="";
}
</script>

<!---------------------------------------------------------------------------------------------------------------->
<!--Name              : ogminvocdet_custom.jsp
<!--Description       : This jsp default populate loan acct number fiels with operative account number field value
<!--Date              : 17-01-2013
<!--Author            : Shishira
<!--Called By         : bgff0003PreLoad.scr
<!--Calling jsp       : None
<!--Menu Option       : OGM.
<!--Modification History:
<!--    Version No.              Date           Author                                  Description
<!--    ---------               ----------      ---------------                     --------------------
<!--     0.1                    17-01-2013      Shishira                        Original version
<!--							15-07-2013		Hari Mohan Verma				
<!---------------------------------------------------------------------------------------------------------------->
<%@ include file="../commonInclude.jsp" %>
<%@ taglib uri="taglib.tld" prefix="arjsp" %>
<script language="javascript" src= "../../custom/javascripts/custom_functions.js"></script>
<script type="text/javascript">
function post_ONLOAD(obj) {
        
	objForm = document.forms[0];
	if(objForm.loanacid.value == null || objForm.loanacid.value == ""){
	//objForm.loanacid.value = objForm.operativeacid.value
	}
}
</script>

<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : emmgendet_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 18-01-2013
<!--Author              : Farhan
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HEMM
<!--Modification History:
<!--    Version No.          Date                 Author              Description
<!--    ---------          ----------           -----------          --------------
<!--     0.1               18-01-2013             Farhan            Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function emmgendet_pre_ONCLICK()
{
        if((funcCode == "A") || (funcCode == "C") || (funcCode == "M")){
               var emp1 = document.forms[0].empName.value;
               if(emp1.length >= 41)
               {
                     alert ("The Employer name can not be more than 40 characters");
                     return false;
               }
       }
}
</script>


<!---------------------------------------------------------------------------------------------------------------->
<!--Name                : emmcrit_custom.jsp
<!--Description         : This file should reside in finbranch/custom/jsp folder.
<!--Date                : 18-01-2013
<!--Author              : Farhan
<!--Called By           : NA
<!--Calling jsp         : NA
<!--Menu Option         : HEMM
<!--Modification History:
<!--    Version No.           Date                 Author                Description
<!--    ---------           ----------            ----------          -----------------
<!--     0.1                18-01-2013             Farhan              Original version
<!---------------------------------------------------------------------------------------------------------------->
<script type="text/javascript">
function emmcrit_pre_ONCLICK()
{
        if(document.forms[0].funcCode.value == "A"){
                var emp = document.forms[0].empId.value;
                if(emp.length >= 11)
                {
                        alert("The Employer Id can not be more than 10 characters");
                        return false;
                }
        }
        if(document.forms[0].funcCode.value == "C"){
        var emp2 = document.forms[0].toEmpId.value;
                if(emp2.length >= 11)
                {
                        alert("The To Employer Id can not be more than 10 characters");
                        return false;
                }
        }
}
</script>


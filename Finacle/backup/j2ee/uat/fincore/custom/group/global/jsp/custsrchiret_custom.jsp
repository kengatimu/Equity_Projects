<!----------------------------------------------------------------------------------------------------->
<!--Name                : custsrchiret_custom.jsp
<!--Description         : 
<!--Date                : 
<!--Author              : 
<!--Called By           : None
<!--Calling jsp         : None
<!--Menu Option         : HCRV
<!--Modification History:
<!--    Version No.           Date                       Author             Description
<!--    -------              ----------                 -----------        ------------------
<!--     0.1                 **-**-2025
<!------------------------------------------------------------------------------------------------------>
<script language="javascript" src="../Renderer/custom/javascripts/session.js">
</script>
<script type="text/javascript">

function custsrchiret_pre_ONLOAD(obj)
{
    if(profileId == "43")
    {
        var labels = document.getElementsByTagName("td");
        for (var i = 0; i < labels.length; i++) {
            var td = labels[i];

            // Only target cells that hold labels (textlabel class)
            if (td.className && td.className.indexOf("textlabel") !== -1) {
                var txt = td.innerText || td.textContent;
				//Address label renaming to State/commune
                if (txt && txt.indexOf("Address Line 1") !== -1) {
                    td.innerHTML = td.innerHTML.replace(/Address Line 1/g, "House no/street name");
                }
				//State label renaming to House no/street name
                if (txt && txt.indexOf("State") !== -1) {
                    td.innerHTML = td.innerHTML.replace(/State/g, "State/commune");
                }
            }
        }
		
		//Address Line 1 label renaming to House no/street name
		document.forms[0].innerHTML = document.forms[0].innerHTML.replace('Address Line 1','House no/street name');
		//State label renaming to State/commune
		document.forms[0].innerHTML = document.forms[0].innerHTML.replace('State','State/commune');
    }
}

</script>
<script language="javascript" src="../../javascripts/common_functions.js" > </script>
<script language="javascript" src="../Renderer/custom/javascripts/custom_functions.js" ></script>

<script language="javascript">
function ogmamenddet_post_ONLOAD() {
        if (mopId == "OGM") {
                if (funcCode == "U") {
                        if (document.forms[0].amendStatus.value == "") {
                                document.forms[0].amendStatus.value = "A";
                        }
                }
        }
}
</script>

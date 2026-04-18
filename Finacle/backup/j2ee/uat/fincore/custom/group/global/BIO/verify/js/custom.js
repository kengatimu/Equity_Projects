document.getElementById("print").src="images/fingerprint.png"
function Verify(){
    alert('WORKS');
    if(document.getElementById('password').value !== "" || document.getElementById('signOnName').value !=="" ) {
        deviceInit(SuccessFunc, ErrorFunc);	
    } else {
        alert("no user/password provide");
    }
}

function ErrorFunc(status) {
            document.getElementById("print").src="images/fingerprint.png";
       swal("Check if device is connected well js");
}

function failCall(){
            document.getElementById("accountNumber").value='';
            document.getElementById("print").src="images/fingerprint.png";
    swal("Failed to process request, kindly retry");
}
function SuccessFunc(result) {
        if (result.ErrorCode == 0) {
            if (result != null && result.BMPBase64.length > 0) {
                document.getElementById("print").src = "data:image/bmp;base64," + result.BMPBase64;
                fpbuno = resp.Data.PBUNo
                console.log('pbu no ',fpbuno)
                verifyCustomer(fpbuno,result.BMPBase64)
            }
        }
        else {
            swal("Failed to capture finger print , kindly retry");
        }
}

function deviceInit(successCall, failCall) {
        var uri = "https://10.1.9.54:58379/compas-bio-api/rest/api/FINACLE";

        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                fpobject = JSON.parse(xmlhttp.responseText);
                successCall(fpobject);
            }
            else if (xmlhttp.status == 404) {
                failCall(xmlhttp.status)
            }
        }
        xmlhttp.onerror = function () {
            failCall(xmlhttp.status);
        }
        var params = "Timeout=" + encodeURIComponent("1000");
        params += "&Quality=" + encodeURIComponent("70");
        params += "&templateFormat=" + encodeURIComponent("ISO");
        xmlhttp.open("POST", uri, true);
        xmlhttp.send(params);
    }
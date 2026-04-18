<!--	This is getting executing on click of submit and validate button -->
function fnValidateData() {
		if (!fnCheckMandatoryFields())
		{
			return false;
		}
      return true;
		}
		
		




function fnDisableFormDataControls(b, f, d) {
    ADD = "A";
    POST = "P";
    COPY = "C";
    MODIFY = "M";
    VERIFY = "V";
    INQUIRY = "I";
    DELETE = "D";
    UNDELETE = "U";
    CANCEL = "X";
    REVERSAL = "E";
    CLOSE = "O";
    if (b == VERIFY || b == INQUIRY || b == DELETE || b == UNDELETE || b == CANCEL || b == REVERSAL || b == CLOSE || b == POST) {
	alert(b);
        var c = f.elements;
        var a = c.length;
        var e = arguments.length;
        if (Number(d) > 0) {
            disableHyperLnks(Number(d))
        } else {
            if (Number(d) == 0) {
                hideAnchors()
            }
        }
        for (i = 0; i < a; i++) {
            if ((c[i].type == "text") || (c[i].type == "textarea")) {
                c[i].readOnly = true;
                if (c[i].getAttribute("hotKeyId") == "LowLimit") {
                    c[i].readOnly = false
                }
            } else {
                if (c[i].type == "select-one") {
                    c[i].disabled = true
                } else {
                    if (c[i].type == "checkbox") {
                        c[i].disabled = true;
                        c[i].setAttribute("fds", "Y")
                    } else {
                        if (c[i].type == "radio") {
                            c[i].disabled = true
                        }
                    }
                }
            }
            if (f.menuName != null && f.menuName != undefined) {
                f.menuName.readOnly = false
            }
        }
        if ((f.Validate != undefined) && (f.Validate != null)) {
            f.Validate.disabled = true
        }
        if ((f.Cancel != undefined) && (f.Cancel != null)) {
            f.Cancel.disabled = true
        }
    }
    if (b != ADD && b != MODIFY && b != COPY) {
        if ((f.AddNew != undefined) && (f.AddNew != null)) {
            f.AddNew.disabled = true
        }
        if ((f.AddNewPage != undefined) && (f.AddNewPage != null)) {
            f.AddNewPage.disabled = true
        }
    }
}




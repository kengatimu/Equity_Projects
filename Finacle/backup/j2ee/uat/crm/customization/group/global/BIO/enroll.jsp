<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
  <title>Enroll FingerPrint</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/enroll.css">
  <meta http-equiv="pragma" content="no-store">
		<meta http-equiv="cache-control" content="no-store">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
  		<script type="text/javascript">
		 document.domain = "ebsafrica.com";
		</script>
	
</head>

<body onbeforeunload=fnClose()>
  <div class="card">
  <form class="form-horizontal"  >
      <div class="card-body">
        <div class="form-body">
          <h4 class="card-title" style="text-align: center">Capture Biometrics</h4>
          <hr>
          <div class="row">
            <div class="col-sm-12">
              <div class="form-group">
                <div class="widget-content">
                  <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="form-group col-lg-12 col-sm-12">
                      <div class="col-lg-4"></div>
                      <div class="col-lg-4">
                        <div style="min-height: 320px;">
                          <img src="assets/images/enroll/enroll.png" class="imgFade" />
                          <img id="L0" src="assets/images/enroll/L0.png" class="fl-L0 imgFade" data-next="fl-L1" />
                          <img id="L1" src="assets/images/enroll/L1.png" class="fl-L1 imgFade" data-next="fl-L2" />
                          <img id="L2" src="assets/images/enroll/L2.png" class="fl-L2 imgFade" data-next="fl-L3" />
                          <img id="L3" src="assets/images/enroll/L3.png" class="fl-L3 imgFade" data-next="fl-L4" />
                          <img id="L4" src="assets/images/enroll/L4.png" class="fl-L4 imgFade" data-next="fl-R0" />
                          <img id="R0" src="assets/images/enroll/R0.png" class="fl-R0 imgFade" data-next="fl-R1" />
                          <img id="R1" src="assets/images/enroll/R1.png" class="fl-R1 imgFade" data-next="fl-R2" />
                          <img id="R2" src="assets/images/enroll/R2.png" class="fl-R2 imgFade" data-next="fl-R3" />
                          <img id="R3" src="assets/images/enroll/R3.png" class="fl-R3 imgFade" data-next="fl-R4" />
                          <img id="R4" src="assets/images/enroll/R4.png" class="fl-R4 imgFade" data-next="x" />
                        </div>
                      </div>
                      <div class="col-lg-4"></div>
                    </div>
                    <div class="col-lg-12">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-6">
                        <div class="col-lg-12">
                          <div class="row">
                            <table class="table" style="height: 100%;" rowspan="2" colspan="2">
                              <tbody>					  
							    <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
							   <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								<tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								<tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								<tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								 <tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
								<tr style="padding-bottom: 0px">
								   <label style="text-align:center; padding-top: 5px"></label>
								</tr>
                                <tr style="padding-bottom: 0px">
                                  <td class="cp-L4 imgCol1" data-href='4|L' data-img='L4' data-pos='5' data-info='Left Little'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_LEFT_THUMB" onclick="addFinger(0)" class="captureFingerPrint">
                                        <img id="LEFT_THUMB" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Left Thumb</label>
                                    </div>
                                  </td>
                                  <td class="cp-L3 imgCol1" data-href='3|L' data-img='L3' data-pos='4' data-info='Left Ring'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_LEFT_INDEX" onclick="addFinger(1)" class="captureFingerPrint">
                                        <img id="LEFT_INDEX" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Left index</label>
                                    </div>
                                  </td>
                                  <td class="cp-L2 imgCol1" data-href='2|L' data-img='L2' data-pos='3' data-info='Left Middle'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_LEFT_MIDDLE" onclick="addFinger(2)" class="captureFingerPrint">
                                        <img id="LEFT_MIDDLE" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Left
                                        middle</label>
                                    </div>
                                  </td>
                                  <td class="cp-L1 imgCol1" data-href='1|L' data-img='L1' data-pos='2' data-info='Left Index'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_LEFT_RING" onclick="addFinger(3)" class="captureFingerPrint">
                                        <img id="LEFT_RING" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Left ring</label>
                                    </div>
                                  </td>
                                  <td class="cp-L0 imgCol1" data-href='0|L' data-img='L0' data-pos='1' data-info='Left Thumb'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_LEFT_LITTLE" onclick="addFinger(4)" class="captureFingerPrint">
                                        <img id="LEFT_LITTLE" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Left
                                        little</label>
                                    </div>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                      <div class="col-lg-3"></div>
                    </div>
                    <div class="col-lg-12">
                      <div class="col-lg-3"></div>
                      <div class="col-lg-6">
                        <div class="col-lg-12">
                          <div class="row">
                            <table class="table" style="border: 0; height: 20%;" rowspan="2" colspan="2">
                              <tbody>
                                <tr>
                                  <td class="cp-R0 imgCol1" data-href='0|R' data-img='R0' data-pos='1' data-info='Right Thumb'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_RIGHT_THUMB" onclick="addFinger(5)" class="captureFingerPrint">
                                        <img id="RIGHT_THUMB" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Right
                                        thumb</label>
                                    </div>
                                  </td>
                                  <td class="cp-R1 imgCol1" data-href='1|R' data-img='R1' data-pos='2' data-info='Right Index'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_RIGHT_INDEX" onclick="addFinger(6)" class="captureFingerPrint">
                                        <img id="RIGHT_INDEX" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Right
                                        index</label>
                                    </div>
                                  </td>
                                  <td class="cp-R2 imgCol1" data-href='2|R' data-img='R2' data-pos='3' data-info='Right Middle'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_RIGHT_MIDDLE" onclick="addFinger(7)" class="captureFingerPrint">
                                        <img id="RIGHT_MIDDLE" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Right
                                        middle</label>
                                    </div>
                                  </td>
								  
                                  <td class="cp-R3 imgCol1" data-href='3|R' data-img='R3' data-pos='4' data-info='Right Ring'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_RIGHT_RING" onclick="addFinger(8)" class="captureFingerPrint">
                                        <img id="RIGHT_RING" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Right
                                        ring</label>
                                    </div>
                                  </td>
                                  <td class="cp-R4 imgCol1" data-href='4|R' data-img='R4' data-pos='5' data-info='Right Little'
                                    capture>
                                    <div style="text-align:center;">
                                      <button type="button" id="BTN_RIGHT_LITTLE" onclick="addFinger(9)" class="captureFingerPrint">
                                        <img id="RIGHT_LITTLE" src="assets/images/enroll/noImage_1.png">
                                      </button>
                                      <label style="text-align:center; padding-top: 5px">Right
                                        little</label>
                                    </div>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                      <div class="col-lg-3"></div>
                      <div class="col-lg-12" style="text-align: center">
                        <button type="button" style="background-color:#990000 ; border-color:#990000" class="btn btn-success" id="BTN_SAVE" onclick="showCapturedFingers()">Save Profile</button>
						<label style="text-align:center; padding-top: 5px">  </label>
						<button type="button" style="background-color:#990000 ; border-color:#990000" class="btn btn-success" id="BTN_RESET" onclick="Reset()">Reset</button>
                        </div>
						
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
	<script src="js/sweetalert.min.js"></script>
  <script type='text/javascript' src="../cif/js/EquityProcessCustom.js"></script>
  <script type='text/javascript' src="../cif/js/EquityBio.js"></script>
 
	

</body>

</html>
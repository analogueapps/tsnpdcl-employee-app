import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'dart:async';

import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';

class OtpRequestAndValidateDialog extends StatefulWidget {
  final bool isAuthenticatedOtp;
  final String? mobileNo;
  final Function(bool verified, String requestId) onComplete;
  final Function() onCancelByUser;

  const OtpRequestAndValidateDialog({
    super.key,
    required this.isAuthenticatedOtp,
    required this.onComplete,
    required this.onCancelByUser,
    this.mobileNo,
  });

  @override
  State<OtpRequestAndValidateDialog> createState() =>
      _OtpRequestAndValidateDialogState();
}

class _OtpRequestAndValidateDialogState
    extends State<OtpRequestAndValidateDialog> {

  bool? isAuthenticatedOtp;
  String? mobileNumber;
  String? otpRequestId;
  bool verifyButtonVisible = isFalse;

  String otp = "";
  bool resendOtp = isFalse;
  int secondsRemaining = millisecondsThirty;
  Timer? timer;

  bool isLoading = isFalse;

  @override
  void initState() {
    super.initState();
    isAuthenticatedOtp = widget.isAuthenticatedOtp;
    mobileNumber = widget.mobileNo;
    otpRequestId = "null";
    getOtp();
  }

  void getOtp() {
    if (isAuthenticatedOtp == isTrue) {
      requestOtp();
    } else {
      requestUnAuthOtp();
    }
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          resendOtp = isTrue;
        });
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: isLoading ? const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            "Requesting OTP...",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ) :
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "OTP Verification",
            style: TextStyle(
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: doubleTen),
          Text(
            "Enter otp send to $mobileNumber",
            style: const TextStyle(
              fontSize: normalSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: doubleTwenty),
          Pinput(
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: isTrue,
            length: numSix,
            defaultPinTheme: PinTheme(
              width: doubleFiftySix,
              height: doubleFiftySix,
              decoration: BoxDecoration(
                color: CommonColors.textFieldColor,
                borderRadius: BorderRadius.circular(doubleTen),
                border: Border.all(
                    color: CommonColors.colorPrimaryMoreLight
                ),
              ),
              textStyle: const TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            onChanged: (value) {
              otp = value;
            },
            onCompleted: (value) {
              otp = value;
            },
          ),
          const SizedBox(height: doubleTwenty),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  showAlertActionDialog(
                      context: context,
                      title: "Cancel OTP verification?",
                      message: "Do you want to cancel this otp verification?",
                      okLabel: "Exit",
                      cancelLabel: "Stay",
                      onPressed: () {
                        widget.onCancelByUser();
                        Navigator.of(context).pop();
                      }
                  );
                },
                child: Text("Cancel".toUpperCase(), style: const TextStyle(color: Colors.white),),
              ),
              const SizedBox(width: doubleTen,),
              Visibility(
                visible: verifyButtonVisible,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    if(otp.length < 6){
                      showAlertDialog(context,"Please enter valid OTP");
                    } else {
                      verifyOTP();
                    }
                  },
                  child: Text("Verify".toUpperCase(), style: const TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: doubleTwenty,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't receive OTP?",
                  style: TextStyle(
                      fontSize: regularTextSize,
                      fontWeight:
                      FontWeight.w500),
                  textAlign:
                  TextAlign.center,
                ),
                const SizedBox(
                  width: doubleFive,
                ),
                resendOtp == isTrue
                    ? GestureDetector(
                  onTap: () {
                    getOtp();
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontSize: regularTextSize,
                        fontWeight:
                        FontWeight
                            .w500,
                        color: CommonColors
                            .colorPrimary),
                    textAlign:
                    TextAlign
                        .start,
                  ),
                )
                    : Text(
                  'Resend OTP in $secondsRemaining sec',
                  style: const TextStyle(
                      fontSize: regularTextSize,
                      fontWeight:
                      FontWeight
                          .w500,
                      color: CommonColors
                          .colorPrimary),
                  textAlign:
                  TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> requestOtp() async {
    setState(() {
      isLoading = isTrue;
    });

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "previousRequestId": otpRequestId ?? "null"
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.REQUEST_OTP_URL, payload);

    setState(() {
      isLoading = isFalse;
    });

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              setState(() {
                mobileNumber = response.data['data'];
                verifyButtonVisible = isTrue;
                List<dynamic> jsonList;
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];  // Fallback to empty list if the type is unexpected
                }
                otpRequestId = jsonList[0];
                startTimer();
              });
            } else {
              showAlertActionDialog(
                  context: context,
                  title: "ERROR",
                  message: response.data['message'],
                  okLabel: "EXIT",
                  cancelLabel: "RETRY",
                  onPressed: () {
                    widget.onCancelByUser();
                    Navigator.of(context).pop();
                  },
                  onCancelPressed: () {
                    getOtp();
                  }
              );
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      } else {
        showAlertActionDialog(
            context: context,
            title: "ERROR",
            message: "Received NULL response from server",
            okLabel: "EXIT",
            cancelLabel: "RETRY",
            onPressed: () {
              widget.onCancelByUser();
              Navigator.of(context).pop();
            },
            onCancelPressed: () {
              getOtp();
            }
        );
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      showAlertActionDialog(
          context: context,
          title: "ERROR",
          message: "An error occurred. Please try again.",
          okLabel: "EXIT",
          cancelLabel: "RETRY",
          onPressed: () {
            widget.onCancelByUser();
            Navigator.of(context).pop();
          },
          onCancelPressed: () {
            getOtp();
          }
      );
      rethrow;
    }
  }

  Future<void> requestUnAuthOtp() async {
    setState(() {
      isLoading = isTrue;
    });

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "mobileNo": mobileNumber ?? "null",
      "previousRequestId": otpRequestId ?? "null"
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.REQUEST_UN_AUTH_OTP_URL, payload);
    setState(() {
      isLoading = isFalse;
    });

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              setState(() {
                mobileNumber = response.data['data'];
                verifyButtonVisible = isTrue;
                List<dynamic> jsonList;
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];  // Fallback to empty list if the type is unexpected
                }
                otpRequestId = jsonList[0];
                startTimer();
              });
            } else {
              showAlertActionDialog(
                  context: context,
                  title: "ERROR",
                  message: response.data['message'],
                  okLabel: "EXIT",
                  cancelLabel: "RETRY",
                  onPressed: () {
                    widget.onCancelByUser();
                    Navigator.of(context).pop();
                  },
                  onCancelPressed: () {
                    getOtp();
                  }
              );
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      } else {
        showAlertActionDialog(
            context: context,
            title: "ERROR",
            message: "Received NULL response from server",
            okLabel: "EXIT",
            cancelLabel: "RETRY",
            onPressed: () {
              widget.onCancelByUser();
              Navigator.of(context).pop();
            },
            onCancelPressed: () {
              getOtp();
            }
        );
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      showAlertActionDialog(
          context: context,
          title: "ERROR",
          message: "An error occurred. Please try again.",
          okLabel: "EXIT",
          cancelLabel: "RETRY",
          onPressed: () {
            widget.onCancelByUser();
            Navigator.of(context).pop();
          },
          onCancelPressed: () {
            getOtp();
          }
      );
      rethrow;
    }
  }

  Future<void> verifyOTP() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Verifying OTP...",
    );

    final payload = {
      "appId": "in.tsnpdcl.npdclemployee",
      "mobileNo": mobileNumber,
      "requestId": otpRequestId,
      "otp": otp,
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.VERIFY_OTP_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              widget.onComplete(isTrue,otpRequestId!);
              Navigator.of(context).pop();
            } else {
              showAlertActionDialog(
                  context: context,
                  title: "ERROR",
                  message: response.data['message'],
                  okLabel: "EXIT",
                  cancelLabel: "RETRY",
                  onPressed: () {
                    widget.onCancelByUser();
                    Navigator.of(context).pop();
                  },
                  onCancelPressed: () {
                    getOtp();
                  }
              );
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      } else {
        showAlertActionDialog(
            context: context,
            title: "ERROR",
            message: "Received NULL response from server",
            okLabel: "EXIT",
            cancelLabel: "RETRY",
            onPressed: () {
              widget.onCancelByUser();
              Navigator.of(context).pop();
            },
            onCancelPressed: () {
              getOtp();
            }
        );
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      showAlertActionDialog(
          context: context,
          title: "ERROR",
          message: "An error occurred. Please try again.",
          okLabel: "EXIT",
          cancelLabel: "RETRY",
          onPressed: () {
            widget.onCancelByUser();
            Navigator.of(context).pop();
          },
          onCancelPressed: () {
            getOtp();
          }
      );
      rethrow;
    }
  }
}

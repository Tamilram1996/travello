import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelo/UI/loginscreen.dart';
import 'package:travelo/Utils/shared_preference.dart';
import '../Utils/base.dart';
import '../Utils/utils.dart';
import 'homescreen.dart'; // Import for input formatters

String? eMailId;

class OtpScreen extends StatefulWidget {
  String? email;

  OtpScreen({Key? key, this.email}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? mailId;
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
  TextEditingController mailController = TextEditingController();

  bool isLoading = false;
  String? OTPvalue;
  String? otpcode;
  bool _isButtonDisabled = false;
  int _secondsRemaining = 0;
  Timer? _timer;

  void startTimer() {
    setState(() {
      _isButtonDisabled = true;
      _secondsRemaining = 30;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isButtonDisabled = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEmail();
  }

  void _fetchEmail() async {
    String? emailId = await getUserName(); // Retrieve email asynchronously
    setState(() {
      mailId = emailId; // Update the state with the email
    });
    print("eMailid: $mailId");
  }

  void clearOtpBoxes() {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }

  String formatEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex == -1 || atIndex < 6) {
      return email; // Return the original email if invalid or too short
    }
    String localPart = email.substring(0, atIndex);
    String domain = email.substring(atIndex);

    String visiblePart = localPart.substring(0, 6);
    String obscuredPart = '*' * (localPart.length - 6);

    return '$visiblePart$obscuredPart$domain';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading == true
            ? loaderWidget()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Almost there",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                                text:
                                    "Please enter the 6-digit code sent to your email "),
                            TextSpan(
                              text:
                                  "${mailId ?? "contact.uiuxexperts@gmail.com"}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: " for verification."),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        formatEmail(mailId ?? ''),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Enter the OTP code below to continue.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return _buildOtpBox(index);
                        }),
                      ),
                      SizedBox(height: 60),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            String otp = otpControllers
                                .map((controller) => controller.text)
                                .join();
                            if (otp.length == 6) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Please enter a valid 6-digit OTP"),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Base.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Didn’t receive any code? Resend Again",
                          style: TextStyle(
                            fontSize: Base.titlefont,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: _isButtonDisabled
                            ? null
                            : () {
                                clearOtpBoxes(); // Your function to reset OTP boxes
                                print("OTP Reset");
                                startTimer();
                              },
                        child: Center(
                          child: Text(
                            _isButtonDisabled
                                ? "Wait $_secondsRemaining sec"
                                : "Get new OTP",
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  _isButtonDisabled ? Colors.grey : Colors.blue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.black, // Set the background color to black
                  shape: BoxShape.circle, // Makes the container circular
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginscreen()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white, // White icon color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Focus(
        onKey: (node, event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            if (otpControllers[index].text.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
            }
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: otpControllers[index],
          focusNode: otpFocusNodes[index],
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          textAlign: TextAlign.center,
          decoration: InputDecoration(border: InputBorder.none),
          style: TextStyle(fontSize: 20),
          onChanged: (value) {
            setState(() {
              OTPvalue =
                  otpControllers.map((controller) => controller.text).join();
              print("OTPvalue?:?:?::");
              print(OTPvalue);
              otpcode = OTPvalue;
            });
            if (value.isNotEmpty && index < 5) {
              FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screen/reset_password_Screen.dart';
import 'package:task_manager/ui/screen/sign_in_Screen.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';



class ForgotPasswordOtpVerify extends StatefulWidget {
  const ForgotPasswordOtpVerify({super.key});
  static const String name='/Forgot_password_otp_verify';

  @override
  State<ForgotPasswordOtpVerify> createState() => _ForgotPasswordOtpVerifyState();
}

class _ForgotPasswordOtpVerifyState extends State<ForgotPasswordOtpVerify> {
  final TextEditingController _pincodeTEcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    Text('Pin Verification',
                    style: textTheme.titleLarge,
                    ),
                    SizedBox(height: 24,),
                    Text('A six digit Pin Sent to your Email',
                    style: textTheme.titleSmall,
                    ),
                    SizedBox(height: 16,),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType:TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedBorderWidth: 1,
                        inactiveBorderWidth: 1,

                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      controller: _pincodeTEcontroller,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      appContext: context,
                    ),
                    SizedBox(height: 16,),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, ResetPasswordScreen.name);
                        },
                        child: Icon(Icons.arrow_circle_right_outlined)
                    ),
                    SizedBox(height: 48,),
                    _builSignInSections()
                    
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pincodeTEcontroller.dispose();
  }
}

class _builSignInSections extends StatelessWidget {
  const _builSignInSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          text: 'Already Have an Account?',
          style: TextStyle(
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.green,
              ),
              recognizer: TapGestureRecognizer()..onTap=(){
                Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (value)=>false);
              }
            )
          ]

        ),

    );

  }

}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/Forgot_password_otp_verify.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String name='/forgot-password-screen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

final TextEditingController _emailTEcontroller=TextEditingController();
GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(

      body: ScreenBackground(
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: Column(
                 

                  children: [
                    const SizedBox(height: 50,),
                    Text('Your Email Address',
                      style:textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8.0),
                    Text('A six digit pin will sent to your Email.',
                    style: textTheme.titleSmall,
                    ),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _emailTEcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 8.0,),


                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, ForgotPasswordOtpVerify.name);
                      },
                      child:Icon(Icons.keyboard_arrow_right),

                    ),
                    const SizedBox(height: 48,),
                    _buildSignInSection(),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
Widget _buildSignInSection() {
  return RichText(text: TextSpan(
      text: 'Alredy have an Account?',
      style: TextStyle(
          color: Colors.black
      ),
      children: [
        TextSpan(
            text: 'Sign In',
            style: TextStyle(
              color: Colors.green,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              }
        )
      ]
  ));
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEcontroller.dispose();
  }

}

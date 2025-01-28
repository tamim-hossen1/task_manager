import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/sign_in_Screen.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const String name= '/reset-password-screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  Text('Set Password',
                    style:textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24,),
                  Text('Minimum length password 8 character with letter and number combination',
                  style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password'
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password'
                    ),
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                      onPressed: (){},
                      child:Text('Confirm'),
                  ),
                  SizedBox(height: 30,),

                  RichText(
                      text: TextSpan(
                        text: 'Have Account? ',
                        style: TextStyle(
                          color: Colors.black,

                        ),
                        children: [
                          TextSpan(
                            text: 'sign In',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name,(value)=> false);
                            },
                          )
                        ]
                      ),

                  )

                ],

              ),
            ),
          ),
      ),
    );
  }
}

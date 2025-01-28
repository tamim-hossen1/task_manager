import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/network_caller.dart';
import 'package:task_manager/Data/models/user_model.dart';
import 'package:task_manager/Data/utils/Urls.dart';

import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/Forgot_password_verify.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screen/new_task_list_Screen.dart';
import 'package:task_manager/ui/screen/sign_up_Screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/Circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/Input_decoration.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';
import 'package:task_manager/ui/widgets/snackBarMessage.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name='/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailTEcontroller=TextEditingController();
  final TextEditingController _passwordTEcontroller=TextEditingController();
  GlobalKey<FormState> _formkey=GlobalKey<FormState>();

  bool _signInProgress=false;

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
                    Text('Get Started With',
                    style:textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _emailTEcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0,),
                    TextFormField(
                      controller: _passwordTEcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Passwoord',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your password';
                        }if(value!.length<6){
                          return 'Enter a value more than 6 latters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0,),

                    Visibility(
                      visible: _signInProgress==false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: _onTapSignInButton,
                          child:Icon(Icons.keyboard_arrow_right),

                      ),
                    ),
                    const SizedBox(height: 48,),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, ForgotPasswordScreen.name);
                              },
                              child: Text("Forgot Password!"),
                          ),
                        ],
                      ),
                    ),
                    _builSignUpSection(),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  void _onTapSignInButton(){
    if(_formkey.currentState!.validate()){
      _SignIn();
    }
  }

  Future<void> _SignIn() async{
    _signInProgress=true;
    setState(() {});

    Map<String,dynamic> requestBody={
      "email":_emailTEcontroller.text.trim(),
      "password":_passwordTEcontroller.text,

    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Url: Urls.loginUrl, body: requestBody);

    if(response.isSuccess){
      String token=response.responseData!['token'];
      UserModel userModel=UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);

    }else{
      _signInProgress=false;
      setState(() {});
      if(response.StatusCode==401){
        showSnackBarMessage(context, 'Email/Password is invalid');
      }
      else{
        showSnackBarMessage(context, response.errorMessage);
      }


    }

  }

Widget _builSignUpSection() {
    return RichText(
                    text: TextSpan(
                      text:"Don't Have an account? ",
                      style: TextStyle(
                        color: Colors.black
                      ),
                      children: [
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            color: Appcolors.themeColors,
                          ),
                            recognizer : TapGestureRecognizer()
                            ..onTap=(){
                              Navigator.pushNamed(context, SignUpScreen.name);
                            }
                        )
                      ],
                    ),
                );
  }
  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
  }
}

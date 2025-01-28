import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/network_caller.dart';
import 'package:task_manager/Data/utils/Urls.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/Circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';
import 'package:task_manager/ui/widgets/snackBarMessage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name='/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEcontroller=TextEditingController();
  final TextEditingController _firstnameTEcontroller=TextEditingController();
  final TextEditingController _lastnameTEcontroller=TextEditingController();
  final TextEditingController _mobileTEcontroller=TextEditingController();
  final TextEditingController _passwordTEcontroller=TextEditingController();

  GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _signUpInProgress=false;


  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(

      body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 48,),
                    Text('Join with us',
                        style: textTheme.titleLarge,

                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _emailTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Email'
                      ),

                      validator: (String? value){
                        if(value?.trim().isEmpty==true){
                          return 'Enter your email address';
                        }else{
                          return null;
                        }
                      },

                    ),
                    SizedBox(height: 8.0,),
                    TextFormField(
                      controller: _firstnameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'First name'
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty==true){
                          return 'Enter your First name';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 8.0,),
                    TextFormField(
                      controller: _lastnameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Last name'
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty==true){
                          return 'Enter your last name';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 8.0,),
                    TextFormField(
                      controller: _mobileTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value){
                        if(value?.trim().isEmpty==true){
                          return 'Enter your Mobile number';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 8.0,),
                    TextFormField(
                      controller: _passwordTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value){
                        if(value?.isEmpty==true){
                          return 'Enter your Password';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16.0,),
                    Visibility(
                      visible: _signUpInProgress==false,
                      replacement:CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                            onPressed: _onTapSignUpButton,
                            child: Icon(Icons.keyboard_arrow_right)
                        ),
                    ),


                    SizedBox(height: 24,),

                    _buildSignInSection(context)
                  ],
                ),
              ),
            ),
          )
      ),

    );
  }
  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    _signUpInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEcontroller.text.trim(),
      "firstName": _firstnameTEcontroller.text.trim(),
      "lastName": _lastnameTEcontroller.text.trim(),
      "mobile": _mobileTEcontroller.text.trim(),
      "password": _passwordTEcontroller.text,
      "photo": ""
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        Url: Urls.registrationUrl, body: requestBody, );
    _signUpInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New user registration successful!');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }


  void _clearTextFields(){
    _passwordTEcontroller.clear();
    _emailTEcontroller.clear();
    _firstnameTEcontroller.clear();
    _lastnameTEcontroller.clear();
    _mobileTEcontroller.clear();
  }


 Widget _buildSignInSection(BuildContext context) {
    return RichText(text: TextSpan(
                text: 'Alredy have an Account?',
                style: TextStyle(
                  color: Colors.black
                ),
                children:[
                  TextSpan(
                    text: 'Sign In',
                    style:  TextStyle(
                      color: Colors.green,
                    ),
                    recognizer: TapGestureRecognizer()..onTap=(){
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
    _firstnameTEcontroller.dispose();
    _lastnameTEcontroller.dispose();
    _mobileTEcontroller.dispose();
    _passwordTEcontroller.dispose();
  }
}


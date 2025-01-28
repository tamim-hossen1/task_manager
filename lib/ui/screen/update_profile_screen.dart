import 'package:flutter/material.dart';

import 'package:task_manager/Data/Services/network_caller.dart';
import 'package:task_manager/Data/models/user_model.dart';
import 'package:task_manager/Data/utils/Urls.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/widgets/Circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';
import 'package:task_manager/ui/widgets/Tm_app_Bar.dart';
import 'package:task_manager/ui/widgets/snackBarMessage.dart';


import 'main_bottom_nav_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
  super.key,
});



  static const String name='/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _firstnameTEcontroller = TextEditingController();
  final TextEditingController _lastnameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateProfileInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: TMappBar(
        fromUpdateProfile: true,
      ),
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48,),
                  Text('Update Profile',
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(height: 8,),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        _buildPhotoPecker(),
                        const SizedBox(width: 12,),
                        Text('No item Selected', maxLines: 1,),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _emailTEcontroller,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),

                  ),
                  SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _firstnameTEcontroller,
                    decoration: InputDecoration(
                        hintText: 'First name'
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _lastnameTEcontroller,
                    decoration: InputDecoration(
                        hintText: 'Last name'
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _mobileTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  TextFormField(
                    controller: _passwordTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _updateProfile();
                          }
                        },
                        child: Icon(Icons.keyboard_arrow_right)
                    ),
                  ),

                  SizedBox(height: 24,),
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget _buildPhotoPecker() {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text('Photos'),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius:
          BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          )),
      alignment: Alignment.center,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    _mobileTEcontroller.dispose();
    _firstnameTEcontroller.dispose();
    _lastnameTEcontroller.dispose();
  }


  Future<void> _updateProfile() async {
    if (!mounted) return;

    setState(() {
      _updateProfileInProgress = true;
    });

    Map<String, dynamic> inputParams = {
      "email": _emailTEcontroller.text.trim(),
      "firstName": _firstnameTEcontroller.text.trim(),
      "lastName": _lastnameTEcontroller.text.trim(),
      "mobile": _mobileTEcontroller.text.trim(),
    };

    if (_passwordTEcontroller.text.isNotEmpty) {
      inputParams["password"] = _passwordTEcontroller.text;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      Url: Urls.ProfileUpdateUrl,
      body: inputParams, // Fix: Send request body
    );

    setState(() {
      _updateProfileInProgress = false;
    });

    debugPrint(response.responseData.toString()); // Debugging line

    if (response.isSuccess && response.responseData?["status"] == "success") {
      UserData userData = UserData(
        email: _emailTEcontroller.text.trim(),
        firstName: _firstnameTEcontroller.text.trim(),
        lastName: _lastnameTEcontroller.text.trim(),
        mobile: _mobileTEcontroller.text.trim(),
        photo: null,
      );

      await AuthController.saveUserDat(
          userData as UserModel); // Ensure compatibility

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainBottomNavScreen()),
              (route) => false,
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Profile Update failed');
      }
    }
  }
}


  class UserData {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;
  UserData({this.email, this.firstName, this.lastName, this.mobile, this.photo});
  UserData.fromJson(Map<String, dynamic> json) {
  email = json["email"];
  firstName = json["firstName"];
  lastName = json["lastName"];
  mobile = json["mobile"];
  photo = json["photo"];
  }
  Map<String, dynamic> toJson(){
  final Map<String, dynamic> data = <String, dynamic>{};
  data["email"] = email;
  data["firstName"] = firstName;
  data["lastName"] = lastName;
  data["mobile"] = mobile;
  data["photo"] = photo;
  return data;
  }

  String get fullName {
  return "${firstName ?? ""} ${lastName ?? ""}";
  }
  }




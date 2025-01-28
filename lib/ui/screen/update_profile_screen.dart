import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';
import 'package:task_manager/ui/widgets/Tm_app_Bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
  super.key,
});



  static const String name='/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEcontroller=TextEditingController();
  final TextEditingController _firstnameTEcontroller=TextEditingController();
  final TextEditingController _lastnameTEcontroller=TextEditingController();
  final TextEditingController _mobileTEcontroller=TextEditingController();
  final TextEditingController _passwordTEcontroller=TextEditingController();

  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
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
                        Text('No item Selected',maxLines: 1,),
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
                  ElevatedButton(
                      onPressed: (){},
                      child: Icon(Icons.keyboard_arrow_right)
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
                      height:56,
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
}

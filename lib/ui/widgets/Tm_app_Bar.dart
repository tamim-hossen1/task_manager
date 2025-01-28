
import 'package:flutter/material.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/sign_in_Screen.dart';
import 'package:task_manager/ui/screen/update_profile_screen.dart';

import '../utils/app_colors.dart';

class TMappBar extends StatelessWidget implements PreferredSizeWidget {
  const TMappBar({
    super.key,
    this.fromUpdateProfile=false,

  });
  final bool fromUpdateProfile;


  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Appcolors.themeColors,
      title:  Row(
        children: [
          CircleAvatar(
            radius: 20,
          ),
          SizedBox(width: 16,),
          Expanded(
            child: GestureDetector(
              onTap: (){

                if(fromUpdateProfile){
                  return;
                }
                Navigator.pushNamed(context, UpdateProfileScreen.name);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel?.fullName?? '',
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AuthController.userModel?.email ?? '',
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async{
                  await AuthController.clearUserData();
                  Navigator.pushNamedAndRemoveUntil(context,SignInScreen.name, (predicate)=> false);
                },
                icon: Icon(Icons.logout),
              )
            ],
          )

        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

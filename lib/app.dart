import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/Forgot_password_otp_verify.dart';
import 'package:task_manager/ui/screen/Forgot_password_verify.dart';
import 'package:task_manager/ui/screen/New_task_Screen.dart';
import 'package:task_manager/ui/screen/Splash_Screen.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screen/reset_password_Screen.dart';
import 'package:task_manager/ui/screen/sign_in_Screen.dart';
import 'package:task_manager/ui/screen/sign_up_Screen.dart';
import 'package:task_manager/ui/screen/update_profile_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskManageApp extends StatelessWidget {
  const TaskManageApp({super.key});

 static GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorSchemeSeed: Appcolors.themeColors,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
            backgroundColor: Appcolors.themeColors,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),

            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10
            ),
            fixedSize: Size.fromWidth(double.maxFinite),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
            )
          )
        )
      ),

      initialRoute: '/',
      navigatorKey: navigatorKey,
      onGenerateRoute: (RouteSettings settings){
        late Widget widget;

        if(settings.name==SplashScreen.name){
          widget= const SplashScreen();
        }
        else if(settings.name==SignInScreen.name){
          widget=const SignInScreen();
        }else if(settings.name==SignUpScreen.name){
          widget=const SignUpScreen();
        }
        else if(settings.name==ForgotPasswordScreen.name){
          widget=const ForgotPasswordScreen();
        }
        else if(settings.name==ForgotPasswordOtpVerify.name){
          widget=const ForgotPasswordOtpVerify();
        }
        else if(settings.name==ResetPasswordScreen.name){
          widget=const ResetPasswordScreen();
        }
        else if(settings.name==MainBottomNavScreen.name){
          widget=const MainBottomNavScreen();
        }else if(settings.name==NewTaskScreen.name){
          widget=const NewTaskScreen();
        }else if(settings.name==UpdateProfileScreen.name){
          widget=const UpdateProfileScreen();
        }
        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}


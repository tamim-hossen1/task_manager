import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/Data/models/user_model.dart';

class AuthController {
  static String? accessToken;
  static UserModel? userModel;



  static const String _accessTokenKey='access-token';
  static const String _userDataKey='user-data';

  static Future<void> saveUserDat(UserModel userData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        "userData", jsonEncode(userData.toJson()));
    AuthController.userModel = userData;
  }

  static Future<void> saveUserData(String accessToken, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(_accessTokenKey, accessToken);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);

    // Null-checks to prevent issues
    if (token != null && userData != null) {
      accessToken = token;
      userModel = UserModel.fromJson(jsonDecode(userData));
    } else {
      // Clear cached data if it's corrupted or missing
      await sharedPreferences.clear();
    }
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);

    if (token != null) {
      try {
        await getUserData();
        return true;
      } catch (e) {
        // Handle any exceptions (e.g., corrupted data)
        print("Error retrieving user data: $e");
        await sharedPreferences.clear();
        return false;
      }
    }
    return false;
  }

  static Future<void> clearUserData() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}

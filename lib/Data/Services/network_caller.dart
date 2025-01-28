import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/sign_in_Screen.dart';

class NetworkResponse{
  final int StatusCode;
  final Map<String,dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.StatusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'Something went Wrong.',
  });
}

class NetworkCaller{
  static Future<NetworkResponse> getRequest({required String Url,Map<String,dynamic>? params}) async{
    try{
      Uri uri = Uri.parse(Url);
      debugPrint('Url => $uri');
      Response response = await get(uri,headers: {
        'token':AuthController.accessToken ?? '',
      });
      debugPrint('Response Code => ${response.statusCode}');
      debugPrint('Response data => ${response.body}');

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return NetworkResponse(
          StatusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeResponse,
        );
      }else if(response.statusCode==401){
        await _logOut();
        return NetworkResponse(
          StatusCode: response.statusCode,
          isSuccess: false,
        );
      }
      else {
        return NetworkResponse(
          StatusCode: response.statusCode,
          isSuccess: false,
        );
      }
    }catch(e){
      return NetworkResponse(
        StatusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({required String Url,Map<String,dynamic>? body}) async{
    try{
      Uri url = Uri.parse(Url);
      debugPrint('Url => $url');
      debugPrint('Body => $body');
      Response response = await post(
          url,
          headers: {
            'content-type':'application/json',
            'token' : AuthController.accessToken ?? ''
          },
          body: jsonEncode(body)
      );
      debugPrint('Response Code => ${response.statusCode}');
      debugPrint('Response data => ${response.body}');

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return NetworkResponse(
          StatusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeResponse,
        );
      }else if(response.statusCode==401){
        await _logOut();
        return NetworkResponse(
          StatusCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          StatusCode: response.statusCode,
          isSuccess: false,
        );
      }
    }catch(e){
      return NetworkResponse(
        StatusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

}
Future<void> _logOut() async{
  await AuthController.clearUserData();

  Navigator.pushNamedAndRemoveUntil(
      TaskManageApp.navigatorKey.currentContext!,
      SignInScreen.name,
          (_) => false);
}
import 'dart:developer';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';

import '../config/api_constants.dart';
import '../routes/app_pages.dart';

class BaseProvider extends GetConnect {

  late AuthService _authService ;

  bool isLoginRequest(request) {
    return (ConfigAPI.baseUrl + ConfigAPI.signInUrl ==
        request.url.toString());
  }


  int retry = 0;

  @override
  void onInit() {
    _authService = Get.find() ;

    httpClient.baseUrl = ConfigAPI.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.maxAuthRetries = retry = 3;
    httpClient.followRedirects = true;

    //addAuthenticator only is called after
    //a request (get/post/put/delete) that returns HTTP status code 401
    httpClient.addAuthenticator<dynamic>((request) async {
      // retry--;
      log('addAuthenticator ${request.url.toString()}');

      // if (!isLoginRequest(request)) {
      //   // log('check is isLoginRequest(request): ${isLoginRequest(request)}');
      //   Get.offAllNamed(Routes.LOGIN);
      // }

      // retry = httpClient.maxAuthRetries;
      if (!isLoginRequest(request)) {
        await _authService.removeCredentials() ;
        Get.offAllNamed(Routes.LOGIN, arguments: {
          'message': {
            'status': 'warning',
            'status_text': 'session_expired',
            'body': 'Session expired please log in again.!'
          }
        });
      }

      return request;
    });

    httpClient.addResponseModifier((request, response) {
      log('call addResponseModifier ${response.statusCode}, ${request.url}');

      if (response.statusCode == 403) {
        return Response(request: request, statusCode: 401);
      }
      return response;
    });

    httpClient.addRequestModifier<dynamic>((request) async {

      if (!_authService.sessionIsEmpty()) {
        // log('Add Request Modifier is authenticated');
        request.headers['Authorization'] =
        'Bearer ${_authService.credentials?.jwt}';
      }
      return request;
    });
  }
}
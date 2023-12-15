import 'dart:developer';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/backend_error_model.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';

import '../config/api_constants.dart';
import '../routes/app_pages.dart';

class BaseProvider extends GetConnect {

  late AuthService authService ;

  bool isLoginRequest(request) {
    return (ConfigAPI.baseUrl + ConfigAPI.signInUrl ==
        request.url.toString());
  }  
  
  bool isMeRequest(request) {
    return (ConfigAPI.baseUrl + ConfigAPI.meUrl == request.url.toString());
  }


  T decode<T>(Response response, T Function(Map<String, dynamic>) decoder) {
    if (response.hasError) {
      if (response.body is Map) {
        var backendError = BackendError.fromJson(response.body);
        if (backendError.error?.details?.errors != null) {
          // Combine all error messages into a single string
          var combinedErrorMessage = backendError.error!.details!.errors!
              .map((e) => e.message)
              .join('\n');
          throw Exception(combinedErrorMessage);
        } else {
          throw Exception(backendError.error?.message ?? 'Unknown error');
        }
      } else {
        print(response.bodyString);
        throw Exception(response.body);
      }
    }
    return decoder(response.body);
  }

  int retry = 0;

  @override
  void onInit() {
    authService = Get.find() ;

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
      if (!isLoginRequest(request) && !isMeRequest(request)) {
        await authService.removeCredentials() ;
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

      if (!isLoginRequest(request) && !authService.sessionIsEmpty()) {
        // log('Add Request Modifier is authenticated');
        request.headers['Authorization'] =
        'Bearer ${authService.credentials?.jwt}';
      }
      return request;
    });
  }
}
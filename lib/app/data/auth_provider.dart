import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';

import 'models/user_permission_model.dart';


class AuthProvider extends BaseProvider {

  Future<UserPermission?> loginLocal(String identifier , String password) async {
    final response = await post(ConfigAPI.signInUrl , {
      "identifier": identifier,
      "password": password
    });

    return decode<UserPermission?>(response, UserPermission.fromJson);

    return response.body;
  }

}

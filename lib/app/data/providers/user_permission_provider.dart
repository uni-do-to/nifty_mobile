import 'package:get/get.dart';

import '../models/user_permission_model.dart';

class UserPermissionProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UserPermission.fromJson(map);
      if (map is List)
        return map.map((item) => UserPermission.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UserPermission?> getUserPermission(int id) async {
    final response = await get('userpermission/$id');
    return response.body;
  }

  Future<Response<UserPermission>> postUserPermission(
          UserPermission userpermission) async =>
      await post('userpermission', userpermission);
  Future<Response> deleteUserPermission(int id) async =>
      await delete('userpermission/$id');
}

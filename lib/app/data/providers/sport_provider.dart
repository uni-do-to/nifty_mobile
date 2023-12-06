import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';

import '../models/api_response.dart';
import '../models/recipe_model.dart';
import '../models/sports_model.dart';

class SportProvider extends BaseProvider {
  Future<ApiListResponse<Sport>?> getSportsList() async {
    final response = await get(ConfigAPI.sportUrl);

    return decode<ApiListResponse<Sport>?>(
        response,
            (data) => ApiListResponse.fromJson(
            data, (data) => Sport.fromJson(data)));
  }
}

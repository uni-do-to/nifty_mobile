import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';

import '../models/sports_response_model.dart';

class SportProvider extends BaseProvider {
  Future<SportsResponse> getSportsList() async {
    final response = await get(ConfigAPI.sportUrl);

    return decode<SportsResponse>(response, SportsResponse.fromJson);
  }
}

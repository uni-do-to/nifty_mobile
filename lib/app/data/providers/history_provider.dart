import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';

import '../models/api_response.dart';
import '../models/history_response_model.dart';

class HistoryProvider extends BaseProvider {

  Future<ApiListResponse<History>?> getHistory() async {
    final response = await get(ConfigAPI.historyUrl );

    return decode<ApiListResponse<History>?>(
        response,
            (data) =>
            ApiListResponse.fromJson(data, (data) => History.fromJson(data)));
  }
}

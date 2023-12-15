import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/app_constants.dart';
import 'package:nifty_mobile/app/services/config_service.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

dynamic removeNull(dynamic params) {
  if (params is Map) {
    var _map = {};
    params.forEach((key, value) {
      var _value = removeNull(value);
      if (_value != null) {
        _map[key] = _value;
      }
    });
    // comment this condition if you want empty dictionary
    if (_map.isNotEmpty)
      return _map;
  } else if (params is List) {
    var _list = [];
    for (var val in params) {
      var _value = removeNull(val);
      if (_value != null) {
        _list.add(_value);
      }
    }
    // comment this condition if you want empty list
    if (_list.isNotEmpty)
      return _list;
  } else if (params != null) {
    return params;
  }
  return null;
}

extension ToDisplayUnit on double {
  String get displayUnit {
    var currentDisplayUnit = Get.find<ConfigService>().displayUnit ;

    if(currentDisplayUnit == AppConstants.displayUnits[0]) {
      return "${(this / 33).toPrecision(1)}" ;
    }
    return "${toPrecision(1)}" ;
  }
}

String get displayUnit {
  var currentDisplayUnit = Get.find<ConfigService>().displayUnit;

  if (currentDisplayUnit == AppConstants.displayUnits[0]) {
    return LocaleKeys.np.tr;
  }
  return LocaleKeys.cal.tr;
}

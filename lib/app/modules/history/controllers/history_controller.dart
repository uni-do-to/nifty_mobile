import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/history_provider.dart';

import '../../../data/models/history_response_model.dart';

class HistoryController extends GetxController {
  RxList<History> historyList = RxList(); // Your list of items
  RxList<History> pastWeekList = RxList();
  RxList<History> pastMonthList = RxList();
  RxList<History> pastYearList = RxList();
  RxBool loading = false.obs;

  final HistoryProvider historyProvider;

  HistoryController(this.historyProvider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;
      var historyListResponse = await historyProvider.getHistory();
      if (historyListResponse != null) {
        DateTime now = DateTime.now();
        DateTime oneWeekAgo = now.subtract(Duration(days: 7));
        DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
        DateTime oneYearAgo = DateTime(now.year - 1, now.month, now.day);

        historyList.value = historyListResponse.data ?? [];

        pastWeekList.value = historyList.where((history) {
          DateTime historyDate = DateTime.parse(history.attributes?.date ?? '');
          return historyDate.isAfter(oneWeekAgo);
        }).toList();

        pastMonthList.value = historyList.where((history) {
          DateTime historyDate = DateTime.parse(history.attributes?.date ?? '');
          return historyDate.isAfter(oneMonthAgo);
        }).toList();

        pastYearList.value = historyList.where((history) {
          DateTime historyDate = DateTime.parse(history.attributes?.date ?? '');
          return historyDate.isAfter(oneYearAgo);
        }).toList();

        // Sort the lists if needed
        sortLists();
      }
    } catch (err) {

    } finally {
      loading.value = false;
    }
  }

  void sortLists() {
    historyList.sort((a, b) => b.attributes!.date!.compareTo(a.attributes!.date!));
    pastWeekList.sort((a, b) => b.attributes!.date!.compareTo(a.attributes!.date!));
    pastMonthList.sort((a, b) => b.attributes!.date!.compareTo(a.attributes!.date!));
    pastYearList.sort((a, b) => b.attributes!.date!.compareTo(a.attributes!.date!));
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

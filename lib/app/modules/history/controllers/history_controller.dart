import 'package:collection/collection.dart';
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
    } catch (err , stacktrace) {
      err.printError();
      stacktrace.printError() ;
    } finally {
      loading.value = false;
    }
  }

  List<History> aggregateByDate(List<History> historyList) {
    var groupedByDate = groupBy(historyList, (History h) {
      return DateTime(h.attributes!.dateTime.year, h.attributes!.dateTime.month, h.attributes!.dateTime.day);
    });

    List<History> averagedHistory = [];
    groupedByDate.forEach((date, histories) {
      double totalWeight = histories.where((element) => element.attributes?.weight != null).fold(0, (sum, current) => sum + (current.attributes!.weight!));
      double averageWeight = totalWeight / histories.where((element) => element.attributes?.weight != null).length;

      if (histories.isNotEmpty) {
        // Creating a new History object for the date with the average weight
        averagedHistory.add(History(
            attributes: Attributes(
              date: date.toString(),
              weight: averageWeight // Optionally handling height similarly
            )
        ));
      }
    });

    return averagedHistory;
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

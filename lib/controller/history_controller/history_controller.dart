import 'package:get/get.dart';
import 'package:smartwatch/services/database_service.dart';

class HistoryController extends GetxController {
  var history = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
    _deleteOldRecords();
  }

  Future<void> fetchHistory() async {
    final data = await DatabaseService().getHistory();
    history.assignAll(data);
    _checkHistoryCount();
  }

  Future<void> addRecord(String date, int heartRate, int steps) async {
    await DatabaseService().insertRecord(date, heartRate, steps);
    fetchHistory();
  }

  Future<void> _deleteOldRecords() async {
    final sevenDaysAgo = DateTime.now().subtract(Duration(days: 7)).toIso8601String();
    await DatabaseService().deleteOldRecords(sevenDaysAgo);
    fetchHistory();
  }

  Future<void> _checkHistoryCount() async {
    if (history.length > 100) {
      final excessCount = history.length - 100;
      await DatabaseService().deleteExcessRecords(excessCount);
      fetchHistory();
    }
  }
}
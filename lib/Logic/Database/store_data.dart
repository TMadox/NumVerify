import 'package:enterpreware_task/Data/Models/number_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreData {
  Future<void> storeData({required List<NumberModel> input}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = numberModelToJson(data: input);
    prefs.setString("history", data);
  }
}

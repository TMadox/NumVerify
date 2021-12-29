import 'package:enterpreware_task/Data/Models/number_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadData {
  Future<List<NumberModel>?> readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("history") && prefs.getString("history") != null) {
      String? data = prefs.getString("history");
      return numberListFromJson(input: data!);
    }
  }
}

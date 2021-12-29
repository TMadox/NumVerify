import 'package:enterpreware_task/Data/Models/number_model.dart';
import 'package:enterpreware_task/Logic/Database/store_data.dart';
import 'package:flutter/cupertino.dart';

class NumberState extends ChangeNotifier {
  List<NumberModel> history = [];
  final StoreData _storeData = StoreData();
  NumberModel? foundNumber;
  List<String> foundCountries = [];

  void fillHistory({required List<NumberModel> input}) {
    history = input;
    filterCountries();
  }

  Future<void> addToHistory(NumberModel input) async {
    foundNumber = input;
    if (input.valid != false) {
      history.add(input);
      addToFilteredCountries(input: input);
      await _storeData.storeData(input: history);
    }
    notifyListeners();
  }

  filterCountries() {
    for (var element in history) {
      if (!foundCountries.contains(element.countryName) &&
          element.countryName != "") {
        foundCountries.add(element.countryName);
      }
    }
  }

  addToFilteredCountries({required NumberModel input}) {
    if (!foundCountries.contains(input.countryName) &&
        input.countryName != "") {
      foundCountries.add(input.countryName);
    }
  }
}

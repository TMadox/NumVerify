import 'package:flutter/foundation.dart';

class GeneralState extends ChangeNotifier {
  bool isLoading = false;
  void setIsLoading({required bool input}) {
    isLoading = input;
    notifyListeners();
  }
}

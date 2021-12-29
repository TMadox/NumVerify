import 'package:dio/dio.dart';
import 'package:enterpreware_task/Data/Constants/service_constants.dart';
import 'package:enterpreware_task/Data/Models/number_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHelper {
  static Dio dio = Dio();
  static Future<NumberModel> getData({
    required String number,
  }) async {
    final String? _key = dotenv.env['api_key'];
    final response = await dio.get(baseUrl,
        queryParameters: {"access_key": _key, "number": number},
        options: Options(receiveTimeout: 300, sendTimeout: 300));
    if (response.data["success"] == false) {
      throw response.data["error"]["code"].toString();
    }
    return NumberModel.fromJson(response.data);
  }
}

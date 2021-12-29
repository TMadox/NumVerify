import 'package:dio/dio.dart';
import 'package:enterpreware_task/Data/Constants/colors.dart';
import 'package:enterpreware_task/Data/Models/number_model.dart';
import 'package:enterpreware_task/Logic/Provider/general_state_class.dart';
import 'package:enterpreware_task/Logic/Provider/numbers_state_class.dart';
import 'package:enterpreware_task/Logic/Services/dio_helper.dart';
import 'package:enterpreware_task/Logic/Services/exceptions.dart';
import 'package:enterpreware_task/Logic/Services/other_exceptions.dart';
import 'package:enterpreware_task/Misc/screen_size.dart';
import 'package:enterpreware_task/View/Widgets/error_dialog.dart';
import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:resize/src/resizeExtension.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  OtherExceptions _exceptions = OtherExceptions();
  PhoneNumber _phoneNumber = PhoneNumber();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<GeneralState>().isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: petrolBlue,
      ),
      child: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.06,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: petrolBlue, width: 2)),
                      height: screenHeight(context) * 0.55,
                      width: screenWidth(context) * 0.9,
                      child: Consumer<NumberState>(
                        builder: (BuildContext context, ref, Widget? child) {
                          NumberModel? number = ref.foundNumber;
                          if (number != null) {
                            return ListView(
                                children: ListTile
                                    .divideTiles(context: context, tiles: [
                              ListTile(
                                title: const Text("Valid"),
                                subtitle: Text(number.valid.toString()),
                              ),
                              ListTile(
                                title: const Text("Local Format"),
                                subtitle: Text(number.localFormat.toString()),
                              ),
                              ListTile(
                                title: const Text("Intl. Format"),
                                subtitle: Text(number.intlFormat.toString()),
                              ),
                              ListTile(
                                title: const Text("Country"),
                                subtitle: Text(number.countryName.toString()),
                              ),
                              ListTile(
                                title: const Text("Location"),
                                subtitle: Text(number.location.toString() == ""
                                    ? "Not Found"
                                    : number.location.toString()),
                              ),
                              ListTile(
                                title: const Text("Carrier"),
                                subtitle: Text(number.carrier.toString()),
                              ),
                              ListTile(
                                title: const Text("Line Type"),
                                subtitle: Text(number.lineType.toString()),
                              ),
                            ]).toList());
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 40.w,
                                  color: orange,
                                ),
                                Text(
                                  "Search something or do stuff..",
                                  style: TextStyle(fontSize: 10.sp),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context) * 0.06,
                  ),
                  SizedBox(
                    width: screenWidth(context) * 0.5,
                    child: Row(
                      children: [
                        Expanded(
                          child: InternationalPhoneNumberInput(
                            cursorColor: orange,
                            onInputChanged: (value) {
                              _phoneNumber = value;
                            },
                            onSubmit: () {
                              requestData(
                                context: context,
                              );
                            },
                            selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                                leadingPadding: 3.w,
                                trailingSpace: false),
                            inputDecoration: const InputDecoration(
                              hintText: "Enter the number",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: petrolBlue),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: petrolBlue),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context) * 0.01,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: petrolBlue, width: 2)),
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              onTap: () {
                                requestData(
                                  context: context,
                                );
                              },
                              child: Icon(
                                Icons.search,
                                color: petrolBlue,
                                size: (screenWidth(context) /
                                        screenWidth(context)) *
                                    50,
                              ),
                            ))
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  requestData({required BuildContext context}) async {
    try {
      context.read<GeneralState>().setIsLoading(input: true);
      await DioHelper.getData(number: _phoneNumber.phoneNumber.toString()).then(
          (value) async =>
              await context.read<NumberState>().addToHistory(value));
    } catch (e) {
      if (e is DioError) {
        String message = DioExceptions.fromDioError(e).toString();
        showErrorDialog(context: context, description: message, title: "Error");
      } else {
        showErrorDialog(
            context: context,
            description: _exceptions.handleError(e.toString()),
            title: "Error");
      }
    } finally {
      context.read<GeneralState>().setIsLoading(input: false);
    }
  }
}

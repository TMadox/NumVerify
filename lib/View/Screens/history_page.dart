import 'package:auto_size_text/auto_size_text.dart';
import 'package:enterpreware_task/Data/Constants/colors.dart';
import 'package:enterpreware_task/Data/Models/number_model.dart';
import 'package:enterpreware_task/Logic/Provider/numbers_state_class.dart';
import 'package:enterpreware_task/Misc/screen_size.dart';
import 'package:enterpreware_task/View/Widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/src/resizeExtension.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Consumer<NumberState>(
        builder: (BuildContext context, ref, Widget? child) {
          List<NumberModel> history = ref.history;
          List<String> countries = ref.foundCountries;
          if (history.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history_toggle_off,
                  size: (screenWidth(context) / screenWidth(context)) * 100,
                ),
                AutoSizeText(
                  "No history here, not yet.",
                  style: TextStyle(
                      fontSize:
                          (screenWidth(context) / screenWidth(context)) * 40),
                )
              ],
            );
          }
          return SizedBox(
            height: constrains.maxHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: true,
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int countriesIndex) {
                return Card(
                  child: SizedBox(
                    height: constrains.maxHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: offWhite,
                          width: screenWidth(context) * 0.2,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context) * 0.01,
                              vertical: screenHeight(context) * 0.01),
                          child: AutoSizeText(
                            countries[countriesIndex],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: constrains.maxWidth * 0.20,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: history
                                .where((element) =>
                                    element.countryName ==
                                    countries[countriesIndex])
                                .length,
                            itemBuilder:
                                (BuildContext context, int numbersIndex) {
                              List<NumberModel> list = history
                                  .where((element) =>
                                      element.countryName ==
                                      countries[countriesIndex])
                                  .toList();

                              return InkWell(
                                onTap: () => showInfoDialog(
                                    context: context,
                                    number: list[numbersIndex]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: screenHeight(context) * 0.008),
                                    AutoSizeText(
                                      list[numbersIndex].localFormat,
                                      style: TextStyle(fontSize: 5.sp),
                                    ),
                                    const Divider()
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}

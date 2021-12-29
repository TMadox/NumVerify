import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:enterpreware_task/Data/Constants/Colors.dart';
import 'package:enterpreware_task/Logic/Database/read_data.dart';
import 'package:enterpreware_task/Logic/Provider/numbers_state_class.dart';
import 'package:enterpreware_task/Misc/screen_size.dart';
import 'package:enterpreware_task/View/Screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final ReadData _readData = ReadData();
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
        splashIconSize: screenWidth(context) * 0.6,
        duration: 0,
        splash: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "Assets/splash_logo.png",
          ),
        ]),
        backgroundColor: petrolBlue,
        screenFunction: () async {
          await _readData.readData().then((value) {
            if (value != null) {
              context.read<NumberState>().fillHistory(input: value);
            }
          });
          return const LandingPage();
        });
  }
}

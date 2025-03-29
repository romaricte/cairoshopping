// ignore: file_names
import 'dart:async';
import 'package:cairoshopping/ui/intro/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';
import 'package:cairoshopping/constants/pref_data.dart';
import 'package:cairoshopping/constants/size_config.dart';
import 'package:cairoshopping/constants/widget_utils.dart';
import 'package:cairoshopping/constants/color_data.dart';
//  import 'package:cairoshopping/main_project.dart';
 import 'package:cairoshopping/ui/home/home_screen.dart';
import 'package:cairoshopping/ui/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        PrefData.isLogIn().then((value) {
          if (value) {

               Constant.sendToScreen(IntroScreen(), context);

          } else {
            PrefData.setLogIn(true);

               Constant.sendToScreen(const LoginScreen(), context);

          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenHeight = SizeConfig.safeBlockVertical! * 100;

    double iconSize = Constant.getPercentSize(screenHeight, 10);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(Constant.getPercentSize(iconSize, 25)),
                  child:getSvgImage("logo_img.svg", iconSize,color:fontBlack )
                  // Image.asset(
                  //   Constant.assetImagePath + "logo_img.png",
                  //   width: iconSize,
                  //   height: iconSize,
                  //   fit: BoxFit.fill,
                  //   color: fontBlack,
                  // ),
                ),
                getCustomText("SHOPPING", fontBlack, 1, TextAlign.center,
                    FontWeight.w900, Constant.getPercentSize(screenHeight, 5.5))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToFinish(context);
          return false;
        });
  }
}

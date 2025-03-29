
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';

import '../../constants/pref_data.dart';
import '../../constants/size_config.dart';
import '../../constants/widget_utils.dart';
import '../../constants/color_data.dart';
import '../../constants/flutter_pin_code_fields.dart';
// import '../home/home_screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VerifyScreen();
  }
}

class _VerifyScreen extends State<VerifyScreen> {
  void backScreen() {
    Constant.backToFinish(context);
  }

  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    double appBarPadding = getAppBarPadding();

    return WillPopScope(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: getBackgroundWidget(Container(
            padding: EdgeInsets.all(appBarPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        backScreen();
                      },
                      child: Icon(
                        Icons.keyboard_backspace_rounded,
                        size: getEdtIconSize(),
                        color: fontBlack,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    getCustomText("Verify Code", fontBlack, 1, TextAlign.center,
                        FontWeight.w800, getLoginTitleFontSize()),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                  ],
                ),
                getSpace(appBarPadding),
                getCustomTextWithoutMaxLine(
                    "Please enter verify code that we've \nsent to your email.",
                    fontBlack,
                    TextAlign.center,
                    FontWeight.w400,
                    getEdtTextSize()),
                getSpace(appBarPadding/2),

                PinCodeFields(
                  length: 4,
                  fieldBorderStyle: FieldBorderStyle.square,
                  controller: newTextEditingController,
                  activeBorderColor: primaryColor,
                  padding: EdgeInsets.zero,
                  focusNode: focusNode,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: Constant.getPercentSize(screenWidth,5.5),
                      fontFamily: Constant.fontsFamily,
                      fontWeight: FontWeight.w500),
                  margin: EdgeInsets.all(
                      Constant.getPercentSize(appBarPadding, 70)),
                  borderWidth: 0.5,
                  borderColor: greyFont,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Constant.getPercentSize(screenWidth, 3))),
                  fieldHeight: Constant.getPercentSize(screenWidth, 14),
                  onComplete: (result) {
                    // Your logic with code
                  },
                ),
                getSpace(appBarPadding),
                getButton(
                    primaryColor,
                    true,
                    "Verify",
                    Colors.white,
                    () {
                      PrefData.setLogIn(true);

                      // Constant.sendToScreen(HomeScreen(), context);

                    },
                    FontWeight.w600,
                    EdgeInsets.symmetric(vertical: appBarPadding))
              ],
            ),
          )),
        ),
        onWillPop: () async {
          backScreen();
          return false;
        });
  }

  @override
  void dispose() {
    try {
      newTextEditingController.dispose();
      focusNode.dispose();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    super.dispose();
  }
}

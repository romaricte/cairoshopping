// ignore: file_names

import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';
import 'package:cairoshopping/ui/login/change_password_screen.dart';

import '../../constants/size_config.dart';
import '../../constants/widget_utils.dart';
import '../../constants/color_data.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordScreen();
  }
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  void backScreen() {
    Constant.backToFinish(context);
  }

  FocusNode focusNode = FocusNode();
  TextEditingController emailSignInController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                    getCustomText("Forgot Password", fontBlack, 1, TextAlign.center,
                        FontWeight.w800, getLoginTitleFontSize()),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                  ],
                ),
                getSpace(appBarPadding),
                getCustomTextWithoutMaxLine(
                    "Please enter email for forgot your\npassword.",
                    fontBlack,
                    TextAlign.center,
                    FontWeight.w400,
                    getEdtTextSize()),
                getSpace(appBarPadding),
                getLoginTextField(
                    emailSignInController, "Email", "email.svg"),
                getSpace(appBarPadding),
                getButton(
                    primaryColor,
                    true,
                    "Submit",
                    Colors.white,
                    () {
                      Constant.sendToScreen(const ChangePasswordScreen(),context);
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
      emailSignInController.dispose();
      focusNode.dispose();
    // ignore: empty_catches
    } catch (e) {
    }


    super.dispose();
  }
}

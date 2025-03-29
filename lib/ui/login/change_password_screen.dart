// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';
import 'package:cairoshopping/ui/intro/splash_screen.dart';

import '../../constants/size_config.dart';
import '../../constants/widget_utils.dart';
import '../../constants/color_data.dart';
import 'reset_password_dialog_box.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreen();
  }
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  void backScreen() {
    Constant.backToFinish(context);
  }

  FocusNode focusNode = FocusNode();
  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passSignInController = TextEditingController();
  ValueNotifier<bool> isShowPass = ValueNotifier(false);
  ValueNotifier<bool> confirmShowPass = ValueNotifier(false);

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
                    getCustomText(
                        "Change Password",
                        fontBlack,
                        1,
                        TextAlign.center,
                        FontWeight.w800,
                        getLoginTitleFontSize()),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                  ],
                ),
                getSpace(appBarPadding),
                getCustomTextWithoutMaxLine(
                    "Please enter new password for\nchange your password.",
                    fontBlack,
                    TextAlign.center,
                    FontWeight.w400,
                    getEdtTextSize()),
                getSpace(appBarPadding),
                ValueListenableBuilder(
                  builder: (context, value, child) {
                    return getPassTextField(emailSignInController, "Password",
                        "Lock.svg", isShowPass.value, () {
                      isShowPass.value = !isShowPass.value;
                    });
                  },
                  valueListenable: isShowPass,
                ),
                ValueListenableBuilder(
                  builder: (context, value, child) {
                    return getPassTextField(
                        passSignInController,
                        "Confirm Password",
                        "Lock.svg",
                        confirmShowPass.value, () {
                      confirmShowPass.value = !confirmShowPass.value;
                    });
                  },
                  valueListenable: confirmShowPass,
                ),
                getSpace(appBarPadding),
                getButton(primaryColor, true, "Submit", Colors.white, () {
                  // Constant.sendToScreen(SplashScreen(), context);
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ResetPasswordDialogBox(

                          func: () {

                            Constant.sendToScreen(const SplashScreen(), context);

                          },
                        );
                      });




                }, FontWeight.w600,
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
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    super.dispose();
  }
}

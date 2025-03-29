// ignore: file_names
import 'dart:convert';
import 'package:country_state_city_picker/model/select_status_model.dart' as status;
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cairoshopping/constants/pref_data.dart';
import 'package:cairoshopping/constants/size_config.dart';
import 'package:cairoshopping/constants/color_data.dart';
import 'package:cairoshopping/ui/login/verify_screen.dart';

import '../../constants/constant.dart';
import '../../constants/widget_utils.dart';
// import '../home/home_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabbar = 0;
  TextEditingController emailRegPhoneController = TextEditingController();
  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passSignInController = TextEditingController();
  ValueNotifier<bool> isShowPass = ValueNotifier(false);
  bool chkVal = false;

  Future getResponse() async {
    var res = await rootBundle.loadString('assets/country.json');
    return jsonDecode(res);
  }

  List<String> country = ["Choose Country"];
  String _selectedCountry = "Choose Country";

  @override
  void initState() {
    getCounty();
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    for (var data in countryres) {
      var model = status.StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) return;
      setState(() {
        country.add(model.emoji! + "    " + model.name!);
      });
    }

    return country;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    double appbarPadding = getAppBarPadding();
    double height = getEditHeight();
    double radius = Constant.getPercentSize(height, 20);
    double fontSize = Constant.getPercentSize(height, 30);
    double privacySize = Constant.getPercentSize(getEditHeight(),25);

    TextStyle style = TextStyle(
        color: fontBlack,
        fontSize: fontSize,
        fontFamily: Constant.fontsFamily,
        fontWeight: FontWeight.w500);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: getBackgroundWidget(Column(
            children: [
              TabBar(
                onTap: (value) {
                  _selectedTabbar = value;
                  setState(() {});
                },
                tabs: [
                  Tab(
                      child: Text(
                    "Sign in",
                    style: TextStyle(
                      decoration: (_selectedTabbar == 0)
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: primaryColor.withOpacity(0.4),
                      decorationThickness: 6,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  )),
                  Tab(
                      child: Text(
                    "Register",
                    style: TextStyle(
                      decoration: (_selectedTabbar == 1)
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: primaryColor.withOpacity(0.4),
                      decorationThickness: 6,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ))
                ],
                unselectedLabelColor: Colors.grey,
                labelColor: fontBlack,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 0,
                indicatorPadding: EdgeInsets.zero,
                // indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.zero,
                indicatorColor: primaryColor,
                indicator: const UnderlineTabIndicator(
                  insets: EdgeInsets.all(0),
                ),
                padding: EdgeInsets.zero,
                labelStyle: TextStyle(
                    color: fontBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: Constant.getPercentSize(screenHeight, 3)),
                controller: _tabController,
                isScrollable: false,
              ),
              (_selectedTabbar == 0)
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: Constant.getPercentSize(screenWidth, 4)),
                      child: Column(
                        children: [
                          getSpace(Constant.getPercentSize(screenHeight, 3)),
                          getLoginTextField(
                              emailSignInController, "Email", "email.svg"),
                          ValueListenableBuilder(
                            builder: (context, value, child) {
                              return getPassTextField(passSignInController,
                                  "Password", "Lock.svg", isShowPass.value, () {
                                isShowPass.value = !isShowPass.value;
                              });
                            },
                            valueListenable: isShowPass,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Constant.sendToScreen(
                                      const ForgotPasswordScreen(), context);
                                },
                                child: getCustomText(
                                    "Forgot Password?",
                                    fontBlack,
                                    1,
                                    TextAlign.end,
                                    FontWeight.bold,
                                    Constant.getPercentSize(screenHeight, 2.3)),
                              )),
                          getSpace(appbarPadding / 2),
                          getButton(primaryColor, true, "Sign In", Colors.white,
                              () {
                            PrefData.setLogIn(true);

                              // Constant.sendToScreen(HomeScreen(), context);

                          }, FontWeight.w500,
                              EdgeInsets.symmetric(vertical: appbarPadding)),
                          getCustomText(
                              "Or sign in with",
                              Colors.grey,
                              1,
                              TextAlign.center,
                              FontWeight.w400,
                              Constant.getPercentSize(screenHeight, 2.2)),
                          Row(
                            children: [
                              Expanded(
                                child: getButtonContainer(
                                    Row(
                                      children: [
                                        getSvgImage(
                                            "google.svg", getEdtIconSize()),
                                        getHorSpace(Constant.getPercentSize(
                                            screenWidth, 1.7)),
                                        getCustomText(
                                            "Google",
                                            fontBlack,
                                            1,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            getEdtTextSize())
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                    EdgeInsets.only(
                                        left: 0,
                                        top: appbarPadding,
                                        bottom: appbarPadding,
                                        right: appbarPadding / 2),
                                    backgroundColor),
                                flex: 1,
                              ),
                              Expanded(
                                child: getButtonContainer(
                                    Row(
                                      children: [
                                        getSvgImage(
                                            "facebook.svg", getEdtIconSize()),
                                        getHorSpace(Constant.getPercentSize(
                                            screenWidth, 1.7)),
                                        getCustomText(
                                            "Facebook",
                                            fontBlack,
                                            1,
                                            TextAlign.center,
                                            FontWeight.bold,
                                            getEdtTextSize())
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                    EdgeInsets.only(
                                        left: appbarPadding / 2,
                                        top: appbarPadding,
                                        bottom: appbarPadding,
                                        right: 0),
                                    backgroundColor),
                                flex: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: Constant.getPercentSize(screenWidth, 4)),
                      child: Column(
                        children: [
                          getSpace(Constant.getPercentSize(screenHeight, 3)),
                          getLoginTextField(
                              emailSignInController, "Email", "email.svg"),
                          getLoginTextField(emailRegPhoneController,
                              "Phone Number", "Call_Calling.svg"),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Constant.getHeightPercentSize(1.2)),
                            child: SizedBox(
                              height: height,
                              child: Container(
                                // margin: EdgeInsets.symmetric(
                                //     vertical: Constant.getHeightPercentSize(1.2)),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Constant.getWidthPercentSize(2.5)),
                                decoration: ShapeDecoration(
                                  color: Colors.transparent,
                                  shape: SmoothRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.shade400, width: 1),
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: radius,
                                      cornerSmoothing: 0.8,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    dropdownColor: backgroundColor,
                                    isExpanded: true,
                                    itemHeight: null,
                                    isDense: true,
                                    underline: getSpace(0),
                                    items: country
                                        .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Row(
                                          children: [
                                            Text(
                                              dropDownStringItem,
                                              style: style,
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCountry = value!;
                                      });
                                    },
                                    value: _selectedCountry,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            builder: (context, value, child) {
                              return getPassTextField(passSignInController,
                                  "Password", "Lock.svg", isShowPass.value, () {
                                isShowPass.value = !isShowPass.value;
                              });
                            },
                            valueListenable: isShowPass,
                          ),
                          getSpace(appbarPadding / 2),
                          Row(
                            children: [
                              SizedBox(
                                height: getEdtIconSize(),
                                width: getEdtIconSize(),
                                child: Checkbox(
                                  onChanged: (value) {
                                    setState(() {
                                      chkVal = value!;
                                    });
                                  },
                                  value: chkVal,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: BorderSide(width: 0.5, color: greyFont),
                                  activeColor: primaryColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                              getHorSpace(
                                  Constant.getPercentSize(screenWidth, 1.5)),
                              getCustomText(
                                  "I accepted",
                                  fontBlack,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w400,
                                  privacySize),
                              getHorSpace(
                                  Constant.getPercentSize(screenWidth, 1.5)),
                              Expanded(child: getCustomText(
                                  "Terms & Privacy Policy",
                                  primaryColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w400,
                                  privacySize),flex: 1,)

                            ],
                          ),
                          getSpace(appbarPadding / 2),
                          getButton(
                              primaryColor, true, "Register", Colors.white, () {
                            Constant.sendToScreen(const VerifyScreen(), context);
                          }, FontWeight.w500,
                              EdgeInsets.symmetric(vertical: appbarPadding)),
                        ],
                      ),
                    ),
              // TabBarView(
              //   children: [
              //     Container(
              //       width: double.infinity,
              //       padding: EdgeInsets.symmetric(
              //           horizontal: Constant.getPercentSize(
              //               screenWidth, 4)),
              //       child: Column(
              //         children: [
              //           getSpace(Constant.getPercentSize(
              //               screenHeight, 5)),
              //           getLoginTextField(emailSignInController,
              //               "Email", "Lock.svg"),
              //           getPassTextField(passSignInController,
              //               "Password", "Lock.svg", false),
              //         ],
              //       ),
              //     ),
              //     // Text("etetetet", style: TextStyle(color: Colors.black87)),
              //     Text("5758689789")
              //   ],
              //   controller: _tabController,
              // ),
            ],
          )),
        ),
        onWillPop: () async {
          Constant.closeApp();
          return false;
        });

    // return WillPopScope(
    //     child: Scaffold(
    //       backgroundColor: backgroundColor,
    //       body: Container(
    //         width: double.infinity,
    //         height: double.infinity,
    //         child: Stack(
    //           children: [
    //             Container(
    //               width: double.infinity,
    //               height: getTopViewHeight(),
    //               padding: EdgeInsets.only(bottom: getTopViewHeight() / 4),
    //               decoration: ShapeDecoration(
    //                   color: primaryColor,
    //                   shape: SmoothRectangleBorder(
    //                       borderRadius: SmoothBorderRadius.only(
    //                           bottomLeft: SmoothRadius(
    //                               cornerRadius: size, cornerSmoothing: 0.8),
    //                           bottomRight: SmoothRadius(
    //                               cornerRadius: size, cornerSmoothing: 0.8)))),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Image.asset(
    //                     Constant.assetImagePath + "logo_img.png",
    //                     height: imgSize,
    //                     width: imgSize,
    //                   ),
    //                   getHorSpace(Constant.getPercentSize(screenWidth, 3)),
    //                   getCustomText(
    //                       "Shopping",
    //                       Colors.white,
    //                       1,
    //                       TextAlign.start,
    //                       FontWeight.bold,
    //                       Constant.getPercentSize(imgSize, 65))
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               width: double.infinity,
    //               height: double.infinity,
    //               child: Column(
    //                 children: [
    //                   getSpace(topHeight),
    //                   Expanded(
    //                     child: SingleChildScrollView(
    //                       child: Container(
    //                         width: double.infinity,
    //                         decoration: ShapeDecoration(
    //                             color: Colors.white,
    //                             shadows: [
    //                               BoxShadow(
    //                                   blurRadius: 3,
    //                                   color: Colors.black.withAlpha(20))
    //                             ],
    //                             shape: SmoothRectangleBorder(
    //                                 borderRadius: SmoothBorderRadius.all(
    //                                     SmoothRadius(
    //                                         cornerSmoothing: 0.5,
    //                                         cornerRadius:
    //                                             Constant.getPercentSize(
    //                                                 getRemainSize, 4))))),
    //                         margin: EdgeInsets.only(
    //                             // top: topHeight,
    //                             left: size / 2.2,
    //                             right: size / 2.2,
    //                             bottom: Constant.getPercentSize(
    //                                 getTopViewHeight(), 10)),
    //                         child: Column(
    //                           children: [
    //                             TabBar(
    //                               onTap: (value) {
    //                                 _selectedTabbar = value;
    //                                 setState(() {});
    //                               },
    //                               tabs: [
    //                                 Tab(
    //                                     child: Text(
    //                                   "Sign in",
    //                                   style: TextStyle(
    //                                     decoration: (_selectedTabbar == 0)
    //                                         ? TextDecoration.underline
    //                                         : TextDecoration.none,
    //                                     decorationColor:
    //                                         primaryColor.withOpacity(0.4),
    //                                     decorationThickness: 6,
    //                                     decorationStyle:
    //                                         TextDecorationStyle.solid,
    //                                   ),
    //                                 )),
    //                                 Tab(
    //                                     child: Text(
    //                                   "Register",
    //                                   style: TextStyle(
    //                                     decoration: (_selectedTabbar == 1)
    //                                         ? TextDecoration.underline
    //                                         : TextDecoration.none,
    //                                     decorationColor:
    //                                         primaryColor.withOpacity(0.4),
    //                                     decorationThickness: 6,
    //                                     decorationStyle:
    //                                         TextDecorationStyle.solid,
    //                                   ),
    //                                 ))
    //                               ],
    //                               unselectedLabelColor: Colors.grey,
    //                               labelColor: fontBlack,
    //                               indicatorSize: TabBarIndicatorSize.tab,
    //                               indicatorWeight: 0,
    //                               indicatorPadding: EdgeInsets.zero,
    //                               // indicatorSize: TabBarIndicatorSize.label,
    //                               labelPadding: EdgeInsets.zero,
    //                               indicatorColor: primaryColor,
    //                               indicator: UnderlineTabIndicator(
    //                                 insets: EdgeInsets.all(0),
    //                               ),
    //                               padding: EdgeInsets.zero,
    //                               labelStyle: TextStyle(
    //                                   color: fontBlack,
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: Constant.getPercentSize(
    //                                       screenHeight, 3)),
    //                               controller: _tabController,
    //                               isScrollable: false,
    //                             ),
    //                             (_selectedTabbar == 0)
    //                                 ? Container(
    //                                     width: double.infinity,
    //                                     padding: EdgeInsets.symmetric(
    //                                         horizontal: Constant.getPercentSize(
    //                                             screenWidth, 4)),
    //                                     child: Column(
    //                                       children: [
    //                                         getSpace(Constant.getPercentSize(
    //                                             screenHeight, 5)),
    //                                         getLoginTextField(
    //                                             emailSignInController,
    //                                             "Email",
    //                                             "email.svg"),
    //                                         ValueListenableBuilder(
    //                                           builder: (context, value, child) {
    //                                             return getPassTextField(
    //                                                 passSignInController,
    //                                                 "Password",
    //                                                 "Lock.svg",
    //                                                 isShowPass.value, () {
    //                                               isShowPass.value =
    //                                                   !isShowPass.value;
    //                                             });
    //                                           },
    //                                           valueListenable: isShowPass,
    //                                         ),
    //                                         Align(
    //                                           alignment: Alignment.centerRight,
    //                                           child: getCustomText(
    //                                               "Forgot Password?",
    //                                               fontBlack,
    //                                               1,
    //                                               TextAlign.end,
    //                                               FontWeight.bold,
    //                                               Constant.getPercentSize(
    //                                                   screenHeight, 2.3))
    //                                         ),
    //                                         getSpace(appba)
    //                                       ],
    //                                     ),
    //                                   )
    //                                 : Text("we4et4645654654"),
    //                             // TabBarView(
    //                             //   children: [
    //                             //     Container(
    //                             //       width: double.infinity,
    //                             //       padding: EdgeInsets.symmetric(
    //                             //           horizontal: Constant.getPercentSize(
    //                             //               screenWidth, 4)),
    //                             //       child: Column(
    //                             //         children: [
    //                             //           getSpace(Constant.getPercentSize(
    //                             //               screenHeight, 5)),
    //                             //           getLoginTextField(emailSignInController,
    //                             //               "Email", "Lock.svg"),
    //                             //           getPassTextField(passSignInController,
    //                             //               "Password", "Lock.svg", false),
    //                             //         ],
    //                             //       ),
    //                             //     ),
    //                             //     // Text("etetetet", style: TextStyle(color: Colors.black87)),
    //                             //     Text("5758689789")
    //                             //   ],
    //                             //   controller: _tabController,
    //                             // ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     flex: 1,
    //                   )
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     onWillPop: () async {
    //       return false;
    //     });
  }
}

// ignore: file_names
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/data_file.dart';
import 'package:cairoshopping/constants/size_config.dart';
import 'package:cairoshopping/constants/widget_utils.dart';
import 'package:cairoshopping/constants/color_data.dart';
import 'package:cairoshopping/models/model_intro.dart';
import 'package:cairoshopping/ui/home/home_screen.dart';
import '../../constants/constant.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  List<ModelIntro> introList = DataFile.getAllIntroData();
  int selectedPos = 0;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;

    double horMargin = Constant.getPercentSize(screenWidth, 5);
    double verMargin = Constant.getPercentSize(screenHeight, 1.3);
    return WillPopScope(
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Stack(
                  children: [
                    PageView.builder(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          selectedPos = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.asset(
                            Constant.assetImagePath + introList[index].image!,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      itemCount: introList.length,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        getCustomTextWithoutMaxLine(
                            introList[selectedPos].title ?? "",
                            Colors.white,
                            TextAlign.center,
                            FontWeight.bold,
                            // TextAlign.center, FontWeight.w400,
                            Constant.getPercentSize(screenHeight, 5.2)),
                        getSpace(Constant.getPercentSize(screenHeight, 1.8)),
                        getCustomTextWithoutMaxLine(
                            introList[selectedPos].description ?? "",
                            Colors.white,
                            TextAlign.center,
                            FontWeight.normal,
                            // TextAlign.center, FontWeight.w400,
                            Constant.getPercentSize(screenHeight, 2.2)),
                        getSpace(Constant.getPercentSize(screenHeight, 2)),
                        DotsIndicator(
                          dotsCount: introList.length,
                          position: selectedPos.toDouble(),
                          decorator: const DotsDecorator(
                            color: Colors.white24, // Inactive color
                            activeColor: Colors.white,
                          ),
                        ),
                        getSpace(Constant.getPercentSize(screenHeight, 2)),
                        (selectedPos == introList.length - 1)
                            ? getButton(
                                Colors.white,
                                true,
                                "Sign In",
                                primaryColor,
                                () {},
                                FontWeight.w600,
                                EdgeInsets.symmetric(
                                    horizontal: horMargin, vertical: verMargin),
                                isBorder: false)
                            : getButton(
                                Colors.white,
                                true,
                                "Next",
                                primaryColor,
                                () {},
                                FontWeight.w600,
                                EdgeInsets.symmetric(
                                    horizontal: horMargin, vertical: verMargin),
                                isBorder: false),
                        (selectedPos == introList.length - 1)
                            ? getButton(Colors.transparent, true, "Register",
                                Colors.white, () {
                                 Constant.sendToScreen(HomeScreen(), context);
                              },
                                FontWeight.w400,
                                EdgeInsets.symmetric(
                                    horizontal: horMargin, vertical: verMargin),
                                isBorder: true,
                                borderColor: Colors.white)
                            : InkWell(
                                onTap: () {
                                    Constant.sendToScreen(HomeScreen(), context);
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: verMargin),
                                  child: getCustomText(
                                      "Skip",
                                      Colors.white,
                                      1,
                                      TextAlign.center,
                                      FontWeight.w300,
                                      Constant.getPercentSize(
                                          getEditHeight(), 32)),
                                ),
                              ),
                        getSpace(Constant.getPercentSize(screenHeight, 2.8)),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
        onWillPop: () async {
          Constant.closeApp();
          return false;
        });
  }
}

// ignore: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';
import 'package:cairoshopping/constants/data_file.dart';
import 'package:cairoshopping/constants/size_config.dart';
import 'package:cairoshopping/constants/widget_utils.dart';
import 'package:cairoshopping/constants/color_data.dart';
import 'package:cairoshopping/models/model_banner.dart';
import 'package:cairoshopping/models/model_category.dart';
import 'package:cairoshopping/models/model_trending.dart';
import 'package:cairoshopping/ui/home/home_screen.dart';




class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabHome();
  }
}

class _TabHome extends State<TabHome> {
  List<ModelBanner> bannerList = DataFile.getAllBanner();
  int selectedSlider = 0;

  getTitleWidget(double padding, String txt, Function function) {
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: Constant.getPercentSize(screenHeight, 1.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getCustomText(txt, fontBlack, 1, TextAlign.start, FontWeight.w800,
              Constant.getPercentSize(screenHeight, 3)),
          InkWell(
            onTap: () {
              function();
            },
            child: getCustomText("View all", primaryColor, 1, TextAlign.start,
                FontWeight.w400, Constant.getPercentSize(screenHeight, 2.3)),
          )
        ],
      ),
    );
  }

  List<ModelCategory> catList = DataFile.getAllCategory();
  List<ModelTrending> trendingList = DataFile.getAllTrendingProduct();
  List<ModelTrending> popularList = DataFile.getAllPopularProduct();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    double appbarPadding = getAppBarPadding();
    double iconSize = Constant.getPercentSize(screenHeight, 3);
    double carousalHeight = Constant.getPercentSize(screenWidth, 42);
    double categoryHeight = Constant.getPercentSize(screenHeight, 25);
    double categoryWidth = Constant.getPercentSize(categoryHeight, 58);
    double trendingHeight = Constant.getPercentSize(screenHeight, 42);
    double trendingWidth = Constant.getPercentSize(trendingHeight, 75);

    double marginPopular = appbarPadding;
    int crossAxisCountPopular = 2;
    double popularWidth =
        (screenWidth - ((crossAxisCountPopular - 1) * marginPopular)) /
            crossAxisCountPopular;
    // var _width = ( _screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;

    double popularHeight = trendingHeight;

    final List<Widget> imageSliders = bannerList
        .map((item) => SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Container(
                decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                            cornerRadius:
                                Constant.getPercentSize(carousalHeight, 8),
                            cornerSmoothing: 0.2))),
                // margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(
                        Constant.getPercentSize(carousalHeight, 8))),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          Constant.assetImagePath + item.image!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),

                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal:
                        //           Constant.getPercentSize(screenWidth, 4.5)),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       getCustomTextWithoutMaxLine(
                        //           item.title!,
                        //           Colors.white,
                        //           TextAlign.start,
                        //           FontWeight.w500,
                        //           Constant.getPercentSize(carousalHeight, 17),
                        //           txtHeight: 1.2)
                        //     ],
                        //   ),
                        // ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: primaryColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appbarPadding),
            child: AppBar(
              elevation: 0,
              backgroundColor: primaryColor,
              leadingWidth: Constant.getPercentSize(screenHeight, 18),
              leading: Builder(
                builder: (context) {
                  return Image.asset(
                    Constant.assetImagePath + "logo.png",
                    height: Constant.getPercentSize(screenHeight, 4),
                  );
                },
              ),
              actions: [
                InkWell(
                  child: getSvgImage("Bag.svg", iconSize, color: Colors.white),
                  onTap: () {
                    Constant.sendToScreen(HomeScreen(selectedTab: 2), context);
                  },
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: appbarPadding,
                right: appbarPadding,
                bottom: appbarPadding * 1.5,
                top: Constant.getPercentSize(appbarPadding, 30)),
            width: double.infinity,
            height: getEditHeight(),
            padding: EdgeInsets.symmetric(
                horizontal: Constant.getPercentSize(screenWidth, 3)),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                        cornerRadius: getCorners(),
                        cornerSmoothing: getCornerSmoothing()))),
            child: InkWell(
              onTap: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getSvgImage("Search.svg", getEdtIconSize()),
                  getHorSpace(Constant.getPercentSize(screenWidth, 2)),
                  Expanded(
                    flex: 1,
                    child: getCustomText("Search...", Colors.black54, 1,
                        TextAlign.start, FontWeight.w400, getEdtTextSize()),
                  ),
                  getSvgImage("filter.svg", getEdtIconSize()),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: backgroundColor,
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            Expanded(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    autoPlay: true,
                                    // viewportFraction:0.85,
                                    // aspectRatio: 1.8,
                                    // viewportFraction: 0.8,
                                    height: double.infinity,
                                    enlargeCenterPage: true,
                                    disableCenter: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        selectedSlider = index;
                                      });
                                    }),
                                items: imageSliders,
                              ),
                              flex: 1,
                            ),
                            DotsIndicator(
                              dotsCount: imageSliders.length,
                              position: selectedSlider.toDouble(),
                              decorator: DotsDecorator(
                                size: const Size(7, 7),
                                activeSize: const Size(7, 7),
                                color: primaryColor.withOpacity(0.3),
                                activeColor: primaryColor,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    height: carousalHeight + 10,
                    margin: EdgeInsets.only(
                        top: Constant.getPercentSize(screenHeight, 2)),
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: categoryHeight,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          ModelCategory modelCat = catList[index];
                          double itemMargin =
                              Constant.getPercentSize(categoryHeight, 4);
                          return InkWell(
                            onTap: () {

                            },
                            child: Container(
                              width: categoryWidth,
                              margin: (index == 0)
                                  ? EdgeInsets.only(
                                      left: appbarPadding,
                                      right: itemMargin,
                                      top: itemMargin,
                                      bottom: itemMargin)
                                  : EdgeInsets.all(itemMargin),
                              height: double.infinity,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                              borderRadius: SmoothBorderRadius(
                                                  cornerRadius:
                                                      Constant.getPercentSize(
                                                          categoryHeight, 50),
                                                  cornerSmoothing: 0.8)),
                                          color: Colors.transparent),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            Constant.getPercentSize(
                                                categoryHeight, 50),
                                          ),
                                        ),
                                        child: Image.asset(
                                          Constant.assetImagePath +
                                              modelCat.image!,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  getSpace(Constant.getPercentSize(
                                      categoryHeight, 6)),
                                  getCustomText(
                                      modelCat.title ?? "",
                                      fontBlack,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w700,
                                      Constant.getPercentSize(
                                          categoryHeight, 9)),
                                  getSpace(Constant.getPercentSize(
                                      categoryHeight, 4))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: catList.length),
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: trendingHeight,
                    child: ListView.builder(
                        primary: false,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          double itemMargin =
                              Constant.getPercentSize(trendingHeight, 4);
                          ModelTrending modelTrend = trendingList[index];
                          return InkWell(
                            onTap: () {
                              // Constant.sendToScreen(AllProductList(), context);
                            },
                            child: Container(
                              height: double.infinity,
                              width: trendingWidth,
                              padding: EdgeInsets.all(
                                  Constant.getPercentSize(trendingHeight, 3.3)),
                              margin: (index == 0)
                                  ? EdgeInsets.only(
                                      left: appbarPadding,
                                      right: itemMargin,
                                      top: itemMargin,
                                      bottom: itemMargin)
                                  : EdgeInsets.all(itemMargin),
                              decoration: ShapeDecoration(
                                  color: cardColor,
                                  shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                          cornerRadius: Constant.getPercentSize(
                                              trendingHeight, 4),
                                          cornerSmoothing: 0.5)),
                                  shadows: [
                                    BoxShadow(
                                        color: shadowColor,
                                        spreadRadius: 1.2,
                                        blurRadius: 2)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: ShapeDecoration(
                                        color: cardColor,
                                        shape: SmoothRectangleBorder(
                                            borderRadius: SmoothBorderRadius(
                                                cornerRadius:
                                                    Constant.getPercentSize(
                                                        trendingHeight, 4),
                                                cornerSmoothing: 0.3)),
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    Constant.getPercentSize(
                                                        trendingHeight, 4))),
                                            child: Image.asset(
                                                Constant.assetImagePath +
                                                    modelTrend.image!,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: getFavWidget(
                                                trendingHeight,
                                                false,
                                                EdgeInsets.all(
                                                    Constant.getPercentSize(
                                                        trendingWidth, 3))),
                                          )
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  getSpace(Constant.getPercentSize(
                                      trendingHeight, 5)),
                                  getCustomText(
                                      modelTrend.title ?? "",
                                      fontBlack,
                                      1,
                                      TextAlign.start,
                                      FontWeight.bold,
                                      Constant.getPercentSize(
                                          trendingHeight, 5.5)),
                                  getSpace(Constant.getPercentSize(
                                      trendingHeight, 2.5)),
                                  getCustomText(
                                      modelTrend.price ?? "",
                                      fontBlack,
                                      1,
                                      TextAlign.start,
                                      FontWeight.normal,
                                      Constant.getPercentSize(
                                          trendingHeight, 5.5))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: trendingList.length),
                  ),
                  getTitleWidget(appbarPadding, "Popular Products", () {

                  }),
                  GridView.count(
                    padding: EdgeInsets.only(
                        left: marginPopular,
                        right: marginPopular,
                        bottom: marginPopular,
                        top: marginPopular),
                    crossAxisCount: crossAxisCountPopular,
                    crossAxisSpacing: marginPopular,
                    mainAxisSpacing: marginPopular,
                    // crossAxisSpacing: 10,
                    childAspectRatio: popularWidth / popularHeight,
                    shrinkWrap: true,
                    primary: false,
                    children: List.generate(popularList.length, (index) {
                      ModelTrending modelPopular = popularList[index];
                      return InkWell(
                        onTap: () {
                          // Constant.sendToScreen(AllProductList(), context);

                        },
                        child: Container(
                          height: popularHeight,
                          width: popularWidth,
                          padding: EdgeInsets.all(
                              Constant.getPercentSize(popularHeight, 3.3)),
                          decoration: ShapeDecoration(
                              color: cardColor,
                              shape: SmoothRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                      cornerRadius: Constant.getPercentSize(
                                          popularHeight, 4),
                                      cornerSmoothing: 0.5)),
                              shadows: [
                                BoxShadow(
                                    color: shadowColor,
                                    spreadRadius: 1.2,
                                    blurRadius: 2)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: ShapeDecoration(
                                    color: cardColor,
                                    shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                            cornerRadius:
                                                Constant.getPercentSize(
                                                    popularHeight, 4),
                                            cornerSmoothing: 0.3)),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Constant.getPercentSize(
                                                    popularHeight, 5))),
                                        child: Image.asset(
                                            Constant.assetImagePath +
                                                modelPopular.image!,
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: getFavWidget(
                                            popularHeight,
                                            index == 0,
                                            EdgeInsets.all(
                                                Constant.getPercentSize(
                                                    popularWidth, 3))),
                                      ),
                                      ((modelPopular.sale ?? "").isNotEmpty)
                                          ? Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                margin: EdgeInsets.all(
                                                    Constant.getPercentSize(
                                                        popularWidth, 2.5)),
                                                child: getCustomText(
                                                    "SALE",
                                                    Colors.white,
                                                    1,
                                                    TextAlign.start,
                                                    FontWeight.normal,
                                                    Constant.getPercentSize(
                                                        popularHeight, 4)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Constant.getPercentSize(
                                                            popularWidth, 5),
                                                    vertical:
                                                        Constant.getPercentSize(
                                                            popularWidth, 3)),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            Constant
                                                                .getPercentSize(
                                                                    popularHeight,
                                                                    5))),
                                                    color: Colors.black),
                                              ),
                                            )
                                          : getSpace(0)
                                    ],
                                  ),
                                ),
                                flex: 1,
                              ),
                              getSpace(
                                  Constant.getPercentSize(popularHeight, 4)),
                              getCustomText(
                                  modelPopular.title ?? "",
                                  fontBlack,
                                  1,
                                  TextAlign.start,
                                  FontWeight.bold,
                                  Constant.getPercentSize(popularHeight, 5.5)),
                              getSpace(
                                  Constant.getPercentSize(popularHeight, 2.5)),
                              Row(
                                children: [
                                  getCustomText(
                                      modelPopular.price ?? "",
                                      fontBlack,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w400,
                                      Constant.getPercentSize(
                                          popularHeight, 5.5)),
                                  getHorSpace(Constant.getPercentSize(
                                      popularWidth, 1.5)),
                                  ((modelPopular.sale ?? "").isNotEmpty)
                                      ? Expanded(
                                          child: getCustomTextWithStrike(
                                              modelPopular.price ?? "",
                                              Colors.red,
                                              1,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              Constant.getPercentSize(
                                                  popularHeight, 5.5)),
                                          flex: 1,
                                        )
                                      : Container()
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          )
          // Container(
          //   decoration:,
          // )
        ],
      ),
    );
  }
}

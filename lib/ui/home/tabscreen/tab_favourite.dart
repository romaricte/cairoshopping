// ignore: file_names
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import '../../../constants/constant.dart';
import '../../../constants/data_file.dart';
import '../../../constants/size_config.dart';
import '../../../constants/widget_utils.dart';
import '../../../constants/color_data.dart';
import '../../../models/model_trending.dart';


class TabFavourite extends StatefulWidget {
  const TabFavourite({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabFavourite();
  }
}

class _TabFavourite extends State<TabFavourite> {
  // List<ModelTrending> popularList = [];
  //
  List<ModelTrending> popularList = DataFile.getAllPopularProduct();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    double appbarPadding = getAppBarPadding();
    double marginPopular = appbarPadding;
    int crossAxisCountPopular = 2;
    double popularWidth =
        (screenWidth - ((crossAxisCountPopular - 1) * marginPopular)) /
            crossAxisCountPopular;
    // var _width = ( _screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;

    double popularHeight = Constant.getPercentSize(screenHeight, 38);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          getDefaultHeader(context, "My Favourite", () {}, (value) {},
              withFilter: false, isShowBack: false),
          Expanded(
            child: Stack(
              children: [
                (popularList.isNotEmpty)
                    ? GridView.count(
                        padding: EdgeInsets.all(marginPopular),
                        crossAxisCount: crossAxisCountPopular,
                        crossAxisSpacing: marginPopular,
                        mainAxisSpacing: marginPopular,
                        // crossAxisSpacing: 10,
                        childAspectRatio: popularWidth / popularHeight,
                        shrinkWrap: true,
                        primary: true,
                        children: List.generate(popularList.length, (index) {
                          ModelTrending modelPopular = popularList[index];
                          return InkWell(
                            onTap: () {

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
                                                        popularHeight, 4))),
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
                                                false,
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
                                                        horizontal: Constant
                                                            .getPercentSize(
                                                                popularWidth,
                                                                5),
                                                        vertical: Constant
                                                            .getPercentSize(
                                                                popularWidth,
                                                                3)),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(Constant
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
                                  getSpace(Constant.getPercentSize(
                                      popularHeight, 2.5)),
                                  getCustomText(
                                      modelPopular.title ?? "",
                                      fontBlack,
                                      1,
                                      TextAlign.start,
                                      FontWeight.bold,
                                      Constant.getPercentSize(
                                          popularHeight, 5.5)),
                                  getSpace(Constant.getPercentSize(
                                      popularHeight, 2.6)),
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
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                    : getEmptyWidget(
                        "cart_item.svg",
                        "No Favourites Yet!",
                        "Explore more and shortlist some products.",
                        "Add Favourites", () {

                      })
              ],
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}

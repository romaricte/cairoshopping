// ignore: file_names
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:shopping/constants/constant.dart';
import 'package:flutter_svg/svg.dart';

import 'size_config.dart';
import 'color_data.dart';

double getEditHeight() {
  return Constant.getHeightPercentSize(8);
}

double getTopViewHeight() {
  return Constant.getHeightPercentSize(42);
}

double getAppBarPadding() {
  double appbarPadding = Constant.getWidthPercentSize(4);
  return appbarPadding;
}

Widget getBackgroundWidget(Widget widget) {
  double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
  double screenHeight = SizeConfig.safeBlockVertical! * 100;

  double size = Constant.getPercentSize(getTopViewHeight(), 16);
  double imgSize = Constant.getPercentSize(getTopViewHeight(), 14);
  double topHeight = Constant.getPercentSize(getTopViewHeight(), 63);
  double getRemainSize = screenHeight - topHeight;

  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: getTopViewHeight(),
          padding: EdgeInsets.only(bottom: getTopViewHeight() / 4),
          decoration: ShapeDecoration(
              color: primaryColor,
              shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius.only(
                      bottomLeft: SmoothRadius(
                          cornerRadius: size, cornerSmoothing: 0.2),
                      bottomRight: SmoothRadius(
                          cornerRadius: size, cornerSmoothing: 0.2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getSvgImage("logo_img.svg", imgSize),
              // Image.asset(
              //   Constant.assetImagePath + "logo_img.png",
              //   height: imgSize,
              //   width: imgSize,
              // ),
              getHorSpace(Constant.getPercentSize(screenWidth, 3)),
              getCustomText("Shopping", Colors.white, 1, TextAlign.start,
                  FontWeight.bold, Constant.getPercentSize(imgSize, 65))
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              getSpace(topHeight),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              blurRadius: 3, color: Colors.black.withAlpha(20))
                        ],
                        shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius.all(SmoothRadius(
                                cornerSmoothing: 0.5,
                                cornerRadius: Constant.getPercentSize(
                                    getRemainSize, 4))))),
                    margin: EdgeInsets.only(
                        // top: topHeight,
                        left: size / 2.2,
                        right: size / 2.2,
                        bottom:
                            Constant.getPercentSize(getTopViewHeight(), 10)),
                    child: widget,
                  ),
                ),
                flex: 1,
              )
            ],
          ),
        )

      ],
    ),
  );
}

Widget getCustomText(String text, Color color, int maxLine, TextAlign textAlign,
    FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        fontStyle: FontStyle.normal,
        color: color,
        fontFamily: Constant.assetImagePath,
        fontWeight: fontWeight),
    maxLines: maxLine,
    textAlign: textAlign,
  );
}

Widget getLeadingIcon(BuildContext context, Function function) {
  double toolbarHeight = Constant.getHeightPercentSize(4);
  // double toolbarHeight = Constant.getToolbarHeight(context);
  return InkWell(
      onTap: () {
        function();
      },
      child: SvgPicture.asset(
        Constant.assetImagePath + "back.svg",
        height: toolbarHeight,
        // height: Constant.getPercentSize(toolbarHeight, 30),
        fit: BoxFit.cover,
        width: toolbarHeight,
      )

      );
}

Widget getEmptyWidget(String image, String title, String description,
    String btnTxt, Function function,
    {bool withButton = true}) {
  double screenHeight = SizeConfig.safeBlockVertical! * 100;
  double width = Constant.getWidthPercentSize(45);
  double height = Constant.getPercentSize(screenHeight, 8.2);
  return Container(
    color: backgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getSvgImage(image, Constant.getPercentSize(screenHeight, 25)),
        SizedBox(
          height: Constant.getPercentSize(screenHeight, 3.2),
        ),
        getCustomTextWithoutMaxLine(title, fontBlack, TextAlign.center,
            FontWeight.bold, Constant.getPercentSize(screenHeight, 3.4)),
        getSpace(Constant.getPercentSize(screenHeight, 1.2)),
        getCustomTextWithoutMaxLine(
          description,
          fontBlack,
          TextAlign.center,
          FontWeight.w400,
          Constant.getPercentSize(screenHeight, 2.4),
        ),
        getSpace(Constant.getPercentSize(screenHeight, 3)),
        (withButton)
            ? InkWell(
                onTap: () {
                  function();

                },
                child: Container(
                    margin: EdgeInsets.only(
                        top: Constant.getPercentSize(height, 4)),
                    width: width,
                    height: height,
                    decoration: ShapeDecoration(
                      color: Colors.white,

                      shape: SmoothRectangleBorder(
                        side: BorderSide(color: primaryColor, width: 1.5),
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: Constant.getPercentSize(height, 25),
                          cornerSmoothing: 0.8,
                        ),
                      ),
                    ),
                    child: Center(
                      child: getCustomTextWithoutMaxLine(
                          btnTxt,
                          primaryColor,
                          TextAlign.center,
                          FontWeight.w700,
                          Constant.getPercentSize(width,9)),
                    )),
              )
            : getSpace(0)
      ],
    ),
  );
}

Widget getDefaultTextFiledWithoutIconWidget(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool withPrefix = false, String imgName = ""}) {
  double height = getEditHeight();

  double radius = Constant.getPercentSize(height, 20);
  double fontSize = Constant.getPercentSize(height, 27);
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        height: height,
        margin:
            EdgeInsets.symmetric(vertical: Constant.getHeightPercentSize(1.2)),
        padding:
            EdgeInsets.symmetric(horizontal: Constant.getWidthPercentSize(2.5)),
        alignment: Alignment.centerLeft,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: SmoothRectangleBorder(
            side: BorderSide(
                color: isAutoFocus ? primaryColor : Colors.grey.shade400,
                width: 1),
            borderRadius: SmoothBorderRadius(
              cornerRadius: radius,
              cornerSmoothing: 0.8,
            ),
          ),
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              setState(() {
                isAutoFocus = true;
                myFocusNode.canRequestFocus = true;
              });
            } else {
              setState(() {
                isAutoFocus = false;
                myFocusNode.canRequestFocus = false;
              });
            }
          },
          child: TextField(
            maxLines: 1,
            controller: textEditingController,
            autofocus: false,
            focusNode: myFocusNode,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
                fontFamily: Constant.fontsFamily,
                color: fontBlack,
                fontWeight: FontWeight.w400,
                fontSize: fontSize),
            decoration: InputDecoration(
                prefixIcon: (withPrefix)
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: Constant.getWidthPercentSize(2.5)),
                        child: getSvgImage(
                            imgName, Constant.getPercentSize(height, 40)),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                border: InputBorder.none,
                isDense: true,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: s,
                prefixIconConstraints:
                    const BoxConstraints(minHeight: 0, minWidth: 0),
                hintStyle: TextStyle(
                    fontFamily: Constant.fontsFamily,
                    color: greyFont,
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize)),
          ),
        ),
      );
    },
  );
}

Widget getSettingRow(String image, String title, Function function) {
  double iconSize = Constant.getHeightPercentSize(5);
  double subIconSize = Constant.getPercentSize(iconSize, 54);
  return InkWell(
    onTap: () {
      function();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: getButtonShapeDecoration(
            primaryColor.withOpacity(0.070),
            corner: Constant.getPercentSize(iconSize, 25),
            withCustomCorner: true,
          ),
          child: Center(
            child: getSvgImage(image, subIconSize),
          ),
        ),
        getHorSpace(Constant.getPercentSize(getAppBarPadding(), 75)),
        Expanded(
          child: getCustomText(title, fontBlack, 1, TextAlign.start,
              FontWeight.w600, Constant.getPercentSize(iconSize, 45)),
          flex: 1,
        ),
        getSvgImage("ArrowRight.svg", subIconSize)
      ],
    ),
  );
}

Widget getDefaultHeader(BuildContext context, String title, Function function,
    ValueChanged<String> funChange,
    {bool withFilter = false,
    Function? filterFun,
    bool isShowBack = true,
    bool isShowSearch = true}) {
  double size = Constant.getHeightPercentSize(6);
  double appbarPadding = getAppBarPadding();
  double toolbarHeight = Constant.getToolbarHeight(context);
  return Container(
    color: primaryColor,
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              top: Constant.getToolbarTopHeight(context),
              left: appbarPadding,
              right: appbarPadding),
          height: toolbarHeight,
          child: Stack(
            children: [
              Visibility(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: getLeadingIcon(context, function)),
                visible: isShowBack,
              ),
              Center(
                child: getCustomText(title, Colors.white, 1, TextAlign.center,
                    FontWeight.bold, Constant.getPercentSize(size, 50)),
              )
              // Image.asset(Constant.assetImagePath + "back11.png",
              //     height: Constant.getPercentSize(toolbarHeight, 90),
              //     fit: BoxFit.cover,
              //     width: Constant.getPercentSize(toolbarHeight, 90)))
              // getSvgImage(
              //     "back.svg", Constant.getPercentSize(toolbarHeight, 90)),)
            ],
          ),
        ),
        (isShowSearch)
            ? Container(
                margin: EdgeInsets.only(
                    left: appbarPadding,
                    right: appbarPadding,
                    bottom: appbarPadding * 1.5,
                    top: Constant.getPercentSize(appbarPadding, 30)),
                width: double.infinity,
                height: getEditHeight(),
                padding: EdgeInsets.symmetric(
                    horizontal: Constant.getWidthPercentSize(3)),
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                            cornerRadius: getCorners(),
                            cornerSmoothing: getCornerSmoothing()))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getSvgImage("Search.svg", getEdtIconSize()),
                    getHorSpace(Constant.getWidthPercentSize(2)),
                    Expanded(
                      child: TextField(
                        onChanged: funChange,
                        decoration: InputDecoration(
                            hintText: "Search...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: Constant.fontsFamily,
                                fontSize: getEdtTextSize(),
                                fontWeight: FontWeight.w400,
                                color: Colors.black54)),
                        style: TextStyle(
                            fontFamily: Constant.fontsFamily,
                            fontSize: getEdtTextSize(),
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),

                      // getCustomText("Search...", Colors.black54, 1,
                      //     TextAlign.start, FontWeight.w400, getEdtTextSize()),
                      flex: 1,
                    ),
                    (withFilter)
                        ? InkWell(
                            child: getSvgImage("filter.svg", getEdtIconSize()),
                            onTap: () {
                              filterFun!();
                            },
                          )
                        : getSpace(0)
                  ],
                ),
              )
            : getSpace(0),
      ],
    ),
  );
}

Widget getCustomTextWithStrike(String text, Color color, int maxLine,
    TextAlign textAlign, FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontSize: textSizes,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.lineThrough,
        color: color,
        fontFamily: Constant.assetImagePath,
        fontWeight: fontWeight),
    maxLines: maxLine,
    textAlign: textAlign,
  );
}

Widget getCustomTextWithoutMaxLine(String text, Color color,
    TextAlign textAlign, FontWeight fontWeight, double textSizes,
    {txtHeight = 1.5}) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        fontStyle: FontStyle.normal,
        color: color,
        fontFamily: Constant.assetImagePath,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

Widget getFavWidget(double height, bool isFav, EdgeInsetsGeometry margin) {
  double size = Constant.getPercentSize(height, 10);
  return Container(
    width: size,
    margin: margin,
    height: size,
    decoration:
        const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    child: Center(
      child: getSvgImage((isFav)?"fav_fill.svg":"heart.svg", Constant.getPercentSize(size, 70),color: (isFav)?null:Colors.black54),
    ),
  );
}

Widget getSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

double getEdtIconSize() {
  double edtIconSize = Constant.getPercentSize(getEditHeight(), 45);
  return edtIconSize;
}

double getLoginTitleFontSize() {
  double edtIconSize = Constant.getHeightPercentSize(3.3);
  return edtIconSize;
}

double getEdtTextSize() {
  double edtIconSize = Constant.getPercentSize(getEditHeight(), 30);
  return edtIconSize;
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

ShapeDecoration getTextFieldDecoration({Color colorSet=Colors.grey}) {
  return ShapeDecoration(
      shape: SmoothRectangleBorder(
          // side: BorderSide(
          //     color: Colors.grey, width: 1),
          borderRadius: SmoothBorderRadius.all(SmoothRadius(
              cornerSmoothing: 0.5,
              cornerRadius: Constant.getPercentSize(getEditHeight(), 20))),
          side: BorderSide(width: 1, color: colorSet)));
}

Widget getLoginTextField(
    TextEditingController controller, String hint, String icon) {
  double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
  double screenHeight = SizeConfig.safeBlockVertical! * 100;

  double edtIconSize = getEdtIconSize();
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  return StatefulBuilder(
    builder: (context, setState) {

    return Container(
      width: double.infinity,
      height: getEditHeight(),
      margin: EdgeInsets.symmetric(
          vertical: Constant.getPercentSize(screenHeight, 1.5)),
      padding: EdgeInsets.symmetric(
          horizontal: Constant.getPercentSize(screenWidth, 2)),
      decoration: getTextFieldDecoration(colorSet:isAutoFocus ? primaryColor : Colors.grey,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getSvgImage(icon, edtIconSize),
          // Image.asset(
          //   Constant.assetImagePath + icon,
          //   height: edtIconSize,
          //   width: edtIconSize,
          // ),
          getHorSpace(Constant.getPercentSize(screenWidth, 1.5)),
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    isAutoFocus = true;
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    isAutoFocus = false;
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: TextField(
                controller: controller,
                autofocus: false,
                focusNode: myFocusNode,
                style: TextStyle(
                    fontSize: getEdtTextSize(),
                    color: fontBlack,

                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: hint,
                    border: InputBorder.none),
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
    },

  );
}


Widget getPassTextField(TextEditingController controller, String hint,
    String icon, bool showPass, Function function) {
  double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
  double screenHeight = SizeConfig.safeBlockVertical! * 100;
  double edtIconSize = getEdtIconSize();

  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  return StatefulBuilder(builder: (context, setState) {
    return Container(
      width: double.infinity,
      height: getEditHeight(),
      margin: EdgeInsets.symmetric(
          vertical: Constant.getPercentSize(screenHeight, 1.5)),
      padding: EdgeInsets.symmetric(
          horizontal: Constant.getPercentSize(screenWidth, 2)),
      decoration: getTextFieldDecoration(colorSet:isAutoFocus ? primaryColor : Colors.grey,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getSvgImage(icon, edtIconSize),
          getHorSpace(Constant.getPercentSize(screenWidth, 1.5)),
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    isAutoFocus = true;
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    isAutoFocus = false;
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: TextField(
                obscureText: (showPass) ? false : true,
                controller: controller,
                autofocus: false,
                focusNode: myFocusNode,
                style: TextStyle(
                    fontSize: getEdtTextSize(),
                    color: fontBlack,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: hint,
                    border: InputBorder.none),
              ),
            ),
            flex: 1,
          ),
          InkWell(
              onTap: () {
                function();
              },
              child: getSvgImage("eye.svg", edtIconSize, color: Colors.grey))
          // SvgPicture.asset(Constant.assetImagePath + "",
          //     color: Colors.red, semanticsLabel: 'A red up arrow')
        ],
      ),
    );
  },);
}

Widget getSvgImage(String image, double size, {Color? color}) {
  return SvgPicture.asset(
    Constant.assetImagePath + image,
    color: color,
    width: size,
    height: size,
    // fit: BoxFit.fitHeight,
  );
}

double getCorners() {
  return Constant.getPercentSize(getEditHeight(), 25);
}

double getCornerSmoothing() {
  return 0.5;
}

getButtonContainer(
    Widget widget, EdgeInsetsGeometry insetsGeometry, Color color) {
  return Container(
    margin: insetsGeometry,
    width: double.infinity,
    height: getEditHeight(),
    decoration: ShapeDecoration(
        color: color,
        shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
                cornerRadius: getCorners(), cornerSmoothing: 0.5))),
    child: widget,
  );
}

getButtonShapeDecoration(Color color,
    {bool withCustomCorner = false, double corner = 0}) {
  return ShapeDecoration(
      color: color,
      shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
              cornerRadius: (withCustomCorner) ? corner : getCorners(),
              cornerSmoothing: 0.5)));
}

Widget getButton(Color bgColor, bool withCorners, String text, Color textColor,
    Function function, FontWeight weight, EdgeInsetsGeometry insetsGeometry,
    {isBorder = false, borderColor = Colors.transparent}) {
  double buttonHeight = getEditHeight();
  double fontSize = Constant.getPercentSize(buttonHeight, 32);
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      width: double.infinity,
      height: buttonHeight,
      decoration: ShapeDecoration(
          color: bgColor,
          shape: SmoothRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color: (isBorder) ? borderColor : Colors.transparent),
              borderRadius: SmoothBorderRadius(
                  cornerRadius: (withCorners) ? getCorners() : 0,
                  cornerSmoothing: (withCorners) ? 0.5 : 0))),
      child: Center(
        child: getCustomText(
            text, textColor, 1, TextAlign.center, weight, fontSize),
      ),
    ),
  );
}

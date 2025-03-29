// ignore: file_names
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';
import 'package:cairoshopping/constants/data_file.dart';
import 'package:cairoshopping/constants/size_config.dart';


import '../../constants/widget_utils.dart';
import '../../constants/color_data.dart';
import '../../models/payment_card_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotificationScreen();
  }
}

class _NotificationScreen extends State<NotificationScreen> {
  _requestPop() {
    Constant.backToFinish(context);
    // Constant.sendToScreen(HomeScreen(selectedTab: 3), context);
  }

  List<PaymentCardModel> paymentModelList = DataFile.getPaymentCardList();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  bool isSaveCard = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    double appBarPadding = getAppBarPadding();

    double cellHeight = Constant.getPercentSize(screenWidth, 25);
    double iconMainSize = Constant.getPercentSize(cellHeight,39);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getDefaultHeader(context, "Notification", () {
                  _requestPop();
                }, (value) {}, isShowSearch: false),
                getSpace(appBarPadding / 2),
                Expanded(
                  child: (paymentModelList.isEmpty)
                      ? Center(
                          child: getEmptyWidget(
                              "notification.svg",
                              "No Notifications Yet!",
                              "We'll notify you when something arrives.",
                              "Add Card",
                              () {},
                              withButton: false),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: true,
                              itemCount: 5,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: appBarPadding,
                                        right: appBarPadding,
                                        bottom: appBarPadding / 2,
                                        top: appBarPadding / 2),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: appBarPadding,
                                        vertical: appBarPadding),
                                    decoration: ShapeDecoration(
                                        color: cardColor,
                                        shape: SmoothRectangleBorder(
                                            borderRadius: SmoothBorderRadius(
                                                cornerRadius:
                                                    Constant.getPercentSize(
                                                        cellHeight, 10),
                                                cornerSmoothing: 0.5))),
                                    height: cellHeight,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: iconMainSize,
                                          height: iconMainSize,
                                          decoration: getButtonShapeDecoration(
                                              primaryColor,
                                              corner: Constant.getPercentSize(
                                                  iconMainSize, 20),
                                              withCustomCorner: true),
                                          child: Center(
                                            child: getSvgImage(
                                                "notification_icon.svg",
                                                Constant.getPercentSize(
                                                    iconMainSize, 55),
                                                color: Colors.white),
                                          ),
                                        ),
                                        getHorSpace(Constant.getPercentSize(
                                            screenWidth,3)),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: getCustomText(
                                                        "Notification ${index + 1}",
                                                        fontBlack,
                                                        1,
                                                        TextAlign.start,
                                                        FontWeight.bold,
                                                        Constant.getPercentSize(
                                                            cellHeight, 17)),
                                                    flex: 1,
                                                  ),
                                                  getCustomText(
                                                      "2 h ago",
                                                      greyFont,
                                                      1,
                                                      TextAlign.start,
                                                      FontWeight.w400,
                                                      Constant.getPercentSize(
                                                          cellHeight,13.5))
                                                ],
                                              ),
                                              Expanded(child: Container(),flex: 1,),
                                              // getSpace(Constant.getPercentSize(
                                              //     cellHeight, 7)),
                                              getCustomText(
                                                  "Lorem ipsum dolor sit amet, consectetur adipiscling elit, sed do eiusmod temporary",
                                                  fontBlack,
                                                  2,
                                                  TextAlign.start,
                                                  FontWeight.w400,
                                                  Constant.getPercentSize(
                                                      cellHeight,14))
                                            ],
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                );
                              }),
                        ),
                  flex: 1,
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          _requestPop();
          return false;
        });
  }

  addNewCardDialog() {
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    double height = Constant.getPercentSize(screenHeight, 45);
    double radius = Constant.getPercentSize(screenHeight, 4.5);
    double margin = getAppBarPadding();
    double cellHeight = Constant.getPercentSize(height, 6.5);
    double fontSize = Constant.getPercentSize(cellHeight, 70);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return FractionallySizedBox(
                heightFactor: 0.57,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: margin),
                  child: ListView(
                    children: <Widget>[
                      getSpace(Constant.getPercentSize(height, 4)),
                      Center(
                        child: Container(
                          width: Constant.getWidthPercentSize(10),
                          height: 1,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      getSpace(Constant.getPercentSize(height, 5)),
                      Row(
                        children: [
                          Expanded(
                            child: getCustomText(
                                "Add Credit Card",
                                fontBlack,
                                1,
                                TextAlign.start,
                                FontWeight.bold,
                                Constant.getPercentSize(height, 5)),
                            flex: 1,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close,
                                size: Constant.getPercentSize(height, 6),
                                color: fontBlack,
                              )),
                        ],
                      ),
                      getSpace(Constant.getPercentSize(height, 3)),
                      getDefaultTextFiledWithoutIconWidget(
                          context, "Name On Card", cardHolderNameController,
                          withPrefix: true, imgName: "Document.svg"),
                      getDefaultTextFiledWithoutIconWidget(
                          context, "Card Number", cardNumberController,
                          withPrefix: true, imgName: "Card.svg"),
                      Row(
                        children: [
                          Expanded(
                            child: getDefaultTextFiledWithoutIconWidget(
                                context, "MM/YY", expDateController),
                            flex: 1,
                          ),
                          getHorSpace(margin),
                          Expanded(
                            child: getDefaultTextFiledWithoutIconWidget(
                                context, "CVV", cvvController),
                            flex: 1,
                          )
                        ],
                      ),
                      getSpace(Constant.getPercentSize(height, 3)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isSaveCard) {
                              isSaveCard = false;
                            } else {
                              isSaveCard = true;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: Constant.getHeightPercentSize(0.5)),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                height: cellHeight,
                                width: cellHeight,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: primaryColor.withOpacity(0.4),
                                        width: 1),
                                    color: (isSaveCard)
                                        ? primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Constant.getPercentSize(
                                            cellHeight, 12)))),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    size:
                                        Constant.getPercentSize(cellHeight, 80),
                                    color: (isSaveCard)
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: fontSize,
                              ),
                              getCustomText("Save Card", fontBlack, 1,
                                  TextAlign.start, FontWeight.w500, fontSize)
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: Constant.getHeightPercentSize(0.5)),
                          child: getButton(
                            primaryColor,
                            true,
                            "Add",
                            Colors.white,
                            () {},
                            FontWeight.bold,
                            EdgeInsets.symmetric(vertical: margin),
                          )
                          //     getButtonWidget(context, "Add", primaryColor, () {
                          //   Navigator.of(context).pop();
                          // }),
                          ),
                      getSpace(margin)
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Widget getSeparateDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getAppBarPadding()),
      child: Divider(
        height: 1,
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget getRowWidget(String title, String desc, String icon) {
    double iconSize = Constant.getHeightPercentSize(3.8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSvgImage(icon, iconSize),
        getHorSpace(Constant.getWidthPercentSize(2)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomText(title, fontBlack, 1, TextAlign.start, FontWeight.w700,
                Constant.getPercentSize(iconSize, 63)),
            getSpace(Constant.getPercentSize(iconSize, 36)),
            getCustomText(desc, greyFont, 1, TextAlign.start, FontWeight.w400,
                Constant.getPercentSize(iconSize, 61)),
          ],
        )
      ],
    );
  }
}

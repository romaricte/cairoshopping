// ignore: file_names
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/data_file.dart';
import 'package:cairoshopping/constants/size_config.dart';
import 'package:cairoshopping/constants/color_data.dart';
import 'package:cairoshopping/models/model_cart.dart';


import '../../../constants/constant.dart';
import '../../../constants/widget_utils.dart';

class TabCart extends StatefulWidget {
  const TabCart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabCart();
  }
}

class _TabCart extends State<TabCart> {
  List<ModelCart> cartList = DataFile.getAllCartList();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    double appBarPadding = getAppBarPadding();
    double edtHeight = getEditHeight();
    double cellHeight = Constant.getPercentSize(screenWidth, 23);
    double deleteIconSize = Constant.getPercentSize(cellHeight, 19);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: Column(
        children: [
          getDefaultHeader(context, "My Cart", () {}, (value) {},
              withFilter: false, isShowBack: false, isShowSearch: false),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                ModelCart modelCart = cartList[index];
                return Container(
                  margin: EdgeInsets.only(
                      left: appBarPadding,
                      right: appBarPadding,
                      top: (index == 0) ? appBarPadding : (appBarPadding / 2),
                      bottom: appBarPadding / 2),
                  width: double.infinity,
                  height: cellHeight,
                  padding:
                      EdgeInsets.all(Constant.getPercentSize(cellHeight, 10)),
                  decoration: ShapeDecoration(
                      color: cardColor,
                      shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                              cornerRadius:
                                  Constant.getPercentSize(cellHeight, 13),
                              cornerSmoothing: 0.5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          Constant.assetImagePath + modelCart.image!,
                          width: Constant.getPercentSize(screenWidth, 20),
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                            Constant.getPercentSize(cellHeight, 10))),
                      ),
                      getHorSpace(Constant.getPercentSize(screenWidth, 3)),
                      Expanded(
                        child: Column(
                          children: [
                            getCustomText(
                                modelCart.title ?? "",
                                fontBlack,
                                1,
                                TextAlign.start,
                                FontWeight.bold,
                                Constant.getPercentSize(cellHeight, 18)),
                            getSpace(Constant.getPercentSize(cellHeight, 7)),
                            getCustomText(
                                modelCart.subTitle ?? "",
                                fontBlack,
                                1,
                                TextAlign.start,
                                FontWeight.w400,
                                Constant.getPercentSize(cellHeight, 16)),
                            const Expanded(
                              child: SizedBox(),
                              flex: 1,
                            ),
                            Row(
                              children: [
                                getCustomText(
                                    modelCart.price ?? "",
                                    fontBlack,
                                    1,
                                    TextAlign.start,
                                    FontWeight.w700,
                                    Constant.getPercentSize(cellHeight, 16)),
                                getHorSpace(Constant.getPercentSize(
                                    screenWidth, 0.5)),
                                Expanded(
                                  child: Container(),
                                  flex: 1,
                                ),

                                //
                                // Expanded(
                                //   child: getCustomText(
                                //       " x${modelCart.quantity}",
                                //       greyFont,
                                //       1,
                                //       TextAlign.start,
                                //       FontWeight.w600,
                                //       Constant.getPercentSize(
                                //           cellHeight, 15.5)),
                                //   flex: 1,
                                // )
                              ],
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        flex: 1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          getSvgImage("Trash.svg", deleteIconSize),
                          Row(
                            children: [
                              getSvgImage("Minus.svg", Constant.getPercentSize(cellHeight,2.5)),
                              getHorSpace(Constant.getPercentSize(screenWidth,2.7)),
                              getCustomText(
                                  "${modelCart.quantity}",
                                  fontBlack,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w700,
                                  Constant.getPercentSize(cellHeight, 15.5)),
                              getHorSpace(Constant.getPercentSize(screenWidth,2.7)),
                              getSvgImage("Plus.svg",
                                  Constant.getPercentSize(cellHeight, 11)),
                            ],
                          )
                        ],
                      )
                      // getSvgImage("Trash.svg", deleteIconSize)
                    ],
                  ),
                );
              },
              itemCount: cartList.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              primary: true,
            ),
            flex: 1,
          ),
          getButtonContainer(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appBarPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // getHorSpace(Constant.getPercentSize(screenWidth, 2.5)),
                    getCustomText(
                        "Total",
                        fontBlack,
                        1,
                        TextAlign.start,
                        FontWeight.w600,
                        Constant.getPercentSize(edtHeight, 36)),
                    getCustomText(
                        "\$54.00",
                        fontBlack,
                        1,
                        TextAlign.start,
                        FontWeight.w900,
                        Constant.getPercentSize(edtHeight, 37)),
                    // getHorSpace(Constant.getPercentSize(screenWidth, 2.5))
                  ],
                ),
              ),
              EdgeInsets.only(
                  left: appBarPadding,
                  right: appBarPadding,
                  top: appBarPadding),
              Colors.transparent),
              // primaryColor.withOpacity(0.1)),
          getButton(primaryColor, true, "Checkout", Colors.white, () {

          }, FontWeight.w700, EdgeInsets.all(appBarPadding))
        ],
      ),
    );
  }
}

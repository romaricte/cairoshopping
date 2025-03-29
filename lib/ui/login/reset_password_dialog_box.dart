// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/constant.dart';
import 'package:cairoshopping/constants/size_config.dart';
import 'package:cairoshopping/constants/widget_utils.dart';

import '../../constants/color_data.dart';

class ResetPasswordDialogBox extends StatefulWidget {
  final Function? func;

  const ResetPasswordDialogBox({Key? key, this.func}) : super(key: key);

  @override
  _ResetPasswordDialogBoxState createState() => _ResetPasswordDialogBoxState();
}

class _ResetPasswordDialogBoxState extends State<ResetPasswordDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    double padding = getAppBarPadding();
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: padding, right: padding, bottom: padding),
          margin: const EdgeInsets.only(top:40),
          // margin: EdgeInsets.only(top: avatarRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                Constant.assetImagePath + "pass_reset.png",
                height: Constant.getHeightPercentSize(12),
                // color: primaryColor,
              ),
              SizedBox(
                height: Constant.getHeightPercentSize(5),
              ),
              getCustomText('Password Changed', fontBlack, 1, TextAlign.center,
                  FontWeight.w800, Constant.getPercentSize(screenHeight, 3)),
              SizedBox(
                height: Constant.getPercentSize(screenHeight, 1.7),
              ),
              getCustomTextWithoutMaxLine(
                'Your password has been successfully\n changed!',
                fontBlack,
                TextAlign.center,
                FontWeight.w500,
                Constant.getPercentSize(screenHeight, 2.4),
              ),
              // SizedBox(
              //   height: Constant.getPercentSize(screenHeight, 5),
              // ),
              getButton(primaryColor, true, "Ok", Colors.white, () {
                Navigator.of(context).pop();
                widget.func!();
              }, FontWeight.w400,
                  EdgeInsets.symmetric(vertical: getAppBarPadding()))
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping/constants/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'constant.dart';
import 'color_data.dart';

// ignore: must_be_immutable
class CustomAnimatedBottomBar extends StatelessWidget {
  CustomAnimatedBottomBar(
      {Key? key,
      this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      this.backgroundColor,
      this.itemCornerRadius = 50,
      this.containerHeight = 56,
      this.animationDuration = const Duration(milliseconds: 270),
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      required this.items,
      required this.onItemSelected,
      this.curve = Curves.linear,
      this.totalItemCount = 1})
      : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;
  int totalItemCount;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: containerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  containerHeight: containerHeight,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                  totalItem: totalItemCount,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final double containerHeight;
  final Duration animationDuration;
  final Curve curve;
  final int totalItem;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.containerHeight,
    required this.iconSize,
    required this.totalItem,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double width = (SizeConfig.safeBlockHorizontal! * 100) / totalItem;
    double containerSize = math.min(width, containerHeight);

    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: width,
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Constant.getPercentSize(containerSize, 80),
                  height: Constant.getPercentSize(containerSize, 80),
                  // width: Constant.getPercentSize(width, 39),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: isSelected
                                ? shadowColor.withOpacity(0.06)
                                // ? primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: const Offset(0, 6))
                      ],
                      color:
                          isSelected ? item.activeColor : Colors.transparent),
                  child: Center(
                      child: SvgPicture.asset(
                    Constant.assetImagePath + item.imageName!,
                    color: isSelected ? Colors.white : null,
                    height: (item.iconSize! * 1.2),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
    this.imageName,
    this.iconSize,
    this.title,
  });

  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
  final String? imageName;
  final String? title;
  final double? iconSize;
}

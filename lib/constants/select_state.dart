// ignore: file_names
import 'dart:convert';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:country_state_city_picker/model/select_status_model.dart' as status;
import 'package:shopping/constants/constant.dart';
import 'package:shopping/constants/widget_utils.dart';
import 'package:shopping/constants/color_data.dart';

class SelectState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final TextStyle? style;
  final Color? dropdownColor;

  const SelectState(
      {Key? key,
      required this.onCountryChanged,
      required this.onStateChanged,
      required this.onCityChanged,
      this.style,
      this.dropdownColor})
      : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  List<String> cities = ["Choose City"];
  List<String> country = ["Choose Country"];
  String _selectedCity = "Choose City";
  String _selectedCountry = "Choose Country";
  String _selectedState = "Choose State";
  List<String> _states = ["Choose State"];

  @override
  void initState() {
    getCounty();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString('assets/country.json');
    return jsonDecode(res);
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

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => status.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      if (!mounted) return;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {

          _states.add(statename.toString());
        }
      });
    }

    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => status.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {

            cities.add(citynames.toString());
          }
        });
      });
    }
    return cities;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedState = "Choose State";
      _states = ["Choose State"];
      _selectedCountry = value;
      widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = "Choose City";
      cities = ["Choose City"];
      _selectedState = value;
      widget.onStateChanged(value);
      getCity();
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      widget.onCityChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = getEditHeight();
    double radius = Constant.getPercentSize(height, 20);
    double fontSize = Constant.getPercentSize(height, 30);

    TextStyle style=TextStyle(
      color: fontBlack,
      fontSize: fontSize,
      fontFamily: Constant.fontsFamily,
      fontWeight: FontWeight.w500
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Constant.getHeightPercentSize(1.2)),
          child: SizedBox(
            height: height,
            child: Container(
              // margin: EdgeInsets.symmetric(
              //     vertical: Constant.getHeightPercentSize(1.2)),
              padding: EdgeInsets.symmetric(
                  horizontal: Constant.getWidthPercentSize(2.5)),
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: SmoothRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade400, width: 1),
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: radius,
                    cornerSmoothing: 0.8,
                  ),
                ),
              ),
              child: Center(
                child: DropdownButton<String>(
                  dropdownColor: widget.dropdownColor,
                  isExpanded: true,
                  itemHeight: null,
                  isDense: true,
                  underline: getSpace(0),
                  items: country.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Row(
                        children: [
                          Text(
                            dropDownStringItem,
                            style:style,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => _onSelectedCountry(value!),
                  value: _selectedCountry,
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Constant.getHeightPercentSize(1.2)),
          child: SizedBox(
            height: height,
            child: Container(
              // margin: EdgeInsets.symmetric(
              //     vertical: Constant.getHeightPercentSize(1.2)),
              padding: EdgeInsets.symmetric(
                  horizontal: Constant.getWidthPercentSize(2.5)),
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: SmoothRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade400, width: 1),
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: radius,
                    cornerSmoothing: 0.8,
                  ),
                ),
              ),
              child: Center(
                child: DropdownButton<String>(
                  dropdownColor: widget.dropdownColor,
                  isExpanded: true,
                  itemHeight: null,
                  isDense: true,
                  underline: getSpace(0),
                  items: _states.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem, style:style),
                    );
                  }).toList(),
                  onChanged: (value) => _onSelectedState(value!),
                  value: _selectedState,
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Constant.getHeightPercentSize(1.2)),
          child: SizedBox(
            height: height,
            child: Container(
              // margin: EdgeInsets.symmetric(
              //     vertical: Constant.getHeightPercentSize(1.2)),
              padding: EdgeInsets.symmetric(
                  horizontal: Constant.getWidthPercentSize(2.5)),
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: SmoothRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade400, width: 1),
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: radius,
                    cornerSmoothing: 0.8,
                  ),
                ),
              ),
              child: Center(
                child:
                DropdownButton<String>(
                  dropdownColor: widget.dropdownColor,
                  isExpanded: true,
                  itemHeight: null,
                  underline: getSpace(0),
                  isDense: true,
                  items: cities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem, style: style),
                    );
                  }).toList(),
                  onChanged: (value) => _onSelectedCity(value!),
                  value: _selectedCity,
                ),
              ),
            ),
          ),
        ),



        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

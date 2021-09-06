import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;

class CountryListModel {
  String countryName;
  String currencyName;
  String currencyCode;
  String flagCode;
  CountryListModel(
      this.countryName, this.currencyName, this.currencyCode, this.flagCode);
}

class CountryListScreen extends StatefulWidget {
  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  @override
  void initState() {
    super.initState();
    initModel();
  }

  List<CountryListModel> countryList = [];
  initModel() {
    countryList
        .add(CountryListModel('UNITED ARAB EMIRATES', 'Dirham', 'AED', 'ae'));
    countryList.add(CountryListModel('AFGHANISTHAN', 'Afghani', 'AFN', 'af'));
    countryList.add(CountryListModel('ALBANIA', 'Lek', 'ALL', 'al'));
    countryList.add(CountryListModel('ANGALO', 'Kwanza', 'AOA', 'ao'));
    countryList
        .add(CountryListModel('ARGENTINA', 'Argentine Peso', 'ARS', 'as'));
    countryList.add(CountryListModel('BULGARIA', 'Bulgarian Lev', 'BGN', 'bg'));
    countryList.add(CountryListModel('BAHARIN', 'Baharain Dinar', 'BHD', 'bh'));
  }

  double paddingLeftandRight = 15;
  double paddingTop = 20;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF313865),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(children: [
              titleBack(),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Divider(
                  height: 1,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              searchAndListCountry()
            ]),
          ),
        ),
      ),
    );
  }

  Widget searchAndListCountry() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingLeftandRight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
                height: 35,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: Color(0xFF4D558A),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, left: 20),
                  child: TextField(
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFE5E6E9),
                        ),
                        hintText: 'Search currencies',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                      )),
                )),
          ),
          Text(
            'Tap to select a currency',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                decoration: TextDecoration.none),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: countryList.length,
              itemBuilder: (context, index) {
                return countryItem(index);
              })
        ],
      ),
    );
  }

  Widget countryItem(int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 35,
                      height: 35,
                      child: ClipOval(
                        child: Image.asset(
                          image.AssetImages.countriesPath +
                              countryList[index].flagCode +
                              '.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        countryList[index].currencyName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            decoration: TextDecoration.none),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          countryList[index].countryName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              decoration: TextDecoration.none),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    countryList[index].currencyCode,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(height: 1, color: Color(0xFF9c9c9c))
      ],
    );
  }

  Widget titleBack() {
    return Padding(
      padding: EdgeInsets.only(
          top: 30.0, left: paddingLeftandRight, right: paddingLeftandRight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: SvgPicture.asset(
                      image.AssetImages.arrowDownIcon,
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    )),
              ),
              Text(
                'Converter',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'Change Currency',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  decoration: TextDecoration.none),
            ),
          ),
        ],
      ),
    );
  }
}

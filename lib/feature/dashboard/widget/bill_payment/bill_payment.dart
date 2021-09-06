import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;

class BillPaymentModel {
  String iconPath;
  String iconTitle;
  BillPaymentModel(this.iconPath, this.iconTitle);
}

class BillPaymentWidget extends StatefulWidget {
  @override
  _BillPaymentWidgetState createState() => new _BillPaymentWidgetState();
}

class _BillPaymentWidgetState extends State<BillPaymentWidget> {
  List<BillPaymentModel> _listBillPaymentMode = <BillPaymentModel>[
    BillPaymentModel(image.AssetImages.mobileBillPayIcon, 'Mobile'.tr),
    BillPaymentModel(
        image.AssetImages.electricityBillPayIcon, 'electricity'.tr),
    BillPaymentModel(image.AssetImages.creditCardBillPayIcon, 'credit_card'.tr),
    BillPaymentModel(image.AssetImages.landlinePayIcon, 'landline'.tr),
    BillPaymentModel(image.AssetImages.gasBillPayIcon, 'gas'.tr),
    BillPaymentModel(image.AssetImages.dthBillPayIcon, 'DTH'),
    BillPaymentModel(image.AssetImages.petrolBillPayIcon, 'petrol'.tr),
    BillPaymentModel(image.AssetImages.landlinePayIcon, 'landline'.tr),
  ];

  double _animatedHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'bill_payment'.tr,
              style: TextStyle(
                  color: Color(0xFF505054), fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _chipsetBillWidgetList(),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: _animatedHeight,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _chipsetCollapseBillWidgetList()),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _animatedHeight != 0.0
                          ? _animatedHeight = 0.0
                          : _animatedHeight = 100.0;
                    }),
                    child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFE5E6E9), width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 5, left: 11, right: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _animatedHeight == 0.0 ? "More" : 'Less',
                                style: TextStyle(
                                    color: Color(0xFF505054),
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: _animatedHeight == 100.0
                                      ? Transform.rotate(
                                          angle: 180 * math.pi / 180,
                                          child: SvgPicture.asset(
                                            image.AssetImages.arrowDownIcon,
                                            color: Color(0xFF505054),
                                            height: 10,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          image.AssetImages.arrowDownIcon,
                                          color: Color(0xFF505054),
                                          height: 10,
                                        ))
                            ],
                          ),
                        )),
                  )),
            ),
          ],
        )
      ],
    );
  }

  List<Widget> _chipsetBillWidgetList() {
    List<Widget> _chipsetBillList = <Widget>[];
    for (int i = 0; i < _listBillPaymentMode.length; i++) {
      if (i < 4) {
        _chipsetBillList.add(billPaymentChipWidget(
            i,
            _listBillPaymentMode[i].iconPath,
            _listBillPaymentMode[i].iconTitle));
      }
    }

    return _chipsetBillList;
  }

  List<Widget> _chipsetCollapseBillWidgetList() {
    List<Widget> _chipsetBillList = <Widget>[];
    for (int i = 0; i < _listBillPaymentMode.length; i++) {
      if (i > 3) {
        _chipsetBillList.add(billPaymentChipWidget(
            i,
            _listBillPaymentMode[i].iconPath,
            _listBillPaymentMode[i].iconTitle));
      }
    }

    return _chipsetBillList;
  }

  Widget billPaymentChipWidget(int index, String iconPath, String iconTitle) =>
      Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(children: [
          Container(
            decoration:
                BoxDecoration(color: Color(0xFFF9F9F9), shape: BoxShape.circle),
            width: 55,
            height: 55,
            alignment: Alignment.center,
            child: SvgPicture.asset(iconPath, height: 27),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              iconTitle,
              style: TextStyle(color: Color(0xFF505054), fontSize: 11),
            ),
          )
        ]),
      );
}

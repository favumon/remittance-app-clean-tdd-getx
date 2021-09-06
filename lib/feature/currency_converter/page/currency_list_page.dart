import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/feature/currency_converter/controllers/currency_converter_controller.dart';

class CurrencyListPage extends StatelessWidget {
  final CurrencyConverterController controller = Get.find();

  final double paddingLeftandRight = 15;
  final double paddingTop = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313865),
      appBar: AppBar(
        title: Text('converter'.tr),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
        centerTitle: false,
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Color(0xFF313865),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: Text(
                'change_currency'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    decoration: TextDecoration.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Divider(
                height: 1,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            SearchAndListCurrency(controller)
          ],
        ),
      ),
    );
  }
}

class SearchAndListCurrency extends StatelessWidget {
  SearchAndListCurrency(this.controller, {Key? key}) : super(key: key);
  final CurrencyConverterController controller;

  final double paddingLeftandRight = 15;
  final double paddingTop = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => Padding(
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
                          onChanged: (value) =>
                              controller.filterCurrecySearchList(value),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              color: Color(0xFFE5E6E9),
                            ),
                            hintText: 'search_currencies'.tr,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                    )),
              ),
              controller.searchedCurrencyList.length < 1
                  ? Container()
                  : Text(
                      'tap_to_select_a_currency'.tr,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
              controller.searchedCurrencyList.length < 1
                  ? Center(
                      child: Text(
                        'no_currency_found'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.searchedCurrencyList.length,
                      itemBuilder: (context, index) {
                        return currencyItem(index);
                      })
            ],
          ),
        ),
      ),
    );
  }

  Widget currencyItem(int index) {
    return InkWell(
      onTap: () => controller.selectCurrency(index),
      child: Column(
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
                                controller
                                    .searchedCurrencyList[index].flagCode +
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
                          controller.searchedCurrencyList[index].currencyName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration: TextDecoration.none),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            controller.searchedCurrencyList[index].countryName,
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
                      controller.searchedCurrencyList[index].currencyCode,
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
      ),
    );
  }
}

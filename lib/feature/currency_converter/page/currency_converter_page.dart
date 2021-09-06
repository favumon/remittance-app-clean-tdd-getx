import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/currency_converter/controllers/currency_converter_controller.dart';
import 'package:remittance_app/feature/currency_converter/widget/currency_graph.dart';
import 'package:remittance_app/feature/currency_converter/widget/currency_rate_fetch.dart';

class CurrencyConverterScreen extends StatelessWidget {
  final _controller = Get.put(getIt<CurrencyConverterController>());

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
      body: Container(
        color: Color(0xFF313865),
        child: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Column(children: [
              CurrencyRateFetch(_controller),
              currencyGraph(),
              SizedBox(height: 20)
            ]),
          ),
        ),
      ),
    );
  }

  Widget currencyGraph() {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingTop,
          left: paddingLeftandRight,
          right: paddingLeftandRight),
      child: Container(
          child:
              // Obx(() =>
              // _controller.busy.value
              //   ? Container()
              //   :
              CurrencyConverterGraph(_controller)
          // ),
          ),
    );
  }
}

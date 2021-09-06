import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/signup/controllers/terms_and_conditions_page_controller.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage();

  @override
  Widget build(BuildContext context) {
    final TermsAndConditionsPageController _controller = Get.put(getIt());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        title: Text(
          'terms_and_conditions'.tr,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black87),
      ),
      body: Obx(() => _controller.termsAndConditionsText.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(_controller.termsAndConditionsText.value),
              ),
            )),
    );
  }
}

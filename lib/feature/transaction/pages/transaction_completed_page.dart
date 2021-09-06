import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/core/shared_widgets/button_normal.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/transaction/controllers/transaction_completed_page_controller.dart';

class TransactionCompletedPage extends StatelessWidget {
  TransactionCompletedPage({Key? key}) : super(key: key);

  final controller = Get.put(getIt<TransactionCompletedPageController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonNormal(
                buttonText: 'dashboard'.tr,
                onTapped: () => controller.finishPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

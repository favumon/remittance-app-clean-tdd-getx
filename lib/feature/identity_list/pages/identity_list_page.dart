import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/identity_list/controllers/identity_list_page_controller.dart';
import 'package:remittance_app/feature/identity_list/widgets/empty_id_list.dart';
import 'package:remittance_app/feature/identity_list/widgets/identity_list.dart';

class IdentityListPage extends StatelessWidget {
  final IdentityListPageController _identityListPageController =
      Get.put<IdentityListPageController>(getIt());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      appBar: AppBar(
        title: Text('identity'.tr),
        brightness: Brightness.dark,
      ),
      body: Obx(() => _identityListPageController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (_identityListPageController.identities.length > 0
              ? IdentityList(_identityListPageController.identities)
              : EmptyIdList())),
    );
  }
}

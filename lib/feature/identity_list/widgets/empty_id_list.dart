import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/feature/identity_list/widgets/add_new_id_button.dart';

class EmptyIdList extends StatelessWidget {
  const EmptyIdList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AssetImages.identity),
        Text(
          'get_id_documents_ready'.tr,
        ),
        SizedBox(height: 5),
        Text(
          'before_start_id_card_with_you_need_to_scan'.tr,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        AddNewIdButton()
      ],
    );
  }
}

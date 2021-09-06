import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/widget/quick_link/quick_link_controller.dart';

class QuickLink extends StatelessWidget {
  final _controller = Get.put(getIt<QuickLinkController>());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'quick_links'.tr,
          style:
              TextStyle(color: Color(0xFF505054), fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Row(children: quickLinkWidget()),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> quickLinkWidget() {
    List<Widget> _quickLinkWidgetList = [];

    _quickLinkWidgetList.add(_addQuickLinkChipWidget());
    for (int i = 0; i < _controller.quickLinkItem.length; i++) {
      _quickLinkWidgetList.add(_quickLinkChipWidget(i));
    }

    return _quickLinkWidgetList;
  }

  Widget _quickLinkChipWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF313865), width: 2),
                ),
                child: Text(_controller.getAvatarText(
                    _controller.quickLinkItem[index].beneficiaryName))),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                _controller.quickLinkItem[index].beneficiaryName,
                style: TextStyle(color: Color(0xFF7D7D7D), fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
    // child: Text(_quickLinkModelList[index].getAvatarText()));
  }

  Widget _addQuickLinkChipWidget() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF313865),
                  border: Border.all(
                    color: Color(0xFFE5E6E9),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'add'.tr,
                style: TextStyle(color: Color(0xFF505054), fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }
}

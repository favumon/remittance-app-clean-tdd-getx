import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/core/shared_widgets/common_loader.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/widget/esay_resend/controllers/esay_resend_controller.dart';

class EasyResendWidget extends StatelessWidget {
  final _controller = Get.put(getIt<EasyResendController>());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.busy.value
          ? Center(
              child: CommonLoader(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'easy_resend'.tr,
                  style: TextStyle(
                      color: Color(0xFF505054), fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(children: easyResendWidget()),
                ),
              ],
            ),
    );
  }

  List<Widget> easyResendWidget() {
    List<Widget> _quickLinkWidgetList = [];

    for (int i = 0; i < _controller.easyResendItem.length; i++) {
      _quickLinkWidgetList.add(_easyResendChipWidget(i));
    }

    return _quickLinkWidgetList;
  }

  Widget _easyResendChipWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Wrap(children: [
                  Container(
                      alignment: Alignment.center,
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Color(0xFF2e3665), width: 2),
                      ),
                      child: Text(_controller.getAvatarText(
                          _controller.easyResendItem[index].beneficiaryName))),
                ]),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _controller.easyResendItem[index].beneficiaryName,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Ref No :  ' +
                            _controller
                                .easyResendItem[index].transactionRefNumber
                                .toString(),
                        style: TextStyle(
                            color: Color(0xFF505054),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      _controller.easyResendItem[index].transactionDate,
                      style: TextStyle(
                          color: Color(0xFF505054),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _controller.easyResendItem[index].beneficiaryCurrencyAmount
                        .toString(),
                    style: TextStyle(
                        color: Color(0xFF313865),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    _controller.easyResendItem[index].beneficiaryCurrencyCode,
                    style: TextStyle(
                        color: Color(0xFF505054), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/core/shared_widgets/common_loader.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/currency_converter/page/currency_converter_page.dart';
import 'package:remittance_app/feature/dashboard/widget/top_exchange_rate/controllers/top_exchange_rate_controller.dart';

class TopExchangeRate extends StatelessWidget {
  final _controller = Get.put(getIt<TopExchangeRateController>());

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => _controller.busy.value
              ? Center(
                  child: CommonLoader(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'top_exchange_rate'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(children: [
                        Text(
                          '20.00',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 45),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'INR',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrencyConverterScreen()));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                image.AssetImages.indianFlagIcon,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'calculator'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/core/shared_widgets/common_text_field.dart';
import 'package:remittance_app/feature/currency_converter/controllers/currency_converter_controller.dart';

class CurrencyRateFetch extends StatelessWidget {
  final double paddingLeftandRight = 15;
  final double paddingTop = 20;

  CurrencyRateFetch(this._controller);

  final CurrencyConverterController _controller;

  @override
  Widget build(BuildContext context) {
    return currencyRateFetch();
  }

  Widget currencyRateFetch() {
    return ReactiveFormBuilder(
      form: () => _controller.form,
      builder: (_, __, ___) => Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: paddingTop,
                left: paddingLeftandRight,
                right: paddingLeftandRight),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'currency'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        decoration: TextDecoration.none),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: .4),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Obx(
                        () => _controller.busy.value
                            ? Container()
                            : Text(
                                '1 ${_controller.baseCurrencyCode} - ${_controller.currencyRate.value.rate} ${_controller.selectedCurrency.value?.currencyCode}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    decoration: TextDecoration.none)),
                      ),
                    ),
                  )
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: paddingTop),
            child: Divider(height: 1, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: paddingTop,
                left: paddingLeftandRight,
                right: paddingLeftandRight),
            child: LocalCurrencyContainer(_controller),
          ),
          Padding(
            padding: EdgeInsets.only(top: paddingTop),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  color: Colors.white,
                  height: 2,
                ),
                Positioned(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child:
                          SvgPicture.asset(image.AssetImages.upAndDownArrow)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: paddingTop,
                left: paddingLeftandRight,
                right: paddingLeftandRight),
            child: ForeignCurrencyContainer(_controller),
          ),
        ],
      ),
    );
  }
}

class LocalCurrencyContainer extends StatelessWidget {
  LocalCurrencyContainer(this.controller, {Key? key}) : super(key: key);

  final CurrencyConverterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'currency_i_have'.tr,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'i_have_this_much_to_exchange'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Color(0xFF9c9c9c), fontWeight: FontWeight.w600),
          ),
        ),
        Container(
            width: double.infinity,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                        controller.baseCurrencyName,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Image.asset(
                      image.AssetImages.countriesPath +
                          controller.basecurrencyFlagCode +
                          '.webp',
                      width: 40,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, bottom: 5),
                      child: Text(
                        controller.baseCurrencyCode,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IntrinsicWidth(
                          child: CommonTextField(
                            controlName: CURRENCY_I_HAVE,
                            textInputType:
                                TextInputType.numberWithOptions(decimal: true),
                            onSubmitted: controller.onChangeIHaveCurrency2,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          // TextField(
                          //   controller: TextEditingController()
                          //     ..text = controller.iHaveCurrency.toString(),
                          //   onChanged: (String value) =>
                          //       controller.onChangeIHaveCurrency(value),
                          //   decoration:
                          //       InputDecoration.collapsed(hintText: null),
                          //   inputFormatters: [
                          //     new LengthLimitingTextInputFormatter(3)
                          //   ],
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .headline3!
                          //       .copyWith(
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold,
                          //           decoration: TextDecoration.underline),
                          // ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]))
      ],
    );
  }
}

class ForeignCurrencyContainer extends StatelessWidget {
  ForeignCurrencyContainer(this.controller, {Key? key}) : super(key: key);

  final CurrencyConverterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'currency_i_want'.tr,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'i_want_to_buy_something_at_this_price'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Color(0xFF9c9c9c), fontWeight: FontWeight.w600),
          ),
        ),
        Obx(
          () =>
              // controller.busy.value
              //     ?
              //      Container(
              //         margin: const EdgeInsets.all(50),
              //         child: SpinKitPouringHourglass(
              //           color: Colors.white,
              //         ),
              //       )
              //     :
              Container(
            width: double.infinity,
            child: InkWell(
              onTap: () {
                controller.navigateToCountryList();
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            controller.selectedCurrency.value?.currencyName ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                          ),
                        ),
                        Image.asset(
                          image.AssetImages.countriesPath +
                              controller.selectedCurrency.value!.flagCode +
                              '.webp',
                          fit: BoxFit.cover,
                          width: 40,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, bottom: 5),
                          child: Text(
                            controller.selectedCurrency.value?.currencyCode ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: IntrinsicWidth(
                              child: CommonTextField(
                                controlName: CURRENCY_I_WANT,
                                onSubmitted: controller.onChangeIWantCurrency2,
                                textInputType: TextInputType.numberWithOptions(
                                    decimal: true),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              // TextField(
                              //   keyboardType: TextInputType.number,
                              //   controller: TextEditingController()
                              //     ..text =
                              //         controller.iWantCurrency.toString(),
                              //   onChanged: (String value) =>
                              //       controller.onChangeIWantCurrency(value),
                              //   decoration: InputDecoration.collapsed(
                              //       hintText: null),
                              //   inputFormatters: [
                              //     // new LengthLimitingTextInputFormatter(3)
                              //   ],
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .headline3!
                              //       .copyWith(
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold,
                              //           decoration:
                              //               TextDecoration.underline),
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../../di_injection/injection_container.dart';
import '../controllers/pin_entry_page_controller.dart';

class PinEntryPage extends StatelessWidget {
  //final PinEntryPageController _controller = Get.put(getIt());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black54),
      ),
      body: GetBuilder<PinEntryPageController>(
          init: Get.put(getIt()),
          builder: (controller) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Flexible(
                          flex: 2,
                          child: SvgPicture.asset('assets/images/logo.svg')),
                      SizedBox(
                        height: 60,
                      ),
                      Column(
                        children: [
                          Text(
                            controller.pageTitle.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text('configure_easy_secure_4_digit_pin'.tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.normal)),
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.lock,
                            size: 34,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PinInputTextFormField(
                        pinLength: 4,
                        decoration: UnderlineDecoration(
                            colorBuilder: FixedColorBuilder(Colors.black26)),
                        textInputAction: TextInputAction.go,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.characters,
                        controller: controller.pinController,
                        onChanged: (_) {
                          if (_.length == 4) {
                            controller.onPinComplete(_);
                          }
                        },
                        autovalidateMode: AutovalidateMode.always,
                        focusNode: controller.focusNode,
                        cursor: Cursor(
                          width: 2,
                          color: Colors.lightBlue,
                          radius: Radius.circular(1),
                          enabled: true,
                        ),
                      ),
                      // PinCodeTextField(
                      //   appContext: context,
                      //   backgroundColor:
                      //       Theme.of(context).scaffoldBackgroundColor,
                      //   length: 4,
                      //   onChanged: (value) {},
                      //   onCompleted: controller.onPinComplete,
                      //   autoFocus: true,
                      //   keyboardType: TextInputType.number,
                      //   controller: controller.pinController,
                      //   autoDismissKeyboard: true,
                      //   cursorColor: Colors.black,
                      //   obscureText: true,
                      //   obscuringCharacter: '•',
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      //   ],
                      //   pinTheme: PinTheme(
                      //       shape: PinCodeFieldShape.underline,
                      //       fieldHeight: 50,
                      //       fieldWidth: 40,
                      //       activeColor: Theme.of(context).primaryColor,
                      //       inactiveColor: Colors.grey),
                      // ),
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: ButtonNormal(
                //       isFullWidth: true,
                //       buttonText: controller.buttonText,
                //       onTapped: controller.onPinSubmit),
                // )
              ],
            );
          }),
    );
  }
}

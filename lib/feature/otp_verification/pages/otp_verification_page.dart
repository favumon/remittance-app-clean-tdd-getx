import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:remittance_app/feature/otp_verification/widgets/otp_resend.dart';

import '../../../core/shared_widgets/button_normal.dart';
import '../../../di_injection/injection_container.dart';
import '../controllers/otp_verification_page_controller.dart';

class OtpVerificationParams {
  final void Function(String otp) verficationSuccessCallback;
  final String email;
  final String mobileNo;

  OtpVerificationParams(
      {required this.verficationSuccessCallback,
      required this.email,
      required this.mobileNo});
}

class OtpVerificationPage extends StatelessWidget {
  final void Function(String otp) verficationSuccessCallback;

  final OtpVerificationPageController _controller = Get.put(getIt());

  OtpVerificationPage(
      {required final OtpVerificationParams otpVerificationParams})
      : this.verficationSuccessCallback =
            otpVerificationParams.verficationSuccessCallback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black87),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 40),
                SvgPicture.asset('assets/images/otp.svg'),
                SizedBox(height: 20),
                Text(
                  'otp_verfication'.tr,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black,
                        fontSize: 27,
                      ),
                ),
                Text(
                  'enter_six_digit_otp_received_on_mobile'.tr,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                PinInputTextFormField(
                  pinLength: 6,
                  decoration: UnderlineDecoration(
                      colorBuilder: FixedColorBuilder(Colors.black26)),
                  controller: _controller.otpController,
                  textInputAction: TextInputAction.go,
                  enabled: true,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.characters,
                  onSubmit: (value) => _controller.pin.value = value,
                  onChanged: (_) {
                    if (_.length == 6) {
                      _controller.focusNode.unfocus();
                      _controller.pin.value = _;
                    } else
                      _controller.pin.value = '';
                  },
                  autovalidateMode: AutovalidateMode.always,
                  focusNode: _controller.focusNode,
                  cursor: Cursor(
                    width: 2,
                    color: Colors.lightBlue,
                    radius: Radius.circular(1),
                    enabled: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: OtpResend(_controller.onResendOtp))
              ],
            ),
          ),
          Obx(() => Align(
                alignment: Alignment.bottomCenter,
                child: ButtonNormal(
                  isFullWidth: true,
                  buttonText: 'verify'.tr,
                  onTapped:
                      _controller.pin.isEmpty ? null : _controller.onVerify,
                ),
              ))
        ],
      ),
    );
  }
}

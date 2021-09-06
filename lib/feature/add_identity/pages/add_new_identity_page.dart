import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:domain/feature/add_identity/entities/id_type.dart';
import 'package:domain/feature/add_identity/entities/nationality.dart';
import 'package:domain/feature/add_identity/entities/signature_image.dart';
import 'package:domain/feature/add_identity/validation/id_image_validation.dart';
import 'package:domain/feature/add_identity/validation/id_number_validation.dart';
import 'package:domain/feature/add_identity/validation/id_type_validation.dart';
import 'package:domain/feature/add_identity/validation/nationality_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/core/shared_widgets/button_normal.dart';
import 'package:remittance_app/core/shared_widgets/common_async_dropdown.dart';
import 'package:remittance_app/core/shared_widgets/common_date_picker_field.dart';
import 'package:remittance_app/core/shared_widgets/common_text_field.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/add_identity/controllers/add_new_identity_page_controller.dart';
import 'package:remittance_app/feature/add_identity/widgets/add_signature.dart';
import 'package:remittance_app/feature/add_identity/widgets/image_picker.dart';

class AddNewIdentityPage extends StatelessWidget {
  final AddNewIdentityPageController _addNewIdentityPageController =
      Get.put<AddNewIdentityPageController>(
    getIt(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('identity'.tr),
        brightness: Brightness.dark,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ReactiveFormBuilder(
              form: () => _addNewIdentityPageController.idenitytyForm,
              builder: (_, __, ___) => SingleChildScrollView(
                    child: Column(
                      children: [
                        CommonAsyncDropdown<IdType>(
                            controlName: 'idType',
                            placeHolderText: 'id_type'.tr,
                            validationMessages: (_) =>
                                generateValidationsMessages(
                                    'idType', IdTypeValidation()),
                            itemSource: _addNewIdentityPageController.idTypes),
                        CommonTextField(
                          controlName: 'idNumber',
                          placeHolderText: 'id_number'.tr,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'id_number'.tr, IdNumberValidation()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CommonDatePickerField(
                          controlName: 'expiryDate',
                          placeHolderText: 'expiry_date'.tr,
                          textInputAction: TextInputAction.done,
                          firstDate: _addNewIdentityPageController
                              .expiryDateValidation.fromDate,
                          lastDate: _addNewIdentityPageController
                              .expiryDateValidation.toDate,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'expiry_date'.tr,
                                  _addNewIdentityPageController
                                      .expiryDateValidation),
                          isReadOnly: true,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ReactiveFormField<IdImage, IdImage>(
                          formControlName: 'idImageFront',
                          validationMessages: (control) =>
                              generateValidationsMessages(
                                  'id_image_front'.tr, IdImageValidation()),
                          builder: (field) {
                            return ImagePicker(
                              placeHolderText: 'id_card_front_side'.tr,
                              onTap: _addNewIdentityPageController
                                  .onPickIdImageFront,
                              field: field,
                            );
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ReactiveFormField<IdImage, IdImage>(
                          formControlName: 'idImageBack',
                          validationMessages: (control) =>
                              generateValidationsMessages(
                                  'id_image_back'.tr, IdImageValidation()),
                          builder: (field) {
                            return ImagePicker(
                              placeHolderText: 'id_card_back_side'.tr,
                              onTap: _addNewIdentityPageController
                                  .onPickIdImageBack,
                              field: field,
                            );
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ReactiveFormField<SignatureImage, SignatureImage>(
                          formControlName: 'signature',
                          builder: (field) {
                            return AddSignature(
                              placeHolderText: 'add_signature'.tr,
                              field: field,
                              onTap:
                                  _addNewIdentityPageController.onAddSignature,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CommonAsyncDropdown<Nationality>(
                            controlName: 'nationality',
                            placeHolderText: 'nationality'.tr,
                            validationMessages: (_) =>
                                generateValidationsMessages(
                                    'nationality'.tr, NationalityValidation()),
                            itemSource:
                                _addNewIdentityPageController.nationalities),
                        SizedBox(
                          height: 10,
                        ),
                        CommonDatePickerField(
                          controlName: 'dob',
                          placeHolderText: 'date_of_birth'.tr,
                          textInputAction: TextInputAction.done,
                          firstDate: _addNewIdentityPageController
                              .dateOfBirthValidation.fromDate,
                          lastDate: _addNewIdentityPageController
                              .dateOfBirthValidation.toDate,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'date_of_birth'.tr,
                                  _addNewIdentityPageController
                                      .dateOfBirthValidation),
                          isReadOnly: true,
                        ),
                        SizedBox(height: 30),
                        ButtonNormal(
                            buttonText: 'confirm'.tr,
                            isFullWidth: true,
                            onTapped: _addNewIdentityPageController.onConfirm),
                      ],
                    ),
                  ))),
    );
  }
}

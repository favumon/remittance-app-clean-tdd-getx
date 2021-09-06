import 'dart:async';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/signup/entities/terms_and_conditions.dart';
import 'package:domain/feature/signup/usecases/get_terms_and_conditions_text.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class TermsAndConditionsPageController extends GetxController {
  final GetTermsAndConditionsText getTermsAndConditionsText;
  StreamController<Either<Failure, TermsAndConditions>> _streamController =
      StreamController();

  final termsAndConditionsText = ''.obs;

  TermsAndConditionsPageController(this.getTermsAndConditionsText);

  @override
  void onInit() {
    getTermsAndConditionsText(NoParams()).then(processTermsAndConditions);
    _streamController.stream.listen((event) {
      processTermsAndConditions(event);
    });
    super.onInit();
  }

  void processTermsAndConditions(Either<Failure, TermsAndConditions> response) {
    response.fold((l) => null,
        (r) => termsAndConditionsText.value = r.termsAndConditionsText);
  }

  @override
  void onClose() {
    _streamController.close();
    super.onClose();
  }
}

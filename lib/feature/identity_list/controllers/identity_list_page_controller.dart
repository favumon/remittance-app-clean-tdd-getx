import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/identity_list/entities/identity_details.dart';
import 'package:domain/feature/identity_list/usecases/get_identities.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class IdentityListPageController extends GetxController {
  final GetIdentities getIdentities;
  final NavigationService navigationService;
  final identities = <IdentityDetails>[].obs;
  final isLoading = false.obs;
  IdentityListPageController(this.getIdentities, this.navigationService);

  @override
  void onInit() {
    super.onInit();

    loadIdentityItems();
  }

  void loadIdentityItems() {
    isLoading.value = true;
    fetchIdentitiesFromApi()
        .then((value) => value.fold((l) => isLoading.value = false, (r) {
              isLoading.value = false;
              identities.value = r;
            }));
  }

  Future<Either<Failure, List<IdentityDetails>>>
      fetchIdentitiesFromApi() async {
    return await getIdentities(NoParams());
  }
}

import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/usecases/get_top_exchange_rate.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class TopExchangeRateController extends GetxController {
  final GetTopExchangeRate _getTopExchangeRate;
  TopExchangeRateItem topExchangeRate =
      TopExchangeRateItem(currencyRate: 0, currencyCode: '');
  var busy = false.obs;

  TopExchangeRateController(this._getTopExchangeRate);

  @override
  void onInit() {
    super.onInit();
    initGetTopExchangeRate();
  }

  initGetTopExchangeRate() async {
    busy(true);
    var response = await _getTopExchangeRate(GetTopExchangeRateParams());
    response.fold((l) => null, (r) {
      topExchangeRate = r;
    });
    busy(false);
  }
}

import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/currency_converter/entity/currency_item.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/usecases/get_all_currency_list.dart';
import 'package:domain/feature/currency_converter/usecases/get_currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/usecases/get_currency_trend_chart_values.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

const String CURRENCY_I_HAVE = 'currency_i_have';
const String CURRENCY_I_WANT = 'currency_i_want';

@injectable
class CurrencyConverterController extends GetxController {
  final NavigationService navigationService;
  final GetCurrencyRateTrend getCurrencyRateTrend;
  final GetCurrencyTrendChartValues getCurrencyTrendChartValues;
  final GetAllCurrencyList getAllCurrencyList;
  final AlertService alertService;

  late final FormGroup form;

  CurrencyConverterController({
    required this.navigationService,
    required this.getAllCurrencyList,
    required this.getCurrencyRateTrend,
    required this.getCurrencyTrendChartValues,
    required this.alertService,
  });

  var baseCurrencyCode = "AED";
  var baseCurrencyName = 'Dirham';
  var basecurrencyFlagCode = 'ae';
  var baseCurrencyInDecimal = 2;

  var selectedCurrency = Rxn<CurrencyItem>();
  var currencyRate = CurrencyRate(rate: 0.0).obs;
  var currencyList = <CurrencyItem>[].obs;
  var currencyRateTrendList = <CurrencyRateTrend>[].obs;
  var searchedCurrencyList = <CurrencyItem>[].obs;

  var busy = false.obs;

  @override
  void onInit() async {
    super.onInit();

    busy(true);
    initFormFields();

    await initGetCurrencyList();
    await Future.wait([
      initCurrencyRate(),
      initChartValues(),
    ]);

    busy(false);
  }

  Future initGetCurrencyList() async {
    final currListRes = await getAllCurrencyList(NoParams());
    currListRes.fold(
        (l) =>
            alertService.showAlertSnackbar(title: '', message: l.message ?? ''),
        (r) {
      currencyList.value = r;
      selectedCurrency.value = currencyList[0];
      searchedCurrencyList.value = r;
    });
  }

  Future initCurrencyRate() async {
    if (selectedCurrency.value == null) return;
    final currencyRateRes = await getCurrencyRateTrend(
        GetCurrencyRateTrendParams(
            baseCurrencyCode: baseCurrencyCode,
            foreignCurrencyCode: selectedCurrency.value!.currencyCode));
    currencyRateRes.fold(
        (l) =>
            alertService.showAlertSnackbar(title: '', message: l.message ?? ''),
        (r) {
      currencyRate.value = r;
      calculateWantCurrency(r);
    });
  }

  calculateWantCurrency(CurrencyRate r) {
    var currencyWant =
        double.parse(getFormValue<String>(CURRENCY_I_HAVE)) * r.rate;
    form.controls[CURRENCY_I_WANT]?.value = currencyWant
        .toStringAsFixed(selectedCurrency.value!.currencyInDecimals);
  }

  Future initChartValues() async {
    currencyRateTrendList.clear();
    if (selectedCurrency.value == null) return;
    final currencyTrendChartRes = await getCurrencyTrendChartValues(
        GetCurrencyTrendChartParams(
            baseCurrencyCode, selectedCurrency.value!.currencyCode));
    currencyTrendChartRes.fold(
        (l) =>
            alertService.showAlertSnackbar(title: '', message: l.message ?? ''),
        (r) => currencyRateTrendList.value = r);
  }

  void navigateToCountryList() {
    navigationService.navigate(AppRouts.currencyList);
  }

  void goBack() {
    navigationService.navigateBack();
  }

  selectCurrency(int index) async {
    selectedCurrency.value = currencyList[index];
    currencyRateTrendList.clear();
    update();

    goBack();

    searchedCurrencyList.value = RxList.from(currencyList);

    busy(true);
    await Future.wait([
      initCurrencyRate(),
      initChartValues(),
    ]);
    busy(false);
  }

  filterCurrecySearchList(String value) {
    if (value != '') {
      searchedCurrencyList.value = currencyList
          .where((e) =>
              e.currencyName.toLowerCase().contains(value.toLowerCase()) ||
              e.countryName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      searchedCurrencyList.clear();
      searchedCurrencyList = RxList.from(currencyList);
    }
  }

  void initFormFields() {
    form = fb.group({
      CURRENCY_I_HAVE: FormControl<String>(value: '1.0'),
      CURRENCY_I_WANT: FormControl<String>(value: '1.0'),
    });
  }

  void onChangeIWantCurrency2() {
    final currencyIWant = getFormValue<String>(CURRENCY_I_WANT);

    if (currencyIWant == '' || currencyIWant == '.') {
      form.controls[CURRENCY_I_HAVE]?.value =
          double.parse('0.0').toStringAsFixed(baseCurrencyInDecimal);
      form.controls[CURRENCY_I_WANT]?.value = double.parse('0.0')
          .toStringAsFixed(selectedCurrency.value!.currencyInDecimals);
      return;
    }

    final value = currencyIWant.replaceAll(new RegExp(r'^0+(?=.)'), '');

    form.controls[CURRENCY_I_WANT]?.value = double.parse(value)
        .toStringAsFixed(selectedCurrency.value!.currencyInDecimals);
    form.controls[CURRENCY_I_HAVE]?.value =
        (double.parse(value) / currencyRate.value.rate)
            .toStringAsFixed(baseCurrencyInDecimal);
  }

  void onChangeIHaveCurrency2() {
    final currencyIHave = getFormValue<String>(CURRENCY_I_HAVE);

    if (currencyIHave == '' || currencyIHave == '.') {
      form.controls[CURRENCY_I_HAVE]?.value =
          double.parse('0.0').toStringAsFixed(baseCurrencyInDecimal);
      form.controls[CURRENCY_I_WANT]?.value = double.parse('0.0')
          .toStringAsFixed(selectedCurrency.value!.currencyInDecimals);
      return;
    }

    final value = currencyIHave.replaceAll(new RegExp(r'^0+(?=.)'), '');

    form.controls[CURRENCY_I_HAVE]?.value =
        double.parse(value).toStringAsFixed(baseCurrencyInDecimal);
    form.controls[CURRENCY_I_WANT]?.value =
        (double.parse(value) * currencyRate.value.rate)
            .toStringAsFixed(selectedCurrency.value!.currencyInDecimals);
  }

  T getFormValue<T>(String controlName) {
    return (form.controls[controlName] as FormControl<T>).value!;
  }
}

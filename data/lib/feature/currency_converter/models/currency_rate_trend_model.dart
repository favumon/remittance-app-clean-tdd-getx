import 'package:data/feature/currency_converter/models/currency_rate_trend_item_model.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend_item.dart';

class CurrencyRateTrendModel extends CurrencyRateTrend {
  final String trendPeriodTitle;
  final List<CurrencyRateTrendItem> trendItemList;

  CurrencyRateTrendModel(
      {required this.trendPeriodTitle, required this.trendItemList})
      : super(trendItemList: trendItemList, trendPeriodTitle: trendPeriodTitle);

  factory CurrencyRateTrendModel.fromMap(Map<String, dynamic> json) {
    return CurrencyRateTrendModel(
      trendPeriodTitle: json['chart_sec_title'],
      trendItemList: json['section_rates']
          .map<CurrencyRateTrendItemModel>(
              (item) => CurrencyRateTrendItemModel.fromMap(item))
          .toList(),
    );
  }
}

import 'package:equatable/equatable.dart';

import 'package:domain/feature/currency_converter/entity/currency_rate_trend_item.dart';

class CurrencyRateTrend extends Equatable {
  final String trendPeriodTitle;
  final List<CurrencyRateTrendItem> trendItemList;

  CurrencyRateTrend({required this.trendPeriodTitle,required this.trendItemList});

  @override
  List<Object?> get props => [trendPeriodTitle, trendItemList];
}

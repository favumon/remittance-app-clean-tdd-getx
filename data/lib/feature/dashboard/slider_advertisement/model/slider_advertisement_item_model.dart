import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';

class SliderAdvertisementModel extends SliderAdvertisementItem {
  final String adImageUrl;
  final adUrl;

  SliderAdvertisementModel({required this.adUrl, required this.adImageUrl})
      : super(adUrl: adUrl, imageUrl: adImageUrl);

  factory SliderAdvertisementModel.fromMap(Map<String, dynamic> json) {
    return SliderAdvertisementModel(
      adImageUrl: json['ad_image_url'],
      adUrl: json['ad_url'],
    );
  }
}

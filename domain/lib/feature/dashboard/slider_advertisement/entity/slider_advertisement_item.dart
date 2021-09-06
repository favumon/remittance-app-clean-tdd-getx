import 'package:equatable/equatable.dart';

class SliderAdvertisementItem extends Equatable {
  final String imageUrl;
  final String adUrl;

  SliderAdvertisementItem({required this.imageUrl, required this.adUrl});

  @override
  List<Object?> get props => [imageUrl, adUrl];
}

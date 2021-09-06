import 'package:equatable/equatable.dart';

class SignatureImage extends Equatable {
  final String signaturePath;
  final String signatureName;

  SignatureImage(this.signaturePath, this.signatureName);

  @override
  List<Object?> get props => [signaturePath, signatureName];
}

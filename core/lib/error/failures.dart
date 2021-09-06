import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  Failure({this.message});
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({String? message}) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure({String? message}) : super(message: message);
}

class RequestTimeout extends NetworkFailure {
  RequestTimeout({String? message}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({String? message}) : super(message: message);
}

class LocalStorageFailure extends Failure {
  LocalStorageFailure({String? message}) : super(message: message);
}

class SignupFailure extends Failure {
  SignupFailure({String? message}) : super(message: message);
}

class OtpVerificationFailure extends Failure {
  OtpVerificationFailure({String? message}) : super(message: message);
}

class BiometricAuthenticationFailure extends Failure {
  BiometricAuthenticationFailure({String? message}) : super(message: message);
}

class UserProfileUpdateFailure extends Failure {
  UserProfileUpdateFailure({String? message}) : super(message: message);
}

class ClientFailure extends Failure {
  ClientFailure({String? message}) : super(message: message);
}

class ImagePickFailure extends Failure {
  ImagePickFailure({String? message}) : super(message: message);
}

class PhotoAccessPermissionFailure extends Failure {
  final isPermenetlyDenied;
  PhotoAccessPermissionFailure({this.isPermenetlyDenied, String? message})
      : super(message: message);
}

class BiometricAuthLoginEnabledFailure extends Failure {
  BiometricAuthLoginEnabledFailure({String? message}) : super(message: message);
}

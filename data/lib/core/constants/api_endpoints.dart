import 'package:core/constants/build_environment.dart';
import 'package:injectable/injectable.dart';

abstract class ApiEndpoints {
  abstract String baseUrl;
  final String token = '/token';

  final String appsettings = 'v3/108dfa4a-eee8-4b60-86f8-2d0f2e36ee4c';
  final String generateOtp = 'v3/97c35559-4f8a-448b-9643-66402a85565e';
  final String signup = 'v3/97c35559-4f8a-448b-9643-66402a85565e';
  final String verifyOtp = 'v3/97c35559-4f8a-448b-9643-66402a85565e';
  final String userProfile = 'v3/b1da1305-55ca-401a-8d84-d6b382de34d2';
  final String updateProfile = 'v3/97c35559-4f8a-448b-9643-66402a85565e';
  final String sentEmailVerification =
      'v3/97c35559-4f8a-448b-9643-66402a85565e';
  final String identityIdTypes = 'v3/b13080cf-4200-49f1-9559-3d82c2e80ea0';
  final String identityNationalities =
      'v3/406db4cf-0a8a-4175-a0ad-c7d2de1b80ea';
  final String geNotifications = 'v3/badc1e7c-594d-4e54-b4f1-d581773847d8';
  final String updateNotificationReadStatus =
      'v3/774ecde6-2e3d-42a6-b42f-0e9285f0971a';
  final String addIdentity = 'v3/97c35559-4f8a-448b-9643-66402a85565e';
  final String transactionDetails = 'v3/3d878955-e5c7-4c1e-a21e-664a72ce81b5';
  final String transactionHistoryList =
      'v3/2afbc7bc-fce4-4536-a230-c0a985ed9bce';
  final String pendingTransactionHistoryList =
      'v3/d4016007-d775-49e3-b46a-4de7be41c44c';
  final String pendingTransactionDetails =
      'v3/91fec6dc-5c71-4224-9e91-4d5c14d7593d';
  final String userIdentities = 'v3/b9c09fab-a48c-4684-89df-10c945365469';
  final String cancelPendingTransaction =
      'v3/162350aa-6c6f-4719-a320-18e083532aca';
  final String completePendingTransaction =
      'v3/162350aa-6c6f-4719-a320-18e083532aca'; //TODO check its working
  final String termsAndConditions = 'v3/d2365a63-e7bd-4fdf-802d-ae61cf3b9aed';
  final String changePassword = 'v3/1521df4b-ccd3-4281-9135-25a8e4d26433';
  final String transactionFilterList =
      'v3/5b1dff35-c449-427e-8f2a-2f472dd4d811';
  final String notificationCount = 'v3/04f93798-e451-4b48-bca9-be2397531357';
  final String topExchageRate = 'v3/53cbcd38-7535-44f0-b665-5aedc6ca459f';
  final String loginAuth = 'v3/fd646190-48cd-42d2-b64e-e3d41f02b5d0';
  final String pendingTransactionCount =
      'v3/a4ece016-9911-4309-9e48-4d60992bb0eb';
  final String easyResendList = 'v3/5f632ada-1135-4f22-9df8-e652bcb75525';
  final String quickLink = 'v3/a85f9601-0fa7-4bd2-83fb-f885df3d554d';
  final sliderAds = 'v3/2e703fe0-ced5-4991-b1c5-f77d75c72050';
  final String getProductCurrencyList =
      'v3/2a461329-cde1-4772-b449-a1772dfffb4b';
  final String getCurrencyRate = 'v3/6a91c2b3-e148-494b-911c-79208d99da8a';
  final String getCurrencyRateTrendChart =
      'v3/6d1e0cd3-d164-48a0-bb21-9b923d35440b';
}

@LazySingleton(env: [BuildEnvironment.development], as: ApiEndpoints)
class ApiEndpointsDev extends ApiEndpoints {
  @override
  String baseUrl = 'https://run.mocky.io/';
}

@LazySingleton(env: [BuildEnvironment.production], as: ApiEndpoints)
class ApiEndpointsProd extends ApiEndpoints {
  @override
  String baseUrl = 'https://run.mocky.io/';
}

import 'package:injectable/injectable.dart';

import 'data_injection.config.dart';

@InjectableInit(initializerName: r'$initDataGetIt')
void configureDataDependencies(getIt) {
  $initDataGetIt(getIt);
}

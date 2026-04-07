import 'package:get_it/get_it.dart';
import 'network/currency_rate_network.dart';
import 'network/currency/currency_api.dart';
import 'services/currency_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<CurrencyRateNetwork>(() => CurrencyRateNetwork());
  getIt.registerLazySingleton<CurrencyApi>(
      () => CurrencyApi(getIt<CurrencyRateNetwork>()));
  getIt.registerLazySingleton<CurrencyRepository>(
      () => CurrencyRepository(getIt<CurrencyApi>()));
}

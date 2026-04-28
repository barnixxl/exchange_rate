import 'package:currency_converter/UI/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'network/currency/currency_api.dart';
import 'network/currency_rate_network.dart';
import 'resources/strings/app_localizations.dart';
import 'services/currency_repository.dart';

late final AppLocalizations strings;

Future<void> initializeLocale() async {
  await initializeDateFormatting('ru', null);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocale();

  strings = lookupAppLocalizations(
    const Locale('ru'),
  );

  final currencyRateNetwork = CurrencyRateNetwork();
  currencyRateNetwork.register();

  final currencyApi = CurrencyApi(
    CurrencyRateNetwork.getInstance(),
  );
  currencyApi.register();

  final currencyRepository = CurrencyRepository(
    CurrencyApi.getInstance(),
  );
  currencyRepository.register();

  runApp(
    Provider<CurrencyRepository>.value(
      value: CurrencyRepository.getInstance(),
      child: Provider<HomeController>(
        create: (_) => HomeController(
          CurrencyRepository.getInstance(),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}

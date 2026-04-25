import 'package:currency_converter/UI/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'services/currency_repository.dart';
import 'network/currency/currency_api.dart';
import 'network/currency_rate_network.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'resources/strings/app_localizations.dart';

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

  final repository = CurrencyRepository(
    CurrencyApi(CurrencyRateNetwork()),
  );
  runApp(
    Provider<CurrencyRepository>.value(
        value: repository,
        child: Provider<HomeController>(
          create: (context) => HomeController(
            Provider.of<CurrencyRepository>(
                context,
                listen: false,
            ),
          ),
          child: const MyApp(),
        )),
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

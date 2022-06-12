import 'package:client/core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:client/core/shared_service/shared_firebase_analytics.dart';
import 'package:client/core/router/route_generator.dart';
import 'package:client/injection.dart';
import 'package:client/core/environments/environments.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Settings.init(
    cacheProvider: SharePreferenceCache(),
  );
  configureDependencies();

  // configure env type
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environments.PROD,
  );
  Environments().initConfig(environment);

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: Key(''),
      navigatorKey: getIt<DialogService>().navigatorKey,
      navigatorObservers: [getIt<SharedFirebaseAnalytics>().getAnalyticsObserver],
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

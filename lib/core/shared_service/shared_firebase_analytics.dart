import 'package:injectable/injectable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

@lazySingleton
class SharedFirebaseAnalytics {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  FirebaseAnalytics get getAnalyticsInstance => analytics;
  FirebaseAnalyticsObserver getAnalyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);
}

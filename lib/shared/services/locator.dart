import 'package:get_it/get_it.dart';
import 'package:nour_al_quran/shared/services/analytics_services.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => AnalyticService());
}

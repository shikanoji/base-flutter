import 'package:get_it/get_it.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Network
  sl.registerLazySingleton(() => ApiClient());

  // Add other dependencies here as needed
}

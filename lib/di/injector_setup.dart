library injector_setup;

import 'package:get_it/get_it.dart';
import 'package:upm/data/datasource/local/database_helper.dart';
import 'package:upm/data/datasource/local/shared_preferences_manager.dart';
import 'package:upm/data/datasource/remote/http_handler.dart';
import 'package:upm/data/datasource/remote/rest_api_factory.dart';
import 'package:upm/data/datasource/remote/token_expired_handler.dart';

part 'independent_injector.dart';

part 'dependent_injector.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  setupIndependent();
  setupDependent();
}

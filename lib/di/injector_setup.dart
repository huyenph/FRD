library injector_setup;

import 'package:get_it/get_it.dart';
import 'package:upm/core/navigation/navigation_service.dart';
import 'package:upm/data/datasource/local/database_helper.dart';
import 'package:upm/data/datasource/local/shared_preferences_manager.dart';
import 'package:upm/data/datasource/remote/http_handler.dart';
import 'package:upm/data/datasource/remote/rest_api_factory.dart';
import 'package:upm/data/datasource/remote/token_expired_handler.dart';
import 'package:upm/data/repositories/app_repository_impl.dart';
import 'package:upm/domain/repositories/app_repositoy.dart';
import 'package:upm/domain/usecases/app_usecase.dart';
import 'package:upm/modules/auth/data/auth_repository_impl.dart';
import 'package:upm/modules/auth/data/auth_service.dart';
import 'package:upm/modules/auth/domain/repositories/auth_repository.dart';
import 'package:upm/modules/auth/domain/usecases/auth_usecase.dart';

part 'independent_injector.dart';

part 'dependent_injector.dart';

part '../modules/auth/auth_module.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  setupIndependent();
  setupDependent();
  authModule();
}

library injector_setup;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frd/core/navigation/navigation_service.dart';
import 'package:frd/data/datasource/remote/rest_api_factory.dart';
import 'package:frd/data/repositories/app_repository_impl.dart';
import 'package:frd/domain/repositories/app_repositoy.dart';
import 'package:frd/domain/usecases/app_usecase.dart';
import 'package:frd/modules/auth/data/auth_repository_impl.dart';
import 'package:frd/modules/auth/data/auth_service.dart';
import 'package:frd/modules/auth/domain/repositories/auth_repository.dart';
import 'package:frd/modules/auth/domain/usecases/auth_usecase.dart';
import 'package:get_it/get_it.dart';

part 'independent_injector.dart';

part 'dependent_injector.dart';

part '../modules/auth/auth_module.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  setupIndependent();
  setupDependent();
  authModule();
}

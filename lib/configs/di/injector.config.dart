// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../src/auth/data/datasources/auth_remote_data_src.dart' as _i6;
import '../../src/auth/data/repos/auth_repo_impl.dart' as _i8;
import '../../src/auth/domain/repos/auth_repo.dart' as _i7;
import '../../src/auth/domain/usecases/login_usecase.dart' as _i9;
import '../logger/app_logger.dart' as _i3;
import '../networking/dio_provider.dart' as _i10;
import '../networking/i_config.dart' as _i4;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioProvider = _$DioProvider();
  gh.singleton<_i3.AppLogger>(_i3.AppLogger());
  gh.factory<_i4.IConfig>(() => _i4.AppConfig());
  gh.singleton<_i5.Dio>(dioProvider.dio(
    gh<_i4.IConfig>(),
    gh<_i3.AppLogger>(),
  ));
  gh.factory<_i6.AuthRemoteDataSrc>(
      () => _i6.AuthRemoteDataSrcImpl(gh<_i5.Dio>()));
  gh.factory<_i7.AuthRepo>(() => _i8.AuthRepoImpl(gh<_i6.AuthRemoteDataSrc>()));
  gh.factory<_i9.LoginUseCase>(() => _i9.LoginUseCase(gh<_i7.AuthRepo>()));
  return getIt;
}

class _$DioProvider extends _i10.DioProvider {}

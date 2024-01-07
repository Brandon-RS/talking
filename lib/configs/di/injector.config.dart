// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../src/auth/data/datasources/auth_remote_data_src.dart' as _i5;
import '../../src/auth/data/repos/auth_repo_impl.dart' as _i7;
import '../../src/auth/domain/repos/auth_repo.dart' as _i6;
import '../../src/auth/domain/usecases/login_usecase.dart' as _i8;
import '../networking/dio_provider.dart' as _i9;
import '../networking/i_config.dart' as _i3;

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
  gh.factory<_i3.IConfig>(() => _i3.AppConfig());
  gh.singleton<_i4.Dio>(dioProvider.dio(gh<_i3.IConfig>()));
  gh.factory<_i5.AuthRemoteDataSrc>(
      () => _i5.AuthRemoteDataSrcImpl(gh<_i4.Dio>()));
  gh.factory<_i6.AuthRepo>(() => _i7.AuthRepoImpl(gh<_i5.AuthRemoteDataSrc>()));
  gh.factory<_i8.LoginUseCase>(() => _i8.LoginUseCase(gh<_i6.AuthRepo>()));
  return getIt;
}

class _$DioProvider extends _i9.DioProvider {}

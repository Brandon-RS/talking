// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../src/auth/data/datasources/auth_remote_data_src.dart' as _i10;
import '../../src/auth/data/repos/auth_repo_impl.dart' as _i12;
import '../../src/auth/domain/repos/auth_repo.dart' as _i11;
import '../../src/auth/domain/usecases/login_usecase.dart' as _i13;
import '../../src/auth/domain/usecases/logout_usecase.dart' as _i14;
import '../../src/user/data/datasources/user_remote_data_src.dart' as _i7;
import '../../src/user/data/repos/user_repo_impl.dart' as _i9;
import '../../src/user/domain/repos/user_repo.dart' as _i8;
import '../../src/user/domain/usecases/register_user_usecase.dart' as _i15;
import '../logger/app_logger.dart' as _i3;
import '../networking/dio_provider.dart' as _i16;
import '../networking/i_config.dart' as _i5;
import '../storage/storage_manager.dart' as _i4;

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
  gh.singleton<_i4.StorageManager>(_i4.StorageManager());
  gh.lazySingleton<_i5.IConfig>(() => _i5.AppConfig(gh<_i4.StorageManager>()));
  gh.lazySingleton<_i6.Dio>(() => dioProvider.dio(
        gh<_i5.IConfig>(),
        gh<_i3.AppLogger>(),
      ));
  gh.factory<_i7.UserRemoteDataSrc>(
      () => _i7.UserRemoteDataSrcImpl(gh<_i6.Dio>()));
  gh.factory<_i8.UserRepo>(() => _i9.UserRepoImpl(gh<_i7.UserRemoteDataSrc>()));
  gh.factory<_i10.AuthRemoteDataSrc>(
      () => _i10.AuthRemoteDataSrcImpl(gh<_i6.Dio>()));
  gh.factory<_i11.AuthRepo>(
      () => _i12.AuthRepoImpl(gh<_i10.AuthRemoteDataSrc>()));
  gh.factory<_i13.LoginUsecase>(() => _i13.LoginUsecase(gh<_i11.AuthRepo>()));
  gh.factory<_i14.LogoutUsecase>(() => _i14.LogoutUsecase(gh<_i11.AuthRepo>()));
  gh.factory<_i15.RegisterUserUsecase>(
      () => _i15.RegisterUserUsecase(gh<_i8.UserRepo>()));
  return getIt;
}

class _$DioProvider extends _i16.DioProvider {}

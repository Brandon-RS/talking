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

import '../../src/auth/data/datasources/auth_remote_data_src.dart' as _i8;
import '../../src/auth/data/repos/auth_repo_impl.dart' as _i10;
import '../../src/auth/domain/repos/auth_repo.dart' as _i9;
import '../../src/auth/domain/usecases/login_usecase.dart' as _i16;
import '../../src/auth/domain/usecases/logout_usecase.dart' as _i17;
import '../../src/auth/domain/usecases/renew_token.usecase.dart' as _i15;
import '../../src/chat/data/datasources/chats_remote_data_src.dart' as _i7;
import '../../src/chat/data/repos/chats_repo_impl.dart' as _i12;
import '../../src/chat/domain/repos/chats_repo.dart' as _i11;
import '../../src/chat/domain/usecases/get_last_chats_usecase.dart' as _i14;
import '../../src/user/data/datasources/user_remote_data_src.dart' as _i13;
import '../../src/user/data/repos/user_repo_impl.dart' as _i19;
import '../../src/user/domain/repos/user_repo.dart' as _i18;
import '../../src/user/domain/usecases/change_password_usecase.dart' as _i21;
import '../../src/user/domain/usecases/delete_account_usecase.dart' as _i20;
import '../../src/user/domain/usecases/get_all_users_usecase.dart' as _i23;
import '../../src/user/domain/usecases/register_user_usecase.dart' as _i22;
import '../../src/user/domain/usecases/upload_profile_pic_usecase.dart' as _i24;
import '../logger/app_logger.dart' as _i3;
import '../networking/dio_provider.dart' as _i25;
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
  gh.singleton<_i3.AppLogger>(() => _i3.AppLogger());
  gh.singleton<_i4.StorageManager>(() => _i4.StorageManager());
  gh.lazySingleton<_i5.IConfig>(() => _i5.AppConfig(gh<_i4.StorageManager>()));
  gh.lazySingleton<_i6.Dio>(() => dioProvider.dio(
        gh<_i5.IConfig>(),
        gh<_i3.AppLogger>(),
      ));
  gh.factory<_i7.ChatsRemoteDataSrc>(
      () => _i7.ChatsRemoteDataSrcImpl(gh<_i6.Dio>()));
  gh.factory<_i8.AuthRemoteDataSrc>(
      () => _i8.AuthRemoteDataSrcImpl(gh<_i6.Dio>()));
  gh.factory<_i9.AuthRepo>(
      () => _i10.AuthRepoImpl(gh<_i8.AuthRemoteDataSrc>()));
  gh.factory<_i11.ChatsRepo>(
      () => _i12.ChatsRepoImpl(gh<_i7.ChatsRemoteDataSrc>()));
  gh.factory<_i13.UserRemoteDataSrc>(
      () => _i13.UserRemoteDataSrcImpl(gh<_i6.Dio>()));
  gh.factory<_i14.GetLastChatsUsecase>(
      () => _i14.GetLastChatsUsecase(gh<_i11.ChatsRepo>()));
  gh.factory<_i15.RenewTokenUsecase>(() => _i15.RenewTokenUsecase(
        gh<_i9.AuthRepo>(),
        gh<_i4.StorageManager>(),
      ));
  gh.factory<_i16.LoginUsecase>(() => _i16.LoginUsecase(
        gh<_i9.AuthRepo>(),
        gh<_i4.StorageManager>(),
      ));
  gh.factory<_i17.LogoutUsecase>(() => _i17.LogoutUsecase(
        gh<_i9.AuthRepo>(),
        gh<_i4.StorageManager>(),
      ));
  gh.factory<_i18.UserRepo>(
      () => _i19.UserRepoImpl(gh<_i13.UserRemoteDataSrc>()));
  gh.factory<_i20.DeleteAccountUsecase>(() => _i20.DeleteAccountUsecase(
        gh<_i18.UserRepo>(),
        gh<_i4.StorageManager>(),
      ));
  gh.factory<_i21.ChangePasswordUsecase>(() => _i21.ChangePasswordUsecase(
        gh<_i18.UserRepo>(),
        gh<_i4.StorageManager>(),
      ));
  gh.factory<_i22.RegisterUserUsecase>(() => _i22.RegisterUserUsecase(
        gh<_i18.UserRepo>(),
        gh<_i4.StorageManager>(),
      ));
  gh.factory<_i23.GetAllUsersUsecase>(
      () => _i23.GetAllUsersUsecase(gh<_i18.UserRepo>()));
  gh.factory<_i24.UploadProfilePicUsecase>(
      () => _i24.UploadProfilePicUsecase(gh<_i18.UserRepo>()));
  return getIt;
}

class _$DioProvider extends _i25.DioProvider {}

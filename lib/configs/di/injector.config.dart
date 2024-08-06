// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../src/auth/data/datasources/auth_remote_data_src.dart' as _i1029;
import '../../src/auth/data/repos/auth_repo_impl.dart' as _i21;
import '../../src/auth/domain/repos/auth_repo.dart' as _i707;
import '../../src/auth/domain/usecases/login_usecase.dart' as _i699;
import '../../src/auth/domain/usecases/logout_usecase.dart' as _i280;
import '../../src/auth/domain/usecases/renew_token.usecase.dart' as _i51;
import '../../src/chat/data/datasources/chats_remote_data_src.dart' as _i710;
import '../../src/chat/data/repos/chats_repo_impl.dart' as _i320;
import '../../src/chat/domain/repos/chats_repo.dart' as _i453;
import '../../src/chat/domain/usecases/get_last_chats_usecase.dart' as _i652;
import '../../src/user/data/datasources/user_remote_data_src.dart' as _i533;
import '../../src/user/data/repos/user_repo_impl.dart' as _i573;
import '../../src/user/domain/repos/user_repo.dart' as _i685;
import '../../src/user/domain/usecases/change_password_usecase.dart' as _i774;
import '../../src/user/domain/usecases/delete_account_usecase.dart' as _i647;
import '../../src/user/domain/usecases/get_all_users_usecase.dart' as _i824;
import '../../src/user/domain/usecases/register_user_usecase.dart' as _i128;
import '../../src/user/domain/usecases/upload_profile_pic_usecase.dart' as _i42;
import '../logger/app_logger.dart' as _i293;
import '../networking/dio_provider.dart' as _i977;
import '../networking/i_config.dart' as _i72;
import '../storage/storage_manager.dart' as _i392;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dioProvider = _$DioProvider();
  gh.singleton<_i293.AppLogger>(() => _i293.AppLogger());
  gh.singleton<_i392.StorageManager>(() => _i392.StorageManager());
  gh.lazySingleton<_i72.IConfig>(
      () => _i72.AppConfig(gh<_i392.StorageManager>()));
  gh.lazySingleton<_i361.Dio>(() => dioProvider.dio(
        gh<_i72.IConfig>(),
        gh<_i293.AppLogger>(),
      ));
  gh.factory<_i710.ChatsRemoteDataSrc>(
      () => _i710.ChatsRemoteDataSrcImpl(gh<_i361.Dio>()));
  gh.factory<_i1029.AuthRemoteDataSrc>(
      () => _i1029.AuthRemoteDataSrcImpl(gh<_i361.Dio>()));
  gh.factory<_i707.AuthRepo>(
      () => _i21.AuthRepoImpl(gh<_i1029.AuthRemoteDataSrc>()));
  gh.factory<_i453.ChatsRepo>(
      () => _i320.ChatsRepoImpl(gh<_i710.ChatsRemoteDataSrc>()));
  gh.factory<_i533.UserRemoteDataSrc>(
      () => _i533.UserRemoteDataSrcImpl(gh<_i361.Dio>()));
  gh.factory<_i652.GetLastChatsUsecase>(
      () => _i652.GetLastChatsUsecase(gh<_i453.ChatsRepo>()));
  gh.factory<_i51.RenewTokenUsecase>(() => _i51.RenewTokenUsecase(
        gh<_i707.AuthRepo>(),
        gh<_i392.StorageManager>(),
      ));
  gh.factory<_i699.LoginUsecase>(() => _i699.LoginUsecase(
        gh<_i707.AuthRepo>(),
        gh<_i392.StorageManager>(),
      ));
  gh.factory<_i280.LogoutUsecase>(() => _i280.LogoutUsecase(
        gh<_i707.AuthRepo>(),
        gh<_i392.StorageManager>(),
      ));
  gh.factory<_i685.UserRepo>(
      () => _i573.UserRepoImpl(gh<_i533.UserRemoteDataSrc>()));
  gh.factory<_i647.DeleteAccountUsecase>(() => _i647.DeleteAccountUsecase(
        gh<_i685.UserRepo>(),
        gh<_i392.StorageManager>(),
      ));
  gh.factory<_i774.ChangePasswordUsecase>(() => _i774.ChangePasswordUsecase(
        gh<_i685.UserRepo>(),
        gh<_i392.StorageManager>(),
      ));
  gh.factory<_i128.RegisterUserUsecase>(() => _i128.RegisterUserUsecase(
        gh<_i685.UserRepo>(),
        gh<_i392.StorageManager>(),
      ));
  gh.factory<_i824.GetAllUsersUsecase>(
      () => _i824.GetAllUsersUsecase(gh<_i685.UserRepo>()));
  gh.factory<_i42.UploadProfilePicUsecase>(
      () => _i42.UploadProfilePicUsecase(gh<_i685.UserRepo>()));
  return getIt;
}

class _$DioProvider extends _i977.DioProvider {}

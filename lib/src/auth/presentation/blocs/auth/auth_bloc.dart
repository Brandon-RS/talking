import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talking/src/auth/domain/usecases/logout_usecase.dart';
import 'package:talking/src/auth/domain/usecases/renew_token.usecase.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';
import 'package:talking/src/user/domain/usecases/delete_account_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RenewTokenUsecase renewTokenUsecase,
    required LogoutUsecase logoutUsecase,
    required DeleteAccountUsecase deleteAccountUsecase,
  })  : _renewTokenUsecase = renewTokenUsecase,
        _logoutUsecase = logoutUsecase,
        _deleteAccountUsecase = deleteAccountUsecase,
        super(const AuthState()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<UpdateProfilePic>(_onUpdateProfilePic);
    on<RenewToken>(_onRenewToken);
    on<Logout>(_onLogout);
    on<DeleteAccount>(_onDeleteAccount);
  }

  final RenewTokenUsecase _renewTokenUsecase;
  final LogoutUsecase _logoutUsecase;
  final DeleteAccountUsecase _deleteAccountUsecase;

  void _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(state.copyWith(status: AuthStatus.unauthenticated));
      case AuthStatus.authenticated:
        return emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: event.user,
        ));
      default:
        return emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void _onUpdateProfilePic(
    UpdateProfilePic event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      user: state.user.copyWith(profileImage: event.url),
    ));
  }

  void _onRenewToken(
    RenewToken event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _renewTokenUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: failure.message,
      )),
      (model) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: model.user,
      )),
    );
  }

  void _onLogout(
    Logout event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _logoutUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: failure.message,
      )),
      (_) => emit(const AuthState()),
    );
  }

  void _onDeleteAccount(
    DeleteAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _deleteAccountUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        error: failure.message,
      )),
      (_) => emit(const AuthState()),
    );
  }
}

part of 'auth_bloc.dart';

enum AuthStatus { loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user = User.empty,
    this.error = '',
  });

  final AuthStatus status;
  final User user;
  final String error;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == AuthStatus.loading;

  bool get hasImage => user.profileImage != null && user.profileImage!.isNotEmpty;

  @override
  List<Object> get props => [status];
}

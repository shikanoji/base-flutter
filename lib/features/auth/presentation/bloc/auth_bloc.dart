import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 1));
    if (email == 'test@example.com' && password == '1234') {
      emit(AuthSuccess());
    } else {
      emit(AuthError('Invalid credentials'));
    }
  }
}

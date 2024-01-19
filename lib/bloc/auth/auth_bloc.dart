import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: 'User Not Found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(
                errorMessage: 'Wrong password provided for that user.'));
          } else {
            emit(LoginFailure(errorMessage: 'Username or Password is defind'));
          }
        } catch (e) {
          emit(LoginFailure(errorMessage: e.toString()));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(
                errorMessage: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(
                errorMessage: 'The account already exists for that email.'));
          } else {
            emit(RegisterFailure(
                errorMessage: 'Username or Password is defind'));
          }
        } catch (e) {
          emit(RegisterFailure(errorMessage: e.toString()));
        }
      }
    });
  }
}

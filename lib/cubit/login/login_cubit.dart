import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginServices(String email, String password) async {
    emit(LoginLoading());
    try {
    UserCredential userCredential=  await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'User Not Found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(
            errorMessage: 'Wrong password provided for that user.'));
      }else{
        emit(LoginFailure(errorMessage: 'Username or Password is defind'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}

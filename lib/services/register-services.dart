  import 'package:firebase_auth/firebase_auth.dart';

Future<void> ResgisterServices(String email,String password )async {
     UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email, password: password);
  }
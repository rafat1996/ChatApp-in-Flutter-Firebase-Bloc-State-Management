import 'package:chatapp/constants/color.dart';
import 'package:chatapp/helper/show-snack-bar.dart';
import 'package:chatapp/services/login-services.dart';
import 'package:chatapp/widgets/custom-button-widget.dart';
import 'package:chatapp/widgets/custom-text-form-field-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;

  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimeryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/logo.png',
                  height: 200,
                ),
                const Center(
                  child: Text(
                    'Chat App',
                    style: TextStyle(
                        fontSize: 40,
                        color: kTextColor,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Text(
                      'Sign In',
                      style: TextStyle(fontSize: 25, color: kTextColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFieldWidget(
                  hint: 'Email',
                  onChanged: (data) {
                    email = data;
                  }, obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFieldWidget(
                  hint: 'Password',
                  onChanged: (data) {
                    password = data;
                  }, obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButtonWidget(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await LoginServices(email!, password!);
                        Navigator.pushNamed(context, 'ChatView',arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        showSnackBar(context, 'Error');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'dont have an account?  ',
                      style: TextStyle(color: kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterView');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: kTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

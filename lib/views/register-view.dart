import 'package:chatapp/constants/color.dart';
import 'package:chatapp/helper/show-snack-bar.dart';
import 'package:chatapp/services/register-services.dart';
import 'package:chatapp/widgets/custom-button-widget.dart';
import 'package:chatapp/widgets/custom-text-form-field-widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

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
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Text(
                      'Register',
                      style: TextStyle(fontSize: 25, color: Colors.white),
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
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await ResgisterServices(email!, password!);
                        Navigator.pushNamed(context, 'ChatView',arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
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
                      'Already Have Account?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
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

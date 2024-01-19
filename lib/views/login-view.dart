import 'package:chatapp/bloc/auth/auth_bloc.dart';
import 'package:chatapp/constants/color.dart';
import 'package:chatapp/cubit/chat/chat_cubit.dart';

import 'package:chatapp/helper/show-snack-bar.dart';
import 'package:chatapp/widgets/custom-button-widget.dart';
import 'package:chatapp/widgets/custom-text-form-field-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();

    String? email;

    String? password;
    bool isLoading = false;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, 'ChatView', arguments: email);
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
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
                  const Row(
                    children: [
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
                    },
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormFieldWidget(
                    hint: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButtonWidget(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(email: email!, password: password!));
                      } else {
                        showSnackBar(context, 'something went Wrong');
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
      ),
    );
  }
}

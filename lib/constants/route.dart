
import 'package:chatapp/views/chat-view.dart';
import 'package:chatapp/views/login-view.dart';
import 'package:chatapp/views/register-view.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> route = {
  '/': (context) =>  LoginView(),
  'RegisterView': (context) =>  RegisterView(),
  'ChatView':(context)=> ChatView(),
};

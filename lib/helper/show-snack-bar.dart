  import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
  }
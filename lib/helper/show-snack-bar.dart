  import 'package:flutter/material.dart';

 showSnackBar(BuildContext context, String e) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
  }



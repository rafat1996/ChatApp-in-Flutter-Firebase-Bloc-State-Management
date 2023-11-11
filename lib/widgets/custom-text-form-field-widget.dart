import 'package:flutter/material.dart';

import 'package:chatapp/constants/color.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
    const CustomTextFormFieldWidget({
    Key? key,
    required this.hint, this.onChanged, required this.obscureText,
  }) : super(key: key);
  final String hint;
  final Function(String)? onChanged;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'Please Enter The Field';
        }
      },
      obscureText:obscureText ,
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: kTextColor),
          
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}

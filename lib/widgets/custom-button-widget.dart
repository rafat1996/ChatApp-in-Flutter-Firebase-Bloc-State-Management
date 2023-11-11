import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Color.fromARGB(242, 53, 13, 146)),
          ),
        ),
      ),
    );
  }
}

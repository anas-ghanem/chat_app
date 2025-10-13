import 'package:flutter/material.dart';

class custom_button extends StatelessWidget {
  String text;
   custom_button({required this.text,required this.onPressed});
   VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 35,
        child: Text(
         text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xff2B475E), fontSize: 20),
        ),
      ),
    );
  }
}

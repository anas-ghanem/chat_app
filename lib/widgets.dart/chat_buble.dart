import 'package:chat_app/conset.dart';
import 'package:chat_app/massage_model.dart';
import 'package:flutter/material.dart';

class chat_buble extends StatelessWidget {
  const chat_buble({
    super.key,required this.massage,
  });
  final Massage massage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(top: 16,bottom: 16,left: 10,right: 10),
       
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 36, 121, 190),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
           
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(massage.massage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        
      ),
    );
  }
}

class chat_bubleforfrinds extends StatelessWidget {
  const chat_bubleforfrinds({
    super.key,required this.massage,
  });
  final Massage massage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(top: 16,bottom: 16,left: 10,right: 10),
       
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: kprimarykey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
           
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Text(massage.massage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        
      ),
    );
  }
}

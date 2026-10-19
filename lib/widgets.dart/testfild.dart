import 'package:chat_app/conset.dart';
import 'package:flutter/material.dart';

class custom_textfild extends StatelessWidget {
  final String? hinttext;
  final Function(String)? onChanged;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const custom_textfild({
    super.key,
    required this.hinttext,
    required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Color(0xff1D2A36)),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator:
          validator ??
          (value) {
            if ((value ?? '').trim().isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(color: Color(0xff7B8794)),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: kprimarykey) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: kprimarykey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
      ),
    );
  }
}

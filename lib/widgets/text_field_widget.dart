import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  TextFieldWidget({required this.label, required this.keyboardType, required this.controller, this.obscureText = false, this.suffixIcon, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${label}', style: TextStyle(fontSize: 15)),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(14),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.green,
                    width: 2
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.green,
                    width: 2
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.green,
                    width: 2
                )
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Colors.red,
                    width: 3
                )
            ),
          ),
          validator: validator,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class primaryBtnWidget extends StatelessWidget {

  final String label;
  final VoidCallback? onPressed;

  primaryBtnWidget({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('${label}', style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

}

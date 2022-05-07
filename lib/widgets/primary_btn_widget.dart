import 'package:flutter/material.dart';
import 'package:movies_app/constants/sizes.dart';

class primaryBtnWidget extends StatelessWidget {

  final String label;
  final VoidCallback? onPressed;

  primaryBtnWidget({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('${label}', style: TextStyle(fontSize: Sizes.label)),
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

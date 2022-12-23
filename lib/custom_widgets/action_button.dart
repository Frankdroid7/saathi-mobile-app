import 'package:flutter/material.dart';
import 'package:saathi/styles.dart';

class ActionButton extends StatelessWidget {
  ActionButton(
      {Key? key,
      this.icon,
      this.buttonColor = AppColors.primaryTextColor,
      required this.onPressed,
      required this.title})
      : super(key: key);
  final String title;
  final Widget? icon;
  Color buttonColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => buttonColor),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(title),
              ),
            ),
            icon ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class ElevatedSquareButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? disabledBackgroundColor;
  final IconData icon;

  const ElevatedSquareButton({
    super.key,
    this.onPressed,
    required this.text,
    this.width = 110,
    this.height = 110,
    this.disabledBackgroundColor = ButtonColor.black,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10),
          elevation: 3,
          backgroundColor: ButtonColor.white,
          foregroundColor: ButtonColor.darkBrown,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: ButtonColor.white,
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: ButtonColor.brown),
            const SizedBox(height: 10),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

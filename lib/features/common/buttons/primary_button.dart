import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? width;
  final Color? disabledBackgroundColor;

  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.text,
    this.width,
    this.disabledBackgroundColor = ButtonColor.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: ButtonColor.brown,
          textStyle: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: ButtonColor.white,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

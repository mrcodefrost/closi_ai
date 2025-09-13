import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class LargeSquareButton extends StatefulWidget {
  final double? height;
  final double? width;
  final IconData icon;
  final String heading;
  final String description;
  final VoidCallback? onSelected; // callback when selected
  final VoidCallback? onUnselected; // optional callback when unselected

  const LargeSquareButton({
    super.key,
    this.height,
    this.width,
    required this.icon,
    required this.heading,
    required this.description,
    this.onSelected,
    this.onUnselected,
  });

  @override
  State<LargeSquareButton> createState() => _LargeSquareButtonState();
}

class _LargeSquareButtonState extends State<LargeSquareButton> {
  bool _isSelected = false; // track state

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });

    if (_isSelected) {
      widget.onSelected?.call();
    } else {
      widget.onUnselected?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleSelection,
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isSelected
              ? ButtonColor.brown
              : Colors.transparent, // background
          border: Border.all(
            color: ButtonColor.brown,
            width: 2,
          ), // visible only when not selected
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: _isSelected ? Colors.black : Colors.brown,
              size: 30,
            ),
            const SizedBox(height: 10),
            Text(
              widget.heading,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

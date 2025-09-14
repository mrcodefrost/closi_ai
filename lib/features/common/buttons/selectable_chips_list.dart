import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class SelectableChipsList<T> extends StatefulWidget {
  final List<T> items; // generic type (can be object, string, int, etc.)
  final String Function(T item) labelBuilder; // how to display text
  final dynamic Function(T item)? valueBuilder; // optional: extract ID/value
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? textStyle;
  final void Function(T item, int index)? onSelected;

  const SelectableChipsList({
    super.key,
    required this.items,
    required this.labelBuilder,
    this.valueBuilder,
    this.selectedColor = ButtonColor.darkBrown,
    this.unselectedColor = ButtonColor.fadedBrown,
    this.textStyle,
    this.onSelected,
  });

  @override
  State<SelectableChipsList<T>> createState() => _SelectableChipsListState<T>();
}

class _SelectableChipsListState<T> extends State<SelectableChipsList<T>> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final isSelected = selectedIndex == index;

          return ChoiceChip(
            label: Text(
              widget.labelBuilder(item),
              style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                selectedIndex = index;
              });
              if (widget.onSelected != null) {
                widget.onSelected!(item, index); // return full object + index
              }
            },
            selectedColor: widget.selectedColor,
            backgroundColor: widget.unselectedColor,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.transparent, width: 1),
            ),
          );
        },
      ),
    );
  }
}

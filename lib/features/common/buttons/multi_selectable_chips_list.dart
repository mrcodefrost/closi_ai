import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class MultiSelectableChipsList<T> extends StatefulWidget {
  final List<T> items; // generic type
  final String Function(T item) labelBuilder;
  final dynamic Function(T item)? valueBuilder;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? textStyle;
  final void Function(List<T> selectedItems)? onSelectionChanged;

  const MultiSelectableChipsList({
    super.key,
    required this.items,
    required this.labelBuilder,
    this.valueBuilder,
    this.selectedColor = ButtonColor.darkBrown,
    this.unselectedColor = ButtonColor.fadedBrown,
    this.textStyle,
    this.onSelectionChanged,
  });

  @override
  State<MultiSelectableChipsList<T>> createState() =>
      _MultiSelectableChipsListState<T>();
}

class _MultiSelectableChipsListState<T>
    extends State<MultiSelectableChipsList<T>> {
  final Set<int> _selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(widget.items.length, (index) {
        final item = widget.items[index];
        final isSelected = _selectedIndexes.contains(index);

        return ChoiceChip(
          label: Text(
            widget.labelBuilder(item),
            style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedIndexes.add(index);
              } else {
                _selectedIndexes.remove(index);
              }
            });

            if (widget.onSelectionChanged != null) {
              final selectedItems = _selectedIndexes
                  .map((i) => widget.items[i])
                  .toList();
              widget.onSelectionChanged!(selectedItems);
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
      }),
    );
  }
}

import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item) itemLabel; // Extracts display value
  final void Function(T)? onSelected;
  final double? width;
  final String hintText;
  final FormFieldValidator<T>? validator;
  final T? initialValue;
  final bool? check;

  const CustomDropDownMenu({
    super.key,
    required this.items,
    required this.itemLabel,
    this.onSelected,
    this.width,
    this.hintText = '',
    this.validator,
    this.initialValue,
    this.check,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        isDense: true,
        value: initialValue,
        validator: validator,
        icon: Icon(Icons.keyboard_arrow_down, color: IconColor.lightBlack),
        dropdownColor: Theme.of(context).colorScheme.surface,
        hint: Text(
          hintText,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: TextColor.lightBlack),
        ),
        decoration: InputDecoration(
          fillColor: check == true ? BackgroundColor.white : Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: BorderColor.paleBrown,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: BorderColor.brown),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemLabel(item), // Extracts display text dynamically
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }).toList(),
        onChanged: (T? value) {
          if (value != null && onSelected != null) {
            onSelected!(value);
          }
        },
      ),
    );
  }
}

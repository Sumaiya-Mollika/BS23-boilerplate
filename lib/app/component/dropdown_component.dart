import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/style.dart';
import 'text_component.dart';

class DropdownComponent<T> extends StatelessWidget {
  final RxList<T> items;
  final Rx<T?> selectedValue;
  final String hintText;
  final String Function(T?) getItemLabel;
  final Function(T?) onChanged;

  const DropdownComponent({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.getItemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<T>(
          value: selectedValue.value,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hintColor,
              fontFamily: primaryFont,
              fontSize: textSmallFontSize,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16.0),
          ),
          isExpanded: true,
          onChanged: (T? newValue) {
            onChanged(newValue);
          },
          items: items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: TextComponent(getItemLabel(value)),
            );
          }).toList(),
        ));
  }
}

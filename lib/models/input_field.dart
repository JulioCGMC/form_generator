import 'package:flutter/material.dart';

/// The model from which the FormField is generated,
/// in relation to the fields received.
@immutable
class InputField {
  /// The key of the input for the result map, after validation
  final String id;

  /// The type of the field you're trying to show
  final FieldType fieldType;

  /// The initial value to be shown in the generated field
  final dynamic? initialValue;
  final String? hintText;
  final Widget? prefixIcon;
  final List<DropdownMenuItem<String>>? items;

  /// The validation required f
  final String? Function(String?)? validator;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController]
  /// and initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// The model from which the FormField is generated,
  /// in relation to the fields received.
  InputField(
      {required this.id,
      required this.fieldType,
      this.hintText,
      this.prefixIcon,
      this.initialValue,
      this.items,
      this.controller,
      this.validator,
      this.focusNode})
      : assert((fieldType != FieldType.dropdown || items != null),
            'Dropdown type require items not null');
}

enum FieldType { text, number, password, email, dropdown, date, time }

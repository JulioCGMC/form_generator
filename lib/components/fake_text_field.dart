import 'package:flutter/material.dart';
import 'package:form_generator/models/input_field.dart';

class FakeTextField extends StatefulWidget {
  final InputField value;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final String? cancelText;
  final String? confirmText;

  const FakeTextField({
    Key? key,
    required this.value,
    required this.controller,
    this.onChanged,
    this.decoration,
    this.cancelText,
    this.confirmText,
  }) : super(key: key);

  @override
  _FakeTextFieldState createState() => _FakeTextFieldState();
}

class _FakeTextFieldState extends State<FakeTextField> {
  Future<void> _showPicker(context) async {
    var result;
    if (widget.value.fieldType == FieldType.date) {
      DateTime initialDate = widget.value.initialValue != null
          ? widget.value.initialValue is DateTime
              ? widget.value.initialValue
              : DateTime.tryParse(widget.value.initialValue)
          : DateTime.now();
      result = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime.now().subtract(Duration(days: 365 * 100)),
          lastDate: DateTime.now().add(Duration(days: 365 * 100)),
          cancelText: widget.cancelText,
          confirmText: widget.confirmText);
    } else if (widget.value.fieldType == FieldType.time) {
      TimeOfDay initialTime = widget.value.initialValue != null
          ? widget.value.initialValue is TimeOfDay
              ? widget.value.initialValue
              : widget.value.initialValue is DateTime
                  ? TimeOfDay.fromDateTime(widget.value.initialValue)
                  : TimeOfDay.fromDateTime(
                      DateTime.tryParse(widget.value.initialValue) ??
                          DateTime.now())
          : TimeOfDay.now();
      result = await showTimePicker(
          context: context,
          initialTime: initialTime,
          cancelText: widget.cancelText,
          confirmText: widget.confirmText);
    }
    if (result != null) {
      if (widget.value.fieldType == FieldType.date) {
        widget.onChanged!(result.toString().split(" ")[0]);
        setState(() {
          widget.controller.text = result.toString().split(" ")[0];
        });
      } else {
        widget.onChanged!(result.format(context));
        setState(() {
          widget.controller.text = result.format(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: (text) => FocusScope.of(context).nextFocus(),
      focusNode:
          widget.value.focusNode ?? FocusNode(debugLabel: widget.value.id),
      validator: widget.value.validator,
      decoration: widget.decoration,
      readOnly: true,
      onTap: () => _showPicker(context),
    );
  }
}

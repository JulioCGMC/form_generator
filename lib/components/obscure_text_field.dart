import 'package:flutter/material.dart';
import 'package:form_generator/models/input_field.dart';

class CustomTextField extends StatefulWidget {
  final InputField value;
  final void Function(String) onChanged;
  final InputDecoration decoration;
  final bool obscureText;

  const CustomTextField(
      {Key key,
      @required this.value,
      this.onChanged,
      this.decoration,
      this.obscureText = false})
      : super(key: key);

  @override
  _CustomTextFieldState createState() =>
      _CustomTextFieldState(this.obscureText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText;

  _CustomTextFieldState(this.obscureText);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.value.controller,
      onFieldSubmitted: (text) => FocusScope.of(context).nextFocus(),
      focusNode:
          widget.value.focusNode ?? FocusNode(debugLabel: widget.value.id),
      initialValue: widget.value.initialValue,
      validator: widget.value.validator,
      onChanged: widget.onChanged,
      obscureText: obscureText,
      decoration: widget.decoration
          ?.copyWith(suffixIcon: widget.obscureText ? _obscureIcon() : null),
      keyboardType: widget.value.fieldType == FieldType.number
          ? TextInputType.number
          : widget.value.fieldType == FieldType.email
              ? TextInputType.emailAddress
              : TextInputType.text,
    );
  }

  Widget _obscureIcon() => GestureDetector(
        onTap: () => setState(() {
          obscureText = !obscureText;
        }),
        child: Icon(
          (obscureText ? Icons.visibility : Icons.visibility_off),
          color: Colors.grey[700],
        ),
      );
}

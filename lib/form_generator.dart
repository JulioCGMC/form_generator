library form_generator;

import 'package:flutter/material.dart';
import 'package:form_generator/components/fake_text_field.dart';
import 'package:form_generator/components/obscure_text_field.dart';

import 'models/input_field.dart';

export 'models/input_field.dart';


class FormGenerator extends StatefulWidget {
  /// The list of fields to be generated
  final List<InputField> fieldList;
  /// The separator between each field generated
  final Widget Function(BuildContext, int)? separatorBuilder;
  /// The border, labels, icons, and styles used to decorate a Material Design text field.
  /// The [TextField] and [InputDecorator] classes use [InputDecoration] objects to describe 
  /// their decoration. (In fact, this class is merely the configuration of an [InputDecorator], 
  /// which does all the heavy lifting.) This sample shows how to style a TextField using
  /// an InputDecorator. The TextField displays a "send message" icon to the left of the 
  /// input area, which is surrounded by a border an all sides. It displays the hintText 
  /// inside the input area to help the user understand what input is required. It displays
  /// the helperText and counterText below the input area.
  final InputDecoration Function(InputField)? decoration;
  /// The widget to show as child of the [ElevatedButton]
  final Widget? buttonChild;
  /// The [ElevatedButton] style
  final ButtonStyle? buttonStyle;
  final EdgeInsetsGeometry? padding;
  /// The resulting value from the inputs after the validation be applied
  final Function(Map<String,String>)? onValidate;
  /// `cancelText` for [showDatepicker] and [showTimePicker]
  final String? cancelText;
  /// `confirmText` for [showDatepicker] and [showTimePicker]
  final String? confirmText;

  FormGenerator({
    required this.fieldList,
    this.separatorBuilder,
    this.decoration,
    this.padding = const EdgeInsets.all(8.0),
    this.onValidate,
    this.buttonChild,
    this.buttonStyle,
    this.cancelText,
    this.confirmText
  });

  @override
  _FormGeneratorState createState() => _FormGeneratorState();
}

class _FormGeneratorState extends State<FormGenerator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> json = {}; 
  
  void _setValue(String key, String value) {
    json[key] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView.separated(
        padding: widget.padding,
        itemCount: widget.fieldList.length + 1,
        itemBuilder: (context, index) 
          => (index < widget.fieldList.length 
            ? generator(widget.fieldList.elementAt(index))
          : submitButton()),
        separatorBuilder: widget.separatorBuilder 
          ?? (context, index) => Divider(),
      )
    );
  }

  Widget generator(InputField value) {
    Widget response;
    switch (value.fieldType) {
      case FieldType.text:
      case FieldType.number:
      case FieldType.email:
      case FieldType.password:
        response = CustomTextField(
          value: value,
          obscureText: (value.fieldType == FieldType.password),
          decoration: widget.decoration != null ? widget.decoration!(value)
            : InputDecoration(hintText: value.hintText, prefixIcon: value.prefixIcon),
          onChanged: (text) => _setValue(value.id, text),
        );
      break;
      case FieldType.date:
      case FieldType.time:
        response = FakeTextField(
          value: value,
          controller: value.controller 
            ?? TextEditingController(text: value.initialValue),
          cancelText: widget.cancelText,
          confirmText: widget.confirmText,
          decoration: widget.decoration != null ? widget.decoration!(value)
            : InputDecoration(hintText: value.hintText, prefixIcon: value.prefixIcon),
          onChanged: (text) => _setValue(value.id, text),
        );
      break;
      case FieldType.dropdown:
        response = DropdownButtonFormField<String>(
          items: value.items,
          onChanged: (text) => _setValue(value.id, text.toString()),
          decoration:  widget.decoration != null ? widget.decoration!(value)
            : InputDecoration(hintText: value.hintText, prefixIcon: value.prefixIcon),
        );
      break;
    }
    return response;
  }

  Widget submitButton() => ElevatedButton(
    onPressed: () {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        if (widget.onValidate != null) {
          widget.onValidate!(json);
        }
      }
    },
    style: widget.buttonStyle,
    child: widget.buttonChild ?? Text("Salvar")
  );
}

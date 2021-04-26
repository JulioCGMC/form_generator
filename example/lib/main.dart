import 'package:flutter/material.dart';
import 'package:form_generator/form_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: FormGenerator(
        onValidate: (response) {
          print("After the button click and validation:");
          print(response);

          /// Example of response:
          /// {
          ///   text_field: My text, email_field: email@email.com,
          ///   number_field: 123456789, password_field: dJufli@o2,
          ///   date_field: 2021-04-28, time_field: 22:56, dropdown_field: 6
          /// }
        },
        fieldList: <InputField>[
          InputField(
              id: "text_field",
              hintText: "Hint Text",
              fieldType: FieldType.text),
          InputField(
              id: "email_field",
              hintText: "Hint Email",
              fieldType: FieldType.email),
          InputField(
              id: "number_field",
              hintText: "Hint Number",
              fieldType: FieldType.number),
          InputField(
              id: "password_field",
              hintText: "Hint Password",
              fieldType: FieldType.password),
          InputField(
              id: "date_field",
              hintText: "Hint Date",
              fieldType: FieldType.date),
          InputField(
              id: "time_field",
              hintText: "Hint Time",
              fieldType: FieldType.time),
          InputField(
              id: "dropdown_field",
              hintText: "Hint Dropdown",
              fieldType: FieldType.dropdown,
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem(child: Text("The first number"), value: "1"),
                DropdownMenuItem(
                    child: Text("The man should not walk alone"), value: "2"),
                DropdownMenuItem(
                    child: Text("As in the parts of a same being"), value: "3"),
                DropdownMenuItem(
                    child: Text("What is all this four"), value: "4"),
                DropdownMenuItem(child: Text("My colleagues age"), value: "5"),
                DropdownMenuItem(
                    child: Text("I think you get it now"), value: "6"),
                DropdownMenuItem(child: Text("I'ts over anakin.."), value: "7"),
              ]),
        ],
        decoration: (value) => InputDecoration(
          hintText: value.hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        buttonStyle: ElevatedButton.styleFrom(minimumSize: Size(5, 45)),
      ),
    );
  }
}

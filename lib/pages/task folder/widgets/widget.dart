import 'package:flutter/material.dart';

Widget myTextfieldWidget(String text, TextEditingController controller) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please Enter $text';
      }
      return null;
    },
    controller: controller,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
        hintStyle: TextStyle(fontSize: 11,color: Colors.grey)),
    maxLines: null,
  );
}

Widget textWidget(String text) {
  return Container(
      margin: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
      ));
}

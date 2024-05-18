import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget textFieldContainer(
    TextEditingController controller, String text, bool obscText, Icon prefix) {
  bool _passVisibility = true;
  return TextFormField(
    controller: controller,
    obscureText: obscText,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please Enter $text';
      }
      return null;
    },
    decoration: InputDecoration(
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(25.0),
      //   borderSide: const BorderSide(
      //     color: Colors.grey,
      //   ),
      // ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(25.0),
      //   borderSide: const BorderSide(
      //     color: Colors.grey,
      //   ),
      // ),

      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(25.0),
      //   borderSide: const BorderSide(
      //     color: Colors.grey,
      //   ),
      // ),
      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      prefixIcon: prefix,
      contentPadding: const EdgeInsets.only(left: 10),
      filled: true,
      // suffixIcon: ,
      hintStyle: const TextStyle(fontSize: 12),
      hintText: text,
      // border: InputBorder.none,
      fillColor: Colors.white70,
    ),
  );
}

Widget buttonContainer(String btn, void Function()? fun, BuildContext context) {
  return GestureDetector(
    onTap: fun,
    child: Container(
      // margin: EdgeInsets.only(top: 20,right: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25)),
      child: Center(
          child: Text(
        btn,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
    ),
  );
}

showToastWidget(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

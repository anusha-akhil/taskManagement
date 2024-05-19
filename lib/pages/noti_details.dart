import 'package:flutter/material.dart';

class Notidetail extends StatefulWidget {
  String? payload;
  Notidetail({super.key, this.payload});

  @override
  State<Notidetail> createState() => _NotidetailState();
}

class _NotidetailState extends State<Notidetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Text(
            widget.payload.toString(),
            maxLines: 3,
            textAlign: TextAlign.center,
            style:const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ))
        ],
      )),
    );
  }
}

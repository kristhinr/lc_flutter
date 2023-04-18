import 'package:flutter/cupertino.dart';

Widget buildSepLine(context,int len) {
  return Container(
    height: 1,
    width:
    MediaQuery.of(context).size.width - len,
    decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1,
                color:
                Color(0xffe5e5e5)))),
  );
}
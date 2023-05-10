import 'package:flutter/cupertino.dart';
// 未读消息的装饰
Widget buildUnReadCountView(int count) {
  if (count > 0) {
    String showNum = '';
    if (count < 99) {
      showNum = ' ' + count.toString() + ' ';
    } else {showNum = ' 99+ ';
    }

    return DecoratedBox(
        decoration: BoxDecoration(
          gradient:
          LinearGradient(colors: [Color(0xfff44336), Color(0xfff44336)]),
          borderRadius: BorderRadius.circular(16.0), //圆角
        ),
        child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
            child: Text(
              showNum,
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 12.0,
              ),
            )));
  } else {
    return Container(
      height: 0,
    );
  }
}
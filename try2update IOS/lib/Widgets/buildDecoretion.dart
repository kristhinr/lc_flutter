import 'package:flutter/cupertino.dart';

import '../Common/Global.dart';

//构造装饰品的几个选项，群聊使用的和其他类型时使用的不同装饰
String memberCount;

Widget buildDecoretion(String string) {
  //Group

    return DecoratedBox(

        decoration: BoxDecoration(

          gradient:
          //LinearGradient(colors: [Color(0x60f44336), Color(0x60057efe)]),
          LinearGradient(colors: [Color(0x60057efe), Color(0x60057efe)]),
          //渐变效果
          borderRadius: BorderRadius.circular(16.0), //圆角
        ),
        child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
//              child: TextWidget(_keyList[index])));
            child: Text(
              string,
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 12.0,
              ),
            )));
  }

Widget buildBETA() {
  //Group

  return DecoratedBox(

      decoration: BoxDecoration(

        gradient:
        //LinearGradient(colors: [Color(0x60f44336), Color(0x60057efe)]),
        LinearGradient(colors: [Color(0xc0f44336), Color(0xc0f44336)]),
        //渐变效果
        borderRadius: BorderRadius.circular(16.0), //圆角
      ),
      child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
//              child: TextWidget(_keyList[index])));
          child: Text(
            'BETA',
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 7.0,
            ),
          )));
}

Widget buildKnown(bool isGroup,bool bool, String string, count) {
  memberCount = '$count人群组';
  if(isGroup == true){
    return DecoratedBox(

        decoration: BoxDecoration(

          gradient:
          //LinearGradient(colors: [Color(0x60f44336), Color(0x60057efe)]),
          LinearGradient(colors: [Color(0x60057efe), Color(0x60057efe)]),
          //渐变效果
          borderRadius: BorderRadius.circular(16.0), //圆角
        ),
        child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
//              child: TextWidget(_keyList[index])));
            child: Text(
              memberCount,
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 12.0,
              ),
            )));
  }else{
  if(Global.colorDecoration == true){
  //know?
  if(string != Global.clientID){//not me
    if(count == 2){
    if(bool == true){//known
      return DecoratedBox(
          //know
          decoration: BoxDecoration(

            gradient:
            LinearGradient(colors: [Color(0xc050d080), Color(0xc050d080)]),
            //渐变效果
            borderRadius: BorderRadius.circular(25.0), //圆角
          ),
          child: Padding(

              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
    //              child: TextWidget(_keyList[index])));
              child: Text(
                '',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 2,
                ),
              )));}
    else{//unknown
      return DecoratedBox(
      //unknow
      decoration: BoxDecoration(

        gradient:
        LinearGradient(colors: [Color(0xc0f44336), Color(0xc0f44336)]),
        //渐变效果
        borderRadius: BorderRadius.circular(25.0), //圆角
      ),
      child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
  //              child: TextWidget(_keyList[index])));
          child: Text(
            '',
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 2,
            ),
          )));}


    } else{

      if(bool == true){//known
        return DecoratedBox(
          //know
            decoration: BoxDecoration(

              gradient:
              LinearGradient(colors: [Color(0xc050d080), Color(0xc050d080)]),
              //渐变效果
              borderRadius: BorderRadius.circular(16.0), //圆角
            ),
            child: Padding(

                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
                //              child: TextWidget(_keyList[index])));
                child: Text(
                  string,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 12.0,
                  ),
                )));}
      else{//unknown
        return DecoratedBox(
          //unknow
            decoration: BoxDecoration(

              gradient:
              LinearGradient(colors: [Color(0xc0f44336), Color(0xc0f44336)]),
              //渐变效果
              borderRadius: BorderRadius.circular(16.0), //圆角
            ),
            child: Padding(

                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
                //              child: TextWidget(_keyList[index])));
                child: Text(
                  string,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 12.0,
                  ),
                )));}




    }
  }else{//is me
    return DecoratedBox(
      //me

        decoration: BoxDecoration(

          gradient:
          LinearGradient(colors: [Color(0xa7057efe), Color(0xa7057efe)]),
          //渐变效果
          borderRadius: BorderRadius.circular(25.0), //圆角
        ),
        child: Padding(

            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
            //              child: TextWidget(_keyList[index])));
            child: Text(
              '',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 2,
              ),
            )));
  }
}else{return Container();}}

}
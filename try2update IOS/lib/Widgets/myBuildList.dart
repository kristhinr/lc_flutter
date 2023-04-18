import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';

import '../Common/Global.dart';
import '../Models/funcEncrypt.dart';
import '../Routes/ConversationDetailPage.dart';
import 'buildDecoretion.dart';
import 'buildSepLine.dart';
import 'buildUnReadCountView.dart';

// 封装了页面绘制列表的函数，这样管理代码更方便

bool value;
bool isGroup;

String memberCount;

Widget myBuildList(count,isGroup,value,context,index,snapshot,creater,name,unreadCount,lastMessageString,time) {


  if (value==true){
    return Container(
        color: Color(0xffffffff),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        height: 75,
        child: Column(
          children: [
            Container(
              height: 74,
              child: CupertinoListTile(
                onTap: () {
                  Conversation con =
                  snapshot.data[index];
                   {
                    Navigator.push(
                      context,
                      new CupertinoPageRoute(
                        builder: (context) => new ConversationDetailPage(conversation: con),
                      ),
                    );
                  }
                }, //点击
                title: Container(
                  padding: EdgeInsets.only(
                      left: 0, top: 12),
                  child: Row(
                    children: [
                      buildKnown(isGroup,allClients().contains(creater),creater,count),
                      SizedBox(width: 5,),
                      Text(
                        '$name ',
                        style: new TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      buildUnReadCountView(
                          unreadCount),
                    ],
                  ),
                ),
                subtitle: Container(
                  padding: EdgeInsets.only(
                      left: 0, bottom: 12),
                  child: Text(
                    lastMessageString,
                    //文字

                    style: new TextStyle(
                      fontSize: 16,
                      color: Color(0xdd000000),
                    ),
                  ),
                ),
                additionalInfo: Container(
                  padding: EdgeInsets.only(right: 6, bottom: 0),
                  child:Text(
                    time,
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                      fontSize: 14,
                      color: Color(0x8a000000),
                    ),
                  ),
                ),),
            ),

            buildSepLine(context,0),
          ],
        ));
  }else{return Container();}

}


Widget myStarList(context,index,name,text,time) {
    return Container(
        color: Color(0xffffffff),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        height: 75,
        child: Column(
          children: [
            Container(
              height: 74,
              child: CupertinoListTile(

                onTap: () {
                  //showDetail;
                  showDetailDialog(context,text);
                }, //点击
                title: Container(
                  padding: EdgeInsets.only(
                      left: 0, top: 12),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.star_fill,size: 13 ,color: Colors.amberAccent,),

                      Text(
                        '  ',
                        style: new TextStyle(
                          fontSize: 12,

                          // fontWeight:FontWeight.bold,
                        ),
                      ),
                      buildDecoretion(' $name '),

                    ],
                  ),
                ),
                subtitle: Container(
                  padding: EdgeInsets.only(
                      left: 20, bottom: 13),
                  child: Text(


                    funcEncrypt().Decryption(text,),
                    //文字

                    style: new TextStyle(
                      fontSize: 16,
                      color: Color(0xdd000000),
                    ),
                  ),
                ),
                additionalInfo: Container(
                  padding: EdgeInsets.only(right: 6, bottom: 0),
                  child:Text(
                    time,
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                      fontSize: 14,
                      color: Color(0x8a000000),
                    ),
                  ),
                ),),
            ),

      buildSepLine(context,0),

          ],
        ));

}

Future<bool> showDetailDialog(context,String text) async {

  return showCupertinoDialog<bool>(

    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          funcEncrypt().DecryptionMan(text),
          textAlign: TextAlign.center,
        ),


        actions: <Widget>[

          CupertinoDialogAction(
            child: Text("确认"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
        ],
      );
    },
  );
}

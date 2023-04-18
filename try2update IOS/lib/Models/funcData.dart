import 'package:leancloud_official_plugin/leancloud_plugin.dart';

import '../Common/Global.dart';
import 'funcEncrypt.dart';

class funcData {
  Conversation conversation;

  String name;
  String creater;
  String time;
  String lastMessageString = '暂无新消息';
  int count = 0;






  funcData({this.conversation});



  void update(Conversation con){

    name = con.name;

    List<Object> members = con.members;
    print(members.toString());
    print(members.length);//有的，但是没法赋值到外部/
    var mutableList = <Object>[]..addAll(members);
    int count = members.length;
    print(count);
    creater = con.rawData["c"];

    if (con.lastMessage == null) {
      time = getFormatDate(con.updatedAt.toString());
      if (count == 2) {

        mutableList.remove(Global.clientID);
        name = mutableList.join('');

      }
    } else {
      time = getFormatDate(con.lastMessageDate.toString());
      if (count == 2) {
        lastMessageString = funcEncrypt().Decryption(
          getMessageString(con.lastMessage),
        );
        var mutableList = <Object>[]..addAll(members);
        mutableList.remove(Global.clientID);
        name = mutableList.join('');
        //print( members.join('').replaceAll(Global.clientID,''));
      } else {
        if (con.lastMessage.fromClientID == Global.clientID) {
          lastMessageString = funcEncrypt().Decryption(
            getMessageString(con.lastMessage),
          );
        } else {
          lastMessageString = con.lastMessage.fromClientID +
              ': ' +
              funcEncrypt().Decryption(
                getMessageString(con.lastMessage),
              );
        }
      }
    }
    count = members.length;
  }
}
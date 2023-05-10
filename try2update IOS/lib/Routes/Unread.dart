//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Models/CurrentClient.dart';
import '../Models/funcData.dart';
import '../Models/funcEncrypt.dart';
import '../Widgets/buildDecoretion.dart';
import '../Widgets/buildUnReadCountView.dart';
import '../Widgets/myBuildList.dart';
import 'ConversationDetailPage.dart';
import '../Widgets/TextWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/Global.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import '../States/GlobalEvent.dart';
import 'package:flutter/cupertino.dart';

import '../routes/SelectChatMembers.dart';
import 'chatPer.dart';

// 未读聊天，通过conversation发新消息后时间戳进行排列判断是否对某个用户是未读（服务器逻辑）
// 本机程序只需要获取已有的数据结构包含的unread数据进行判断，包含一个未读标记装饰

class Unread extends StatefulWidget {
  @override
  _UnreadState createState() => new _UnreadState();
}

class _UnreadState extends State<Unread> {
  CurrentClient currentClint;

  Map<String, int> unreadCountMap = Map();
  Map<String, int> conversationIDToIndexMap = Map();

  @override
  void initState() {
    super.initState();
    currentClint = CurrentClient();

    //收到新消息
    currentClint.client.onMessage = ({
      Client client,
      Conversation conversation,
      Message message,
    }) {
      if (message != null) {
        receiveNewMessage(message);
        print('收到信息---');
      }
    };
    //
    mess.on(MyEvent.ConversationRefresh, (arg) {
      setState(() {});
    });
    //未读数更新通知
    currentClint.client.onUnreadMessageCountUpdated = ({
      Client client,
      Conversation conversation,
    }) {
      print('onUnreadMessageCountUpdated-----:' +
          conversation.unreadMessageCount.toString());
//      final prefs = await SharedPreferences.getInstance();
      if (conversation.unreadMessageCount != null) {
//        prefs.setInt(conversation.id, conversation.unreadMessageCount);
        unreadCountMap[conversation.id] = conversation.unreadMessageCount;
      } else {
//        prefs.setInt(conversation.id, 0);
        unreadCountMap[conversation.id] = 0;
      }
      setState(() {});
      //TODO 局部刷新
//      int count = unreadCountMap[conversation.id];
//      int index = conversationIDToIndexMap[conversation.id];
//      print(index.toString()+'index--');
//      if (count != null && index != null) {
//        _keyList[index].currentState.onPressed(count);
//      }
    };
  }

  void receiveNewMessage(Message message) {
    //收到新消息刷新页面
//    setState(() {});
  }
//  Future<int> getUnReadMessageCount(String conversationId) async {
//    final prefs = await SharedPreferences.getInstance();
//    int counter = prefs.getInt(conversationId) ?? 0;
//    print('counter:-----:' + counter.toString());
//    return counter;
//  }
//根据ID获取index
  @override
  void dispose() {

    //取消订阅
    mess.off(MyEvent.ConversationRefresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //body: Center(
//        padding: EdgeInsets.all(2.0),
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            border: Border(
              bottom: BorderSide.none,
            ),
            largeTitle: Text('未读消息'),
            trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    new CupertinoPageRoute(
                      builder: (context) => chatPer(),
                    ),
                  );
                }),
          ),
          //SizedBox(height: 10,),
          SliverToBoxAdapter(
            child: Container(
              height: 10.0, // desired empty space height
            ),
          ),
          FutureBuilder<List<Conversation>>(
            future: retrieveData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      Conversation con = snapshot.data[index];
                      final conv = funcData();
                      conv.update(con);
                      //print(conv.name+ conv.creater +conv.lastMessageString);
                      String name = conv.name;
                      String creater = conv.creater;
                      String time = conv.time;
                      String lastMessageString = conv.lastMessageString;
                      int count = con.members.length;
                      int unreadCount = 0;
                      if (unreadCountMap[con.id] != null) {
                        unreadCount = unreadCountMap[con.id];
                      }

                        bool value = (unreadCount != 0);
                      bool isGroup =false;
                      return myBuildList(count,isGroup,value,context,index,snapshot,creater,name,unreadCount,lastMessageString,time) ;

                        },
                    childCount: snapshot.data.length,
                  ),
                );
              }
            },
          ),

        ],
      ),
    );
    //);
  }

  Future<List<Conversation>> retrieveData() async {
    CurrentClient currentClient = CurrentClient();
    List<Conversation> conversations;
    try {
      ConversationQuery query = currentClient.client.conversationQuery();
      //TODO：上拉加载更多
      query.limit = 20;
      query.orderByDescending('updatedAt');
      //让查询结果附带一条最新消息
      query.includeLastMessage = true;
      conversations = await query.find();

      //记录未读消息数
      final prefs = await SharedPreferences.getInstance();
      conversations.forEach((item) {
        if (item.unreadMessageCount != null) {
//        prefs.setInt(conversation.id, conversation.unreadMessageCount);
          unreadCountMap[item.id] = item.unreadMessageCount;
        } else {
//        prefs.setInt(conversation.id, 0);
          unreadCountMap[item.id] = 0;
        }


      });
    } catch (e) {
      print(e);
      showToastRed(e.message);
    }
    return conversations;
  }
}

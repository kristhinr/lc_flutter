
import 'package:Mchat/Models/funcData.dart';
import 'package:Mchat/Models/funcEncrypt.dart';
import 'package:Mchat/Routes/chatPer.dart';
import 'package:flutter/cupertino.dart';
import 'package:leancloud_storage/leancloud.dart';
import '../Models/CurrentClient.dart';
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

// 信息模块收藏功能，类似与Conversation的获取，但是包含内容覆盖不同，
// 选择使用LCObject自己构成一个数据结构，异步从服务端获取信息并绘制
class StarListPage extends StatefulWidget {
  @override
  _StarListPageState createState() => new _StarListPageState();
}

class _StarListPageState extends State<StarListPage> {
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

//根据ID获取index
  @override
  void dispose() {
    super.dispose();
    //取消订阅
    mess.off(MyEvent.ConversationRefresh);
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
            largeTitle: Text('收藏'),
            trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    new CupertinoPageRoute(
                      builder: (context) => chatPer(),
                      //builder: (context) => new SelectChatMembers(),
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
          FutureBuilder<List<LCObject>>(
            future: retrievestared(),
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

                          //https://docs.leancloud.cn/sdk/storage/guide/flutter/

                      LCObject con = snapshot.data[index];

                      String name = con['sender'];
                      //设置点击显示详细内容和修改备注

                      String time = getFormatDate(con.updatedAt.toString());

                      String text = con['content'];



                      return myStarList(context,index,name,text,time) ;

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


  Future<List<LCObject>> retrievestared() async {
    // my stared test!!!

    List<LCObject> stared;
    try {

      LCQuery<LCObject> query = LCQuery('stared');
      query.select('clientID');
      query.select('messageID');
      query.select('updatedAt');
      query.select('content');
      query.select('sender');


      query.whereEqualTo('clientID', Global.clientID);//查找clientID为本人的，stared列。
      //https://docs.leancloud.cn/sdk/storage/guide/flutter/
// students 是包含满足条件的 Student 对象的数组
      //TODO：上拉加载更多
      query.limit(20);
      query.orderByDescending('updatedAt');

      stared = await query.find();

      //String clientID = stared['clientID'] as String;
    } catch (e) {
      print(e);
      showToastRed(e.message);
    }
    return stared;
  }
}

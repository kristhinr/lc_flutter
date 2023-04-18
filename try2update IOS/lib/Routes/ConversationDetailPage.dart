//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Common/Global.dart';
import '../Models/CurrentClient.dart';
import '../States/GlobalEvent.dart';
import '../Widgets/MessageList.dart';
import '../Widgets/InputMessageView.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';

class ConversationDetailPage extends StatefulWidget {
  final Conversation conversation;

  ConversationDetailPage({Key key, @required this.conversation})
      : super(key: key);
  @override
  _ConversationDetailPageState createState() =>
      new _ConversationDetailPageState();
}

class _ConversationDetailPageState extends State<ConversationDetailPage> {
//  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  TextEditingController renameController = TextEditingController();

  Message _firstMessage;
  CurrentClient currentClint;

  @override
  void initState() {
    super.initState();
    currentClint = CurrentClient();
    //进入会话详情页面，标记会话已读
    this.widget.conversation.read();
    print(this.widget.conversation.id);//conv-id
    //print(this.widget.conversation.lastMessage.id);//lastmessage:最新的消息的 msg-id:32位，获取使用一次性


  }

  @override
  void deactivate() async {
    super.deactivate();
//    //刷新列表
//    mess.emit(MyEvent.ConversationRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(
            bottom: BorderSide.none,
          ),
          middle: Container(child: NameView()),
          trailing: Container(child: GOrSView()),


        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: FutureBuilder<List<Message>>(
            future: queryMessages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Container(
                    height: 60.0,
                    child: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      MessageList(
//                          scrollController: _scrollController,
                          conversation: this.widget.conversation,
                          firstPageMessages: snapshot.data,
                          firstMessage: _firstMessage),
                      //读取message
                      InputMessageView(
//                          scrollController: _scrollController,
                          conversation: this.widget.conversation),
                      //输入message
                    ],
                  );
                }
              } else {
                // 请求未结束，显示loading
                return CupertinoActivityIndicator();
              }
            },
          ),
        ));
  }

  void updateConInfo() async {
    if (renameController.text != null && renameController.text != '') {
      await widget.conversation.updateInfo(attributes: {
        'name': renameController.text,
      });
//      setState(() {});

      List conversations;
      ConversationQuery query = currentClint.client.conversationQuery();
      query.whereEqualTo('objectId', widget.conversation.id);

      conversations = await query.find();
      Conversation conversationFirst = conversations.first;
      print('name--->' + conversationFirst.name);
    } else {
      showToastRed('名称不能为空');
    }
  }

  Future<bool> showConfirmDialog() async {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "修改会话名称：",
            style: new TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          content: CupertinoTextField(
            controller: renameController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            CupertinoDialogAction(
              child: Text("确认"),
              onPressed: () {
                updateConInfo();
                //关闭对话框并返回true
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showNameDialog() async {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "聊天成员：",
            style: new TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          content: Text(this.widget.conversation.members.join(", ")),
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

  Widget GOrSView() {
    if (this.widget.conversation.members.length > 2) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.search),
              onPressed: () {
                showNameDialog();
                // Do something when the search button is pressed
              },
            ),
          ),
        ],
      );
    } else {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(CupertinoIcons.line_horizontal_3),
        onPressed: () {},
      );
    }
  }

  Widget NameView() {
    String name = '';

    var mutableList = <Object>[]..addAll(this.widget.conversation.members);

    if (this.widget.conversation.members.length > 2) {
      return CupertinoButton(
        padding: EdgeInsets.all(0),

        onPressed: () {
          showConfirmDialog();
        },
        //color: Color(0xff000000),
        child: Text(
          this.widget.conversation.name,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff000000)),
        ),
      );
    } else {
      mutableList.remove(Global.clientID);
//name = members.join('').replaceAll(Global.clientID,'');
      name = mutableList.join('');

      return CupertinoButton(
        padding: EdgeInsets.all(0),

        onPressed: () {
          //showConfirmDialog();
        },
        //color: Color(0xff000000),
        child: Text(
          name,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff000000)),
        ),
      );
    }
  }

  Future<List<Message>> queryMessages() async {
    List<Message> messages;
    try {
      messages = await this.widget.conversation.queryMessage(
            limit: 10,
          );
      _firstMessage = messages.first;
    } catch (e) {
      print(e.message);
    }
    return messages;
  }
}

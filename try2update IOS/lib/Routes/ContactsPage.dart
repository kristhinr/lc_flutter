//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common/Global.dart';
import '../Models/CurrentClient.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:leancloud_storage/leancloud.dart';
import '../Widgets/buildSepLine.dart';
import 'SelectChatMembers.dart';
import 'ConversationDetailPage.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => new _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> _list = allClients();
  @override
  void initState() {
    super.initState();
    removeCurrentClient();
  }

  removeCurrentClient() {
    _list.remove(Global.clientID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            border: Border(
              bottom: BorderSide.none,
            ),
            largeTitle: Text('联系人'),
            //backgroundColor: Color(0xfff2f2f2),
            trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    new CupertinoPageRoute(
                      builder: (context) => new SelectChatMembers(),
                      //SelectChatMembers为群聊
                    ),
                  );
                }),

            //trailing: Icon(CupertinoIcons.add_circled),
            // This widget fills the remaining space in the viewport.
          ),
          // ..
          SliverToBoxAdapter(
            child: Container(
              height: 10.0, // desired empty space height
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    color: Color(0xffffffff),
                  //alignment: Alignment.centerRight,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    height: 75,
                    child: Column(
                      children: [

                        Container(
                          height: 74,
                          child: CupertinoListTile(
                            onTap: () {
                              showConfirmDialog(_list[index]);
                            },

                            leading: Image.asset(
                              "images/Fig.png",
                            ), //前标签leading，头像图片等
                            leadingSize: 55,
                            title: Container(
                              padding: EdgeInsets.only(left: 0, top: 9),
                              child: LimitedBox(
                                maxHeight: 35,
                                child: Text(
                                  _list[index],
                                  style: new TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            subtitle: Container(
                              padding: EdgeInsets.only(left: 4, bottom: 12),
                              child: LimitedBox(
                                maxHeight: 15,
                                child: Text(
                                  "[ " + _list[index] + " ] : Your friend",
                                  style: new TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        ),
                        buildSepLine(context,0),
                      ],
                    )
                    //child:
                    );
              },
              childCount: _list.length,
            ),
          ),
        ],
      ),
    );
  }

  void addBlackList(String clientID) async {
    if (Global.clientID != null) {
      LCObject blackList = LCObject('BlackList');
      blackList['clientID'] = Global.clientID;
      blackList.addAllUnique('blackedList', [clientID]);
      await blackList.save();
      showToastGreen('加入黑名单成功！');
      _list.remove(clientID);
      setState(() {});

    } else {
      showToastRed('用户未登录');
      return;
    }
  }




//TOOD：charPer相同，可分离
  void createSigConversation(String clientID) async {
    Set<String> createSigCov = new Set();

    createSigCov.add(Global.clientID);
    createSigCov.add(clientID);
    if (Global.clientID != null) {
      Client currentClient = Client(id: Global.clientID);
      try {
        Conversation conversation = await currentClient.createConversation(
            isUnique: true,
            members: createSigCov,
            name: clientID +' '+ Global.clientID);


        // name: '发起群聊'+Global.clientID);

        Navigator.pop(context);
        Navigator.push(
          context,
          new CupertinoPageRoute(
            builder: (context) =>
            new ConversationDetailPage(conversation: conversation),
          ),
        );
      } catch (e) {
        showToastRed('创建会话失败:${e.message}');
      }
    } else {
      showToastRed('用户未登录');
      return;
    }
  }


  Future<bool> showConfirmDialog(String name) async {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("创建对话"),
          content: Text("确认与 $name 聊天？"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            CupertinoDialogAction(
              child: Text("确认"),
              onPressed: () {
                //单独聊天的
                createSigConversation(name);
                //addBlackList(name);
                //关闭对话框并返回true
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

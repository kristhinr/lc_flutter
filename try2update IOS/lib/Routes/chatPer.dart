
import 'package:Mchat/Routes/SelectChatMembers.dart';
import 'package:flutter/cupertino.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import '../Models/CurrentClient.dart';
import '../routes/ConversationDetailPage.dart';

import '../Common/Global.dart';

//实现一个单聊页面，直接输入id可以用于跟非联系人聊天，

class chatPer extends StatefulWidget {
  @override
  _chatPerState createState() => _chatPerState();
}

class _chatPerState extends State<chatPer> {
  String nID;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text(
              '   ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 42,
                fontFamily: 'JetBrainsMono',
              ),
              //textAlign: TextAlign.center,
            ),
            border: Border(
              bottom: BorderSide.none,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: <Widget>[
                  Expanded(flex: 1, child: SizedBox()),
                  buildTitle(),
                  Container(
                    //height: 35,
                    margin: EdgeInsets.all(10),
                    //padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(25.0),
                      //color: Color(0xffe5e5e5),
                    ),
                    child: Row(
                      children: <Widget>[
                        CupertinoButton(
                          //padding: const EdgeInsets.only(left: 20, right: 15),
                            padding:
                            const EdgeInsets.only(bottom: 20, left: 0),
                            onPressed: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                        return  SelectChatMembers();
                                      }));
                            },
                            child: SizedBox(
                                child: Row(
                                  children: const [
                                    Icon(
                                      //CupertinoIcons.chevron_up_circle_fill,size: 40,
                                      CupertinoIcons.person_2_fill,
                                      size: 28,

                                      color: Color(0xff057efe),
                                    ),
                                  ],
                                ))),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 20, right: 10),
                            child: CupertinoTextField(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6),

                              decoration: BoxDecoration(
                                // 文本框装饰
                                color: Color(0xffffffff), // 文本框颜色
                                border: Border.all(
                                    color: Color(0xffe5e5e5),
                                    width: 1), // 输入框边框
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25)), // 输入框圆角设置
                                // boxShadow: [BoxShadow(color: Colors.redAccent, offset: Offset(0, 5))], //装饰阴影
                              ),
                              controller: textEditingController,
                              placeholder: ' Name.',
                              //onSubmitted: _handleSubmitted,
                              // autofocus: true,
                              onSubmitted: (value) {
                                setState(() {
                                  nID = value;
                                });
                              },
                            ),
                          ),
                        ),
                        CupertinoButton(
                          //padding: const EdgeInsets.only(left: 20, right: 15),
                            padding:
                            const EdgeInsets.only(bottom: 20, right: 8),
                            //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            //alignment: FractionalOffset.center,
                            // onPressed: () =>
                            //     _handleSubmitted(textEditingController.text),
                            onPressed: () {
                              // else if (_clientID = null) {
                              //   showToastRed('未成功输入用户信息');}

                              setState(() {
                                nID = textEditingController.text;
                              });
                              showConfirmDialog(nID);
                            },
                            child: SizedBox(
                                child: Row(
                                  children: const [
                                    Icon(
                                      //CupertinoIcons.chevron_up_circle_fill,size: 40,
                                      CupertinoIcons.paperplane_fill,
                                      //CupertinoIcons.color_filter,

                                      color: Color(0xff057efe),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  Expanded(flex: 6, child: SizedBox()),

                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Container buildTitle() {
    return Container(
//width: 300,

        padding: EdgeInsets.all(60.0),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'Per Aspera',
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 32,
                            //letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            //color: Colors.grey[300],
                            color: Color(0xffa5a5a5),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Per Aspera',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'JetBrainsMono',
                            //letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Color(0xffc0c0c0).withOpacity(0.1),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        // Solid text as fill.
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'Ad Astra',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'JetBrainsMono',
                            //letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            //color: Colors.grey[300],
                            color: Color(0xffa5a5a5),
                          ),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          'Ad Astra',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'JetBrainsMono',
                            //letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Color(0xffc0c0c0).withOpacity(0.1),
                          ),
                          textAlign: TextAlign.end,
                        ),
                        // Solid text as fill.
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 60,),
          ],
        ));
  }


//TOOD：与Contact文件重复，可分离
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

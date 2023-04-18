//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common/Global.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import '../Widgets/buildSepLine.dart';
import 'ConversationDetailPage.dart';

class SelectChatMembers extends StatefulWidget {
  @override
  _SelectChatMembersState createState() => new _SelectChatMembersState();
}

class _SelectChatMembersState extends State<SelectChatMembers> {
  List<String> _list = allClients();
  Map<String, bool> _checkboxSelectedList = new Map();
  Set<String> _selectedClientList = new Set();

  @override
  void initState() {
    super.initState();
    removeCurrentClient();
  }
  removeCurrentClient() {
    _list.remove(Global.clientID);
    _list.forEach((item) {
      //index:_list.indexOf(item)
      _checkboxSelectedList[item] = false;
    });
//    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
        border: Border(
        bottom: BorderSide.none),
        middle: Text(
        "选择联系人"),

            //导航栏

            //导航栏右侧菜单
            trailing:
            CupertinoButton(
              //textColor: Colors.white,
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.checkmark_alt_circle),


                onPressed: () {
                  createConversation();
                }),),

        child: Container(
            decoration: new BoxDecoration(
              //color: Color(0xffe5e5e5),
                color: Color(0xfff5f5f5),
              //border: new Border.all(width: 2.0, color: Color(0xffff0000)),
              ),

            child: Column(children: <Widget>[
          Expanded(
            child:Material(
            child: ListView.separated(

                //添加分割线
                separatorBuilder: (BuildContext context, int index) {
                  return buildSepLine(context,70);
                },
                itemCount: _list.length,
//            itemExtent: 50.0, //强制高度为50.0
                itemBuilder: (BuildContext context, int index) {

                  return CheckboxListTile(

                    onChanged: (isCheck) {
                      setState(() {
                        _checkboxSelectedList[_list[index]] = isCheck;
                      });
                    },
                    selected: false,
                    value: _checkboxSelectedList[_list[index]],
                    title: Text(_list[index]),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }),
          ),),
        ])));
  }


  void createConversation() async {
    _checkboxSelectedList.forEach((key, value) {
      if (value == true) {
        _selectedClientList.add(key);
      }
    });
    if (_selectedClientList.length == 0) {
      showToastRed('请选择成员！');
      return;
    }

    if (Global.clientID != null) {
      Client currentClient = Client(id: Global.clientID);
      try {
        Conversation conversation = await currentClient.createConversation(
            isUnique: true,
            members: _selectedClientList,


            //name: 'Chat with ' + _selectedClientList.toString().replaceFirst('{','').replaceRange(_selectedClientList.toString().length-1,_selectedClientList.toString().length,'').replaceAll(',', '').trimRight().replaceAll(' ', ' & ') );
            name: Global.clientID+'&' + _selectedClientList.join('&') );
        print("list:"+_selectedClientList.toString() +"; length:"+ _selectedClientList.toString().length.toString());


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
}

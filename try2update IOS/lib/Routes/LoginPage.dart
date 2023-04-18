//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Models/CurrentClient.dart';
import 'UserProtocol.dart';
import '../Common/Global.dart';
//import 'HomeBottomBar.dart';
import 'Navigation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _clientID;
  bool _checkboxSelected = true;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (Global.clientID != null) {
      _clientID = Global.clientID;
      setState(() {});
    }
  }

  Future userLogin(String clientID) async {
    CommonUtil.showLoadingDialog(context); //发起请求前弹出loading
    Global.saveClientID(clientID);

    login(clientID).then((value) {
      Navigator.pop(context); //销毁 loading
      Navigator.pushAndRemoveUntil(
          context,
          new CupertinoPageRoute(builder: (context) => Navigation()),
          (_) => false);
    }).catchError((error) {
      showToastRed(error.message);
      Navigator.pop(context); //销毁 loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text(
              ' MChat ',
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, bottom: 20, right: 10),
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
                              placeholder: 'Your Name.',
                              //onSubmitted: _handleSubmitted,
                              // autofocus: true,
                              onSubmitted: (value) {
                                setState(() {
                                  this._clientID = value;
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
                              if (!_checkboxSelected) {
                                showToastRed('未同意用户使用协议');
                              }
                              // else if (_clientID = null) {
                              //   showToastRed('未成功输入用户信息');}
                              else {
                                setState(() {
                                  this._clientID = textEditingController.text;
                                });
                                userLogin(_clientID);
                              }
                            },
                            child: SizedBox(
                                child: Row(
                              children: const [
                                Icon(
                                  //CupertinoIcons.chevron_up_circle_fill,size: 40,
                                  CupertinoIcons.paperplane_fill,

                                  color: Color(0xff057efe),
                                ),
                              ],
                            ))),
                      ],
                    ),
                  ),
                  Expanded(flex: 6, child: SizedBox()),
                  buildCheckBox(context),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildCheckBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.scale(
            scale: 0.5,
            child: CupertinoSwitch(
              value: _checkboxSelected,
              activeColor: Color(0xff2196F3).withOpacity(0.6), //选中时的颜色
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value;
                });
              },
            ),
          ),
          GestureDetector(
            child: Text(
              '我已阅读并同意使用协议',
              style: TextStyle(
                color: Color(0xff2196F3).withOpacity(0.8),
                decoration: TextDecoration.underline,
                fontSize: 15.0,
              ),
            ),
            onTap: () => showUserProtocolPage(), //点击
          )
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

  showUserProtocolPage() {
    Navigator.push(
      context,
      new CupertinoPageRoute(
        builder: (context) => new UserProtocolPage(),
      ),
    );
  }

  Future login(String clintID) async {
    CurrentClient currentClint = CurrentClient();
    if (clintID != currentClint.client.id) {
      currentClint.updateClient();
    }
    await currentClint.client.open();
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Common/Global.dart';
import '../Models/CurrentClient.dart';
import '../Widgets/buildDecoretion.dart';
import '../Widgets/buildSepLine.dart';
import 'LoginPage.dart';
import 'Subscription.dart';
import 'Settings.dart';
import 'info.dart';

// import '../model/DataTrans.dart';
import 'ME.dart';

// 充当设置页面,settings 应为其他选项卡
// 二级导航页面，已经重绘
// 包含个人简介，设置模块，关于
class Nav2 extends StatefulWidget {
  @override
  _Nav2State createState() => _Nav2State();
  }
  // final TransferDataEntity data;
class _Nav2State extends State<Nav2> {
  //bool _encryptionValue;


  @override
  void initState() {
    super.initState();

    // _encryptionValue = Global.encryptionValue;
    //   setState(() {});

  }


  Future clientClose() async {
    CommonUtil.showLoadingDialog(context); //发起请求前弹出loading

    close().then((value) {
      Navigator.pop(context); //销毁 loading
      Navigator.pushAndRemoveUntil(
          context,
          new CupertinoPageRoute(builder: (context) => LoginPage()),
              (_) => false);
    }).catchError((error) {
      showToastRed(error.message);
      Navigator.pop(context); //销毁 loading
    });
  }

  Future close() async {
    if (Global.clientID != null) {
      CurrentClient currentClint = CurrentClient();
      await currentClint.client.close();
      Global.removeClientID();
    } else {
      showToastRed('有 BUG，重启一下试试。。。');
    }
  }

  Future<bool> showConfirmDialog() async {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("提示"),
          content: Text("确认退出登录"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            CupertinoDialogAction(
              child: Text("确认"),
              onPressed: () {
                //Client close；
                //关闭对话框并返回true
                clientClose();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('设置'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
                child:
                Icon(CupertinoIcons.eject),
                onPressed: () {
                  showConfirmDialog();
                }


    ),
            border: Border(
              bottom: BorderSide.none,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,

                  children: <Widget>[

                    CupertinoListSection.insetGrouped(
                      children: [
                        Container(
height: 100,
                          child: CupertinoListTile.notched(
                            title: Container(

                              padding: EdgeInsets.only(top: 31),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:  [

                                  Text(
                                    " ${Global.clientID}",
                                    style: TextStyle(
                                        fontSize: 32.0,
                                        letterSpacing: 0,

                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 4),

                                ],
                              ),
                            ),
                            leading: Image.asset(
                              "images/Fig.png",

                            ),
                            leadingSize: 80,

                          ),
                        ),
                        Container(
                          height: 43,
                          child: CupertinoListTile.notched(
                            title: Container(
                              padding: EdgeInsets.only(top: 11),
                              child: Text(
                                '个人资料  ',
                                style: TextStyle(
                                  fontSize: 16.0,

                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading:
                            Icon(CupertinoIcons.square_favorites_alt),
                            trailing: const CupertinoListTileChevron(),
                            onTap: ()  {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                        return ME();
                                      }));
                            },
                          ),
                        ),

                      ],
                    ),
                    // 顶部10px

                    const SizedBox(height: 20),

                    CupertinoListSection.insetGrouped(
                      children: [
                        Container(
                          height: 43,
                          child: CupertinoListTile.notched(
                            title: Container(
                              padding: EdgeInsets.only(top: 11),
                              child: Row(
                                children: [
                                  Text(
                                    '订阅  ',
                                    style: TextStyle(
                                      fontSize: 16.0,

                                      //fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  buildBETA(),
                                ],
                              ),
                            ),
                            leading: Icon(
                              CupertinoIcons.briefcase,

                            ),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                        return  Subscription();
                                      }));
                            },
                          ),
                        ),
                        Container(
                          height: 43,
                          child: CupertinoListTile.notched(
                            title: Container(
                              padding: EdgeInsets.only(top: 11),
                              child: Text(
                                '选项  ',
                                style: TextStyle(
                                  fontSize: 16.0,

                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading:
                            Icon(CupertinoIcons.list_bullet_indent),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                        return  Settings();
                                      }));
                            },
                          ),
                        ),
                        Container(
                          height: 43,
                          child: CupertinoListTile.notched(
                            title: Container(
                              padding: EdgeInsets.only(top: 11),
                              child: Text(
                                '加密保护  ',
                                style: TextStyle(
                                  fontSize: 16.0,

                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading: Icon(CupertinoIcons
                                .cube_box),
                            trailing:  CupertinoSwitch(
                              value: Global.encryptionValue,
                              activeColor: CupertinoColors.activeBlue,
                              onChanged: (value) {
                                setState(() {
                                  Global.encryptionValue = value ?? false;

                                });
                                if (Global.decryptionValue == false) {
                                  if(Global.encryptionValue == true){
                                    showToastRed('当前未开启显示解密');};}
                                //showToastRed('当前无法关闭加密保护！');
                              },
                            ),

                          ),
                        ),

                      ],
                    ),



                    // const SizedBox(height: 80),

                    const SizedBox(height: 20),

                    CupertinoListSection.insetGrouped(
                      children: [
                        Container(
                          height: 43,
                          child: CupertinoListTile.notched(
                            title: Container(
                              padding: EdgeInsets.only(top: 11),
                              child: Row(
                                children: [
                                  Text(
                                    '关于程序  ',
                                    style: TextStyle(
                                      fontSize: 16.0,

                                      //fontWeight: FontWeight.w600
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            leading: Icon(
                              CupertinoIcons.info,

                            ),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                        return info();
                                      }));
                            },
                          ),
                        ),


                      ],
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

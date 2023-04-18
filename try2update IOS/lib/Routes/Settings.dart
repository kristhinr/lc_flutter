import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Common/Global.dart';
import '../Widgets/buildSepLine.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}


// 2级导航里面的设置页面，包含两个全局变量的switch修改，装饰品和选择是否显示解密后的文本（本地解密，实现端对端）

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('设置'),
            //backgroundColor: Color(0xfff2f2f2),
            border: Border(
              bottom: BorderSide.none,
            ),
            //trailing: Icon(CupertinoIcons.add_circled),
          ),
          // This widget fills the remaining space in the viewport.
          // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
          SliverFillRemaining(
            child: Container(
              //color: Color(0xffe5e5e5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  CupertinoListSection.insetGrouped(
                    children: [

                      Container(
                        height: 43,
                        child: CupertinoListTile.notched(
                          title: Container(
                            padding: EdgeInsets.only(top: 11),
                            child: Text(
                              '彩色装饰品  ',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                //fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          leading: Icon(CupertinoIcons
                              .eyedropper_halffull, color: Color(0xfff0a0a0),),
                          trailing:  CupertinoSwitch(
                            value: Global.colorDecoration,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                Global.colorDecoration = value ?? false;
                              });
                            },
                          ),

                        ),
                      ),
                      Container(
                        height: 43,
                        child: CupertinoListTile.notched(
                          title: Container(
                            padding: EdgeInsets.only(top: 11),
                            child: Text(
                              '显示解密后的文本  ',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                //fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          leading: Icon(CupertinoIcons
                              .captions_bubble),
                          trailing:  CupertinoSwitch(
                            value: Global.decryptionValue,
                            activeColor: CupertinoColors.activeBlue,
                            onChanged: (value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                Global.decryptionValue = value ?? false;

                              });
                              if (Global.decryptionValue == true) {
                                if(Global.encryptionValue == false){
                                  showToastRed('当前未开启安全加密');};}
                            },
                          ),

                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

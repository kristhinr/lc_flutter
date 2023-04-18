//import 'dart:ui';

import 'package:Mchat/Routes/StarList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/buildDecoretion.dart';
import '../Widgets/buildSepLine.dart';
import 'ConversationListPage.dart';
import 'ContactsPage.dart';

import 'Group.dart';
import 'Linked.dart';

import 'Unlinked.dart';
import 'Unread.dart';

import 'Nav2.dart';

class Navigation extends StatelessWidget {
  // get data => TransferDataEntity;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('信息'),
            border: Border(
              bottom: BorderSide.none,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    // 讯息

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
                                    '已收藏  ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  buildBETA(),
                                ],
                              ),
                            ),
                            leading: Icon(
                              CupertinoIcons.star_lefthalf_fill,
                              color: Colors.amberAccent,
                            ),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                //return  Stared();
                                return StarListPage();
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
                                '所有信息  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading:
                                Icon(CupertinoIcons.bubble_left_bubble_right),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                return ConversationListPage();
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
                                '已知联系人  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading: Icon(CupertinoIcons
                                .person_crop_circle_badge_checkmark),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                return Linked();
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
                                '未知联系人  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading: Icon(
                                CupertinoIcons.person_crop_circle_badge_exclam),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                return Unlinked();
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
                                '未处理  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading: Icon(CupertinoIcons.envelope_badge),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                return Unread();
                              }));
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    CupertinoListSection.insetGrouped(
                      children: [
                        Container(
                          height: 43,
                          child: CupertinoListTile.notched(
                            title: Container(
                              padding: EdgeInsets.only(top: 11),
                              child: Text(
                                '联系人  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading: Icon(
                              CupertinoIcons.person_crop_square,
                            ),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                return ContactsPage();
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
                                '群组  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading: Icon(
                              CupertinoIcons.person_2,
                            ),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                return Group();
                              }));
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    CupertinoListSection.insetGrouped(
                      children: [
                        Container(
                          height: 43,
                          child: CupertinoListTile.notched(
                            title: Container(
                              padding: EdgeInsets.only(top: 11),
                              child: Text(
                                '设置  ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            leading: Icon(
                              CupertinoIcons.settings,
                            ),
                            trailing: const CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute<Widget>(
                                      builder: (BuildContext context) {
                                return Nav2();
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

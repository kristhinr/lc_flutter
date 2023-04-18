

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'ConversationListPage.dart';
import 'Unread.dart';

// 订阅页面，目前充当测试

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color(0xff191970),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color(0xff007ba7),
};

Sky _selectedSegment = Sky.midnight;

  class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => new _SubscriptionState();
  }

  class _SubscriptionState extends State<Subscription> {



  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('订阅'),
            //backgroundColor: Color(0xfff2f2f2),
            border: Border(
              bottom: BorderSide.none,),
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

                  const SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      //设置四周边框
                      // border: new Border.all(width: 0,),
                    ),
                    child:CupertinoSlidingSegmentedControl<Sky>(
                      groupValue: _selectedSegment,
                      // Callback that sets the selected segmented control.
                      onValueChanged: (Sky value) {
                        if (value != null) {
                          setState(() {
                            _selectedSegment = value;
                          });
                        }
                      },
                      children: const <Sky, Widget>{
                        Sky.midnight: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),

                          child: Text(
                            'Midnight',

                          ),
                        ),
                        Sky.viridian: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Viridian',

                          ),
                        ),
                        Sky.cerulean: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Cerulean',

                          ),
                        ),
                      },
                    ),
                  ),

                  SizedBox(height: 40),
                  CupertinoListSection.insetGrouped(

                    children: [
                      Container(
                       height:43,
                        child:
                        CupertinoListTile.notched(

                          title: Container(
                            padding: EdgeInsets.only(top: 11),
                            child:Text('已收藏  '),),
                          leading: Icon(CupertinoIcons.star_lefthalf_fill,color: Colors.amberAccent,),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute<Widget>(
                                    builder: (BuildContext context) {
                                      return  ConversationListPage();
                                    }));
                          },
                        ),
                      ),
                      Container(
                        height:43,
                        child:
                        CupertinoListTile.notched(

                          title: Container(
                            padding: EdgeInsets.only(top: 11),
                            child:Text('所有信息  '),),
                          leading: Icon(CupertinoIcons.bubble_left_bubble_right),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute<Widget>(
                                    builder: (BuildContext context) {
                                      return  ConversationListPage();
                                    }));
                          },
                        ),
                      ),
                      Container(
                        height:43,
                        child:
                        CupertinoListTile.notched(

                          title: Container(
                            padding: EdgeInsets.only(top: 11),
                            child:Text('已知联系人  '),),
                          leading: Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute<Widget>(
                                    builder: (BuildContext context) {
                                      return  ConversationListPage();
                                    }));
                          },
                        ),
                      ),
                      Container(
                        height:43,
                        child:
                        CupertinoListTile.notched(

                          title: Container(
                            padding: EdgeInsets.only(top: 11),
                            child:Text('未知联系人  '),),
                          leading: Icon(CupertinoIcons.person_crop_circle_badge_exclam),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute<Widget>(
                                    builder: (BuildContext context) {
                                      return  ConversationListPage();
                                    }));
                          },
                        ),
                      ),
                      Container(
                        height:43,
                        child:
                        CupertinoListTile.notched(

                          title: Container(
                            padding: EdgeInsets.only(top: 11),
                            child:Text('未处理  '),),
                          leading: Icon(CupertinoIcons.envelope_badge),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                        Navigator.push(context,
                        CupertinoPageRoute<Widget>(
                        builder: (BuildContext context) {
                        return  Unread();
                        }));
                        },
                        ),
                      ),

                    ],
                  ),

                ],
              ),),
          ),
        ],
      ),
    );
  }
}

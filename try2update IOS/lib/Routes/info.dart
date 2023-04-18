import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Common/Global.dart';

class info extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('关于'),
            //backgroundColor: Color(0xfff2f2f2),
            border: Border(
              bottom: BorderSide.none,
            ),
            //trailing: Icon(CupertinoIcons.add_circled),
          ),
          // This widget fills the remaining space in the viewport.
          // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              //color: Color(0xfff2f2f2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,

                children: <Widget>[
                  const SizedBox(height: 10),
                  //const SizedBox(height: 10),

                  Container(
                    alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      //height: 280,
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 5),

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        //设置四周边框
                      ),
                      child: Column(


                        children: [
                          CupertinoListTile(

                            leading: Image.asset(
                      "images/MessageRC.png",

                      ) ,
                              leadingSize:70,


                              title:
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                child:Text('MChat',style: TextStyle(
                            //fontFamily: 'JetBrainsMono',
                              fontSize: 44.0,
                              letterSpacing: 0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),),),
                              subtitle:
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child:Text(
                                '基于flutter的端对端加密聊天程序',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  letterSpacing: 0,
                                  color: Colors.black54,
                                ),),
                              ),



                          ),
                          //const Expanded(child: SizedBox()),

                          const SizedBox(height: 19),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 17),
                           child:
                            Text(
                            '在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。',
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              //:,
                              fontSize: 15.0,
                              letterSpacing: 0,
                              color: Colors.black87,
                              // fontWeight: FontWeight.w600
                            ),
                          ),),
                          //const Expanded(child: SizedBox()),
                        ],
                      )),

                  const SizedBox(height: 40),
                  //const SizedBox(height: 10),


                  Container(
                    alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 100,
                      //padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: Color(0xfffadada),
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        //设置四周边框
                      ),
                      child:

                                  CupertinoButton(
                                      //padding:
                                      //const EdgeInsets.only(left: 20, right: 15),
                                      //padding: EdgeInsets.symmetric(horizontal: 20),
                                      //alignment: FractionalOffset.center,
                                      onPressed: () {
                                        showToastMyDec('Thanks!');
                                      },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[Container(
                                        child: Text(
                                          '☕️ Some Coffee 🎉',
                                          style: TextStyle(
                                              fontSize: 28.0,
                                              letterSpacing: 0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ), Container(child: Text(
              '🥳🥳 !!感谢!! 🥳🥳',
              style: TextStyle(
                fontSize: 14.0,
                letterSpacing: 0,
                color: Colors.black,
              ),
            ),),
              ],



                                    ),),

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

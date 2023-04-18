import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Common/Global.dart';
// import '../model/DataTrans.dart';

// 个人信息，包含名称，头像，一个包含信息的二维码，（目前没有意义）

class ME extends StatefulWidget {
@override
_MEState createState() => _MEState();
}
// final TransferDataEntity data;
class _MEState extends State<ME> {

@override
void initState() {
super.initState();
}


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('个人资料'),

            //backgroundColor: Color(0xfff2f2f2),
            trailing: Icon(CupertinoIcons.barcode_viewfinder),
            border: Border(
              bottom: BorderSide.none,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              //color: Color(0xfff2f2f2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  const SizedBox(height: 10),

                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 140,
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        //设置四周边框
                      ),
                      child: Column(
                        children: [
                          const Expanded(child: SizedBox()),
                          Row(
                            children: [
                              Image.asset(
                                "images/Fig.png",
                                // 头像
                                // 只保存本地就可以
                                width: 100.0,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${Global.clientID}',
                                    //data.name
                                    style: TextStyle(
                                      fontSize: 42.0,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 0),
                                  // Text(
                                  //   '59976040-a675-11ec-8ee4-1f922f66b681',
                                  //   // 可以转2进制再转base64 （节省 省8位）
                                  //   //data.uuid
                                  //   style: TextStyle(
                                  //     fontSize: 11.0,
                                  //     letterSpacing: 0,
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      )),

                  const SizedBox(height: 40),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 360,
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        //设置四周边框
                      ),
                      child: Column(
                        children: [
                          const Expanded(child: SizedBox()),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(child: SizedBox()),
                              Column(
                                children: [
                                  QrImage(// 二维码通过name和uuid生成
                                      data: 'source:MChat,'
                                          'name:${Global.clientID},'
                                          'uuid:59976040-a675-11ec-8ee4-1f922f66b681',
                                      size: 280),
                                  // QrImage(data:
                                  // 'name:Kristhinr,'
                                  //     'uuid:59976040-a675-11ec-8ee4-1f922f66b681',size: 280,embeddedImage: AssetImage(
                                  //     "images/Message.png"
                                  //     ),),
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

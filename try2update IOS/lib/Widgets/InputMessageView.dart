import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../Common/Global.dart';
import '../States/GlobalEvent.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:leancloud_storage/leancloud.dart';
//import 'package:flutter_plugin_record/flutter_plugin_record.dart';
//import 'package:flutter_plugin_record/index.dart';
import 'package:flutter/cupertino.dart';
import '../Models/funcEncrypt.dart';

// 输入消息的页面，
class InputMessageView extends StatefulWidget {
  final Conversation conversation;
  InputMessageView({Key key, @required this.conversation}) : super(key: key);
  @override
  _InputMessageViewState createState() => new _InputMessageViewState();
}

class _InputMessageViewState extends State<InputMessageView> {
  TextEditingController _messController = new TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  FocusNode myFocusNode;
  bool _isShowImageGridView = false;
  String message_encode;
  List _icons = [
    {'name': '照片', 'icon': CupertinoIcons.photo_on_rectangle},
    {'name': '拍摄', 'icon': CupertinoIcons.photo_camera},
    //可以继续添加更多 icons
  ];

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    mess.on(MyEvent.ScrollviewDidScroll, (arg) {
      myFocusNode.unfocus(); // 失去焦点
    });
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        setState(() {
          _isShowImageGridView = false;
        });
        //当有焦点的时候保持focus
      }
    });
 
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
    //取消订阅
    mess.off(
      MyEvent.ScrollviewDidScroll,
    );
    mess.off(
      MyEvent.PlayAudioMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10,left: 0,right: 15),
      padding: EdgeInsets.only(left: 0),
      child: Column(children: <Widget>[
        Container(

          child: buildTextField(),
          decoration: BoxDecoration(color: Color(0x00999900),
            ),
        ),
        buildImageGridView()
      ]),
    );
  }

  Widget buildImageGridView() {
    if (_isShowImageGridView) {
      return Container(
        decoration: BoxDecoration(color: CupertinoColors.systemGroupedBackground),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            scrollDirection: Axis.vertical,
            itemCount: _icons.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildIconButton(
                  _icons[index]['name'], _icons[index]['icon']);
            }),
        height: 200,
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _buildIconButton(String name, IconData icon) {
    return Column(
      children: <Widget>[
        GestureDetector(
          excludeFromSemantics: true,
          onTap: () {
            if (name == '照片') {
              _onImageButtonPressed(ImageSource.gallery, context: context);
            } else if (name == '拍摄') {
              _onImageButtonPressed(ImageSource.camera, context: context);
            }
          },
          child: Container(
            width: 60.0,
            height: 60.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xffffffff), borderRadius: BorderRadius.circular(10.0)),
            child: Icon(
              icon,
              size: 28.0,
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 3.0),
            child: Text(name,
                style: TextStyle(fontSize: 12.0, color: Color(0xff606060))))
      ],
    );
  }

  Widget buildTextField() {
    return Container(
      
      //alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          CupertinoButton(
            onPressed: showImageGirdView,
            child: SizedBox(
              width: 45,
              height: 32,
              child: Container(
                margin:EdgeInsets.only(left: 0),


                decoration: new BoxDecoration(
                  color: Color(0xff057efe).withOpacity(0.8),


                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(CupertinoIcons.add,size: 22.0,color: Color(0xffffffff),)

                  ],),



              ),),



            //                  color: Colors.grey,
          ),
          Container(child: textView()),

        ],
      ),
    );
  }

  Widget textView() {

      return Flexible(
        child: Container(
          height: 34,
          margin: const EdgeInsets.only(top: 2, bottom: 2),
          child: CupertinoTextField(
    decoration: BoxDecoration(
    // 文本框装饰
    color: Color(0xffffffff), // 文本框颜色
    border: Border.all(
    color: Color(0xffe5e5e5), width: 1), // 输入框边框
    borderRadius:
    BorderRadius.all(Radius.circular(25)),),
            textInputAction: TextInputAction.send,
            controller: _messController,
            focusNode: myFocusNode,
            onEditingComplete: () {
              sendTextMessage();
            },
          ),
        ),
      );
    }
    
  // 点击加号
  void showImageGirdView() {
    // 监听焦点变化，获得焦点时focusNode.hasFocus 值为true，失去焦点时为false。
    if (myFocusNode.hasFocus) {
      myFocusNode.unfocus();
    }
    setState(() {
      _isShowImageGridView = !_isShowImageGridView;
      //      _isShowVoice = false;
    });
  }
  
  void sendTextMessage() async {
    //TODO: 此处是输入信息的设置
    if (_messController.text != null && _messController.text != '') {
      try {
        TextMessage textMessage = TextMessage();
        print(this.widget.conversation.id);//24bit,可以在输入前获取，这是个固定值，
        message_encode = funcEncrypt().Encryption(_messController.text);
        //TODO : 编写时，funct()加括号，获取Encryption为静态变量

        textMessage.text =  message_encode;
        //print(">>> Global.encryptionValue:"+Global.encryptionValue.toString());

        //textMessage.text = _messController.text;
        //可以对 _messController.text （读取的文本信息进行加密后发送，）
        // 此处获取从聊天框输入的文本类信息；获取
        await this.widget.conversation.send(message: textMessage);

//        showToastGreen('发送成功');
        mess.emit(MyEvent.NewMessage, textMessage);
        _messController.clear();
        myFocusNode.unfocus();
      } catch (e) {
        showToastRed(e.toString());
        print(e.toString());
      }
    } else {
      showToastRed('未输入消息内容');
      return;
    }
  }

  //发送图片消息
  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    final _imageFile = await _imagePicker.getImage(
      source: source,
      maxWidth: MediaQuery.of(context).size.width * 0.4,
      maxHeight: MediaQuery.of(context).size.width * 0.6,
      imageQuality: 70,
    );
    Image image = Image.file(File(_imageFile.path));
//     预先获取图片信息
    double imageHeight = 250;
    image.image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo info, bool _) {
      //图片的宽高 info.image.height
      print('image.height:---->' + info.image.height.toString());
      print('image.width:---->' + info.image.width.toString());
      imageHeight = info.image.height.toDouble();
    }));
    Uint8List bytes = await _imageFile.readAsBytes();
    LCFile file = LCFile.fromBytes('imageMessage.png', bytes);

    await file.save(onProgress: (int count, int total) {
      print('$count/$total');
      if (count == total) {
        //发消息
        sendImageMessage(file.data, imageHeight);
      }
    });
  }

  void sendImageMessage(Uint8List binaryData, double imageHeight) async {
    //上传完成
    try {
      ImageMessage imageMessage = ImageMessage.from(binaryData: binaryData);
      await this.widget.conversation.send(message: imageMessage);
//      showToastGreen('发送成功 url:' + imageMessage.url);
      //预先显示图片要知道高度
      mess.emit(MyEvent.ImageMessageHeight, imageHeight);

//      print('发送成功 url:' + imageMessage.url);
      mess.emit(MyEvent.NewMessage, imageMessage);
      setState(() {
        _messController.clear();
        myFocusNode.unfocus();
        _isShowImageGridView = false;
      });
    } catch (e) {
      showToastRed(e.toString());
      print(e.toString());
    }
  }


}

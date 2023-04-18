import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../Models/CurrentClient.dart';
import '../Common/Global.dart';
import '../Models/funcEncrypt.dart';
import '../States/GlobalEvent.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:cached_network_image/cached_network_image.dart';

// 消息内容页的信息，左右区别，从Conversation接收全部信息，可以从rawdata看到信息，

class MessageList extends StatefulWidget {
  final Conversation conversation;
  final List<Message> firstPageMessages;
  final Message firstMessage;

  MessageList(
      {Key key,
      @required this.conversation,
      this.firstPageMessages,
      this.firstMessage})
      : super(key: key);
  @override
  _MessageListState createState() => new _MessageListState();
}

class _MessageListState extends State<MessageList> {
  double _textMessageMaxWidth = 200;
  double _imageMessageHeight = 250;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  AutoScrollController _autoScrollController;

  List<Message> _showMessageList = List<Message>();
  bool _isMessagePositionLeft = false;
  CurrentClient currentClint;
  bool isImageMessageSendBySelf = false;

  //翻页位置的第一条消息
  Message _oldMessage = Message();
  //翻页最后一页长度小于 10 特殊处理
  int _lastPageLength = 0;
  bool _isNeedScrollToNewPage = false;

  //FlutterPluginRecord recordPlugin;

  @override
  void initState() {
    super.initState();

    _oldMessage = widget.firstMessage;
    if (widget.firstPageMessages != null) {
      _showMessageList = widget.firstPageMessages;
    }

    _autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    //第一次进来滚到底
    if (_showMessageList.length >= 10) {
      _scrollToIndex(10);
    } else {
      _scrollToIndex(_showMessageList.length);
    }

    //监听滚动
    _autoScrollController.addListener(() {
      //通知收起键盘
      mess.emit(MyEvent.ScrollviewDidScroll);
    });

    //监听自己发送了新消息
    mess.on(MyEvent.NewMessage, (message) {
      if (message != null) {
        receiveNewMessage(message);
      }
    });
    //收到新消息
    currentClint = CurrentClient();
    currentClint.client.onMessage = ({
      Client client,
      Conversation conversation,
      Message message,
    }) {
      if (message != null) {
        //用户正在某个对话页面聊天，并在这个对话中收到了消息时，需要将会话标记为已读
        if (conversation.id == widget.conversation.id) {
          conversation.read();
          receiveNewMessage(message);
        }
      }
    };
    mess.on(MyEvent.ImageMessageHeight, (height) {
      _imageMessageHeight = height;
    });

  }



  void receiveNewMessage(Message message) {
    if (message is TextMessage) {
      //message.stringContent = message.stringContent + '?receive.?decode';
      //字符串 解密？ 是否能成功显示？
      //message = message + '111';
      double height = calculateTextHeight(getMessageString(message), 14.0,
              FontWeight.bold, _textMessageMaxWidth - 16, 100) +
          16 +
          30;
      setState(() {
        _showMessageList.add(message);
        _autoScrollController
            .jumpTo(_autoScrollController.position.maxScrollExtent + height);
      });
    }
    if (message is ImageMessage) {
      setState(() {
        _showMessageList.add(message);
        _autoScrollController.animateTo(
            _autoScrollController.position.maxScrollExtent +
                _imageMessageHeight,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
      });
    }

    mess.emit(MyEvent.ConversationRefresh);
  }

  Future _scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(index,
        duration: Duration(milliseconds: 100),
        preferPosition: AutoScrollPosition.end);
  }

  void _onRefresh() async {
    _isNeedScrollToNewPage = true;

    if (_showMessageList.length == 0) {
      _refreshController.refreshCompleted();
      _isNeedScrollToNewPage = false;
      return;
    }
    //每次查询 10 条消息
    try {
      // 以上一页的最早的消息作为开始，继续向前拉取消息
      List<Message> messages2 = await this.widget.conversation.queryMessage(
            startTimestamp: _oldMessage.sentTimestamp,
            startMessageID: _oldMessage.id,
            startClosed: false,
            limit: 10,
          );
      if (messages2.length == 0) {
        _refreshController.refreshCompleted();
        _isNeedScrollToNewPage = false;
        return;
      } else if (messages2.length < 10) {
        _lastPageLength = messages2.length;
      }
      _oldMessage = messages2.first;
      _showMessageList.insertAll(0, messages2);
    } catch (e) {
      print(e);
    }
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            //点击页面通知收起键盘
            onTap: () => mess.emit(MyEvent.ScrollviewDidScroll),
            onDoubleTap: () => mess.emit(MyEvent.ScrollviewDidScroll),
            child: Container(
                child: SmartRefresher(
                    enablePullDown: true,
                    header: CustomHeader(
//                      completeDuration: Duration(milliseconds: 200),
                      builder: (context, mode) {
                        Widget body;
                        if (mode == RefreshStatus.idle) {
                          body = Text("下拉刷新");
                        } else if (mode == RefreshStatus.refreshing) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == RefreshStatus.canRefresh) {
//                              body = Text("release to refresh");
                          body = CupertinoActivityIndicator();
                        } else if (mode == RefreshStatus.completed) {
//                              body = Text("refreshCompleted!");
                          if (_isNeedScrollToNewPage) {
                            _lastPageLength != 0
                                ? _scrollToIndex(_lastPageLength)
                                : _scrollToIndex(10);
                          }
                        }
                        return Container(
                          height: 60.0,
                          child: Center(
                            child: body,
                          ),
                        );
                      },
                    ),
                    onRefresh: _onRefresh,
                    controller: _refreshController,
                    child: ListView.builder(
                      //根据子组件的总长度来设置ListView的长度
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _autoScrollController,
                      itemCount: _showMessageList.length,
                      itemBuilder: (context, index) {
                        _textMessageMaxWidth =
                            MediaQuery.of(context).size.width * 0.7;
                        Message message = _showMessageList[index];
                        String fromClientID = message.fromClientID;
                        // string time = message.sentDate;//
                        _isMessagePositionLeft = false;
                        if (fromClientID != currentClint.client.id) {
                          _isMessagePositionLeft = true;
                        }
                        return AutoScrollTag(
                            key: ValueKey(index),
                            controller: _autoScrollController,
                            index: index,
                            child: Container(
//                    color: Color(0xfff5f5f5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Column(
                                      crossAxisAlignment: _isMessagePositionLeft
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onLongPress: () {
                                              //TODO：禁言
                                            },
                                            child: nameBuildView(fromClientID)),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Flex(
                                            direction: Axis.horizontal,
                                            mainAxisAlignment:
                                                _isMessagePositionLeft
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment.end,
                                            children: <Widget>[
                                              typeMessageView(message),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    )))));
  }
  Widget nameBuildView(String fromClientID){
    if(this.widget.conversation.members.length>2 && fromClientID!=Global.clientID){
      //当为群聊，且不是本人发消息时，写来源
      return Container(
        padding: const EdgeInsets.only(
            right: 8, left: 8),
        child: new Text(
          fromClientID,
          style: new TextStyle(
            fontWeight: FontWeight.normal,color: Color(0xff000000).withOpacity(0.7),
          ),
        ),
      );

    }else{return Container();}



  }
  //展示不同的消息类型
  Widget typeMessageView(Message message) {
    if (message is TextMessage) {
      return GestureDetector(
          onLongPress: () {
            showReportDialog(message.id,message.text,message.fromClientID);
          },
          child: Container(
              padding: const EdgeInsets.all(8.0),
              constraints: BoxConstraints(
                maxWidth: _textMessageMaxWidth,
              ),
              decoration: _isMessagePositionLeft//是否在左边
              //TODO:颜色修改
                  ? BoxDecoration(
                      color: Color(0xffE0E0E0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    )
                  : BoxDecoration(
                      color: Color(0xff2196F3),
                      // 这里是框的颜色；
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
              child: new Text(
                //TODO：显示端 —— 设置解密？ dd
                  funcEncrypt().Decryption(getMessageString(message),),


                  //getMessageString(message),
               // getMessageString(message).replaceAll('?encoded', '!decoded'),
                //最后显示
                style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    color: _isMessagePositionLeft ? Color(0xff000000) : Color(0xffffffff)),
                //###########
                // 修改的位置，颜色标记。 文字颜色：白/蓝
                //##########3
              )));
    } else if (message is FileMessage) {
      if (message is ImageMessage) {
        return GestureDetector(
            onLongPress: () {
              showReportDialog(message.id,message.url,message.fromClientID);
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.4,
              ),
              child: CachedNetworkImage(
                imageUrl: message.url,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    //CircularProgressIndicator(value: downloadProgress.progress),
                  CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => Icon(CupertinoIcons.exclamationmark_octagon),
              ),
            ));
      }

    } else {
      return Text('暂未支持的消息类型。。。');
    }
  }

  Future<bool> showReportDialog(String messageID,String text,String sender) async {

    print(sender);
    return showCupertinoDialog<bool>(


      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            funcEncrypt().DecryptionMan(text),
            textAlign: TextAlign.center,
          ),


          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("❤️收藏"),
              onPressed: () {
                saveReports(messageID,text,sender);
                //关闭对话框并返回true
                Navigator.of(context).pop();
              },

            ),
            CupertinoDialogAction(
              child: Text("确认"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
          ],
        );
      },
    );
  }
//TODO:禁言

  Future saveReports(String messageID,String text,String sender) async {
LCObject stared = LCObject('stared');
stared['clientID'] = Global.clientID;
stared['messageID'] = messageID;
stared['content'] = text;
stared['sender'] = sender;
stared['conversationID'] = this.widget.conversation.id;
await stared.save();
    showToastGreen('提交成功！');
  }


  ///value: 文本内容；fontSize : 文字的大小；fontWeight：文字权重；maxWidth：文本框的最大宽度；maxLines：文本支持最大多少行
  static double calculateTextHeight(String value, fontSize,
      FontWeight fontWeight, double maxWidth, int maxLines) {
    TextPainter painter = TextPainter(
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
            )));
    painter.layout(maxWidth: maxWidth);

    ///文字的宽度:painter.width
    return painter.height;
  }

  @override
  void dispose() {
    super.dispose();
    //recordPlugin.dispose();
    //取消订阅
    mess.off(MyEvent.NewMessage);
    mess.off(MyEvent.ImageMessageHeight);
//    mess.off(MyEvent.EditingMessage);
  }

  @override
  void deactivate() async {
    print('结束');
//    int result = await audioPlayer.release();
//    if (result == 1) {
//      print('release success');
//    } else {
//      print('release failed');
//    }
    super.deactivate();
    //recordPlugin.stopPlay();
    //recordPlugin.dispose();
  }
}

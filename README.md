# 基于lcrealtime制作的app - MChat

尝试进行端对端加密，主要是对前端重构，加入了自己想要做的一些功能，并尝试统一风格。
Flutter & Dart & LeanCloud
Flutter的iOS风格聊天程序

## leancloud相关修改：
 - Global.dart文件：`/lib/Common/Global.dart`
 - IOS相关文件：`/ios/Runner/AppDelegate.swift`
 - Android相关：`/android/app/src/main/java/com/example/lcrealtime/MyApplication.java`（不确定）

## 希望包含的内容：
对lcrealmassage的Cupertino风格重构，并增加一些其他的功能。
原GitHub链接：https://github.com/SXiaoXu/FlutterRealtimeDemo

## 关于目前的状态，功能等
0 前置
   - 登录页面              ✅完成
     - 没有制作登录功能，但是可以输入ID进入，预计接入系统后用其他账号登录或系统保存一个状态
   - 登出                 ✅完成
     - 包含一个警告框，设置为页内弹窗功能
   - 基于leancloud的后端，目前没有flutter的可用框架（对用户管理）
1 功能页
   - 收藏的信息（或其他内容） ✅完成
     - 需要信息中带有一个flag（修订为使用从LCObject查找创建人并列出）
   - 所有信息读取           ✅完成 
     - 读取所有当前用户的conversation进行列表，包括已知联系人，未知联系人，未读消息，群组，都是从这个界面再进行条件过滤
   - 已知联系人的信息列表    ✅完成
   - 未知联系人            ✅完成
     - 对联系人进行过滤？（在联系人列表中的，以及不在列表中的）
   - 未读消息的列表         ✅完成
     - 有unread count作为标记，直接过滤
   - 联系人页面            ✅完成
     - 制作了页面，但是没有添加联系人的功能，如上leancloud目前没有flutter的管理
   - 群组                  ✅完成
     - 未制作，由于目前的联系人聊天是群组类多选聊天，或许出现重复，
     - 可以设置为超过两个人的聊天页，但是放在此处则页面逻辑不同(✅完成)
   - 延展类功能
2 功能延展
   - 导航主页              ✅完成
     - 包含各个功能导航，以及更美观的界面（iMessage）
   - 个人资料页            ✅完成
     - 包含个人名称，图片，以及信息二维码，但是图片内容暂不可更改，服务器需要图像存储
   - 订阅
     - 设想：为能够选择聊天的服务器，这样可以快速在各个服务器中切换，未实现，
     - p2p、反追踪、在任何不可信的服务器上进行快速搭建并安全通信等
   - 选项页面
     - 设想：包含一些其他功能，现在包含一些测试按钮
     - 彩色装饰品
     - 显示解密后的文本
   - 加密保护🌟
     - 核心功能，设置为一个开关，控制一个全局变量，能够开启和关闭发信时的加解密；
   - 关于                 ✅完成
     - 一个包含程序信息的简单页面
3 小部件
   - 原版本自带的拉黑功能（已经修改为收藏功能），利用leancloud 的LCObject 云端
     - 支持在联系人列表拉黑，对某个单条信息进行举报
   - 收藏相关              ✅完成
     - 计划：对某个消息等进行收藏加星功能（喜爱）设置flag来在"收藏"页面展示
4 聊天部分
   - 删除了原版本支持的录音部分（由于自己这里编译不过）（报错找不到GitHub相关等）
   - 保留文本输入，图片上传功能，
   - 对群组聊天的页面进行重绘，修改部分逻辑，在发信人为自己时不显示id，
   - 对单聊页面重绘，名称始终显示为对方ID，发信内容页面不显示ID
   - （对自己）对导航、列表页面重绘，代码的封装（在我的学习过程中，从手写导航页面到转为使用插件绘制，让代码逻辑更清晰）
   - （对自己）原本的页面分离列表进行风格化统一，并且将其封装到函数中，减少多个页面的重复代码绘制可能导致的差异性。
5 一些逻辑和其他功能
   - 彩色装饰品：对列表进行装饰，过滤条件（是否为自己，是否为群组，是否是已知的联系人）
   - 对收藏页面来说，是利用举报的逻辑上传stared的object并且其中包含创建人，这样从云取回时过滤Global.clientID就可以实现


# 文档
致谢：https://github.com/SXiaoXu/FlutterRealtimeDemo
[LeanCloud 即时通信插件链接](https://pub.dev/packages/leancloud_official_plugin#leancloud_official_plugin)
[LeanCloud 即时通信开发文档](https://leancloud.cn/docs/#%E5%8D%B3%E6%97%B6%E9%80%9A%E8%AE%AF)
[Flutter 文档](https://flutter.dev/docs)
   


# Preview

![login](/preview/pre1.png)
![nav](preview/pre2.png)
![send](/preview/pre3.png)


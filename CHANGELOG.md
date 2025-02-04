## 1.3.2
* [新增]剪切板共享功能(测试中)
* [新增]文件下载成功后支持直接打开
* [新增]文件支持多线程下载

## 1.3.1
* [修复]桌面端拖拽文件只能上传一个的bug
* [修复]修复下载同名文件不能添加别名的bug
* [优化]首页界面优化
* [修复]iOS浏览器无法加入的bug

## 1.3.0
* [新增]Web端支持拖拽上传文件了
* [修复]Web上传文件桌面端不能下载的bug

## 1.2.9
* [新增]桌面端支持拖拽上传文件了

## 1.2.8
* [优化]文件选择的UI样式

## 1.2.7
* [修复]浏览器上传客户端下载没创建文件夹的bug
* [修复]浏览器上传客户端下载文件名错误的bug

## 1.2.6
* [新增]支持浏览器上传文件

## 1.2.5
* [优化]实现了动态端口绑定，避免端口占用的情况
* [修复]修复非发起共享端发送文件，web不能下载的问题
* [优化]添加新的ip筛选算法，不再依赖端口
这个版本主要为了解决之前对固定端口的依赖，为了之后的windows版本

## 1.2.4
* [优化]设备发现的弹窗替换成列表
* [新增]其他设备关闭速享的列表同步
* [改动]聊天窗口端口换成了12000，这是一个非兼容性的改动，所以旧版不再能与这个版本互传文件。

## 1.2.3

* [优化]UI优化
* [优化]更新web图标，浏览器标题
* [优化]替换ip查找方案(可能会引发新的问题)
简单描述就是，pc在N个ip下，手机在N个ip下，他俩怎么通信
* [增加]增加app选择的功能(文件选择-切换T标签可查看)
配色有些违和，有更好的配色可以提供给我，目前是扣的material you的颜色
设置功能还没时间支持，等后面更新。
* [增加]设备加入与退出的提示

## 1.2.2

* 尝试支持息屏不退出传输

## 1.2.1

* 修复文件夹下载网速显示的问题
* 支持 MIUI 桌面长按 app 分享到速享
* 支持 MT 管理器长按文件分享到速享(部分高权限目录会不生效)
* 适配了一下平板的UI
快速分享需要速享处于房间中
设置功能还只有UI

## 1.2.0

* 支持文件多选发送
* 整体布局优化
* 支持发送文件夹(测试功能)
* 文件选择页面优化
* 添加设置功能(目前只有UI)

## 1.1.8

* 优化安卓端视频播放大小问题
* 优化历史消息获取
* 优化未加入局域网的消息显示
* 静态部署默认所有文件响应下载行为
* web共享窗口点击消息同时支持文件可预览，点击下载可唤起下载而不是预览
感谢@reselp 反馈的响应头支持的问题

## 1.1.7

* 优化扫码功能

## 1.1.6

* 修复 windows 发送文件的 bug
* 更改聊天文件部署方案
* 优化文件部署，增加了排序，视屏丝滑在线播放
* 合并端口，不再需要筛选部署的端口啦
* 优化UI

## 1.1.5

* UI 调整
* 支持局域网设备发现功能
* 修复一些 bug

## 1.1.4

* macOS支持发送文件
* UI调整
* 支持仅IP地址加入分享窗口
* 调整PC端窗口的初始大小
* 支持扫码连接

## 1.1.3

* 修复android端非chrome浏览器无法打开网页的问题

## 1.1.2

* 优化UI
* 优化web的url
* macOS支持选择文件夹功能

## 1.1.1

* 优化视频消息的显示
* 修复加入共享窗口端发送文件无法解析的问题
* 下载其他文件支持网速显示

## 1.1.0

这个版本添加代码较多，直接升了第二个版本号

* 可以像聊天一样共享文件，支持Android、macOS、Windows、Linux、Web（PC版等后续编译，macOS有需要的可以直接联系我要测试版）
* 支持图片以及视频消息直接预览（预览仅支持Android与Web）
* 消息内容快速复制
* 支持多个设备同时分享与查看
* 下载进度显示、网速显示
Web加入分享，直接打开“创建窗口“后显示的URL即可。
目前web还不支持分享文件，后续跟上，这部分涉及到的技术太广，web前端、后端、Flutter客户端，我还需要学习才能开发其他的功能。

## 1.0.0

第一个版本

* 支持文件部署
* 支持多端口模式
* 支持扫码打开部署网站
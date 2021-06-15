import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:speed_share/config/config.dart';
import 'package:speed_share/themes/app_colors.dart';
import 'package:speed_share/utils/process_server.dart';
import 'package:speed_share/utils/scan_util.dart';
import 'package:speed_share/utils/shelf_static.dart';
import 'package:speed_share/widgets/custom_icon_button.dart';
import 'package:supercharged/supercharged.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool serverOpend = true;
  String content = '';
  List<String> addreses = [];
  @override
  void initState() {
    super.initState();
    request();
  }

  Future<void> request() async {
    if (GetPlatform.isAndroid) {
      PermissionUtil.requestStorage();
    }
    if (!GetPlatform.isWeb) {
      addreses = await PlatformUtil.localAddress();
    }

    setState(() {});
  }

  Widget addressItem(String uri) {
    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(
          text: uri,
        ));
        content = uri;
        setState(() {});
        showToast('已复制到剪切板');
      },
      child: SizedBox(
        height: Dimens.gap_dp48,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp12,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepPurple,
                ),
                height: Dimens.gap_dp6,
                width: Dimens.gap_dp6,
              ),
              SizedBox(width: Dimens.gap_dp8),
              Text(
                uri,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar;
    // if (GetPlatform.isAndroid) {
    appBar = AppBar(
      title: Text('速享'),
      actions: [
        if (GetPlatform.isAndroid)
          NiIconButton(
            child: SvgPicture.asset(
              '${Config.flutterPackage}assets/icon/QR_code.svg',
              color: Colors.black,
            ),
            onTap: () async {
              ScanUtil.parseScan();
            },
          ),
        SizedBox(width: Dimens.gap_dp12),
      ],
    );
    // }
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: QrImage(
                data: content,
                version: QrVersions.auto,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '局域网的设备使用浏览器打开以下链接即可浏览本机文件，点击可复制链接和更新二维码',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ),
                Builder(builder: (_) {
                  List<Widget> list = [];
                  for (String address in addreses) {
                    // if (address.startsWith('10.')) {
                    //   // 10.开头的ip一般是移动数据获得的ip
                    //   continue;
                    // }
                    list.add(
                      addressItem('http://$address:${Config.shelfAllPort}'),
                    );
                  }
                  return Column(
                    children: list,
                  );
                }),
              ],
            ),
            Center(
              child: serverOpend
                  ? LoginButton(
                      title: '关闭服务',
                      backgroundColor: AppColors.surface,
                      fontColor: AppColors.fontColor,
                      onTap: () async {
                        await Future<void>.delayed(Duration(milliseconds: 300));
                        if (!GetPlatform.isWeb) {
                          ProcessServer.close();
                        }
                        ShelfStatic.close();
                        serverOpend = false;
                        setState(() {});
                        return true;
                      },
                    )
                  : LoginButton(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      title: '开启服务',
                      fontColor: Colors.white,
                      onTap: () async {
                        await Future<void>.delayed(Duration(milliseconds: 300));
                        if (!GetPlatform.isWeb) {
                          ProcessServer.start();
                        }
                        ShelfStatic.start();
                        serverOpend = true;
                        setState(() {});
                        return true;
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key key,
    this.onTap,
    this.title,
    this.backgroundColor,
    this.fontColor,
  }) : super(key: key);
  final Future<bool> Function() onTap;
  final String title;
  final Color backgroundColor;
  final Color fontColor;

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> with AnimationMixin {
  bool successExec = false;
  CustomAnimationControl tapControl = CustomAnimationControl.STOP;
  CustomAnimationControl execControl = CustomAnimationControl.STOP;
  final _tween = TimelineTween<String>()
    ..addScene(begin: 0.milliseconds, end: 300.milliseconds).animate(
      'width',
      tween: Dimens.setWidth(300).tweenTo(Dimens.setWidth(36)),
    )
    ..addScene(begin: 0.milliseconds, end: 300.milliseconds).animate(
      'radius',
      tween: Dimens.setWidth(8).tweenTo(Dimens.setWidth(18)),
    )
    ..addScene(begin: 0.milliseconds, end: 300.milliseconds).animate(
      'fontsize',
      tween: Dimens.font_sp14.tweenTo(Dimens.setWidth(0)),
    )
    ..addScene(begin: 300.milliseconds, end: 600.milliseconds).animate(
      'opacity',
      tween: 0.0.tweenTo(1.0),
    );
  // ..addScene(begin: 0.milliseconds, end: 3000.milliseconds).animate(
  //   "width",
  //   tween: 300.0.tweenTo(36.0),
  // );
  @override
  Widget build(BuildContext context) {
    return CustomAnimation<double>(
      control: tapControl,
      tween: 0.0.tweenTo(1.0), // Pass in tween
      duration: const Duration(milliseconds: 200), // Obtain duration
      builder: (context, child, tapValue) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            tapControl = CustomAnimationControl.PLAY_REVERSE;
            execControl = CustomAnimationControl.PLAY;
            setState(() {});
            successExec = await widget.onTap();
            successExec = true;
            // if (!successExec) {
            execControl = CustomAnimationControl.PLAY_REVERSE;
            // }
            setState(() {});
            Feedback.forLongPress(context);
          },
          onTapDown: (_) {
            tapControl = CustomAnimationControl.PLAY;
            Feedback.forLongPress(context);
            setState(() {});
          },
          onTapCancel: () {
            tapControl = CustomAnimationControl.PLAY_REVERSE;
            Feedback.forLongPress(context);
            setState(() {});
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(1.0 - tapValue * 0.05),
            child: CustomAnimation<TimelineValue<String>>(
              control: execControl,
              tween: _tween, // Pass in tween
              duration: _tween.duration, // Obtain duration
              builder: (context, child, value) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(value.get('radius')),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.04 - tapValue * 0.04,
                        ),
                        offset: const Offset(0.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 0, //阴影模糊程度
                        spreadRadius: 0.0, //阴影扩散程度
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(value.get('radius')),
                    ),
                    child: SizedBox(
                      width: Dimens.setWidth(value.get('width')),
                      height: Dimens.setWidth(40),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                color: widget.fontColor,
                                fontWeight: FontWeight.bold,
                                fontSize: value.get('fontsize'),
                              ),
                            ),
                          ),
                          CustomAnimation<double>(
                            control: CustomAnimationControl.LOOP,
                            tween: 0.0.tweenTo(2 * pi), // Pass in tween
                            duration: const Duration(
                              milliseconds: 300,
                            ), // Obtain duration
                            builder: (context, child, rvalue) {
                              return Opacity(
                                opacity: value.get('opacity'),
                                child: Transform.rotate(
                                  angle: rvalue,
                                  child: Icon(
                                    Icons.refresh,
                                    size: Dimens.gap_dp30,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_manager.dart';
import 'package:flutter_sg_mvvm/app_manager/app_routes_manager.dart';
import 'package:flutter_sg_mvvm/page/find/find_page.dart';
import 'package:flutter_sg_mvvm/page/home/home_page.dart';
import 'package:flutter_sg_mvvm/page/mall/mall_page.dart';
import 'package:flutter_sg_mvvm/page/mine/mine_page.dart';
import 'package:flutter_sg_mvvm/widgets/icons/icons.dart';

class MainBottomBar extends StatefulWidget {
  MainBottomBar({Key key}) : super(key: key);
  @override
  _MainBottomBarState createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar>
    with WidgetsBindingObserver {
  int currentIndex = 0;
  List<Widget> _pages = [];
  final _pageController = PageController(initialPage: 0);

  TextStyle _selectedLabelStyle = const TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
  );
  TextStyle _unselectedLabelStyle = const TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w400,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getScreenSize();
    _pages.add(HomePage());
    _pages.add(MallPage());
    _pages.add(FindPage());
    _pages.add(MinePage());
    //监听app生命周期
    WidgetsBinding.instance.addObserver(this);

    AppRoutesManager.addAppRooutesManageListener((data) {
      int code = data['code'] ?? -1;
      PopPage pop = data['popPage'] ?? PopPage.popNone;

      switch (data['page']) {
        case PushPage.goLogin:
          AppRoutesManager.router
              .navigateTo(context, '${AppRoutesManager.login}?code=$code')
              .then((loginSuccess) {
            if (loginSuccess == false) {
              //没有登录
              if (Navigator.of(context).canPop()) {
                //是否可以返回
                switch (pop) {
                  case PopPage.popNone:
                    break;
                  case PopPage.popUntil: //返回一级界面
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    break;
                  case PopPage.popUp: //返回上一页
                    Navigator.of(context).pop();
                    break;
                }
              } else {
                //已经是一级界面回到首页
                _handlePageChanged(0);
              }
            }
          });
          break;
        case PushPage.goHomeAndLogin:
          Navigator.of(context).popUntil((route) => route.isFirst);
          _handlePageChanged(0);
          break;
        default:
          {
            break;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _pages,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.5,
                color: Color(0xFFE5E5E5),
              ),
            ),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Color(0xFFDFBE84),
            unselectedItemColor: Color(0xFF262626),
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            selectedLabelStyle: _selectedLabelStyle,
            unselectedLabelStyle: _unselectedLabelStyle,
            backgroundColor: Theme.of(context).cardColor,
            currentIndex: currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  IconFont.home_outline,
                  color: Color(0xFF262626),
                  size: 28.0,
                ),
                activeIcon: Icon(
                  IconFont.home,
                  color: Color(0xFFDFBE84),
                  size: 28.0,
                ),
                title: Text('首页'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconFont.mall_outlline,
                  color: Color(0xFF262626),
                  size: 28.0,
                ),
                activeIcon: Icon(
                  IconFont.mall,
                  color: Color(0xFFDFBE84),
                  size: 28.0,
                ),
                title: Text('商城'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconFont.shoe_outline,
                  color: Color(0xFF262626),
                  size: 28.0,
                ),
                activeIcon: Icon(
                  IconFont.shoe,
                  color: Color(0xFFDFBE84),
                  size: 28.0,
                ),
                title: Text('发现'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconFont.person_outline,
                  color: Color(0xFF262626),
                  size: 28.0,
                ),
                activeIcon: Icon(
                  IconFont.person,
                  color: Color(0xFFDFBE84),
                  size: 28.0,
                ),
                title: Text('我的'),
              ),
            ],
            onTap: (int index) async {
              if (!AppManager.isLogin && index == 3) {
                AppRoutesManager.router
                    .navigateTo(context, AppRoutesManager.login)
                    .then((isLogin) {
                  if (isLogin) {
                    _handlePageChanged(index);
                  }
                });
              } else {
                _handlePageChanged(index);
              }
            },
          ),
        ));
  }

  void _handlePageChanged(int index) {
    _pageController.jumpToPage(index);

    setState(() {
      currentIndex = index;
    });
  }

  /// 获取屏幕尺寸等信息
  Future<void> _getScreenSize() async {
    Future.microtask(() {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;
      AppManager.scale = width / 375;
      AppManager.width = width;
      AppManager.height = height;
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}

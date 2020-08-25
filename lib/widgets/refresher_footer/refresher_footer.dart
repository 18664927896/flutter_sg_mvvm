
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        final style = TextStyle(
          fontSize: 12.0,
          color: Color(0xFFCCCCCC),
        );
        if (mode == LoadStatus.idle) {
          body = Text("上拉加载", style: style);
        } else if (mode == LoadStatus.loading) {
          body = Text("正在加载", style: style);
        } else if (mode == LoadStatus.failed) {
          body = Text("加载失败！点击重试！", style: style);
        } else if (mode == LoadStatus.canLoading) {
          body = Text("松手，加载更多!", style: style);
        } else if (mode == LoadStatus.noMore) {
          body = Text("已经到底了哦～", style: style);
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}

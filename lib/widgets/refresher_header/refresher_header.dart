import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefresherHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomHeader(builder: (BuildContext context, RefreshStatus mode) {
      Widget body;
      final style = TextStyle(
        fontSize: 12.0,
        color: Color(0xFF262626),
      );
      if (mode == RefreshStatus.idle) {
        body = Text("下拉刷新", style: style);
      } else if (mode == RefreshStatus.refreshing) {
        body = Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SpinKitThreeBounce(
                size: 8.0,
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color:
                          index.isEven ? Color(0XFF555555) : Color(0XFFBBBBBB),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                },
              ),
            ),
            Text("刷新中", style: style),
          ],
        );
      } else if (mode == RefreshStatus.failed) {
        body = Text("刷新失败！点击重试！", style: style);
      } else if (mode == RefreshStatus.canRefresh) {
        body = Text("松手刷新", style: style);
      } else {
        body = Text("刷新完成", style: style);
      }
      return Container(
//                        color: Colors.red,
          height: 50.0,
          child: Center(child: body));
    });
  }
}

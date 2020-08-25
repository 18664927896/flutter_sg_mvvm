import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';

class MallPage extends StatefulWidget {
  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends BaseState<MallPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "商城";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: pageName,
      ),
      body: Container(
        color:  Colors.orange,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/page/mall/view_model/mall_view_model.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

class MallPage extends StatefulWidget {
  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends BaseState<MallPage,MallViewModel> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "商城";
    viewModel = MallViewModel(context);
    viewModel.refreshData(isShowLoading: true);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: CustomAppBar(
          title: pageName,
        ),
        body: initView(),
      ),
    );
  }

  @override
  Widget buildView() {
    return Container(
      color:  Colors.orange,
    );
  }
}

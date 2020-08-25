import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/app_manager/app_manager.dart';
import 'package:flutter_sg_mvvm/base/base_state.dart';
import 'package:flutter_sg_mvvm/page/home/model/product_model.dart';
import 'package:flutter_sg_mvvm/page/home/view_model/home_view_model.dart';
import 'package:flutter_sg_mvvm/page/login/login_page.dart';
import 'package:flutter_sg_mvvm/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_sg_mvvm/widgets/loading_widget/loading_widget.dart';
import 'package:flutter_sg_mvvm/widgets/refresher_footer/refresher_footer.dart';
import 'package:flutter_sg_mvvm/widgets/refresher_header/refresher_header.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}):super(key:key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomeViewModel viewModel;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageName = "首页";
    viewModel = HomeViewModel(context);
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

  Widget initView() {
    return Consumer<HomeViewModel>(
      builder: (build, provide, _) {
        print('Consumer-initView');
        print('${viewModel.isLoading}');
        return viewModel.isLoading ? LoadingWidget() : _buildListView();
      },
    );
  }

  Widget _buildListView() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: RefresherHeader(),
                footer: RefresherFooter(),
                controller: viewModel.refreshController,
                onRefresh: (){
                  viewModel.page = 0;
                  viewModel.refreshData();
                },
                onLoading: (){
                  viewModel.refreshData();
                },
                child: ListView.builder(
                  itemCount: viewModel.dataList.length,
                  itemBuilder: (BuildContext context, index) {
                    ProductModel model = viewModel.dataList[index];
                    return Container(
                      height: 100,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(model.name),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    viewModel.collectionProduc(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(model.isCollection?'取消':'收藏'),
                                  ),
                                )

                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text('价格：${model.price}'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text('数量：${model.num}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
          GestureDetector(
            onTap: () {
              push(page: LoginPage(), popCallback: (dada) {});
            },
            child: Container(
              width: AppManager.width,
              height: 40,
              color: Colors.yellow,
            ),
          )
        ],
      ),
    );

  }
}

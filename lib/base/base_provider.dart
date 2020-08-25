import 'package:flutter/material.dart';
import 'package:flutter_sg_mvvm/base/base_view_model.dart';


///提供viewModel的widget
///author:liuhc
class BaseProvider<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final Widget child;

  BaseProvider({
    @required this.viewModel,
    @required this.child,
  });

  static T of<T extends BaseViewModel>(BuildContext context) {
    final type = _typeOf<BaseProvider<T>>();
    BaseProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.viewModel;
  }

  static Type _typeOf<T>() => T;

  @override
  _ViewModelProviderState createState() => _ViewModelProviderState();
}

class _ViewModelProviderState extends State<BaseProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }
}

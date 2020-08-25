
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SpinKitRing(
          lineWidth: 2.0,
          color: Color(0xFF262626),
          duration: const Duration(milliseconds: 1000),
          size: 40.0,
        ),
      ),
    );
  }
}

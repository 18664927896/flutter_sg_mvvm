import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String _status;
  final String _buttonText;
  final bool _isShowImage;
  final VoidCallback _callback;

  EmptyWidget({
    Key key,
    String status,
    String buttonText,
    bool isShowImage,
    VoidCallback onTap,
  })  : _status = status ?? '',
        _buttonText = buttonText ?? '',
        _isShowImage = isShowImage ?? true,
        _callback = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_isShowImage) Image.asset('assets/images/status/empty.png'),
        SizedBox(
          height: 20.0,
        ),
        Text(
          _status,
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF888888),
            fontFamily: 'Regular',
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        if (_buttonText.isNotEmpty)
          FlatButton(
            highlightColor: Color(0x55FFFFFF),
            color: Color(0xFF262626),
            padding: EdgeInsets.symmetric(horizontal: 41.0),
            shape: BeveledRectangleBorder(),
            onPressed: () {
              if (_callback != null) {
                _callback();
              }
            },
            child: Container(
              height: 44.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _buttonText,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontFamily: 'Regular',
                      fontWeight: FontWeight.w300,
                      height: 1.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        SizedBox(
          height: 80.0,
        ),
      ],
    );
  }
}

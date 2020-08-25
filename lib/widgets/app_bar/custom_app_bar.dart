import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sg_mvvm/widgets/icons/icons.dart';




class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final Widget leading;
  final Widget trailing;
  final dynamic title;
  final bool showBorder;

  CustomAppBar({
    Key key,
    this.leading,
    this.title = '',
    this.trailing,
    this.height = 44.0,
    this.showBorder = false,
  }) : super();

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Widget _title;

  Function callback;

  @override
  void initState() {
    super.initState();
    setTitle();

    callback = (code) {
      setState(() {});
    };


  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.title != widget.title) {
      setTitle();
    }
  }

  void setTitle() {
    if (widget.title is Widget) {
      _title = widget.title;
    } else {
      _title = Text(
        widget.title?.toString(),
      );
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    Widget leading = widget.leading;
    if (leading == null && canPop) {
      leading = const CustomBackButton();
    }

    if (leading == null && canPop) {
      leading = const CustomBackButton();
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: true,
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              border: widget.showBorder
                  ? Border(
                bottom: BorderSide(
                  color: Color(0xFFEEEEEE),
                  width: 0.5,
                ),
              )
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: Container(
                    child: leading,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 190.0,
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: const Color(0xFF262626),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    child: _title,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    child: widget.trailing,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  /// Creates an [IconButton] with the appropriate "back" icon for the current
  /// target platform.
  const CustomBackButton({Key key, this.color, this.onPressed})
      : super(key: key);

  /// The color to use for the icon.
  ///
  /// Defaults to the [IconThemeData.color] specified in the ambient [IconTheme],
  /// which usually matches the ambient [Theme]'s [ThemeData.iconTheme].
  final Color color;

  /// An override callback to perform instead of the default behavior which is
  /// to pop the [Navigator].
  ///
  /// It can, for instance, be used to pop the platform's navigation stack
  /// via [SytemNavigator] instead of Flutter's [Navigator] in add-to-app
  /// situations.
  ///
  /// Defaults to null.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: Icon(
        IconFont.back,
        color: Color(0xFF262626),
        size: 20.0,
      ),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

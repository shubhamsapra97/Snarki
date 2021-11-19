import 'package:flutter/material.dart';

class RaisedButtonCustom extends StatelessWidget {
  final Widget? child;
  final String btnText;
  final Function? onPressed;
  final Color? btnColor;
  final Color btnTextColor;
  final double? width;
  final double height;
  final Color? disabledColor;
  final Color? disabledTextColor;
   final double borderRadius;

  const RaisedButtonCustom({
    Key? key,
    this.child,
    this.btnText = '',
    @required this.onPressed,
    this.btnColor,
    this.btnTextColor = Colors.white,
    this.width ,
    this.height = 46,
    this.disabledColor,
    this.disabledTextColor, this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
          // disabledColor: disabledColor ?? HexColor("#D9D9D9"),
          disabledTextColor: disabledTextColor,
          onPressed: () => onPressed!(),
          elevation: 0,
          textColor: btnTextColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          color: btnColor ?? Theme.of(context).accentColor,
          child: child ??
              Text(
                btnText,
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: btnTextColor),
              )),
    );
  }
}

class FlatButtonCustom extends StatelessWidget {
  final Widget? widget;
  final String btnText;
  final Function? onPressed;
  final Color btnColor;
  final Color? borderColor;
  final double borderRadius;

  const FlatButtonCustom({
    Key? key,
    this.widget,
    this.btnText = '',
    this.onPressed,
    this.btnColor = Colors.white,
    this.borderRadius = 10.0,
    this.borderColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        disabledColor: Theme.of(context).buttonColor.withOpacity(0.5),
        onPressed: () => onPressed,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.5, color: borderColor ?? Theme.of(context).buttonColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: btnColor,
        textColor: Theme.of(context).buttonColor,
        child: widget ?? Text(btnText));
  }
}


import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget? value;
  final Widget? secondaryIcon;
  final Color? titleColor;

  const InfoSection({Key? key, this.title, this.icon, this.value, this.secondaryIcon, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title ?? '',
                  style:Theme.of(context).textTheme.bodyText1?.copyWith(
                    color : titleColor ?? Colors.black
                  ),
                ),
              ),
              Spacer(),
              secondaryIcon ?? Offstage()
             
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: value,
          ),
         
        ],
      ),
    );
  }
}
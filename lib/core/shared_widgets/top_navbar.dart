import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  final List<Widget> actions;
  final List<Widget> title;

  const TopNavBar({
    Key key,
    this.title,
    this.actions = const [],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: title ??
                [
                  Text(
                    _salutation(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    'HARRIET SALON',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
          ),
          Spacer(),
          ...actions,
        ],
      ),
    );
  }

  String _salutation() {
    if (TimeOfDay.now().hour >= 6 && TimeOfDay.now().hour <= 11) {
      return "☀️ Good Morning..!";
    }

    if (TimeOfDay.now().hour >= 12 && TimeOfDay.now().hour < 18) {
      return "☀️ Good After Noon..!";
    }

    return "🌙 Good Evening..!";
  }
}

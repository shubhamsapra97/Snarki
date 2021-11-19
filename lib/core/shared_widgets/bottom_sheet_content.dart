import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  final Widget child;

  const BottomSheetContent({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {
           
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 17,
              ),
              SizedBox(width: 8),
              Text(
                "Back",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 17,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        this.child
      ]),
    );
  }
}

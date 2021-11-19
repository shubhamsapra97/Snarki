
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FormCard extends StatelessWidget {
  final List<Widget> widgets;

  const FormCard({Key key, this.widgets}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder:(context, sizinigInfo) =>
           new Container(
        width: double.infinity,
        height: sizinigInfo.screenSize.height*0.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16),
          child: SingleChildScrollView(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets
            ),
          ),
        ),
      ),
    );
  }
}

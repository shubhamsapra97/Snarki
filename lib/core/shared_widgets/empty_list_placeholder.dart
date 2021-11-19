// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
//
//
// class EmptyListPlaceHolder extends StatelessWidget {
//   final String text;
//   final IconData iconData;
//   final Widget child;
//
//   const EmptyListPlaceHolder({Key key, this.text = "No New Orders", this.iconData = FontAwesome.cab, this.child}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//               height: 70,
//               width: 70,
//               child: child ?? Icon(iconData, color: Theme.of(context).primaryColor, size: 32,)),
//           Text(
//             text,
//             style: Theme.of(context).accentTextTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
//           )
//         ],
//       ),
//     ),
//   );
//   }
// }
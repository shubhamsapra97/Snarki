// import 'package:flutter/material.dart';
//
// class PopupMenu<T> extends StatelessWidget {
//   final List<T> collection;
//   final Function(String) onSelected;
//   final Color iconColor;
//
//   const PopupMenu(
//       {Key key,
//       @required this.collection,
//       @required this.onSelected,
//       this.iconColor = Colors.white})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       elevation: 0,
//       icon: Icon(
//         Icons.more_vert,
//         color: iconColor,
//       ),
//       onSelected: this.onSelected,
//       itemBuilder: (BuildContext context) => [
//         ...collection.map<PopupMenuEntry>((value) => PopupMenuItem<T>(
//               value: value,
//               child: Text(
//                 '$value',
//                 style: Theme.of(context).accentTextTheme.bodyText2,
//               ),
//             ))
//       ],
//     );
//   }
// }

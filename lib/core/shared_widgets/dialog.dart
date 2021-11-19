// import 'package:flutter/material.dart';
// import 'package:client/core/shared_widgets/button.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:meta/meta.dart';

// BuildContext _context = Modular.navigatorKey.currentState.overlay.context;

// Future _dialogBox({
//   String title,
//   Widget content,
//   Widget confirmButton,
//   Widget cancelButton,
// }) {
//   return showDialog(
//       context: Modular.navigatorKey.currentState.overlay.context,
//       builder: (context) => Dialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             child: Container(
//               width: 500,
//               margin: EdgeInsets.all(16),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       title,
//                       style: Theme.of(context).textTheme.headline6,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     content,
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ButtonBar(children: [cancelButton, confirmButton]),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ]),
//             ),
//           ));
// }

// Future showDialogBox({@required String title, @required String description}) {
//   return _dialogBox(
//       title: title,
//       content: Text(
//         description,
//         textAlign: TextAlign.center,
//       ),
//       confirmButton: RaisedButtonCustom(
//           child: Text("OK"),
//           onPressed: () {
//             Modular.to.pop();
//           }));
// }

// Future showActionDialogBox(
//     {@required String title, @required String description}) {
//   return _dialogBox(
//     title: title,
//     content: Text(
//       description,
//       textAlign: TextAlign.center,
//     ),
//     confirmButton: RaisedButtonCustom(
//         child: Text("OK"),
//         onPressed: () {
//           return Modular.to.pop("true");
//         }),
//     cancelButton: FlatButton(
//         child: Text("Cancel"),
//         onPressed: () {
//           return Modular.to.pop("false");
//         }),
//   );
// }

// Flushbar<dynamic> showSnackBar(
//   context, {
//   @required String desc,
// }) {
//   Flushbar flush;

//   flush = Flushbar(
//     messageText: Text(
//       desc,
//       style: TextStyle(
//         color: Colors.white,
//       ),
//     ),
//     mainButton: FlatButton(
//         onPressed: () {
//           flush.dismiss(true);
//         },
//         child: Text(
//           "DISMISS",
//           style: Theme.of(context)
//               .textTheme
//               .bodyText2
//               .copyWith(color: Colors.white),
//         )),
//     backgroundColor: Colors.blue,
//     flushbarPosition: FlushbarPosition.BOTTOM,
//     padding: EdgeInsets.all(8),
//     barBlur: 0.0001,
//     borderRadius: 0,
//     icon: Icon(
//       Icons.info,
//       color: Colors.white,
//     ),
//     duration: Duration(seconds: 3),
//   )..show(_context);

//   return flush;
// }

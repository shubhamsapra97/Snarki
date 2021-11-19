// import 'package:flutter/material.dart';
//
// class GradientBackgroundWidget extends StatelessWidget {
//   final Widget child;
//   final List<Color> colors;
//   final double stops;
//
//   const GradientBackgroundWidget({
//     Key key,
//     this.child,
//     @required this.colors,
//     this.stops,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0.0, 1.0),
//           colors: colors,
//           stops: stops ?? [0.0, 1.0],
//         ),
//       ),
//       child: this.child,
//     );
//   }
// }

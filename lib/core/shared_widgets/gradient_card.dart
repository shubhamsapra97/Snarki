// import 'package:flutter/material.dart';
//
// class GradientCard extends StatelessWidget {
//   final List<Color> colors;
//   final double stops;
//   final Widget child;
//   final EdgeInsetsGeometry padding;
//   final BorderRadius borderRadius;
//   final double elevation;
//   final EdgeInsetsGeometry margin;
//
//   const GradientCard({
//     Key key,
//     @required this.colors,
//     @required this.child,
//     @required this.padding,
//     this.elevation = 0,
//     @required this.borderRadius,
//     this.stops,
//     this.margin,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: elevation,
//       margin: margin,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: borderRadius,
//           gradient: LinearGradient(
//             begin: Alignment(0.0, -1.0),
//             end: Alignment(0.0, 1.0),
//             colors: colors,
//             stops: stops ?? [0.0, 1.0],
//           ),
//         ),
//         child: Padding(padding: padding, child: this.child),
//       ),
//     );
//   }
// }

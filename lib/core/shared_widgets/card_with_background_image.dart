// import 'package:flutter/material.dart';
//
// class CardWithBackgroundImageTapable extends StatelessWidget {
//   final String imagePath;
//   final List<Colors> foregrondColors;
//   final Widget child;
//   final EdgeInsetsGeometry padding;
//   final double circularRadius;
//   final double elevation;
//   final Function onTap;
//   final EdgeInsetsGeometry margin;
//
//   const CardWithBackgroundImageTapable({
//     Key key,
//     @required this.imagePath,
//     this.foregrondColors,
//     @required this.child,
//     this.circularRadius = 10,
//     this.elevation = 0,
//     @required this.padding,
//     @required this.onTap,
//     this.margin,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//           margin: margin,
//           elevation: elevation,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(circularRadius)),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(circularRadius),
//                 image: DecorationImage(
//                     fit: BoxFit.cover, image: AssetImage(imagePath))),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 gradient: LinearGradient(
//                   begin: Alignment(0.0, -1.0),
//                   end: Alignment(0.0, 1.0),
//                   colors: foregrondColors ??
//                       [
//                         Colors.black.withOpacity(0.3),
//                         Colors.black.withOpacity(0.3),
//                       ],
//                   stops: [0.0, 1.0],
//                 ),
//               ),
//               child: Padding(padding: padding, child: this.child),
//             ),
//           )),
//     );
//   }
// }
//
// class CardWithBackgroundImage extends StatelessWidget {
//   final String imagePath;
//   final List<Colors> foregrondColors;
//   final Widget child;
//   final EdgeInsetsGeometry padding;
//   final double circularRadius;
//   final double elevation;
//   final EdgeInsetsGeometry margin;
//
//   const CardWithBackgroundImage({
//     Key key,
//     @required this.imagePath,
//     this.foregrondColors,
//     @required this.child,
//     this.circularRadius = 10,
//     this.elevation = 0,
//     @required this.padding,
//     this.margin,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         margin: margin,
//         elevation: elevation,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(circularRadius)),
//         child: Container(
//           decoration: BoxDecoration(
//
//               // color: Colors.transparent,
//               borderRadius: BorderRadius.circular(circularRadius),
//               image: DecorationImage(
//                   fit: BoxFit.cover, image: AssetImage(imagePath))),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               gradient: LinearGradient(
//                 begin: Alignment(0.0, -1.0),
//                 end: Alignment(0.0, 1.0),
//                 colors: foregrondColors ??
//                     [
//                       Colors.black.withOpacity(0.3),
//                       Colors.black.withOpacity(0.3),
//                     ],
//                 stops: [0.0, 1.0],
//               ),
//             ),
//             child: Padding(padding: padding, child: this.child),
//           ),
//         ));
//   }
// }

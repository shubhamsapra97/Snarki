// import 'package:flutter/material.dart';
//
// class CounterWidget extends StatefulWidget {
//   final ValueChanged<int> onChange;
//   final int initialValue;
//   final double height;
//   final double width;
//   final int maxCounterLimit;
//
//   const CounterWidget(
//       {Key key,
//       this.onChange,
//       this.initialValue = 0,
//       this.height = 35,
//       this.width = 115,
//       this.maxCounterLimit = 10})
//       : super(key: key);
//
//   @override
//   _CounterWidgetState createState() => _CounterWidgetState();
// }
//
// class _CounterWidgetState extends State<CounterWidget> {
//   int _counter;
//
//   @override
//   void initState() {
//     super.initState();
//     _counter = widget.initialValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       width: widget.width,
//       decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(
//             width: 0.5,
//           //  color: AppTheme.primaryTextColor,
//           )),
//       child: Row(children: [
//         Flexible(
//           flex: 1,
//           child: IconButton(
//               padding: EdgeInsets.zero,
//               iconSize: 10,
//               icon: Icon(Icons.minimize,
//                   size: 10, color: Theme.of(context).primaryColor),
//               onPressed: () {
//                 _handleDecrement();
//               }),
//         ),
//         Flexible(
//           flex: 1,
//           child: Text(
//             '$_counter',
//             style: Theme.of(context)
//                 .accentTextTheme
//                 .caption
//                 .copyWith(color: Theme.of(context).primaryColor),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: IconButton(
//               padding: EdgeInsets.zero,
//               iconSize: 10,
//               icon: Icon(
//                 Icons.add,
//                 size: 10,
//                 color: Theme.of(context).primaryColor,
//               ),
//               onPressed: () {
//                 _handleIncrement();
//               }),
//         ),
//       ]),
//     );
//   }
//
//   void _handleIncrement() {
//     if (_counter < widget.maxCounterLimit) {
//       setState(() {
//         _counter++;
//         widget.onChange(_counter);
//       });
//     }
//   }
//
//   void _handleDecrement() {
//     if (_counter > 0) {
//       setState(() {
//         _counter--;
//         widget.onChange(_counter);
//       });
//     }
//   }
// }

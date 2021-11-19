// import 'package:flutter/material.dart';
//
// class ToggleButton extends StatefulWidget {
//   final slot;
//   final Function(dynamic?)? onSelection;
//   final Function(dynamic?)? onCancelSelection;
//   final Color selectedFillColor;
//   final Color? unSelectedFillColor;
//   final Color selectedTextColor;
//
//
//   ToggleButton({
//     Key? key,
//     @required this.slot,
//     this.onSelection,
//     this.onCancelSelection,
//     this.selectedFillColor = Colors.blue,
//     this.unSelectedFillColor,
//     this.selectedTextColor = Colors.white,
//   }) : super(key: key);
//
//   @override
//   _ToggleButtonState createState() => _ToggleButtonState();
// }
//
// class _ToggleButtonState extends State<ToggleButton> {
//   bool _isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return RawMaterialButton(
//       onPressed: () {
//         setState(() {
//           _isSelected = !_isSelected;
//         });
//
//         if (_isSelected == true) {
//           widget.onSelection!(widget.slot);
//         }
//
//         if (_isSelected == false) {
//           widget.onCancelSelection!(widget.slot);
//         }
//       },
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       constraints: BoxConstraints(),
//       elevation: 0,
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       focusColor: Colors.transparent,
//       hoverColor: Colors.transparent,
//       hoverElevation: 0,
//       highlightElevation: 0,
//       focusElevation: 0,
//       child: Text(widget.slot.toString(),
//           style: Theme.of(context).textTheme.bodyText1?.copyWith(
//               color: _isSelected
//                   ? widget.selectedTextColor
//                   : widget.selectedFillColor)),
//       fillColor: _isSelected
//           ? widget.selectedFillColor
//           : (widget.unSelectedFillColor ??
//               widget.selectedFillColor.withOpacity(0.3)),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     );
//   }
// }
//
// class ToggleButtonGroup extends StatefulWidget {
//   final List<String?>? slots;
//   final Color? titleColor;
//   final Function(dynamic?)? onSelection;
//   final Color selectedFillColor;
//   final Color? unSelectedFillColor;
//   final Color selectedTextColor;
//   final double width;
//
//   ToggleButtonGroup({
//     Key? key,
//     @required this.slots,
//     this.titleColor,
//     this.onSelection,
//     this.selectedFillColor = Colors.blue,
//     this.unSelectedFillColor,
//     this.selectedTextColor = Colors.white,
//     this.width = 20,
//   }) : super(key: key);
//
//   @override
//   _ToggleButtonGroupState createState() => _ToggleButtonGroupState();
// }
//
// class _ToggleButtonGroupState extends State<ToggleButtonGroup> {
//   Map<String, bool> _isSelected = {};
//
//   @override
//   void initState() {
//     super.initState();
//     widget.slots?.forEach((slot) {
//       if (slot != null) _isSelected.addAll({slot: false});
//     });
//   }
//
//   void selectSlot(selectedSlot) {
//     setState(() {
//       widget.slots?.forEach((slot) {
//         if (slot != null) _isSelected[slot] = false;
//       });
//       _isSelected[selectedSlot] = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(spacing: 1, children: [
//       ...widget.slots.map(
//         (slot) => SizedBox(
//           width: 25,
//           child: RawMaterialButton(
//             onPressed: () {
//               selectSlot(slot);
//               widget.onSelection(slot);
//             },
//             padding: EdgeInsets.zero,
//             elevation: 0,
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             focusColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             hoverElevation: 0,
//             highlightElevation: 0,
//             focusElevation: 0,
//             child: Text(slot.toString(),
//                 style: Theme.of(context).textTheme.bodyText1.copyWith(
//                   fontWeight: FontWeight.bold,
//                     color: _isSelected[slot] == true
//                         ? widget.selectedTextColor
//                         : widget.selectedFillColor)),
//             fillColor: _isSelected[slot] == true
//                 ? widget.selectedFillColor
//                 : (widget.unSelectedFillColor ??
//                     widget.selectedFillColor.withOpacity(0.3)),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//       )
//     ]);
//   }
// }

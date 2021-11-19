import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final List<InlineSpan> inlineSpans;
  final TextAlign textAlign;

  const StyledText({
    Key? key,
    @required this.inlineSpans = const [],
    this.textAlign = TextAlign.left,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      
      textAlign: textAlign,
      text: TextSpan(text: '', children: inlineSpans),
    );
  }
}

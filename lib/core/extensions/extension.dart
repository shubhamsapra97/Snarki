

import 'package:intl/intl.dart';

extension DateParsing on DateTime{
 
  String get abbrDate{
    return DateFormat.yMMMd().format(this);
  }
}

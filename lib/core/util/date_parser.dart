import 'package:intl/intl.dart';

const format = 'MM/dd/yyyy hh:mm a';

String formatDate(DateTime dateTime) => DateFormat(format).format(dateTime);
DateTime parseDate(String dateTime) => DateFormat(format).parse(dateTime);

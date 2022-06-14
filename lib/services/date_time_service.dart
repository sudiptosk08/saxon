import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saxonmarket/views/global_components/k_date_time_modal_content.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeService {
  static convert(dateTime, {bool isDate = true, bool isLongDate = false, bool isDateWithTime = false, bool isCustomDateFormat = false}) {
    // Format:
    // var utcFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    var dateFormat = DateFormat('yyyy-MM-dd');
    var customDateFormat = DateFormat('dd MMM');
    var longDateFormat = DateFormat("MMMM d, y ");
    var timeFormat = DateFormat('h:mma');

    DateTime parsedLocalDateTime;
    parsedLocalDateTime = DateTime.parse(dateTime.toString()).toLocal();

    if (isDate && !isLongDate && !isCustomDateFormat && !isDateWithTime) {
      return dateFormat.format(parsedLocalDateTime);
    } else if (isLongDate) {
      return longDateFormat.format(parsedLocalDateTime);
    } else if (isCustomDateFormat) {
      return customDateFormat.format(parsedLocalDateTime);
    } else if (isDateWithTime) {
      return longDateFormat.format(parsedLocalDateTime) + timeFormat.format(parsedLocalDateTime);
    } else {
      return timeFormat.format(parsedLocalDateTime);
    }
  }

  static timeAgoLocal(dateTime, {alwaysTimeAgo = false}) {
    if (!alwaysTimeAgo) {
      return DateTime.now().difference(DateTime.parse(dateTime)).inDays > 2
          ? DateFormat('MMM dd, yyyy h:mm a').format(DateTime.parse(dateTime).toLocal())
          : timeago.format(DateTime.parse(dateTime), allowFromNow: true);
    } else {
      return timeago.format(DateTime.parse(dateTime), allowFromNow: true);
    }
  }

  /*
  Date Picker Function
  */
  static Future<DateTime> pickDate(BuildContext context, {isFirstNow = false}) async {
    final DateTime? picked = Platform.isIOS
        ? await showModalBottomSheet<DateTime>(
            context: context,
            isDismissible: true,
            elevation: 5,
            isScrollControlled: true,
            backgroundColor: KColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            ),
            builder: (context) {
              return KDateTimeModalContent(isFirstNow: true);
            },
          )
        : await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1500),
            lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(primary: KColor.primary),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
    return picked!;
  }

  /*
  Time Picker Function
  */
  static Future pickTime(BuildContext context) async {
    dynamic picked = Platform.isIOS
        ? await showModalBottomSheet<DateTime>(
            context: context,
            isDismissible: true,
            elevation: 5,
            isScrollControlled: true,
            backgroundColor: KColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            ),
            builder: (context) {
              return KDateTimeModalContent(isFirstNow: true, isDate: false);
            },
          ) /* returns DateTime */
        : await showTimePicker(
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(primary: KColor.primary),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
            context: context,
            initialTime: TimeOfDay.now(),
          ); /* Returns TimeOfDay */
    return picked;
  }

//  TargetPlatform.android
}

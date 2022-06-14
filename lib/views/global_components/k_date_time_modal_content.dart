import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class KDateTimeModalContent extends StatelessWidget {
  final bool isDate, isFirstNow;
  const KDateTimeModalContent({this.isDate = true, this.isFirstNow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: <Widget>[
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 65,
                  height: 5,
                  decoration: BoxDecoration(color: KColor.grey200, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(25)))),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop()),
                CupertinoButton(child: Text('Done'), onPressed: () => Navigator.of(context).pop()),
              ],
            ),
          ),
          Divider(height: 0, thickness: 1),
          Expanded(
            child: Container(
              child: CupertinoDatePicker(
                initialDateTime: isFirstNow ? DateTime.now() : DateTime(1500),
                mode: isDate ? CupertinoDatePickerMode.date : CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime dateTime) {
                  print(dateTime);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

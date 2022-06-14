import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class KConfirmationDialogContent extends StatefulWidget {
  final Function()? onPressedCallback;
  final String? title;
  final bool titleShow;
  final String? dividerTitle;
  final String buttonTextYes;
  final String buttonTextNo;
  const KConfirmationDialogContent(
      {this.title, this.titleShow = false, this.dividerTitle, this.onPressedCallback, this.buttonTextYes = "Yes", this.buttonTextNo = "No"});

  @override
  _KConfirmationDialogContentState createState() => _KConfirmationDialogContentState();
}

class _KConfirmationDialogContentState extends State<KConfirmationDialogContent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: KColor.greybg,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.titleShow
              ? Column(
                  children: [
                    Text(widget.dividerTitle ?? '',
                        textAlign: TextAlign.center, style: KTextStyle.bodyText1.copyWith(color: KColor.black, fontWeight: FontWeight.bold)),
                    Divider(color: KColor.black54, thickness: 0.5),
                    SizedBox(width: KSize.getHeight(context, 14)),
                  ],
                )
              : Container(),
          Text(widget.title ?? '', style: KTextStyle.bodyText1.copyWith(color: KColor.white, fontWeight: FontWeight.normal)),
        ],
      ),
      actions: <Widget>[
        PlatformDialogAction(
          child: TextButton(
            onPressed: widget.onPressedCallback,
            style: TextButton.styleFrom(primary: KColor.white),
            child: Text(widget.buttonTextYes),
          ),
        ),
        PlatformDialogAction(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(primary: KColor.white),
            child: Text(widget.buttonTextNo),
          ),
        ),
      ],
    );

    // AlertDialog(
    //   content: Text(widget.titleContent),
    //   actions: <Widget>[
    //     TextButton(
    //       onPressed: widget.onPressedCallback,
    //       style: TextButton.styleFrom(primary: KColor.primary),
    //       child: Text(
    //         'Yes',
    //       ),
    //     ),
    //     TextButton(
    //       onPressed: () => Navigator.of(context).pop(false),
    //       style: TextButton.styleFrom(primary: KColor.primary),
    //       child: Text(
    //         'No',
    //       ),
    //     ),
    //   ],
    // );
  }
}

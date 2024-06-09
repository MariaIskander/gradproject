import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/constant.dart';
import 'package:kidzo_app/Re-usable_Component/customtextbutton.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(
      {super.key, this.appinfo, this.isScreenLocked, this.lat, this.long});
  double? lat, long;
  List? appinfo;
  bool? isScreenLocked;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
      ),
      body: Column(
        children: [
          CustomTextButton(onTap: null, textName: widget.lat.toString()),
          CustomTextButton(onTap: null, textName: widget.long.toString()),
          CustomTextButton(
              onTap: null, textName: widget.isScreenLocked.toString()),
        ],
      ),
    );
  }
}

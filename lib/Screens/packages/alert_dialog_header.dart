import 'package:flutter/material.dart';
import 'package:kidzo_app/Screens/packages/alert_dialog_service.dart';

class AlertDialogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: screenHeight * 0.4,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Image(
                  image: const AssetImage(""),
                  width: screenHeight * 0.15,
                )),
            Spacer(),
            _title(),
            Spacer(),
            _dismissButton(context),
            SizedBox(width: screenWidth * 0.025)
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      "App Opened!!!!",
    );
  }

  Widget _dismissButton(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return IconButton(
      color: Colors.white,
      onPressed: () async {
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(
        Icons.close,
        size: screenHeight * 0.04,
      ),
    );
  }
}

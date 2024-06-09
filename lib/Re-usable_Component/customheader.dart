// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/customtextbutton.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({
    super.key,
    this.containerHeight,
    this.isRequiredDesscriptionName = false,
    required this.headerName,
    this.desscriptionName,
    this.heightBetweenTheHeaderAndDesc = 0.048,
    this.paddingAllSizeHeight = 0.048,
    this.onTapHeadName,
    this.onLongTapDesscriptionName,
    this.onLongTapHeadName,
    this.onTapDesscriptionName,
  });

  final String headerName;
  bool isRequiredDesscriptionName;
  String? desscriptionName;
  num paddingAllSizeHeight;
  num heightBetweenTheHeaderAndDesc;
  double? containerHeight;
  void Function()? onTapHeadName;
  void Function()? onTapDesscriptionName;
  void Function()? onLongTapDesscriptionName;
  void Function()? onLongTapHeadName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight ?? double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(18, 69, 89, 1),
            Color.fromRGBO(18, 69, 89, 1)
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
            MediaQuery.of(context).size.height * paddingAllSizeHeight),
        child: Column(
          children: [
            CustomTextButton(
              onLongTap: onLongTapHeadName ?? () {},
              onTap: onTapHeadName ?? () {},
              textName: headerName,
              isBold: true,
              textColor: Colors.white,
              textFontSize: 30,
              alignment: Alignment.topCenter,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  heightBetweenTheHeaderAndDesc,
            ),
            isRequiredDesscriptionName
                ? CustomTextButton(
                    onLongTap: onLongTapDesscriptionName ?? () {},
                    onTap: onTapDesscriptionName ?? () {},
                    textName: desscriptionName ?? '',
                    isBold: true,
                    textColor: Colors.white,
                    textFontSize: 30,
                    alignment: Alignment.topCenter,
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }
}

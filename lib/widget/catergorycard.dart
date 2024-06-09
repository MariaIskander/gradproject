import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/constant.dart';
import 'package:kidzo_app/Re-usable_Component/customtextbutton.dart';

class CategoryCard extends StatefulWidget {
  final String svgScr;
  final String title;
  final void Function()? onTap;

  const CategoryCard({
    super.key,
    required this.svgScr,
    required this.title,
    required this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: appColor,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.018,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                widget.svgScr,
                width: 140,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            CustomTextButton(
              onTap: null,
              textName: widget.title,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}

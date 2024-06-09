

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:kidzo_app/Re-usable_Component/customsmallButton.dart';

class TTextFiled extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const TTextFiled(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Color(0xff124559),
                fontWeight: FontWeight.normal,
                fontSize: 20),
          ),
          Container(
              
              margin: EdgeInsets.only(top: 10.0),
              height: 52,
              color: Color.fromARGB(255, 240, 235, 235),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        readOnly: widget==null?false:true,
                    controller: controller,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff124559),
                      
                    ),
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                          
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(146, 18, 69, 89),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff124559),
                          width: 0,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff124559),
                          width: 0,
                        ))
                        ),
                  )),
                  widget==null?Container():Container(child:widget),
                  SizedBox(width: 10,),
                  
                ],

                
              )),
        ],
      ),
    );
  }
}



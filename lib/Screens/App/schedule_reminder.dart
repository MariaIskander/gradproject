import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kidzo_app/Re-usable_Component/customsmallButton.dart';

import 'package:kidzo_app/Screens/login/imports.dart';
import 'package:kidzo_app/Screens/signup/imports.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff124559),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Color(0xff124559),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  topRow(),
                  Row(
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: TextStyle(
                            color: Color.fromARGB(174, 255, 255, 255),
                            fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                      SmallButton(name: "+ Add Task", onTap: (){} )
                    ],
                  ),
                  Container(
                    child: DatePicker(DateTime.now(),
                        height: 90,
                        width: 60,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Color.fromARGB(255, 249, 167, 161),
                        selectedTextColor: Colors.white,
                        dayTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                        monthTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                        dateTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18), onDateChange: (date) {
                      _selectedDate = date;
                    }),
                    
                  ),
                  
                ],
              ),
            ),
            splitsWidget(),
            splitsWidget(),
            splitsWidget(),
            splitsWidget(),
            splitsWidget(),
          ],
        ),
      ),
    );
  }
}

class splitsWidget extends StatelessWidget {
  const splitsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                "13:00",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              lineGen(
                lines: [20.0, 30.0, 40.0, 10.0],
              ),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: Color(0xff124559),
            child: Container(
              color: Color(0xffD9D9D9),
              margin: EdgeInsets.only(left: 4.0),
              padding: EdgeInsets.only(left: 15, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.025,
                    child: Row(
                      children: <Widget>[
                        Text("13:00 - 14:00"),
                        VerticalDivider(),
                        Text("Blue str,21"),
                      ],
                    ),
                  ),
                  Text(
                    "English Lesson",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class lineGen extends StatelessWidget {
  final lines;
  const lineGen({
    super.key,
    this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          4,
          (index) => Container(
            margin: EdgeInsets.symmetric(vertical: 14),
            width: lines[index],
            height: 2.0,
            color: Color(0xffD9D9D9),
          ),
        ));
  }
}

class topRow extends StatelessWidget {
  const topRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Schedule",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Reminder",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(174, 255, 255, 255),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

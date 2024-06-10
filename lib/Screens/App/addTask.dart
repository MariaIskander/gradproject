import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:kidzo_app/Re-usable_Component/addtasktextfiled.dart';
import 'package:kidzo_app/Re-usable_Component/customsmallButton.dart';
import 'package:kidzo_app/Screens/login/imports.dart';
import 'package:kidzo_app/Services/NotificationServices.dart';
import 'package:permission_handler/permission_handler.dart';

class AddTaskPAge extends StatefulWidget {
  const AddTaskPAge({Key? key}) : super(key: key);

  @override
  State<AddTaskPAge> createState() => _AddTaskPAgeState();
}

class _AddTaskPAgeState extends State<AddTaskPAge> {
  final TextEditingController _nameController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay startTimeOfDay = TimeOfDay.now();

  var _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  var _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Add Task",
                  style: TextStyle(
                      color: Color(0xff124559),
                      fontWeight: FontWeight.w500,
                      fontSize: 29),
                ),
                TTextFiled(
                    title: "Title", hint: "Enter title here", widget: null),
                SizedBox(
                  height: 10,
                ),
                TTextFiled(
                    title: "Note", hint: "Enter note here", widget: null),
                SizedBox(
                  height: 10,
                ),
                TTextFiled(
                    title: "Date",
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                        onPressed: () async {
                          DateTime? _pickerDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now());
                          if (_pickerDate != null)
                            setState(() {
                              _selectedDate = _pickerDate;
                              print(_selectedDate);
                            });
                          else {
                            print("it's null or something is wrong");
                          }
                        },
                        icon: Icon(Icons.calendar_today_outlined))),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TTextFiled(
                            title: "Start Time",
                            hint: _startTime,
                            widget: IconButton(
                                onPressed: () async {
                                  var pickedTime = await showTimePicker(
                                    initialEntryMode: TimePickerEntryMode.input,
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  print('the picked time is $pickedTime');

                                  setState(() {
                                    _startTime = pickedTime!.format(context);
                                    startTimeOfDay = pickedTime;
                                  });
                                },
                                icon: Icon(Icons.access_alarm_outlined)))),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: TTextFiled(
                            title: "End Time",
                            hint: _endTime,
                            widget: IconButton(
                                onPressed: () async {
                                  var pickedTime = await showTimePicker(
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                      context: context,
                                      initialTime: TimeOfDay.now());

                                  setState(() {
                                    _endTime = pickedTime!.format(context);
                                  });
                                },
                                icon: Icon(Icons.access_alarm_outlined)))),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: SmallButton(
                      name: "Create Task",
                      onTap: () async {
                        if (await Permission.notification.request().isGranted) {
                          // NotificationService().scheduleNotification(
                          //     title: 'Scheduled Notification',
                          //     body: '${DateTime.now()}',
                          //     scheduledNotificationDateTime: DateTime(
                          //       DateTime.now().year,
                          //       DateTime.now().month,
                          //       DateTime.now().day,
                          //       startTimeOfDay.hour,
                          //       startTimeOfDay.minute,
                          //     ));
                          NotificationService().scheduleNotification(
                              title: 'Scheduled Notification',
                              body: '${DateTime.now()}',
                              scheduledNotificationDateTime:
                                  DateTime.now().add(Duration(seconds: 1)));
                        } else {
                          print("access denied");
                        }
                        //   NotificationService().showNotification(body: 'ahmad');
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

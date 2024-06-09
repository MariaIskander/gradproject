import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidzo_app/Re-usable_Component/addtasktextfiled.dart';
import 'package:kidzo_app/Re-usable_Component/customsmallButton.dart';

class AddTaskPAge extends StatefulWidget {
  
  const AddTaskPAge({Key? key}) : super(key: key);

  @override
  State<AddTaskPAge> createState() => _AddTaskPAgeState();
}

class _AddTaskPAgeState extends State<AddTaskPAge> {
  final TextEditingController _nameController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  
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
              TTextFiled(title: "Note", hint: "Enter note here", widget: null),
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
                              onPressed: () {
                                 var _pickerTime;
                                bool isStartTime = false ;
                                var pickedTime = showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                    context: context,
                                    initialTime:
                                        TimeOfDay(hour: 9, minute: 10));
                                        String _formatedTime = _pickerTime.format(context);
                                        if (pickedTime == null){
                                          print("time cancled");
                                        }
                                        else if ( isStartTime ==true){
                                          _startTime =_formatedTime;
                                        }
                                        else if (isStartTime == false){
                                          _endTime = _formatedTime;
                                        }
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
                                 var _pickerTime;
                                bool isStartTime = false ;
                                var pickedTime = showTimePicker(
                                  initialEntryMode: TimePickerEntryMode.input,
                                    context: context,
                                    initialTime:
                                        TimeOfDay(hour: 9, minute: 10));
                                        String _formatedTime = _pickerTime.format(context);
                                        if (pickedTime == null){
                                          print("time cancled");
                                        }
                                        else if ( isStartTime ==true){
                                          _startTime =_formatedTime;
                                        }
                                        else if (isStartTime == false){
                                          _endTime = _formatedTime;
                                        }
                              
                              },
                              icon: Icon(Icons.access_alarm_outlined)))),
                             
                ],
              ),
              SizedBox(height: 40,),
               Center(child: SmallButton(name: "Create Task", onTap: ()=>null))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/constant.dart';
import 'package:kidzo_app/Screens/App/addTask.dart';



class SmallButton extends StatelessWidget{
  final String name;
  final Function()? onTap;
  const SmallButton({Key? key , required this.name , required this.onTap }) : super (key : key);

  @override 
  Widget build(BuildContext context){
    return Container(
      width: 150,
      height: 70,
      color: Color.fromARGB(255, 255, 255, 255),
      child: ElevatedButton(
        
        onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AddTaskPAge(
                               
                              )));
        },
        
        child: Center(child: Text(name ,style: TextStyle(color: kPrimaryColor , fontWeight: FontWeight.w700, fontSize: 16),)),
        
      ),
    );
  }
}
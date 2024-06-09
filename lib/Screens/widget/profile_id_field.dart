import 'package:flutter/material.dart';

class ParentId extends StatelessWidget {
  const ParentId({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 26, color: Colors.white),
      decoration: const InputDecoration(
          icon: Image(
            image: AssetImage('assets/images/profile2.png'),
          ),
          label: Text(
            'Parent ID',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(198, 255, 255, 255),
            ),
          )),
    );
  }
}

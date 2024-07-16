import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var nameController = TextEditingController();
  var age = TextEditingController();
  String namedata = "";
  String agedata = "";
  setdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('age', age.text);
  }

  getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('name');
    final String? age = prefs.getString('age');
    print(name);
    setState(() {
      namedata = name!;
    });
    print(age);
    setState(() {
      agedata = age!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(namedata),
          Text(agedata),
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: age,
          ),
          ElevatedButton(
              onPressed: () {
                setdata();
              },
              child: Text("set data")),
          ElevatedButton(
              onPressed: () {
                getdata();
              },
              child: Text("get data"))
        ],
      ),
    );
  }
}

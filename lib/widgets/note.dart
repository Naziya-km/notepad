import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notesCard extends StatefulWidget {
  final String items;
  final String itemss;
  const notesCard({super.key, required this.items, required this.itemss});

  @override
  State<notesCard> createState() => _notesCardState();
}

class _notesCardState extends State<notesCard> {
  List<String> items = [];
  List<String> itemss = [];

  // String title = "";
  // String notes = "";
  // getdata() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? action = prefs.getString('action');
  //   final String? actions = prefs.getString('actions');

  //   setState(() {
  //     title = action!;
  //     notes = actions!;
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getdata();
  // }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            widget.itemss,
            style: TextStyle(fontSize: 45),
          ),
          Text(
            widget.items,
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    );
  }
}

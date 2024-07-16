import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notesCard extends StatefulWidget {
  final String items;
  const notesCard({super.key, required this.items});

  @override
  State<notesCard> createState() => _notesCardState();
}

class _notesCardState extends State<notesCard> {
  List<String> items = [];
  String title = "";
  getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('action');
    setState(() {
      title = action!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Text(widget.items),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: 200,
      ),
    );
  }
}

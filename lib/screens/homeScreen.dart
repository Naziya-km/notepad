import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notesapp/widgets/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var titlecontroller = TextEditingController();
  var notescontroller = TextEditingController();

  @override
  List title = [];
  List notes = [];
  List<String> addednotes = [];
  List<String> addedtitle = [];

  setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('titles', addednotes);
    await prefs.setStringList('notes', addedtitle);
  }

  getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? data = prefs.getStringList('titles');
    final List<String>? datas = prefs.getStringList('notes');
    setState(() {
      title = data!;
      notes = datas!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (AppBar(
          title: Center(
            child: Row(
              children: [
                Text(style: TextStyle(fontWeight: FontWeight.bold), "NOTES"),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Icon(Icons.note_alt),
                  onTap: () {
                    getdata();
                  },
                )
              ],
            ),
          ),
        )),
        backgroundColor: Color.fromARGB(255, 6, 15, 7),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 13, 144, 35),
          tooltip: 'Increment',
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                actions: <Widget>[
                  TextField(
                    decoration: InputDecoration(label: Text("title")),
                    controller: titlecontroller,
                  ),
                  TextField(
                      controller: notescontroller,
                      decoration: InputDecoration(label: Text("notes"))),
                  TextButton(
                    onPressed: () async {
                      addedtitle.add(titlecontroller.text);
                      addednotes.add(notescontroller.text);
                      setdata();

                      Navigator.of(ctx).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.green,
                        child: const Text("okay"),
                      ),
                    ),
                  ),
                ],
              ),
            );
            // setdata();
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        body: title.isEmpty
            ? Center(child: CircularProgressIndicator())
            : MasonryGridView.builder(
                itemCount: title.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) =>
                    notesCard(items: title[index], itemss: notes[index])));
  }
}

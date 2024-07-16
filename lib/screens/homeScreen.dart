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
  // void initState() {
  //   getdata();
  //   // TODO: implement initState
  //   super.initState();
  // }

  var title = TextEditingController();

  List items = [];

  setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
  }

  getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? data = prefs.getStringList('items');
    setState(() {
      items = data!;
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
            // showDialog(
            //   context: context,
            //   builder: (ctx) => AlertDialog(
            //     actions: <Widget>[
            //       TextField(
            //         decoration: InputDecoration(label: Text("title")),
            //         controller: title,
            //       ),
            //       TextField(decoration: InputDecoration(label: Text("notes"))),
            //       TextButton(
            //         onPressed: () async {
            //           final SharedPreferences prefs =
            //               await SharedPreferences.getInstance();
            //           await prefs.setString('title', title.text);

            //           Navigator.of(ctx).pop();

            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Container(
            //             color: Colors.green,
            //             child: const Text("okay"),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
            setdata();
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        body: items.isEmpty
            ? Center(child: CircularProgressIndicator())
            : MasonryGridView.builder(
                itemCount: 3,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) =>
                    notesCard(items: items[index])));
  }
}

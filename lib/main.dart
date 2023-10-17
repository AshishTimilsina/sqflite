import 'package:flutter/material.dart';
import 'package:learn_sqflite/dbhelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final dbhelper = Databasehelper.instance;
  // insert function
  void insertdata() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: "ashish",
      Databasehelper.columnage: 22,
    };
    final id = await dbhelper.insert(row);
    print(id);
    print("Inserted Successfully");
  }

  // retrieving data from database funtion
  void querydata() async {
    var allrows = await dbhelper.queryall();
    for (var element in allrows) {
      print(element);
    }
  }

  // retreiving Specific data only
  void queryspecific() async {
    var allrows = await dbhelper.queryspecific(15);
    print(allrows);
  }

  // deleting Specific data
  void delete() async {
    var id = await dbhelper.deleteData(1);
    print(id);
  }

  // updating Specific data
  void update() async {
    var data = await dbhelper.updateData(4);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFLITE DATABASE'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: insertdata,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Insert'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: querydata,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 70, 123)),
              child: const Text('Query'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: queryspecific,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(64, 196, 255, 1)),
              child: const Text('Query Specific'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: update,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 152, 152, 62)),
              child: const Text('UPDATE'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: delete,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              child: const Text('DELETE'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //for bringing json

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Card"),
      ),
      body: Center(
        child: data.isEmpty
            ? Text("data is not available")
            : ListView.builder(
                itemBuilder: (context, key) {
                  return Card(
                    child: Row(
                      children: [
                        Image.network(data[key]['image'],
                            width: 200, height: 250, fit: BoxFit.contain),
                        Text(data[key]['title'].toString())
                      ],
                    ),
                  );
                },
                itemCount: data.length,
              ),
      ),
    );
  }

  Future<String> getData() async {
    var url = Uri.parse(
        "https://raw.githubusercontent.com/zeushahn/Test/main/movies.json");

    var response = await http.get(url);
    print(response.body);

    setState(() {
      var dbConvert = json.decode(utf8.decode(response.bodyBytes));
      List db = dbConvert['results'];
      data.addAll(db);
    });

    return response.body;
  }
}

import 'package:flutter/material.dart';
import 'package:practice/sliverview.dart';
import 'package:practice/screen/tabs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dataKey = new GlobalKey();
  List list = ["Data1", "Data2", "Data3"];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      appBar: new AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tabs(),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SliverView(),
                  ),
                );
              }),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
                height: 160.0, width: double.infinity, child: new Card()),
            new SizedBox(
                height: 160.0, width: double.infinity, child: new Card()),
            new SizedBox(
                height: 160.0, width: double.infinity, child: new Card()),
            // destination
            new SizedBox(
                height: 160.0,
                width: double.infinity,
                child: new Card(
                    key: dataKey, child: Center(child: new Text("data")))),
          ],
        ),
      ),
      bottomNavigationBar: new RaisedButton(
        onPressed: () => Scrollable.ensureVisible(dataKey.currentContext),
        child: new Text("Scroll to data"),
      ),
    );
  }
}

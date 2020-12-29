import 'package:flutter/material.dart';

class SliverView extends StatefulWidget {
  @override
  _SliverViewState createState() => _SliverViewState();
}

class _SliverViewState extends State<SliverView> {
  final dataKey = new GlobalKey();
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                bottom: TabBar(
                  tabs: [
                    GestureDetector(
                      child: Tab(
                        text: "Tab1",
                      ),
                      onTap: () =>
                          Scrollable.ensureVisible(dataKey.currentContext),
                    ),
                    GestureDetector(
                      child: Tab(
                        text: "Tab2",
                      ),
                      onTap: () =>
                          Scrollable.ensureVisible(dataKey.currentContext),
                    ),
                    GestureDetector(
                      child: Tab(
                        text: "Tab3",
                      ),
                      onTap: () =>
                          Scrollable.ensureVisible(dataKey.currentContext),
                    ),
                    GestureDetector(
                      child: Tab(
                        text: "Tab4",
                      ),
                      onTap: () =>
                          Scrollable.ensureVisible(dataKey.currentContext),
                    ),
                  ],
                ),
              ),
            ];
          },
          // body: TabBarView(
          //   children: [
          //     Text('Text1'),
          //     Text('Text2'),
          //     Text('Text3'),
          //     Text('Text4'),
          //   ],
          // ),
          body: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new SizedBox(
                    height: 160.0,
                    width: double.infinity,
                    child: new Card(
                      child: Center(
                        child: Text("1"),
                      ),
                    )),
                new SizedBox(
                    height: 160.0,
                    width: double.infinity,
                    child: new Card(
                      child: Center(
                        child: Text("2"),
                      ),
                    )),
                new SizedBox(
                    height: 160.0,
                    width: double.infinity,
                    child: new Card(
                      child: Center(
                        child: Text("3"),
                      ),
                    )),
                new SizedBox(
                    height: 160.0,
                    width: double.infinity,
                    child: new Card(
                      child: Center(
                        child: Text("4"),
                      ),
                    )),
                new SizedBox(
                    height: 160.0,
                    width: double.infinity,
                    child: new Card(
                      child: Center(
                        child: Text("5"),
                      ),
                    )),
                // destination
                new SizedBox(
                  height: 160.0,
                  width: double.infinity,
                  child: new Card(
                    key: dataKey,
                    child: Center(
                      child: new Text("target"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

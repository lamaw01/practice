import 'package:flutter/material.dart';
import 'package:practice/screen/pinscreen.dart';
import 'package:practice/screen/timeout.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// ignore: unused_import
import 'package:visibility_detector/visibility_detector.dart';

class ScrollWidget extends StatefulWidget {
  @override
  _ScrollWidgetState createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> list_name = [
    {
      "title": "Jollibee",
      "image": "assets/images/jollibee_header.jpg",
      "food1": {
        "name": "Chicken Joy",
        "price": "P 90.00",
      },
      "food2": {
        "name": "Spaghetti",
        "price": "P 75.00",
      },
      "food3": {
        "name": "Burger Steak",
        "price": "P 50.00",
      }
    },
    {
      "title": "Greenwich",
      "image": "assets/images/greenwich_header.jpg",
      "food1": {
        "name": "Pineapple Pizza",
        "price": "P 150.00",
      },
      "food2": {
        "name": "Italian Pizza",
        "price": "P 75.00",
      },
      "food3": {
        "name": "Pepper Pizza",
        "price": "P 200.00",
      }
    },
    {
      "title": "McDonalds",
      "image": "assets/images/mcdonalds_header.jpg",
      "food1": {
        "name": "Burger",
        "price": "P 45.00",
      },
      "food2": {
        "name": "Fries",
        "price": "P 35.00",
      },
      "food3": {
        "name": "McFloat",
        "price": "P 25.00",
      }
    },
    {
      "title": "Chowking",
      "image": "assets/images/chowking_header.jpg",
      "food1": {
        "name": "Chowfan",
        "price": "P 65.00",
      },
      "food2": {
        "name": "Noodles",
        "price": "P 40.00",
      },
      "food3": {
        "name": "Shiopao",
        "price": "P 30.00",
      }
    },
    {
      "title": "BigBys",
      "image": "assets/images/bigbys_header.jpg",
      "food1": {
        "name": "Belly Buster",
        "price": "P 165.00",
      },
      "food2": {
        "name": "Chicken Corn",
        "price": "P 100.00",
      },
      "food3": {
        "name": "Longganisa",
        "price": "P 65.00",
      }
    },
  ];
  final scrollController = ScrollController();
  TabController tabController;
  ItemScrollController _controller;
  int selectedIndex = 0;

  void initState() {
    super.initState();
    startKeepAlive();
    tabController = TabController(
      initialIndex: selectedIndex,
      length: list_name.length,
      vsync: this,
    );
    _controller = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: selectedIndex,
        length: list_name.length,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                primary: true,
                pinned: true,
                floating: true,
                expandedHeight: 200,
                forceElevated: innerBoxIsScrolled,
                // title: Text('hello'),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: tabController,
                    onTap: (index) => _controller.jumpTo(index: index),
                    isScrollable: true,
                    tabs: List<Widget>.generate(
                      list_name.length,
                      (int index) {
                        // print(index);
                        return Tab(
                          iconMargin: EdgeInsets.symmetric(horizontal: 16.0),
                          // text: list_name[index]['title'] st,
                          child: Text(
                            list_name[index]['title'],
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: ScrollablePositionedList.builder(
              itemScrollController: _controller,
              itemCount: list_name.length,
              itemBuilder: (context, index) {
                return VisibilityDetector(
                  onVisibilityChanged: (VisibilityInfo info) {
                    if (info.visibleFraction == 1)
                      setState(() {
                        selectedIndex = index;
                        print(selectedIndex);
                        tabController.animateTo(selectedIndex);
                      });
                  },
                  key: Key(index.toString()),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              list_name[index]['title'],
                              style: TextStyle(fontSize: 20.0),
                              // key: dataKey,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list_name[index]['food1']['name'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  list_name[index]['food1']['price'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list_name[index]['food2']['name'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  list_name[index]['food2']['price'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list_name[index]['food3']['name'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  list_name[index]['food3']['price'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.star),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PinScreen(),
            ),
          );
        },
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.pink, // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

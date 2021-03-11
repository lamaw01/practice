import 'package:flutter/material.dart';
import 'package:practice/screen/timeout.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// ignore: unused_import
import 'package:visibility_detector/visibility_detector.dart';

class OldScrollWidget extends StatefulWidget {
  @override
  _OldScrollWidgetState createState() => _OldScrollWidgetState();
}

class _OldScrollWidgetState extends State<OldScrollWidget>
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
  ItemPositionsListener itemPositionsListener;
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
    itemPositionsListener = ItemPositionsListener.create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: selectedIndex,
          length: list_name.length,
          child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  // primary: true,
                  // pinned: true,
                  floating: true,
                  expandedHeight: 200,
                  forceElevated: innerBoxIsScrolled,
                  title: Text('Menu'),
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
                itemPositionsListener: itemPositionsListener,
                itemScrollController: _controller,
                itemCount: list_name.length,
                itemBuilder: (context, index) {
                  // print(itemPositionsListener.itemPositions.value.first.index);
                  return VisibilityDetector(
                    onVisibilityChanged: (VisibilityInfo info) {
                      // ignore: unused_local_variable
                      var visiblePercentage = info.visibleFraction * 100;
                      // debugPrint(
                      //     'Widget ${info.key} is $visiblePercentage% visible');
                      // if (info.visibleFraction == 1)
                      //   setState(() {
                      //     selectedIndex = index;
                      //     print(selectedIndex);
                      //     tabController.animateTo(selectedIndex);
                      //   });
                      // print(
                      //     'index first ${itemPositionsListener.itemPositions.value.first.index}');
                      // print(
                      //     'index last ${itemPositionsListener.itemPositions.value.last.index}');
                      // print(
                      //     'trailing ${itemPositionsListener.itemPositions.value.last.itemTrailingEdge.sign}');
                      // if (itemPositionsListener.itemPositions.value.first.index >=
                      //     1) {
                      //   setState(() {
                      //     // selectedIndex = index;
                      //     selectedIndex = itemPositionsListener
                      //         .itemPositions.value.first.index;
                      //     print(selectedIndex);
                      //     tabController.animateTo(selectedIndex);
                      //   });
                      // }
                      print(
                          'KANI ${itemPositionsListener.itemPositions.value.first.index}');
                      setState(() {
                        // selectedIndex = index;
                        selectedIndex = itemPositionsListener
                            .itemPositions.value.first.index;

                        tabController.animateTo(selectedIndex);
                      });
                      // if (visiblePercentage >= 0.0 &&
                      //     visiblePercentage >= 100.0) {
                      //   print(info.key.toString());
                      //   setState(() {
                      //     selectedIndex = index;
                      //     tabController.animateTo(selectedIndex);
                      //     print(selectedIndex);
                      //   });
                      // }
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

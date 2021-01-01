import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';

class ScrollWidget extends StatefulWidget {
  @override
  _ScrollWidgetState createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget> {
  final scrollController = ScrollController();
  TabController tabController;
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> list_name = [
    {
      "title": "Jollibee",
      "image": "assets/images/jollibee_header.jpg",
      "food1": {
        "name": "Chicken Joy",
        "price": "90.0",
      },
      "food2": {
        "name": "Spaghetti",
        "price": "75.0",
      },
      "food3": {
        "name": "Burger Steak",
        "price": "50.0",
      }
    },
    {
      "title": "Greenwich",
      "image": "assets/images/greenwich_header.jpg",
      "food1": {
        "name": "Pineapple Pizza",
        "price": "150.0",
      },
      "food2": {
        "name": "Italian Pizza",
        "price": "75.0",
      },
      "food3": {
        "name": "Pepper Pizza",
        "price": "220.0",
      }
    },
    {
      "title": "McDonalds",
      "image": "assets/images/mcdonalds_header.jpg",
      "food1": {
        "name": "Burger",
        "price": "45.0",
      },
      "food2": {
        "name": "Fries",
        "price": "35.0",
      },
      "food3": {
        "name": "McFloat",
        "price": "25.0",
      }
    },
    {
      "title": "Chowking",
      "image": "assets/images/chowking_header.jpg",
      "food1": {
        "name": "Chowfan",
        "price": "65.0",
      },
      "food2": {
        "name": "Noodles",
        "price": "40.0",
      },
      "food3": {
        "name": "Shiopao",
        "price": "30.0",
      }
    },
    {
      "title": "BigBys",
      "image": "assets/images/bigbys_header.jpg",
      "food1": {
        "name": "Belly Buster",
        "price": "165.0",
      },
      "food2": {
        "name": "Chicken Corn",
        "price": "100",
      },
      "food3": {
        "name": "Longganisa",
        "price": "65.0",
      }
    },
  ];

  ItemScrollController _controller;
  void initState() {
    super.initState();
    _controller = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: list_name.length,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                bottom: TabBar(
                  onTap: (index) => _controller.jumpTo(index: index),
                  isScrollable: true,
                  tabs: List<Widget>.generate(list_name.length, (int index) {
                    print(index);
                    return Tab(
                      iconMargin: EdgeInsets.symmetric(horizontal: 16.0),
                      // text: list_name[index]['title'] st,
                      child: Text(
                        list_name[index]['title'],
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ];
          },
          body: Container(
            child: ScrollablePositionedList.builder(
              itemScrollController: _controller,
              itemCount: list_name.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            list_name[index]['title'],
                            style: TextStyle(fontSize: 24.0),
                            // key: dataKey,
                          ),
                          SizedBox(
                            height: 22.0,
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
                            height: 22.0,
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
                            height: 22.0,
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

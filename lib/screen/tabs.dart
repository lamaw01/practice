import 'package:flutter/material.dart';
import 'package:practice/screen/order.dart';
import 'package:practice/screen/scrollview.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
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
        "price": "200.0",
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

  SwiperController _scrollController = new SwiperController();

  TabController tabController;

  int currentindex2 = 0; // for swiper index initial

  int selectedIndex = 0; // for tab

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: selectedIndex,
      length: list_name.length,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {
        print(tabController.index);
        _scrollController.move(tabController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: list_name.length,
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 50),
                  height: 120,
                  child: DefaultTabController(
                    length: list_name.length,
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 35.0),
                      child: Material(
                        child: TabBar(
                          onTap: (index) => _scrollController.move(index),
                          controller: tabController,
                          isScrollable: true,
                          indicatorColor: Color.fromRGBO(0, 202, 157, 1),
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontSize: 18),
                          unselectedLabelColor: Colors.black,
                          tabs: List<Widget>.generate(list_name.length,
                              (int index) {
                            return new Tab(text: list_name[index]['title']);
                          }),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: new Swiper(
                  onIndexChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                      tabController.animateTo(index);
                      currentindex2 = index;
                      print(index);
                    });
                  },
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                      tabController.animateTo(index);
                      currentindex2 = index;
                      print(index);
                    });
                  },
                  duration: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return new Swiper(
                      duration: 2,
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return VisibilityDetector(
                          key: Key(index.toString()),
                          child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 500,
                              width: double.infinity,
                              color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 200,
                                      minHeight: 200,
                                      maxWidth: 200,
                                      maxHeight: 200,
                                    ),
                                    child: Image(
                                      image:
                                          AssetImage(list_name[index]['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    list_name[index]['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Order(
                                            amountVal: list_name[index]['food1']
                                                ['price'],
                                            menuName: list_name[index]['food1']
                                                ['name'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              list_name[index]['food1']['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              list_name[index]['food1']
                                                  ['price'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Order(
                                            amountVal: list_name[index]['food2']
                                                ['price'],
                                            menuName: list_name[index]['food2']
                                                ['name'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              list_name[index]['food2']['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              list_name[index]['food2']
                                                  ['price'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Order(
                                            amountVal: list_name[index]['food3']
                                                ['price'],
                                            menuName: list_name[index]['food3']
                                                ['name'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              list_name[index]['food3']['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              list_name[index]['food3']
                                                  ['price'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          onVisibilityChanged: (VisibilityInfo info) {
                            if (info.visibleFraction == 1)
                              setState(() {
                                selectedIndex = index;
                                tabController.animateTo(index);
                                currentindex2 = index;
                                print(index);
                              });
                          },
                        );
                      },
                      itemCount: list_name.length,
                    );
                  },
                  itemCount: list_name.length,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.forward),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScrollWidget()));
          },
        ),
      ),
    );
  }
}

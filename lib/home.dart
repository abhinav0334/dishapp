
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dishapp/TabCategory.dart';
import 'package:dishapp/dish.dart';
import 'package:http/http.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}
class HomeState extends State<Home> with TickerProviderStateMixin{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<TabCategory> tab_list;
  List<TabCategory> tab_menu;
  List<Dish> tab_dishes;
  // List<List<Dish>> all_dish = new List();
  TabController _cardController;
  TabPageSelector _tabPageSelector;
  List<Tab> myList = new List();
  int count = 0;
  var appbar_height = AppBar().preferredSize.height;
  

  // Future<List<TabCategory>> getData() async {
  Future<List> getData() async{
    String link =
          // "https://newsapi.org/v2/top-headlines?country=in&apiKey=API_KEY";
          "http://www.mocky.io/v2/5dfccffc310000efc8d2c1ad";
    Response res =  await get(link);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      String str = res.body.toString();
      var json_data = json.decode(str.substring(1, str.length - 1)); 
      var rest = json_data["table_menu_list"];
      tab_list = rest.map<TabCategory>((json) => TabCategory.fromJson(json)).toList();
    }
    myList.clear();
    tab_list.map((TabCategory){
      myList.add(new Tab(text: TabCategory.menu_category,));
    }).toList();
    _cardController = new TabController(vsync: this, length: myList.length);
    _tabPageSelector = new TabPageSelector(controller: _cardController);
    // print("List Size: ${tab_list[0].menu_category}");
    return tab_list;
    
  }
  @override
  void initState() {
    super.initState();
    // getData();
    getTabMenu();
  }
  void getTabMenu() async{
    // tab_menu = await getData();
    getData().then((val) => setState((){
      tab_menu = val;
    }));
  }
  void decrease(var index, var dish_index){
    setState(() {
      if(tab_menu[index].dishes[dish_index].count > 0){
        tab_menu[index].dishes[dish_index].count = tab_menu[index].dishes[dish_index].count - 1;
        count = count - 1;
      }
    });
  }
  void increase(var index, var dish_index){
    setState(() {
      count++;
      tab_menu[index].dishes[dish_index].count = tab_menu[index].dishes[dish_index].count + 1;
    });
  }

  Widget getTabWidget(List<TabCategory> list){
    var padding = MediaQuery.of(context).padding;
    return Container(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 50,
            child: new TabBar(
              controller: _cardController,
              indicatorColor: Colors.pink,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.black,
              isScrollable: true,
              tabs: myList
              ),
          ),
          new Container(
            height: MediaQuery.of(context).size.height - appbar_height - 50 - padding.top,
            child: new TabBarView(
              controller: _cardController,
              children: list.isEmpty
                ? <Widget>[]
                : list.map((TabCategory){
                  var index = list.indexOf(TabCategory);
                  tab_dishes = TabCategory.dishes;
                  return new Card(
                    child: new SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: new BoxConstraints(),
                        child: new Column(
                          children: tab_dishes.map((Dish){
                            var dish_index = tab_dishes.indexOf(Dish);
                            return new Container(
                              padding: EdgeInsets.all(10),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                         Text(Dish.dish_name, style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                         new Container(
                                           child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(Dish.dish_currency + " " + Dish.dish_price.toString(), style: new TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                              Text(Dish.dish_calories.toString() + " calories", style: new TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                                            ],
                                           )
                                         ),
                                         new Container(padding: EdgeInsets.only(top: 10), child: Text(Dish.dish_description, style: new TextStyle(fontSize: 16,),)),
                                         new Container(
                                            padding: EdgeInsets.only(top: 10),
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            height: 60,
                                            child: FlatButton(
                                            onPressed: () => {},
                                            color: Colors.green,
                                            textColor: Colors.white,
                                            padding: EdgeInsets.all(10.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),),
                                            child: Row( // Replace with a Row for horizontal icon + text
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                new GestureDetector(
                                                  onTap: () {
                                                    decrease(index, dish_index);
                                                  },
                                                  child: Text("-", style: new TextStyle(fontSize: 30),),
                                                ),
                                                Text(Dish.count.toString(), style: new TextStyle(fontSize: 20),),
                                                new GestureDetector(
                                                  onTap:() {
                                                    increase(index, dish_index);
                                                  },
                                                  child: Text("+", style: new TextStyle(fontSize: 30),)
                                                )
                                              ],
                                            ),
                                           ),
                                         ),
                                         Dish.addoncats.length > 0 ?
                                            Container(padding: EdgeInsets.only(top: 5), child: Text("Customizations Available", style: new TextStyle(fontSize: 16, color: Colors.red),))
                                            : Container()
                                      ]
                                    ),
                                  ),
                                  new Container(
                                    child: Image.network(Dish.dish_image, width: 70, height: 70, fit: BoxFit.cover,),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        ),
                    ),
                  );
                }).toList(),
                
            ),
          )
        ],
      )
    );
    // }
  }

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
              title: Text("UNI Resto Cafe", style: new TextStyle(color: Colors.black,)),
              backgroundColor: Colors.white,
              actions: <Widget>[
                new Align(alignment: Alignment.center, child: new Text("My Orders", style: new TextStyle(fontSize: 18.0, color: Colors.black),),),
                new Stack(
                  children: <Widget>[
                    new Align(alignment: Alignment.center, child: new IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // setState(() {
                        //   count = 0;
                        // });
                      })),
                    count > 0 ? new Positioned(
                      right: 11,
                      top: 11,
                      child: new Container(
                        padding: EdgeInsets.all(2),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ) : new Container()
                  ]
                )
              ],
              leading: new IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
            ),
      body: tab_menu != null
                ? getTabWidget(tab_menu)
                : Center(child: CircularProgressIndicator())
      // body: FutureBuilder(
      //     future: getData(),
      //     builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      //       return snapshot.data != null
      //           ? getTabWidget(snapshot.data)
      //           : Center(child: CircularProgressIndicator());
            
      //     }),
    );
  }
}

class ChangeTitleAndLeading {
  final String title;
  // final Widget leading;

  ChangeTitleAndLeading({
    @required this.title,
    // @required this.leading
  }) :
    assert(title != null);
    // assert(leading != null);
}
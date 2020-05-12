import 'package:dishapp/TabCategory.dart';
import 'package:json_annotation/json_annotation.dart';

class Restaurant{
  String restaurant_name;
  String restaurant_image;
  List<TabCategory> tab_list;

  Restaurant(
    {
      this.restaurant_name,
      this.restaurant_image,
      this.tab_list
    }
  );
  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    restaurant_name: json["restaurant_name"],
    restaurant_image: json["restaurant_image"],
    tab_list: List<TabCategory>.from(json["table_menu_list"].map((x) => TabCategory.fromJson(x))),
  );
  Map<String, dynamic> toJson()=> {
    "restaurant_name": restaurant_name,
    "restaurant_image": restaurant_image,
    "tab_list": List<dynamic>.from(tab_list.map((x) => x.toJson())),
  };
}
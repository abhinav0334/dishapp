import 'package:json_annotation/json_annotation.dart';
import 'package:dishapp/dish.dart';

class TabCategory{
  String menu_category;
  String menu_category_id;
  String menu_category_image;
  List<Dish> dishes;

  TabCategory(
    {
      this.menu_category,
      this.menu_category_id,
      this.menu_category_image,
      this.dishes,
    }
  );
  factory TabCategory.fromJson(Map<String, dynamic> json) => TabCategory(
    menu_category: json["menu_category"] == null? null : json["menu_category"],
    menu_category_id: json["menu_category_id"],
    menu_category_image: json["menu_category_image"],
    dishes: List<Dish>.from(json["category_dishes"].map((x) => Dish.fromJson(x))),
  );
  Map<String, dynamic> toJson()=> {
    "menu_category": menu_category,
    "menu_category_id": menu_category_id,
    "menu_category_image": menu_category_image,
    "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
  };
}
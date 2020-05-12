import 'package:flutter/material.dart';
import 'package:dishapp/addoncat.dart';

class Dish{
  String dish_id;
  String dish_name;
  double dish_price;
  String dish_image;
  String dish_currency;
  double dish_calories;
  String dish_description;
  bool   dish_availability;
  int    dish_type;
  String next_url;
  List<AddonCat> addoncats;
  int count = 0;

  Dish(
    {
      this.dish_id,
      this.dish_name,
      this.dish_price,
      this.dish_image,
      this.dish_currency,
      this.dish_calories,
      this.dish_description,
      this.dish_availability,
      this.dish_type,
      this.next_url,
      this.addoncats,
      this.count,
    }
  );
  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
    dish_id: json["dish_id"] == null? null: json["dish_id"],
    dish_name: json["dish_name"],
    dish_price: json["dish_price"],
    dish_image: json["dish_image"],
    dish_currency: json["dish_currency"],
    dish_calories: json["dish_calories"],
    dish_description: json["dish_description"],
    dish_availability: json["dish_availability"],
    dish_type: json["dish_type"],
    next_url: json["next_url"],
    addoncats: List<AddonCat>.from(json["addonCat"].map((x) => AddonCat.fromJson(x))),
    count: 0
  );
  Map<String, dynamic> toJson() => {
    "dish_id": dish_id,
    "dish_name": dish_name,
    "dish_price": dish_price,
    "dish_image": dish_image,
    "dish_currency": dish_currency,
    "dish_calories": dish_calories,
    "dish_description": dish_description,
    "dish_availability": dish_availability,
    "dish_type": dish_type,
    "next_url": next_url,
    "addons": List<dynamic>.from(addoncats.map((x) => x.toJson()))
  };
}

import 'package:flutter/material.dart';
import 'package:dishapp/addon.dart';

class AddonCat {
  String addon_category;
  String addon_category_id;
  int addon_selection;
  String nexturl;
  List<Addon> addons;

  AddonCat (
    {
      this.addon_category,
      this.addon_category_id,
      this.addon_selection,
      this.nexturl,
      this.addons
    }
  );
  factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
    addon_category: json["addon_category"],
    addon_category_id: json["addon_category_id"],
    addon_selection: json["addon_selection"],
    nexturl: json["nexturl"],
    addons: List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x)))
  );
  Map<String, dynamic> toJson() =>{
    "addon_category": addon_category,
    "addon_category_id": addon_category_id,
    "addon_selection": addon_selection,
    "nexturl": nexturl,
    "addons": List<dynamic>.from(addons.map((x) => x.toJson()))
  };
}
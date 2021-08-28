import 'package:flutter/material.dart';

class Product {
  final String? title, image, color;

  Product({this.title, this.image, this.color});
}

List<Product> demoProducts = [
  Product(title: "Cabbage", image: "assets/images/img_1.png"),
  Product(title: "Broccoli", image: "assets/images/img_2.png"),
  Product(title: "Carrot", image: "assets/images/img_3.png"),
  Product(title: "Pakcoy", image: "assets/images/img_4.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
];

List<Product> newProducts = [
  Product(
      title: "CFC Home '22",
      image: "assets/images/cfc_home.png",
      color: '1F4799'),
  Product(
      title: "FCB Home '22",
      image: "assets/images/fcb_home.png",
      color: '6C000F'),
  Product(
      title: "JUFC Home '22",
      image: "assets/images/jufc_home.png",
      color: '0D0D0F'),
  Product(
      title: "MCFC Home '22",
      image: "assets/images/mcfc_home.jpeg",
      color: '6998E2'),
  Product(
      title: "MUFC Home '22",
      image: "assets/images/mufc_home.jpeg",
      color: 'DA1C2A'),
  Product(
      title: "RMFC Home '22",
      image: "assets/images/rmfc_home.png",
      color: 'C9C7CE'),
];

extension ColorExtension on String{
  toColor(){
    var hexColor=this;
    if(hexColor.length==6){
      hexColor='FF'+hexColor;
    }
    if(hexColor.length==8){
      return Color(int.parse('0x$hexColor'));
    }
  }
}

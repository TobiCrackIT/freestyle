import 'package:animation_2/controllers/home_controller.dart';
import 'package:animation_2/screens/home/components/cart_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants.dart';

class CardShortView extends StatelessWidget {
  const CardShortView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Cart",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                controller.cart.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: Hero(
                    tag: controller.cart[index].product!.title! + "_cartTag",
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage(controller.cart[index].product!.image!),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CartDetailsView(controller: controller))),
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              ),
              Positioned(
                top: -4,
                right: -1,
                child: Text(
                  controller.totalCartItems().toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

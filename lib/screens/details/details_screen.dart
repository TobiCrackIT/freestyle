import 'package:animation_2/components/fav_btn.dart';
import 'package:animation_2/components/price.dart';
import 'package:animation_2/constants.dart';
import 'package:animation_2/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../constants.dart';
import 'components/cart_counter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {Key? key, required this.product, required this.onProductAdd})
      : super(key: key);

  final Product product;
  final VoidCallback onProductAdd;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  String _cartTag ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: buildAppBar(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.37,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Hero(
                      tag: widget.product.title! + _cartTag,
                      child: Image.asset(widget.product.image!)),
                ),
                Positioned(
                  bottom: -60,
                  child: CartCounter(),
                )
              ],
            ),
          ),
          SizedBox(height: defaultPadding * 1.6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.title!,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
                Price(amount: "₦25,000.00"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding,vertical: defaultPadding/2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "This is an authentic jersey authorized by the EPL and we trust that you would like it even as you support your favourite team. We have taken extra steps to make sure you get the best and most affordable jersey without compromising on quality.",
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      height: 1.8,
                    ),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding,vertical: defaultPadding/2),
            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(primary: widget.product.color!.toColor(),),
                onPressed: () {
                  widget.onProductAdd();
                  setState(() {
                    _cartTag = '_cartTag';
                  });
                  Navigator.pop(context);
                },
                child: Text('Add to Cart'),
              ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(

      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Jersey",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        FavBtn(radius: 20),
        SizedBox(width: defaultPadding),
      ],
    );
  }
}

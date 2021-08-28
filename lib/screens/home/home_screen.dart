import 'package:animation_2/constants.dart';
import 'package:animation_2/controllers/home_controller.dart';
import 'package:animation_2/models/Product.dart';
import 'package:animation_2/screens/home/components/card_short_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../constants.dart';
import '../../models/Product.dart';
import '../details/details_screen.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  final controller = HomeController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      left: 0,
                      right: 0,
                      top: cartBarHeight - 20,
                      height: constraints.maxHeight - cartBarHeight + 20,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: defaultPadding,
                            right: defaultPadding,
                            top: defaultPadding / 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(defaultPadding * 1.5),
                            topRight: Radius.circular(defaultPadding * 1.5),
                          ),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: newProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                          ),
                          itemBuilder: (context, index) => ProductCard(
                            product: newProducts[index],
                            press: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        FadeTransition(
                                  opacity: animation,
                                  child: DetailsScreen(
                                    product: newProducts[index],
                                    onProductAdd: () {
                                      controller
                                          .addProductToCart(newProducts[index]);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      //height: cartBarHeight,
                      child:  Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(defaultPadding),
                          color: Color(0xffEAEAEA),
                          child: CardShortView(controller: controller),
                        ),
                      ),
                  ],
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

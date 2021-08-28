import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants.dart';
import 'rounded_icon_btn.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundIconBtn(
            iconData: Icons.add,
            press: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 4),
            child: Text(
              "1",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ),
          RoundIconBtn(
            iconData: Icons.remove,
            color: Colors.red,
            press: () {},
          ),

        ],
      ),
    );
  }
}
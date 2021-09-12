import 'package:animation_2/core/dropdown_item.dart';
import 'package:flutter/material.dart';

class CustomCategoryDropdown extends StatelessWidget {
  final DropDownItem? currentValue;
  final List<DropDownItem>? options;
  final Function(DropDownItem?)? onSelected;
  CustomCategoryDropdown({this.currentValue, this.options, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromRGBO(74, 21, 75, 0.15), width: 1),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4),
            color: Color.fromRGBO(74, 21, 75, 0.15),
          )
        ],
      ),
      padding: EdgeInsets.only(left: 16.0, top: 3, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              child: DropdownButton(
                focusColor: Theme.of(context).colorScheme.primary,
                isExpanded: true,
                dropdownColor: Colors.white,
                underline: Container(),
                items: options!.map(
                  (val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val.title!),
                    );
                  },
                ).toList(),
                value: currentValue,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 22,
                    color: Color.fromRGBO(111, 108, 110, 0.7),
                  ),
                ),
                onChanged: onSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

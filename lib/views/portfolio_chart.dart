import 'package:animation_2/constants.dart';
import 'package:animation_2/models/item_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PortfolioChart extends StatelessWidget {
  final List<ItemModel> items;
  PortfolioChart({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portfolio = <String, double>{};

    items.forEach(
      (element) => portfolio.update(
        element.category,
        (value) => value + element.amount,
        ifAbsent: () => element.amount,
      ),
    );

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 400.0,
        child: Column(
          children: [
            Expanded(
              child: PieChart(

                PieChartData(
                  centerSpaceRadius: 20,
                  sections: portfolio
                      .map((key, value) => MapEntry(
                          key,
                          PieChartSectionData(
                            color: getCategoryColor(key),
                            radius: 100.0,
                            value: value,
                            title: '\$${value.toStringAsFixed(2)}',
                          )))
                      .values
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: portfolio.keys
                  .map((e) => _Indicator(color: getCategoryColor(e), text: e))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicator({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

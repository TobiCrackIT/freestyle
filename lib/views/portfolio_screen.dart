import 'package:animation_2/core/portfolio_repository.dart';
import 'package:animation_2/models/item_model.dart';
import 'package:animation_2/views/portfolio_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late Future<List<ItemModel>> _porfolioItems;

  @override
  void initState() {
    super.initState();
    _porfolioItems = PortfolioRepository().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Tracker'),
      ),
      body: RefreshIndicator(
          child: FutureBuilder<List<ItemModel>>(
            future: _porfolioItems,
            builder: (context, snap) {
              if (snap.hasData) {
                final items = snap.data!;
                return ListView.builder(
                    itemCount: items.length + 1,
                    itemBuilder: (context, i) {
                      if (i == 0)
                        return PortfolioChart(
                          items: items,
                        );

                      final item = items[i - 1];
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 2.0,
                            color: getCategoryColor(item.category),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(item.name),
                          subtitle: Text(
                            '${item.category} • ${DateFormat.yMd().format(item.date)}',
                          ),
                          trailing: Text(
                            '\$${item.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black26),
                          ),
                        ),
                      );
                    });
              } else if (snap.hasError) {
                return Center(child: Text(snap.error.toString()));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          onRefresh: () async {
            _porfolioItems = PortfolioRepository().getItems();
            setState(() {

            });
          },
      ),
    );
  }
}

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

                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,width: 60,
                              decoration: BoxDecoration(
                                color: getCategoryColor(item.category),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Icon(getCategoryIcon(item.category),color: Colors.white,),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,style: TextStyle(fontSize: 16),),
                                    Text(
                                      '${item.category} • ${DateFormat.yMd().format(item.date)}',
                                      style: TextStyle(color: Colors.grey),
                                    )

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    '\$${item.amount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45),
                                  ),
                                )

                              ],
                            )),
                          ],

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

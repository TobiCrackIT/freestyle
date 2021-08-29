import 'dart:convert';
import 'dart:io';
import 'package:animation_2/models/failure.dart';
import 'package:animation_2/models/item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PortfolioRepository {
  static const String _baseURL = 'https://api.notion.com/v1';
  final http.Client _client;

  PortfolioRepository({http.Client? client})
      : _client = client ?? http.Client();

  Future<List<ItemModel>> getItems() async {
    try {
      final url =
          '$_baseURL/databases/${dotenv.env['NOTION_DATABASE_ID']}/query';
      final response = await _client.post(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader:
            'Bearer ${dotenv.env['NOTION_API_KEY']}',
        'Notion-Version': '2021-08-16'
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint(data.toString());
        var theList = (data['results'] as List)
            .map((e) => ItemModel.fromMap(e))
            .toList()
              ..sort((a, b) => b.date.compareTo(a.date));
        debugPrint('LENGTH: ${theList.length}');
        return theList;
      } else {
        throw Failure(message: 'ERROR: An error occurred');
      }
    } catch (e) {
      throw Failure(message: 'ERROR: ${e.toString()}');
    }
  }

  void dispose() {
    _client.close();
  }
}

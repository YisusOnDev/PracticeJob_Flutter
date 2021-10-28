import 'package:flutter/services.dart';
import 'dart:convert';

class _MenuProvider {
  List<dynamic> options = [];

  _MenuProvider();

  Future<List<dynamic>> loadData() async {
    final resp = await rootBundle.loadString('data/menu.json');
    Map dataMap = json.decode(resp);
    options = dataMap['routes'];

    return options;
  }
}

final menuProvider = _MenuProvider();

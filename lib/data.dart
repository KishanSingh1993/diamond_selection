import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'models/diamond.dart';

Future<List<Diamond>> loadDiamonds() async {
  final String response = await rootBundle.loadString('assets/data.json');
  final List<dynamic> data = jsonDecode(response);
  return data.map((json) => Diamond.fromJson(json)).toList();
}
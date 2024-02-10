import 'dart:convert';

import 'package:zillow_guesser/House.dart';
import 'package:http/http.dart' as http;

const _DOMAIN = 'https://shining-battle-holiday.glitch.me/';

const _FETCH_HOUSE_URL = _DOMAIN + "fetchHouse";

Future<House> getRandomHouse() async {
  final response = await http.get(Uri.parse(_FETCH_HOUSE_URL));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    House house = House.fromJson(data);
    return house;
  } else {
    throw Exception('Failed to get a house');
  }
}

import 'dart:convert';

import 'package:http/http.dart';

import '../Modle/world_status_modle.dart';

class StatesServices {
  Future<WorldStatusModle> getApi() async {
    var response = await get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatusModle.fromJson(data);
    } else {
      return throw Exception('Error');
    }
  }

  Future<List<dynamic>> getcountries() async {
    var data;
    var response =
        await get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      return throw Exception('Error');
    }
  }
}

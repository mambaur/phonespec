import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:phone_spec/models/brand_model.dart';
import 'package:http/http.dart' as http;

class BrandRepository {
  final _baseUrl = dotenv.env['API_URL'].toString();

  Future<List<BrandModel>?> getBrands(
      {int page = 1, int limit = 10, String q = ''}) async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl + '/brands?page=$page&limit=$limit&q=$q'));
      // print(response.body);

      if (response.statusCode == 200) {
        Iterable iterable = json.decode(response.body)['data'];
        List<BrandModel> listBrands =
            iterable.map((e) => BrandModel.fromJson(e)).toList();
        return listBrands;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:phone_spec/models/specifications_model.dart';

class SpecificationRepository {
  final _baseUrl = dotenv.env['API_URL'].toString();

  Future<List<SpecificationModel>?> getSpecifications(
      int bannerId, String q, int page, int limit) async {
    try {
      final response = await http.get(Uri.parse(
          _baseUrl + '/androids/$bannerId?q=$q&page=$page&limit=$limit'));
      print(response.body);

      if (response.statusCode == 200) {
        Iterable iterable = json.decode(response.body)['data'];
        List<SpecificationModel> listSpecs =
            iterable.map((e) => SpecificationModel.fromJson(e)).toList();
        return listSpecs;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

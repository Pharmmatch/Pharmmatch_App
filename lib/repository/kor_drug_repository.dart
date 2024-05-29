import 'dart:convert';
import 'package:pharmmatch_app/const/api.dart';
import 'package:http/http.dart' as http;
import 'package:pharmmatch_app/models/drug_info.dart';

class KorDrugRepository {
  static const int numOfRows = 100;

  static Future<List<DrugInfo>> getDrugs() async {
    List<DrugInfo> allDrugs = [];
    int pageNo = 1;

    while (true) {
      final response = await http.get(Uri.parse(
          '$baseUrl?serviceKey=$serviceKey&pageNo=$pageNo&numOfRows=$numOfRows&type=json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData['body'] != null && jsonData['body']['items'] != null) {
          final items = jsonData['body']['items'];

          if (items is List) {
            allDrugs.addAll(items
                .map<DrugInfo>((item) => DrugInfo.fromJson(item))
                .toList());
          } else if (items != null) {
            allDrugs.add(DrugInfo.fromJson(items));
          }

          if (items is List && items.length < numOfRows) {
            break;
          }
        } else {
          break;
        }

        pageNo++;
      } else {
        throw Exception(
            'Failed to load drugs, status code: ${response.statusCode}');
      }
    }

    return allDrugs;
  }
}

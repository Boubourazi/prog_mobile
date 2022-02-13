import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class CsvParser {
  final String url;
  List<List<dynamic>> _parsed = [];

  CsvParser(this.url);

  Map<String, List<Map<String, dynamic>>> get siteByCampus {
    Map<String, List<Map<String, dynamic>>> mapped = {};
    for (List<dynamic> line in _parsed) {
      String key = line[5];
      Map<String, dynamic> lineMapped = {
        "key": line[0],
        "id": line[1],
        "name": line[2],
        "adr": line[3].toString(),
        "postalCode": line[4].toString(),
        "city": key,
        "addr": line[6],
        "addr2": line[7],
        "long": line[8],
        "lat": line[9],
      };
      if (mapped[key] == null) {
        mapped[key] = [lineMapped];
      } else {
        mapped[key]!.add(lineMapped);
      }
    }
    return mapped;
  }

  Future<List<List<dynamic>>> _parse() async {
    return const CsvToListConverter(
      fieldDelimiter: ";",
      textDelimiter: ";;;",
    ).convert(await rootBundle.loadString(url));
  }

  Future<void> initParsed() async {
    _parsed = await _parse();
  }
}

import 'dart:convert';

abstract class BaseParam {
  Map<String, dynamic> toMap();

  Map<String, dynamic> toJson() {
    return addWhiteListNull(removeNulls(toMap()));
  }

  Map<String, dynamic> toJsonEncode() {
    return encodeMapValuesToJson(removeNulls(toMap()));
  }

  Map<String, dynamic> removeNulls(Map<String, dynamic> map) {
    return map..removeWhere((key, value) => value == null);
  }

  Map<String, dynamic> addWhiteListNull(Map<String, dynamic> map) {
    return map.map((key, value) {
      if (value == 'null' || value == -1) {
        return MapEntry(key, null);
      }
      return MapEntry(key, value);
    });
  }

  Map<String, String> encodeMapValuesToJson(Map<String, dynamic> map) {
    final encodedMap = map.map((key, value) {
      if (value is String) return MapEntry(key, value);
      return MapEntry(key, jsonEncode(value));
    });

    return encodedMap;
  }

  Iterable<MapEntry<String, String>> convertArrayToMapEntries(
      String arrayName, List<String> array) {
    return array.asMap().entries.map(
          (entry) {
        int index = entry.key;
        String value = entry.value;
        return MapEntry('$arrayName[$index]', value);
      },
    );
  }
}

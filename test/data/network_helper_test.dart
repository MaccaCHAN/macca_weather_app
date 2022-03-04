import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final client;
  final String url;

  NetworkHelper({required this.url, required this.client});

  Future getData() async {
    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.statusCode);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

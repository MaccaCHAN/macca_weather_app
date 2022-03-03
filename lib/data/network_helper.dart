import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.statusCode);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
